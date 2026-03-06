import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { NotificationModule } from 'src/engine/core-modules/notification/notification.module';
import { UserModule } from 'src/engine/core-modules/user/user.module';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { LeadAssignmentNotificationModule } from 'src/modules/lead-assignment-notification/lead-assignment-notification.module';

import { FollowUpReminderCronCommand } from './commands/follow-up-reminder.cron.command';
import { FollowUpReminderCronJob } from './crons/follow-up-reminder.cron.job';
import { SendFollowUpReminderJob } from './jobs/send-follow-up-reminder.job';

@Module({
  imports: [
    TypeOrmModule.forFeature([WorkspaceEntity]),
    NotificationModule,
    UserModule,
    LeadAssignmentNotificationModule,
  ],
  providers: [
    FollowUpReminderCronJob,
    SendFollowUpReminderJob,
    FollowUpReminderCronCommand,
  ],
  exports: [FollowUpReminderCronCommand],
})
export class NotificationJobModule {}
