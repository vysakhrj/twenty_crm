import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { WorkspaceActivationStatus } from 'twenty-shared/workspace';
import { Repository } from 'typeorm';

import { SentryCronMonitor } from 'src/engine/core-modules/cron/sentry-cron-monitor.decorator';
import { ExceptionHandlerService } from 'src/engine/core-modules/exception-handler/exception-handler.service';
import { InjectMessageQueue } from 'src/engine/core-modules/message-queue/decorators/message-queue.decorator';
import { Process } from 'src/engine/core-modules/message-queue/decorators/process.decorator';
import { Processor } from 'src/engine/core-modules/message-queue/decorators/processor.decorator';
import { MessageQueue } from 'src/engine/core-modules/message-queue/message-queue.constants';
import { MessageQueueService } from 'src/engine/core-modules/message-queue/services/message-queue.service';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';

import {
  SendFollowUpReminderJob,
  type SendFollowUpReminderJobData,
} from '../jobs/send-follow-up-reminder.job';

// Run daily at 9 AM
export const FOLLOW_UP_REMINDER_CRON_PATTERN = '0 9 * * *';

@Injectable()
@Processor(MessageQueue.cronQueue)
export class FollowUpReminderCronJob {
  private readonly logger = new Logger(FollowUpReminderCronJob.name);

  constructor(
    @InjectRepository(WorkspaceEntity)
    private readonly workspaceRepository: Repository<WorkspaceEntity>,
    @InjectMessageQueue(MessageQueue.workspaceQueue)
    private readonly messageQueueService: MessageQueueService,
    private readonly exceptionHandlerService: ExceptionHandlerService,
  ) {}

  @Process(FollowUpReminderCronJob.name)
  @SentryCronMonitor(
    FollowUpReminderCronJob.name,
    FOLLOW_UP_REMINDER_CRON_PATTERN,
  )
  async handle(): Promise<void> {
    const workspaces = await this.getActiveWorkspaces();

    if (workspaces.length === 0) {
      this.logger.log('No active workspaces found for follow-up reminders');

      return;
    }

    this.logger.log(
      `Enqueuing follow-up reminder jobs for ${workspaces.length} workspace(s)`,
    );

    for (const workspace of workspaces) {
      try {
        await this.messageQueueService.add<SendFollowUpReminderJobData>(
          SendFollowUpReminderJob.name,
          {
            workspaceId: workspace.id,
          },
        );
      } catch (error) {
        this.exceptionHandlerService.captureExceptions([error], {
          workspace: {
            id: workspace.id,
          },
        });
      }
    }

    this.logger.log(
      `Successfully enqueued ${workspaces.length} follow-up reminder job(s)`,
    );
  }

  private async getActiveWorkspaces(): Promise<Array<{ id: string }>> {
    const workspaces = await this.workspaceRepository.find({
      where: {
        activationStatus: WorkspaceActivationStatus.ACTIVE,
      },
      select: ['id'],
      order: { id: 'ASC' },
    });

    if (workspaces.length === 0) {
      return [];
    }

    return workspaces.map((workspace) => ({
      id: workspace.id,
    }));
  }
}
