import styled from '@emotion/styled';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { IconChevronRight } from 'twenty-ui/display';
import { FieldMetadataType } from 'twenty-shared/types';

const StyledRow = styled.div`
  align-items: center;
  border-bottom: 1px solid ${({ theme }) => theme.border.color.light};
  cursor: pointer;
  display: flex;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};

  &:active {
    background: ${({ theme }) => theme.background.transparent.lighter};
  }
`;

const StyledTextContainer = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
`;

const StyledName = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
`;

const StyledSubText = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
`;

const StyledDot = styled.div<{ dotColor?: string }>`
  background: ${({ dotColor }) => dotColor ?? '#e57373'};
  border-radius: 50%;
  flex-shrink: 0;
  height: 10px;
  width: 10px;
`;

const StyledChevron = styled.div`
  color: ${({ theme }) => theme.font.color.light};
  display: flex;
  flex-shrink: 0;
`;

const getRecordDisplayName = (
  record: ObjectRecord,
  objectMetadataItem: ObjectMetadataItem,
): string => {
  const labelField = objectMetadataItem.fields.find(
    (field) => field.id === objectMetadataItem.labelIdentifierFieldMetadataId,
  );

  if (!labelField) {
    return record.name ?? record.id;
  }

  const value = record[labelField.name];

  if (labelField.type === FieldMetadataType.FULL_NAME) {
    const firstName = value?.firstName ?? '';
    const lastName = value?.lastName ?? '';
    return `${firstName} ${lastName}`.trim() || record.id;
  }

  return String(value ?? record.id);
};

const getSelectFieldValue = (
  record: ObjectRecord,
  objectMetadataItem: ObjectMetadataItem,
): { label: string; color?: string } | null => {
  const selectField = objectMetadataItem.fields.find(
    (field) =>
      field.type === FieldMetadataType.SELECT &&
      field.isActive &&
      !field.isSystem,
  );

  if (!selectField) return null;

  const value = record[selectField.name];
  if (!value) return null;

  const option = selectField.options?.find(
    (opt) => opt.value === value,
  );

  return option
    ? { label: option.label, color: option.color }
    : { label: String(value) };
};

// Extract display names from relation fields (Customer, Property, etc.)
const getRelationSummaries = (
  record: ObjectRecord,
  objectMetadataItem: ObjectMetadataItem,
): string[] => {
  const summaries: string[] = [];

  for (const fieldMeta of objectMetadataItem.fields) {
    if (!fieldMeta.isActive) continue;
    if (fieldMeta.type !== FieldMetadataType.RELATION) continue;

    const relatedRecord = record[fieldMeta.name];
    if (!relatedRecord || typeof relatedRecord !== 'object') continue;

    const related = relatedRecord as Record<string, unknown>;

    // Try FULL_NAME composite
    const nameField = related.name;
    if (nameField && typeof nameField === 'object') {
      const nameObj = nameField as { firstName?: string; lastName?: string };
      const fullName =
        `${nameObj.firstName ?? ''} ${nameObj.lastName ?? ''}`.trim();
      if (fullName) {
        summaries.push(fullName);
        continue;
      }
    }

    // Try common label fields
    for (const key of ['name', 'title', 'label', 'displayName']) {
      const val = related[key];
      if (typeof val === 'string' && val.trim()) {
        summaries.push(val.trim());
        break;
      }
    }
  }

  return summaries;
};

const SELECT_DOT_COLOR_MAP: Record<string, string> = {
  green: '#34a853',
  turquoise: '#40bad5',
  sky: '#64b4e6',
  blue: '#4285f4',
  purple: '#9b51e0',
  pink: '#e96ba8',
  red: '#ea4335',
  orange: '#ff9800',
  yellow: '#fbbc04',
  gray: '#9e9e9e',
};

const formatRelativeTime = (dateString: string): string => {
  try {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);
    const diffWeeks = Math.floor(diffDays / 7);

    if (diffMins < 60) return `${diffMins} min`;
    if (diffHours < 24) return `${diffHours} hrs`;
    if (diffDays < 2) return 'yesterday';
    if (diffDays < 7) {
      return `on ${date.toLocaleDateString('en-US', { weekday: 'short' })}`;
    }
    if (diffWeeks < 5) return `${diffWeeks} wk${diffWeeks > 1 ? 's' : ''}`;
    return date.toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
    });
  } catch {
    return dateString;
  }
};

export const SimpleRecordListCard = ({
  record,
  objectMetadataItem,
  onClick,
}: {
  record: ObjectRecord;
  objectMetadataItem: ObjectMetadataItem;
  onClick: () => void;
}) => {
  const displayName = getRecordDisplayName(record, objectMetadataItem);
  const selectValue = getSelectFieldValue(record, objectMetadataItem);
  const relativeTime = record.createdAt
    ? formatRelativeTime(record.createdAt)
    : null;
  const relationSummaries = getRelationSummaries(record, objectMetadataItem);

  const subParts: string[] = [];
  if (relationSummaries.length > 0) subParts.push(...relationSummaries);
  if (selectValue) subParts.push(selectValue.label);
  if (relativeTime) subParts.push(relativeTime);

  const dotColor = selectValue?.color
    ? SELECT_DOT_COLOR_MAP[selectValue.color]
    : undefined;

  return (
    <StyledRow onClick={onClick}>
      <StyledTextContainer>
        <StyledName>{displayName}</StyledName>
        {subParts.length > 0 && (
          <StyledSubText>{subParts.join(' \u00B7 ')}</StyledSubText>
        )}
      </StyledTextContainer>
      {selectValue && <StyledDot dotColor={dotColor} />}
      <StyledChevron>
        <IconChevronRight size={16} />
      </StyledChevron>
    </StyledRow>
  );
};
