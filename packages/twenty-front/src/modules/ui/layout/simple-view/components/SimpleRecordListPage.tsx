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
import { useRecoilValue } from 'recoil';

import { useCurrentUserRole } from '@/auth/hooks/useCurrentUserRole';
import { currentWorkspaceMemberState } from '@/auth/states/currentWorkspaceMemberState';
import { currentWorkspaceMembersState } from '@/auth/states/currentWorkspaceMembersState';
import { computeProgressText } from '@/action-menu/utils/computeProgressText';
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
import {
  buildContactSearchFilter,
  buildSimpleRecordListFilter,
  getLeadCustomerRelationInfo,
} from '@/ui/layout/simple-view/utils/simple-record-list-filter.utils';
import { useSimpleRecordListExport } from '@/ui/layout/simple-view/hooks/useSimpleRecordListExport';
import {
  getLeadExportAssigneeName,
  getSimpleRecordListExportTitle,
  getWorkspaceMemberDisplayName,
} from '@/ui/layout/simple-view/utils/simple-record-list-export.utils';
import { useHasPermissionFlag } from '@/settings/roles/hooks/useHasPermissionFlag';
import { Table } from '@/ui/layout/table/components/Table';
import { TableBody } from '@/ui/layout/table/components/TableBody';
import { TableCell } from '@/ui/layout/table/components/TableCell';
import { TableRow } from '@/ui/layout/table/components/TableRow';
import { IconFileExport, IconSearch } from 'twenty-ui/display';
import { MOBILE_VIEWPORT } from 'twenty-ui/theme';
import { PermissionFlagType } from '~/generated-metadata/graphql';

const TOOLBAR_STACKED_LAYOUT_MAX_WIDTH = MOBILE_VIEWPORT + 120;

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

const StyledTitleRow = styled.div`
  align-items: center;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  justify-content: space-between;
`;

const StyledTitle = styled.h1`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.xl};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
`;

const StyledExportActions = styled.div`
  display: flex;
  flex-shrink: 0;
  gap: ${({ theme }) => theme.spacing(2)};
`;

const StyledExportButton = styled.button`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  color: ${({ theme }) => theme.font.color.secondary};
  cursor: pointer;
  display: flex;
  flex-shrink: 0;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(1)};
  height: ${({ theme }) => theme.spacing(8)};
  padding: 0 ${({ theme }) => theme.spacing(3)};

  &:disabled {
    cursor: not-allowed;
    opacity: 0.6;
  }

  &:focus-visible {
    border-radius: ${({ theme }) => theme.border.radius.sm};
    outline: 1px solid ${({ theme }) => theme.color.blue};
  }
`;

const StyledToolbar = styled.div`
  container-type: inline-size;
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};

  @container (min-width: ${TOOLBAR_STACKED_LAYOUT_MAX_WIDTH}px) {
    align-items: center;
    flex-direction: row;
  }
`;

const StyledSearchRow = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.lighter};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  display: flex;
  flex: 1;
  gap: ${({ theme }) => theme.spacing(2)};
  min-width: 0;
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(4)};
  width: 100%;

  @container (min-width: ${TOOLBAR_STACKED_LAYOUT_MAX_WIDTH}px) {
    min-width: 260px;
    width: auto;
  }
`;

const StyledFiltersRow = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  width: 100%;

  @container (min-width: ${TOOLBAR_STACKED_LAYOUT_MAX_WIDTH}px) {
    flex-shrink: 0;
    width: auto;
  }
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
  flex: 1;
  gap: ${({ theme }) => theme.spacing(1)};
  height: ${({ theme }) => theme.spacing(8)};
  min-width: 0;
  padding: 0 ${({ theme }) => theme.spacing(2)} 0
    ${({ theme }) => theme.spacing(3)};

  @container (min-width: ${TOOLBAR_STACKED_LAYOUT_MAX_WIDTH}px) {
    flex: 0 0 auto;
  }
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
  flex: 1;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-width: 0;
  outline: none;

  @container (min-width: ${TOOLBAR_STACKED_LAYOUT_MAX_WIDTH}px) {
    flex: 0 1 auto;
  }

  &:focus-visible {
    border-radius: ${({ theme }) => theme.border.radius.sm};
    outline: 1px solid ${({ theme }) => theme.color.blue};
  }
`;

const StyledDateInput = styled.input`
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  flex: 1;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-width: 0;
  outline: none;

  &::-webkit-calendar-picker-indicator {
    cursor: pointer;
  }

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
  const { isAdmin } = useCurrentUserRole();
  const canExportRecords = useHasPermissionFlag(PermissionFlagType.EXPORT_CSV);
  const currentWorkspaceMember = useRecoilValue(currentWorkspaceMemberState);
  const workspaceMembers = useRecoilValue(currentWorkspaceMembersState);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedAssigneeId, setSelectedAssigneeId] = useState('all');
  const [dateFrom, setDateFrom] = useState('');
  const [dateTo, setDateTo] = useState('');
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

  const isAdminLeadList =
    objectNameSingular === 'lead' && isAdmin === true;
  const isLeadList = objectNameSingular === 'lead';

  const customerRelationInfo = useMemo(
    () => (isLeadList ? getLeadCustomerRelationInfo(objectMetadataItem) : null),
    [isLeadList, objectMetadataItem],
  );

  const customerObjectNameSingular =
    customerRelationInfo?.objectNameSingular ?? 'customer';

  const { objectMetadataItem: customerObjectMetadataItem } =
    useObjectMetadataItem({
      objectNameSingular: customerObjectNameSingular,
    });

  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  const customerSearchFilter = useMemo(
    () =>
      buildContactSearchFilter(
        deferredSearchTerm,
        customerObjectMetadataItem.fields,
      ),
    [customerObjectMetadataItem.fields, deferredSearchTerm],
  );

  const shouldSearchCustomers =
    isLeadList &&
    deferredSearchTerm.trim().length > 0 &&
    customerRelationInfo !== null;

  const { records: matchingCustomers, loading: matchingCustomersLoading } =
    useFindManyRecords({
      objectNameSingular: customerObjectNameSingular,
      filter: customerSearchFilter,
      limit: 200,
      recordGqlFields: {
        id: true,
      },
      skip: !shouldSearchCustomers,
    });

  const matchingCustomerIds = useMemo(
    () => matchingCustomers.map((customer) => customer.id),
    [matchingCustomers],
  );

  const filter = useMemo(
    () =>
      buildSimpleRecordListFilter({
        searchTerm: deferredSearchTerm,
        labelField,
        isLeadList,
        customerRelationInfo,
        matchingCustomerIds,
        selectedAssigneeId,
        isAdminLeadList,
        dateFrom,
        dateTo,
      }),
    [
      customerRelationInfo,
      dateFrom,
      dateTo,
      deferredSearchTerm,
      isAdminLeadList,
      isLeadList,
      labelField,
      matchingCustomerIds,
      selectedAssigneeId,
    ],
  );

  const shouldWaitForCustomerSearch =
    shouldSearchCustomers && matchingCustomersLoading;

  const columns = useMemo(
    () =>
      getSimpleRecordListColumns(objectMetadataItem, {
        isAdminLeadList,
      }),
    [isAdminLeadList, objectMetadataItem],
  );

  const assigneeOptions = useMemo(
    () =>
      [...workspaceMembers].sort((memberA, memberB) =>
        getWorkspaceMemberDisplayName(memberA).localeCompare(
          getWorkspaceMemberDisplayName(memberB),
        ),
      ),
    [workspaceMembers],
  );

  const exportTitle = useMemo(
    () =>
      getSimpleRecordListExportTitle({
        assigneeName: getLeadExportAssigneeName({
          currentWorkspaceMember,
          isAdminLeadList,
          isLeadList,
          selectedAssigneeId,
          workspaceMembers,
        }),
        labelPlural: objectMetadataItem.labelPlural,
      }),
    [
      currentWorkspaceMember,
      isAdminLeadList,
      isLeadList,
      objectMetadataItem.labelPlural,
      selectedAssigneeId,
      workspaceMembers,
    ],
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
      skip: shouldWaitForCustomerSearch,
    });

  const isLoadingRecords = loading || shouldWaitForCustomerSearch;

  const { exportCsv, exportExcel, exportPdf, isExporting, progress } =
    useSimpleRecordListExport({
      columns,
      effectiveSort,
      exportTitle,
      filter,
      objectMetadataItem,
      orderBy,
      recordGqlFields,
    });

  const exportProgressText = computeProgressText(
    isExporting ? progress : undefined,
  );

  const isExportDisabled = isExporting || shouldWaitForCustomerSearch;

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
        if (entry.isIntersecting && hasNextPage && !isLoadingRecords) {
          fetchMoreRecords?.();
        }
      },
      { root: scrollContainer, threshold: 0.1 },
    );

    observer.observe(sentinel);

    return () => {
      observer.disconnect();
    };
  }, [hasNextPage, isLoadingRecords, fetchMoreRecords]);

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
  const assigneeFilterSelectId = `${objectMetadataItem.nameSingular}-simple-list-assignee-filter`;
  const dateFromInputId = `${objectMetadataItem.nameSingular}-simple-list-date-from`;
  const dateToInputId = `${objectMetadataItem.nameSingular}-simple-list-date-to`;
  const hasActiveFilters =
    searchTerm.trim().length > 0 ||
    selectedAssigneeId !== 'all' ||
    dateFrom.length > 0 ||
    dateTo.length > 0;
  const searchPlaceholder = isLeadList
    ? t`Search leads, customer name, email, phone...`
    : t`Search ${lowerCaseLabelPlural}...`;
  const gridAutoColumns = `64px ${columns
    .map((column) => column.width)
    .join(' ')} 88px`;

  return (
    <StyledContainer>
      <StyledHeader>
        <StyledTitleRow>
          <StyledTitle>{labelPlural}</StyledTitle>
          {canExportRecords && (
            <StyledExportActions>
              <StyledExportButton
                type="button"
                disabled={isExportDisabled}
                onClick={() => {
                  void exportCsv();
                }}
              >
                <IconFileExport size={16} />
                {t`CSV${exportProgressText}`}
              </StyledExportButton>
              <StyledExportButton
                type="button"
                disabled={isExportDisabled}
                onClick={() => {
                  void exportExcel();
                }}
              >
                <IconFileExport size={16} />
                {t`Excel${exportProgressText}`}
              </StyledExportButton>
              <StyledExportButton
                type="button"
                disabled={isExportDisabled}
                onClick={() => {
                  void exportPdf();
                }}
              >
                <IconFileExport size={16} />
                {t`PDF${exportProgressText}`}
              </StyledExportButton>
            </StyledExportActions>
          )}
        </StyledTitleRow>

        <StyledToolbar>
          <StyledSearchRow>
            <StyledSearchIcon>
              <IconSearch size={16} />
            </StyledSearchIcon>
            <StyledSearchInput
              aria-label={t`Search ${labelPlural}`}
              placeholder={searchPlaceholder}
              value={searchTerm}
              onChange={(event) => setSearchTerm(event.target.value)}
            />
          </StyledSearchRow>
          <StyledFiltersRow>
            {isAdminLeadList && (
              <StyledSortControl>
                <StyledSortLabel htmlFor={assigneeFilterSelectId}>
                  <Trans>Assignee</Trans>
                </StyledSortLabel>
                <StyledSortSelect
                  id={assigneeFilterSelectId}
                  value={selectedAssigneeId}
                  onChange={(event) =>
                    setSelectedAssigneeId(event.target.value)
                  }
                >
                  <option value="all">{t`All assignees`}</option>
                  {assigneeOptions.map((workspaceMember) => (
                    <option key={workspaceMember.id} value={workspaceMember.id}>
                      {getWorkspaceMemberDisplayName(workspaceMember)}
                    </option>
                  ))}
                </StyledSortSelect>
              </StyledSortControl>
            )}
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
                    <option
                      key={`${column.key}:asc`}
                      value={`${column.key}:asc`}
                    >
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
            {isLeadList && (
              <>
                <StyledSortControl>
                  <StyledSortLabel htmlFor={dateFromInputId}>
                    <Trans>From</Trans>
                  </StyledSortLabel>
                  <StyledDateInput
                    id={dateFromInputId}
                    type="date"
                    value={dateFrom}
                    onChange={(event) => setDateFrom(event.target.value)}
                  />
                </StyledSortControl>
                <StyledSortControl>
                  <StyledSortLabel htmlFor={dateToInputId}>
                    <Trans>To</Trans>
                  </StyledSortLabel>
                  <StyledDateInput
                    id={dateToInputId}
                    type="date"
                    value={dateTo}
                    onChange={(event) => setDateTo(event.target.value)}
                  />
                </StyledSortControl>
              </>
            )}
          </StyledFiltersRow>
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

        {!isLoadingRecords && records.length === 0 && (
          <StyledEmptyState>
            {hasActiveFilters
              ? t`No records match your search`
              : t`No ${lowerCaseLabelPlural} yet`}
          </StyledEmptyState>
        )}

        {isLoadingRecords && records.length === 0 && (
          <StyledEmptyState>
            <Trans>Loading...</Trans>
          </StyledEmptyState>
        )}

        {hasNextPage && (
          <StyledLoadingSentinel ref={sentinelRef}>
            {isLoadingRecords ? t`Loading more...` : ''}
          </StyledLoadingSentinel>
        )}
      </StyledList>
    </StyledContainer>
  );
};
