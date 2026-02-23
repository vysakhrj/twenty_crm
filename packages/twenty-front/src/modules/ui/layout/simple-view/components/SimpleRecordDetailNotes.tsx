import styled from '@emotion/styled';
import { useCallback, useMemo, useState } from 'react';
import { v4 } from 'uuid';

import { getActivityPreview } from '@/activities/utils/getActivityPreview';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { IconNotes, IconPencil } from 'twenty-ui/display';

const StyledSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
`;

const StyledSectionHeader = styled.div`
  align-items: center;
  display: flex;
  justify-content: space-between;
`;

const StyledSectionTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
  padding: ${({ theme }) => theme.spacing(1)} 0;
`;

const StyledEditButton = styled.button`
  align-items: center;
  background: none;
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.secondary};
  cursor: pointer;
  display: flex;
  gap: ${({ theme }) => theme.spacing(1)};
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => theme.spacing(1)} ${({ theme }) => theme.spacing(2)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }
`;

const StyledBodyContainer = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  min-height: 60px;
  overflow: hidden;
`;

const StyledBodyText = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.sm};
  line-height: 1.6;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  white-space: pre-wrap;
  word-break: break-word;
`;

const StyledEmptyBody = styled.div`
  align-items: center;
  color: ${({ theme }) => theme.font.color.tertiary};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(6)};
`;

const StyledTextarea = styled.textarea`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.color.blue};
  border-radius: ${({ theme }) => theme.border.radius.md};
  box-sizing: border-box;
  color: ${({ theme }) => theme.font.color.primary};
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  line-height: 1.6;
  min-height: 120px;
  outline: none;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  resize: vertical;
  width: 100%;
`;

const StyledFormButtons = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  justify-content: flex-end;
  margin-top: ${({ theme }) => theme.spacing(1)};
`;

const StyledFormButton = styled.button<{ isPrimary?: boolean }>`
  background: ${({ theme, isPrimary }) =>
    isPrimary ? theme.color.blue : 'none'};
  border: 1px solid
    ${({ theme, isPrimary }) =>
      isPrimary ? theme.color.blue : theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ isPrimary }) => (isPrimary ? '#fff' : 'inherit')};
  cursor: pointer;
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => theme.spacing(1.5)}
    ${({ theme }) => theme.spacing(3)};

  &:disabled {
    cursor: not-allowed;
    opacity: 0.5;
  }
`;

// Convert plain text into a minimal BlockNote document JSON
const textToBlocknote = (text: string): string => {
  const lines = text.split('\n');
  const blocks = lines.map((line) => ({
    id: v4(),
    type: 'paragraph',
    props: {
      textColor: 'default',
      backgroundColor: 'default',
      textAlignment: 'left',
    },
    content: line
      ? [{ type: 'text', text: line, styles: {} }]
      : [],
    children: [],
  }));
  return JSON.stringify(blocks);
};

// Extract plain text from bodyV2 (blocknote JSON or markdown)
const extractBodyText = (
  bodyV2: { blocknote?: string | null; markdown?: string | null } | null | undefined,
): string => {
  if (!bodyV2) return '';

  if (bodyV2.markdown) {
    return bodyV2.markdown;
  }

  if (bodyV2.blocknote) {
    return getActivityPreview(bodyV2.blocknote);
  }

  return '';
};

export const SimpleRecordDetailNotes = ({
  objectNameSingular,
  objectRecordId,
  record,
}: {
  objectNameSingular: string;
  objectRecordId: string;
  record: ObjectRecord;
}) => {
  const [isEditing, setIsEditing] = useState(false);
  const [editText, setEditText] = useState('');
  const [isSaving, setIsSaving] = useState(false);

  const { updateOneRecord } = useUpdateOneRecord();

  const bodyV2 = record.bodyV2 as
    | { blocknote?: string | null; markdown?: string | null }
    | null
    | undefined;

  const bodyText = useMemo(() => extractBodyText(bodyV2), [bodyV2]);

  const handleStartEdit = useCallback(() => {
    setEditText(bodyText);
    setIsEditing(true);
  }, [bodyText]);

  const handleCancel = () => {
    setIsEditing(false);
    setEditText('');
  };

  const handleSave = useCallback(async () => {
    setIsSaving(true);
    try {
      await updateOneRecord({
        idToUpdate: objectRecordId,
        objectNameSingular,
        updateOneRecordInput: {
          bodyV2: {
            blocknote: textToBlocknote(editText),
            markdown: editText,
          },
        },
      });
      setIsEditing(false);
    } catch (error) {
      // eslint-disable-next-line no-console
      console.error('Failed to save body:', error);
    } finally {
      setIsSaving(false);
    }
  }, [editText, objectRecordId, objectNameSingular, updateOneRecord]);

  return (
    <StyledSection>
      <StyledSectionHeader>
        <StyledSectionTitle>Notes</StyledSectionTitle>
        {!isEditing && (
          <StyledEditButton onClick={handleStartEdit}>
            <IconPencil size={14} />
            {bodyText ? 'Edit' : 'Add'}
          </StyledEditButton>
        )}
      </StyledSectionHeader>

      {isEditing ? (
        <>
          <StyledTextarea
            value={editText}
            onChange={(event) => setEditText(event.target.value)}
            placeholder="Write notes here..."
            autoFocus
          />
          <StyledFormButtons>
            <StyledFormButton onClick={handleCancel} disabled={isSaving}>
              Cancel
            </StyledFormButton>
            <StyledFormButton
              isPrimary
              onClick={handleSave}
              disabled={isSaving}
            >
              {isSaving ? 'Saving...' : 'Save'}
            </StyledFormButton>
          </StyledFormButtons>
        </>
      ) : (
        <StyledBodyContainer>
          {bodyText ? (
            <StyledBodyText>{bodyText}</StyledBodyText>
          ) : (
            <StyledEmptyBody>
              <IconNotes size={24} />
              No notes yet
            </StyledEmptyBody>
          )}
        </StyledBodyContainer>
      )}
    </StyledSection>
  );
};
