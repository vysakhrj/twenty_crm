import { Injectable } from '@nestjs/common';

import { isDefined } from 'twenty-shared/utils';

import { UserVarsService } from 'src/engine/core-modules/user/user-vars/services/user-vars.service';

import { USER_FCM_TOKENS_KEY } from 'src/engine/core-modules/user/constants/user-fcm-tokens-key.constant';

const MAX_FCM_TOKENS_PER_USER_AND_WORKSPACE = 20;

export type StoredFcmToken = {
  deviceId: string;
  token: string;
  updatedAt: string;
};

@Injectable()
export class UserFcmTokenService {
  constructor(private readonly userVarsService: UserVarsService) {}

  async getUserTokens({
    userId,
    workspaceId,
  }: {
    userId: string;
    workspaceId: string;
  }): Promise<string[]> {
    const tokens = await this.getUserStoredTokens({ userId, workspaceId });

    return tokens.map((token) => token.token);
  }

  async upsertUserToken({
    userId,
    workspaceId,
    deviceId,
    token,
  }: {
    userId: string;
    workspaceId: string;
    deviceId: string;
    token: string;
  }): Promise<void> {
    const existingTokens = await this.getUserStoredTokens({ userId, workspaceId });

    const now = new Date().toISOString();
    const matchingTokenIndex = existingTokens.findIndex(
      (storedToken) => storedToken.deviceId === deviceId,
    );

    if (matchingTokenIndex >= 0) {
      existingTokens[matchingTokenIndex] = { deviceId, token, updatedAt: now };
    } else {
      existingTokens.push({ deviceId, token, updatedAt: now });
    }

    const nextTokens = existingTokens
      .sort((firstToken, secondToken) =>
        firstToken.updatedAt > secondToken.updatedAt ? -1 : 1,
      )
      .slice(0, MAX_FCM_TOKENS_PER_USER_AND_WORKSPACE);

    await this.userVarsService.set({
      userId,
      workspaceId,
      key: USER_FCM_TOKENS_KEY,
      value: nextTokens,
    });
  }

  async removeUserTokens({
    userId,
    workspaceId,
    tokensToRemove,
  }: {
    userId: string;
    workspaceId: string;
    tokensToRemove: string[];
  }): Promise<void> {
    if (tokensToRemove.length === 0) {
      return;
    }

    const existingTokens = await this.getUserStoredTokens({ userId, workspaceId });
    const nextTokens = existingTokens.filter(
      (storedToken) => !tokensToRemove.includes(storedToken.token),
    );

    await this.userVarsService.set({
      userId,
      workspaceId,
      key: USER_FCM_TOKENS_KEY,
      value: nextTokens,
    });
  }

  private async getUserStoredTokens({
    userId,
    workspaceId,
  }: {
    userId: string;
    workspaceId: string;
  }): Promise<StoredFcmToken[]> {
    const storedValue = (await this.userVarsService.get({
      userId,
      workspaceId,
      key: USER_FCM_TOKENS_KEY,
    })) as unknown;

    if (!Array.isArray(storedValue)) {
      return [];
    }

    return storedValue
      .map((storedToken) => {
        if (
          typeof storedToken !== 'object' ||
          !isDefined(storedToken)
        ) {
          return null;
        }

        const parsedToken = storedToken as Record<string, unknown>;

        if (
          typeof parsedToken.deviceId !== 'string' ||
          typeof parsedToken.token !== 'string' ||
          typeof parsedToken.updatedAt !== 'string'
        ) {
          return null;
        }

        return {
          deviceId: parsedToken.deviceId,
          token: parsedToken.token,
          updatedAt: parsedToken.updatedAt,
        };
      })
      .filter(isDefined);
  }
}
