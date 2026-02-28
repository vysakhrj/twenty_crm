import { Logger } from '@nestjs/common';

import { Command, CommandRunner } from 'nest-commander';

import {
  SEED_APPLE_WORKSPACE_ID,
  SEED_YCOMBINATOR_WORKSPACE_ID,
} from 'src/engine/workspace-manager/dev-seeder/core/constants/seeder-workspaces.constant';
import { DevSeederService } from 'src/engine/workspace-manager/dev-seeder/services/dev-seeder.service';
@Command({
  name: 'workspace:seed:dev',
  description:
    'Seed workspace with initial data. This command is intended for development only.',
})
export class DataSeedWorkspaceCommand extends CommandRunner {
  workspaceIds = [
    SEED_APPLE_WORKSPACE_ID,
    SEED_YCOMBINATOR_WORKSPACE_ID,
  ] as const;
  private readonly logger = new Logger(DataSeedWorkspaceCommand.name);

  constructor(private readonly devSeederService: DevSeederService) {
    super();
  }

  async run(): Promise<void> {
    try {
      for (const workspaceId of this.workspaceIds) {
        await this.devSeederService.seedDev(workspaceId);
      }
    } catch (error: unknown) {
      this.logger.error(error);
      if (error instanceof Error) {
        this.logger.error(error.stack);
      }
      const err = error as {
        errors?: { metadata?: Error; workspaceSchema?: Error };
        failedWorkspaceMigrationBuildResult?: unknown;
      };
      if (err.errors) {
        if (err.errors.metadata) {
          this.logger.error('Underlying metadata error:', err.errors.metadata);
          this.logger.error(err.errors.metadata.stack);
        }
        if (err.errors.workspaceSchema) {
          this.logger.error(
            'Underlying workspaceSchema error:',
            err.errors.workspaceSchema,
          );
          this.logger.error(err.errors.workspaceSchema.stack);
        }
      }
      if (err.failedWorkspaceMigrationBuildResult) {
        this.logger.error(
          'Validation report:',
          JSON.stringify(err.failedWorkspaceMigrationBuildResult, null, 2),
        );
      }
    }
  }
}
