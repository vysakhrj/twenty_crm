import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { recordStoreFamilyState } from '@/object-record/record-store/states/recordStoreFamilyState';
import { useTargetRecord } from '@/ui/layout/contexts/useTargetRecord';
import { useRecoilValue } from 'recoil';
import { FieldMetadataType } from 'twenty-shared/types';
import styled from '@emotion/styled';

import { SimpleRecordDetailNotes } from '@/ui/layout/simple-view/components/SimpleRecordDetailNotes';

const StyledNotesSection = styled.div`
  padding-top: ${({ theme }) => theme.spacing(4)};
`;

export const RecordDetailNotesSection = () => {
  const targetRecord = useTargetRecord();
  const record = useRecoilValue(
    recordStoreFamilyState(targetRecord.id),
  );
  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular: targetRecord.targetObjectNameSingular,
  });

  const hasNotesField = objectMetadataItem.fields.some(
    (field) =>
      field.isActive &&
      field.type === FieldMetadataType.RICH_TEXT_V2 &&
      (field.name === 'notes' || field.name === 'bodyV2'),
  );

  if (!hasNotesField || !record) {
    return null;
  }

  return (
    <StyledNotesSection>
      <SimpleRecordDetailNotes
        objectMetadataItem={objectMetadataItem}
        objectNameSingular={targetRecord.targetObjectNameSingular}
        objectRecordId={targetRecord.id}
        record={record}
      />
    </StyledNotesSection>
  );
};
