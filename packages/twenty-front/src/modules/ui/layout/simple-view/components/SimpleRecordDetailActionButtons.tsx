import styled from '@emotion/styled';
import { useLingui } from '@lingui/react/macro';

import { IconMail, IconMessage, IconPhone } from 'twenty-ui/display';

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
  whatsappNumber,
}: {
  phoneNumber?: string;
  email?: string;
  whatsappNumber?: string;
}) => {
  const { t } = useLingui();

  const whatsappLink = whatsappNumber
    ? `https://wa.me/${whatsappNumber.replace(/\D/g, '')}`
    : undefined;

  return (
    <StyledActionRow>
      {phoneNumber ? (
        <StyledActionButton href={`tel:${phoneNumber}`}>
          <IconPhone size={22} />
          {t`Call`}
        </StyledActionButton>
      ) : (
        <StyledDisabledButton>
          <IconPhone size={22} />
          {t`Call`}
        </StyledDisabledButton>
      )}

      {email ? (
        <StyledActionButton href={`mailto:${email}`}>
          <IconMail size={22} />
          {t`Email`}
        </StyledActionButton>
      ) : (
        <StyledDisabledButton>
          <IconMail size={22} />
          {t`Email`}
        </StyledDisabledButton>
      )}

      {whatsappLink ? (
        <StyledActionButton href={whatsappLink} target="_blank" rel="noreferrer">
          <IconMessage size={22} />
          {t`WhatsApp`}
        </StyledActionButton>
      ) : (
        <StyledDisabledButton>
          <IconMessage size={22} />
          {t`WhatsApp`}
        </StyledDisabledButton>
      )}
    </StyledActionRow>
  );
};
