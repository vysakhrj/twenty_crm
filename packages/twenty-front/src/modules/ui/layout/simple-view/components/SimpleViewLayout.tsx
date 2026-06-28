import styled from '@emotion/styled';
import { useLingui } from '@lingui/react/macro';
import { Outlet, useLocation } from 'react-router-dom';
import { useRecoilValue } from 'recoil';
import { isNonEmptyString } from '@sniptt/guards';

import { currentWorkspaceState } from '@/auth/states/currentWorkspaceState';
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

  > * {
    min-height: 0;
  }
`;

export const SimpleViewLayout = ({ title }: { title?: string }) => {
  const { t } = useLingui();
  const location = useLocation();
  const currentWorkspace = useRecoilValue(currentWorkspaceState);
  const computedTitle =
    title ??
    (location.pathname === '/simple/settings'
      ? t`Settings`
      : isNonEmptyString(currentWorkspace?.displayName)
        ? currentWorkspace.displayName
        : t`CRM`);

  return (
    <StyledLayout>
      <SimpleViewTopBar title={computedTitle} />
      <StyledMainContent>
        <Outlet />
      </StyledMainContent>
      <SimpleViewSideDrawer />
    </StyledLayout>
  );
};
