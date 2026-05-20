import styled from '@emotion/styled';
import { Trans } from '@lingui/react/macro';
import { type ReactNode } from 'react';

import {
  IconBriefcase,
  IconClockHour8,
  IconMail,
  IconMap,
  IconMessage,
  IconPhone,
  IconUser,
} from 'twenty-ui/display';

const StyledCard = styled.div`
  background: ${({ theme }) => theme.background.secondary};
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(3)};
  padding: ${({ theme }) => theme.spacing(3)};
`;

const StyledAssignedSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.5)};
`;

const StyledAssignedLabel = styled.div`
  color: ${({ theme }) => theme.color.blue};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledAssignedName = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledDateValue = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.sm};
`;

const StyledDivider = styled.div`
  background: ${({ theme }) => theme.border.color.light};
  height: 1px;
  width: 100%;
`;

const StyledSectionTitle = styled.h3`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  margin: 0;
`;

const StyledInfoList = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2.5)};
`;

const StyledInfoRow = styled.div`
  align-items: center;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  min-width: 0;
`;

const StyledIconCircle = styled.div<{ iconVariant: BasicInfoIconVariant }>`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.light};
  border-radius: 50%;
  color: ${({ iconVariant, theme }) => {
    switch (iconVariant) {
      case 'blue':
        return theme.color.blue;
      case 'green':
        return theme.color.green;
      case 'orange':
        return theme.color.orange;
      case 'purple':
        return theme.color.purple;
      case 'red':
        return theme.color.red;
      case 'teal':
        return theme.color.turquoise;
      default:
        return theme.font.color.secondary;
    }
  }};
  display: flex;
  flex-shrink: 0;
  height: ${({ theme }) => theme.spacing(7)};
  justify-content: center;
  width: ${({ theme }) => theme.spacing(7)};
`;

const StyledInfoValue = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-width: 0;
  word-break: break-word;
`;

const StyledInfoLink = styled.a`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  min-width: 0;
  text-decoration: none;
  word-break: break-word;

  &:hover {
    color: ${({ theme }) => theme.color.blue};
  }
`;

const StyledExtraSection = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};
`;

type BasicInfoIconVariant =
  | 'blue'
  | 'green'
  | 'orange'
  | 'purple'
  | 'red'
  | 'teal';

type BasicInfoItem = {
  href?: string;
  icon: ReactNode;
  iconVariant: BasicInfoIconVariant;
  value: string;
};

export const SimpleRecordDetailBasicInfo = ({
  assigneeName,
  children,
  createdDate,
  infoItems,
}: {
  assigneeName?: string;
  children?: ReactNode;
  createdDate?: string;
  infoItems: BasicInfoItem[];
}) => {
  return (
    <StyledCard>
      <StyledAssignedSection>
        <StyledAssignedLabel>
          <Trans>Assigned to</Trans>
        </StyledAssignedLabel>
        <StyledAssignedName>
          {assigneeName ?? <Trans>Unassigned</Trans>}
        </StyledAssignedName>
        {createdDate && <StyledDateValue>{createdDate}</StyledDateValue>}
      </StyledAssignedSection>

      <StyledDivider />

      <StyledSectionTitle>
        <Trans>Basic Information</Trans>
      </StyledSectionTitle>

      {infoItems.length > 0 && (
        <StyledInfoList>
          {infoItems.map((item, index) => (
            <StyledInfoRow key={`${item.value}-${index}`}>
              <StyledIconCircle iconVariant={item.iconVariant}>
                {item.icon}
              </StyledIconCircle>
              {item.href ? (
                <StyledInfoLink href={item.href}>{item.value}</StyledInfoLink>
              ) : (
                <StyledInfoValue>{item.value}</StyledInfoValue>
              )}
            </StyledInfoRow>
          ))}
        </StyledInfoList>
      )}

      {children && <StyledExtraSection>{children}</StyledExtraSection>}
    </StyledCard>
  );
};

export type { BasicInfoIconVariant };

export const BasicInfoIcons = {
  Briefcase: IconBriefcase,
  Clock: IconClockHour8,
  Mail: IconMail,
  Map: IconMap,
  Message: IconMessage,
  Phone: IconPhone,
  User: IconUser,
};
