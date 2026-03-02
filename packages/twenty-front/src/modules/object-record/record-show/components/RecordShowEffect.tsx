import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useObjectMetadataItems } from '@/object-metadata/hooks/useObjectMetadataItems';
import { CoreObjectNameSingular } from '@/object-metadata/types/CoreObjectNameSingular';
import { useFindOneRecord } from '@/object-record/hooks/useFindOneRecord';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { buildFindOneRecordForShowPageOperationSignature } from '@/object-record/record-show/graphql/operations/factories/findOneRecordForShowPageOperationSignatureFactory';
import { recordStoreFamilyState } from '@/object-record/record-store/states/recordStoreFamilyState';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { useEffect, useRef } from 'react';
import { useRecoilCallback, useRecoilValue } from 'recoil';
import { isDefined } from 'twenty-shared/utils';

type RecordShowEffectProps = {
  objectNameSingular: string;
  recordId: string;
};

export const RecordShowEffect = ({
  objectNameSingular,
  recordId,
}: RecordShowEffectProps) => {
  const { updateOneRecord } = useUpdateOneRecord();
  const hasMarkedReadAtRef = useRef(false);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);
  const { objectMetadataItem } = useObjectMetadataItem({ objectNameSingular });
  const { objectMetadataItems } = useObjectMetadataItems();

  const FIND_ONE_RECORD_FOR_SHOW_PAGE_OPERATION_SIGNATURE =
    buildFindOneRecordForShowPageOperationSignature({
      objectMetadataItem,
      objectMetadataItems,
    });

  const { record, loading } = useFindOneRecord({
    objectRecordId: recordId,
    objectNameSingular,
    recordGqlFields: FIND_ONE_RECORD_FOR_SHOW_PAGE_OPERATION_SIGNATURE.fields,
    withSoftDeleted: true,
  });

  const setRecordStore = useRecoilCallback(
    ({ snapshot, set }) =>
      async (newRecord: ObjectRecord | null | undefined) => {
        const previousRecordValue = snapshot
          .getLoadable(recordStoreFamilyState(recordId))
          .getValue();

        if (JSON.stringify(previousRecordValue) !== JSON.stringify(newRecord)) {
          set(recordStoreFamilyState(recordId), newRecord);
        }
      },
    [recordId],
  );

  useEffect(() => {
    if (!loading && isDefined(record)) {
      setRecordStore(record);
    }
  }, [record, setRecordStore, loading]);

  useEffect(() => {
    hasMarkedReadAtRef.current = false;
  }, [objectNameSingular, recordId]);

  useEffect(() => {
    if (
      objectNameSingular !== CoreObjectNameSingular.Lead ||
      loading ||
      !isDefined(record) ||
      hasMarkedReadAtRef.current
    ) {
      return;
    }

    const hasReadAtField = objectMetadataItem.fields.some(
      (field) => field.name === 'readAt',
    );

    if (!hasReadAtField) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    const recordReadAt = (record as ObjectRecord & { readAt?: string | null })
      .readAt;
    const assigneeId = (
      record as ObjectRecord & {
        assigneeId?: string | null;
        assignee?: { id?: string | null } | null;
      }
    ).assigneeId;
    const assigneeRelationId = (
      record as ObjectRecord & {
        assignee?: { id?: string | null } | null;
      }
    ).assignee?.id;
    const leadAssigneeId = assigneeId ?? assigneeRelationId ?? null;
    const currentMemberId = currentWorkspaceMember?.id ?? null;

    if (
      isDefined(leadAssigneeId) &&
      leadAssigneeId !== '' &&
      isDefined(currentMemberId) &&
      currentMemberId !== '' &&
      currentMemberId !== leadAssigneeId
    ) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    if (isDefined(recordReadAt) && recordReadAt !== '') {
      hasMarkedReadAtRef.current = true;
      return;
    }

    hasMarkedReadAtRef.current = true;

    void updateOneRecord({
      objectNameSingular,
      idToUpdate: recordId,
      updateOneRecordInput: {
        readAt: new Date().toISOString(),
      },
    });
  }, [
    currentWorkspaceMember,
    loading,
    objectMetadataItem.fields,
    objectNameSingular,
    record,
    recordId,
    updateOneRecord,
  ]);

  return <></>;
};
