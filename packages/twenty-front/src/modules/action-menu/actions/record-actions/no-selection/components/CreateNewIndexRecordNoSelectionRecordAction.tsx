import { Action } from '@/action-menu/actions/components/Action';
import { useContextStoreObjectMetadataItemOrThrow } from '@/context-store/hooks/useContextStoreObjectMetadataItemOrThrow';
import { useObjectPermissionsForObject } from '@/object-record/hooks/useObjectPermissionsForObject';
import { useCreateNewIndexRecord } from '@/object-record/record-table/hooks/useCreateNewIndexRecord';

export const CreateNewIndexRecordNoSelectionRecordAction = () => {
  const { objectMetadataItem } = useContextStoreObjectMetadataItemOrThrow();

  const objectPermissions = useObjectPermissionsForObject(
    objectMetadataItem.id,
  );

  const hasObjectUpdatePermissions = objectPermissions.canUpdateObjectRecords;

  const isLeadObject =
    objectMetadataItem.nameSingular.toLowerCase() === 'lead';
  // Lead creation is only allowed via webhooks, not from the UI
  if (!hasObjectUpdatePermissions || isLeadObject) {
    return null;
  }

  const { createNewIndexRecord } = useCreateNewIndexRecord({
    objectMetadataItem,
  });

  return (
    <Action
      onClick={() => createNewIndexRecord({ position: 'first' })}
      closeSidePanelOnCommandMenuListActionExecution={false}
    />
  );
};
