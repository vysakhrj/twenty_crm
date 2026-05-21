import {
  Document,
  Font,
  Page,
  StyleSheet,
  Text,
  View,
  pdf,
} from '@react-pdf/renderer';
import { saveAs } from 'file-saver';

import { type SimpleRecordListColumn } from '@/ui/layout/simple-view/utils/simple-record-table.utils';

const ROWS_PER_PAGE = 24;

const registerInterFonts = (() => {
  let registrationPromise: Promise<void> | null = null;

  return () => {
    if (!registrationPromise) {
      registrationPromise = Promise.resolve().then(() => {
        Font.register({
          family: 'Inter',
          fonts: [
            {
              src: 'https://fonts.gstatic.com/s/inter/v19/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfMZg.ttf',
              fontWeight: 400,
            },
            {
              src: 'https://fonts.gstatic.com/s/inter/v19/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuI6fMZg.ttf',
              fontWeight: 500,
            },
            {
              src: 'https://fonts.gstatic.com/s/inter/v19/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYMZg.ttf',
              fontWeight: 600,
            },
          ],
        });
      });
    }

    return registrationPromise;
  };
})();

const styles = StyleSheet.create({
  page: {
    fontFamily: 'Inter',
    paddingBottom: 28,
    paddingHorizontal: 24,
    paddingTop: 24,
  },
  title: {
    color: '#141414',
    fontSize: 16,
    fontWeight: 600,
    marginBottom: 16,
  },
  table: {
    border: '1px solid #dddddd',
    borderRadius: 4,
    width: '100%',
  },
  headerRow: {
    backgroundColor: '#f1f1f1',
    borderBottom: '1px solid #dddddd',
    flexDirection: 'row',
  },
  headerCell: {
    borderRight: '1px solid #dddddd',
    color: '#666666',
    flex: 1,
    fontSize: 9,
    fontWeight: 600,
    paddingHorizontal: 6,
    paddingVertical: 8,
  },
  headerNumberCell: {
    borderRight: '1px solid #dddddd',
    color: '#666666',
    fontSize: 9,
    fontWeight: 600,
    paddingHorizontal: 6,
    paddingVertical: 8,
    width: 28,
  },
  bodyRow: {
    borderBottom: '1px solid #eeeeee',
    flexDirection: 'row',
  },
  bodyCell: {
    borderRight: '1px solid #eeeeee',
    color: '#141414',
    flex: 1,
    fontSize: 9,
    paddingHorizontal: 6,
    paddingVertical: 7,
  },
  bodyNumberCell: {
    borderRight: '1px solid #eeeeee',
    color: '#141414',
    fontSize: 9,
    paddingHorizontal: 6,
    paddingVertical: 7,
    width: 28,
  },
  mutedText: {
    color: '#999999',
  },
  footer: {
    bottom: 16,
    color: '#999999',
    fontSize: 8,
    left: 24,
    position: 'absolute',
    right: 24,
    textAlign: 'right',
  },
});

const chunkRows = <TRow,>(rows: TRow[], chunkSize: number): TRow[][] => {
  const chunks: TRow[][] = [];

  for (let index = 0; index < rows.length; index += chunkSize) {
    chunks.push(rows.slice(index, index + chunkSize));
  }

  return chunks;
};

type SimpleRecordListPdfDocumentProps = {
  headers: string[];
  pages: string[][][];
  title: string;
};

const SimpleRecordListPdfDocument = ({
  headers,
  pages,
  title,
}: SimpleRecordListPdfDocumentProps) => (
  <Document>
    {pages.map((pageRows, pageIndex) => (
      <Page key={pageIndex} orientation="landscape" size="A4" style={styles.page}>
        {pageIndex === 0 && <Text style={styles.title}>{title}</Text>}
        <View style={styles.table}>
          <View style={styles.headerRow}>
            {headers.map((header, headerIndex) => (
              <Text
                key={header}
                style={
                  headerIndex === 0
                    ? styles.headerNumberCell
                    : styles.headerCell
                }
              >
                {header}
              </Text>
            ))}
          </View>
          {pageRows.map((row, rowIndex) => (
            <View key={`${pageIndex}-${rowIndex}`} style={styles.bodyRow}>
              {row.map((cellValue, cellIndex) => (
                <Text
                  key={`${pageIndex}-${rowIndex}-${cellIndex}`}
                  style={
                    cellIndex === 0
                      ? cellValue === '-'
                        ? [styles.bodyNumberCell, styles.mutedText]
                        : styles.bodyNumberCell
                      : cellValue === '-'
                        ? [styles.bodyCell, styles.mutedText]
                        : styles.bodyCell
                  }
                >
                  {cellValue}
                </Text>
              ))}
            </View>
          ))}
        </View>
        <Text style={styles.footer}>
          {pageIndex + 1} / {pages.length}
        </Text>
      </Page>
    ))}
  </Document>
);

export const downloadSimpleRecordListPdf = async ({
  columns,
  filename,
  rows,
  title,
}: {
  columns: SimpleRecordListColumn[];
  filename: string;
  rows: Record<string, string>[];
  title: string;
}) => {
  if (rows.length === 0) {
    return;
  }

  await registerInterFonts();

  const headers = ['No', ...columns.map((column) => column.label)];
  const tableRows = rows.map((row, index) => [
    String(index + 1),
    ...columns.map((column) => {
      const cellValue = row[column.label];

      return cellValue && cellValue.length > 0 ? cellValue : '-';
    }),
  ]);
  const pages = chunkRows(tableRows, ROWS_PER_PAGE);

  const blob = await pdf(
    <SimpleRecordListPdfDocument
      headers={headers}
      pages={pages}
      title={title}
    />,
  ).toBlob();

  saveAs(blob, filename);
};
