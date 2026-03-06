import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { NotificationEntity } from 'src/engine/core-modules/notification/entities/notification.entity';
import { NotificationResolver } from 'src/engine/core-modules/notification/notification.resolver';
import { NotificationService } from 'src/engine/core-modules/notification/services/notification.service';
import { SubscriptionsModule } from 'src/engine/subscriptions/subscriptions.module';

@Module({
  imports: [TypeOrmModule.forFeature([NotificationEntity]), SubscriptionsModule],
  providers: [NotificationService, NotificationResolver],
  exports: [NotificationService],
})
export class NotificationModule {}
