import styled from '@emotion/styled';
import {
  useCallback,
  useDeferredValue,
  useEffect,
  useMemo,
  useRef,
  useState,
} from 'react';
import { useNavigate } from 'react-router-dom';
import { Trans, useLingui } from '@lingui/react/macro';

import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useGenerateDepthRecordGqlFieldsFromObject } from '@/object-record/graphql/record-gql-fields/hooks/useGenerateDepthRecordGqlFieldsFromObject';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import {
  getSimpleRecordFieldValue,
  getSimpleRecordListColumns,
  getSimpleRecordListOrderBy,
  sortSimpleRecordsForList,
  type SimpleRecordListSort,
} from '@/ui/layout/simple-view/utils/simple-record-table.utils';
import { Table } from '@/ui/layout/table/components/Table';
import { TableBody } from '@/ui/layout/table/components/TableBody';
import { TableCell } from '@/ui/layout/table/components/TableCell';
import { TableRow } from '@/ui/layout/table/components/TableRow';
import { FieldMetadataType } from 'twenty-shared/types';
import { IconSearch } from 'twenty-ui/display';

const StyledContainer = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  max-width: 100%;
  min-height: 0;
  overflow: hidden;
  width: 100%;
`;

const StyledHeader = styled.div`
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
`;

const StyledTitle = styled.h1`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.xl};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
`;

const StyledToolbar = styled.div`
  align-items: center;
  display: flex;
  flex-wrap: wrap;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledSearchRow = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.lighter};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  display: flex;
  flex: 1;
  gap: ${({ theme }) => theme.spacing(2)};
  min-width: 260px;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(4)};
`;

const StyledSearchIcon = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  display: flex;
  flex-shrink: 0;
`;

const StyledSearchInput = styled.input`
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  outline: none;

  &::placeholder {
    color: ${({ theme }) => theme.font.color.light};
  }
`;

const StyledSortControl = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  color: ${({ theme }) => theme.font.color.secondary};
  display: flex;
  flex-shrink: 0;
  gap: ${({ theme }) => theme.spacing(1)};
  height: ${({ theme }) => theme.spacing(8)};
  padding: 0 ${({ theme }) => theme.spacing(2)} 0
    ${({ theme }) => theme.spacing(3)};
`;

const StyledSortLabel = styled.label`
  color: ${({ theme }) => theme.font.color.tertiary};
  flex-shrink: 0;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
`;

const StyledSortSelect = styled.select`
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  outline: none;

  &:focus-visible {
    border-radius: ${({ theme }) => theme.border.radius.sm};
    outline: 1px solid ${({ theme }) => theme.color.blue};
  }
`;

const StyledList = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  min-height: 0;
  overflow-y: auto;
  padding: 0 ${({ theme }) => theme.spacing(4)}
    ${({ theme }) => theme.spacing(4)};
`;

const StyledTableWrapper = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.light};
  border-radius: ${({ theme }) => theme.border.radius.md};
  box-shadow: ${({ theme }) => theme.boxShadow.light};
  min-width: 100%;
`;

const StyledTableScroll = styled.div`
  -webkit-overflow-scrolling: touch;
  overflow-x: auto;
  overflow-y: visible;
  width: 100%;
`;

const StyledHeaderCell = styled(TableCell)`
  background: ${({ theme }) => theme.background.transparent.lighter};
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  height: ${({ theme }) => theme.spacing(8)};
`;

const StyledPinnedHeaderCell = styled(StyledHeaderCell)`
  background: ${({ theme }) => theme.background.secondary};
  box-shadow: -4px 0 8px ${({ theme }) => theme.background.transparent.light};
  position: sticky;
  right: 0;
  z-index: 2;
`;

const StyledBodyRow = styled(TableRow)`
  border-top: 1px solid ${({ theme }) => theme.border.color.light};
`;

const StyledBodyCell = styled(TableCell)`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  height: ${({ theme }) => theme.spacing(9)};
  overflow: hidden;

  > span {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
`;

const StyledPinnedBodyCell = styled(StyledBodyCell)`
  background: ${({ theme }) => theme.background.secondary};
  box-shadow: -4px 0 8px ${({ theme }) => theme.background.transparent.light};
  position: sticky;
  right: 0;
  z-index: 1;
`;

const StyledMutedValue = styled.span`
  color: ${({ theme }) => theme.font.color.tertiary};
`;

const StyledViewButton = styled.button`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.color.blue};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  padding: ${({ theme }) => theme.spacing(1.5)} ${({ theme }) => theme.spacing(2.5)};
  transition: background-color
    ${({ theme }) => theme.animation.duration.normal}s;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }

  &:focus-visible {
    outline: 2px solid ${({ theme }) => theme.color.blue};
    outline-offset: 2px;
  }
`;

const StyledEmptyState = styled.div`
  align-items: center;
  color: ${({ theme }) => theme.font.color.tertiary};
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.md};
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(10)};
`;

const StyledLoadingSentinel = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.md};
  padding: ${({ theme }) => theme.spacing(3)};
  text-align: center;
`;

export const SimpleRecordListPage = ({
  objectNameSingular,
}: {
  objectNameSingular: string;
}) => {
  const navigate = useNavigate();
  const { t } = useLingui();
  const [searchTerm, setSearchTerm] = useState('');
  const [sort, setSort] = useState<SimpleRecordListSort>({
    direction: 'asc',
    field: 'name',
  });
  const deferredSearchTerm = useDeferredValue(searchTerm);
  const sentinelRef = useRef<HTMLDivElement>(null);
  const listRef = useRef<HTMLDivElement>(null);

  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular,
  });

  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  const filter = useMemo(() => {
    if (!deferredSearchTerm || !labelField) return undefined;

    if (labelField.type === FieldMetadataType.FULL_NAME) {
      return {
        or: [
          {
            [labelField.name]: {
              firstName: { ilike: `%${deferredSearchTerm}%` },
            },
          },
          {
            [labelField.name]: {
              lastName: { ilike: `%${deferredSearchTerm}%` },
            },
          },
        ],
      };
    }

    return { [labelField.name]: { ilike: `%${deferredSearchTerm}%` } };
  }, [deferredSearchTerm, labelField]);

  const columns = useMemo(
    () => getSimpleRecordListColumns(objectMetadataItem),
    [objectMetadataItem],
  );

  const effectiveSort = useMemo(
    () =>
      columns.some((column) => column.key === sort.field)
        ? sort
        : {
            direction: 'asc' as const,
            field: columns[0]?.key ?? 'name',
          },
    [columns, sort],
  );

  const orderBy = useMemo(
    () => getSimpleRecordListOrderBy(effectiveSort),
    [effectiveSort],
  );

  const { recordGqlFields } = useGenerateDepthRecordGqlFieldsFromObject({
    objectNameSingular,
    depth: 1,
    shouldOnlyLoadRelationIdentifiers: false,
  });

  const { records, loading, fetchMoreRecords, hasNextPage } =
    useFindManyRecords({
      objectNameSingular,
      filter,
      orderBy,
      recordGqlFields,
      limit: 30,
    });

  const sortedRecords = useMemo(
    () =>
      sortSimpleRecordsForList(
        records,
        effectiveSort,
        columns,
        objectMetadataItem,
      ),
    [records, effectiveSort, columns, objectMetadataItem],
  );

  // Auto-load more when sentinel becomes visible
  useEffect(() => {
    const sentinel = sentinelRef.current;
    const scrollContainer = listRef.current;
    if (!sentinel || !scrollContainer) return;

    const observer = new IntersectionObserver(
      (entries) => {
        const entry = entries[0];
        if (entry.isIntersecting && hasNextPage && !loading) {
          fetchMoreRecords?.();
        }
      },
      { root: scrollContainer, threshold: 0.1 },
    );

    observer.observe(sentinel);

    return () => {
      observer.disconnect();
    };
  }, [hasNextPage, loading, fetchMoreRecords]);

  const handleViewButtonClick = useCallback(
    (recordId: string) => {
      navigate(`/object/${objectMetadataItem.nameSingular}/${recordId}`);
    },
    [navigate, objectMetadataItem.nameSingular],
  );

  const handleSortChange = (value: string) => {
    const [field, direction] = value.split(':');

    setSort({
      direction: direction === 'desc' ? 'desc' : 'asc',
      field,
    });
  };

  const labelPlural = objectMetadataItem.labelPlural;
  const lowerCaseLabelPlural = objectMetadataItem.labelPlural.toLowerCase();
  const sortSelectId = `${objectMetadataItem.nameSingular}-simple-list-sort`;
  const gridAutoColumns = `64px ${columns
    .map((column) => column.width)
    .join(' ')} 88px`;

  return (
    <StyledContainer>
      <StyledHeader>
        <StyledTitle>{labelPlural}</StyledTitle>

        <StyledToolbar>
          <StyledSearchRow>
            <StyledSearchIcon>
              <IconSearch size={16} />
            </StyledSearchIcon>
            <StyledSearchInput
              aria-label={t`Search ${labelPlural}`}
              placeholder={t`Search ${lowerCaseLabelPlural}...`}
              value={searchTerm}
              onChange={(event) => setSearchTerm(event.target.value)}
            />
          </StyledSearchRow>
          <StyledSortControl>
            <StyledSortLabel htmlFor={sortSelectId}>
              <Trans>Sort</Trans>
            </StyledSortLabel>
            <StyledSortSelect
              id={sortSelectId}
              value={`${effectiveSort.field}:${effectiveSort.direction}`}
              onChange={(event) => handleSortChange(event.target.value)}
            >
              {columns.flatMap((column) => {
                const columnLabel = column.label;

                return [
                  <option key={`${column.key}:asc`} value={`${column.key}:asc`}>
                    {t`${columnLabel} ascending`}
                  </option>,
                  <option
                    key={`${column.key}:desc`}
                    value={`${column.key}:desc`}
                  >
                    {t`${columnLabel} descending`}
                  </option>,
                ];
              })}
            </StyledSortSelect>
          </StyledSortControl>
        </StyledToolbar>
      </StyledHeader>

      <StyledList ref={listRef}>
        {sortedRecords.length > 0 && (
          <StyledTableWrapper>
            <StyledTableScroll>
              <Table>
                <TableBody>
                  <TableRow gridAutoColumns={gridAutoColumns}>
                    <StyledHeaderCell>
                      <Trans>No</Trans>
                    </StyledHeaderCell>
                    {columns.map((column) => (
                      <StyledHeaderCell key={column.key}>
                        {column.label}
                      </StyledHeaderCell>
                    ))}
                    <StyledPinnedHeaderCell align="center">
                      <Trans>Action</Trans>
                    </StyledPinnedHeaderCell>
                  </TableRow>

                  {sortedRecords.map((record, index) => {
                    return (
                      <StyledBodyRow
                        key={record.id}
                        gridAutoColumns={gridAutoColumns}
                      >
                        <StyledBodyCell>
                          <span>{index + 1}</span>
                        </StyledBodyCell>
                        {columns.map((column) => {
                          const fieldValue = getSimpleRecordFieldValue(
                            record,
                            column,
                            objectMetadataItem,
                          );

                          return (
                            <StyledBodyCell key={column.key}>
                              {fieldValue !== '-' ? (
                                <span>{fieldValue}</span>
                              ) : (
                                <StyledMutedValue>-</StyledMutedValue>
                              )}
                            </StyledBodyCell>
                          );
                        })}
                        <StyledPinnedBodyCell align="center">
                          <StyledViewButton
                            type="button"
                            onClick={() => handleViewButtonClick(record.id)}
                          >
                            <Trans>View</Trans>
                          </StyledViewButton>
                        </StyledPinnedBodyCell>
                      </StyledBodyRow>
                    );
                  })}
                </TableBody>
              </Table>
            </StyledTableScroll>
          </StyledTableWrapper>
        )}

        {!loading && records.length === 0 && (
          <StyledEmptyState>
            {searchTerm
              ? t`No records match your search`
              : t`No ${lowerCaseLabelPlural} yet`}
          </StyledEmptyState>
        )}

        {loading && records.length === 0 && (
          <StyledEmptyState>
            <Trans>Loading...</Trans>
          </StyledEmptyState>
        )}

        {hasNextPage && (
          <StyledLoadingSentinel ref={sentinelRef}>
            {loading ? t`Loading more...` : ''}
          </StyledLoadingSentinel>
        )}
      </StyledList>
    </StyledContainer>
  );
};
