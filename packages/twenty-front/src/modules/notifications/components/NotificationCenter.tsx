import styled from '@emotion/styled';
import { useLingui } from '@lingui/react/macro';
import { useRecoilState, useRecoilValue } from 'recoil';

import { IconBell, IconCheck, IconX } from 'twenty-ui/display';
import { Button } from 'twenty-ui/input';

import { NotificationList } from './NotificationList';
import { useNotifications } from '../hooks/useNotifications';
import {
  notificationsState,
  showNotificationCenterState,
  unreadNotificationsCountState,
} from '../states/notificationsState';

const StyledOverlay = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: ${({ theme }) => theme.background.overlayPrimary};
  z-index: 1000;
`;

const StyledDrawer = styled.div`
  position: fixed;
  top: 0;
  right: 0;
  width: 400px;
  max-width: 100%;
  height: 100vh;
  background: ${({ theme }) => theme.background.primary};
  border-left: 1px solid ${({ theme }) => theme.border.color.medium};
  z-index: 1001;
  display: flex;
  flex-direction: column;
  box-shadow: ${({ theme }) => theme.boxShadow.light};
`;

const StyledHeader = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(4)};
  border-bottom: 1px solid ${({ theme }) => theme.border.color.medium};
`;

const StyledTitle = styled.div`
  align-items: center;
  color: ${({ theme }) => theme.font.color.primary};
  display: flex;
  flex: 1;
  font-size: ${({ theme }) => theme.font.size.lg};
  font-weight: ${({ theme }) => theme.font.weight.medium};
  gap: ${({ theme }) => theme.spacing(2)};
  min-width: 0;
`;

const StyledCloseButton = styled.button`
  align-items: center;
  background: transparent;
  border: none;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.secondary};
  cursor: pointer;
  display: flex;
  flex-shrink: 0;
  height: ${({ theme }) => theme.spacing(10)};
  justify-content: center;
  padding: 0;
  transition: all 0.2s ease;
  width: ${({ theme }) => theme.spacing(10)};

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    color: ${({ theme }) => theme.font.color.primary};
  }
`;

const StyledContent = styled.div`
  flex: 1;
  overflow-y: auto;
  padding: ${({ theme }) => theme.spacing(2)};
`;

const StyledFooter = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: ${({ theme }) => theme.spacing(3)} ${({ theme }) => theme.spacing(4)};
  border-top: 1px solid ${({ theme }) => theme.border.color.medium};
`;

const StyledCount = styled.div`
  font-size: ${({ theme }) => theme.font.size.sm};
  color: ${({ theme }) => theme.font.color.secondary};
`;

const StyledEmptyState = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(8)};
  color: ${({ theme }) => theme.font.color.secondary};
  text-align: center;
`;

export const NotificationCenter = () => {
  const { t } = useLingui();
  const [isOpen, setIsOpen] = useRecoilState(showNotificationCenterState);
  const notifications = useRecoilValue(notificationsState);
  const unreadCount = useRecoilValue(unreadNotificationsCountState);
  const { markAllAsRead } = useNotifications();

  const handleClose = () => {
    setIsOpen(false);
  };

  const handleMarkAllAsRead = () => {
    markAllAsRead();
  };

  if (!isOpen) return null;

  return (
    <>
      <StyledOverlay onClick={handleClose} />
      <StyledDrawer>
        <StyledHeader>
          <StyledTitle>
            <IconBell size={20} />
            {t`Notifications`}
          </StyledTitle>
          <StyledCloseButton onClick={handleClose} title={t`Close`}>
            <IconX size={24} />
          </StyledCloseButton>
        </StyledHeader>

        <StyledContent>
          {notifications.length > 0 ? (
            <NotificationList />
          ) : (
            <StyledEmptyState>
              <IconBell size={48} strokeWidth={1} />
              <p>{t`No notifications yet`}</p>
            </StyledEmptyState>
          )}
        </StyledContent>

        {notifications.length > 0 && (
          <StyledFooter>
            <StyledCount>
              {unreadCount > 0
                ? t`${unreadCount} unread`
                : t`All caught up!`}
            </StyledCount>
            {unreadCount > 0 && (
              <Button
                variant="secondary"
                size="small"
                onClick={handleMarkAllAsRead}
                Icon={IconCheck}
                title={t`Mark all as read`}
              />
            )}
          </StyledFooter>
        )}
      </StyledDrawer>
    </>
  );
};
