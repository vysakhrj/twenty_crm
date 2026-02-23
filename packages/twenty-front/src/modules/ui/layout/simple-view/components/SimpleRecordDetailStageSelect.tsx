import styled from '@emotion/styled';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { FieldMetadataType } from 'twenty-shared/types';

const StyledSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
`;

const StyledSectionTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
  padding: ${({ theme }) => theme.spacing(1)} 0;
`;

const StyledSelectWrapper = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  overflow: hidden;
  position: relative;

  &::after {
    border-left: 4px solid transparent;
    border-right: 4px solid transparent;
    border-top: 5px solid ${({ theme }) => theme.font.color.tertiary};
    content: '';
    pointer-events: none;
    position: absolute;
    right: ${({ theme }) => theme.spacing(4)};
    top: 50%;
    transform: translateY(-50%);
  }
`;

const StyledSelect = styled.select`
  appearance: none;
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  outline: none;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  padding-right: ${({ theme }) => theme.spacing(8)};
  width: 100%;
`;

export const SimpleRecordDetailStageSelect = ({
  record,
  objectMetadataItem,
}: {
  record: ObjectRecord;
  objectMetadataItem: ObjectMetadataItem;
}) => {
  const { updateOneRecord } = useUpdateOneRecord();

  const selectFields = objectMetadataItem.fields.filter(
    (field) =>
      field.type === FieldMetadataType.SELECT &&
      field.isActive &&
      !field.isSystem,
  );

  if (selectFields.length === 0) return null;

  const handleChange = (fieldName: string, newValue: string) => {
    updateOneRecord({
      idToUpdate: record.id,
      objectNameSingular: objectMetadataItem.nameSingular,
      updateOneRecordInput: {
        [fieldName]: newValue,
      },
    });
  };

  return (
    <>
      {selectFields.map((field) => (
        <StyledSection key={field.id}>
          <StyledSectionTitle>{field.label}</StyledSectionTitle>
          <StyledSelectWrapper>
            <StyledSelect
              value={record[field.name] ?? ''}
              onChange={(event) =>
                handleChange(field.name, event.target.value)
              }
            >
              {field.options?.map((option) => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </StyledSelect>
          </StyledSelectWrapper>
        </StyledSection>
      ))}
    </>
  );
};
