import {
  getLeadExportAssigneeName,
  getSimpleRecordListExportFilename,
  getSimpleRecordListExportTitle,
  getWorkspaceMemberDisplayName,
} from '@/ui/layout/simple-view/utils/simple-record-list-export.utils';
import { utils } from 'xlsx-ugnis';

const createWorkspaceMember = ({
  firstName,
  id,
  lastName,
}: {
  firstName: string;
  id: string;
  lastName: string;
}) => ({
  id,
  name: {
    firstName,
    lastName,
  },
});

describe('simple-record-list-export.utils', () => {
  describe('getWorkspaceMemberDisplayName', () => {
    it('returns the trimmed full name', () => {
      expect(
        getWorkspaceMemberDisplayName(
          createWorkspaceMember({
            firstName: 'Jane',
            id: 'member-1',
            lastName: 'Doe',
          }),
        ),
      ).toBe('Jane Doe');
    });
  });

  describe('getSimpleRecordListExportTitle', () => {
    it('includes assignee name when provided', () => {
      expect(
        getSimpleRecordListExportTitle({
          assigneeName: 'Jane Doe',
          labelPlural: 'Leads',
        }),
      ).toBe('Leads - Jane Doe');
    });

    it('returns label plural when assignee name is missing', () => {
      expect(
        getSimpleRecordListExportTitle({
          labelPlural: 'Leads',
        }),
      ).toBe('Leads');
    });
  });

  describe('getSimpleRecordListExportFilename', () => {
    it('builds a filename with the given extension', () => {
      expect(
        getSimpleRecordListExportFilename({
          baseName: 'Leads - Jane Doe',
          extension: 'csv',
        }),
      ).toBe('Leads - Jane Doe.csv');
    });

    it('sanitizes invalid filename characters', () => {
      expect(
        getSimpleRecordListExportFilename({
          baseName: 'Leads/Jane:Doe',
          extension: 'xlsx',
        }),
      ).toBe('Leads-Jane-Doe.xlsx');
    });
  });

  describe('getLeadExportAssigneeName', () => {
    const workspaceMembers = [
      createWorkspaceMember({
        firstName: 'Jane',
        id: 'assignee-1',
        lastName: 'Doe',
      }),
      createWorkspaceMember({
        firstName: 'John',
        id: 'assignee-2',
        lastName: 'Smith',
      }),
    ];

    it('returns current member name for sales lead exports', () => {
      expect(
        getLeadExportAssigneeName({
          currentWorkspaceMember: workspaceMembers[1],
          isAdminLeadList: false,
          isLeadList: true,
          selectedAssigneeId: 'all',
          workspaceMembers,
        }),
      ).toBe('John Smith');
    });

    it('returns selected assignee name for admin lead exports', () => {
      expect(
        getLeadExportAssigneeName({
          currentWorkspaceMember: workspaceMembers[1],
          isAdminLeadList: true,
          isLeadList: true,
          selectedAssigneeId: 'assignee-1',
          workspaceMembers,
        }),
      ).toBe('Jane Doe');
    });

    it('returns undefined when admin exports all assignees', () => {
      expect(
        getLeadExportAssigneeName({
          currentWorkspaceMember: workspaceMembers[1],
          isAdminLeadList: true,
          isLeadList: true,
          selectedAssigneeId: 'all',
          workspaceMembers,
        }),
      ).toBeUndefined();
    });

    it('returns undefined for non-lead exports', () => {
      expect(
        getLeadExportAssigneeName({
          currentWorkspaceMember: workspaceMembers[1],
          isAdminLeadList: false,
          isLeadList: false,
          selectedAssigneeId: 'all',
          workspaceMembers,
        }),
      ).toBeUndefined();
    });
  });

  describe('excel export cell formatting', () => {
    it('keeps phone numbers as visible text cells', () => {
      const worksheet = utils.aoa_to_sheet([
        ['Name', 'Email', 'Phone No'],
        ['LEAD-1', 'customer@example.com', '+919876543210'],
      ]);

      const range = utils.decode_range(worksheet['!ref'] ?? 'A1');

      for (let rowIndex = range.s.r; rowIndex <= range.e.r; rowIndex++) {
        for (
          let columnIndex = range.s.c;
          columnIndex <= range.e.c;
          columnIndex++
        ) {
          const cellAddress = utils.encode_cell({
            r: rowIndex,
            c: columnIndex,
          });
          const cell = worksheet[cellAddress];

          if (!cell || cell.v === undefined || cell.v === null) {
            continue;
          }

          cell.t = 's';
          cell.v = String(cell.v);
          delete cell.w;
        }
      }

      expect(worksheet.C2).toEqual({
        t: 's',
        v: '+919876543210',
      });
    });
  });
});
