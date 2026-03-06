import { Module } from '@nestjs/common';

import { NotificationModule } from 'src/engine/core-modules/notification/notification.module';
import { UserModule } from 'src/engine/core-modules/user/user.module';
import { LeadAssignmentListener } from 'src/modules/lead-assignment-notification/listeners/lead-assignment.listener';
import { FcmPushNotificationService } from 'src/modules/lead-assignment-notification/services/fcm-push-notification.service';

@Module({
  imports: [UserModule, NotificationModule],
  providers: [LeadAssignmentListener, FcmPushNotificationService],
  exports: [FcmPushNotificationService],
})
export class LeadAssignmentNotificationModule {}
