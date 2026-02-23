import styled from '@emotion/styled';
import { useRecoilState } from 'recoil';

import { useFilteredObjectMetadataItems } from '@/object-metadata/hooks/useFilteredObjectMetadataItems';
import { simpleViewObjectsState } from '@/ui/layout/simple-view/states/simpleViewObjectsState';

const StyledContainer = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(1)};
  padding: ${({ theme }) => theme.spacing(2)} ${({ theme }) => theme.spacing(4)};
`;

const StyledLabel = styled.div`
  color: ${({ theme }) => theme.font.color.tertiary};
  font-size: ${({ theme }) => theme.font.size.xs};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  padding-bottom: ${({ theme }) => theme.spacing(1)};
  text-transform: uppercase;
`;

const StyledCheckboxRow = styled.label`
  align-items: center;
  cursor: pointer;
  display: flex;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(1)} 0;
`;

const StyledCheckbox = styled.input`
  accent-color: ${({ theme }) => theme.color.blue};
  cursor: pointer;
  height: 16px;
  margin: 0;
  width: 16px;
`;

const StyledObjectName = styled.span`
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
`;

export const SimpleViewObjectConfig = () => {
  const [simpleViewObjects, setSimpleViewObjects] = useRecoilState(
    simpleViewObjectsState,
  );
  const { alphaSortedActiveNonSystemObjectMetadataItems } =
    useFilteredObjectMetadataItems();

  const handleToggleObject = (nameSingular: string) => {
    setSimpleViewObjects((prev) =>
      prev.includes(nameSingular)
        ? prev.filter((name) => name !== nameSingular)
        : [...prev, nameSingular],
    );
  };

  return (
    <StyledContainer>
      <StyledLabel>Simple view objects</StyledLabel>
      {alphaSortedActiveNonSystemObjectMetadataItems.map((item) => (
        <StyledCheckboxRow key={item.id}>
          <StyledCheckbox
            type="checkbox"
            checked={simpleViewObjects.includes(item.nameSingular)}
            onChange={() => handleToggleObject(item.nameSingular)}
          />
          <StyledObjectName>{item.labelPlural}</StyledObjectName>
        </StyledCheckboxRow>
      ))}
    </StyledContainer>
  );
};
