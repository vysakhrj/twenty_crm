import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { FieldMetadataType } from 'twenty-shared/types';

export type SimpleRecordListSortDirection = 'asc' | 'desc';
export type SimpleRecordListSortField = string;

export type SimpleRecordListSort = {
  direction: SimpleRecordListSortDirection;
  field: SimpleRecordListSortField;
};

export const DEFAULT_SIMPLE_RECORD_LIST_SORT: SimpleRecordListSort = {
  direction: 'desc',
  field: 'createdAt',
};

type SimpleRecordListFieldMetadata = {
  id: string;
  isActive?: boolean | null;
  isSystem?: boolean | null;
  label: string;
  name: string;
  options?: { label: string; value: string }[] | null;
  type: FieldMetadataType;
};

type SimpleRecordListObjectMetadataItem = {
  fields: SimpleRecordListFieldMetadata[];
  labelIdentifierFieldMetadataId: string;
  nameSingular: string;
};

export type SimpleRecordListColumn = {
  fieldName?: string;
  fieldType?: FieldMetadataType;
  key: string;
  label: string;
  options?: { label: string; value: string }[] | null;
  width: string;
};

export type SimpleRecordListColumnOptions = {
  isAdminLeadList?: boolean;
};

const CONTACT_FIELD_TYPES = new Set([
  FieldMetadataType.EMAILS,
  FieldMetadataType.PHONES,
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

const CUSTOMER_OBJECT_NAMES = new Set(['customer', 'person']);

const CONTACT_RELATION_KEYS = ['customer', 'person'] as const;

const EXCLUDED_CONTACT_RELATION_KEYS = new Set([
  'assignee',
  'assigneeId',
  'createdBy',
  'updatedBy',
]);

const formatCreatedAt = (value: unknown): string => {
  if (typeof value !== 'string' || value.trim().length === 0) {
    return '-';
  }

  const date = new Date(value);

  if (Number.isNaN(date.getTime())) {
    return value;
  }

  return new Intl.DateTimeFormat('en-US', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
    timeZone: 'UTC',
  }).format(date);
};

const isRecordLike = (value: unknown): value is Record<string, unknown> =>
  value !== null && typeof value === 'object' && !Array.isArray(value);

const getFullNameValue = (value: unknown): string | null => {
  if (!isRecordLike(value)) {
    return null;
  }

  const firstName = typeof value.firstName === 'string' ? value.firstName : '';
  const lastName = typeof value.lastName === 'string' ? value.lastName : '';
  const fullName = `${firstName} ${lastName}`.trim();

  return fullName.length > 0 ? fullName : null;
};

export const getSimpleRecordDisplayName = (
  record: ObjectRecord | Record<string, unknown>,
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
): string => {
  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  if (!labelField) {
    return String(record.name ?? record.id ?? '-');
  }

  const value = record[labelField.name];

  if (labelField.type === FieldMetadataType.FULL_NAME) {
    return getFullNameValue(value) ?? String(record.id ?? '-');
  }

  return String(value ?? record.id ?? '-');
};

const findCustomerRecord = (
  record: Record<string, unknown>,
): Record<string, unknown> | undefined => {
  const customer = record.customer;

  if (isRecordLike(customer)) {
    return customer;
  }

  const person = record.person;

  if (isRecordLike(person)) {
    return person;
  }

  return undefined;
};

const getRelatedRecordDisplayName = (value: unknown): string | undefined => {
  if (!isRecordLike(value)) {
    return undefined;
  }

  const name = getFullNameValue(value.name);

  if (name !== null) {
    return name;
  }

  for (const key of ['name', 'title', 'label', 'displayName']) {
    const displayValue = value[key];

    if (typeof displayValue === 'string' && displayValue.trim().length > 0) {
      return displayValue.trim();
    }
  }

  return undefined;
};

const findValueInRecord = (
  record: Record<string, unknown>,
  predicate: (value: unknown, key: string) => string | undefined,
  depth = 0,
  excludedKeys: ReadonlySet<string> = new Set(),
): string | undefined => {
  if (depth > 2) {
    return undefined;
  }

  for (const [key, value] of Object.entries(record)) {
    if (depth === 0 && excludedKeys.has(key)) {
      continue;
    }

    const directValue = predicate(value, key);

    if (directValue !== undefined) {
      return directValue;
    }

    if (isRecordLike(value)) {
      const nestedValue = findValueInRecord(value, predicate, depth + 1);

      if (nestedValue !== undefined) {
        return nestedValue;
      }
    }
  }

  return undefined;
};

const extractContactValueFromRelation = (
  record: Record<string, unknown>,
  predicate: (value: unknown, key: string) => string | undefined,
): string | undefined => {
  for (const relationKey of CONTACT_RELATION_KEYS) {
    const relationRecord = record[relationKey];

    if (!isRecordLike(relationRecord)) {
      continue;
    }

    const contactValue = findValueInRecord(relationRecord, predicate);

    if (contactValue !== undefined) {
      return contactValue;
    }
  }

  return undefined;
};

export const extractSimpleRecordPrimaryEmail = (
  record: ObjectRecord | Record<string, unknown>,
): string | undefined => {
  const customerEmail = extractContactValueFromRelation(
    record,
    (value, key) => {
      if (isRecordLike(value) && typeof value.primaryEmail === 'string') {
        return value.primaryEmail;
      }

      if (
        key.toLowerCase().includes('email') &&
        typeof value === 'string' &&
        value.includes('@')
      ) {
        return value;
      }

      return undefined;
    },
  );

  if (customerEmail !== undefined) {
    return customerEmail;
  }

  return findValueInRecord(
    record,
    (value, key) => {
      if (isRecordLike(value) && typeof value.primaryEmail === 'string') {
        return value.primaryEmail;
      }

      if (
        key.toLowerCase().includes('email') &&
        typeof value === 'string' &&
        value.includes('@')
      ) {
        return value;
      }

      return undefined;
    },
    0,
    EXCLUDED_CONTACT_RELATION_KEYS,
  );
};

export const extractSimpleRecordPrimaryPhone = (
  record: ObjectRecord | Record<string, unknown>,
): string | undefined => {
  const customerPhone = extractContactValueFromRelation(
    record,
    (value, key) => {
      if (isRecordLike(value) && typeof value.primaryPhoneNumber === 'string') {
        const callingCode =
          typeof value.primaryPhoneCallingCode === 'string'
            ? value.primaryPhoneCallingCode
            : '';

        return `${callingCode}${value.primaryPhoneNumber}`.trim();
      }

      if (
        key.toLowerCase().includes('phone') &&
        typeof value === 'string' &&
        value.trim().length > 0
      ) {
        return value;
      }

      return undefined;
    },
  );

  if (customerPhone !== undefined) {
    return customerPhone;
  }

  return findValueInRecord(
    record,
    (value, key) => {
      if (isRecordLike(value) && typeof value.primaryPhoneNumber === 'string') {
        const callingCode =
          typeof value.primaryPhoneCallingCode === 'string'
            ? value.primaryPhoneCallingCode
            : '';

        return `${callingCode}${value.primaryPhoneNumber}`.trim();
      }

      if (
        key.toLowerCase().includes('phone') &&
        typeof value === 'string' &&
        value.trim().length > 0
      ) {
        return value;
      }

      return undefined;
    },
    0,
    EXCLUDED_CONTACT_RELATION_KEYS,
  );
};

export const getSimpleRecordListOrderBy = (sort: SimpleRecordListSort) => [
  {
    createdAt:
      sort.direction === 'asc' &&
      (sort.field === 'createdAt' || sort.field === 'date')
        ? ('AscNullsLast' as const)
        : ('DescNullsLast' as const),
  },
];

const getLabelField = (
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
) =>
  objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

const LEAD_CUSTOMER_NAME_COLUMN: SimpleRecordListColumn = {
  key: 'customerName',
  label: 'Customer Name',
  width: 'minmax(180px, 1fr)',
};

const LEAD_CUSTOMER_PHONE_COLUMN: SimpleRecordListColumn = {
  key: 'phone',
  label: 'Customer Phone',
  width: 'minmax(160px, 1fr)',
};

const LEAD_ORIGIN_COLUMN: SimpleRecordListColumn = {
  key: 'originName',
  label: 'Origin',
  width: 'minmax(180px, 1fr)',
};

const LEAD_DATE_COLUMN: SimpleRecordListColumn = {
  key: 'date',
  label: 'Date',
  width: 'minmax(140px, 0.9fr)',
};

const LEAD_ASSIGNEE_NAME_COLUMN: SimpleRecordListColumn = {
  key: 'assigneeName',
  label: 'Assignee Name',
  width: 'minmax(180px, 1fr)',
};

const isDisplayableMetadataField = (
  field: SimpleRecordListFieldMetadata,
  labelFieldId: string,
) =>
  field.isActive !== false &&
  field.isSystem !== true &&
  field.id !== labelFieldId &&
  !CONTACT_FIELD_TYPES.has(field.type) &&
  !HIDDEN_FIELD_TYPES.has(field.type);

export const getSimpleRecordListColumns = (
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
  options?: SimpleRecordListColumnOptions,
): SimpleRecordListColumn[] => {
  const labelField = getLabelField(objectMetadataItem);

  const nameColumn: SimpleRecordListColumn = {
    fieldName: labelField?.name,
    fieldType: labelField?.type,
    key: 'name',
    label: labelField?.label ?? 'Name',
    width:
      objectMetadataItem.nameSingular === 'lead'
        ? 'minmax(128px, 0.75fr)'
        : 'minmax(180px, 1fr)',
  };

  if (
    objectMetadataItem.nameSingular === 'lead' &&
    options?.isAdminLeadList === true
  ) {
    return [
      LEAD_CUSTOMER_NAME_COLUMN,
      LEAD_CUSTOMER_PHONE_COLUMN,
      LEAD_ORIGIN_COLUMN,
      LEAD_ASSIGNEE_NAME_COLUMN,
      LEAD_DATE_COLUMN,
    ];
  }

  if (objectMetadataItem.nameSingular === 'lead') {
    return [
      LEAD_CUSTOMER_NAME_COLUMN,
      LEAD_CUSTOMER_PHONE_COLUMN,
      LEAD_DATE_COLUMN,
      LEAD_ORIGIN_COLUMN,
    ];
  }

  if (CUSTOMER_OBJECT_NAMES.has(objectMetadataItem.nameSingular)) {
    return [
      nameColumn,
      {
        key: 'email',
        label: 'Email',
        width: 'minmax(220px, 1.25fr)',
      },
      {
        key: 'phone',
        label: 'Phone No',
        width: 'minmax(160px, 1fr)',
      },
    ];
  }

  if (objectMetadataItem.nameSingular === 'property') {
    const locationField =
      objectMetadataItem.fields.find((field) => field.name === 'location') ??
      objectMetadataItem.fields.find((field) =>
        field.label.toLocaleLowerCase().includes('location'),
      );

    return [
      nameColumn,
      {
        fieldName: locationField?.name,
        fieldType: locationField?.type,
        key: locationField?.name ?? 'location',
        label: locationField?.label ?? 'Location',
        options: locationField?.options,
        width: 'minmax(260px, 1fr)',
      },
    ];
  }

  if (objectMetadataItem.nameSingular === 'origin') {
    return [
      nameColumn,
      {
        key: 'createdAt',
        label: 'Created At',
        width: 'minmax(180px, 1fr)',
      },
    ];
  }

  const metadataColumns = objectMetadataItem.fields
    .filter((field) =>
      isDisplayableMetadataField(
        field,
        objectMetadataItem.labelIdentifierFieldMetadataId,
      ),
    )
    .slice(0, 2)
    .map(
      (field): SimpleRecordListColumn => ({
        fieldName: field.name,
        fieldType: field.type,
        key: field.name,
        label: field.label,
        options: field.options,
        width: 'minmax(180px, 1fr)',
      }),
    );

  return [nameColumn, ...metadataColumns];
};

export const getDefaultSimpleRecordListSort = (
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
  options?: SimpleRecordListColumnOptions,
): SimpleRecordListSort => {
  const columns = getSimpleRecordListColumns(objectMetadataItem, options);
  const dateColumn = columns.find(
    (column) => column.key === 'date' || column.key === 'createdAt',
  );

  if (dateColumn !== undefined) {
    return {
      direction: 'desc',
      field: dateColumn.key,
    };
  }

  return DEFAULT_SIMPLE_RECORD_LIST_SORT;
};

export const getSimpleRecordFieldValue = (
  record: ObjectRecord | Record<string, unknown>,
  column: SimpleRecordListColumn,
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
): string => {
  switch (column.key) {
    case 'email':
      return extractSimpleRecordPrimaryEmail(record) ?? '-';
    case 'phone':
      return extractSimpleRecordPrimaryPhone(record) ?? '-';
    case 'createdAt':
    case 'date':
      return formatCreatedAt(record.createdAt);
    case 'customerName': {
      const customerRecord = findCustomerRecord(record);

      return customerRecord
        ? (getRelatedRecordDisplayName(customerRecord) ?? '-')
        : '-';
    }
    case 'assigneeName': {
      const assigneeRecord = record.assignee;

      return isRecordLike(assigneeRecord)
        ? (getRelatedRecordDisplayName(assigneeRecord) ?? '-')
        : '-';
    }
    case 'originName': {
      const originRecord = record.origin;

      return isRecordLike(originRecord)
        ? (getRelatedRecordDisplayName(originRecord) ?? '-')
        : '-';
    }
    case 'name':
      return getSimpleRecordDisplayName(record, objectMetadataItem);
  }

  const rawValue =
    column.fieldName !== undefined ? record[column.fieldName] : undefined;

  if (rawValue === null || rawValue === undefined || rawValue === '') {
    return '-';
  }

  switch (column.fieldType) {
    case FieldMetadataType.FULL_NAME:
      return getFullNameValue(rawValue) ?? '-';
    case FieldMetadataType.SELECT: {
      const option = column.options?.find((item) => item.value === rawValue);

      return option?.label ?? String(rawValue);
    }
    case FieldMetadataType.BOOLEAN:
      return rawValue ? 'Yes' : 'No';
    case FieldMetadataType.CURRENCY: {
      if (isRecordLike(rawValue) && typeof rawValue.amountMicros === 'number') {
        const currencyCode =
          typeof rawValue.currencyCode === 'string'
            ? rawValue.currencyCode
            : '';

        return `${currencyCode} ${(
          rawValue.amountMicros / 1_000_000
        ).toLocaleString()}`.trim();
      }

      return '-';
    }
    case FieldMetadataType.RELATION:
      return getRelatedRecordDisplayName(rawValue) ?? '-';
    default:
      if (isRecordLike(rawValue)) {
        return getRelatedRecordDisplayName(rawValue) ?? '-';
      }

      return String(rawValue);
  }
};

export const sortSimpleRecordsForList = <TRecord extends ObjectRecord>(
  records: TRecord[],
  sort: SimpleRecordListSort,
  columns: SimpleRecordListColumn[],
  objectMetadataItem: SimpleRecordListObjectMetadataItem,
): TRecord[] =>
  [...records].sort((recordA, recordB) => {
    const isDateSort =
      sort.field === 'createdAt' || sort.field === 'date';
    const sortColumn = columns.find((column) => column.key === sort.field);

    if (sortColumn === undefined && !isDateSort) {
      return 0;
    }

    const valueA =
      isDateSort && typeof recordA.createdAt === 'string'
        ? recordA.createdAt
        : sortColumn === undefined
          ? ''
          : getSimpleRecordFieldValue(
              recordA,
              sortColumn,
              objectMetadataItem,
            ).toLocaleLowerCase();
    const valueB =
      isDateSort && typeof recordB.createdAt === 'string'
        ? recordB.createdAt
        : sortColumn === undefined
          ? ''
          : getSimpleRecordFieldValue(
              recordB,
              sortColumn,
              objectMetadataItem,
            ).toLocaleLowerCase();

    if (valueA.length === 0 && valueB.length === 0) {
      return 0;
    }

    if (valueA.length === 0) {
      return 1;
    }

    if (valueB.length === 0) {
      return -1;
    }

    const comparison = valueA.localeCompare(valueB);

    return sort.direction === 'asc' ? comparison : -comparison;
  });
