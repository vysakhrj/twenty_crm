import styled from '@emotion/styled';
import { useRecoilValue, useSetRecoilState } from 'recoil';

import { currentWorkspaceState } from '@/auth/states/currentWorkspaceState';
import { useNotifications } from '@/notifications/hooks/useNotifications';
import { showNotificationCenterState } from '@/notifications/states/notificationsState';
import { isSimpleViewDrawerOpenState } from '@/ui/layout/simple-view/states/isSimpleViewDrawerOpenState';
import { DEFAULT_WORKSPACE_LOGO } from '@/ui/navigation/navigation-drawer/constants/DefaultWorkspaceLogo';
import { Avatar, IconBell, IconList } from 'twenty-ui/display';

const StyledTopBar = styled.div`
  align-items: center;
  background: ${({ theme }) => theme.background.primary};
  border-bottom: 1px solid ${({ theme }) => theme.border.color.medium};
  display: flex;
  height: ${({ theme }) => theme.spacing(14)};
  padding: 0 ${({ theme }) => theme.spacing(4)};
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
  height: ${({ theme }) => theme.spacing(10)};
  justify-content: center;
  padding: 0;
  width: ${({ theme }) => theme.spacing(10)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }
`;

const StyledTitle = styled.div`
  align-items: center;
  color: ${({ theme }) => theme.font.color.primary};
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.semiBold};
  gap: ${({ theme }) => theme.spacing(2.5)};
  justify-content: center;
  min-width: 0;
`;

const StyledTitleText = styled.span`
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
`;

const StyledNotificationButton = styled.button<{ hasUnread: boolean }>`
  align-items: center;
  background: none;
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.primary};
  cursor: pointer;
  display: flex;
  height: ${({ theme }) => theme.spacing(10)};
  justify-content: center;
  padding: 0;
  position: relative;
  width: ${({ theme }) => theme.spacing(10)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
  }

  &::after {
    background: ${({ theme }) => theme.color.red};
    border-radius: 50%;
    content: '';
    display: ${({ hasUnread }) => (hasUnread ? 'block' : 'none')};
    height: 8px;
    position: absolute;
    right: 6px;
    top: 6px;
    width: 8px;
  }
`;

export const SimpleViewTopBar = ({ title }: { title: string }) => {
  const currentWorkspace = useRecoilValue(currentWorkspaceState);
  const setIsDrawerOpen = useSetRecoilState(isSimpleViewDrawerOpenState);
  const setShowNotificationCenter = useSetRecoilState(
    showNotificationCenterState,
  );
  const { unreadCount } = useNotifications({ skipFullFetch: true });

  return (
    <StyledTopBar>
      <StyledHamburgerButton onClick={() => setIsDrawerOpen(true)}>
        <IconList size={24} />
      </StyledHamburgerButton>
      <StyledTitle>
        <Avatar
          size="md"
          placeholder={currentWorkspace?.displayName ?? title}
          avatarUrl={currentWorkspace?.logo ?? DEFAULT_WORKSPACE_LOGO}
        />
        <StyledTitleText>{title}</StyledTitleText>
      </StyledTitle>
      <StyledNotificationButton
        onClick={() => setShowNotificationCenter(true)}
        hasUnread={unreadCount > 0}
        aria-label="Notifications"
      >
        <IconBell size={24} />
      </StyledNotificationButton>
    </StyledTopBar>
  );
};
