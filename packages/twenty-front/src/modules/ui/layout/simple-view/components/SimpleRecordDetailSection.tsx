import styled from '@emotion/styled';
import { useLingui } from '@lingui/react/macro';
import { useState } from 'react';
import { IconMail, IconMessage, IconPhone } from 'twenty-ui/display';

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

const StyledSectionContent = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  overflow: hidden;
`;

const StyledFieldRow = styled.div`
  border-bottom: 1px solid ${({ theme }) => theme.border.color.light};
  display: flex;
  justify-content: space-between;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};

  &:last-child {
    border-bottom: none;
  }
`;

const StyledFieldContent = styled.div<{ isExpandable: boolean }>`
  cursor: ${({ isExpandable }) => (isExpandable ? 'pointer' : 'default')};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.5)};
  min-width: 0;
`;

const StyledFieldLabel = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledFieldValue = styled.div<{ isExpanded: boolean }>`
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: ${({ isExpanded }) => (isExpanded ? 'unset' : 2)};
  overflow: ${({ isExpanded }) => (isExpanded ? 'visible' : 'hidden')};
  word-break: break-word;
`;

const StyledLink = styled.a<{ isExpanded: boolean }>`
  color: ${({ theme }) => theme.color.blue};
  display: -webkit-box;
  font-size: ${({ theme }) => theme.font.size.sm};
  -webkit-box-orient: vertical;
  -webkit-line-clamp: ${({ isExpanded }) => (isExpanded ? 'unset' : 2)};
  overflow: ${({ isExpanded }) => (isExpanded ? 'visible' : 'hidden')};
  text-decoration: none;
  word-break: break-all;

  &:hover {
    text-decoration: underline;
  }
`;

const StyledActions = styled.div`
  align-items: center;
  display: flex;
  flex-shrink: 0;
  gap: ${({ theme }) => theme.spacing(1.5)};
`;

const StyledActionButton = styled.a`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border: 1px solid ${({ theme }) => theme.color.blue};
  border-radius: ${({ theme }) => theme.border.radius.sm};
  box-shadow: ${({ theme }) => `0 1px 2px ${theme.background.transparent.medium}`};
  color: ${({ theme }) => theme.color.blue};
  cursor: pointer;
  display: inline-flex;
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(1)};
  padding: ${({ theme }) => theme.spacing(1)} ${({ theme }) => theme.spacing(1.5)};
  text-decoration: none;
  transition: transform 0.12s ease, box-shadow 0.12s ease, background 0.12s ease;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    box-shadow: ${({ theme }) =>
      `0 2px 6px ${theme.background.transparent.medium}`};
  }

  &:active {
    transform: scale(0.97);
  }
`;

type SectionFieldActionType = 'call' | 'email' | 'whatsapp';

type SectionFieldAction = {
  type: SectionFieldActionType;
  href: string;
};

export type SectionField = {
  label: string;
  value: string;
  href?: string;
  actions?: SectionFieldAction[];
};

export const SimpleRecordDetailSection = ({
  title,
  fields,
}: {
  title: string;
  fields: SectionField[];
}) => {
  const { t } = useLingui();
  const [expandedFieldKeys, setExpandedFieldKeys] = useState<Set<string>>(
    () => new Set(),
  );

  const getActionLabel = (actionType: 'call' | 'email' | 'whatsapp') => {
    if (actionType === 'call') {
      return t`Call`;
    }

    if (actionType === 'email') {
      return t`Email`;
    }

    return t`WhatsApp`;
  };

  if (fields.length === 0) return null;

  const toggleExpanded = (fieldKey: string) => {
    setExpandedFieldKeys((current) => {
      const next = new Set(current);
      if (next.has(fieldKey)) {
        next.delete(fieldKey);
      } else {
        next.add(fieldKey);
      }
      return next;
    });
  };

  return (
    <StyledSection>
      <StyledSectionTitle>{title}</StyledSectionTitle>
      <StyledSectionContent>
        {fields.map((field, index) => {
          const fieldKey = `${field.label}-${index}`;
          const isExpanded = expandedFieldKeys.has(fieldKey);
          const isExpandable = !field.href && field.value.length > 90;

          return (
            <StyledFieldRow key={fieldKey}>
              <StyledFieldContent
                isExpandable={isExpandable}
                onClick={() => {
                  if (!isExpandable) return;
                  toggleExpanded(fieldKey);
                }}
              >
              <StyledFieldLabel>{field.label}</StyledFieldLabel>
              {field.href ? (
                <StyledLink href={field.href} isExpanded={isExpanded}>
                  {field.value}
                </StyledLink>
              ) : (
                <StyledFieldValue isExpanded={isExpanded}>
                  {field.value}
                </StyledFieldValue>
              )}
            </StyledFieldContent>
            {field.actions && field.actions.length > 0 && (
              <StyledActions>
                {field.actions.map((action) => {
                  const actionLabel = getActionLabel(action.type);
                  const icon =
                    action.type === 'call' ? (
                      <IconPhone size={14} />
                    ) : action.type === 'email' ? (
                      <IconMail size={14} />
                    ) : (
                      <IconMessage size={14} />
                    );

                  return (
                    <StyledActionButton
                      key={`${field.label}-${action.type}`}
                      href={action.href}
                      target={action.type === 'whatsapp' ? '_blank' : undefined}
                      rel={action.type === 'whatsapp' ? 'noreferrer' : undefined}
                    >
                      {icon}
                      {actionLabel}
                    </StyledActionButton>
                  );
                })}
              </StyledActions>
            )}
            </StyledFieldRow>
          );
        })}
      </StyledSectionContent>
    </StyledSection>
  );
};
