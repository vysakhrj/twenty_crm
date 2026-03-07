import { useContext } from 'react';
import { useRecoilState } from 'recoil';

import { FieldContext } from '@/object-record/record-field/ui/contexts/FieldContext';
import { useRecordFieldInput } from '@/object-record/record-field/ui/hooks/useRecordFieldInput';
import { recordStoreFamilySelector } from '@/object-record/record-store/states/selectors/recordStoreFamilySelector';

export const useConvenientTimeField = () => {
  const { recordId, fieldDefinition, clearable } = useContext(FieldContext);

  const fieldName = fieldDefinition.metadata.fieldName;

  const [fieldValue, setFieldValue] = useRecoilState<string | undefined>(
    recordStoreFamilySelector({
      recordId,
      fieldName,
    }),
  );

  const { setDraftValue } = useRecordFieldInput<string | null>();

  const stringValue =
    typeof fieldValue === 'string' ? fieldValue : undefined;

  return {
    fieldDefinition,
    fieldValue: stringValue ?? '',
    setDraftValue,
    setFieldValue,
    clearable,
  };
};
