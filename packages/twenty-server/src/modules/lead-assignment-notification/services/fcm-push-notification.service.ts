import { Injectable, Logger } from '@nestjs/common';

import { TwentyConfigService } from 'src/engine/core-modules/twenty-config/twenty-config.service';

export type SendLeadAssignmentPushPayload = {
  tokens: string[];
  leadId: string;
  leadName: string;
  workspaceId: string;
};

type FcmResult = {
  error?: string;
};

type FcmLegacyResponse = {
  results?: FcmResult[];
};

@Injectable()
export class FcmPushNotificationService {
  private readonly logger = new Logger(FcmPushNotificationService.name);

  constructor(private readonly twentyConfigService: TwentyConfigService) {}

  async sendLeadAssignmentPush({
    tokens,
    leadId,
    leadName,
    workspaceId,
  }: SendLeadAssignmentPushPayload): Promise<string[]> {
    const notificationsEnabled =
      this.twentyConfigService.get('FCM_NOTIFICATIONS_ENABLED');

    if (!notificationsEnabled || tokens.length === 0) {
      return [];
    }

    const serverKey = this.twentyConfigService.get('FCM_SERVER_KEY');

    if (!serverKey) {
      this.logger.warn(
        'FCM_NOTIFICATIONS_ENABLED is true but FCM_SERVER_KEY is missing',
      );

      return [];
    }

    try {
      const response = await fetch('https://fcm.googleapis.com/fcm/send', {
        method: 'POST',
        headers: {
          Authorization: `key=${serverKey}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          registration_ids: tokens,
          notification: {
            title: 'New lead assigned',
            body: `${leadName} has been assigned to you`,
          },
          data: {
            type: 'lead_assigned',
            leadId,
            workspaceId,
          },
        }),
      });

      if (!response.ok) {
        this.logger.warn(
          `Failed to send FCM push notification: ${response.status} ${response.statusText}`,
        );

        return [];
      }

      const body = (await response.json()) as FcmLegacyResponse;
      const invalidTokens: string[] = [];

      for (const [index, result] of (body.results ?? []).entries()) {
        if (
          result.error === 'NotRegistered' ||
          result.error === 'InvalidRegistration'
        ) {
          invalidTokens.push(tokens[index]);
        }
      }

      return invalidTokens;
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);

      this.logger.warn(`Failed to send FCM push notification: ${message}`);

      return [];
    }
  }
}
