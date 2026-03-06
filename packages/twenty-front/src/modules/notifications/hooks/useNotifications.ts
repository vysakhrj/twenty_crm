import { useCallback } from 'react';
import { useQuery, useMutation, useSubscription } from '@apollo/client';
import { useRecoilState, useSetRecoilState } from 'recoil';
import { isDefined } from 'twenty-shared/utils';

import {
  GET_NOTIFICATIONS,
  GET_UNREAD_NOTIFICATIONS_COUNT,
  MARK_NOTIFICATION_AS_READ,
  MARK_ALL_NOTIFICATIONS_AS_READ,
  DELETE_NOTIFICATION,
  NOTIFICATION_RECEIVED_SUBSCRIPTION,
} from '../graphql/queries';
import {
  notificationsState,
  unreadNotificationsCountState,
  hasNextPageNotificationsState,
  isLoadingNotificationsState,
  type Notification,
} from '../states/notificationsState';

const PAGE_SIZE = 20;

export const useNotifications = (options?: { skipFullFetch?: boolean }) => {
  const [notifications, setNotifications] = useRecoilState(notificationsState);
  const [unreadCount, setUnreadCount] = useRecoilState(
    unreadNotificationsCountState,
  );
  const [hasNextPage, setHasNextPage] = useRecoilState(
    hasNextPageNotificationsState,
  );
  const setIsLoading = useSetRecoilState(isLoadingNotificationsState);

  const { fetchMore, refetch } = useQuery(GET_NOTIFICATIONS, {
    variables: { first: PAGE_SIZE },
    fetchPolicy: 'network-only',
    skip: options?.skipFullFetch === true,
    onCompleted: (data) => {
      if (data?.notifications) {
        setNotifications(data.notifications.edges);
        setHasNextPage(data.notifications.pageInfo.hasNextPage);
      }
    },
    onError: (error) => {
      console.error('[useNotifications] GET_NOTIFICATIONS failed:', error.message);
    },
  });

  const { refetch: refetchUnreadCount } = useQuery(
    GET_UNREAD_NOTIFICATIONS_COUNT,
    {
      fetchPolicy: 'network-only',
      onCompleted: (data) => {
        if (isDefined(data?.unreadNotificationsCount)) {
          setUnreadCount(data.unreadNotificationsCount);
        }
      },
      onError: (error) => {
        console.error(
          '[useNotifications] GET_UNREAD_NOTIFICATIONS_COUNT failed:',
          error.message,
        );
      },
    },
  );

  useSubscription(NOTIFICATION_RECEIVED_SUBSCRIPTION, {
    onData: ({ data }) => {
      const notification = data?.data?.notificationReceived;
      if (notification) {
        setNotifications((prev) => {
          const exists = prev.some((n) => n.id === notification.id);

          if (exists) {
            return prev;
          }

          return [notification, ...prev];
        });
        setUnreadCount((prev) => prev + 1);
      }
    },
  });

  const [markAsReadMutation] = useMutation(MARK_NOTIFICATION_AS_READ);
  const [markAllAsReadMutation] = useMutation(MARK_ALL_NOTIFICATIONS_AS_READ);
  const [deleteMutation] = useMutation(DELETE_NOTIFICATION);

  const markAsRead = useCallback(
    async (id: string) => {
      const result = await markAsReadMutation({ variables: { id } });
      if (result.data?.markNotificationAsRead) {
        setNotifications((prev) =>
          prev.map((n) =>
            n.id === id
              ? { ...n, isRead: true, readAt: new Date().toISOString() }
              : n,
          ),
        );
        setUnreadCount((prev) => Math.max(0, prev - 1));
      }
    },
    [markAsReadMutation, setNotifications, setUnreadCount],
  );

  const markAllAsRead = useCallback(async () => {
    const result = await markAllAsReadMutation();
    if (result.data?.markAllNotificationsAsRead) {
      setNotifications((prev) =>
        prev.map((n) =>
          n.isRead
            ? n
            : { ...n, isRead: true, readAt: new Date().toISOString() },
        ),
      );
      setUnreadCount(0);
    }
  }, [markAllAsReadMutation, setNotifications, setUnreadCount]);

  const deleteNotification = useCallback(
    async (id: string) => {
      const result = await deleteMutation({ variables: { id } });
      if (result.data?.deleteNotification) {
        const deletedNotification = notifications.find((n) => n.id === id);
        setNotifications((prev) => prev.filter((n) => n.id !== id));
        if (deletedNotification && !deletedNotification.isRead) {
          setUnreadCount((prev) => Math.max(0, prev - 1));
        }
      }
    },
    [deleteMutation, notifications, setNotifications, setUnreadCount],
  );

  const loadMore = useCallback(async () => {
    if (!hasNextPage) return;

    setIsLoading(true);
    const lastNotification = notifications[notifications.length - 1];
    const after = lastNotification?.createdAt;

    const result = await fetchMore({
      variables: { first: PAGE_SIZE, after },
    });

    if (result.data?.notifications) {
      setNotifications((prev) => [
        ...prev,
        ...result.data.notifications.edges,
      ]);
      setHasNextPage(result.data.notifications.pageInfo.hasNextPage);
    }
    setIsLoading(false);
  }, [
    fetchMore,
    hasNextPage,
    notifications,
    setNotifications,
    setHasNextPage,
    setIsLoading,
  ]);

  const refresh = useCallback(async () => {
    await refetch();
    await refetchUnreadCount();
  }, [refetch, refetchUnreadCount]);

  return {
    notifications,
    unreadCount,
    hasNextPage,
    markAsRead,
    markAllAsRead,
    deleteNotification,
    loadMore,
    refresh,
  };
};
