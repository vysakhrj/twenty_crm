import { Injectable, Logger, OnModuleInit } from '@nestjs/common';

import {
  type ObjectRecordCreateEvent,
  type ObjectRecordUpsertEvent,
  type ObjectRecordUpdateEvent,
} from 'twenty-shared/database-events';
import { isDefined } from 'twenty-shared/utils';

import { OnDatabaseBatchEvent } from 'src/engine/api/graphql/graphql-query-runner/decorators/on-database-batch-event.decorator';
import { DatabaseEventAction } from 'src/engine/api/graphql/graphql-query-runner/enums/database-event-action';
import { WorkspaceEventBatch } from 'src/engine/workspace-event-emitter/types/workspace-event-batch.type';
import { UserFcmTokenService } from 'src/engine/core-modules/user/services/user-fcm-token.service';
import { GlobalWorkspaceOrmManager } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-orm.manager';
import { buildSystemAuthContext } from 'src/engine/twenty-orm/utils/build-system-auth-context.util';
import { FcmPushNotificationService } from 'src/modules/lead-assignment-notification/services/fcm-push-notification.service';
import { type WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';
import { NotificationService } from 'src/engine/core-modules/notification/services/notification.service';
import { NotificationType } from 'src/engine/core-modules/notification/enums/notification-type.enum';
import { EmailService } from 'src/engine/core-modules/email/email.service';

type LeadRecord = {
  assigneeId?: string | null;
  assigneeRelationId?: string | null;
  assignee?: { id?: string | null } | string | null;
  name?: string | null;
  title?: string | null;
};

@Injectable()
export class LeadAssignmentListener {
  private readonly logger = new Logger(LeadAssignmentListener.name);
  private static readonly BUILD_MARKER = '2026-03-06-lead-assignment-v3';

  onModuleInit() {
    this.logger.log(
      `LeadAssignmentListener loaded (${LeadAssignmentListener.BUILD_MARKER})`,
    );
  }

  constructor(
    private readonly globalWorkspaceOrmManager: GlobalWorkspaceOrmManager,
    private readonly userFcmTokenService: UserFcmTokenService,
    private readonly fcmPushNotificationService: FcmPushNotificationService,
    private readonly notificationService: NotificationService,
    private readonly emailService: EmailService,
  ) {}

  @OnDatabaseBatchEvent('lead', DatabaseEventAction.CREATED)
  @OnDatabaseBatchEvent('lead', DatabaseEventAction.UPDATED)
  @OnDatabaseBatchEvent('lead', DatabaseEventAction.UPSERTED)
  async handleLeadCreatedOrUpdated(
    payload: WorkspaceEventBatch<
      | ObjectRecordCreateEvent<LeadRecord>
      | ObjectRecordUpdateEvent<LeadRecord>
      | ObjectRecordUpsertEvent<LeadRecord>
    >,
  ) {
    this.logger.log(
      `Lead assignment listener received ${payload.events.length} event(s) for ${payload.name} in workspace ${payload.workspaceId}`,
    );

    const authContext = buildSystemAuthContext(payload.workspaceId);

    for (const event of payload.events) {
      const previousAssigneeId =
        'before' in event.properties
          ? this.extractAssigneeId(event.properties.before)
          : null;
      const nextAssigneeId = this.extractAssigneeId(event.properties.after);

      if (!nextAssigneeId || nextAssigneeId === previousAssigneeId) {
        this.logger.debug(
          `Skipping lead ${event.recordId}: previousAssigneeId=${previousAssigneeId ?? 'null'} nextAssigneeId=${nextAssigneeId ?? 'null'}`,
        );
        continue;
      }

      const assignee = await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
        authContext,
        async () => {
          const workspaceMemberRepository =
            await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
              payload.workspaceId,
              'workspaceMember',
              { shouldBypassPermissionChecks: true },
            );

          return workspaceMemberRepository.findOne({
            where: { id: nextAssigneeId },
          });
        },
      );

      if (!isDefined(assignee?.userId)) {
        continue;
      }

      const leadName = this.getLeadName(event.properties.after, event.recordId);

      // Create notification record
      const notification = await this.notificationService.create({
        userId: assignee.userId,
        workspaceId: payload.workspaceId,
        type: NotificationType.LEAD_ASSIGNED,
        title: 'New lead assigned',
        body: `${leadName} has been assigned to you`,
        metadata: { leadId: event.recordId },
      });

      // Send push notification
      const tokens = await this.userFcmTokenService.getUserTokens({
        userId: assignee.userId,
        workspaceId: payload.workspaceId,
      });

      if (tokens.length > 0) {
        const invalidTokens =
          await this.fcmPushNotificationService.sendLeadAssignmentPush({
            tokens,
            leadId: event.recordId,
            leadName,
            notificationId: notification.id,
            workspaceId: payload.workspaceId,
          });

        if (invalidTokens.length > 0) {
          await this.userFcmTokenService.removeUserTokens({
            userId: assignee.userId,
            workspaceId: payload.workspaceId,
            tokensToRemove: invalidTokens,
          });
        }

        await this.notificationService.updatePushSent(notification.id);
      } else {
        this.logger.warn(
          `No FCM tokens found for user ${assignee.userId} in workspace ${payload.workspaceId}`,
        );
      }

      // Send email notification
      await this.emailService.send({
        to: assignee.userEmail ?? '',
        subject: 'New lead assigned to you',
        text: `${leadName} has been assigned to you. View it at: /objects/leads/${event.recordId}`,
        html: `<p>${leadName} has been assigned to you.</p><p><a href="/objects/leads/${event.recordId}">View Lead</a></p>`,
      });

      await this.notificationService.updateEmailSent(notification.id);
    }
  }

  private getLeadName(lead: LeadRecord | undefined, fallbackId: string): string {
    if (lead?.name) {
      return lead.name;
    }

    if (lead?.title) {
      return lead.title;
    }

    this.logger.debug(`Lead ${fallbackId} has no name/title value`);

    return `Lead #${fallbackId}`;
  }

  private extractAssigneeId(lead: LeadRecord | undefined): string | null {
    if (!lead) {
      return null;
    }

    if (lead.assigneeId) {
      return lead.assigneeId;
    }

    if (lead.assigneeRelationId) {
      return lead.assigneeRelationId;
    }

    if (typeof lead.assignee === 'string') {
      return lead.assignee;
    }

    if (lead.assignee && typeof lead.assignee === 'object') {
      return lead.assignee.id ?? null;
    }

    return null;
  }
}
