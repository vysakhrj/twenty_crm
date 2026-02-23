import { useCurrentUserRole } from '@/auth/hooks/useCurrentUserRole';
import { contextStoreCurrentViewIdComponentState } from '@/context-store/states/contextStoreCurrentViewIdComponentState';
import { currentRecordFiltersComponentState } from '@/object-record/record-filter/states/currentRecordFiltersComponentState';
import { type RecordFilter } from '@/object-record/record-filter/types/RecordFilter';
import { useRecordIndexContextOrThrow } from '@/object-record/record-index/contexts/RecordIndexContext';
import { useRecoilComponentFamilyState } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentFamilyState';
import { useRecoilComponentState } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentState';
import { useRecoilComponentValue } from '@/ui/utilities/state/component-state/hooks/useRecoilComponentValue';
import { hasInitializedCurrentRecordFiltersComponentFamilyState } from '@/views/states/hasInitializedCurrentRecordFiltersComponentFamilyState';
import { useEffect, useRef } from 'react';
import { ViewFilterOperand } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import { v4 } from 'uuid';

export const RoleBasedRecordFilterEffect = () => {
  const { objectMetadataItem } = useRecordIndexContextOrThrow();
  const { currentWorkspaceMemberId, getObjectPermissions } =
    useCurrentUserRole();

  const [currentRecordFilters, setCurrentRecordFilters] =
    useRecoilComponentState(currentRecordFiltersComponentState);

  // Get current view ID to track view changes
  const currentViewId = useRecoilComponentValue(
    contextStoreCurrentViewIdComponentState,
  );

  // Check if view filters have been initialized
  const [hasInitializedCurrentRecordFilters] = useRecoilComponentFamilyState(
    hasInitializedCurrentRecordFiltersComponentFamilyState,
    {
      viewId: currentViewId ?? undefined,
    },
  );

  // Track if we've applied the filter for the current view
  const appliedForViewId = useRef<string | null>(null);

  // Get permissions for the current object
  const objectPermissions = getObjectPermissions(objectMetadataItem.id);
  const canReadOwnObjectRecordsOnly =
    objectPermissions?.canReadOwnObjectRecordsOnly ?? false;

  useEffect(() => {
    // Apply for Task and Lead objects for members who should see their own records only
    const supportedObjects = ['task', 'lead'];
    if (!supportedObjects.includes(objectMetadataItem.nameSingular)) {
      return;
    }

    if (!canReadOwnObjectRecordsOnly) {
      return;
    }

    if (!isDefined(currentWorkspaceMemberId)) {
      return;
    }

    if (!isDefined(currentViewId)) {
      return;
    }

    // Wait for view filters to be initialized first
    if (!hasInitializedCurrentRecordFilters) {
      return;
    }

    // Don't re-apply if already applied for this view
    if (appliedForViewId.current === currentViewId) {
      // But check if the filter still exists (might have been removed by view change)
      const assigneeField = objectMetadataItem.fields.find(
        (field) => field.name === 'assignee',
      );
      if (isDefined(assigneeField)) {
        const existingAssigneeFilter = currentRecordFilters.find(
          (filter) => filter.fieldMetadataId === assigneeField.id,
        );
        // If filter exists, we're good
        if (isDefined(existingAssigneeFilter)) {
          return;
        }
      }
    }

    // Find the assignee field
    const assigneeField = objectMetadataItem.fields.find(
      (field) => field.name === 'assignee',
    );

    if (!isDefined(assigneeField)) {
      return;
    }

    // Check if assignee filter already exists
    const existingAssigneeFilter = currentRecordFilters.find(
      (filter) => filter.fieldMetadataId === assigneeField.id,
    );

    if (isDefined(existingAssigneeFilter)) {
      // Mark as applied for this view
      appliedForViewId.current = currentViewId;
      return;
    }

    // Create the "assignee is me" filter
    const assigneeFilter: RecordFilter = {
      id: v4(),
      fieldMetadataId: assigneeField.id,
      value: JSON.stringify({
        isCurrentWorkspaceMemberSelected: true,
        selectedRecordIds: [currentWorkspaceMemberId],
      }),
      displayValue: 'Me',
      type: 'RELATION',
      operand: ViewFilterOperand.IS,
      label: 'Assignee',
    };

    setCurrentRecordFilters([...currentRecordFilters, assigneeFilter]);
    appliedForViewId.current = currentViewId;
  }, [
    objectMetadataItem,
    canReadOwnObjectRecordsOnly,
    currentWorkspaceMemberId,
    currentRecordFilters,
    setCurrentRecordFilters,
    currentViewId,
    hasInitializedCurrentRecordFilters,
  ]);

  // Reset when changing objects
  useEffect(() => {
    return () => {
      appliedForViewId.current = null;
    };
  }, [objectMetadataItem.id]);

  return null;
};
