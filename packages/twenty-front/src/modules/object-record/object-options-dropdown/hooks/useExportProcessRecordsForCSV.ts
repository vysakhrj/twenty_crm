import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useObjectMetadataItems } from '@/object-metadata/hooks/useObjectMetadataItems';
import { getLabelIdentifierFieldMetadataItem } from '@/object-metadata/utils/getLabelIdentifierFieldMetadataItem';
import { getLabelIdentifierFieldValue } from '@/object-metadata/utils/getLabelIdentifierFieldValue';
import { type FieldCurrencyValue } from '@/object-record/record-field/ui/types/FieldMetadata';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { computeMorphRelationFieldName, isDefined } from 'twenty-shared/utils';
import { FieldMetadataType, RelationType } from '~/generated-metadata/graphql';
import { convertCurrencyMicrosToCurrencyAmount } from '~/utils/convertCurrencyToCurrencyMicros';
import { formatDateISOStringToUnifiedDateTime, formatDateISOStringToUnifiedDate } from '@/localization/utils/formatDateISOStringToUnified';

export const useExportProcessRecordsForCSV = (objectNameSingular: string) => {
  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular,
  });
  const { objectMetadataItems } = useObjectMetadataItems();

  const processRecordsForCSVExport = (records: ObjectRecord[]) => {
    if (!isDefined(objectMetadataItem)) {
      return records;
    }

    return records.map((record) =>
      objectMetadataItem.fields.reduce<ObjectRecord>(
        (processedRecord, field) => {
          if (
            !isDefined(record[field.name]) &&
            field.type !== FieldMetadataType.RELATION &&
            field.type !== FieldMetadataType.MORPH_RELATION
          ) {
            return processedRecord;
          }

          switch (field.type) {
            case FieldMetadataType.CURRENCY:
              return {
                ...processedRecord,
                [field.name]: {
                  amountMicros: convertCurrencyMicrosToCurrencyAmount(
                    record[field.name].amountMicros,
                  ),
                  currencyCode: record[field.name].currencyCode,
                } satisfies FieldCurrencyValue,
              } as ObjectRecord;
            case FieldMetadataType.MULTI_SELECT:
            case FieldMetadataType.ARRAY:
            case FieldMetadataType.RAW_JSON:
              return {
                ...processedRecord,
                [field.name]: JSON.stringify(record[field.name]),
              } as ObjectRecord;
            case FieldMetadataType.DATE:
              return {
                ...processedRecord,
                [field.name]: formatDateISOStringToUnifiedDate(record[field.name]),
              } as ObjectRecord;
            case FieldMetadataType.DATE_TIME:
              return {
                ...processedRecord,
                [field.name]: formatDateISOStringToUnifiedDateTime(record[field.name]),
              } as ObjectRecord;
            case FieldMetadataType.RELATION:
              if (field.relation?.type === RelationType.MANY_TO_ONE) {
                const relationRecord = record[field.name];
                const targetObjectMetadata = objectMetadataItems.find(
                  (item) =>
                    item.id === field.relation?.targetObjectMetadata?.id,
                );
                const labelIdentifier =
                  targetObjectMetadata &&
                  getLabelIdentifierFieldMetadataItem(targetObjectMetadata);
                const displayName =
                  relationRecord && isDefined(labelIdentifier)
                    ? getLabelIdentifierFieldValue(
                        relationRecord as ObjectRecord,
                        labelIdentifier,
                      )
                    : '';
                const { [field.name + 'Id']: _removedId, ...rest } =
                  processedRecord;
                return {
                  ...rest,
                  [field.name]: displayName.trim(),
                } as ObjectRecord;
              }
              return processedRecord;
            case FieldMetadataType.ACTOR:
              if (
                isDefined(record[field.name]) &&
                typeof record[field.name] === 'object'
              ) {
                const actorValue = record[field.name] as {
                  name?: string;
                  workspaceMemberId?: string | null;
                };
                const memberName = actorValue.name ?? '';
                return {
                  ...processedRecord,
                  [field.name]: {
                    ...processedRecord[field.name],
                    workspaceMemberId: memberName.trim(),
                  },
                } as ObjectRecord;
              }
              return processedRecord;
            case FieldMetadataType.MORPH_RELATION:
              if (
                field.settings?.relationType === RelationType.MANY_TO_ONE &&
                isDefined(field.morphRelations)
              ) {
                const morphRelationType = field.settings.relationType;
                let displayName = '';
                const idsToRemove: string[] = [];
                for (const morphRelation of field.morphRelations) {
                  const gqlField = computeMorphRelationFieldName({
                    fieldName: field.name,
                    relationType: morphRelationType,
                    targetObjectMetadataNameSingular:
                      morphRelation.targetObjectMetadata.nameSingular,
                    targetObjectMetadataNamePlural:
                      morphRelation.targetObjectMetadata.namePlural,
                  });
                  const morphRecord = record[gqlField];
                  if (morphRecord && typeof morphRecord === 'object' && 'name' in morphRecord) {
                    displayName = String((morphRecord as { name?: string }).name ?? '').trim();
                    if (displayName) break;
                  }
                  idsToRemove.push(`${gqlField}Id`);
                }
                const rest = { ...processedRecord };
                for (const idKey of idsToRemove) {
                  delete rest[idKey];
                }
                return {
                  ...rest,
                  [field.name]: displayName,
                } as ObjectRecord;
              }
              return processedRecord;
            default:
              return processedRecord;
          }
        },
        record as ObjectRecord,
      ),
    );
  };

  return { processRecordsForCSVExport };
};
