import { useCallback } from 'react';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { EXPORT_TABLE_DATA_DEFAULT_PAGE_SIZE } from '@/object-record/object-options-dropdown/constants/ExportTableDataDefaultPageSize';
import { useLazyFetchAllRecords } from '@/object-record/hooks/useLazyFetchAllRecords';
import {
  downloadSimpleRecordListCsv,
  downloadSimpleRecordListExcel,
  buildSimpleRecordListExportRows,
  getSimpleRecordListExportFilename,
} from '@/ui/layout/simple-view/utils/simple-record-list-export.utils';
import { downloadSimpleRecordListPdf } from '@/ui/layout/simple-view/utils/simple-record-list-pdf.utils';
import {
  sortSimpleRecordsForList,
  type SimpleRecordListColumn,
  type SimpleRecordListSort,
} from '@/ui/layout/simple-view/utils/simple-record-table.utils';
import { type RecordGqlOperationFilter } from 'twenty-shared/types';
import {
  type RecordGqlOperationGqlRecordFields,
  type RecordGqlOperationOrderBy,
} from 'twenty-shared/types';

type UseSimpleRecordListExportParams = {
  columns: SimpleRecordListColumn[];
  effectiveSort: SimpleRecordListSort;
  exportTitle: string;
  filter?: RecordGqlOperationFilter;
  objectMetadataItem: ObjectMetadataItem;
  orderBy: RecordGqlOperationOrderBy;
  recordGqlFields?: RecordGqlOperationGqlRecordFields;
};

export const useSimpleRecordListExport = ({
  columns,
  effectiveSort,
  exportTitle,
  filter,
  objectMetadataItem,
  orderBy,
  recordGqlFields,
}: UseSimpleRecordListExportParams) => {
  const { fetchAllRecords, isDownloading, progress } = useLazyFetchAllRecords({
    delayMs: 100,
    filter,
    objectNameSingular: objectMetadataItem.nameSingular,
    orderBy,
    pageSize: EXPORT_TABLE_DATA_DEFAULT_PAGE_SIZE,
    recordGqlFields,
  });

  const fetchExportRows = useCallback(async () => {
    const records = await fetchAllRecords();

    const sortedRecords = sortSimpleRecordsForList(
      records,
      effectiveSort,
      columns,
      objectMetadataItem,
    );

    return buildSimpleRecordListExportRows(
      sortedRecords,
      columns,
      objectMetadataItem,
    );
  }, [
    columns,
    effectiveSort,
    fetchAllRecords,
    objectMetadataItem,
  ]);

  const exportCsv = useCallback(async () => {
    const rows = await fetchExportRows();

    downloadSimpleRecordListCsv({
      columns,
      filename: getSimpleRecordListExportFilename({
        baseName: exportTitle,
        extension: 'csv',
      }),
      rows,
    });
  }, [columns, exportTitle, fetchExportRows]);

  const exportExcel = useCallback(async () => {
    const rows = await fetchExportRows();

    downloadSimpleRecordListExcel({
      columns,
      filename: getSimpleRecordListExportFilename({
        baseName: exportTitle,
        extension: 'xlsx',
      }),
      rows,
    });
  }, [columns, exportTitle, fetchExportRows]);

  const exportPdf = useCallback(async () => {
    const rows = await fetchExportRows();

    await downloadSimpleRecordListPdf({
      columns,
      filename: getSimpleRecordListExportFilename({
        baseName: exportTitle,
        extension: 'pdf',
      }),
      rows,
      title: objectMetadataItem.labelPlural,
    });
  }, [
    columns,
    exportTitle,
    fetchExportRows,
    objectMetadataItem.labelPlural,
  ]);

  return {
    exportCsv,
    exportExcel,
    exportPdf,
    isExporting: isDownloading,
    progress,
  };
};
