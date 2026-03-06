import { Injectable, Logger } from '@nestjs/common';

import { Process } from 'src/engine/core-modules/message-queue/decorators/process.decorator';
import { Processor } from 'src/engine/core-modules/message-queue/decorators/processor.decorator';
import { MessageQueue } from 'src/engine/core-modules/message-queue/message-queue.constants';
import { NotificationType } from 'src/engine/core-modules/notification/enums/notification-type.enum';
import { NotificationService } from 'src/engine/core-modules/notification/services/notification.service';
import { UserFcmTokenService } from 'src/engine/core-modules/user/services/user-fcm-token.service';
import { buildSystemAuthContext } from 'src/engine/twenty-orm/utils/build-system-auth-context.util';
import { GlobalWorkspaceOrmManager } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-orm.manager';
import { FcmPushNotificationService } from 'src/modules/lead-assignment-notification/services/fcm-push-notification.service';
import { type WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';
import { isDefined } from 'twenty-shared/utils';
import { addDays, startOfDay, endOfDay } from 'date-fns';

export type SendFollowUpReminderJobData = {
  workspaceId: string;
};

type LeadRecord = {
  id: string;
  assigneeId?: string | null;
  name?: string | null;
  title?: string | null;
  dueAt?: Date | null;
};

@Injectable()
@Processor(MessageQueue.workspaceQueue)
export class SendFollowUpReminderJob {
  private readonly logger = new Logger(SendFollowUpReminderJob.name);

  constructor(
    private readonly globalWorkspaceOrmManager: GlobalWorkspaceOrmManager,
    private readonly notificationService: NotificationService,
    private readonly userFcmTokenService: UserFcmTokenService,
    private readonly fcmPushNotificationService: FcmPushNotificationService,
  ) {}

  @Process(SendFollowUpReminderJob.name)
  async handle(data: SendFollowUpReminderJobData): Promise<void> {
    const { workspaceId } = data;

    this.logger.log(
      `Processing follow-up reminders for workspace ${workspaceId}`,
    );

    const authContext = buildSystemAuthContext(workspaceId);

    try {
      // Get leads with due date within next 24 hours
      const leads = await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
        authContext,
        async () => {
          const leadRepository =
            await this.globalWorkspaceOrmManager.getRepository<LeadRecord>(
              workspaceId,
              'lead',
              { shouldBypassPermissionChecks: true },
            );

          const now = new Date();
          const tomorrow = addDays(now, 1);

          return leadRepository.find({
            where: {
              dueAt: {
                gte: startOfDay(now),
                lte: endOfDay(tomorrow),
              },
              assigneeId: {
                not: null,
              },
            },
            select: ['id', 'assigneeId', 'name', 'title', 'dueAt'],
          });
        },
      );

      this.logger.log(
        `Found ${leads.length} leads with upcoming due dates in workspace ${workspaceId}`,
      );

      for (const lead of leads) {
        if (!isDefined(lead.assigneeId)) {
          continue;
        }

        await this.sendReminderForLead(lead, workspaceId, authContext);
      }

      this.logger.log(
        `Completed follow-up reminders for workspace ${workspaceId}`,
      );
    } catch (error) {
      this.logger.error(
        `Failed to process follow-up reminders for workspace ${workspaceId}`,
        error instanceof Error ? error.stack : String(error),
      );
      throw error;
    }
  }

  private async sendReminderForLead(
    lead: LeadRecord,
    workspaceId: string,
    authContext: any,
  ): Promise<void> {
    // Get assignee details
    const assignee = await this.globalWorkspaceOrmManager.executeInWorkspaceContext(
      authContext,
      async () => {
        const workspaceMemberRepository =
          await this.globalWorkspaceOrmManager.getRepository<WorkspaceMemberWorkspaceEntity>(
            workspaceId,
            'workspaceMember',
            { shouldBypassPermissionChecks: true },
          );

        return workspaceMemberRepository.findOne({
          where: { id: lead.assigneeId! },
        });
      },
    );

    if (!isDefined(assignee?.userId)) {
      this.logger.debug(`No user found for assignee ${lead.assigneeId}`);
      return;
    }

    const leadName = this.getLeadName(lead);
    const formattedDueDate = lead.dueAt
      ? new Date(lead.dueAt).toLocaleDateString()
      : 'today';

    // Create notification
    const notification = await this.notificationService.create({
      userId: assignee.userId,
      workspaceId,
      type: NotificationType.FOLLOW_UP_REMINDER,
      title: 'Follow-up reminder',
      body: `${leadName} is due for follow-up on ${formattedDueDate}`,
      metadata: { leadId: lead.id },
    });

    // Send push notification
    const tokens = await this.userFcmTokenService.getUserTokens({
      userId: assignee.userId,
      workspaceId,
    });

    if (tokens.length > 0) {
      const invalidTokens =
        await this.fcmPushNotificationService.sendFollowUpReminderPush({
          tokens,
          leadId: lead.id,
          leadName,
          notificationId: notification.id,
          workspaceId,
        });

      if (invalidTokens.length > 0) {
        await this.userFcmTokenService.removeUserTokens({
          userId: assignee.userId,
          workspaceId,
          tokensToRemove: invalidTokens,
        });
      }

      await this.notificationService.updatePushSent(notification.id);
    }

    this.logger.log(
      `Sent follow-up reminder for lead ${lead.id} to user ${assignee.userId}`,
    );
  }

  private getLeadName(lead: LeadRecord): string {
    if (lead.name) {
      return lead.name;
    }

    if (lead.title) {
      return lead.title;
    }

    return `Lead #${lead.id}`;
  }
}
