import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  Logger,
  NotFoundException,
  ServiceUnavailableException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';

import { isDefined } from 'twenty-shared/utils';

import { CommonCreateOneQueryRunnerService } from 'src/engine/api/common/common-query-runners/common-create-one-query-runner.service';
import { WorkspaceAuthContext } from 'src/engine/api/common/interfaces/workspace-auth-context.interface';
import { AuthenticatedRequest } from 'src/engine/api/rest/types/authenticated-request';
import { CommonApiContextBuilderService } from 'src/engine/core-modules/record-crud/services/common-api-context-builder.service';
import { UserWorkspaceEntity } from 'src/engine/core-modules/user-workspace/user-workspace.entity';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { ADMIN_ROLE } from 'src/engine/metadata-modules/role/constants/admin-role';
import { RoleEntity } from 'src/engine/metadata-modules/role/role.entity';
import { UserRoleService } from 'src/engine/metadata-modules/user-role/user-role.service';
import { GlobalWorkspaceOrmManager } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-orm.manager';
import { WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';
import { CreateLeadWithPersonDto } from '../controllers/lead-webhook.controller';

type SalesAvailabilityUpdateInput = {
  availabilityStartTime?: string;
  availabilityEndTime?: string;
  availableDays?: string[];
};

type SalesLeaveUpdateInput = {
  leaveDate?: string;
  leaveStartDate?: string;
  leaveEndDate?: string;
  clearLeave?: boolean;
};

type SalesAvailabilityPermission = {
  canManageSalesAvailability: boolean;
  isAdminLike: boolean;
};

type SalesLeavePermission = {
  canManageOthersLeave: boolean;
  isAdminLike: boolean;
};

const WEEKDAY_KEYS = [
  'MONDAY',
  'TUESDAY',
  'WEDNESDAY',
  'THURSDAY',
  'FRIDAY',
  'SATURDAY',
  'SUNDAY',
] as const;

type WeekdayKey = (typeof WEEKDAY_KEYS)[number];

const TIME_24H_REGEX = /^([01]\d|2[0-3]):([0-5]\d)$/;

@Injectable()
export class LeadWebhookService {
  private readonly logger = new Logger(LeadWebhookService.name);

  constructor(
    private readonly commonApiContextBuilder: CommonApiContextBuilderService,
    private readonly commonCreateOneQueryRunnerService: CommonCreateOneQueryRunnerService,
    private readonly globalWorkspaceOrmManager: GlobalWorkspaceOrmManager,
    private readonly userRoleService: UserRoleService,
    @InjectRepository(WorkspaceEntity)
    private readonly workspaceRepository: Repository<WorkspaceEntity>,
    @InjectRepository(RoleEntity)
    private readonly roleRepository: Repository<RoleEntity>,
    @InjectRepository(UserWorkspaceEntity)
    private readonly userWorkspaceRepository: Repository<UserWorkspaceEntity>,
  ) {}

  async createLeadWithPerson(
    body: CreateLeadWithPersonDto,
    request: AuthenticatedRequest,
  ): Promise<{
    lead: any;
    person: any | null;
    taskTarget: any | null;
    origin: any | null;
    property: any | null;
    debug: any;
  }> {
    const { workspaceId } = request;
    if (!isDefined(workspaceId)) {
      throw new Error('workspaceId is required in the request');
    }

    // Use the request itself as auth context (it contains user/apiKey info)
    const authContext = request as unknown as WorkspaceAuthContext;

    // Step 1: Get assignee by round-robin among active members (no load balancing)
    const { assigneeId, memberCount, currentIndex, allMembers } =
      await this.getAssigneeByLoadBalance(workspaceId, authContext);

    // Step 2: Find or create Customer (by email or phone; reuse existing if match)
    let customer: any | null = null;
    const hasPersonData = body.person && (
      body.person.name ||
      body.person.emails?.[0]?.email ||
      body.person.phones?.[0]?.number
    );
    if (hasPersonData) {
      customer = await this.findOrCreateCustomer(body.person, authContext);
    }

    // Step 3: Find or create Origin record by name (needed for originId on lead)
    let origin: any | null = null;
    if (body.origin) {
      origin = await this.findOrCreateOrigin(body.origin, authContext);
    }

    // Step 3b: Resolve property by propertyName or use propertyId
    let property: any | null = null;
    let resolvedPropertyId: string | null = null;
    if (body.propertyId) {
      resolvedPropertyId = body.propertyId;
      property = await this.findPropertyById(body.propertyId, authContext);
    } else if (body.propertyName) {
      property = await this.findPropertyByName(body.propertyName, authContext);
      resolvedPropertyId = property?.id ?? null;
    }

    // Step 4: Compute lead title (auto-increment SFS-N)
    const title = await this.generateNextLeadTitle(authContext);

    // Step 4b: Compute due date (fallback = today + 2 days if not provided)
    const dueDate =
      body.dueDate ??
      new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toISOString();

    const buildingType = Array.isArray(body.buildingType)
      ? body.buildingType
      : isDefined(body.buildingType)
        ? [body.buildingType]
        : undefined;

    // Step 5: Create Lead with assignee, customer, origin, property, and custom fields
    const lead = await this.createLead(
      {
        title,
        body: body.body,
        dueDate,
        convenientTime: body.convenientTime ?? undefined,
        buildingType,
        assigneeId,
        customerId: customer?.id || null,
        originId: origin?.id || null,
        propertyId: resolvedPropertyId,
      },
      authContext,
    );

    return {
      lead,
      person: customer,
      taskTarget: null,
      origin,
      property,
      debug: {
        roundRobin: {
          totalMembers: memberCount,
          currentIndex,
          selectedAssigneeId: assigneeId,
          allMembers,
        },
      },
    };
  }

  async updateSalesAvailability(
    workspaceId: string,
    workspaceMemberId: string,
    input: SalesAvailabilityUpdateInput,
    authContext: WorkspaceAuthContext,
  ) {
    const salesAvailabilityPermission = await this.assertManagerOrSuperAdmin(
      workspaceId,
      authContext,
    );

    if (!salesAvailabilityPermission.isAdminLike) {
      const adminWorkspaceMemberIds = await this.getAdminWorkspaceMemberIds(
        workspaceId,
        authContext,
      );

      if (adminWorkspaceMemberIds.includes(workspaceMemberId)) {
        throw new ForbiddenException(
          'Managers cannot update sales availability for admin members',
        );
      }
    }

    const salesMemberIds = await this.getSalesWorkspaceMemberIds(
      workspaceId,
      authContext,
    );

    if (!salesMemberIds.includes(workspaceMemberId)) {
      throw new NotFoundException(
        `Sales workspace member ${workspaceMemberId} not found`,
      );
    }

    const updates: Partial<WorkspaceMemberWorkspaceEntity> = {};

    if (isDefined(input.availabilityStartTime)) {
      if (!this.isValidAvailabilityTime(input.availabilityStartTime, false)) {
        throw new BadRequestException(
          'availabilityStartTime must use HH:mm format between 00:00 and 23:59',
        );
      }

      updates.availabilityStartTime = input.availabilityStartTime;
    }

    if (isDefined(input.availabilityEndTime)) {
      if (!this.isValidAvailabilityTime(input.availabilityEndTime, true)) {
        throw new BadRequestException(
          'availabilityEndTime must use HH:mm format between 00:00 and 24:00',
        );
      }

      updates.availabilityEndTime = input.availabilityEndTime;
    }

    if (isDefined(input.availableDays)) {
      const normalizedDays = input.availableDays.map((day) =>
        String(day).toUpperCase(),
      );

      const hasInvalidDay = normalizedDays.some(
        (day) => !WEEKDAY_KEYS.includes(day as WeekdayKey),
      );

      if (normalizedDays.length === 0 || hasInvalidDay) {
        throw new BadRequestException(
          `availableDays must contain valid weekdays: ${WEEKDAY_KEYS.join(', ')}`,
        );
      }

      updates.availableDays = normalizedDays;
    }

    if (!Object.keys(updates).length) {
      throw new BadRequestException(
        'Provide at least one field to update (availabilityStartTime, availabilityEndTime or availableDays)',
      );
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const existingMember = await workspaceMemberRepository.findOne({
          where: { id: workspaceMemberId },
        });

        if (!existingMember) {
          throw new NotFoundException(
            `Workspace member ${workspaceMemberId} not found`,
          );
        }

        const startTime =
          updates.availabilityStartTime ??
          existingMember.availabilityStartTime ??
          '00:00';
        const endTime =
          updates.availabilityEndTime ??
          existingMember.availabilityEndTime ??
          this.getEndTimeFromAvailabilityHours(existingMember.availabilityHours);

        const startMinutes = this.parseAvailabilityTimeToMinutes(startTime, false);
        const endMinutes = this.parseAvailabilityTimeToMinutes(endTime, true);

        if (startMinutes >= endMinutes) {
          throw new BadRequestException(
            'availabilityStartTime must be earlier than availabilityEndTime',
          );
        }

        try {
          await workspaceMemberRepository.update({ id: workspaceMemberId }, updates);
        } catch (error) {
          const missingFields = this.getMissingWorkspaceMemberMetadataFields(error);

          if (missingFields.size === 0) {
            throw error;
          }

          const fallbackUpdates: Partial<WorkspaceMemberWorkspaceEntity> = {
            ...updates,
          };

          for (const missingField of missingFields) {
            delete fallbackUpdates[missingField];
          }

          const isTimeFieldMissing =
            missingFields.has('availabilityStartTime') ||
            missingFields.has('availabilityEndTime');

          if (isTimeFieldMissing) {
            if (startTime !== '00:00') {
              throw new BadRequestException(
                'This workspace does not support custom start time yet. Use 00:00 as start time.',
              );
            }

            if (endMinutes % 60 !== 0) {
              throw new BadRequestException(
                'End time must be on whole-hour boundaries for this workspace (e.g. 18:00).',
              );
            }

            fallbackUpdates.availabilityHours = endMinutes / 60;
            delete fallbackUpdates.availabilityStartTime;
            delete fallbackUpdates.availabilityEndTime;
          }

          if (Object.keys(fallbackUpdates).length > 0) {
            try {
              await workspaceMemberRepository.update(
                { id: workspaceMemberId },
                fallbackUpdates,
              );
            } catch (secondError) {
              const secondMissingFields =
                this.getMissingWorkspaceMemberMetadataFields(secondError);

              if (secondMissingFields.size === 0) {
                throw secondError;
              }

              for (const missingField of secondMissingFields) {
                delete fallbackUpdates[missingField];
              }

              if (Object.keys(fallbackUpdates).length > 0) {
                await workspaceMemberRepository.update(
                  { id: workspaceMemberId },
                  fallbackUpdates,
                );
              }
            }
          }
        }

        const updatedMember = await workspaceMemberRepository.findOne({
          where: { id: workspaceMemberId },
        });

        if (!updatedMember) {
          throw new NotFoundException(
            `Workspace member ${workspaceMemberId} not found`,
          );
        }

        return {
          workspaceMemberId: updatedMember.id,
          availabilityStartTime: this.getAvailabilityStartTime(updatedMember),
          availabilityEndTime: this.getAvailabilityEndTime(updatedMember),
          availableDays: this.getAvailableDays(updatedMember),
          status: this.computeAvailabilityStatus(updatedMember),
        };
      },
    );
  }

  async updateSalesLeave(
    workspaceId: string,
    workspaceMemberId: string,
    input: SalesLeaveUpdateInput,
    authContext: WorkspaceAuthContext,
  ) {
    const salesLeavePermission = await this.getSalesLeavePermission(
      workspaceId,
      authContext,
    );

    if (!salesLeavePermission.canManageOthersLeave) {
      if (workspaceMemberId !== authContext.workspaceMemberId) {
        throw new ForbiddenException(
          'Sales users can only update their own leave',
        );
      }
    } else if (!salesLeavePermission.isAdminLike) {
      const adminWorkspaceMemberIds = await this.getAdminWorkspaceMemberIds(
        workspaceId,
        authContext,
      );

      if (adminWorkspaceMemberIds.includes(workspaceMemberId)) {
        throw new ForbiddenException(
          'Managers cannot update sales leave for admin members',
        );
      }
    }

    const salesMemberIds = await this.getSalesWorkspaceMemberIds(
      workspaceId,
      authContext,
    );

    if (!salesMemberIds.includes(workspaceMemberId)) {
      throw new NotFoundException(
        `Sales workspace member ${workspaceMemberId} not found`,
      );
    }

    let leaveStartDate: string | null = null;
    let leaveEndDate: string | null = null;

    if (!input.clearLeave) {
      if (input.leaveDate) {
        const date = new Date(input.leaveDate);

        if (Number.isNaN(date.getTime())) {
          throw new BadRequestException(
            'leaveDate must be a valid ISO date string',
          );
        }

        const leaveStart = new Date(date);
        leaveStart.setUTCHours(0, 0, 0, 0);
        const leaveEnd = new Date(date);
        leaveEnd.setUTCHours(23, 59, 59, 999);

        leaveStartDate = leaveStart.toISOString();
        leaveEndDate = leaveEnd.toISOString();
      } else {
        if (!input.leaveStartDate || !input.leaveEndDate) {
          throw new BadRequestException(
            'Provide leaveDate or both leaveStartDate and leaveEndDate',
          );
        }

        const leaveStart = new Date(input.leaveStartDate);
        const leaveEnd = new Date(input.leaveEndDate);

        if (
          Number.isNaN(leaveStart.getTime()) ||
          Number.isNaN(leaveEnd.getTime())
        ) {
          throw new BadRequestException(
            'leaveStartDate and leaveEndDate must be valid ISO date strings',
          );
        }

        if (leaveEnd < leaveStart) {
          throw new BadRequestException(
            'leaveEndDate must be greater than or equal to leaveStartDate',
          );
        }

        leaveStartDate = leaveStart.toISOString();
        leaveEndDate = leaveEnd.toISOString();
      }
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        await workspaceMemberRepository.update(
          { id: workspaceMemberId },
          { leaveStartDate, leaveEndDate },
        );

        const updatedMember = await workspaceMemberRepository.findOne({
          where: { id: workspaceMemberId },
        });

        if (!updatedMember) {
          throw new NotFoundException(
            `Workspace member ${workspaceMemberId} not found`,
          );
        }

        return {
          workspaceMemberId: updatedMember.id,
          leaveStartDate: updatedMember.leaveStartDate,
          leaveEndDate: updatedMember.leaveEndDate,
          status: this.computeAvailabilityStatus(updatedMember),
        };
      },
    );
  }

  async getSelfSalesUserStatus(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ) {
    const workspaceMemberId = authContext.workspaceMemberId;

    if (!workspaceMemberId) {
      throw new ForbiddenException(
        'Only workspace members can view their sales leave status',
      );
    }

    await this.getSalesLeavePermission(workspaceId, authContext);

    const salesMemberIds = await this.getSalesWorkspaceMemberIds(
      workspaceId,
      authContext,
    );

    if (!salesMemberIds.includes(workspaceMemberId)) {
      throw new NotFoundException(
        `Sales workspace member ${workspaceMemberId} not found`,
      );
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const member = await workspaceMemberRepository.findOne({
          where: { id: workspaceMemberId },
        });

        if (!member) {
          throw new NotFoundException(
            `Workspace member ${workspaceMemberId} not found`,
          );
        }

        return {
          workspaceMemberId: member.id,
          name: `${member.name?.firstName ?? ''} ${member.name?.lastName ?? ''}`.trim(),
          availabilityStartTime: this.getAvailabilityStartTime(member),
          availabilityEndTime: this.getAvailabilityEndTime(member),
          availableDays: this.getAvailableDays(member),
          leaveStartDate: member.leaveStartDate ?? null,
          leaveEndDate: member.leaveEndDate ?? null,
          status: this.computeAvailabilityStatus(member),
        };
      },
    );
  }

  async getSalesUsersStatus(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ) {
    await this.assertManagerOrSuperAdmin(workspaceId, authContext);

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const salesMemberIds = await this.getSalesWorkspaceMemberIds(
          workspaceId,
          authContext,
        );

        if (salesMemberIds.length === 0) {
          return [];
        }

        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const members = await workspaceMemberRepository.find({
          where: { id: In(salesMemberIds) },
        });

        return members.map((member) => ({
          workspaceMemberId: member.id,
          name: `${member.name?.firstName ?? ''} ${member.name?.lastName ?? ''}`.trim(),
          availabilityStartTime: this.getAvailabilityStartTime(member),
          availabilityEndTime: this.getAvailabilityEndTime(member),
          availableDays: this.getAvailableDays(member),
          leaveStartDate: member.leaveStartDate ?? null,
          leaveEndDate: member.leaveEndDate ?? null,
          status: this.computeAvailabilityStatus(member),
        }));
      },
    );
  }

  private async getSalesLeavePermission(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<SalesLeavePermission> {
    const userWorkspaceId = authContext.userWorkspaceId;

    if (!userWorkspaceId) {
      throw new ForbiddenException('Only workspace users can perform this action');
    }

    const rolesByUserWorkspace =
      await this.userRoleService.getRolesByUserWorkspaces({
        userWorkspaceIds: [userWorkspaceId],
        workspaceId,
      });

    const currentRoles = rolesByUserWorkspace.get(userWorkspaceId) ?? [];

    if (currentRoles.length === 0) {
      throw new ForbiddenException('Current role could not be resolved');
    }

    const isAdminLike = currentRoles.some((role) => this.isAdminLikeRole(role));
    const hasManagerRole = currentRoles.some((role) =>
      role.label.toLowerCase().includes('manager'),
    );
    const hasSalesRole = currentRoles.some((role) => this.isSalesRole(role));

    if (isAdminLike || hasManagerRole) {
      return {
        canManageOthersLeave: true,
        isAdminLike,
      };
    }

    if (hasSalesRole) {
      return {
        canManageOthersLeave: false,
        isAdminLike: false,
      };
    }

    throw new ForbiddenException(
      'Only sales, manager, or super admin roles can manage leave',
    );
  }

  private isSalesRole(role: Pick<RoleEntity, 'label'>) {
    return role.label.toLowerCase().includes('sales');
  }

  private async assertManagerOrSuperAdmin(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<SalesAvailabilityPermission> {
    const userWorkspaceId = authContext.userWorkspaceId;

    if (!userWorkspaceId) {
      throw new ForbiddenException('Only workspace users can perform this action');
    }

    const rolesByUserWorkspace =
      await this.userRoleService.getRolesByUserWorkspaces({
        userWorkspaceIds: [userWorkspaceId],
        workspaceId,
      });

    const currentRoles = rolesByUserWorkspace.get(userWorkspaceId) ?? [];

    if (currentRoles.length === 0) {
      throw new ForbiddenException('Current role could not be resolved');
    }

    const isAdminLike = currentRoles.some((role) => this.isAdminLikeRole(role));
    const hasManagerRole = currentRoles.some((role) =>
      role.label.toLowerCase().includes('manager'),
    );
    const isPrivileged = isAdminLike || hasManagerRole;

    if (!isPrivileged) {
      throw new ForbiddenException(
        'Only manager or super admin roles can manage sales availability',
      );
    }

    return {
      canManageSalesAvailability: true,
      isAdminLike,
    };
  }

  private isAdminLikeRole(role: Pick<RoleEntity, 'label' | 'standardId' | 'canUpdateAllSettings'>) {
    const normalizedLabel = role.label.toLowerCase();

    return (
      role.standardId === ADMIN_ROLE.standardId ||
      role.canUpdateAllSettings ||
      normalizedLabel.includes('admin') ||
      normalizedLabel.includes('superadmin') ||
      normalizedLabel.includes('super admin')
    );
  }

  private async getSalesWorkspaceMemberIds(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<string[]> {
    const salesRoles = await this.roleRepository.find({
      where: {
        workspaceId,
      },
    });

    const salesRoleIds = salesRoles
      .filter((role) => role.label.toLowerCase().includes('sales'))
      .map((role) => role.id);

    if (salesRoleIds.length === 0) {
      return [];
    }

    const userWorkspaceIdsByRole = await Promise.all(
      salesRoleIds.map((roleId) =>
        this.userRoleService.getUserWorkspaceIdsAssignedToRole(roleId, workspaceId),
      ),
    );

    const userWorkspaceIds = Array.from(new Set(userWorkspaceIdsByRole.flat()));

    if (userWorkspaceIds.length === 0) {
      return [];
    }

    const userWorkspaces = await this.userWorkspaceRepository.find({
      where: { id: In(userWorkspaceIds) },
    });

    const userIds = userWorkspaces.map((userWorkspace) => userWorkspace.userId);

    if (userIds.length === 0) {
      return [];
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const members = await workspaceMemberRepository.find({
          where: {
            userId: In(userIds),
          },
        });

        return members.map((member) => member.id);
      },
    );
  }

  private async getManagerWorkspaceMemberIds(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<string[]> {
    const roles = await this.roleRepository.find({
      where: { workspaceId },
    });

    const managerRoleIds = roles
      .filter((role) => {
        const normalizedLabel = role.label.toLowerCase();
        const hasManagerOrAdminLabel =
          normalizedLabel.includes('manager') ||
          normalizedLabel.includes('admin') ||
          normalizedLabel.includes('superadmin') ||
          normalizedLabel.includes('super admin');

        return (
          role.standardId === ADMIN_ROLE.standardId ||
          role.canUpdateAllSettings ||
          hasManagerOrAdminLabel
        );
      })
      .map((role) => role.id);

    if (managerRoleIds.length === 0) {
      return [];
    }

    const userWorkspaceIdsByRole = await Promise.all(
      managerRoleIds.map((roleId) =>
        this.userRoleService.getUserWorkspaceIdsAssignedToRole(roleId, workspaceId),
      ),
    );

    const userWorkspaceIds = Array.from(new Set(userWorkspaceIdsByRole.flat()));

    if (userWorkspaceIds.length === 0) {
      return [];
    }

    const userWorkspaces = await this.userWorkspaceRepository.find({
      where: { id: In(userWorkspaceIds) },
    });

    const userIds = userWorkspaces.map((userWorkspace) => userWorkspace.userId);

    if (userIds.length === 0) {
      return [];
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const members = await workspaceMemberRepository.find({
          where: {
            userId: In(userIds),
          },
        });

        return members.map((member) => member.id);
      },
    );
  }

  private async getAdminWorkspaceMemberIds(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<string[]> {
    const roles = await this.roleRepository.find({
      where: { workspaceId },
    });

    const adminRoleIds = roles
      .filter((role) => this.isAdminLikeRole(role))
      .map((role) => role.id);

    if (adminRoleIds.length === 0) {
      return [];
    }

    const userWorkspaceIdsByRole = await Promise.all(
      adminRoleIds.map((roleId) =>
        this.userRoleService.getUserWorkspaceIdsAssignedToRole(roleId, workspaceId),
      ),
    );

    const userWorkspaceIds = Array.from(new Set(userWorkspaceIdsByRole.flat()));

    if (userWorkspaceIds.length === 0) {
      return [];
    }

    const userWorkspaces = await this.userWorkspaceRepository.find({
      where: { id: In(userWorkspaceIds) },
    });

    const userIds = userWorkspaces.map((userWorkspace) => userWorkspace.userId);

    if (userIds.length === 0) {
      return [];
    }

    return this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        const members = await workspaceMemberRepository.find({
          where: {
            userId: In(userIds),
          },
        });

        return members.map((member) => member.id);
      },
    );
  }

  private getAvailabilityStartTime(
    member: WorkspaceMemberWorkspaceEntity,
  ): string {
    return member.availabilityStartTime ?? '00:00';
  }

  private getAvailabilityEndTime(member: WorkspaceMemberWorkspaceEntity): string {
    return (
      member.availabilityEndTime ??
      this.getEndTimeFromAvailabilityHours(member.availabilityHours)
    );
  }

  private getEndTimeFromAvailabilityHours(availabilityHours: number | null | undefined) {
    const hours = Number.isFinite(availabilityHours) ? Number(availabilityHours) : 24;
    const boundedHours = Math.min(24, Math.max(1, Math.round(hours)));

    return `${String(boundedHours).padStart(2, '0')}:00`;
  }

  private getAvailableDays(member: WorkspaceMemberWorkspaceEntity): string[] {
    return member.availableDays?.length
      ? member.availableDays
      : [...WEEKDAY_KEYS];
  }

  private computeAvailabilityStatus(member: WorkspaceMemberWorkspaceEntity): {
    status: 'ACTIVE' | 'INACTIVE';
    reason: 'AVAILABLE' | 'LEAVE' | 'UNAVAILABLE_DAY' | 'UNAVAILABLE_HOURS';
  } {
    const now = new Date();
    const weekday = this.getWeekdayFromDate(now);

    const availableDays = this.getAvailableDays(member);
    const isAvailableToday = availableDays.includes(weekday);

    const leaveStartTimestamp = member.leaveStartDate
      ? new Date(member.leaveStartDate).getTime()
      : Number.NaN;
    const leaveEndTimestamp = member.leaveEndDate
      ? new Date(member.leaveEndDate).getTime()
      : Number.NaN;
    const hasLeaveWindow =
      !Number.isNaN(leaveStartTimestamp) && !Number.isNaN(leaveEndTimestamp);
    const isOnLeave =
      hasLeaveWindow &&
      now.getTime() >= leaveStartTimestamp &&
      now.getTime() <= leaveEndTimestamp;

    if (isOnLeave) {
      return { status: 'INACTIVE', reason: 'LEAVE' };
    }

    if (!isAvailableToday) {
      return { status: 'INACTIVE', reason: 'UNAVAILABLE_DAY' };
    }

    const availabilityStartTime = this.getAvailabilityStartTime(member);
    const availabilityEndTime = this.getAvailabilityEndTime(member);
    const startMinutes = this.parseAvailabilityTimeToMinutes(
      availabilityStartTime,
      false,
    );
    const endMinutes = this.parseAvailabilityTimeToMinutes(
      availabilityEndTime,
      true,
    );
    const currentMinutes = now.getUTCHours() * 60 + now.getUTCMinutes();
    const isWithinTimeWindow =
      currentMinutes >= startMinutes && currentMinutes < endMinutes;

    if (!isWithinTimeWindow) {
      return { status: 'INACTIVE', reason: 'UNAVAILABLE_HOURS' };
    }

    return { status: 'ACTIVE', reason: 'AVAILABLE' };
  }

  private isValidAvailabilityTime(value: string, allow24HourBoundary: boolean) {
    if (allow24HourBoundary && value === '24:00') {
      return true;
    }

    return TIME_24H_REGEX.test(value);
  }

  private parseAvailabilityTimeToMinutes(
    value: string,
    allow24HourBoundary: boolean,
  ): number {
    if (allow24HourBoundary && value === '24:00') {
      return 24 * 60;
    }

    if (!TIME_24H_REGEX.test(value)) {
      return allow24HourBoundary ? 24 * 60 : 0;
    }

    const [hours, minutes] = value.split(':').map(Number);

    return hours * 60 + minutes;
  }

  private getMissingWorkspaceMemberMetadataFields(
    error: unknown,
  ): Set<keyof WorkspaceMemberWorkspaceEntity> {
    const getMessagesArray = (value: unknown) =>
      Array.isArray(value) ? value.filter((entry) => typeof entry === 'string') : [];

    const errorObject =
      typeof error === 'object' && error !== null
        ? (error as Record<string, unknown>)
        : null;
    const responseObject =
      errorObject && typeof errorObject.response === 'object' && errorObject.response !== null
        ? (errorObject.response as Record<string, unknown>)
        : null;

    const rawMessage =
      error instanceof Error
        ? error.message
        : typeof error === 'string'
          ? error
          : '';

    const flattenedMessages = [
      rawMessage,
      ...getMessagesArray(responseObject?.messages),
      ...getMessagesArray(errorObject?.messages),
      (() => {
        try {
          return JSON.stringify(error);
        } catch {
          return '';
        }
      })(),
    ]
      .filter(Boolean)
      .join(' ');

    const missingFields = new Set<keyof WorkspaceMemberWorkspaceEntity>();

    if (flattenedMessages.includes('availabilityStartTime')) {
      missingFields.add('availabilityStartTime');
    }

    if (flattenedMessages.includes('availabilityEndTime')) {
      missingFields.add('availabilityEndTime');
    }

    if (flattenedMessages.includes('availabilityHours')) {
      missingFields.add('availabilityHours');
    }

    if (flattenedMessages.includes('availableDays')) {
      missingFields.add('availableDays');
    }

    return missingFields;
  }

  private getWeekdayFromDate(date: Date): WeekdayKey {
    const dateDay = date.getUTCDay();

    const weekdayByIndex: Record<number, WeekdayKey> = {
      0: 'SUNDAY',
      1: 'MONDAY',
      2: 'TUESDAY',
      3: 'WEDNESDAY',
      4: 'THURSDAY',
      5: 'FRIDAY',
      6: 'SATURDAY',
    };

    return weekdayByIndex[dateDay];
  }

  // Assigns leads round-robin among active members only. Does not balance by current lead count.
  private async getAssigneeByLoadBalance(
    workspaceId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<{
    assigneeId: string | null;
    memberCount: number;
    currentIndex: number;
    allMembers: Array<{ id: string; name: string; leadCount: number }>;
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

      // Get all workspace members, their lead counts, and total lead count for round-robin
      const { members, leadCounts, totalLeadCount } =
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

            const leadRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'lead',
                { shouldBypassPermissionChecks: true },
              );

            const totalCount = await leadRepository.count();

            const counts: Record<string, number> = {};
            for (const member of allMembers) {
              const count = await leadRepository.count({
                where: { assigneeId: member.id },
              });
              counts[member.id] = count;
            }

            return {
              members: allMembers,
              leadCounts: counts,
              totalLeadCount: totalCount,
            };
          },
        );

      this.logger.log(
        `[Lead Assignment] Found ${members?.length || 0} workspace members`,
      );

      if (!Array.isArray(members) || members.length === 0) {
        this.logger.warn(
          `No workspace members found for workspace ${workspaceId}`,
        );
        return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: [] };
      }

      const salesMemberIds = await this.getSalesWorkspaceMemberIds(
        workspaceId,
        authContext,
      );
      const shouldRestrictToSalesMembers = salesMemberIds.length > 0;

      const baseEligibleMembers = members
        .filter((member) => {
          const fullName = `${member.name?.firstName || ''} ${member.name?.lastName || ''}`.trim();
          const availabilityStatus = this.computeAvailabilityStatus(member);

          // Exclude "System Admin", unnamed members, and currently inactive members.
          return (
            fullName.toLowerCase() !== 'system admin' &&
            fullName !== '' &&
            availabilityStatus.status === 'ACTIVE'
          );
        })
        .map((member) => ({
          id: member.id,
          name: `${member.name?.firstName || ''} ${member.name?.lastName || ''}`.trim(),
          leadCount: leadCounts[member.id] || 0,
          availabilityStartTime: this.getAvailabilityStartTime(member),
          availabilityEndTime: this.getAvailabilityEndTime(member),
          availableDays: this.getAvailableDays(member),
        }));

      const eligibleSalesMembers = shouldRestrictToSalesMembers
        ? baseEligibleMembers.filter((member) => salesMemberIds.includes(member.id))
        : baseEligibleMembers;

      // Log all members for debugging
      this.logger.log(
        `[Lead Assignment] Eligible members (active, excluding System Admin):`,
      );
      baseEligibleMembers.forEach((member) => {
        this.logger.log(
          `  - ${member.name}: ${member.leadCount} leads, ${member.availabilityStartTime}-${member.availabilityEndTime}`,
        );
      });

      let selectedPool = eligibleSalesMembers;
      let selectedPoolLabel = shouldRestrictToSalesMembers ? 'sales' : 'all';

      if (shouldRestrictToSalesMembers && eligibleSalesMembers.length === 0) {
        const managerMemberIds = await this.getManagerWorkspaceMemberIds(
          workspaceId,
          authContext,
        );

        const eligibleManagerMembers = baseEligibleMembers.filter((member) =>
          managerMemberIds.includes(member.id),
        );

        if (eligibleManagerMembers.length > 0) {
          selectedPool = eligibleManagerMembers;
          selectedPoolLabel = 'manager';
          this.logger.warn(
            `[Lead Assignment] No available sales members. Falling back to available managers.`,
          );
        } else {
          this.logger.warn(
            `[Lead Assignment] No available sales members and no available managers.`,
          );
          throw new ServiceUnavailableException(
            'No sales team members are currently available to accept leads, and no manager is currently available. ' +
              'Try again later or update team availability and leave in Settings.',
          );
        }
      }

      if (selectedPool.length === 0) {
        throw new ServiceUnavailableException(
          'No team members are currently available to accept leads. ' +
            'Try again later or update team availability and leave in Settings.',
        );
      }

      // Equal distribution among active members: stable order by id, then round-robin by total lead count
      const orderedPool = [...selectedPool].sort((a, b) =>
        a.id.localeCompare(b.id),
      );
      const roundRobinIndex = totalLeadCount % orderedPool.length;
      const selectedMember = orderedPool[roundRobinIndex];

      this.logger.log(
        `[Lead Assignment] Selected ${selectedMember.name} (round-robin ${roundRobinIndex + 1}/${orderedPool.length}) from ${selectedPoolLabel}`,
      );

      return {
        assigneeId: selectedMember.id,
        memberCount: selectedPool.length,
        currentIndex: selectedPool.findIndex((m) => m.id === selectedMember.id),
        allMembers: selectedPool,
      };
    } catch (error) {
      if (error instanceof ServiceUnavailableException) {
        throw error;
      }

      this.logger.error('Failed to get assignee from active pool', error);
      return { assigneeId: null, memberCount: 0, currentIndex: -1, allMembers: [] };
    }
  }

  private async findOrCreateCustomer(
    personData: CreateLeadWithPersonDto['person'],
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    const primaryEmail = personData?.emails?.[0]?.email;
    const primaryPhone = personData?.phones?.[0]?.number;

    if (primaryEmail) {
      const existing = await this.findCustomerByEmail(primaryEmail, authContext);
      if (existing) {
        this.logger.log(
          `[FindOrCreateCustomer] Found existing customer by email: ${primaryEmail}, id: ${existing.id}`,
        );
        return existing;
      }
    }

    if (primaryPhone) {
      const existing = await this.findCustomerByPhone(primaryPhone, authContext);
      if (existing) {
        this.logger.log(
          `[FindOrCreateCustomer] Found existing customer by phone: ${primaryPhone}, id: ${existing.id}`,
        );
        return existing;
      }
    }

    this.logger.log(
      `[FindOrCreateCustomer] Creating new customer with email: ${primaryEmail || 'none'}, phone: ${primaryPhone || 'none'}`,
    );

    const { queryRunnerContext, selectedFields } =
      await this.commonApiContextBuilder.build({
        authContext,
        objectName: 'customer',
      });

    const customerPayload: Record<string, unknown> = {};

    if (personData?.name) {
      const firstName = personData.name.firstName?.trim() || '';
      const lastName = personData.name.lastName?.trim() || '';
      customerPayload.name = [firstName, lastName].filter(Boolean).join(' ') || null;
    }

    if (personData?.emails && personData.emails.length > 0) {
      customerPayload.emails = {
        primaryEmail: personData.emails[0].email,
        additionalEmails: personData.emails.slice(1).map((e) => e.email),
      };
    }

    if (personData?.phones && personData.phones.length > 0) {
      customerPayload.phones = {
        primaryPhoneNumber: personData.phones[0].number,
        primaryPhoneCountryCode: '',
        additionalPhones: personData.phones
          .slice(1)
          .map((p) => ({ number: p.number, countryCode: '' })),
      };
    }

    if (personData?.jobTitle) {
      customerPayload.jobTitle = personData.jobTitle;
    }

    if (personData?.companyName) {
      customerPayload.companyName = personData.companyName;
    }

    if (personData?.whatsapp && personData.whatsapp.length > 0) {
      customerPayload.whatsapp = {
        primaryPhoneNumber: personData.whatsapp[0].number,
        primaryPhoneCountryCode: '',
        additionalPhones: personData.whatsapp
          .slice(1)
          .map((p) => ({ number: p.number, countryCode: '' })),
      };
    }

    const createdCustomer = await this.commonCreateOneQueryRunnerService.execute(
      {
        data: customerPayload,
        selectedFields,
      },
      queryRunnerContext,
    );

    this.logger.log(
      `[FindOrCreateCustomer] Created new customer: ${createdCustomer.id}`,
    );

    return createdCustomer;
  }

  private async findCustomerByEmail(
    email: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      const existing =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const customerRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'customer',
                { shouldBypassPermissionChecks: true },
              );

            const customers = await customerRepository.find();
            const emailLower = email.toLowerCase();

            const found = customers.find((customer: any) => {
              const emails = customer.emails ?? customer.email;
              if (!emails) return false;

              const primary = emails.primaryEmail ?? emails.primary;
              if (primary?.toLowerCase() === emailLower) return true;

              const additional = emails.additionalEmails ?? emails.additional;
              if (Array.isArray(additional)) {
                return additional.some(
                  (e: string) => e?.toLowerCase() === emailLower,
                );
              }

              return false;
            });

            return found || null;
          },
        );

      return existing;
    } catch (error: any) {
      this.logger.error(
        `[FindCustomerByEmail] Failed: ${error?.message || error}`,
      );
      return null;
    }
  }

  private async findCustomerByPhone(
    phone: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      const normalizedPhone = phone.replace(/[\s\-\(\)]/g, '');

      const existing =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const customerRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'customer',
                { shouldBypassPermissionChecks: true },
              );

            const customers = await customerRepository.find();

            const found = customers.find((customer: any) => {
              const phones = customer.phones ?? customer.phone;
              if (!phones) return false;

              const primary =
                phones.primaryPhoneNumber ?? phones.primary;
              const primaryNorm = primary?.replace(/[\s\-\(\)]/g, '');
              if (primaryNorm && primaryNorm.includes(normalizedPhone)) {
                return true;
              }
              if (primaryNorm && normalizedPhone.includes(primaryNorm)) {
                return true;
              }

              const additional =
                phones.additionalPhones ?? phones.additional;
              if (Array.isArray(additional)) {
                return additional.some((p: any) => {
                  const num = (p?.number ?? p)?.replace(/[\s\-\(\)]/g, '');
                  return (
                    num &&
                    (num.includes(normalizedPhone) ||
                      normalizedPhone.includes(num))
                  );
                });
              }

              return false;
            });

            return found || null;
          },
        );

      return existing;
    } catch (error: any) {
      this.logger.error(
        `[FindCustomerByPhone] Failed: ${error?.message || error}`,
      );
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

  private async findPropertyByName(
    propertyName: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      const property =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const propertyRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'property',
                { shouldBypassPermissionChecks: true },
              );

            const found = await propertyRepository.findOne({
              where: { name: propertyName },
            });

            return found ?? null;
          },
        );

      if (property) {
        this.logger.log(
          `[FindPropertyByName] Found property: ${propertyName} -> ${property.id}`,
        );
      } else {
        this.logger.warn(
          `[FindPropertyByName] No property found with name: ${propertyName}`,
        );
      }

      return property;
    } catch (error: any) {
      this.logger.error(
        `[FindPropertyByName] Failed: ${error?.message || error}`,
      );
      return null;
    }
  }

  private async findPropertyById(
    propertyId: string,
    authContext: WorkspaceAuthContext,
  ): Promise<any | null> {
    try {
      const workspaceId = authContext.workspace.id;

      const property =
        await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
          authContext,
          async () => {
            const propertyRepository =
              await this.globalWorkspaceOrmManager.getRepository(
                workspaceId,
                'property',
                { shouldBypassPermissionChecks: true },
              );

            const found = await propertyRepository.findOne({
              where: { id: propertyId },
            });

            return found ?? null;
          },
        );

      return property;
    } catch (error: any) {
      this.logger.error(
        `[FindPropertyById] Failed: ${error?.message || error}`,
      );
      return null;
    }
  }

  private async createLead(
    leadData: {
      title: string;
      body?: string;
      dueDate?: string;
      convenientTime?: string;
      buildingType?: string[];
      assigneeId?: string | null;
      customerId?: string | null;
      originId?: string | null;
      propertyId?: string | null;
    },
    authContext: WorkspaceAuthContext,
  ): Promise<any> {
    const {
      queryRunnerContext,
      selectedFields,
      flatObjectMetadata,
      flatFieldMetadataMaps,
    } =
      await this.commonApiContextBuilder.build({
        authContext,
        objectName: 'lead',
      });

    const statusField = Object.values(flatFieldMetadataMaps.byId).find(
      (field: any) =>
        field.objectMetadataId === flatObjectMetadata.id &&
        field.name === 'status',
    );

    let statusValue: string | undefined;

    if (
      statusField &&
      Array.isArray(statusField.options) &&
      statusField.options.length > 0
    ) {
      const options = statusField.options as Array<{
        value: string;
        label?: string;
      }>;

      const preferredOption = options.find((option) => {
        const valueLower = option.value.toLowerCase();
        const labelLower = option.label?.toLowerCase();

        return valueLower === 'new' || labelLower === 'new';
      });

      statusValue = (preferredOption ?? options[0]).value;
    }

    const hasReadAtField = Object.values(flatFieldMetadataMaps.byId).some(
      (field: any) =>
        field.objectMetadataId === flatObjectMetadata.id &&
        field.name === 'readAt',
    );

    const leadPayload: Record<string, unknown> = {
      name: leadData.title,
    };

    if (hasReadAtField) {
      leadPayload.readAt = null;
    }

    if (isDefined(statusValue)) {
      leadPayload.status = statusValue;
    }

    if (leadData.body) {
      // Plain text body (existing field)
      leadPayload.body = leadData.body;
      // Rich-text notes field (RICH_TEXT_V2) mirroring Task body
      // leadPayload.notes = {
      //   markdown: leadData.body,
      // };
    }

    if (leadData.dueDate) {
      leadPayload.dueDate = leadData.dueDate;
    }

    if (leadData.convenientTime) {
      leadPayload.convenientTime = leadData.convenientTime;
    }

    if (Array.isArray(leadData.buildingType) && leadData.buildingType.length) {
      leadPayload.buildingType = leadData.buildingType;
    }

    if (leadData.assigneeId) {
      leadPayload.assigneeId = leadData.assigneeId;
    }

    if (leadData.customerId) {
      leadPayload.customerId = leadData.customerId;
    }

    if (leadData.originId) {
      leadPayload.originId = leadData.originId;
    }

    if (leadData.propertyId) {
      leadPayload.propertyId = leadData.propertyId;
    }

    const createdLead = await this.commonCreateOneQueryRunnerService.execute(
      {
        data: leadPayload,
        selectedFields,
      },
      queryRunnerContext,
    );

    this.logger.log(`[CreateLead] Created: ${JSON.stringify(createdLead)}`);

    return createdLead;
  }

  private async generateNextLeadTitle(
    authContext: WorkspaceAuthContext,
  ): Promise<string> {
    try {
      const workspaceId = authContext.workspace.id;

      const nextIndex = await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
        authContext,
        async () => {
          const leadRepository =
            await this.globalWorkspaceOrmManager.getRepository(
              workspaceId,
              'lead',
              { shouldBypassPermissionChecks: true },
            );

          const existingCount = await leadRepository.count({

          });

          return existingCount + 1;
        },
      );

      return `SFS-${nextIndex}`;
    } catch (error) {
      this.logger.error(
        '[GenerateNextLeadTitle] Failed, falling back to SFS-1',
        error,
      );
      return 'SFS-1';
    }
  }
}
