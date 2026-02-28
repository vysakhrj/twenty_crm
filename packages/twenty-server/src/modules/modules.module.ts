import { Module } from '@nestjs/common';

import { AssigneeViewManagerModule } from 'src/modules/assignee-view-manager/assignee-view-manager.module';
import { CalendarModule } from 'src/modules/calendar/calendar.module';
import { ConnectedAccountModule } from 'src/modules/connected-account/connected-account.module';
import { FavoriteFolderModule } from 'src/modules/favorite-folder/favorite-folder.module';
import { FavoriteModule } from 'src/modules/favorite/favorite.module';
import { LeadAssignmentNotificationModule } from 'src/modules/lead-assignment-notification/lead-assignment-notification.module';
import { MessagingModule } from 'src/modules/messaging/messaging.module';
import { WorkflowModule } from 'src/modules/workflow/workflow.module';

@Module({
  imports: [
    AssigneeViewManagerModule,
    MessagingModule,
    CalendarModule,
    ConnectedAccountModule,
    WorkflowModule,
    FavoriteFolderModule,
    FavoriteModule,
    LeadAssignmentNotificationModule,
  ],
  providers: [],
  exports: [],
})
export class ModulesModule {}
