import { UseGuards } from '@nestjs/common';
import {
  Args,
  Int,
  Mutation,
  Query,
  Resolver,
  Subscription,
} from '@nestjs/graphql';

import { isDefined } from 'twenty-shared/utils';

import { UserEntity } from 'src/engine/core-modules/user/user.entity';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { AuthUser } from 'src/engine/decorators/auth/auth-user.decorator';
import { AuthWorkspace } from 'src/engine/decorators/auth/auth-workspace.decorator';
import { NoPermissionGuard } from 'src/engine/guards/no-permission.guard';
import { UserAuthGuard } from 'src/engine/guards/user-auth.guard';
import { WorkspaceAuthGuard } from 'src/engine/guards/workspace-auth.guard';
import { SubscriptionChannel } from 'src/engine/subscriptions/enums/subscription-channel.enum';
import { SubscriptionService } from 'src/engine/subscriptions/subscription.service';

import {
  NotificationConnection,
  NotificationPageInfo,
} from './dto/notification-connection.output';
import { NotificationFilterInput } from './dto/notification-filter.input';
import { NotificationEntity } from './entities/notification.entity';
import { NotificationService } from './services/notification.service';

@Resolver(() => NotificationEntity)
@UseGuards(WorkspaceAuthGuard, UserAuthGuard, NoPermissionGuard)
export class NotificationResolver {
  constructor(
    private readonly notificationService: NotificationService,
    private readonly subscriptionService: SubscriptionService,
  ) {}

  @Query(() => NotificationConnection)
  async notifications(
    @Args('filter', { nullable: true }) filter: NotificationFilterInput,
    @Args('first', { type: () => Int, nullable: true, defaultValue: 20 }) first: number,
    @Args('after', { nullable: true }) after: string,
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<NotificationConnection> {
    const result = await this.notificationService.findMany(
      {
        userId: user.id,
        workspaceId: workspace.id,
        isRead: filter?.isRead,
        type: filter?.type,
      },
      { first, after },
    );

    return {
      edges: result.notifications,
      pageInfo: {
        hasNextPage: result.hasNextPage,
        endCursor: result.endCursor,
      } as NotificationPageInfo,
    };
  }

  @Query(() => Number)
  async unreadNotificationsCount(
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<number> {
    return this.notificationService.countUnread(user.id, workspace.id);
  }

  @Mutation(() => NotificationEntity, { nullable: true })
  async markNotificationAsRead(
    @Args('id') id: string,
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<NotificationEntity | null> {
    const notification = await this.notificationService.findById(id);

    if (!isDefined(notification)) {
      return null;
    }

    if (
      notification.userId !== user.id ||
      notification.workspaceId !== workspace.id
    ) {
      return null;
    }

    return this.notificationService.markAsRead(id);
  }

  @Mutation(() => Boolean)
  async markAllNotificationsAsRead(
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<boolean> {
    await this.notificationService.markAllAsRead(user.id, workspace.id);

    return true;
  }

  @Mutation(() => Boolean)
  async deleteNotification(
    @Args('id') id: string,
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<boolean> {
    const notification = await this.notificationService.findById(id);

    if (!isDefined(notification)) {
      return false;
    }

    if (
      notification.userId !== user.id ||
      notification.workspaceId !== workspace.id
    ) {
      return false;
    }

    return this.notificationService.delete(id);
  }

  @Subscription(() => NotificationEntity, {
    filter: (
      payload: { notificationReceived: NotificationEntity },
      _variables: Record<string, unknown>,
      context: { userId: string; workspaceId: string },
    ) => {
      const notification = payload.notificationReceived;

      return (
        notification.userId === context.userId &&
        notification.workspaceId === context.workspaceId
      );
    },
  })
  notificationReceived(
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ) {
    return this.subscriptionService.subscribe({
      channel: SubscriptionChannel.NOTIFICATION_CHANNEL,
      workspaceId: workspace.id,
      userId: user.id,
    });
  }
}
