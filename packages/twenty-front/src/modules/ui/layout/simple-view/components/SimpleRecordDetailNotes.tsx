import styled from '@emotion/styled';
import { Trans, useLingui } from '@lingui/react/macro';
import { isNonEmptyString } from '@sniptt/guards';
import { useCallback, useMemo, useState } from 'react';

import { type ObjectMetadataItem } from '@/object-metadata/types/ObjectMetadataItem';
import { useUpdateOneRecord } from '@/object-record/hooks/useUpdateOneRecord';
import { type ObjectRecord } from '@/object-record/types/ObjectRecord';
import { type FieldRichTextV2Value } from '@/object-record/record-field/ui/types/FieldMetadata';
import {
  appendFeedbackEntryToMarkdown,
  formatFeedbackDisplayDateTime,
  parseFeedbackEntriesFromMarkdown,
} from '@/ui/layout/simple-view/utils/simple-record-feedback.utils';
import { FieldMetadataType } from 'twenty-shared/types';
import { IconChevronDown, IconChevronUp, IconPencil } from 'twenty-ui/display';

const StyledCard = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)};
`;

const StyledSubmitFormSection = styled.div`
  border-radius: ${({ theme }) => theme.border.radius.sm};
  overflow: hidden;
`;

const StyledSubmitFeedbackHeader = styled.button<{ isExpanded: boolean }>`
  align-items: center;
  background: ${({ theme }) => theme.color.blue};
  border: none;
  border-radius: ${({ isExpanded, theme }) =>
    isExpanded
      ? `${theme.border.radius.sm} ${theme.border.radius.sm} 0 0`
      : theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.inverted};
  cursor: pointer;
  display: flex;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  gap: ${({ theme }) => theme.spacing(1.5)};
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(2.5)}
    ${({ theme }) => theme.spacing(3)};
  width: 100%;

  &:hover {
    opacity: 0.95;
  }
`;

const StyledSubmitFeedbackHeaderLabel = styled.span`
  align-items: center;
  display: flex;
  flex: 1;
  gap: ${({ theme }) => theme.spacing(1.5)};
  justify-content: center;
`;

const StyledSubmitFormContent = styled.div`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: 0 0 ${({ theme }) => theme.border.radius.sm}
    ${({ theme }) => theme.border.radius.sm};
  border-top: none;
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(2.5)};
`;

const StyledTextArea = styled.textarea`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  box-sizing: border-box;
  color: ${({ theme }) => theme.font.color.primary};
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  line-height: 1.5;
  min-height: ${({ theme }) => theme.spacing(24)};
  outline: none;
  padding: ${({ theme }) => theme.spacing(2.5)};
  resize: vertical;
  width: 100%;

  &::placeholder {
    color: ${({ theme }) => theme.font.color.light};
  }

  &:focus {
    border-color: ${({ theme }) => theme.color.blue};
  }
`;

const StyledSubmitButton = styled.button`
  background: ${({ theme }) => theme.color.green};
  border: 1px solid ${({ theme }) => theme.color.green};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.inverted};
  cursor: pointer;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  padding: ${({ theme }) => theme.spacing(2.5)}
    ${({ theme }) => theme.spacing(3)};
  width: 100%;

  &:disabled {
    cursor: not-allowed;
    opacity: 0.5;
  }

  &:hover:not(:disabled) {
    opacity: 0.9;
  }
`;

const StyledFeedbackList = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1.5)};
`;

const StyledAccordionItem = styled.div`
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  overflow: hidden;
`;

const StyledAccordionHeader = styled.button`
  align-items: center;
  background: transparent;
  border: none;
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  font-family: ${({ theme }) => theme.font.family};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(2.5)}
    ${({ theme }) => theme.spacing(3)};
  text-align: left;
  width: 100%;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.lighter};
  }
`;

const StyledAccordionContent = styled.div`
  border-top: 1px solid ${({ theme }) => theme.border.color.light};
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  line-height: 1.5;
  padding: ${({ theme }) => theme.spacing(2.5)}
    ${({ theme }) => theme.spacing(3)};
  white-space: pre-wrap;
  word-break: break-word;
`;

const StyledEmptyState = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
  padding: ${({ theme }) => theme.spacing(1)} 0;
`;

const RICH_TEXT_V2_FIELD_NAMES = ['notes', 'bodyV2'];

const getMarkdownFromRichTextValue = (
  fieldValue: FieldRichTextV2Value | null | undefined,
): string => {
  if (isNonEmptyString(fieldValue?.markdown)) {
    return fieldValue.markdown.trim();
  }

  return '';
};

export const SimpleRecordDetailNotes = ({
  objectMetadataItem,
  objectNameSingular,
  objectRecordId,
  record,
}: {
  objectMetadataItem: ObjectMetadataItem;
  objectNameSingular: string;
  objectRecordId: string;
  record: ObjectRecord;
}) => {
  const { t } = useLingui();
  const { updateOneRecord } = useUpdateOneRecord();
  const [feedbackDraft, setFeedbackDraft] = useState('');
  const [expandedEntryKeys, setExpandedEntryKeys] = useState<Set<string>>(
    () => new Set(),
  );
  const [isSubmitFormExpanded, setIsSubmitFormExpanded] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const richTextV2Field = objectMetadataItem.fields.find(
    (field) =>
      field.isActive &&
      field.type === FieldMetadataType.RICH_TEXT_V2 &&
      RICH_TEXT_V2_FIELD_NAMES.includes(field.name),
  );

  const fieldValue =
    (record[richTextV2Field?.name ?? ''] as
      | FieldRichTextV2Value
      | null
      | undefined) ?? undefined;

  const feedbackEntries = useMemo(() => {
    const markdown = getMarkdownFromRichTextValue(fieldValue);
    const fallbackDate =
      typeof record.updatedAt === 'string'
        ? record.updatedAt
        : typeof record.createdAt === 'string'
          ? record.createdAt
          : undefined;

    return parseFeedbackEntriesFromMarkdown(markdown, fallbackDate);
  }, [fieldValue, record.createdAt, record.updatedAt]);

  const toggleEntryExpanded = useCallback((entryKey: string) => {
    setExpandedEntryKeys((current) => {
      const next = new Set(current);
      if (next.has(entryKey)) {
        next.delete(entryKey);
      } else {
        next.add(entryKey);
      }
      return next;
    });
  }, []);

  const handleSubmitFeedback = useCallback(async () => {
    if (!richTextV2Field || feedbackDraft.trim().length === 0 || isSubmitting) {
      return;
    }

    setIsSubmitting(true);

    const existingMarkdown = getMarkdownFromRichTextValue(fieldValue);
    const nextMarkdown = appendFeedbackEntryToMarkdown({
      content: feedbackDraft,
      existingMarkdown,
    });

    try {
      await updateOneRecord({
        idToUpdate: objectRecordId,
        objectNameSingular,
        updateOneRecordInput: {
          [richTextV2Field.name]: {
            blocknote: null,
            markdown: nextMarkdown,
          },
        },
      });
      setFeedbackDraft('');
      setIsSubmitFormExpanded(false);
    } finally {
      setIsSubmitting(false);
    }
  }, [
    feedbackDraft,
    fieldValue,
    isSubmitting,
    objectNameSingular,
    objectRecordId,
    richTextV2Field,
    updateOneRecord,
  ]);

  if (!richTextV2Field) {
    return null;
  }

  return (
    <StyledCard>
      <StyledSubmitFormSection>
        <StyledSubmitFeedbackHeader
          type="button"
          isExpanded={isSubmitFormExpanded}
          onClick={() => setIsSubmitFormExpanded((current) => !current)}
        >
          <StyledSubmitFeedbackHeaderLabel>
            <IconPencil size={16} />
            <Trans>Submit Feedback</Trans>
          </StyledSubmitFeedbackHeaderLabel>
          {isSubmitFormExpanded ? (
            <IconChevronUp size={16} />
          ) : (
            <IconChevronDown size={16} />
          )}
        </StyledSubmitFeedbackHeader>

        {isSubmitFormExpanded && (
          <StyledSubmitFormContent>
            <StyledTextArea
              placeholder={t`Write your feedback...`}
              value={feedbackDraft}
              onChange={(event) => setFeedbackDraft(event.target.value)}
            />

            <StyledSubmitButton
              type="button"
              disabled={feedbackDraft.trim().length === 0 || isSubmitting}
              onClick={handleSubmitFeedback}
            >
              {isSubmitting ? t`Submitting...` : t`Submit`}
            </StyledSubmitButton>
          </StyledSubmitFormContent>
        )}
      </StyledSubmitFormSection>

      {feedbackEntries.length === 0 ? (
        <StyledEmptyState>
          <Trans>No feedback yet.</Trans>
        </StyledEmptyState>
      ) : (
        <StyledFeedbackList>
          {feedbackEntries.map((entry, index) => {
            const entryKey = `${entry.createdAt}-${index}`;
            const isExpanded = expandedEntryKeys.has(entryKey);
            const feedbackIndex = feedbackEntries.length - index;
            const feedbackLabel = t`Feedback ${feedbackIndex} - ${formatFeedbackDisplayDateTime(entry.createdAt)}`;

            return (
              <StyledAccordionItem key={entryKey}>
                <StyledAccordionHeader
                  type="button"
                  onClick={() => toggleEntryExpanded(entryKey)}
                >
                  <span>{feedbackLabel}</span>
                  {isExpanded ? (
                    <IconChevronUp size={16} />
                  ) : (
                    <IconChevronDown size={16} />
                  )}
                </StyledAccordionHeader>
                {isExpanded && (
                  <StyledAccordionContent>
                    {entry.content}
                  </StyledAccordionContent>
                )}
              </StyledAccordionItem>
            );
          })}
        </StyledFeedbackList>
      )}
    </StyledCard>
  );
};
