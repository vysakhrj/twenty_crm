import { Injectable, Logger } from '@nestjs/common';

import { isDefined } from 'twenty-shared/utils';
import { type ObjectRecordUpdateEvent } from 'twenty-shared/database-events';

import { OnDatabaseBatchEvent } from 'src/engine/api/graphql/graphql-query-runner/decorators/on-database-batch-event.decorator';
import { DatabaseEventAction } from 'src/engine/api/graphql/graphql-query-runner/enums/database-event-action';
import { WorkspaceEventBatch } from 'src/engine/workspace-event-emitter/types/workspace-event-batch.type';
import { UserFcmTokenService } from 'src/engine/core-modules/user/services/user-fcm-token.service';
import { GlobalWorkspaceOrmManager } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-orm.manager';
import { buildSystemAuthContext } from 'src/engine/twenty-orm/utils/build-system-auth-context.util';
import { FcmPushNotificationService } from 'src/modules/lead-assignment-notification/services/fcm-push-notification.service';
import { type WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';

type LeadRecord = {
  assigneeId?: string | null;
  name?: string | null;
  title?: string | null;
};

@Injectable()
export class LeadAssignmentListener {
  private readonly logger = new Logger(LeadAssignmentListener.name);

  constructor(
    private readonly globalWorkspaceOrmManager: GlobalWorkspaceOrmManager,
    private readonly userFcmTokenService: UserFcmTokenService,
    private readonly fcmPushNotificationService: FcmPushNotificationService,
  ) {}

  @OnDatabaseBatchEvent('lead', DatabaseEventAction.UPDATED)
  async handleLeadUpdated(
    payload: WorkspaceEventBatch<ObjectRecordUpdateEvent<LeadRecord>>,
  ) {
    const authContext = buildSystemAuthContext(payload.workspaceId);

    for (const event of payload.events) {
      const updatedFields = event.properties.updatedFields ?? [];

      if (!updatedFields.includes('assigneeId')) {
        continue;
      }

      const previousAssigneeId = event.properties.before?.assigneeId ?? null;
      const nextAssigneeId = event.properties.after?.assigneeId ?? null;

      if (!nextAssigneeId || nextAssigneeId === previousAssigneeId) {
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

      const tokens = await this.userFcmTokenService.getUserTokens({
        userId: assignee.userId,
        workspaceId: payload.workspaceId,
      });

      if (tokens.length === 0) {
        continue;
      }

      const leadName = this.getLeadName(event.properties.after, event.recordId);
      const invalidTokens =
        await this.fcmPushNotificationService.sendLeadAssignmentPush({
          tokens,
          leadId: event.recordId,
          leadName,
          workspaceId: payload.workspaceId,
        });

      if (invalidTokens.length > 0) {
        await this.userFcmTokenService.removeUserTokens({
          userId: assignee.userId,
          workspaceId: payload.workspaceId,
          tokensToRemove: invalidTokens,
        });
      }
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
}
