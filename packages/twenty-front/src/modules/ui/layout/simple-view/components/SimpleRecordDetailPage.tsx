import styled from '@emotion/styled';
import { useEffect, useMemo, useRef } from 'react';
import { useRecoilValue } from 'recoil';
import { useNavigate } from 'react-router-dom';

import {
  formatDateISOStringToUnifiedDate,
  formatDateISOStringToUnifiedDateTime,
} from '@/localization/utils/formatDateISOStringToUnified';
import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useGenerateDepthRecordGqlFieldsFromObject } from '@/object-record/graphql/record-gql-fields/hooks/useGenerateDepthRecordGqlFieldsFromObject';
import { useFindOneRecord } from '@/object-record/hooks/useFindOneRecord';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { SimpleRecordDetailNotes } from '@/ui/layout/simple-view/components/SimpleRecordDetailNotes';
import {
    SimpleRecordDetailSection,
    type SectionField,
} from '@/ui/layout/simple-view/components/SimpleRecordDetailSection';
import { SimpleRecordDetailStageSelect } from '@/ui/layout/simple-view/components/SimpleRecordDetailStageSelect';
import { FieldMetadataType } from 'twenty-shared/types';
import { IconArrowLeft, IconCalendar } from 'twenty-ui/display';

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
  gap: ${({ theme }) => theme.spacing(3)};
  max-width: 100%;
  padding: ${({ theme }) => theme.spacing(3)};
  padding-bottom: ${({ theme }) => theme.spacing(10)};
`;

const StyledTopCard = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(3)};
`;

const StyledNameRow = styled.div`
  align-items: center;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2.5)};
`;

const StyledRecordName = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledCreatedDate = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
`;

const StyledAvatar = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.medium};
  border-radius: 50%;
  color: ${({ theme }) => theme.font.color.secondary};
  display: inline-flex;
  flex-shrink: 0;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  height: ${({ theme }) => theme.spacing(8)};
  justify-content: center;
  width: ${({ theme }) => theme.spacing(8)};
`;

const StyledPrimaryInfo = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.25)};
  min-width: 0;
`;

const StyledChip = styled.div`
  background: ${({ theme }) => theme.background.transparent.light};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.xl};
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  padding: ${({ theme }) => theme.spacing(0.75)} ${({ theme }) => theme.spacing(1.5)};
`;

const StyledTopActionRow = styled.div`
  align-items: stretch;
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledStageSlot = styled.div`
  display: flex;
  flex: 0 1 44%;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.75)};
  min-width: 0;
`;

const StyledStatusLabel = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.xs};
  font-weight: ${({ theme }) => theme.font.weight.medium};
`;

const StyledFollowUpDue = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.75)};
  min-width: 0;
`;

const StyledTopMetaRow = styled.div`
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledTopMetaItem = styled.div`
  display: flex;
  flex: 1 1 100%;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.75)};
  min-width: 0;
`;

const StyledFollowUpLabel = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.xs};
  font-weight: ${({ theme }) => theme.font.weight.medium};
`;

const StyledFollowUpValueRow = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  gap: ${({ theme }) => theme.spacing(1)};
  min-width: 0;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(2.5)};
`;

const StyledFollowUpValue = styled.div`
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-width: 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
`;

const StyledFollowUpCalendarButton = styled.button`
  align-items: center;
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.tertiary};
  cursor: pointer;
  display: inline-flex;
  flex-shrink: 0;
  padding: 0;

  &:hover {
    color: ${({ theme }) => theme.font.color.primary};
  }
`;

const StyledHiddenFollowUpInput = styled.input`
  height: 0;
  opacity: 0;
  pointer-events: none;
  position: absolute;
  width: 0;
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

const StyledReadOnlyDateValue = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  box-sizing: border-box;
  color: ${({ theme }) => theme.font.color.primary};
  display: flex;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  width: 100%;
`;

const StyledTopMetaValue = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  display: flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-height: ${({ theme }) => theme.spacing(9)};
  min-width: 0;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(2.5)};
  word-break: break-word;
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

const PRIORITY_FIELD_NAMES = new Set(['body', 'convenientTime']);
const AUTO_MANAGED_FIELD_NAMES = new Set(['readAt']);

const getInitials = (value: string): string => {
  const cleaned = value.trim();
  if (!cleaned) return '--';

  const parts = cleaned.split(/\s+/).filter((part) => part.length > 0);
  if (parts.length === 1) {
    return parts[0].slice(0, 2).toUpperCase();
  }

  return `${parts[0][0]}${parts[1][0]}`.toUpperCase();
};

const formatDate = (dateString: string): string => {
  const formatted =
    formatDateISOStringToUnifiedDateTime(dateString);
  return formatted || dateString;
};

const formatDateOnly = (dateString: string): string => {
  const formatted = formatDateISOStringToUnifiedDate(dateString);
  return formatted || dateString;
};

const formatFieldValue = (
  value: unknown,
  fieldType: FieldMetadataType,
): string => {
  if (value === null || value === undefined) return '-';

  switch (fieldType) {
    case FieldMetadataType.DATE:
      return formatDateOnly(String(value));
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

const toDateInputValue = (dateString: string | null | undefined): string => {
  if (!dateString) return '';
  try {
    const date = new Date(dateString);
    return date.toISOString().split('T')[0];
  } catch {
    return '';
  }
};

const toDateTimeInputValue = (dateString: string | null | undefined): string => {
  if (!dateString) return '';
  try {
    const date = new Date(dateString);
    const localDate = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
    return localDate.toISOString().slice(0, 16);
  } catch {
    return '';
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
  const getFormattedPhone = (phoneObj: Record<string, unknown>) => {
    const primaryPhoneNumber = phoneObj.primaryPhoneNumber;
    if (
      typeof primaryPhoneNumber !== 'string' ||
      primaryPhoneNumber.trim().length === 0
    ) {
      return undefined;
    }

    const callingCode =
      typeof phoneObj.primaryPhoneCallingCode === 'string'
        ? phoneObj.primaryPhoneCallingCode
        : '';

    const prefix = callingCode;

    return `${prefix}${primaryPhoneNumber}`.trim();
  };

  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const phone = getFormattedPhone(value as Record<string, unknown>);
      if (phone) {
        return phone;
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
            const phone = getFormattedPhone(relValue as Record<string, unknown>);
            if (phone) {
              return phone;
            }
          }
        }
      }
    }
  }

  return undefined;
};

const extractWhatsappFromRecord = (
  record: Record<string, unknown>,
): string | undefined => {
  const whatsapp = record.whatsapp;
  if (whatsapp && typeof whatsapp === 'object' && !Array.isArray(whatsapp)) {
    const whatsappObj = whatsapp as Record<string, unknown>;
    const primaryPhoneNumber = whatsappObj.primaryPhoneNumber;
    if (
      typeof primaryPhoneNumber === 'string' &&
      primaryPhoneNumber.trim().length > 0
    ) {
      const callingCode =
        typeof whatsappObj.primaryPhoneCallingCode === 'string'
          ? whatsappObj.primaryPhoneCallingCode
          : '';
      const prefix = callingCode;
      return `${prefix}${primaryPhoneNumber}`.trim();
    }
  }

  for (const value of Object.values(record)) {
    if (value && typeof value === 'object' && !Array.isArray(value)) {
      const related = value as Record<string, unknown>;
      if (related.__typename && related.whatsapp) {
        const relatedWhatsapp = extractWhatsappFromRecord(related);
        if (relatedWhatsapp) {
          return relatedWhatsapp;
        }
      }
    }
  }

  return undefined;
};

const getWhatsappHref = (phoneNumber: string): string => {
  const digits = phoneNumber.replace(/\D/g, '');
  return `https://wa.me/${digits}`;
};

const formatPreferenceValue = (value: unknown): string | undefined => {
  if (!value) return undefined;

  if (Array.isArray(value)) {
    const labels = value
      .map((item) => {
        if (typeof item === 'string') return item;
        if (item && typeof item === 'object') {
          const label = (item as Record<string, unknown>).label;
          const rawValue = (item as Record<string, unknown>).value;
          if (typeof label === 'string') return label;
          if (typeof rawValue === 'string') return rawValue;
        }
        return null;
      })
      .filter((item): item is string => !!item && item.trim().length > 0);

    return labels.length > 0 ? labels.join(', ') : undefined;
  }

  if (typeof value === 'string') return value;
  if (typeof value === 'object') {
    const obj = value as Record<string, unknown>;
    if (typeof obj.label === 'string') return obj.label;
    if (typeof obj.value === 'string') return obj.value;
  }

  return undefined;
};

const findCustomerRecord = (
  record: Record<string, unknown>,
): Record<string, unknown> | undefined => {
  const customer = record.customer;
  if (customer && typeof customer === 'object' && !Array.isArray(customer)) {
    return customer as Record<string, unknown>;
  }

  for (const value of Object.values(record)) {
    if (
      value &&
      typeof value === 'object' &&
      !Array.isArray(value) &&
      (value as Record<string, unknown>).__typename === 'Person'
    ) {
      return value as Record<string, unknown>;
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
  const followUpPickerInputRef = useRef<HTMLInputElement>(null);
  const convenientTimePickerInputRef = useRef<HTMLInputElement>(null);
  const hasMarkedReadAtRef = useRef(false);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);

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

  const primaryWhatsapp = useMemo(() => {
    if (!record) return undefined;
    return extractWhatsappFromRecord(record as Record<string, unknown>);
  }, [record]);

  const followUpField = useMemo(
    () =>
      objectMetadataItem.fields.find(
        (field) =>
          field.isActive &&
          (field.name === 'dueDate' || field.label.toLowerCase() === 'due date'),
      ),
    [objectMetadataItem.fields],
  );

  const followUpValue = useMemo(() => {
    if (!record) return undefined;
    const typedRecord = record as Record<string, unknown>;
    const followUpRawValue = followUpField
      ? typedRecord[followUpField.name]
      : undefined;
    return typeof followUpRawValue === 'string' && followUpRawValue
      ? followUpRawValue
      : undefined;
  }, [record, followUpField]);

  const followUpDue = useMemo(
    () => (followUpValue ? formatDate(followUpValue) : undefined),
    [followUpValue],
  );

  const convenientTimeField = useMemo(
    () =>
      objectMetadataItem.fields.find(
        (field) =>
          field.isActive &&
          (field.name === 'convenientTime' ||
            field.label.toLowerCase() === 'convenient time'),
      ),
    [objectMetadataItem.fields],
  );

  const convenientTimeText = useMemo(() => {
    if (!record) return undefined;

    const formatConvenientTimeValue = (raw: string): string => {
      const trimmed = raw.trim();
      const date = new Date(trimmed);
      if (!Number.isNaN(date.getTime())) {
        return formatDate(trimmed);
      }
      return trimmed;
    };

    if (convenientTimeField) {
      const value = record[convenientTimeField.name];
      if (typeof value === 'string' && value.trim().length > 0) {
        return formatConvenientTimeValue(value);
      }
    }

    // Fallback for migrated/renamed convenient time fields.
    for (const [key, value] of Object.entries(record)) {
      if (typeof value !== 'string' || value.trim().length === 0) continue;
      const normalizedKey = key.toLowerCase();
      if (normalizedKey.includes('convenient') && normalizedKey.includes('time')) {
        return formatConvenientTimeValue(value);
      }
    }

    return undefined;
  }, [record, convenientTimeField]);

  const customerPriorityFields = useMemo((): SectionField[] => {
    if (!record) return [];

    const typedRecord = record as Record<string, unknown>;
    const customerRecord = findCustomerRecord(typedRecord);

    const customerName = customerRecord
      ? getRelatedRecordDisplayName(customerRecord)
      : null;

    const jobTitleCandidates = [
      customerRecord?.jobTitle,
      typedRecord.jobTitle,
    ];
    const jobTitle = jobTitleCandidates.find(
      (value): value is string =>
        typeof value === 'string' && value.trim().length > 0,
    );

    const customerCompanyRecord =
      customerRecord &&
      customerRecord.company &&
      typeof customerRecord.company === 'object' &&
      !Array.isArray(customerRecord.company)
        ? (customerRecord.company as Record<string, unknown>)
        : undefined;

    const companyFromRelation = customerCompanyRecord
      ? getRelatedRecordDisplayName(customerCompanyRecord)
      : null;
    const companyFromRoot =
      typedRecord.company &&
      typeof typedRecord.company === 'object' &&
      !Array.isArray(typedRecord.company)
        ? getRelatedRecordDisplayName(typedRecord.company as Record<string, unknown>)
        : null;

    const companyName = companyFromRelation || companyFromRoot;

    const preference = formatPreferenceValue(
      customerRecord?.workPreference ?? typedRecord.workPreference,
    );

    const propertyRecord =
      typedRecord.property &&
      typeof typedRecord.property === 'object' &&
      !Array.isArray(typedRecord.property)
        ? (typedRecord.property as Record<string, unknown>)
        : undefined;
    const propertyName = propertyRecord
      ? getRelatedRecordDisplayName(propertyRecord)
      : null;

    const bodyField = objectMetadataItem.fields.find(
      (field) => field.isActive && field.name === 'body',
    );
    const bodyValue = bodyField ? typedRecord[bodyField.name] : undefined;
    const customerQuery =
      typeof bodyValue === 'string' && bodyValue.trim().length > 0
        ? bodyValue.trim()
        : undefined;

    const fields: SectionField[] = [];

    if (customerName) {
      fields.push({ label: 'Customer', value: customerName });
    }
    if (jobTitle) {
      fields.push({ label: 'Job title', value: jobTitle });
    }
    if (companyName) {
      fields.push({ label: 'Company', value: companyName });
    }
    if (propertyName) {
      fields.push({ label: 'Property', value: propertyName });
    }
    if (preference) {
      fields.push({ label: 'Preference', value: preference });
    }
    if (customerQuery) {
      fields.push({ label: 'Customer query', value: customerQuery });
    }

    return fields;
  }, [record, objectMetadataItem.fields]);

  const originChip = useMemo(() => {
    if (!record) return undefined;

    const typedRecord = record as Record<string, unknown>;
    const originValue = typedRecord.origin;

    if (typeof originValue === 'string' && originValue.trim().length > 0) {
      return originValue.trim();
    }

    if (originValue && typeof originValue === 'object' && !Array.isArray(originValue)) {
      const displayName = getRelatedRecordDisplayName(
        originValue as Record<string, unknown>,
      );
      if (displayName) return displayName;
    }

    const originField = objectMetadataItem.fields.find(
      (field) => field.isActive && field.label.toLowerCase() === 'origin',
    );
    if (!originField) return undefined;

    const fallbackValue = typedRecord[originField.name];
    if (
      fallbackValue &&
      typeof fallbackValue === 'object' &&
      !Array.isArray(fallbackValue)
    ) {
      return getRelatedRecordDisplayName(fallbackValue as Record<string, unknown>) ?? undefined;
    }
    if (typeof fallbackValue === 'string' && fallbackValue.trim().length > 0) {
      return fallbackValue.trim();
    }

    return undefined;
  }, [record, objectMetadataItem.fields]);

  // Extract relation fields (Customer, Property, etc.)
  const relationFields = useMemo((): SectionField[] => {
    if (!record) return [];
    const fields: SectionField[] = [];
    const existingLabels = new Set(
      customerPriorityFields.map((field) => field.label.toLowerCase()),
    );
    existingLabels.add('origin');

    for (const fieldMeta of objectMetadataItem.fields) {
      if (!fieldMeta.isActive) continue;
      if (fieldMeta.type !== FieldMetadataType.RELATION) continue;
      if (existingLabels.has(fieldMeta.label.toLowerCase())) continue;
      if (fieldMeta.name.toLowerCase() === 'origin') continue;

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
  }, [record, objectMetadataItem.fields, customerPriorityFields]);

  const contactFields = useMemo((): SectionField[] => {
    if (!record) return [];
    const fields: SectionField[] = [];

    if (primaryEmail) {
      fields.push({
        label: 'Email address',
        value: primaryEmail,
        href: `mailto:${primaryEmail}`,
        actions: [{ type: 'email', href: `mailto:${primaryEmail}` }],
      });
    }

    if (primaryPhone) {
      fields.push({
        label: 'Phone number',
        value: primaryPhone,
        href: `tel:${primaryPhone}`,
        actions: [{ type: 'call', href: `tel:${primaryPhone}` }],
      });
    }

    if (primaryWhatsapp) {
      const whatsappHref = getWhatsappHref(primaryWhatsapp);
      fields.push({
        label: 'WhatsApp',
        value: primaryWhatsapp,
        href: whatsappHref,
        actions: [{ type: 'whatsapp', href: whatsappHref }],
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
  }, [
    record,
    objectMetadataItem.fields,
    primaryEmail,
    primaryPhone,
    primaryWhatsapp,
  ]);

  const dateFields = useMemo(() => {
    return objectMetadataItem.fields.filter(
      (field) =>
        field.isActive &&
        (field.type === FieldMetadataType.DATE ||
          field.type === FieldMetadataType.DATE_TIME) &&
        field.name !== followUpField?.name &&
        !AUTO_MANAGED_FIELD_NAMES.has(field.name) &&
        !SYSTEM_FIELD_NAMES.has(field.name),
    );
  }, [objectMetadataItem.fields, followUpField?.name]);

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
      if (PRIORITY_FIELD_NAMES.has(fieldMeta.name)) continue;
      if (fieldMeta.label.toLowerCase() === 'convenient time') continue;
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

  const handleFollowUpChange = (newValue: string) => {
    if (!followUpField) return;
    handleDateChange(followUpField.name, newValue);
  };

  const handleConvenientTimeChange = (newValue: string) => {
    if (!convenientTimeField) return;
    const isoValue = newValue ? new Date(newValue).toISOString() : '';
    updateOneRecord({
      idToUpdate: objectRecordId,
      objectNameSingular,
      updateOneRecordInput: {
        [convenientTimeField.name]: isoValue,
      },
    });
  };

  const openConvenientTimePicker = () => {
    const input = convenientTimePickerInputRef.current;
    if (!input) return;
    if ('showPicker' in input && typeof input.showPicker === 'function') {
      input.showPicker();
      return;
    }
    input.focus();
    input.click();
  };

  useEffect(() => {
    hasMarkedReadAtRef.current = false;
  }, [objectNameSingular, objectRecordId]);

  useEffect(() => {
    if (
      objectNameSingular !== 'lead' ||
      !record ||
      hasMarkedReadAtRef.current
    ) {
      return;
    }

    const hasReadAtField = objectMetadataItem.fields.some(
      (field) => field.name === 'readAt',
    );

    if (!hasReadAtField) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    const typedRecord = record as Record<string, unknown>;
    const readAt = typedRecord.readAt;
    const normalizedReadAt =
      typeof readAt === 'string' ? readAt.trim().toLowerCase() : readAt;
    const isAlreadyRead =
      normalizedReadAt !== null &&
      normalizedReadAt !== undefined &&
      normalizedReadAt !== '' &&
      normalizedReadAt !== 'null' &&
      normalizedReadAt !== 'undefined';

    if (isAlreadyRead) {
      hasMarkedReadAtRef.current = true;
      return;
    }

    const assigneeId =
      typeof typedRecord.assigneeId === 'string' && typedRecord.assigneeId
        ? typedRecord.assigneeId
        : null;
    const assigneeRelation =
      typedRecord.assignee &&
      typeof typedRecord.assignee === 'object' &&
      !Array.isArray(typedRecord.assignee)
        ? (typedRecord.assignee as Record<string, unknown>)
        : null;
    const assigneeRelationId =
      assigneeRelation && typeof assigneeRelation.id === 'string'
        ? assigneeRelation.id
        : null;
    const leadAssigneeId = assigneeId ?? assigneeRelationId;
    const currentMemberId = currentWorkspaceMember?.id ?? null;

    if (
      leadAssigneeId &&
      currentMemberId &&
      currentMemberId !== leadAssigneeId
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
    objectMetadataItem.fields,
    objectNameSingular,
    objectRecordId,
    record,
    updateOneRecord,
  ]);

  const openFollowUpPicker = () => {
    const input = followUpPickerInputRef.current;
    if (!input) return;

    if ('showPicker' in input && typeof input.showPicker === 'function') {
      input.showPicker();
      return;
    }

    input.focus();
    input.click();
  };

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
        <StyledTopCard>
          <StyledNameRow>
            <StyledAvatar>{getInitials(displayName || 'Untitled')}</StyledAvatar>
            <StyledPrimaryInfo>
              <StyledRecordName>{displayName || 'Untitled'}</StyledRecordName>
              {record.createdAt && (
                <StyledCreatedDate>
                  Created: {formatDate(record.createdAt)}
                </StyledCreatedDate>
              )}
            </StyledPrimaryInfo>
            {originChip && <StyledChip>{originChip}</StyledChip>}
          </StyledNameRow>

          <StyledTopActionRow>
            <StyledStageSlot>
              <StyledStatusLabel>Status</StyledStatusLabel>
              <SimpleRecordDetailStageSelect
                compact
                record={record}
                objectMetadataItem={objectMetadataItem}
              />
            </StyledStageSlot>
            {followUpField && (
              <StyledFollowUpDue>
                <StyledFollowUpLabel>Follow up due</StyledFollowUpLabel>
                <StyledFollowUpValueRow
                  role="button"
                  onClick={openFollowUpPicker}
                >
                  <StyledFollowUpValue>{followUpDue ?? '-'}</StyledFollowUpValue>
                  <StyledFollowUpCalendarButton
                    type="button"
                    onClick={(event) => {
                      event.stopPropagation();
                      openFollowUpPicker();
                    }}
                    aria-label="Set follow up due"
                  >
                    <IconCalendar size={16} />
                  </StyledFollowUpCalendarButton>
                  <StyledHiddenFollowUpInput
                    ref={followUpPickerInputRef}
                    type={
                      followUpField.type === FieldMetadataType.DATE_TIME
                        ? 'datetime-local'
                        : 'date'
                    }
                    value={
                      followUpField.type === FieldMetadataType.DATE_TIME
                        ? toDateTimeInputValue(followUpValue)
                        : toDateInputValue(followUpValue)
                    }
                    onChange={(event) => handleFollowUpChange(event.target.value)}
                  />
                </StyledFollowUpValueRow>
              </StyledFollowUpDue>
            )}
          </StyledTopActionRow>

          {(convenientTimeField || convenientTimeText !== undefined) && (
            <StyledTopMetaRow>
              <StyledTopMetaItem>
                <StyledFollowUpLabel>
                  {convenientTimeField?.label ?? 'Convenient Time'}
                </StyledFollowUpLabel>
                {convenientTimeField ? (
                  <StyledFollowUpValueRow
                    role="button"
                    onClick={openConvenientTimePicker}
                  >
                    <StyledTopMetaValue>
                      {convenientTimeText ?? '-'}
                    </StyledTopMetaValue>
                    <StyledFollowUpCalendarButton
                      type="button"
                      onClick={(event) => {
                        event.stopPropagation();
                        openConvenientTimePicker();
                      }}
                      aria-label="Set convenient time"
                    >
                      <IconCalendar size={16} />
                    </StyledFollowUpCalendarButton>
                    <StyledHiddenFollowUpInput
                      ref={convenientTimePickerInputRef}
                      type="datetime-local"
                      value={toDateTimeInputValue(
                        record[convenientTimeField.name] as string,
                      )}
                      onChange={(event) =>
                        handleConvenientTimeChange(event.target.value)
                      }
                    />
                  </StyledFollowUpValueRow>
                ) : (
                  <StyledTopMetaValue>
                    {convenientTimeText ?? '-'}
                  </StyledTopMetaValue>
                )}
              </StyledTopMetaItem>
            </StyledTopMetaRow>
          )}
        </StyledTopCard>

        {customerPriorityFields.length > 0 && (
          <SimpleRecordDetailSection
            title="Details"
            fields={customerPriorityFields}
          />
        )}

        {contactFields.length > 0 && (
          <SimpleRecordDetailSection
            title="Contact info"
            fields={contactFields}
          />
        )}

        <SimpleRecordDetailNotes
          objectMetadataItem={objectMetadataItem}
          objectNameSingular={objectNameSingular}
          objectRecordId={objectRecordId}
          record={record}
        />

        {relationFields.length > 0 && (
          <SimpleRecordDetailSection title="Related" fields={relationFields} />
        )}

        {dateFields.map((field) => (
          <StyledDateSection key={field.id}>
            <StyledDateLabel>{field.label}</StyledDateLabel>
            {field.name === 'dueDate' ||
            field.label.toLowerCase() === 'due date' ? (
              <StyledReadOnlyDateValue>
                <span>
                  {field.type === FieldMetadataType.DATE_TIME
                    ? formatDate(String(record[field.name] ?? ''))
                    : formatDateOnly(String(record[field.name] ?? ''))}
                </span>
                <IconCalendar size={20} />
              </StyledReadOnlyDateValue>
            ) : (
              <StyledDateInput
                type={
                  field.type === FieldMetadataType.DATE_TIME
                    ? 'datetime-local'
                    : 'date'
                }
                value={
                  field.type === FieldMetadataType.DATE_TIME
                    ? toDateTimeInputValue(record[field.name] as string)
                    : toDateInputValue(record[field.name] as string)
                }
                onChange={(event) =>
                  handleDateChange(field.name, event.target.value)
                }
              />
            )}
          </StyledDateSection>
        ))}

        {detailFields.length > 0 && (
          <SimpleRecordDetailSection title="Details" fields={detailFields} />
        )}
      </StyledBody>
    </StyledContainer>
  );
};
