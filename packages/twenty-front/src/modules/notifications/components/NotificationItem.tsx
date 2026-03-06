import styled from '@emotion/styled';
import { formatDistanceToNow } from 'date-fns';
import { MouseEvent } from 'react';
import { useNavigate } from 'react-router-dom';

import { IconCheckbox, IconTrash, IconBell, IconCalendarEvent, IconUser } from 'twenty-ui/display';

import { type Notification } from '../states/notificationsState';

const StyledNotificationItem = styled.div<{ isRead: boolean }>`
  display: flex;
  align-items: flex-start;
  gap: ${({ theme }) => theme.spacing(2)};
  padding: ${({ theme }) => theme.spacing(3)};
  background: ${({ theme, isRead }) =>
    isRead ? theme.background.primary : theme.background.transparent.light};
  border-radius: ${({ theme }) => theme.border.radius.md};
  cursor: pointer;
  transition: background 0.2s ease;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.medium};
  }
`;

const StyledIconContainer = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  background: ${({ theme }) => theme.color.blue};
  color: ${({ theme }) => theme.font.color.inverted};
  flex-shrink: 0;
`;

const StyledContent = styled.div`
  flex: 1;
  min-width: 0;
`;

const StyledTitle = styled.div`
  font-weight: ${({ theme }) => theme.font.weight.medium};
  font-size: ${({ theme }) => theme.font.size.md};
  color: ${({ theme }) => theme.font.color.primary};
  margin-bottom: ${({ theme }) => theme.spacing(1)};
`;

const StyledBody = styled.div`
  font-size: ${({ theme }) => theme.font.size.sm};
  color: ${({ theme }) => theme.font.color.secondary};
  margin-bottom: ${({ theme }) => theme.spacing(1)};
  line-height: 1.4;
`;

const StyledTime = styled.div`
  font-size: ${({ theme }) => theme.font.size.xs};
  color: ${({ theme }) => theme.font.color.tertiary};
`;

const StyledActions = styled.div`
  display: flex;
  gap: ${({ theme }) => theme.spacing(1)};
  opacity: 0;
  transition: opacity 0.2s ease;

  .notification-item:hover & {
    opacity: 1;
  }
`;

const StyledActionButton = styled.button`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  border: none;
  background: transparent;
  border-radius: ${({ theme }) => theme.border.radius.sm};
  color: ${({ theme }) => theme.font.color.tertiary};
  cursor: pointer;
  transition: all 0.2s ease;

  &:hover {
    background: ${({ theme }) => theme.background.transparent.medium};
    color: ${({ theme }) => theme.font.color.primary};
  }
`;

const StyledUnreadIndicator = styled.div`
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: ${({ theme }) => theme.color.blue};
  flex-shrink: 0;
  margin-top: 6px;
`;

type NotificationItemProps = {
  notification: Notification;
  onMarkAsRead: (id: string) => void;
  onDelete: (id: string) => void;
};

const getNotificationIcon = (type: Notification['type']) => {
  switch (type) {
    case 'lead_assigned':
      return IconUser;
    case 'follow_up_reminder':
      return IconCalendarEvent;
    default:
      return IconBell;
  }
};

export const NotificationItem = ({
  notification,
  onMarkAsRead,
  onDelete,
}: NotificationItemProps) => {
  const navigate = useNavigate();
  const Icon = getNotificationIcon(notification.type);

  const handleClick = () => {
    if (!notification.isRead) {
      onMarkAsRead(notification.id);
    }

    // Navigate based on notification type
    if (notification.metadata?.leadId) {
      navigate(`/objects/leads/${notification.metadata.leadId}`);
    }
  };

  const handleMarkAsRead = (e: MouseEvent) => {
    e.stopPropagation();
    onMarkAsRead(notification.id);
  };

  const handleDelete = (e: MouseEvent) => {
    e.stopPropagation();
    onDelete(notification.id);
  };

  return (
    <StyledNotificationItem
      className="notification-item"
      isRead={notification.isRead}
      onClick={handleClick}
    >
      <StyledIconContainer>
        <Icon size={20} />
      </StyledIconContainer>

      <StyledContent>
        <StyledTitle>{notification.title}</StyledTitle>
        <StyledBody>{notification.body}</StyledBody>
        <StyledTime>
          {formatDistanceToNow(new Date(notification.createdAt), {
            addSuffix: true,
          })}
        </StyledTime>
      </StyledContent>

      {!notification.isRead && <StyledUnreadIndicator />}

      <StyledActions>
        {!notification.isRead && (
          <StyledActionButton
            onClick={handleMarkAsRead}
            title="Mark as read"
          >
            <IconCheckbox size={16} />
          </StyledActionButton>
        )}
        <StyledActionButton
          onClick={handleDelete}
          title="Delete"
        >
          <IconTrash size={16} />
        </StyledActionButton>
      </StyledActions>
    </StyledNotificationItem>
  );
};
