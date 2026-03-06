import { Command, CommandRunner } from 'nest-commander';

import { InjectMessageQueue } from 'src/engine/core-modules/message-queue/decorators/message-queue.decorator';
import { MessageQueue } from 'src/engine/core-modules/message-queue/message-queue.constants';
import { MessageQueueService } from 'src/engine/core-modules/message-queue/services/message-queue.service';

import {
  FollowUpReminderCronJob,
  FOLLOW_UP_REMINDER_CRON_PATTERN,
} from '../crons/follow-up-reminder.cron.job';

@Command({
  name: 'cron:follow-up-reminder',
  description: 'Starts a cron job to send follow-up reminders for leads',
})
export class FollowUpReminderCronCommand extends CommandRunner {
  constructor(
    @InjectMessageQueue(MessageQueue.cronQueue)
    private readonly messageQueueService: MessageQueueService,
  ) {
    super();
  }

  async run(): Promise<void> {
    await this.messageQueueService.addCron<undefined>({
      jobName: FollowUpReminderCronJob.name,
      data: undefined,
      options: {
        repeat: {
          pattern: FOLLOW_UP_REMINDER_CRON_PATTERN,
        },
      },
    });

    // eslint-disable-next-line no-console
    console.log(
      `Follow-up reminder cron job registered with pattern: ${FOLLOW_UP_REMINDER_CRON_PATTERN}`,
    );
  }
}
