import {
  extractSimpleRecordPrimaryEmail,
  extractSimpleRecordPrimaryPhone,
  getDefaultSimpleRecordListSort,
  getSimpleRecordFieldValue,
  getSimpleRecordListColumns,
  getSimpleRecordDisplayName,
  getSimpleRecordListOrderBy,
  sortSimpleRecordsForList,
} from '@/ui/layout/simple-view/utils/simple-record-table.utils';
import { FieldMetadataType } from 'twenty-shared/types';

const objectMetadataItem = {
  nameSingular: 'lead',
  fields: [
    {
      id: 'name-field-id',
      isActive: true,
      isSystem: false,
      label: 'Name',
      name: 'name',
      type: FieldMetadataType.FULL_NAME,
    },
  ],
  labelIdentifierFieldMetadataId: 'name-field-id',
};

const propertyMetadataItem = {
  nameSingular: 'property',
  fields: [
    {
      id: 'property-name-field-id',
      isActive: true,
      isSystem: false,
      label: 'Name',
      name: 'name',
      type: FieldMetadataType.TEXT,
    },
    {
      id: 'property-email-field-id',
      isActive: true,
      isSystem: false,
      label: 'Email',
      name: 'emails',
      type: FieldMetadataType.EMAILS,
    },
    {
      id: 'property-location-field-id',
      isActive: true,
      isSystem: false,
      label: 'Location',
      name: 'location',
      type: FieldMetadataType.TEXT,
    },
    {
      id: 'property-status-field-id',
      isActive: true,
      isSystem: false,
      label: 'Status',
      name: 'status',
      type: FieldMetadataType.SELECT,
      options: [{ label: 'Available', value: 'AVAILABLE' }],
    },
  ],
  labelIdentifierFieldMetadataId: 'property-name-field-id',
};

const customerMetadataItem = {
  nameSingular: 'customer',
  fields: [
    {
      id: 'customer-name-field-id',
      isActive: true,
      isSystem: false,
      label: 'Name',
      name: 'name',
      type: FieldMetadataType.FULL_NAME,
    },
  ],
  labelIdentifierFieldMetadataId: 'customer-name-field-id',
};

const originMetadataItem = {
  nameSingular: 'origin',
  fields: [
    {
      id: 'origin-name-field-id',
      isActive: true,
      isSystem: false,
      label: 'Name',
      name: 'name',
      type: FieldMetadataType.TEXT,
    },
  ],
  labelIdentifierFieldMetadataId: 'origin-name-field-id',
};

describe('simple-record-table.utils', () => {
  it('extracts the listing values shown in the enquiry table', () => {
    const record = {
      id: 'record-id',
      customer: {
        emails: {
          primaryEmail: 'john@example.com',
        },
        name: {
          firstName: 'John',
          lastName: 'Doe',
        },
        phones: {
          primaryPhoneCallingCode: '+91',
          primaryPhoneNumber: '9876543210',
        },
      },
      name: {
        firstName: 'John',
        lastName: 'Doe',
      },
    };

    expect(getSimpleRecordDisplayName(record, objectMetadataItem)).toBe(
      'John Doe',
    );
    expect(extractSimpleRecordPrimaryEmail(record)).toBe('john@example.com');
    expect(extractSimpleRecordPrimaryPhone(record)).toBe('+919876543210');
  });

  it('prefers customer email over assignee email on lead records', () => {
    const record = {
      id: 'record-id',
      assignee: {
        name: {
          firstName: 'Agent',
          lastName: 'Smith',
        },
        userEmail: 'agent@company.com',
      },
      customer: {
        emails: {
          primaryEmail: 'customer@example.com',
        },
        phones: {
          primaryPhoneCallingCode: '+1',
          primaryPhoneNumber: '5551234',
        },
      },
    };

    expect(extractSimpleRecordPrimaryEmail(record)).toBe(
      'customer@example.com',
    );
    expect(extractSimpleRecordPrimaryPhone(record)).toBe('+15551234');
  });

  it('uses createdAt as the server-side listing sort field', () => {
    expect(
      getSimpleRecordListOrderBy({
        direction: 'desc',
        field: 'createdAt',
      }),
    ).toEqual([{ createdAt: 'DescNullsLast' }]);
    expect(
      getSimpleRecordListOrderBy({
        direction: 'asc',
        field: 'createdAt',
      }),
    ).toEqual([{ createdAt: 'AscNullsLast' }]);
  });

  it('defaults to date descending for admin lead lists', () => {
    expect(
      getDefaultSimpleRecordListSort(objectMetadataItem, {
        isAdminLeadList: true,
      }),
    ).toEqual({
      direction: 'desc',
      field: 'date',
    });
  });

  it('defaults to date descending for sales lead lists', () => {
    expect(getDefaultSimpleRecordListSort(objectMetadataItem)).toEqual({
      direction: 'desc',
      field: 'date',
    });
  });

  it('sorts records by date descending for sales lead lists', () => {
    const records = [
      {
        __typename: 'Lead',
        id: 'record-old',
        createdAt: '2024-01-01T00:00:00.000Z',
        name: { firstName: 'Amy', lastName: 'Brown' },
      },
      {
        __typename: 'Lead',
        id: 'record-new',
        createdAt: '2024-01-02T00:00:00.000Z',
        name: { firstName: 'Zoe', lastName: 'Adams' },
      },
    ];

    expect(
      sortSimpleRecordsForList(
        records,
        {
          direction: 'desc',
          field: 'date',
        },
        getSimpleRecordListColumns(objectMetadataItem),
        objectMetadataItem,
      ).map((record) => record.id),
    ).toEqual(['record-new', 'record-old']);
  });

  it('uses customer-first columns for sales lead records', () => {
    expect(
      getSimpleRecordListColumns(objectMetadataItem).map(
        (column) => column.label,
      ),
    ).toEqual([
      'Customer Name',
      'Customer Phone',
      'Customer Email',
      'Date',
      'Lead Name',
    ]);
  });

  it('uses customer-first columns for admin lead records', () => {
    expect(
      getSimpleRecordListColumns(objectMetadataItem, {
        isAdminLeadList: true,
      }).map((column) => column.label),
    ).toEqual([
      'Customer Name',
      'Customer Phone',
      'Customer Email',
      'Lead Name',
      'Assignee Name',
      'Date',
    ]);
  });

  it('formats admin enquiry column values for lead records', () => {
    const adminColumns = getSimpleRecordListColumns(objectMetadataItem, {
      isAdminLeadList: true,
    });
    const record = {
      __typename: 'Lead',
      assignee: {
        name: {
          firstName: 'Agent',
          lastName: 'Smith',
        },
      },
      createdAt: '2024-01-02T10:30:00.000Z',
      customer: {
        name: {
          firstName: 'John',
          lastName: 'Doe',
        },
      },
      id: 'record-id',
      name: {
        firstName: 'Enquiry',
        lastName: '#12',
      },
    };

    expect(
      getSimpleRecordFieldValue(
        record,
        adminColumns.find((column) => column.key === 'customerName')!,
        objectMetadataItem,
      ),
    ).toBe('John Doe');
    expect(
      getSimpleRecordFieldValue(
        record,
        adminColumns.find((column) => column.key === 'assigneeName')!,
        objectMetadataItem,
      ),
    ).toBe('Agent Smith');
    expect(
      getSimpleRecordFieldValue(
        record,
        adminColumns.find((column) => column.key === 'date')!,
        objectMetadataItem,
      ),
    ).toBe('Jan 2, 2024');
    expect(
      getSimpleRecordFieldValue(
        record,
        adminColumns.find((column) => column.key === 'name')!,
        objectMetadataItem,
      ),
    ).toBe('Enquiry #12');
  });

  it('uses customer name and contact columns for customer records', () => {
    expect(
      getSimpleRecordListColumns(customerMetadataItem).map(
        (column) => column.label,
      ),
    ).toEqual(['Name', 'Email', 'Phone No']);
  });

  it('uses property name and location for property records', () => {
    const propertyColumns = getSimpleRecordListColumns(propertyMetadataItem);

    expect(propertyColumns.map((column) => column.label)).toEqual([
      'Name',
      'Location',
    ]);
  });

  it('uses origin name and formatted created at for origin records', () => {
    const originColumns = getSimpleRecordListColumns(originMetadataItem);

    expect(originColumns.map((column) => column.label)).toEqual([
      'Name',
      'Created At',
    ]);
    expect(
      getSimpleRecordFieldValue(
        {
          __typename: 'Origin',
          createdAt: '2024-01-02T10:30:00.000Z',
          id: 'origin-id',
          name: 'Website',
        },
        originColumns[1],
        originMetadataItem,
      ),
    ).toBe('Jan 2, 2024');
  });

  it('formats generic metadata field values for non-lead records', () => {
    const statusColumn = {
      fieldName: 'status',
      fieldType: FieldMetadataType.SELECT,
      key: 'status',
      label: 'Status',
      options: [{ label: 'Available', value: 'AVAILABLE' }],
      width: 'minmax(180px, 1fr)',
    };

    expect(
      getSimpleRecordFieldValue(
        {
          __typename: 'Property',
          id: 'property-id',
          location: '221B Baker Street',
          name: 'Townhouse',
          status: 'AVAILABLE',
        },
        statusColumn,
        propertyMetadataItem,
      ),
    ).toBe('Available');
  });

  it('sorts visible records by customer email and phone number', () => {
    const records = [
      {
        __typename: 'Lead',
        id: 'record-b',
        createdAt: '2024-01-02T00:00:00.000Z',
        customer: {
          emails: { primaryEmail: 'zoe@example.com' },
          phones: { primaryPhoneNumber: '222' },
        },
        name: { firstName: 'Zoe', lastName: 'Adams' },
      },
      {
        __typename: 'Lead',
        id: 'record-a',
        createdAt: '2024-01-01T00:00:00.000Z',
        customer: {
          emails: { primaryEmail: 'amy@example.com' },
          phones: { primaryPhoneNumber: '111' },
        },
        name: { firstName: 'Amy', lastName: 'Brown' },
      },
    ];

    expect(
      sortSimpleRecordsForList(
        records,
        {
          direction: 'asc',
          field: 'email',
        },
        getSimpleRecordListColumns(objectMetadataItem),
        objectMetadataItem,
      ).map((record) => record.id),
    ).toEqual(['record-a', 'record-b']);

    expect(
      sortSimpleRecordsForList(
        records,
        {
          direction: 'desc',
          field: 'phone',
        },
        getSimpleRecordListColumns(objectMetadataItem),
        objectMetadataItem,
      ).map((record) => record.id),
    ).toEqual(['record-b', 'record-a']);
  });
});
