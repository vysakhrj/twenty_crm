import { UseGuards } from '@nestjs/common';
import { Args, Mutation, Resolver } from '@nestjs/graphql';

import { UpsertFcmTokenInput } from 'src/engine/core-modules/user/dtos/upsert-fcm-token.input';
import { UserFcmTokenService } from 'src/engine/core-modules/user/services/user-fcm-token.service';
import { UserEntity } from 'src/engine/core-modules/user/user.entity';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { AuthUser } from 'src/engine/decorators/auth/auth-user.decorator';
import { AuthWorkspace } from 'src/engine/decorators/auth/auth-workspace.decorator';
import { NoPermissionGuard } from 'src/engine/guards/no-permission.guard';
import { UserAuthGuard } from 'src/engine/guards/user-auth.guard';
import { WorkspaceAuthGuard } from 'src/engine/guards/workspace-auth.guard';

@Resolver(() => UserEntity)
export class UserFcmTokenResolver {
  constructor(private readonly userFcmTokenService: UserFcmTokenService) {}

  @Mutation(() => Boolean)
  @UseGuards(UserAuthGuard, WorkspaceAuthGuard, NoPermissionGuard)
  async upsertFcmToken(
    @Args('input') input: UpsertFcmTokenInput,
    @AuthUser() user: UserEntity,
    @AuthWorkspace() workspace: WorkspaceEntity,
  ): Promise<boolean> {
    await this.userFcmTokenService.upsertUserToken({
      userId: user.id,
      workspaceId: workspace.id,
      deviceId: input.deviceId,
      token: input.token,
    });

    return true;
  }
}
