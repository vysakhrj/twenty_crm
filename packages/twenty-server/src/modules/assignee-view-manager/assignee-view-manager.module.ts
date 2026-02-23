import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { ApplicationModule } from 'src/engine/core-modules/application/application.module';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { WorkspaceManyOrAllFlatEntityMapsCacheModule } from 'src/engine/metadata-modules/flat-entity/services/workspace-many-or-all-flat-entity-maps-cache.module';
import { WorkspaceMigrationModule } from 'src/engine/workspace-manager/workspace-migration/workspace-migration.module';
import { AssigneeViewWorkspaceMemberListener } from 'src/modules/assignee-view-manager/listeners/assignee-view-workspace-member.listener';
import { CreateAssigneeViewForWorkspaceMemberService } from 'src/modules/assignee-view-manager/services/create-assignee-view-for-workspace-member.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([WorkspaceEntity]),
    ApplicationModule,
    WorkspaceManyOrAllFlatEntityMapsCacheModule,
    WorkspaceMigrationModule,
  ],
  providers: [
    CreateAssigneeViewForWorkspaceMemberService,
    AssigneeViewWorkspaceMemberListener,
  ],
  exports: [CreateAssigneeViewForWorkspaceMemberService],
})
export class AssigneeViewManagerModule {}
