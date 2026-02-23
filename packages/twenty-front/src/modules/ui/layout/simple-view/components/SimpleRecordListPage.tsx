import styled from '@emotion/styled';
import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';

import { useObjectMetadataItem } from '@/object-metadata/hooks/useObjectMetadataItem';
import { useFindManyRecords } from '@/object-record/hooks/useFindManyRecords';
import { SimpleRecordListCard } from '@/ui/layout/simple-view/components/SimpleRecordListCard';
import { FieldMetadataType } from 'twenty-shared/types';
import { IconSearch } from 'twenty-ui/display';

const StyledContainer = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  max-width: 100%;
  overflow: hidden;
  width: 100%;
`;

const StyledSearchWrapper = styled.div`
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
`;

const StyledSearchRow = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.lighter};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.pill};
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
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

const StyledList = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  min-height: 0;
  overflow-y: auto;
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
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => theme.spacing(3)};
  text-align: center;
`;

export const SimpleRecordListPage = ({
  objectNameSingular,
}: {
  objectNameSingular: string;
}) => {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState('');
  const sentinelRef = useRef<HTMLDivElement>(null);
  const listRef = useRef<HTMLDivElement>(null);

  const { objectMetadataItem } = useObjectMetadataItem({
    objectNameSingular,
  });

  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  const filter = useMemo(() => {
    if (!searchTerm || !labelField) return undefined;

    if (labelField.type === FieldMetadataType.FULL_NAME) {
      return {
        or: [
          {
            [labelField.name]: {
              firstName: { ilike: `%${searchTerm}%` },
            },
          },
          {
            [labelField.name]: {
              lastName: { ilike: `%${searchTerm}%` },
            },
          },
        ],
      };
    }

    return { [labelField.name]: { ilike: `%${searchTerm}%` } };
  }, [searchTerm, labelField]);

  const orderBy = useMemo(
    () => [{ createdAt: 'DescNullsLast' as const }],
    [],
  );

  const { records, loading, fetchMoreRecords, hasNextPage } =
    useFindManyRecords({
      objectNameSingular,
      filter,
      orderBy,
      limit: 30,
    });

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

  const handleRowClick = useCallback(
    (recordId: string) => {
      navigate(
        `/object/${objectMetadataItem.nameSingular}/${recordId}`,
      );
    },
    [navigate, objectMetadataItem.nameSingular],
  );

  return (
    <StyledContainer>
      <StyledSearchWrapper>
        <StyledSearchRow>
          <StyledSearchIcon>
            <IconSearch size={16} />
          </StyledSearchIcon>
          <StyledSearchInput
            placeholder="Search..."
            value={searchTerm}
            onChange={(event) => setSearchTerm(event.target.value)}
          />
        </StyledSearchRow>
      </StyledSearchWrapper>

      <StyledList ref={listRef}>
        {records.map((record) => (
          <SimpleRecordListCard
            key={record.id}
            record={record}
            objectMetadataItem={objectMetadataItem}
            onClick={() => handleRowClick(record.id)}
          />
        ))}

        {!loading && records.length === 0 && (
          <StyledEmptyState>
            {searchTerm
              ? 'No records match your search'
              : `No ${objectMetadataItem.labelPlural.toLowerCase()} yet`}
          </StyledEmptyState>
        )}

        {loading && records.length === 0 && (
          <StyledEmptyState>Loading...</StyledEmptyState>
        )}

        {hasNextPage && (
          <StyledLoadingSentinel ref={sentinelRef}>
            {loading ? 'Loading more...' : ''}
          </StyledLoadingSentinel>
        )}
      </StyledList>
    </StyledContainer>
  );
};
