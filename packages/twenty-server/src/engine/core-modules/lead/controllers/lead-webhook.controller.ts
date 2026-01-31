import {
  Body,
  Controller,
  Logger,
  Post,
  Req,
  Res,
  UseFilters,
  UseGuards,
} from '@nestjs/common';
import { Response } from 'express';

import { RestApiExceptionFilter } from 'src/engine/api/rest/rest-api-exception.filter';
import { AuthenticatedRequest } from 'src/engine/api/rest/types/authenticated-request';
import { CustomPermissionGuard } from 'src/engine/guards/custom-permission.guard';
import { JwtAuthGuard } from 'src/engine/guards/jwt-auth.guard';
import { WorkspaceAuthGuard } from 'src/engine/guards/workspace-auth.guard';
import { LeadWebhookService } from '../services/lead-webhook.service';

export type CreateLeadWithPersonDto = {
  // Lead fields
  title: string;
  body?: string;
  status?: string;
  dueDate?: string;
  // Origin tracking (e.g., "website", "zapier", "meta_instagram", "meta_facebook", "google_ads")
  origin?: string;
  // Property linking (optional - pass existing property ID)
  propertyId?: string;
  // Person fields (all optional)
  person?: {
    name?: {
      firstName?: string;
      lastName?: string;
    };
    emails?: Array<{
      email: string;
      type?: string;
    }>;
    phones?: Array<{
      number: string;
      type?: string;
    }>;
    jobTitle?: string;
    city?: string;
    linkedin?: string;
    intro?: string;
    performanceRating?: number;
    whatsapp?: Array<{
      number: string;
      type?: string;
    }>;
    workPreference?: string[];
  };
};

@Controller('api/lead/create-with-person')
@UseGuards(JwtAuthGuard, WorkspaceAuthGuard, CustomPermissionGuard)
@UseFilters(RestApiExceptionFilter)
export class LeadWebhookController {
  private readonly logger = new Logger(LeadWebhookController.name);

  constructor(private readonly leadWebhookService: LeadWebhookService) {}

  @Post()
  async createLeadWithPerson(
    @Body() body: CreateLeadWithPersonDto,
    @Req() request: AuthenticatedRequest,
    @Res() res: Response,
  ) {
    this.logger.log(
      `[Lead Webhook] Creating lead with person on workspace ${request.workspaceId}`,
    );

    try {
      const result = await this.leadWebhookService.createLeadWithPerson(
        body,
        request,
      );

      res.status(201).send({
        data: {
          lead: result.lead,
          person: result.person,
          taskTarget: result.taskTarget,
          origin: result.origin,
        },
        debug: result.debug,
      });
    } catch (error) {
      this.logger.error('Failed to create lead with person', error);
      throw error;
    }
  }
}
