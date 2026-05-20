import styled from '@emotion/styled';
import { useEffect, useMemo, useRef, type ReactNode } from 'react';
import { useRecoilValue } from 'recoil';
import { useNavigate } from 'react-router-dom';

import {
  formatDateISOStringToUnifiedDate,
  formatDateISOStringToUnifiedDateTime,
} from '@/localization/utils/formatDateISOStringToUnified';
import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { currentWorkspaceMembersState } from '@/auth/states/currentWorkspaceMembersState';
import { CoreObjectNameSingular } from '@/object-metadata/types/CoreObjectNameSingular';
import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useGenerateDepthRecordGqlFieldsFromObject } from '@/object-record/graphql/record-gql-fields/hooks/useGenerateDepthRecordGqlFieldsFromObject';
import { useFindOneRecord } from '@/object-record/hooks/useFindOneRecord';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import {
  BasicInfoIcons,
  SimpleRecordDetailBasicInfo,
  type BasicInfoIconVariant,
} from '@/ui/layout/simple-view/components/SimpleRecordDetailBasicInfo';
import { SimpleRecordDetailNotes } from '@/ui/layout/simple-view/components/SimpleRecordDetailNotes';
import {
  SimpleRecordDetailSection,
  type SectionField,
} from '@/ui/layout/simple-view/components/SimpleRecordDetailSection';
import { SimpleRecordDetailStageSelect } from '@/ui/layout/simple-view/components/SimpleRecordDetailStageSelect';
import { FieldMetadataType } from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';
import { IconArrowLeft, IconCalendar } from 'twenty-ui/display';
import { MOBILE_VIEWPORT } from 'twenty-ui/theme';

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

const StyledContentGrid = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};

  @media (min-width: ${MOBILE_VIEWPORT}px) {
    align-items: flex-start;
    flex-direction: row;
  }
`;

const StyledLeftColumn = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  min-width: 0;
  width: 100%;

  @media (min-width: ${MOBILE_VIEWPORT}px) {
    max-width: 50%;
  }
`;

const StyledRightColumn = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  min-width: 0;
  width: 100%;

  @media (min-width: ${MOBILE_VIEWPORT}px) {
    max-width: 50%;
  }
`;

const StyledCompactMetaRow = styled.div`
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

  const person = record.person;
  if (person && typeof person === 'object' && !Array.isArray(person)) {
    return person as Record<string, unknown>;
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

const ASSIGNEE_FIELD_CANDIDATE_NAMES = [
  'assignedTo',
  'assignee',
  'owner',
  'manager',
] as const;

const getAssigneeJoinColumnId = (
  record: Record<string, unknown>,
  objectMetadataItem: { fields: { name: string; type: FieldMetadataType; isActive?: boolean | null; relation?: { targetObjectMetadata?: { nameSingular?: string | null } | null } | null; settings?: { joinColumnName?: string | null } | null }[] },
): string | null => {
  const workspaceMemberRelationFields = objectMetadataItem.fields.filter(
    (field) =>
      field.type === FieldMetadataType.RELATION &&
      field.isActive &&
      field.relation?.targetObjectMetadata?.nameSingular ===
        CoreObjectNameSingular.WorkspaceMember &&
      isDefined(field.settings?.joinColumnName),
  );

  if (workspaceMemberRelationFields.length === 0) {
    return null;
  }

  const preferredRelationField =
    workspaceMemberRelationFields.find((field) =>
      ASSIGNEE_FIELD_CANDIDATE_NAMES.includes(
        field.name as (typeof ASSIGNEE_FIELD_CANDIDATE_NAMES)[number],
      ),
    ) ?? workspaceMemberRelationFields[0];

  const joinColumnName = preferredRelationField.settings?.joinColumnName;

  if (!isDefined(joinColumnName)) {
    return null;
  }

  const idValue = record[joinColumnName];

  return typeof idValue === 'string' && idValue.length > 0 ? idValue : null;
};

const getCustomerLocation = (
  customerRecord: Record<string, unknown> | undefined,
): string | undefined => {
  if (!customerRecord) {
    return undefined;
  }

  const city =
    typeof customerRecord.city === 'string' ? customerRecord.city.trim() : '';
  const address = customerRecord.address;

  let addressCity = '';
  let addressState = '';

  if (address && typeof address === 'object' && !Array.isArray(address)) {
    const addressObject = address as Record<string, unknown>;
    addressCity =
      typeof addressObject.addressCity === 'string'
        ? addressObject.addressCity.trim()
        : '';
    addressState =
      typeof addressObject.addressState === 'string'
        ? addressObject.addressState.trim()
        : '';
  }

  const locationParts = [city || addressCity, addressState].filter(
    (part) => part.length > 0,
  );

  return locationParts.length > 0 ? locationParts.join(', ') : undefined;
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
  const hasMarkedReadAtRef = useRef(false);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);
  const workspaceMembers = useRecoilValue(currentWorkspaceMembersState);

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

  const assigneeName = useMemo(() => {
    if (!record) return undefined;

    const typedRecord = record as Record<string, unknown>;
    const assigneeRelation =
      typedRecord.assignee &&
      typeof typedRecord.assignee === 'object' &&
      !Array.isArray(typedRecord.assignee)
        ? (typedRecord.assignee as Record<string, unknown>)
        : null;

    if (assigneeRelation) {
      const relationName = getRelatedRecordDisplayName(assigneeRelation);
      if (relationName) {
        return relationName;
      }
    }

    const assigneeId = getAssigneeJoinColumnId(typedRecord, objectMetadataItem);
    const assigneeMember = isDefined(assigneeId)
      ? workspaceMembers.find((member) => member.id === assigneeId)
      : undefined;

    if (!assigneeMember) {
      return undefined;
    }

    return `${assigneeMember.name.firstName} ${assigneeMember.name.lastName}`.trim();
  }, [objectMetadataItem, record, workspaceMembers]);

  const basicInfoItems = useMemo(() => {
    if (!record) return [];

    const typedRecord = record as Record<string, unknown>;
    const customerRecord = findCustomerRecord(typedRecord);
    const items: {
      href?: string;
      icon: ReactNode;
      iconVariant: BasicInfoIconVariant;
      value: string;
    }[] = [];

    const customerName = customerRecord
      ? getRelatedRecordDisplayName(customerRecord)
      : null;

    if (customerName) {
      items.push({
        icon: <BasicInfoIcons.User size={16} />,
        iconVariant: 'blue',
        value: customerName,
      });
    }

    const location = getCustomerLocation(customerRecord);
    if (location) {
      items.push({
        icon: <BasicInfoIcons.Map size={16} />,
        iconVariant: 'red',
        value: location,
      });
    }

    if (primaryEmail) {
      items.push({
        href: `mailto:${primaryEmail}`,
        icon: <BasicInfoIcons.Mail size={16} />,
        iconVariant: 'purple',
        value: primaryEmail,
      });
    }

    if (primaryPhone) {
      items.push({
        href: `tel:${primaryPhone}`,
        icon: <BasicInfoIcons.Phone size={16} />,
        iconVariant: 'green',
        value: primaryPhone,
      });
    }

    if (primaryWhatsapp) {
      items.push({
        href: getWhatsappHref(primaryWhatsapp),
        icon: <BasicInfoIcons.Message size={16} />,
        iconVariant: 'green',
        value: primaryWhatsapp,
      });
    }

    const propertyRecord =
      typedRecord.property &&
      typeof typedRecord.property === 'object' &&
      !Array.isArray(typedRecord.property)
        ? (typedRecord.property as Record<string, unknown>)
        : undefined;
    const propertyName = propertyRecord
      ? getRelatedRecordDisplayName(propertyRecord)
      : null;

    if (propertyName) {
      items.push({
        icon: <BasicInfoIcons.Briefcase size={16} />,
        iconVariant: 'orange',
        value: propertyName,
      });
    }

    if (convenientTimeText) {
      items.push({
        icon: <BasicInfoIcons.Clock size={16} />,
        iconVariant: 'teal',
        value: convenientTimeText,
      });
    }

    return items;
  }, [
    convenientTimeText,
    primaryEmail,
    primaryPhone,
    primaryWhatsapp,
    record,
  ]);

  const filteredCustomerPriorityFields = useMemo(
    () =>
      customerPriorityFields.filter(
        (field) =>
          !['customer', 'property'].includes(field.label.toLowerCase()),
      ),
    [customerPriorityFields],
  );

  const recordCreatedDate = useMemo(() => {
    if (!record?.createdAt) return undefined;
    return formatDateOnly(record.createdAt);
  }, [record?.createdAt]);

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
        <StyledContentGrid>
          <StyledLeftColumn>
            <SimpleRecordDetailBasicInfo
              assigneeName={assigneeName}
              createdDate={recordCreatedDate}
              infoItems={basicInfoItems}
            >
              <StyledCompactMetaRow>
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
                      <StyledFollowUpValue>
                        {followUpDue ?? '-'}
                      </StyledFollowUpValue>
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
                        onChange={(event) =>
                          handleFollowUpChange(event.target.value)
                        }
                      />
                    </StyledFollowUpValueRow>
                  </StyledFollowUpDue>
                )}
              </StyledCompactMetaRow>
            </SimpleRecordDetailBasicInfo>

            {filteredCustomerPriorityFields.length > 0 && (
              <SimpleRecordDetailSection
                title="Details"
                fields={filteredCustomerPriorityFields}
              />
            )}

            {relationFields.length > 0 && (
              <SimpleRecordDetailSection
                title="Related"
                fields={relationFields}
              />
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
              <SimpleRecordDetailSection
                title="Additional details"
                fields={detailFields}
              />
            )}
          </StyledLeftColumn>

          <StyledRightColumn>
            <SimpleRecordDetailNotes
              objectMetadataItem={objectMetadataItem}
              objectNameSingular={objectNameSingular}
              objectRecordId={objectRecordId}
              record={record}
            />
          </StyledRightColumn>
        </StyledContentGrid>
      </StyledBody>
    </StyledContainer>
  );
};
