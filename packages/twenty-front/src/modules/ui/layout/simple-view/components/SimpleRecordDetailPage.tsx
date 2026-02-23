import styled from '@emotion/styled';
import { useCallback, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';

import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useGenerateDepthRecordGqlFieldsFromObject } from '@/object-record/graphql/record-gql-fields/hooks/useGenerateDepthRecordGqlFieldsFromObject';
import { useFindOneRecord } from '@/object-record/hooks/useFindOneRecord';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { SimpleRecordDetailActionButtons } from '@/ui/layout/simple-view/components/SimpleRecordDetailActionButtons';
import { SimpleRecordDetailNotes } from '@/ui/layout/simple-view/components/SimpleRecordDetailNotes';
import {
  SimpleRecordDetailSection,
  type SectionField,
} from '@/ui/layout/simple-view/components/SimpleRecordDetailSection';
import { SimpleRecordDetailStageSelect } from '@/ui/layout/simple-view/components/SimpleRecordDetailStageSelect';
import { FieldMetadataType } from 'twenty-shared/types';
import { IconArrowLeft, IconCheck, IconPencil } from 'twenty-ui/display';

const StyledContainer = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  max-width: 100%;
  overflow-x: hidden;
  overflow-y: auto;
  width: 100%;
`;

const StyledHeader = styled.div`
  align-items: center;
  border-bottom: 1px solid ${({ theme }) => theme.border.color.light};
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
`;

const StyledBackButton = styled.button`
  align-items: center;
  background: none;
  border: none;
  color: ${({ theme }) => theme.color.blue};
  cursor: pointer;
  display: flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  gap: ${({ theme }) => theme.spacing(1)};
  padding: 0;

  &:hover {
    opacity: 0.8;
  }
`;

const StyledHeaderTitle = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  text-align: center;
`;

const StyledHeaderSpacer = styled.div`
  width: ${({ theme }) => theme.spacing(10)};
`;

const StyledBody = styled.div`
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(4)};
  max-width: 100%;
  padding: ${({ theme }) => theme.spacing(4)};
  padding-bottom: ${({ theme }) => theme.spacing(10)};
`;

const StyledNameRow = styled.div`
  align-items: center;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledRecordName = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.xl};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledNameInput = styled.input`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.color.blue};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.xl};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  outline: none;
  padding: ${({ theme }) => theme.spacing(1)} ${({ theme }) => theme.spacing(2)};
`;

const StyledEditButton = styled.button`
  align-items: center;
  background: none;
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.secondary};
  cursor: pointer;
  display: flex;
  flex-shrink: 0;
  padding: ${({ theme }) => theme.spacing(1)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }
`;

const StyledCreatedDate = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
  margin-top: ${({ theme }) => theme.spacing(0.5)};
`;

const StyledLoading = styled.div`
  align-items: center;
  color: ${({ theme }) => theme.font.color.tertiary};
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.md};
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(10)};
`;

const StyledDateSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
`;

const StyledDateLabel = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
  padding: ${({ theme }) => theme.spacing(1)} 0;
`;

const StyledDateInput = styled.input`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  outline: none;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  width: 100%;
  box-sizing: border-box;

  &:focus {
    border-color: ${({ theme }) => theme.color.blue};
  }
`;

const CONTACT_FIELD_TYPES = new Set([
  FieldMetadataType.EMAILS,
  FieldMetadataType.PHONES,
  FieldMetadataType.LINKS,
]);

const HIDDEN_FIELD_TYPES = new Set([
  FieldMetadataType.POSITION,
  FieldMetadataType.ACTOR,
  FieldMetadataType.TS_VECTOR,
  FieldMetadataType.RICH_TEXT,
  FieldMetadataType.RICH_TEXT_V2,
  FieldMetadataType.FILES,
  FieldMetadataType.MORPH_RELATION,
  FieldMetadataType.RAW_JSON,
]);

const SYSTEM_FIELD_NAMES = new Set([
  'id',
  'createdAt',
  'updatedAt',
  'deletedAt',
  'createdBy',
  'position',
  '__typename',
]);

const formatDate = (dateString: string): string => {
  try {
    return new Date(dateString).toLocaleDateString('en-US', {
      month: '2-digit',
      day: '2-digit',
      year: '2-digit',
      hour: 'numeric',
      minute: '2-digit',
    });
  } catch {
    return dateString;
  }
};

const toDateInputValue = (dateString: string | null | undefined): string => {
  if (!dateString) return '';
  try {
    const date = new Date(dateString);
    return date.toISOString().split('T')[0];
  } catch {
    return '';
  }
};

const formatFieldValue = (
  value: unknown,
  fieldType: FieldMetadataType,
): string => {
  if (value === null || value === undefined) return '-';

  switch (fieldType) {
    case FieldMetadataType.DATE:
    case FieldMetadataType.DATE_TIME:
      return formatDate(String(value));
    case FieldMetadataType.BOOLEAN:
      return value ? 'Yes' : 'No';
    case FieldMetadataType.CURRENCY: {
      const currency = value as {
        amountMicros?: number;
        currencyCode?: string;
      };
      if (currency.amountMicros !== undefined) {
        const amount = currency.amountMicros / 1_000_000;
        return `${currency.currencyCode ?? ''} ${amount.toLocaleString()}`.trim();
      }
      return String(value);
    }
    case FieldMetadataType.FULL_NAME: {
      const name = value as { firstName?: string; lastName?: string };
      return `${name.firstName ?? ''} ${name.lastName ?? ''}`.trim() || '-';
    }
    case FieldMetadataType.NUMBER:
    case FieldMetadataType.NUMERIC:
      return String(value);
    default:
      if (typeof value === 'object') return '-';
      return String(value);
  }
};

// Extract a display name from a related record object
const getRelatedRecordDisplayName = (
  relatedRecord: Record<string, unknown>,
): string | null => {
  if (!relatedRecord || typeof relatedRecord !== 'object') return null;

  // Try FULL_NAME composite first
  const nameField = relatedRecord.name;
  if (nameField && typeof nameField === 'object') {
    const nameObj = nameField as { firstName?: string; lastName?: string };
    const fullName =
      `${nameObj.firstName ?? ''} ${nameObj.lastName ?? ''}`.trim();
    if (fullName) return fullName;
  }

  // Try common string label fields
  for (const key of ['name', 'title', 'label', 'displayName']) {
    const val = relatedRecord[key];
    if (typeof val === 'string' && val.trim()) return val.trim();
  }

  return null;
};

const extractEmailFromRecord = (
  record: Record<string, unknown>,
): string | undefined => {
  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const obj = value as Record<string, unknown>;
      if (
        typeof obj.primaryEmail === 'string' &&
        obj.primaryEmail.includes('@')
      ) {
        return obj.primaryEmail;
      }
    }
    if (
      typeof value === 'string' &&
      value.includes('@') &&
      value.includes('.')
    ) {
      return value;
    }
  }

  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const related = value as Record<string, unknown>;
      if (related.__typename) {
        for (const relValue of Object.values(related)) {
          if (
            relValue &&
            typeof relValue === 'object' &&
            !Array.isArray(relValue)
          ) {
            const obj = relValue as Record<string, unknown>;
            if (
              typeof obj.primaryEmail === 'string' &&
              obj.primaryEmail.includes('@')
            ) {
              return obj.primaryEmail;
            }
          }
        }
      }
    }
  }

  return undefined;
};

const extractPhoneFromRecord = (
  record: Record<string, unknown>,
): string | undefined => {
  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const obj = value as Record<string, unknown>;
      if (
        typeof obj.primaryPhoneNumber === 'string' &&
        obj.primaryPhoneNumber.length > 0
      ) {
        const cc =
          typeof obj.primaryPhoneCountryCode === 'string'
            ? obj.primaryPhoneCountryCode
            : '';
        return `${cc}${obj.primaryPhoneNumber}`;
      }
    }
  }

  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const related = value as Record<string, unknown>;
      if (related.__typename) {
        for (const relValue of Object.values(related)) {
          if (
            relValue &&
            typeof relValue === 'object' &&
            !Array.isArray(relValue)
          ) {
            const obj = relValue as Record<string, unknown>;
            if (
              typeof obj.primaryPhoneNumber === 'string' &&
              obj.primaryPhoneNumber.length > 0
            ) {
              const cc =
                typeof obj.primaryPhoneCountryCode === 'string'
                  ? obj.primaryPhoneCountryCode
                  : '';
              return `${cc}${obj.primaryPhoneNumber}`;
            }
          }
        }
      }
    }
  }

  return undefined;
};

export const SimpleRecordDetailPage = ({
  objectNameSingular,
  objectRecordId,
}: {
  objectNameSingular: string;
  objectRecordId: string;
}) => {
  const navigate = useNavigate();
  const { updateOneRecord } = useUpdateOneRecord();
  const [isEditingTitle, setIsEditingTitle] = useState(false);
  const [editedTitle, setEditedTitle] = useState('');

  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular,
  });

  // Load full relation data so we can extract emails/phones from related Person records
  const { recordGqlFields } = useGenerateDepthRecordGqlFieldsFromObject({
    objectNameSingular,
    depth: 1,
    shouldOnlyLoadRelationIdentifiers: false,
  });

  const { record, loading } = useFindOneRecord({
    objectNameSingular,
    objectRecordId,
    recordGqlFields,
  });

  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  const displayName = useMemo(() => {
    if (!record || !labelField) return '';
    const value = record[labelField.name];
    if (labelField.type === FieldMetadataType.FULL_NAME) {
      const firstName = value?.firstName ?? '';
      const lastName = value?.lastName ?? '';
      return `${firstName} ${lastName}`.trim();
    }
    return String(value ?? '');
  }, [record, labelField]);

  const primaryEmail = useMemo(() => {
    if (!record) return undefined;
    return extractEmailFromRecord(record as Record<string, unknown>);
  }, [record]);

  const primaryPhone = useMemo(() => {
    if (!record) return undefined;
    return extractPhoneFromRecord(record as Record<string, unknown>);
  }, [record]);

  // Extract relation fields (Customer, Property, etc.)
  const relationFields = useMemo((): SectionField[] => {
    if (!record) return [];
    const fields: SectionField[] = [];

    for (const fieldMeta of objectMetadataItem.fields) {
      if (!fieldMeta.isActive) continue;
      if (fieldMeta.type !== FieldMetadataType.RELATION) continue;

      const relatedRecord = record[fieldMeta.name];
      if (!relatedRecord || typeof relatedRecord !== 'object') continue;

      const relatedDisplayName = getRelatedRecordDisplayName(
        relatedRecord as Record<string, unknown>,
      );
      if (relatedDisplayName) {
        fields.push({
          label: fieldMeta.label,
          value: relatedDisplayName,
        });
      }
    }

    return fields;
  }, [record, objectMetadataItem.fields]);

  const contactFields = useMemo((): SectionField[] => {
    if (!record) return [];
    const fields: SectionField[] = [];

    if (primaryEmail) {
      fields.push({
        label: 'Email address',
        value: primaryEmail,
        href: `mailto:${primaryEmail}`,
      });
    }

    if (primaryPhone) {
      fields.push({
        label: 'Phone number',
        value: primaryPhone,
        href: `tel:${primaryPhone}`,
      });
    }

    for (const fieldMeta of objectMetadataItem.fields) {
      if (!fieldMeta.isActive || fieldMeta.isSystem) continue;
      if (fieldMeta.type === FieldMetadataType.LINKS) {
        const links = record[fieldMeta.name];
        const primaryUrl =
          links && typeof links === 'object'
            ? (links as Record<string, string>).primaryLinkUrl
            : null;
        if (primaryUrl) {
          fields.push({
            label: fieldMeta.label,
            value: primaryUrl,
            href: primaryUrl.startsWith('http')
              ? primaryUrl
              : `https://${primaryUrl}`,
          });
        }
      }
    }

    return fields;
  }, [record, objectMetadataItem.fields, primaryEmail, primaryPhone]);

  const dateFields = useMemo(() => {
    return objectMetadataItem.fields.filter(
      (field) =>
        field.isActive &&
        (field.type === FieldMetadataType.DATE ||
          field.type === FieldMetadataType.DATE_TIME) &&
        !SYSTEM_FIELD_NAMES.has(field.name),
    );
  }, [objectMetadataItem.fields]);

  const detailFields = useMemo((): SectionField[] => {
    if (!record) return [];
    const fields: SectionField[] = [];

    for (const fieldMeta of objectMetadataItem.fields) {
      if (!fieldMeta.isActive) continue;
      if (fieldMeta.isSystem && SYSTEM_FIELD_NAMES.has(fieldMeta.name)) continue;
      if (CONTACT_FIELD_TYPES.has(fieldMeta.type)) continue;
      if (HIDDEN_FIELD_TYPES.has(fieldMeta.type)) continue;
      if (fieldMeta.type === FieldMetadataType.SELECT) continue;
      if (fieldMeta.type === FieldMetadataType.DATE) continue;
      if (fieldMeta.type === FieldMetadataType.DATE_TIME) continue;
      if (fieldMeta.type === FieldMetadataType.RELATION) continue;
      if (fieldMeta.id === objectMetadataItem.labelIdentifierFieldMetadataId)
        continue;

      const value = record[fieldMeta.name];
      if (value === null || value === undefined || value === '') continue;

      const formatted = formatFieldValue(value, fieldMeta.type);
      if (formatted === '-') continue;

      fields.push({
        label: fieldMeta.label,
        value: formatted,
      });
    }

    return fields;
  }, [record, objectMetadataItem]);

  const handleBack = () => {
    navigate(`/objects/${objectMetadataItem.namePlural}`);
  };

  const handleDateChange = (fieldName: string, newValue: string) => {
    const dateValue = newValue ? new Date(newValue).toISOString() : null;
    updateOneRecord({
      idToUpdate: objectRecordId,
      objectNameSingular,
      updateOneRecordInput: {
        [fieldName]: dateValue,
      },
    });
  };

  const handleStartEditTitle = useCallback(() => {
    setEditedTitle(displayName);
    setIsEditingTitle(true);
  }, [displayName]);

  const handleSaveTitle = useCallback(() => {
    if (!labelField || !editedTitle.trim()) {
      setIsEditingTitle(false);
      return;
    }

    let updateInput: Record<string, unknown>;
    if (labelField.type === FieldMetadataType.FULL_NAME) {
      const parts = editedTitle.trim().split(/\s+/);
      const firstName = parts[0] ?? '';
      const lastName = parts.slice(1).join(' ');
      updateInput = { [labelField.name]: { firstName, lastName } };
    } else {
      updateInput = { [labelField.name]: editedTitle.trim() };
    }

    updateOneRecord({
      idToUpdate: objectRecordId,
      objectNameSingular,
      updateOneRecordInput: updateInput,
    });

    setIsEditingTitle(false);
  }, [
    labelField,
    editedTitle,
    updateOneRecord,
    objectRecordId,
    objectNameSingular,
  ]);

  if (loading && !record) {
    return <StyledLoading>Loading...</StyledLoading>;
  }

  if (!record) {
    return <StyledLoading>Record not found</StyledLoading>;
  }

  return (
    <StyledContainer>
      <StyledHeader>
        <StyledBackButton onClick={handleBack}>
          <IconArrowLeft size={16} />
          {objectMetadataItem.labelPlural}
        </StyledBackButton>
        <StyledHeaderTitle>
          {objectMetadataItem.labelSingular} details
        </StyledHeaderTitle>
        <StyledHeaderSpacer />
      </StyledHeader>

      <StyledBody>
        <div>
          <StyledNameRow>
            {isEditingTitle ? (
              <>
                <StyledNameInput
                  value={editedTitle}
                  onChange={(event) => setEditedTitle(event.target.value)}
                  onKeyDown={(event) => {
                    if (event.key === 'Enter') handleSaveTitle();
                    if (event.key === 'Escape') setIsEditingTitle(false);
                  }}
                  autoFocus
                />
                <StyledEditButton onClick={handleSaveTitle}>
                  <IconCheck size={16} />
                </StyledEditButton>
              </>
            ) : (
              <>
                <StyledRecordName>
                  {displayName || 'Untitled'}
                </StyledRecordName>
                <StyledEditButton onClick={handleStartEditTitle}>
                  <IconPencil size={16} />
                </StyledEditButton>
              </>
            )}
          </StyledNameRow>
          {record.createdAt && (
            <StyledCreatedDate>{formatDate(record.createdAt)}</StyledCreatedDate>
          )}
        </div>

        <SimpleRecordDetailActionButtons
          phoneNumber={primaryPhone}
          email={primaryEmail}
        />

        <SimpleRecordDetailStageSelect
          record={record}
          objectMetadataItem={objectMetadataItem}
        />

        {relationFields.length > 0 && (
          <SimpleRecordDetailSection
            title="Related"
            fields={relationFields}
          />
        )}

        {dateFields.map((field) => (
          <StyledDateSection key={field.id}>
            <StyledDateLabel>{field.label}</StyledDateLabel>
            <StyledDateInput
              type="date"
              value={toDateInputValue(record[field.name] as string)}
              onChange={(event) =>
                handleDateChange(field.name, event.target.value)
              }
            />
          </StyledDateSection>
        ))}

        {contactFields.length > 0 && (
          <SimpleRecordDetailSection
            title="Contact info"
            fields={contactFields}
          />
        )}

        {detailFields.length > 0 && (
          <SimpleRecordDetailSection
            title="Details"
            fields={detailFields}
          />
        )}

        <SimpleRecordDetailNotes
          objectNameSingular={objectNameSingular}
          objectRecordId={objectRecordId}
          record={record}
        />
      </StyledBody>
    </StyledContainer>
  );
};
