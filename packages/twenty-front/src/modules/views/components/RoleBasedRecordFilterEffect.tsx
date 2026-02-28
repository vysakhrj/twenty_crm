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

  const currentViewId = useRecoilComponentValue(
    contextStoreCurrentViewIdComponentState,
  );

  const [hasInitializedCurrentRecordFilters] = useRecoilComponentFamilyState(
    hasInitializedCurrentRecordFiltersComponentFamilyState,
    {
      viewId: currentViewId ?? undefined,
    },
  );

  const filterIdRef = useRef<string | null>(null);

  const objectPermissions = getObjectPermissions(objectMetadataItem.id);
  const canReadOwnObjectRecordsOnly =
    objectPermissions?.canReadOwnObjectRecordsOnly ?? false;

  useEffect(() => {
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

    if (!hasInitializedCurrentRecordFilters) {
      return;
    }

    const assigneeField = objectMetadataItem.fields.find(
      (field) => field.name === 'assignee',
    );

    if (!isDefined(assigneeField)) {
      return;
    }

    const existingAssigneeFilter = currentRecordFilters.find(
      (filter) => filter.fieldMetadataId === assigneeField.id,
    );

    if (isDefined(existingAssigneeFilter)) {
      filterIdRef.current = existingAssigneeFilter.id;

      return;
    }

    const newFilterId = filterIdRef.current ?? v4();

    filterIdRef.current = newFilterId;

    const assigneeFilter: RecordFilter = {
      id: newFilterId,
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
  }, [
    objectMetadataItem,
    canReadOwnObjectRecordsOnly,
    currentWorkspaceMemberId,
    currentRecordFilters,
    setCurrentRecordFilters,
    currentViewId,
    hasInitializedCurrentRecordFilters,
  ]);

  useEffect(() => {
    return () => {
      filterIdRef.current = null;
    };
  }, [objectMetadataItem.id]);

  return null;
};
