import styled from '@emotion/styled';
import { useRecoilValue } from 'recoil';

import { Loader } from 'twenty-ui/feedback';

import { NotificationItem } from './NotificationItem';
import { useNotifications } from '../hooks/useNotifications';
import { notificationsState, hasNextPageNotificationsState, isLoadingNotificationsState } from '../states/notificationsState';

const StyledList = styled.div`
  display: flex;
  flex-direction: column;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(2)};
`;

const StyledLoadMoreButton = styled.button`
  display: flex;
  align-items: center;
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(3)};
  background: transparent;
  border: 1px solid ${({ theme }) => theme.border.color.medium};
  border-radius: ${({ theme }) => theme.border.radius.md};
  color: ${({ theme }) => theme.font.color.secondary};
  font-size: ${({ theme }) => theme.font.size.sm};
  cursor: pointer;
  transition: all 0.2s ease;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.light};
    color: ${({ theme }) => theme.font.color.primary};
  }
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

const StyledEmptyStateIcon = styled.div`
  width: 64px;
  height: 64px;
  border-radius: ${({ theme }) => theme.border.radius.md};
  background: ${({ theme }) => theme.background.transparent.light};
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: ${({ theme }) => theme.spacing(3)};
  color: ${({ theme }) => theme.font.color.tertiary};
`;

const StyledEmptyStateText = styled.div`
  font-size: ${({ theme }) => theme.font.size.md};
  color: ${({ theme }) => theme.font.color.secondary};
`;

const StyledLoaderContainer = styled.div`
  display: flex;
  justify-content: center;
  padding: ${({ theme }) => theme.spacing(3)};
`;

export const NotificationList = () => {
  const notifications = useRecoilValue(notificationsState);
  const hasNextPage = useRecoilValue(hasNextPageNotificationsState);
  const isLoading = useRecoilValue(isLoadingNotificationsState);
  const { markAsRead, deleteNotification, loadMore } = useNotifications();

  if (notifications.length === 0 && !isLoading) {
    return (
      <StyledEmptyState>
        <StyledEmptyStateIcon>
          <svg
            width="32"
            height="32"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="1.5"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9" />
            <path d="M10.3 21a1.94 1.94 0 0 0 3.4 0" />
          </svg>
        </StyledEmptyStateIcon>
        <StyledEmptyStateText>No notifications yet</StyledEmptyStateText>
      </StyledEmptyState>
    );
  }

  return (
    <StyledList>
      {notifications.map((notification) => (
        <NotificationItem
          key={notification.id}
          notification={notification}
          onMarkAsRead={markAsRead}
          onDelete={deleteNotification}
        />
      ))}

      {isLoading && (
        <StyledLoaderContainer>
          <Loader />
        </StyledLoaderContainer>
      )}

      {hasNextPage && !isLoading && (
        <StyledLoadMoreButton onClick={loadMore}>
          Load more
        </StyledLoadMoreButton>
      )}
    </StyledList>
  );
};
