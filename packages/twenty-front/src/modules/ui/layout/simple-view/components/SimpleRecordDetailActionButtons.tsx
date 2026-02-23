import styled from '@emotion/styled';

import { IconMail, IconPhone } from 'twenty-ui/display';

const StyledActionRow = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(3)};
`;

const StyledActionButton = styled.a`
  align-items: center;
  background: ${({ theme }) => theme.color.blue};
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: #fff;
  cursor: pointer;
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
  height: 52px;
  justify-content: center;
  user-select: none;
  text-decoration: none;

  &:hover {
    opacity: 0.9;
  }

  &:active {
    opacity: 0.8;
    transform: scale(0.98);
  }
`;

const StyledDisabledButton = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.transparent.medium};
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.tertiary};
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
  height: 52px;
  justify-content: center;
  user-select: none;
`;

export const SimpleRecordDetailActionButtons = ({
  phoneNumber,
  email,
}: {
  phoneNumber?: string;
  email?: string;
}) => {
  return (
    <StyledActionRow>
      {phoneNumber ? (
        <StyledActionButton href={`tel:${phoneNumber}`}>
          <IconPhone size={22} />
          Call
        </StyledActionButton>
      ) : (
        <StyledDisabledButton>
          <IconPhone size={22} />
          Call
        </StyledDisabledButton>
      )}

      {email ? (
        <StyledActionButton href={`mailto:${email}`}>
          <IconMail size={22} />
          Email
        </StyledActionButton>
      ) : (
        <StyledDisabledButton>
          <IconMail size={22} />
          Email
        </StyledDisabledButton>
      )}
    </StyledActionRow>
  );
};
