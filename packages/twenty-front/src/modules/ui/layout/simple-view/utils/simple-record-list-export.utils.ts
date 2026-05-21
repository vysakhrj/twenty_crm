import { json2csv } from 'json-2-csv';
import { saveAs } from 'file-saver';
import { utils, write } from 'xlsx-ugnis';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import {
  getSimpleRecordFieldValue,
  type SimpleRecordListColumn,
} from '@/ui/layout/simple-view/utils/simple-record-table.utils';
import { formatValueForCSV } from '@/spreadsheet-import/utils/formatValueForCSV';
import { sanitizeValueForCSVExport } from '@/spreadsheet-import/utils/sanitizeValueForCSVExport';

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

  const sanitizedRows = sanitizeExportRows(rows, columns);
  const headers = columns.map((column) => column.label);
  const dataRows = sanitizedRows.map((row) =>
    columns.map((column) => row[column.label] ?? ''),
  );

  const worksheet = utils.aoa_to_sheet([headers, ...dataRows]);
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
