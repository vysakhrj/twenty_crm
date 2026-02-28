import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { CoreCommonApiModule } from 'src/engine/api/common/core-common-api.module';
import { AuthModule } from 'src/engine/core-modules/auth/auth.module';
import { RecordCrudModule } from 'src/engine/core-modules/record-crud/record-crud.module';
import { UserWorkspaceEntity } from 'src/engine/core-modules/user-workspace/user-workspace.entity';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { PermissionsModule } from 'src/engine/metadata-modules/permissions/permissions.module';
import { RoleEntity } from 'src/engine/metadata-modules/role/role.entity';
import { UserRoleModule } from 'src/engine/metadata-modules/user-role/user-role.module';
import { GlobalWorkspaceDataSourceModule } from 'src/engine/twenty-orm/global-workspace-datasource/global-workspace-datasource.module';
import { WorkspaceCacheStorageModule } from 'src/engine/workspace-cache-storage/workspace-cache-storage.module';
import { LeadWebhookController } from './controllers/lead-webhook.controller';
import { LeadWebhookService } from './services/lead-webhook.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([WorkspaceEntity, RoleEntity, UserWorkspaceEntity]),
    AuthModule,
    PermissionsModule,
    UserRoleModule,
    WorkspaceCacheStorageModule,
    GlobalWorkspaceDataSourceModule,
    RecordCrudModule,
    CoreCommonApiModule,
  ],
  controllers: [LeadWebhookController],
  providers: [LeadWebhookService],
  exports: [LeadWebhookService],
})
export class LeadModule {}
