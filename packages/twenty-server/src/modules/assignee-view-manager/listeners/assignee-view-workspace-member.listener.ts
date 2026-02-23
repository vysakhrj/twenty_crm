import { Injectable } from '@nestjs/common';

import { InjectRepository } from '@nestjs/typeorm';

import { WorkspaceActivationStatus } from 'twenty-shared/workspace';
import { Repository } from 'typeorm';

import { type ObjectRecordCreateEvent } from 'twenty-shared/database-events';

import { OnDatabaseBatchEvent } from 'src/engine/api/graphql/graphql-query-runner/decorators/on-database-batch-event.decorator';
import { DatabaseEventAction } from 'src/engine/api/graphql/graphql-query-runner/enums/database-event-action';
import { WorkspaceEntity } from 'src/engine/core-modules/workspace/workspace.entity';
import { WorkspaceEventBatch } from 'src/engine/workspace-event-emitter/types/workspace-event-batch.type';
import { CreateAssigneeViewForWorkspaceMemberService } from 'src/modules/assignee-view-manager/services/create-assignee-view-for-workspace-member.service';
import { WorkspaceMemberWorkspaceEntity } from 'src/modules/workspace-member/standard-objects/workspace-member.workspace-entity';

type WorkspaceMemberName = {
  firstName?: string;
  lastName?: string;
};

function getMemberDisplayName(after: {
  name?: WorkspaceMemberName;
  userEmail?: string | null;
}): string {
  const name = after.name;
  if (name && (name.firstName || name.lastName)) {
    return [name.firstName, name.lastName].filter(Boolean).join(' ').trim();
  }
  if (after.userEmail) {
    return after.userEmail;
  }
  return 'Member';
}

@Injectable()
export class AssigneeViewWorkspaceMemberListener {
  constructor(
    private readonly createAssigneeViewForWorkspaceMemberService: CreateAssigneeViewForWorkspaceMemberService,
    @InjectRepository(WorkspaceEntity)
    private readonly workspaceRepository: Repository<WorkspaceEntity>,
  ) {}

  @OnDatabaseBatchEvent('workspaceMember', DatabaseEventAction.CREATED)
  async handleCreatedEvent(
    payload: WorkspaceEventBatch<
      ObjectRecordCreateEvent<WorkspaceMemberWorkspaceEntity>
    >,
  ) {
    const workspace = await this.workspaceRepository.findOneBy({
      id: payload.workspaceId,
    });

    if (
      !workspace ||
      workspace.activationStatus !== WorkspaceActivationStatus.ACTIVE
    ) {
      return;
    }

    for (const eventPayload of payload.events) {
      const after = eventPayload.properties.after;
      const workspaceMemberId = eventPayload.recordId;
      const memberDisplayName = getMemberDisplayName(after);

      await this.createAssigneeViewForWorkspaceMemberService.createAssigneeViewForWorkspaceMember(
        {
          workspaceId: payload.workspaceId,
          workspaceMemberId,
          memberDisplayName,
        },
      );
    }
  }
}
