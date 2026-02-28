import { Module } from '@nestjs/common';

import { UserModule } from 'src/engine/core-modules/user/user.module';
import { LeadAssignmentListener } from 'src/modules/lead-assignment-notification/listeners/lead-assignment.listener';
import { FcmPushNotificationService } from 'src/modules/lead-assignment-notification/services/fcm-push-notification.service';

@Module({
  imports: [UserModule],
  providers: [LeadAssignmentListener, FcmPushNotificationService],
})
export class LeadAssignmentNotificationModule {}
