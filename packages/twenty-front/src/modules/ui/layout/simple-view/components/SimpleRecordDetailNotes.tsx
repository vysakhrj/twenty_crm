import styled from '@emotion/styled';
import { useCallback } from 'react';
import { useDebouncedCallback } from 'use-debounce';

import { FormRichTextV2FieldInput } from '@/object-record/record-field/ui/form-types/components/FormRichTextV2FieldInput';
import { type FieldRichTextV2Value } from '@/object-record/record-field/ui/types/FieldMetadata';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { FieldMetadataType } from 'twenty-shared/types';

const StyledSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
`;

const StyledSectionTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  margin: 0;
  padding-bottom: ${({ theme }) => theme.spacing(2)};
`;

const RICH_TEXT_V2_FIELD_NAMES = ['notes', 'bodyV2'];

export const SimpleRecordDetailNotes = ({
  objectMetadataItem,
  objectNameSingular,
  objectRecordId,
  record,
}: {
  objectMetadataItem: ObjectMetadataItem;
  objectNameSingular: string;
  objectRecordId: string;
  record: ObjectRecord;
}) => {
  const { updateOneRecord } = useUpdateOneRecord();

  const richTextV2Field = objectMetadataItem.fields.find(
    (field) =>
      field.isActive &&
      field.type === FieldMetadataType.RICH_TEXT_V2 &&
      RICH_TEXT_V2_FIELD_NAMES.includes(field.name),
  );

  if (!richTextV2Field) {
    return null;
  }

  const fieldValue = (record[richTextV2Field.name] as
    | FieldRichTextV2Value
    | null
    | undefined) ?? undefined;

  const debouncedUpdate = useDebouncedCallback(
    (value: FieldRichTextV2Value) => {
      updateOneRecord({
        idToUpdate: objectRecordId,
        objectNameSingular,
        updateOneRecordInput: {
          [richTextV2Field.name]: value,
        },
      });
    },
    500,
  );

  const handleChange = useCallback(
    (value: FieldRichTextV2Value) => {
      debouncedUpdate(value);
    },
    [debouncedUpdate],
  );

  return (
    <StyledSection>
      <StyledSectionTitle>{richTextV2Field.label}</StyledSectionTitle>
      <FormRichTextV2FieldInput
        key={objectRecordId}
        defaultValue={fieldValue}
        onChange={handleChange}
        placeholder="Enter text or type '/' for commands"
        variant="inline"
      />
    </StyledSection>
  );
};
