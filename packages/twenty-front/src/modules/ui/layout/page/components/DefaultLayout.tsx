import { useRecoilValue } from 'recoil';

import { AuthModal } from '@/auth/components/AuthModal';
import { AppErrorBoundary } from '@/error-handler/components/AppErrorBoundary';
import { AppFullScreenErrorFallback } from '@/error-handler/components/AppFullScreenErrorFallback';
import { AppPageErrorFallback } from '@/error-handler/components/AppPageErrorFallback';
import { InformationBannerIsImpersonating } from '@/information-banner/components/impersonate/InformationBannerIsImpersonating';
import { KeyboardShortcutMenu } from '@/keyboard-shortcut-menu/components/KeyboardShortcutMenu';
import { AppNavigationDrawer } from '@/navigation/components/AppNavigationDrawer';
import { MobileNavigationBar } from '@/navigation/components/MobileNavigationBar';
import { useIsSettingsPage } from '@/navigation/hooks/useIsSettingsPage';
import { NotificationCenter } from '@/notifications/components/NotificationCenter';
import { useFirebaseNotifications } from '@/notifications/hooks/useFirebaseNotifications';
import { OBJECT_SETTINGS_WIDTH } from '@/settings/data-model/constants/ObjectSettings';
import { useShowFullscreen } from '@/ui/layout/fullscreen/hooks/useShowFullscreen';
import { useShowAuthModal } from '@/ui/layout/hooks/useShowAuthModal';
import { NAVIGATION_DRAWER_CONSTRAINTS } from '@/ui/layout/resizable-panel/constants/NavigationDrawerConstraints';
import { SimpleViewLayout } from '@/ui/layout/simple-view/components/SimpleViewLayout';
import { isSimpleViewEnabledState } from '@/ui/layout/simple-view/states/isSimpleViewEnabledState';
import { useIsMobile } from '@/ui/utilities/responsive/hooks/useIsMobile';
import { Global, css, useTheme } from '@emotion/react';
import styled from '@emotion/styled';
import { AnimatePresence, LayoutGroup, motion } from 'framer-motion';
import { Outlet } from 'react-router-dom';
import { useScreenSize } from 'twenty-ui/utilities';

const StyledLayout = styled.div<{ isPlainBackground?: boolean }>`
  background: ${({ theme, isPlainBackground }) =>
    isPlainBackground ? theme.background.primary : theme.background.noisy};
  display: flex;
  flex-direction: column;
  height: 100dvh;
  position: relative;
  scrollbar-color: ${({ theme }) => theme.border.color.medium} transparent;
  scrollbar-width: 4px;
  width: 100%;

  *::-webkit-scrollbar-thumb {
    border-radius: ${({ theme }) => theme.border.radius.sm};
  }
`;

const StyledPageContainer = styled(motion.div)`
  display: flex;
  flex: 1 1 auto;
  flex-direction: row;
  min-height: 0;
`;

const StyledAppNavigationDrawer = styled(AppNavigationDrawer)`
  flex-shrink: 0;
`;

const StyledMainContainer = styled.div`
  display: flex;
  flex: 0 1 100%;
  overflow: hidden;
`;

export const DefaultLayout = () => {
  const isMobile = useIsMobile();
  const isSettingsPage = useIsSettingsPage();
  const theme = useTheme();
  const windowsWidth = useScreenSize().width;
  const showAuthModal = useShowAuthModal();
  const useShowFullScreen = useShowFullscreen();
  const isSimpleViewEnabled = useRecoilValue(isSimpleViewEnabledState);

  useFirebaseNotifications();

  // When simple view is enabled and not on auth/settings pages, use simplified layout
  const shouldUseSimpleView =
    isSimpleViewEnabled && !showAuthModal && !isSettingsPage;

  if (shouldUseSimpleView) {
    return (
      <>
        <Global
          styles={css`
            body {
              background: ${theme.background.tertiary};
            }
          `}
        />
        <StyledLayout>
          <AppErrorBoundary FallbackComponent={AppFullScreenErrorFallback}>
            <SimpleViewLayout />
          </AppErrorBoundary>
          <NotificationCenter />
        </StyledLayout>
      </>
    );
  }

  return (
    <>
      <Global
        styles={css`
          body {
            background: ${theme.background.tertiary};
          }
        `}
      />
      <StyledLayout isPlainBackground={showAuthModal}>
        <AppErrorBoundary FallbackComponent={AppFullScreenErrorFallback}>
          <InformationBannerIsImpersonating />
          <StyledPageContainer
            animate={{
              marginLeft:
                isSettingsPage && !isMobile && !useShowFullScreen
                  ? (windowsWidth -
                      (OBJECT_SETTINGS_WIDTH +
                        NAVIGATION_DRAWER_CONSTRAINTS.default +
                        76)) /
                    2
                  : 0,
            }}
            transition={{
              duration: theme.animation.duration.normal,
            }}
          >
            {!showAuthModal && <KeyboardShortcutMenu />}
            {showAuthModal ? null : useShowFullScreen ? null : (
              <StyledAppNavigationDrawer />
            )}
            {showAuthModal ? (
              <>
                <StyledMainContainer />
                <AnimatePresence mode="wait">
                  <LayoutGroup>
                    <AuthModal>
                      <Outlet />
                    </AuthModal>
                  </LayoutGroup>
                </AnimatePresence>
              </>
            ) : (
              <StyledMainContainer>
                <AppErrorBoundary FallbackComponent={AppPageErrorFallback}>
                  <Outlet />
                </AppErrorBoundary>
              </StyledMainContainer>
            )}
          </StyledPageContainer>
          {isMobile && !showAuthModal && <MobileNavigationBar />}
          {!showAuthModal && <NotificationCenter />}
        </AppErrorBoundary>
      </StyledLayout>
    </>
  );
};
