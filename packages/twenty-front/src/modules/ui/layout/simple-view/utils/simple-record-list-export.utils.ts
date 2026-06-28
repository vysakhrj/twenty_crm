import { json2csv } from 'json-2-csv';
import { saveAs } from 'file-saver';
import { utils, write, type WorkSheet } from 'xlsx-ugnis';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import {
  getSimpleRecordFieldValue,
  type SimpleRecordListColumn,
} from '@/ui/layout/simple-view/utils/simple-record-table.utils';
import { formatValueForCSV } from '@/spreadsheet-import/utils/formatValueForCSV';
import { sanitizeValueForCSVExport } from '@/spreadsheet-import/utils/sanitizeValueForCSVExport';

type WorkspaceMemberName = {
  name: { firstName?: string | null; lastName?: string | null };
};

export const getWorkspaceMemberDisplayName = (
  workspaceMember: WorkspaceMemberName,
) =>
  `${workspaceMember.name.firstName ?? ''} ${workspaceMember.name.lastName ?? ''}`.trim();

export const getLeadExportAssigneeName = ({
  currentWorkspaceMember,
  isAdminLeadList,
  isLeadList,
  selectedAssigneeId,
  workspaceMembers,
}: {
  currentWorkspaceMember?: (WorkspaceMemberName & { id: string }) | null;
  isAdminLeadList: boolean;
  isLeadList: boolean;
  selectedAssigneeId: string;
  workspaceMembers: (WorkspaceMemberName & { id: string })[];
}): string | undefined => {
  if (!isLeadList) {
    return undefined;
  }

  if (isAdminLeadList && selectedAssigneeId !== 'all') {
    const selectedMember = workspaceMembers.find(
      (workspaceMember) => workspaceMember.id === selectedAssigneeId,
    );

    if (!selectedMember) {
      return undefined;
    }

    const selectedMemberName = getWorkspaceMemberDisplayName(selectedMember);

    return selectedMemberName.length > 0 ? selectedMemberName : undefined;
  }

  if (!isAdminLeadList && currentWorkspaceMember) {
    const currentMemberName = getWorkspaceMemberDisplayName(
      currentWorkspaceMember,
    );

    return currentMemberName.length > 0 ? currentMemberName : undefined;
  }

  return undefined;
};

export const getSimpleRecordListExportTitle = ({
  assigneeName,
  labelPlural,
}: {
  assigneeName?: string;
  labelPlural: string;
}) => (assigneeName ? `${labelPlural} - ${assigneeName}` : labelPlural);

export const getSimpleRecordListExportFilename = ({
  baseName,
  extension,
}: {
  baseName: string;
  extension: string;
}) => {
  const sanitizedBaseName = baseName.trim().replace(/[/\\?%*:|"<>]/g, '-');

  return `${sanitizedBaseName}.${extension}`;
};

export const buildSimpleRecordListExportRows = (
  records: ObjectRecord[],
  columns: SimpleRecordListColumn[],
  objectMetadataItem: ObjectMetadataItem,
) =>
  records.map((record) => {
    const row: Record<string, string> = {};

    for (const column of columns) {
      const fieldValue = getSimpleRecordFieldValue(
        record,
        column,
        objectMetadataItem,
      );

      row[column.label] = fieldValue === '-' ? '' : fieldValue;
    }

    return row;
  });

const sanitizeExportRows = (
  rows: Record<string, string>[],
  columns: SimpleRecordListColumn[],
) =>
  rows.map((row) => {
    const sanitizedRow: Record<string, string> = {};

    for (const column of columns) {
      sanitizedRow[column.label] = sanitizeValueForCSVExport(
        row[column.label] ?? '',
      );
    }

    return sanitizedRow;
  });

const formatWorksheetCellsAsText = (worksheet: WorkSheet) => {
  const reference = worksheet['!ref'];

  if (!reference) {
    return;
  }

  const range = utils.decode_range(reference);

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
};

export const downloadSimpleRecordListCsv = ({
  columns,
  filename,
  rows,
}: {
  columns: SimpleRecordListColumn[];
  filename: string;
  rows: Record<string, string>[];
}) => {
  if (rows.length === 0) {
    return;
  }

  const sanitizedRows = sanitizeExportRows(rows, columns);
  const keys = columns.map((column) => ({
    field: column.label,
    title: formatValueForCSV(sanitizeValueForCSVExport(column.label)),
  }));

  const csvContent = json2csv(sanitizedRows, {
    emptyFieldValue: '',
    keys,
  });

  saveAs(new Blob([csvContent], { type: 'text/csv' }), filename);
};

export const downloadSimpleRecordListExcel = ({
  columns,
  filename,
  rows,
}: {
  columns: SimpleRecordListColumn[];
  filename: string;
  rows: Record<string, string>[];
}) => {
  if (rows.length === 0) {
    return;
  }

  const headers = columns.map((column) => column.label);
  const dataRows = rows.map((row) =>
    columns.map((column) => row[column.label] ?? ''),
  );

  const worksheet = utils.aoa_to_sheet([headers, ...dataRows]);
  formatWorksheetCellsAsText(worksheet);
  const workbook = utils.book_new();

  utils.book_append_sheet(workbook, worksheet, 'Export');

  const xlsxArrayBuffer = write(workbook, {
    bookType: 'xlsx',
    type: 'array',
  }) as ArrayBuffer;

  saveAs(
    new Blob([xlsxArrayBuffer], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    }),
    filename,
  );
};
