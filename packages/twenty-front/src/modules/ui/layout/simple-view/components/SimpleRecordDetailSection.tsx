import styled from '@emotion/styled';

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
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(0.5)};
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};

  &:last-child {
    border-bottom: none;
  }
`;

const StyledFieldLabel = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  font-size: ${({ theme }) => theme.font.size.sm};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
`;

const StyledFieldValue = styled.div`
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  word-break: break-word;
`;

const StyledLink = styled.a`
  color: ${({ theme }) => theme.color.blue};
  font-size: ${({ theme }) => theme.font.size.sm};
  text-decoration: none;
  word-break: break-all;

  &:hover {
    text-decoration: underline;
  }
`;

export type SectionField = {
  label: string;
  value: string;
  href?: string;
};

export const SimpleRecordDetailSection = ({
  title,
  fields,
}: {
  title: string;
  fields: SectionField[];
}) => {
  if (fields.length === 0) return null;

  return (
    <StyledSection>
      <StyledSectionTitle>{title}</StyledSectionTitle>
      <StyledSectionContent>
        {fields.map((field) => (
          <StyledFieldRow key={field.label}>
            <StyledFieldLabel>{field.label}</StyledFieldLabel>
            {field.href ? (
              <StyledLink href={field.href}>{field.value}</StyledLink>
            ) : (
              <StyledFieldValue>{field.value}</StyledFieldValue>
            )}
          </StyledFieldRow>
        ))}
      </StyledSectionContent>
    </StyledSection>
  );
};
