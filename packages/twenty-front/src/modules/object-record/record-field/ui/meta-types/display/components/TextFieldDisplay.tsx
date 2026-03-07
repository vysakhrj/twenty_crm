import { useMemo } from 'react';

import { formatDateISOStringToUnifiedDateTime } from '@/localization/utils/formatDateISOStringToUnified';
import { useTextFieldDisplay } from '@/object-record/record-field/ui/meta-types/hooks/useTextFieldDisplay';
import { isFieldText } from '@/object-record/record-field/ui/types/guards/isFieldText';
import { TextDisplay } from '@/ui/field/display/components/TextDisplay';

const formatConvenientTimeIfDate = (raw: string): string => {
  const trimmed = raw.trim();
  if (!trimmed) return raw;
  const formatted = formatDateISOStringToUnifiedDateTime(trimmed);
  return formatted || raw;
};

const isConvenientTimeField = (
  fieldName: string,
  fieldLabel: string | undefined,
): boolean =>
  fieldName === 'convenientTime' ||
  (fieldLabel?.toLowerCase().trim() ?? '') === 'convenient time';

export const TextFieldDisplay = () => {
  const { fieldValue, fieldDefinition, displayedMaxRows } =
    useTextFieldDisplay();

  const displayedMaxRowsFromSettings = isFieldText(fieldDefinition)
    ? fieldDefinition.metadata?.settings?.displayedMaxRows
    : undefined;

  const displayMaxRowCalculated = displayedMaxRows
    ? displayedMaxRows
    : displayedMaxRowsFromSettings;

  const displayText = useMemo(() => {
    if (!isConvenientTimeField(fieldDefinition.metadata.fieldName, fieldDefinition.metadata.label)) {
      return fieldValue ?? '';
    }
    const value = (fieldValue ?? '').trim();
    if (!value) return value;
    return formatConvenientTimeIfDate(value);
  }, [fieldValue, fieldDefinition.metadata.fieldName, fieldDefinition.metadata.label]);

  return (
    <TextDisplay text={displayText} displayedMaxRows={displayMaxRowCalculated} />
  );
};
