import styled from '@emotion/styled';
import { useSetRecoilState } from 'recoil';

import { isSimpleViewDrawerOpenState } from '@/ui/layout/simple-view/states/isSimpleViewDrawerOpenState';
import { IconList } from 'twenty-ui/display';

const StyledTopBar = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border-bottom: 1px solid ${({ theme }) => theme.border.color.medium};
  display: flex;
  height: ${({ theme }) => theme.spacing(12)};
  padding: 0 ${({ theme }) => theme.spacing(3)};
  flex-shrink: 0;
`;

const StyledHamburgerButton = styled.button`
  align-items: center;
  background: none;
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  height: ${({ theme }) => theme.spacing(8)};
  justify-content: center;
  padding: 0;
  width: ${({ theme }) => theme.spacing(8)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }
`;

const StyledTitle = styled.div`
  color: ${({ theme }) => theme.font.color.primary};
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.md};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  text-align: center;
`;

const StyledSpacer = styled.div`
  width: ${({ theme }) => theme.spacing(8)};
`;

export const SimpleViewTopBar = ({ title }: { title: string }) => {
  const setIsDrawerOpen = useSetRecoilState(isSimpleViewDrawerOpenState);

  return (
    <StyledTopBar>
      <StyledHamburgerButton onClick={() => setIsDrawerOpen(true)}>
        <IconList size={20} />
      </StyledHamburgerButton>
      <StyledTitle>{title}</StyledTitle>
      <StyledSpacer />
    </StyledTopBar>
  );
};
