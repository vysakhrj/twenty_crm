import {
  Body,
  Controller,
  Get,
  Logger,
  Param,
  Patch,
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
  body?: string;
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

export type UpdateSalesAvailabilityDto = {
  availabilityStartTime?: string;
  availabilityEndTime?: string;
  availableDays?: string[];
};

export type UpdateSalesLeaveDto = {
  leaveDate?: string;
  leaveStartDate?: string;
  leaveEndDate?: string;
  clearLeave?: boolean;
};

@Controller('api/lead/create-with-person')
@UseGuards(JwtAuthGuard, WorkspaceAuthGuard, CustomPermissionGuard)
@UseFilters(RestApiExceptionFilter)
export class LeadWebhookController {
  private readonly logger = new Logger(LeadWebhookController.name);

  constructor(private readonly leadWebhookService: LeadWebhookService) {}

  private getWorkspaceIdOrThrow(request: AuthenticatedRequest): string {
    if (!request.workspaceId) {
      throw new Error('workspaceId is required in the request');
    }

    return request.workspaceId;
  }

  @Get('sales-users/status')
  async getSalesUsersStatus(@Req() request: AuthenticatedRequest, @Res() res: Response) {
    const workspaceId = this.getWorkspaceIdOrThrow(request);

    const salesUsers = await this.leadWebhookService.getSalesUsersStatus(
      workspaceId,
      request,
    );

    res.status(200).send({ data: salesUsers });
  }

  @Patch('sales-users/:workspaceMemberId/availability')
  async updateSalesAvailability(
    @Param('workspaceMemberId') workspaceMemberId: string,
    @Body() body: UpdateSalesAvailabilityDto,
    @Req() request: AuthenticatedRequest,
    @Res() res: Response,
  ) {
    const workspaceId = this.getWorkspaceIdOrThrow(request);

    const result = await this.leadWebhookService.updateSalesAvailability(
      workspaceId,
      workspaceMemberId,
      body,
      request,
    );

    res.status(200).send({ data: result });
  }

  @Patch('sales-users/:workspaceMemberId/leave')
  async updateSalesLeave(
    @Param('workspaceMemberId') workspaceMemberId: string,
    @Body() body: UpdateSalesLeaveDto,
    @Req() request: AuthenticatedRequest,
    @Res() res: Response,
  ) {
    const workspaceId = this.getWorkspaceIdOrThrow(request);

    const result = await this.leadWebhookService.updateSalesLeave(
      workspaceId,
      workspaceMemberId,
      body,
      request,
    );

    res.status(200).send({ data: result });
  }

  // Returns 503 only when no assignee is available:
  // - If sales roles exist: tries available sales members first, then available managers.
  // - If none exist: tries any available workspace members.
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
