import { FieldMetadataType } from 'twenty-shared/types';

import {
  buildContactSearchFilter,
  buildCreatedAtDateFilter,
  buildLeadSearchFilter,
  buildReadAtFilter,
  buildSimpleRecordListFilter,
  getLeadCustomerRelationInfo,
} from '@/ui/layout/simple-view/utils/simple-record-list-filter.utils';

const leadMetadataItem = {
  fields: [
    {
      isActive: true,
      name: 'customer',
      relation: {
        targetObjectMetadata: {
          nameSingular: 'customer',
        },
      },
      settings: {
        joinColumnName: 'customerId',
      },
      type: FieldMetadataType.RELATION,
    },
    {
      isActive: true,
      name: 'name',
      type: FieldMetadataType.TEXT,
    },
  ],
};

const customerMetadataFields = [
  {
    isActive: true,
    name: 'name',
    type: FieldMetadataType.TEXT,
  },
  {
    isActive: true,
    name: 'emails',
    type: FieldMetadataType.EMAILS,
  },
  {
    isActive: true,
    name: 'phones',
    type: FieldMetadataType.PHONES,
  },
];

describe('simple-record-list-filter.utils', () => {
  it('finds the customer relation on lead metadata', () => {
    expect(getLeadCustomerRelationInfo(leadMetadataItem)).toEqual({
      joinColumnName: 'customerId',
      objectNameSingular: 'customer',
    });
  });

  it('builds customer search filters for text name, email, and phone', () => {
    expect(buildContactSearchFilter('john', customerMetadataFields)).toEqual({
      or: [
        { name: { ilike: '%john%' } },
        { emails: { primaryEmail: { ilike: '%john%' } } },
        { emails: { additionalEmails: { like: '%john%' } } },
        { phones: { primaryPhoneNumber: { ilike: '%john%' } } },
        { phones: { primaryPhoneCallingCode: { ilike: '%john%' } } },
      ],
    });
  });

  it('builds full name customer search filters when name is composite', () => {
    expect(
      buildContactSearchFilter('john', [
        {
          isActive: true,
          name: 'name',
          type: FieldMetadataType.FULL_NAME,
        },
      ]),
    ).toEqual({
      or: [
        { name: { firstName: { ilike: '%john%' } } },
        { name: { lastName: { ilike: '%john%' } } },
      ],
    });
  });

  it('builds lead search filters across lead name and matching customers', () => {
    expect(
      buildLeadSearchFilter({
        searchTerm: 'john',
        labelField: {
          name: 'name',
          type: FieldMetadataType.TEXT,
        },
        customerJoinColumnName: 'customerId',
        matchingCustomerIds: ['customer-1', 'customer-2'],
      }),
    ).toEqual({
      or: [
        { name: { ilike: '%john%' } },
        { customerId: { in: ['customer-1', 'customer-2'] } },
      ],
    });
  });

  it('builds createdAt date range filters', () => {
    expect(
      buildCreatedAtDateFilter({
        dateFrom: '2024-01-01',
        dateTo: '2024-01-31',
      }),
    ).toEqual({
      and: [
        { createdAt: { gte: '2024-01-01T00:00:00.000Z' } },
        { createdAt: { lte: '2024-01-31T23:59:59.999Z' } },
      ],
    });
  });

  it('builds readAt filters for read and unread leads', () => {
    expect(buildReadAtFilter('all')).toBeUndefined();
    expect(buildReadAtFilter('read')).toEqual({
      readAt: { is: 'NOT_NULL' },
    });
    expect(buildReadAtFilter('unread')).toEqual({
      readAt: { is: 'NULL' },
    });
  });

  it('combines lead search, date, assignee, and read status filters', () => {
    expect(
      buildSimpleRecordListFilter({
        searchTerm: 'john',
        labelField: {
          name: 'name',
          type: FieldMetadataType.TEXT,
        },
        isLeadList: true,
        customerRelationInfo: {
          joinColumnName: 'customerId',
          objectNameSingular: 'customer',
        },
        matchingCustomerIds: ['customer-1'],
        selectedAssigneeId: 'assignee-1',
        isAdminLeadList: true,
        dateFrom: '2024-01-01',
        dateTo: '2024-01-31',
        readStatus: 'unread',
      }),
    ).toEqual({
      and: [
        {
          or: [
            { name: { ilike: '%john%' } },
            { customerId: { in: ['customer-1'] } },
          ],
        },
        {
          and: [
            { createdAt: { gte: '2024-01-01T00:00:00.000Z' } },
            { createdAt: { lte: '2024-01-31T23:59:59.999Z' } },
          ],
        },
        { readAt: { is: 'NULL' } },
        { assigneeId: { eq: 'assignee-1' } },
      ],
    });
  });
});
