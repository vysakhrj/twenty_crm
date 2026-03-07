import { type FieldDefinition } from '@/object-record/record-field/ui/types/FieldDefinition';
import { type FieldMetadata } from '@/object-record/record-field/ui/types/FieldMetadata';

export const isConvenientTimeField = (
  field: Pick<
    FieldDefinition<FieldMetadata>,
    'metadata' | 'type'
  >,
): boolean =>
  field.metadata?.fieldName === 'convenientTime' ||
  (field.metadata?.label?.toLowerCase().trim() ?? '') === 'convenient time';
