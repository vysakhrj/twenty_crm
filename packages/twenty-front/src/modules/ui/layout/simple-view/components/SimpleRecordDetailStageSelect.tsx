import styled from '@emotion/styled';
import { Trans } from '@lingui/react/macro';
import { useState } from 'react';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { useIsMobile } from '@/ui/utilities/responsive/hooks/useIsMobile';
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

const StyledSelectWrapper = styled.div<{ compact: boolean }>`
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
    right: ${({ theme, compact }) =>
      compact ? theme.spacing(3) : theme.spacing(4)};
    top: 50%;
    transform: translateY(-50%);
  }
`;

const StyledSelect = styled.select<{ compact: boolean }>`
  appearance: none;
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme, compact }) =>
    compact ? theme.font.size.sm : theme.font.size.md};
  outline: none;
  padding: ${({ theme, compact }) =>
    compact
      ? `${theme.spacing(2)} ${theme.spacing(3)}`
      : `${theme.spacing(3)} ${theme.spacing(4)}`};
  padding-right: ${({ theme, compact }) =>
    compact ? theme.spacing(7) : theme.spacing(8)};
  width: 100%;
`;

const StyledMobileTrigger = styled.button<{ compact: boolean }>`
  align-items: center;
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme, compact }) =>
    compact ? theme.font.size.sm : theme.font.size.md};
  justify-content: space-between;
  padding: ${({ theme, compact }) =>
    compact
      ? `${theme.spacing(2)} ${theme.spacing(3)}`
      : `${theme.spacing(3)} ${theme.spacing(4)}`};
  width: 100%;
`;

const StyledMobileTriggerChevron = styled.span`
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-top: 5px solid ${({ theme }) => theme.font.color.tertiary};
  margin-left: ${({ theme }) => theme.spacing(2)};
`;

const StyledMobilePopupOverlay = styled.div`
  background: rgba(0, 0, 0, 0.35);
  inset: 0;
  position: fixed;
  z-index: 1000;
`;

const StyledMobilePopup = styled.div`
  background: ${({ theme }) => theme.background.primary};
  border-radius: ${({ theme }) => theme.border.radius.md}
    ${({ theme }) => theme.border.radius.md} 0 0;
  bottom: 0;
  left: 0;
  max-height: 70dvh;
  overflow: auto;
  padding: ${({ theme }) => theme.spacing(3)};
  position: fixed;
  right: 0;
  z-index: 1001;
`;

const StyledMobilePopupTitle = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin-bottom: ${({ theme }) => theme.spacing(2)};
`;

const StyledMobileOptionButton = styled.button<{ isSelected: boolean }>`
  background: ${({ theme, isSelected }) =>
    isSelected ? theme.background.transparent.medium : 'transparent'};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  margin-bottom: ${({ theme }) => theme.spacing(1.5)};
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(3)};
  text-align: left;
  width: 100%;
`;

const StyledMobileCloseButton = styled.button`
  background: transparent;
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.secondary};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.md};
  margin-top: ${({ theme }) => theme.spacing(1)};
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(3)};
  width: 100%;
`;

export const SimpleRecordDetailStageSelect = ({
  record,
  objectMetadataItem,
  compact = false,
}: {
  record: ObjectRecord;
  objectMetadataItem: ObjectMetadataItem;
  compact?: boolean;
}) => {
  const { updateOneRecord } = useUpdateOneRecord();
  const isMobile = useIsMobile();
  const [openedFieldName, setOpenedFieldName] = useState<string | null>(null);

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
          {!compact && <StyledSectionTitle>{field.label}</StyledSectionTitle>}
          {isMobile ? (
            <>
              <StyledMobileTrigger
                compact={compact}
                type="button"
                onClick={() => setOpenedFieldName(field.name)}
              >
                <span>
                  {field.options?.find(
                    (option) => option.value === (record[field.name] ?? ''),
                  )?.label ?? record[field.name] ?? ''}
                </span>
                <StyledMobileTriggerChevron />
              </StyledMobileTrigger>
              {openedFieldName === field.name && (
                <>
                  <StyledMobilePopupOverlay
                    onClick={() => setOpenedFieldName(null)}
                  />
                  <StyledMobilePopup>
                    <StyledMobilePopupTitle>{field.label}</StyledMobilePopupTitle>
                    {field.options?.map((option) => (
                      <StyledMobileOptionButton
                        key={option.value}
                        type="button"
                        isSelected={option.value === (record[field.name] ?? '')}
                        onClick={() => {
                          handleChange(field.name, option.value);
                          setOpenedFieldName(null);
                        }}
                      >
                        {option.label}
                      </StyledMobileOptionButton>
                    ))}
                    <StyledMobileCloseButton
                      type="button"
                      onClick={() => setOpenedFieldName(null)}
                    >
                      <Trans>Cancel</Trans>
                    </StyledMobileCloseButton>
                  </StyledMobilePopup>
                </>
              )}
            </>
          ) : (
            <StyledSelectWrapper compact={compact}>
              <StyledSelect
                compact={compact}
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
          )}
        </StyledSection>
      ))}
    </>
  );
};
