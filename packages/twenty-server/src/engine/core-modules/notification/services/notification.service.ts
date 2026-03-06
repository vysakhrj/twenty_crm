import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { isDefined } from 'twenty-shared/utils';
import { Repository } from 'typeorm';

import { NotificationType } from 'src/engine/core-modules/notification/enums/notification-type.enum';
import {
  NotificationEntity,
  NotificationMetadata,
} from 'src/engine/core-modules/notification/entities/notification.entity';
import { SubscriptionService } from 'src/engine/subscriptions/subscription.service';
import { SubscriptionChannel } from 'src/engine/subscriptions/enums/subscription-channel.enum';

export type CreateNotificationInput = {
  userId: string;
  workspaceId: string;
  type: NotificationType;
  title: string;
  body: string;
  metadata?: NotificationMetadata;
};

export type NotificationFilter = {
  userId?: string;
  workspaceId?: string;
  isRead?: boolean;
  type?: NotificationType;
};

export type NotificationPagination = {
  first?: number;
  after?: string;
};

@Injectable()
export class NotificationService {
  private readonly logger = new Logger(NotificationService.name);

  constructor(
    @InjectRepository(NotificationEntity)
    private readonly notificationRepository: Repository<NotificationEntity>,
    private readonly subscriptionService: SubscriptionService,
  ) {}

  async create(input: CreateNotificationInput): Promise<NotificationEntity> {
    const notification = this.notificationRepository.create({
      ...input,
      metadata: input.metadata || {},
      isRead: false,
      emailSent: false,
      pushSent: false,
    });

    const saved = await this.notificationRepository.save(notification);

    try {
      await this.subscriptionService.publish({
        channel: SubscriptionChannel.NOTIFICATION_CHANNEL,
        workspaceId: input.workspaceId,
        payload: { notificationReceived: saved },
      });
    } catch (error) {
      this.logger.warn(
        `Failed to publish notification to subscription channel: ${error}`,
      );
    }

    return saved;
  }

  async findMany(
    filter: NotificationFilter,
    pagination: NotificationPagination,
  ): Promise<{
    notifications: NotificationEntity[];
    hasNextPage: boolean;
    endCursor: string | null;
  }> {
    const queryBuilder = this.notificationRepository.createQueryBuilder(
      'notification',
    );

    if (isDefined(filter.userId)) {
      queryBuilder.andWhere('notification.userId = :userId', {
        userId: filter.userId,
      });
    }

    if (isDefined(filter.workspaceId)) {
      queryBuilder.andWhere('notification.workspaceId = :workspaceId', {
        workspaceId: filter.workspaceId,
      });
    }

    if (isDefined(filter.isRead)) {
      queryBuilder.andWhere('notification.isRead = :isRead', {
        isRead: filter.isRead,
      });
    }

    if (isDefined(filter.type)) {
      queryBuilder.andWhere('notification.type = :type', {
        type: filter.type,
      });
    }

    queryBuilder.orderBy('notification.createdAt', 'DESC');

    const limit = pagination.first ?? 20;
    queryBuilder.limit(limit + 1);

    if (isDefined(pagination.after)) {
      queryBuilder.andWhere('notification.createdAt < :cursor', {
        cursor: new Date(pagination.after),
      });
    }

    const results = await queryBuilder.getMany();
    const hasNextPage = results.length > limit;

    const notifications = hasNextPage ? results.slice(0, limit) : results;

    const endCursor =
      notifications.length > 0
        ? notifications[notifications.length - 1].createdAt.toISOString()
        : null;

    return {
      notifications,
      hasNextPage,
      endCursor,
    };
  }

  async findById(id: string): Promise<NotificationEntity | null> {
    return this.notificationRepository.findOne({
      where: { id },
    });
  }

  async markAsRead(id: string): Promise<NotificationEntity | null> {
    const notification = await this.findById(id);

    if (!isDefined(notification)) {
      return null;
    }

    notification.isRead = true;
    notification.readAt = new Date();

    return this.notificationRepository.save(notification);
  }

  async markAllAsRead(userId: string, workspaceId: string): Promise<void> {
    await this.notificationRepository.update(
      {
        userId,
        workspaceId,
        isRead: false,
      },
      {
        isRead: true,
        readAt: new Date(),
      },
    );
  }

  async delete(id: string): Promise<boolean> {
    const result = await this.notificationRepository.delete(id);

    return result.affected === 1;
  }

  async countUnread(userId: string, workspaceId: string): Promise<number> {
    return this.notificationRepository.count({
      where: {
        userId,
        workspaceId,
        isRead: false,
      },
    });
  }

  async updateEmailSent(id: string): Promise<void> {
    await this.notificationRepository.update(id, { emailSent: true });
  }

  async updatePushSent(id: string): Promise<void> {
    await this.notificationRepository.update(id, { pushSent: true });
  }
}
