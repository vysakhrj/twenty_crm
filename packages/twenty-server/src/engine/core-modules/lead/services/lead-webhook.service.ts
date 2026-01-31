import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

import { isDefined } from 'twenty-shared/utils';

import { CommonCreateOneQueryRunnerService } from 'src/engine/api/common/common-query-runners/common-create-one-query-runner.service';
import { WorkspaceAuthContext } from 'src/engine/api/common/interfaces/workspace-auth-context.interface';
import { AuthenticatedRequest } from 'src/engine/api/rest/types/authenticated-request';
import { CommonApiContextBuilderService } from 'src/engine/core-modules/record-crud/services/common-api-context-builder.service';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { GlobalWorkspaceOrmManager } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-orm.manager';
import { WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';
import { CreateLeadWithPersonDto } from '../controllers/lead-webhook.controller';

@Injectable()
export class LeadWebhookService {
  private readonly logger = new Logger(LeadWebhookService.name);

  constructor(
    private readonly commonApiContextBuilder: CommonApiContextBuilderService,
    private readonly commonCreateOneQueryRunnerService: CommonCreateOneQueryRunnerService,
    private readonly globalWorkspaceOrmManager: GlobalWorkspaceOrmManager,
    @InjectRepository(WorkspaceEntity)
    private readonly workspaceRepository: Repository<WorkspaceEntity>,
  ) {}

  async createLeadWithPerson(
    body: CreateLeadWithPersonDto,
    request: AuthenticatedRequest,
  ): Promise<{
    lead: any;
    person: any | null;
    taskTarget: any | null;
    origin: any | null;
    debug: any;
  }> {
    const { workspaceId } = request;
    if (!isDefined(workspaceId)) {
      throw new Error('workspaceId is required in the request');
    }

    // Use the request itself as auth context (it contains user/apiKey info)
    const authContext = request as unknown as WorkspaceAuthContext;

    // Step 1: Get assignee using load balancing (fewest tasks, exclude System Admin)
    const { assigneeId, memberCount, currentIndex, allMembers } =
      await this.getAssigneeByLoadBalance(workspaceId, authContext);

    // Step 2: Find or create Person (needed for customerId on lead)
    // Search by email or phone number
    let person: any | null = null;
    const hasPersonData = body.person && (
      body.person.name ||
      body.person.emails?.[0]?.email ||
      body.person.phones?.[0]?.number
    );
    if (hasPersonData) {
      person = await this.findOrCreatePerson(body.person, authContext);
    }

    // Step 3: Find or create Origin record (needed for originsId on lead)
    let origin: any | null = null;
    if (body.origin) {
      origin = await this.findOrCreateOrigin(body.origin, authContext);
    }

    // Step 4: Create Lead/Task with all relations set directly
    // Relations use plural FK names: customersId, originsId, propertiesId
    const lead = await this.createLead(
      {
        title: body.title,
        body: body.body,
        status: body.status || 'New',
        dueDate: body.dueDate,
        assigneeId,
        customerId: person?.id || null,
        originId: origin?.id || null,
        propertyId: body.propertyId || null,
      },
      authContext,
    );

    // Step 5: Create TaskTarget to link Task, Person, Origin, and Property
    let taskTarget: any | null = null;
    if (person || origin || body.propertyId) {
      taskTarget = await this.createTaskTarget(
        lead.id,
        person?.id || null,
        origin?.id || null,
        body.propertyId || null,
        authContext,
      );
    }

    return {
      lead,
      person,
      taskTarget,
      origin,
      debug: {
        roundRobin: {
          totalMembers: memberCount,
          currentIndex,
          selectedAssigneeId: assigneeId,
          allMembers,
        },
        note: 'Using Task object as workaround. Lead object not accessible via API. Customer/Property/Source fields cannot be populated until Lead object is fixed.',
      },
    };
  }

  private async getAssigneeByLoadBalance(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<{
    assigneeId: string | null;
    memberCount: number;
    currentIndex: number;
    allMembers: Array<{ id: string; name: string; taskCount: number }>;
  }> {
    try {
      // Get workspace entity from core schema
      const workspace = await this.workspaceRepository.findOne({
        where: { id: workspaceId },
      });

      if (!workspace) {
        this.logger.warn(`Workspace ${workspaceId} not found`);
        return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: [] };
      }

      // Get all workspace members and their task counts
      const { members, taskCounts } =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const workspaceMemberRepository =
              await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
                workspaceId,
                'workspaceMember',
                { shouldBypassPermissionChecks: true },
              );

            const allMembers = await workspaceMemberRepository.find();

            // Get task repository to count tasks per assignee
            const taskRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'task',
                { shouldBypassPermissionChecks: true },
              );

            // Count tasks for each member
            const counts: Record<string, number> = {};
            for (const member of allMembers) {
              const count = await taskRepository.count({
                where: { assigneeId: member.id },
              });
              counts[member.id] = count;
            }

            return { members: allMembers, taskCounts: counts };
          },
        );

      this.logger.log(
        `[Load Balance] Found ${members?.length || 0} workspace members`,
      );

      if (!Array.isArray(members) || members.length === 0) {
        this.logger.warn(
          `No workspace members found for workspace ${workspaceId}`,
        );
        return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: [] };
      }

      // Filter out System Admin and build member info with task counts
      const eligibleMembers = members
        .filter((member) => {
          const fullName = `${member.name?.firstName || ''} ${member.name?.lastName || ''}`.trim();
          // Exclude "System Admin" or members with no name
          return fullName.toLowerCase() !== 'system admin' && fullName !== '';
        })
        .map((member) => ({
          id: member.id,
          name: `${member.name?.firstName || ''} ${member.name?.lastName || ''}`.trim(),
          taskCount: taskCounts[member.id] || 0,
        }));

      // Log all members for debugging
      this.logger.log(`[Load Balance] Eligible members (excluding System Admin):`);
      eligibleMembers.forEach((member) => {
        this.logger.log(
          `  - ${member.name}: ${member.taskCount} tasks`,
        );
      });

      if (eligibleMembers.length === 0) {
        this.logger.warn(
          `No eligible members found (all are System Admin or unnamed)`,
        );
        return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: eligibleMembers };
      }

      // Find member with fewest tasks (load balancing)
      const sortedMembers = [...eligibleMembers].sort(
        (a, b) => a.taskCount - b.taskCount,
      );
      const selectedMember = sortedMembers[0];

      this.logger.log(
        `[Load Balance] Selected ${selectedMember.name} (${selectedMember.taskCount} tasks - lowest)`,
      );

      return {
        assigneeId: selectedMember.id,
        memberCount: eligibleMembers.length,
        currentIndex: eligibleMembers.findIndex((m) => m.id === selectedMember.id),
        allMembers: eligibleMembers,
      };
    } catch (error) {
      this.logger.error('Failed to get assignee via load balance', error);
      return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: [] };
    }
  }

  private async findOrCreatePerson(
    personData: CreateLeadWithPersonDto['person'],
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    const primaryEmail = personData?.emails?.[0]?.email;
    const primaryPhone = personData?.phones?.[0]?.number;

    // Try to find existing person by email first
    if (primaryEmail) {
      const existingPerson = await this.findPersonByEmail(primaryEmail, authContext);
      if (existingPerson) {
        this.logger.log(`[FindOrCreatePerson] Found existing person by email: ${primaryEmail}, id: ${existingPerson.id}`);
        return existingPerson;
      }
    }

    // Try to find existing person by phone number
    if (primaryPhone) {
      const existingPerson = await this.findPersonByPhone(primaryPhone, authContext);
      if (existingPerson) {
        this.logger.log(`[FindOrCreatePerson] Found existing person by phone: ${primaryPhone}, id: ${existingPerson.id}`);
        return existingPerson;
      }
    }

    // Person not found, create a new one
    this.logger.log(`[FindOrCreatePerson] Creating new person with email: ${primaryEmail || 'none'}, phone: ${primaryPhone || 'none'}`);

    const { queryRunnerContext, selectedFields } =
      await this.commonApiContextBuilder.build({
        authContext,
        objectName: 'person',
      });

    // Build person payload using standard Person fields
    const personPayload: any = {};

    if (personData?.name) {
      personPayload.name = {
        firstName: personData.name.firstName || '',
        lastName: personData.name.lastName || '',
      };
    }

    if (personData?.emails && personData.emails.length > 0) {
      // Standard person emails format: { primaryEmail, additionalEmails }
      personPayload.emails = {
        primaryEmail: personData.emails[0].email,
        additionalEmails: personData.emails.slice(1).map((e) => e.email),
      };
    }

    if (personData?.phones && personData.phones.length > 0) {
      // Standard person phones format: { primaryPhoneNumber, primaryPhoneCountryCode, additionalPhones }
      personPayload.phones = {
        primaryPhoneNumber: personData.phones[0].number,
        primaryPhoneCountryCode: '',
        additionalPhones: personData.phones
          .slice(1)
          .map((p) => ({ number: p.number, countryCode: '' })),
      };
    }

    if (personData?.jobTitle) {
      personPayload.jobTitle = personData.jobTitle;
    }

    if (personData?.city) {
      personPayload.city = personData.city;
    }

    const createdPerson = await this.commonCreateOneQueryRunnerService.execute(
      {
        data: personPayload,
        selectedFields,
      },
      queryRunnerContext,
    );

    this.logger.log(`[FindOrCreatePerson] Created new person: ${createdPerson.id}`);

    return createdPerson;
  }

  private async findPersonByEmail(
    email: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      const existingPerson =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const personRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'person',
                { shouldBypassPermissionChecks: true },
              );

            // Search for person with matching primary email
            // The emails field is a composite type with primaryEmail
            const persons = await personRepository.find();

            // Find person with matching email (check primaryEmail in the emails composite field)
            const found = persons.find((person: any) => {
              const personEmails = person.emails;
              if (!personEmails) return false;

              // Check primaryEmail
              if (personEmails.primaryEmail?.toLowerCase() === email.toLowerCase()) {
                return true;
              }

              // Check additionalEmails
              if (Array.isArray(personEmails.additionalEmails)) {
                return personEmails.additionalEmails.some(
                  (e: string) => e.toLowerCase() === email.toLowerCase(),
                );
              }

              return false;
            });

            return found || null;
          },
        );

      return existingPerson;
    } catch (error: any) {
      this.logger.error(`[FindPersonByEmail] Failed: ${error?.message || error}`);
      return null;
    }
  }

  private async findPersonByPhone(
    phone: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      // Normalize phone number (remove spaces, dashes, etc.)
      const normalizedPhone = phone.replace(/[\s\-\(\)]/g, '');

      const existingPerson =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const personRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'person',
                { shouldBypassPermissionChecks: true },
              );

            const persons = await personRepository.find();

            // Find person with matching phone number
            const found = persons.find((person: any) => {
              const personPhones = person.phones;
              if (!personPhones) return false;

              // Normalize and check primaryPhoneNumber
              const primaryPhone = personPhones.primaryPhoneNumber?.replace(/[\s\-\(\)]/g, '');
              if (primaryPhone && primaryPhone.includes(normalizedPhone)) {
                return true;
              }
              if (primaryPhone && normalizedPhone.includes(primaryPhone)) {
                return true;
              }

              // Check additionalPhones
              if (Array.isArray(personPhones.additionalPhones)) {
                return personPhones.additionalPhones.some((p: any) => {
                  const num = (p.number || p)?.replace(/[\s\-\(\)]/g, '');
                  return num && (num.includes(normalizedPhone) || normalizedPhone.includes(num));
                });
              }

              return false;
            });

            return found || null;
          },
        );

      return existingPerson;
    } catch (error: any) {
      this.logger.error(`[FindPersonByPhone] Failed: ${error?.message || error}`);
      return null;
    }
  }

  private async createTaskTarget(
    taskId: string,
    personId: string | null,
    originId: string | null,
    propertyId: string | null,
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    const { queryRunnerContext, selectedFields } =
      await this.commonApiContextBuilder.build({
        authContext,
        objectName: 'taskTarget',
      });

    const taskTargetPayload: any = {
      taskId,
    };

    if (personId) {
      taskTargetPayload.personId = personId;
    }

    if (originId) {
      taskTargetPayload.originId = originId;
    }

    if (propertyId) {
      taskTargetPayload.propertyId = propertyId;
    }

    const createdTaskTarget =
      await this.commonCreateOneQueryRunnerService.execute(
        {
          data: taskTargetPayload,
          selectedFields,
        },
        queryRunnerContext,
      );

    this.logger.log(
      `Created TaskTarget linking task ${taskId} to person ${personId}, origin ${originId}, property ${propertyId}`,
    );

    return createdTaskTarget;
  }

  private async linkOriginToTask(
    taskId: string,
    originId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<void> {
    try {
      this.logger.log(`[LinkOriginToTask] Linking origin ${originId} to task ${taskId}`);

      const workspaceId = authContext.workspace.id;

      // Update the Origin's leadsId to point to the Task
      await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
        authContext,
        async () => {
          const originRepository =
            await this.globalWorkspaceOrmManager.getRepository(
              workspaceId,
              'origin',
              { shouldBypassPermissionChecks: true },
            );

          await originRepository.update(
            { id: originId },
            { leadsId: taskId },
          );

          this.logger.log(`[LinkOriginToTask] Updated origin ${originId} with leadsId: ${taskId}`);
        },
      );
    } catch (error: any) {
      this.logger.error(`[LinkOriginToTask] Failed: ${error?.message || error}`);
    }
  }

  private async findOrCreateOrigin(
    originValue: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    try {
      this.logger.log(`[FindOrCreateOrigin] Looking for origin: ${originValue}`);

      const workspaceId = authContext.workspace.id;

      // Try to find existing origin by name using direct repository access
      const existingOrigin =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const originRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'origin',
                { shouldBypassPermissionChecks: true },
              );

            const found = await originRepository.findOne({
              where: { name: originValue },
            });

            return found;
          },
        );

      if (existingOrigin) {
        this.logger.log(`[FindOrCreateOrigin] Found existing origin: ${JSON.stringify(existingOrigin)}`);
        return existingOrigin;
      }

      // Origin not found, create a new one
      this.logger.log(`[FindOrCreateOrigin] Creating new origin: ${originValue}`);

      const { queryRunnerContext, selectedFields } =
        await this.commonApiContextBuilder.build({
          authContext,
          objectName: 'origin',
        });

      const originPayload: any = {
        name: originValue,
      };

      const createdOrigin =
        await this.commonCreateOneQueryRunnerService.execute(
          {
            data: originPayload,
            selectedFields,
          },
          queryRunnerContext,
        );

      this.logger.log(`[FindOrCreateOrigin] Created new origin: ${JSON.stringify(createdOrigin)}`);

      return createdOrigin;
    } catch (error: any) {
      this.logger.error(`[FindOrCreateOrigin] Failed: ${error?.message || error}`);
      this.logger.error(`[FindOrCreateOrigin] Stack: ${error?.stack}`);
      return null;
    }
  }

  private async createLead(
    leadData: {
      title: string;
      body?: string;
      status: string;
      dueDate?: string;
      assigneeId?: string | null;
      customerId?: string | null;
      originId?: string | null;
      propertyId?: string | null;
    },
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    // Using 'task' object - the Leads object has relations configured on Task
    const { queryRunnerContext, selectedFields } =
      await this.commonApiContextBuilder.build({
        authContext,
        objectName: 'task',
      });

    // Build task payload
    const taskPayload: any = {
      title: leadData.title,
    };

    // Task uses bodyV2 (Rich Text V2) not body
    if (leadData.body) {
      taskPayload.bodyV2 = {
        blocknote: leadData.body,
        markdown: leadData.body,
      };
    }

    // Task status uses: TODO, IN_PROGRESS, DONE (not custom statuses)
    if (leadData.status) {
      const statusMap: Record<string, string> = {
        New: 'TODO',
        'In Progress': 'IN_PROGRESS',
        Done: 'DONE',
        Completed: 'DONE',
      };
      taskPayload.status = statusMap[leadData.status] || 'TODO';
    }

    if (leadData.dueDate) {
      taskPayload.dueAt = leadData.dueDate;
    }

    // Task uses assignee relation
    if (leadData.assigneeId) {
      taskPayload.assigneeId = leadData.assigneeId;
    }

    // Link to customer (person)
    if (leadData.customerId) {
      taskPayload.customerId = leadData.customerId;
    }

    // Origins relation -> originsId (or try origin/originId)
    if (leadData.originId) {
      taskPayload.originId = leadData.originId;
    }

    if (leadData.propertyId) {
      taskPayload.propertyId = leadData.propertyId;
    }

    const createdTask = await this.commonCreateOneQueryRunnerService.execute(
      {
        data: taskPayload,
        selectedFields,
      },
      queryRunnerContext,
    );

    this.logger.log(`[CreateLead] Created: ${JSON.stringify(createdTask)}`);

    return createdTask;
  }
}
