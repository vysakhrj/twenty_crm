import { Injectable } from '@nestjs/common';

import { ViewFilterOperand } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import { v4 } from 'uuid';

import { ApplicationService } from 'src/engine/core-modules/application/application.service';
import { WorkspaceManyOrAllFlatEntityMapsCacheService } from 'src/engine/metadata-modules/flat-entity/services/workspace-many-or-all-flat-entity-maps-cache.service';
import { findFlatEntityByUniversalIdentifier } from 'src/engine/metadata-modules/flat-entity/utils/find-flat-entity-by-universal-identifier.util';
import { type FlatView } from 'src/engine/metadata-modules/flat-view/types/flat-view.type';
import { type FlatViewFilter } from 'src/engine/metadata-modules/flat-view-filter/types/flat-view-filter.type';
import { type FlatViewGroup } from 'src/engine/metadata-modules/flat-view-group/types/flat-view-group.type';
import { computeFlatViewGroupsOnViewCreate } from 'src/engine/metadata-modules/flat-view-group/utils/compute-flat-view-groups-on-view-create.util';
import { ViewOpenRecordIn } from 'src/engine/metadata-modules/view/enums/view-open-record-in';
import { ViewType } from 'src/engine/metadata-modules/view/enums/view-type.enum';
import { ViewVisibility } from 'src/engine/metadata-modules/view/enums/view-visibility.enum';
import { STANDARD_OBJECTS } from 'src/engine/workspace-manager/twenty-standard-application/constants/standard-object.constant';
import { WorkspaceMigrationBuilderException } from 'src/engine/workspace-manager/workspace-migration/exceptions/workspace-migration-builder-exception';
import { WorkspaceMigrationValidateBuildAndRunService } from 'src/engine/workspace-manager/workspace-migration/services/workspace-migration-validate-build-and-run-service';
import { STANDARD_OBJECT_IDS } from 'twenty-shared/metadata';

@Injectable()
export class CreateAssigneeViewForWorkspaceMemberService {
  constructor(
    private readonly applicationService: ApplicationService,
    private readonly flatEntityMapsCacheService: WorkspaceManyOrAllFlatEntityMapsCacheService,
    private readonly workspaceMigrationValidateBuildAndRunService: WorkspaceMigrationValidateBuildAndRunService,
  ) {}

  async createAssigneeViewForWorkspaceMember({
    workspaceId,
    workspaceMemberId,
    memberDisplayName,
  }: {
    workspaceId: string;
    workspaceMemberId: string;
    memberDisplayName: string;
  }): Promise<void> {
    const { workspaceCustomFlatApplication } =
      await this.applicationService.findWorkspaceTwentyStandardAndCustomApplicationOrThrow(
        { workspaceId },
      );

    const {
      flatObjectMetadataMaps,
      flatFieldMetadataMaps,
      flatViewMaps,
    } =
      await this.flatEntityMapsCacheService.getOrRecomputeManyOrAllFlatEntityMaps(
        {
          workspaceId,
          flatMapsKeys: [
            'flatObjectMetadataMaps',
            'flatFieldMetadataMaps',
            'flatViewMaps',
          ],
        },
      );

    const taskObjectMetadata = findFlatEntityByUniversalIdentifier({
      flatEntityMaps: flatObjectMetadataMaps,
      universalIdentifier: STANDARD_OBJECT_IDS.task,
    });

    if (!isDefined(taskObjectMetadata)) {
      return;
    }

    const assigneeFieldMetadata = findFlatEntityByUniversalIdentifier({
      flatEntityMaps: flatFieldMetadataMaps,
      universalIdentifier: STANDARD_OBJECTS.task.fields.assignee
        .universalIdentifier,
    });

    const statusFieldMetadata = findFlatEntityByUniversalIdentifier({
      flatEntityMaps: flatFieldMetadataMaps,
      universalIdentifier: STANDARD_OBJECTS.task.fields.status
        .universalIdentifier,
    });

    if (!isDefined(assigneeFieldMetadata) || !isDefined(statusFieldMetadata)) {
      return;
    }

    const taskViewIds = Object.values(flatViewMaps.byId)
      .filter((view) => view.objectMetadataId === taskObjectMetadata.id)
      .map((view) => view.id);

    const taskViews = taskViewIds
      .map((id) => flatViewMaps.byId[id])
      .filter(isDefined);
    const maxPosition =
      taskViews.length > 0
        ? Math.max(...taskViews.map((view) => view.position), 0) + 1
        : 0;

    const viewId = v4();
    const now = new Date().toISOString();

    const flatViewToCreate: FlatView = {
      id: viewId,
      objectMetadataId: taskObjectMetadata.id,
      workspaceId,
      name: `Assigned to ${memberDisplayName}`,
      type: ViewType.TABLE,
      key: null,
      icon: 'IconUserCircle',
      position: maxPosition,
      isCompact: false,
      isCustom: true,
      openRecordIn: ViewOpenRecordIn.SIDE_PANEL,
      shouldHideEmptyGroups: false,
      kanbanAggregateOperation: null,
      kanbanAggregateOperationFieldMetadataId: null,
      mainGroupByFieldMetadataId: statusFieldMetadata.id,
      calendarLayout: null,
      calendarFieldMetadataId: null,
      anyFieldFilterValue: null,
      visibility: ViewVisibility.WORKSPACE,
      createdByUserWorkspaceId: null,
      viewFieldIds: [],
      viewFilterIds: [],
      viewGroupIds: [],
      viewFilterGroupIds: [],
      applicationId: workspaceCustomFlatApplication.id,
      universalIdentifier: v4(),
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    };

    const flatViewGroupsToCreate = computeFlatViewGroupsOnViewCreate({
      flatViewToCreateId: viewId,
      mainGroupByFieldMetadataId: statusFieldMetadata.id,
      flatFieldMetadataMaps,
    });

    const viewFilterId = v4();
    const flatViewFilterToCreate: FlatViewFilter = {
      id: viewFilterId,
      viewId,
      fieldMetadataId: assigneeFieldMetadata.id,
      operand: ViewFilterOperand.IS,
      value: {
        selectedRecordIds: [workspaceMemberId],
      },
      viewFilterGroupId: null,
      positionInViewFilterGroup: null,
      subFieldName: null,
      workspaceId,
      applicationId: workspaceCustomFlatApplication.id,
      universalIdentifier: v4(),
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
    };

    const validateAndBuildResult =
      await this.workspaceMigrationValidateBuildAndRunService.validateBuildAndRunWorkspaceMigration(
        {
          allFlatEntityOperationByMetadataName: {
            view: {
              flatEntityToCreate: [flatViewToCreate],
              flatEntityToDelete: [],
              flatEntityToUpdate: [],
            },
            viewGroup: {
              flatEntityToCreate: flatViewGroupsToCreate,
              flatEntityToDelete: [],
              flatEntityToUpdate: [],
            },
            viewFilter: {
              flatEntityToCreate: [flatViewFilterToCreate],
              flatEntityToDelete: [],
              flatEntityToUpdate: [],
            },
          },
          workspaceId,
          isSystemBuild: true,
        },
      );

    if (isDefined(validateAndBuildResult)) {
      throw new WorkspaceMigrationBuilderException(
        validateAndBuildResult,
        'Failed to create assignee view for workspace member',
      );
    }
  }
}
