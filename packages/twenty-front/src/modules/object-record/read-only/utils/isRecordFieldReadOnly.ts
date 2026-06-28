import { type FieldMetadataItem } from '@/object-metadata/types/FieldMetadataItem';
import { isFieldMetadataReadOnlyByPermissions } from '@/object-record/read-only/utils/internal/isFieldMetadataReadOnlyByPermissions';
import { isAutoManagedFieldReadOnly } from '@/object-record/utils/isAutoManagedFieldReadOnly';
import { type ObjectPermission } from '~/generated/graphql';
import { isDefined } from 'twenty-shared/utils';

type IsRecordFieldReadOnlyParams = {
  isRecordReadOnly: boolean;
  fieldMetadataItem: Pick<FieldMetadataItem, 'id' | 'isUIReadOnly'> & {
    name?: string;
  };
  objectPermissions: ObjectPermission;
};

export const isRecordFieldReadOnly = ({
  objectPermissions,
  isRecordReadOnly,
  fieldMetadataItem,
}: IsRecordFieldReadOnlyParams) => {
  const fieldReadOnlyByPermissions = isFieldMetadataReadOnlyByPermissions({
    objectPermissions,
    fieldMetadataId: fieldMetadataItem.id,
  });

  return (
    isRecordReadOnly ||
    fieldMetadataItem.isUIReadOnly ||
    (isDefined(fieldMetadataItem.name) &&
      isAutoManagedFieldReadOnly(fieldMetadataItem.name)) ||
    fieldReadOnlyByPermissions
  );
};
