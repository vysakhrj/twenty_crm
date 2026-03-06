import { Injectable, Logger } from '@nestjs/common';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';

import { TwentyConfigService } from 'src/engine/core-modules/twenty-config/twenty-config.service';

export type SendLeadAssignmentPushPayload = {
  tokens: string[];
  leadId: string;
  leadName: string;
  notificationId: string;
  workspaceId: string;
};

export type SendFollowUpReminderPushPayload = {
  tokens: string[];
  leadId: string;
  leadName: string;
  notificationId: string;
  workspaceId: string;
};

export type SendNotificationPayload = {
  tokens: string[];
  title: string;
  body: string;
  type: 'lead_assigned' | 'follow_up_reminder' | 'ticket_assigned';
  metadata: Record<string, string>;
};

// OAuth2 Token Response
type OAuth2TokenResponse = {
  access_token: string;
  token_type: string;
  expires_in: number;
};

// FCM V1 API Response
type FcmV1Response = {
  name?: string;
  error?: {
    code: number;
    message: string;
    status: string;
    details?: unknown[];
  };
};

// Service Account JSON structure
type ServiceAccountCredentials = {
  type: string;
  project_id: string;
  private_key_id: string;
  private_key: string;
  client_email: string;
  client_id: string;
  auth_uri: string;
  token_uri: string;
};

@Injectable()
export class FcmPushNotificationService {
  private readonly logger = new Logger(FcmPushNotificationService.name);
  private cachedToken: string | null = null;
  private tokenExpiry: number = 0;

  constructor(private readonly twentyConfigService: TwentyConfigService) {}

  async sendLeadAssignmentPush({
    tokens,
    leadId,
    leadName,
    notificationId,
    workspaceId,
  }: SendLeadAssignmentPushPayload): Promise<string[]> {
    return this.sendNotification({
      tokens,
      title: 'New lead assigned',
      body: `${leadName} has been assigned to you`,
      type: 'lead_assigned',
      metadata: { leadId, notificationId, workspaceId },
    });
  }

  async sendFollowUpReminderPush({
    tokens,
    leadId,
    leadName,
    notificationId,
    workspaceId,
  }: SendFollowUpReminderPushPayload): Promise<string[]> {
    return this.sendNotification({
      tokens,
      title: 'Follow-up reminder',
      body: `${leadName} is due for follow-up`,
      type: 'follow_up_reminder',
      metadata: { leadId, notificationId, workspaceId },
    });
  }

  async sendNotification({
    tokens,
    title,
    body,
    type,
    metadata,
  }: SendNotificationPayload): Promise<string[]> {
    const notificationsEnabled =
      this.twentyConfigService.get('FCM_NOTIFICATIONS_ENABLED');

    if (!notificationsEnabled || tokens.length === 0) {
      return [];
    }

    // Check for service account credentials (FCM V1 API)
    const serviceAccountPath = this.twentyConfigService.get(
      'FCM_SERVICE_ACCOUNT_PATH',
    );

    if (serviceAccountPath && existsSync(serviceAccountPath)) {
      return this.sendWithV1Api(tokens, title, body, type, metadata);
    }

    // Fallback to Legacy API
    const serverKey = this.twentyConfigService.get('FCM_SERVER_KEY');
    if (serverKey) {
      return this.sendWithLegacyApi(tokens, title, body, type, metadata);
    }

    this.logger.warn(
      'FCM_NOTIFICATIONS_ENABLED but no authentication method available. ' +
        'Please set either FCM_SERVICE_ACCOUNT_PATH (V1 API) or FCM_SERVER_KEY (Legacy API)',
    );

    return [];
  }

  private async sendWithV1Api(
    tokens: string[],
    title: string,
    body: string,
    type: string,
    metadata: Record<string, string>,
  ): Promise<string[]> {
    const serviceAccountPath = this.twentyConfigService.get(
      'FCM_SERVICE_ACCOUNT_PATH',
    )!;
    const invalidTokens: string[] = [];

    try {
      // Read service account credentials
      const credentials: ServiceAccountCredentials = JSON.parse(
        readFileSync(serviceAccountPath, 'utf-8'),
      );

      // Get OAuth2 access token
      const accessToken = await this.getOAuth2Token(credentials);
      const webPushIconUrl = this.getDefaultWebPushIconUrl();

      // Send to each token individually (V1 API requires batch endpoint or individual calls)
      for (const token of tokens) {
        try {
          const response = await fetch(
            `https://fcm.googleapis.com/v1/projects/${credentials.project_id}/messages:send`,
            {
              method: 'POST',
              headers: {
                Authorization: `Bearer ${accessToken}`,
                'Content-Type': 'application/json',
              },
              body: JSON.stringify({
                message: {
                  token,
                  notification: {
                    title,
                    body,
                  },
                  data: {
                    type,
                    ...metadata,
                  },
                  android: {
                    priority: 'HIGH',
                    notification: {
                      channel_id: 'default',
                    },
                  },
                  webpush: {
                    headers: {
                      Urgency: 'high',
                    },
                    notification: {
                      ...(webPushIconUrl
                        ? {
                            icon: webPushIconUrl,
                            badge: webPushIconUrl,
                          }
                        : {}),
                      tag: metadata.notificationId || type,
                      requireInteraction: true,
                    },
                    fcm_options: {
                      link: metadata.link || '/',
                    },
                  },
                },
              }),
            },
          );

          if (!response.ok) {
            const errorData = (await response.json()) as FcmV1Response;
            const errorMessage = errorData.error?.message || 'Unknown error';

            // Check for invalid token errors
            if (
              errorMessage.includes('registration-token-not-registered') ||
              errorMessage.includes('invalid-registration') ||
              response.status === 404
            ) {
              invalidTokens.push(token);
              this.logger.debug(`Invalid token detected: ${token.slice(0, 20)}...`);
            } else {
              this.logger.warn(
                `FCM V1 API error for token ${token.slice(0, 20)}...: ${errorMessage}`,
              );
            }
          }
        } catch (error) {
          const message = error instanceof Error ? error.message : String(error);
          this.logger.warn(`Failed to send to token ${token.slice(0, 20)}...: ${message}`);
        }
      }

      return invalidTokens;
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      this.logger.error(`FCM V1 API failed: ${message}`);
      return [];
    }
  }

  private async sendWithLegacyApi(
    tokens: string[],
    title: string,
    body: string,
    type: string,
    metadata: Record<string, string>,
  ): Promise<string[]> {
    const serverKey = this.twentyConfigService.get('FCM_SERVER_KEY')!;

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
            title,
            body,
          },
          data: {
            type,
            ...metadata,
          },
        }),
      });

      if (!response.ok) {
        this.logger.warn(
          `Failed to send FCM push notification: ${response.status} ${response.statusText}`,
        );
        return [];
      }

      type FcmLegacyResponse = {
        results?: { error?: string }[];
      };

      const responseBody = (await response.json()) as FcmLegacyResponse;
      const invalidTokens: string[] = [];

      for (const [index, result] of (responseBody.results ?? []).entries()) {
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
      this.logger.warn(`Legacy FCM API failed: ${message}`);
      return [];
    }
  }

  private async getOAuth2Token(
    credentials: ServiceAccountCredentials,
  ): Promise<string> {
    // Check if we have a cached token that hasn't expired
    const now = Date.now();
    if (this.cachedToken && this.tokenExpiry > now + 60000) {
      return this.cachedToken;
    }

    try {
      // Create JWT for OAuth2
      const jwtHeader = Buffer.from(
        JSON.stringify({
          alg: 'RS256',
          typ: 'JWT',
          kid: credentials.private_key_id,
        }),
      ).toString('base64url');

      const nowSeconds = Math.floor(now / 1000);
      const jwtClaim = Buffer.from(
        JSON.stringify({
          iss: credentials.client_email,
          sub: credentials.client_email,
          scope: 'https://www.googleapis.com/auth/firebase.messaging',
          aud: credentials.token_uri,
          iat: nowSeconds,
          exp: nowSeconds + 3600, // 1 hour
        }),
      ).toString('base64url');

      // Sign JWT with private key
      const signature = await this.signJwt(
        `${jwtHeader}.${jwtClaim}`,
        credentials.private_key,
      );

      const jwt = `${jwtHeader}.${jwtClaim}.${signature}`;

      // Exchange JWT for access token
      const tokenResponse = await fetch(credentials.token_uri, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion: jwt,
        }),
      });

      if (!tokenResponse.ok) {
        throw new Error(`OAuth2 token request failed: ${tokenResponse.status}`);
      }

      const tokenData = (await tokenResponse.json()) as OAuth2TokenResponse;

      this.cachedToken = tokenData.access_token;
      this.tokenExpiry = now + tokenData.expires_in * 1000;

      return this.cachedToken;
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      throw new Error(`Failed to get OAuth2 token: ${message}`);
    }
  }

  private getDefaultWebPushIconUrl(): string | undefined {
    const frontendUrl = this.twentyConfigService.get('FRONTEND_URL');

    if (!frontendUrl) {
      return undefined;
    }

    const trimmedUrl = frontendUrl.endsWith('/')
      ? frontendUrl.slice(0, -1)
      : frontendUrl;

    return `${trimmedUrl}/favicon.ico`;
  }

  private async signJwt(data: string, privateKey: string): Promise<string> {
    // Import the private key and sign
    const encoder = new TextEncoder();
    const dataBuffer = encoder.encode(data);

    // Convert PEM to CryptoKey
    const pemHeader = '-----BEGIN PRIVATE KEY-----';
    const pemFooter = '-----END PRIVATE KEY-----';
    const pemContents = privateKey
      .replace(pemHeader, '')
      .replace(pemFooter, '')
      .replace(/\s/g, '');
    const binaryDer = Buffer.from(pemContents, 'base64');

    const cryptoKey = await crypto.subtle.importKey(
      'pkcs8',
      binaryDer,
      {
        name: 'RSASSA-PKCS1-v1_5',
        hash: 'SHA-256',
      },
      false,
      ['sign'],
    );

    const signature = await crypto.subtle.sign(
      'RSASSA-PKCS1-v1_5',
      cryptoKey,
      dataBuffer,
    );

    return Buffer.from(signature).toString('base64url');
  }
}
