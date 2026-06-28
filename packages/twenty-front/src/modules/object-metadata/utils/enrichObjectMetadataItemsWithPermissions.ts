import { getNonReadableFieldMetadataIdsFromObjectPermissions } from '@/object-metadata/utils/getNonReadableFieldMetadataIdsFromObjectPermissions';
import { getNonUpdatableFieldMetadataIdsFromObjectPermissions } from '@/object-metadata/utils/getNonUpdatableFieldMetadataIdsFromObjectPermissions';
import { getObjectPermissionsFromMapByObjectMetadataId } from '@/settings/roles/role-permissions/objects-permissions/utils/getObjectPermissionsFromMapByObjectMetadataId';
import { isAutoManagedFieldReadOnly } from '@/object-record/utils/isAutoManagedFieldReadOnly';
import { type ObjectPermissions } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';

type enrichObjectMetadataItemsWithPermissionsArgs = {
  objectMetadataItems: Omit<
    ObjectMetadataItem,
    'readableFields' | 'updatableFields'
  >[];
  objectPermissionsByObjectMetadataId: Record<
    string,
    ObjectPermissions & { objectMetadataId: string }
  >;
};

export const enrichObjectMetadataItemsWithPermissions = ({
  objectMetadataItems,
  objectPermissionsByObjectMetadataId,
}: enrichObjectMetadataItemsWithPermissionsArgs) => {
  const formattedObjects: ObjectMetadataItem[] =
    objectMetadataItems.map((object) => {
      const objectPermissions = getObjectPermissionsFromMapByObjectMetadataId({
        objectPermissionsByObjectMetadataId,
        objectMetadataId: object.id,
      });

      const nonReadableFieldMetadataIds = !isDefined(objectPermissions)
        ? []
        : getNonReadableFieldMetadataIdsFromObjectPermissions({
            objectPermissions: objectPermissions,
          });

      const nonUpdatableFieldMetadataIds = !isDefined(objectPermissions)
        ? []
        : getNonUpdatableFieldMetadataIdsFromObjectPermissions({
            objectPermissions: objectPermissions,
          });

      const { fields, ...objectWithoutFields } = object;

      const enrichedFields = fields.map((field) =>
        isAutoManagedFieldReadOnly(field.name)
          ? { ...field, isUIReadOnly: true }
          : field,
      );

      return {
        ...objectWithoutFields,
        fields: enrichedFields,
        readableFields: enrichedFields.filter(
          (field) => !nonReadableFieldMetadataIds.includes(field.id),
        ),
        updatableFields: enrichedFields.filter(
          (field) =>
            !nonUpdatableFieldMetadataIds.includes(field.id) &&
            !isAutoManagedFieldReadOnly(field.name),
        ),
      } satisfies ObjectMetadataItem;
    }) ?? [];

  return formattedObjects;
};
