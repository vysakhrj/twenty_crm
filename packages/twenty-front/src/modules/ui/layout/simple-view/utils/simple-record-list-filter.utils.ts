import {
  FieldMetadataType,
  type RecordGqlOperationFilter,
} from 'twenty-shared/types';
import { isDefined } from 'twenty-shared/utils';

type LeadListLabelField = {
  name: string;
  type: FieldMetadataType;
};

type SearchableFieldMetadata = {
  isActive?: boolean | null;
  name: string;
  type: FieldMetadataType;
};

type LeadListObjectMetadataItem = {
  fields: {
    isActive?: boolean | null;
    name: string;
    relation?: {
      targetObjectMetadata?: { nameSingular?: string | null } | null;
    } | null;
    settings?: { joinColumnName?: string | null } | null;
    type: FieldMetadataType;
  }[];
};

export type LeadCustomerRelationInfo = {
  joinColumnName: string;
  objectNameSingular: string;
};

export const getLeadCustomerRelationInfo = (
  objectMetadataItem: LeadListObjectMetadataItem,
): LeadCustomerRelationInfo | null => {
  const customerRelationField = objectMetadataItem.fields.find(
    (field) =>
      field.isActive !== false &&
      field.type === FieldMetadataType.RELATION &&
      (field.name === 'customer' || field.name === 'person') &&
      isDefined(field.settings?.joinColumnName),
  );

  if (!isDefined(customerRelationField?.settings?.joinColumnName)) {
    return null;
  }

  return {
    joinColumnName: customerRelationField.settings.joinColumnName,
    objectNameSingular:
      customerRelationField.relation?.targetObjectMetadata?.nameSingular ??
      customerRelationField.name,
  };
};

export const buildFieldSearchConditions = (
  field: SearchableFieldMetadata,
  searchTerm: string,
): RecordGqlOperationFilter[] => {
  const trimmedSearchTerm = searchTerm.trim();
  const ilikePattern = `%${trimmedSearchTerm}%`;

  switch (field.type) {
    case FieldMetadataType.FULL_NAME:
      return [
        {
          [field.name]: {
            firstName: { ilike: ilikePattern },
          },
        },
        {
          [field.name]: {
            lastName: { ilike: ilikePattern },
          },
        },
      ] as RecordGqlOperationFilter[];
    case FieldMetadataType.TEXT:
      return [
        {
          [field.name]: { ilike: ilikePattern },
        },
      ] as RecordGqlOperationFilter[];
    case FieldMetadataType.EMAILS:
      return [
        {
          [field.name]: {
            primaryEmail: { ilike: ilikePattern },
          },
        },
        {
          [field.name]: {
            additionalEmails: { like: ilikePattern },
          },
        },
      ] as RecordGqlOperationFilter[];
    case FieldMetadataType.PHONES:
      return [
        {
          [field.name]: {
            primaryPhoneNumber: { ilike: ilikePattern },
          },
        },
        {
          [field.name]: {
            primaryPhoneCallingCode: { ilike: ilikePattern },
          },
        },
      ] as RecordGqlOperationFilter[];
    default:
      return [];
  }
};

export const buildContactSearchFilter = (
  searchTerm: string,
  fields: SearchableFieldMetadata[],
): RecordGqlOperationFilter | undefined => {
  const trimmedSearchTerm = searchTerm.trim();

  if (trimmedSearchTerm.length === 0) {
    return undefined;
  }

  const activeFields = fields.filter((field) => field.isActive !== false);
  const searchConditions: RecordGqlOperationFilter[] = [];

  const nameField =
    activeFields.find((field) => field.name === 'name') ??
    activeFields.find((field) => field.type === FieldMetadataType.FULL_NAME);

  if (isDefined(nameField)) {
    searchConditions.push(
      ...buildFieldSearchConditions(nameField, trimmedSearchTerm),
    );
  }

  for (const field of activeFields) {
    if (field.type === FieldMetadataType.EMAILS) {
      searchConditions.push(
        ...buildFieldSearchConditions(field, trimmedSearchTerm),
      );
    }

    if (field.type === FieldMetadataType.PHONES) {
      searchConditions.push(
        ...buildFieldSearchConditions(field, trimmedSearchTerm),
      );
    }
  }

  if (searchConditions.length === 0) {
    return undefined;
  }

  if (searchConditions.length === 1) {
    return searchConditions[0];
  }

  return {
    or: searchConditions,
  } as RecordGqlOperationFilter;
};

const buildLeadNameSearchConditions = (
  searchTerm: string,
  labelField: LeadListLabelField,
): RecordGqlOperationFilter[] =>
  buildFieldSearchConditions(labelField, searchTerm);

export const buildLeadSearchFilter = ({
  searchTerm,
  labelField,
  customerJoinColumnName,
  matchingCustomerIds,
}: {
  searchTerm: string;
  labelField: LeadListLabelField;
  customerJoinColumnName: string;
  matchingCustomerIds: string[];
}): RecordGqlOperationFilter | undefined => {
  const trimmedSearchTerm = searchTerm.trim();

  if (trimmedSearchTerm.length === 0) {
    return undefined;
  }

  const searchConditions = buildLeadNameSearchConditions(
    trimmedSearchTerm,
    labelField,
  );

  if (matchingCustomerIds.length > 0) {
    searchConditions.push({
      [customerJoinColumnName]: {
        in: matchingCustomerIds,
      },
    } as RecordGqlOperationFilter);
  }

  if (searchConditions.length === 1) {
    return searchConditions[0];
  }

  return {
    or: searchConditions,
  } as RecordGqlOperationFilter;
};

export const buildCreatedAtDateFilter = ({
  dateFrom,
  dateTo,
}: {
  dateFrom?: string;
  dateTo?: string;
}): RecordGqlOperationFilter | undefined => {
  const filterConditions: RecordGqlOperationFilter[] = [];

  if (isDefined(dateFrom) && dateFrom.length > 0) {
    filterConditions.push({
      createdAt: {
        gte: `${dateFrom}T00:00:00.000Z`,
      },
    });
  }

  if (isDefined(dateTo) && dateTo.length > 0) {
    filterConditions.push({
      createdAt: {
        lte: `${dateTo}T23:59:59.999Z`,
      },
    });
  }

  if (filterConditions.length === 0) {
    return undefined;
  }

  if (filterConditions.length === 1) {
    return filterConditions[0];
  }

  return {
    and: filterConditions,
  } as RecordGqlOperationFilter;
};

export const combineRecordFilters = (
  filterConditions: RecordGqlOperationFilter[],
): RecordGqlOperationFilter | undefined => {
  if (filterConditions.length === 0) {
    return undefined;
  }

  if (filterConditions.length === 1) {
    return filterConditions[0];
  }

  return {
    and: filterConditions,
  } as RecordGqlOperationFilter;
};

export const buildSimpleRecordListFilter = ({
  searchTerm,
  labelField,
  isLeadList,
  customerRelationInfo,
  matchingCustomerIds,
  selectedAssigneeId,
  isAdminLeadList,
  dateFrom,
  dateTo,
}: {
  searchTerm: string;
  labelField?: LeadListLabelField;
  isLeadList: boolean;
  customerRelationInfo: LeadCustomerRelationInfo | null;
  matchingCustomerIds: string[];
  selectedAssigneeId: string;
  isAdminLeadList: boolean;
  dateFrom?: string;
  dateTo?: string;
}): RecordGqlOperationFilter | undefined => {
  const filterConditions: RecordGqlOperationFilter[] = [];

  if (searchTerm.trim().length > 0 && isDefined(labelField)) {
    if (isLeadList && isDefined(customerRelationInfo)) {
      const leadSearchFilter = buildLeadSearchFilter({
        searchTerm,
        labelField,
        customerJoinColumnName: customerRelationInfo.joinColumnName,
        matchingCustomerIds,
      });

      if (isDefined(leadSearchFilter)) {
        filterConditions.push(leadSearchFilter);
      }
    } else {
      const genericSearchConditions = buildLeadNameSearchConditions(
        searchTerm,
        labelField,
      );

      filterConditions.push(
        (genericSearchConditions.length === 1
          ? genericSearchConditions[0]
          : { or: genericSearchConditions }) as RecordGqlOperationFilter,
      );
    }
  }

  if (isLeadList) {
    const dateFilter = buildCreatedAtDateFilter({ dateFrom, dateTo });

    if (isDefined(dateFilter)) {
      filterConditions.push(dateFilter);
    }
  }

  if (isAdminLeadList && selectedAssigneeId !== 'all') {
    filterConditions.push({
      assigneeId: { eq: selectedAssigneeId },
    } as RecordGqlOperationFilter);
  }

  return combineRecordFilters(filterConditions);
};
