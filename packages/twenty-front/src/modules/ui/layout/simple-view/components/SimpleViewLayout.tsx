import styled from '@emotion/styled';
import { Outlet } from 'react-router-dom';

import { SimpleViewSideDrawer } from '@/ui/layout/simple-view/components/SimpleViewSideDrawer';
import { SimpleViewTopBar } from '@/ui/layout/simple-view/components/SimpleViewTopBar';

const StyledLayout = styled.div`
  display: flex;
  flex-direction: column;
  height: 100dvh;
  max-width: 100vw;
  overflow: hidden;
  width: 100%;
`;

const StyledMainContent = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;
  max-width: 100%;
  min-height: 0;
  overflow-x: hidden;
  overflow-y: auto;
`;

export const SimpleViewLayout = ({ title }: { title?: string }) => {
  return (
    <StyledLayout>
      <SimpleViewTopBar title={title ?? 'CRM'} />
      <StyledMainContent>
        <Outlet />
      </StyledMainContent>
      <SimpleViewSideDrawer />
    </StyledLayout>
  );
};
