import { useEffect, useRef } from 'react';
import { useRecoilValue } from 'recoil';

import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { type FieldMetadataItem } from '@/object-metadata/types/FieldMetadataItem';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import {
  getLeadAssigneeIdFromRecord,
  isAssignedSalespersonViewingLead,
  isReadAtValueEmpty,
} from '@/object-record/utils/lead-read-at.utils';

type UseMarkLeadReadAtOnViewParams = {
  objectNameSingular: string;
  objectRecordId: string;
  record: ObjectRecord | null | undefined;
  objectMetadataFields: FieldMetadataItem[];
  isRecordLoading?: boolean;
};

export const useMarkLeadReadAtOnView = ({
  objectNameSingular,
  objectRecordId,
  record,
  objectMetadataFields,
  isRecordLoading = false,
}: UseMarkLeadReadAtOnViewParams) => {
  const { updateOneRecord } = useUpdateOneRecord();
  const hasMarkedReadAtRef = useRef(false);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);

  useEffect(() => {
    hasMarkedReadAtRef.current = false;
  }, [objectNameSingular, objectRecordId]);

  useEffect(() => {
    if (
      objectNameSingular !== 'lead' ||
      isRecordLoading ||
      !record ||
      hasMarkedReadAtRef.current
    ) {
      return;
    }

    const hasReadAtField = objectMetadataFields.some(
      (field) => field.name === 'readAt',
    );

    if (!hasReadAtField) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    const typedRecord = record as ObjectRecord & Record<string, unknown>;

    if (!isReadAtValueEmpty(typedRecord.readAt)) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    const leadAssigneeId = getLeadAssigneeIdFromRecord(typedRecord);
    const currentMemberId = currentWorkspaceMember?.id ?? null;

    if (
      !isAssignedSalespersonViewingLead({
        leadAssigneeId,
        currentMemberId,
      })
    ) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    hasMarkedReadAtRef.current = true;

    void updateOneRecord({
      idToUpdate: objectRecordId,
      objectNameSingular,
      updateOneRecordInput: {
        readAt: new Date().toISOString(),
      },
    });
  }, [
    currentWorkspaceMember,
    isRecordLoading,
    objectMetadataFields,
    objectNameSingular,
    objectRecordId,
    record,
    updateOneRecord,
  ]);
};
