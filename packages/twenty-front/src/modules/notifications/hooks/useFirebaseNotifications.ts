import { useEffect, useRef } from 'react';
import { useSetRecoilState } from 'recoil';

import { onForegroundMessage } from '@/firebase/services/firebase-messaging.service';
import {
  notificationsState,
  unreadNotificationsCountState,
  type Notification,
} from '../states/notificationsState';

export const useFirebaseNotifications = () => {
  const setNotifications = useSetRecoilState(notificationsState);
  const setUnreadCount = useSetRecoilState(unreadNotificationsCountState);
  const unsubscribeRef = useRef<(() => void) | null>(null);

  useEffect(() => {
    const reloadLeadsPageIfNeeded = (notificationType?: string) => {
      const isLeadPage = window.location.pathname.startsWith('/objects/leads');
      const isLeadNotification =
        notificationType === 'lead_assigned' ||
        notificationType === 'follow_up_reminder';

      if (isLeadPage && isLeadNotification) {
        window.location.reload();
      }
    };

    unsubscribeRef.current = onForegroundMessage((payload) => {
      const { notification: fcmNotification, data } = payload;

      if (!fcmNotification) {
        reloadLeadsPageIfNeeded(data?.type);

        return;
      }

      // Show browser system notification
      if (Notification.permission === 'granted') {
        const iconUrl = `${window.location.origin}/inceptra-favicon.png`;
        const systemNotification = new Notification(
          fcmNotification.title ?? 'New Notification',
          {
            body: fcmNotification.body ?? '',
            icon: iconUrl,
            tag: data?.notificationId ?? data?.type ?? 'default',
            requireInteraction: true,
          },
        );

        systemNotification.onclick = () => {
          window.focus();
          systemNotification.close();

          if (data?.type === 'lead_assigned' && data?.leadId) {
            window.location.href = `/objects/leads/${data.leadId}`;
          } else if (data?.type === 'follow_up_reminder' && data?.leadId) {
            window.location.href = `/objects/leads/${data.leadId}`;
          }
        };
      }

      reloadLeadsPageIfNeeded(data?.type);

      // Optimistically add to the notification list if we have enough data
      if (data?.notificationId) {
        const newNotification: Notification = {
          id: data.notificationId,
          type: (data.type as Notification['type']) ?? 'lead_assigned',
          title: fcmNotification.title ?? 'Notification',
          body: fcmNotification.body ?? '',
          metadata: data as Record<string, string>,
          isRead: false,
          createdAt: new Date().toISOString(),
        };

        setNotifications((prev) => {
          const exists = prev.some((n) => n.id === newNotification.id);

          if (exists) {
            return prev;
          }

          return [newNotification, ...prev];
        });

        setUnreadCount((prev) => prev + 1);
      }
    });

    const handleServiceWorkerMessage = (
      event: MessageEvent<{ type?: string; data?: { type?: string } }>,
    ) => {
      if (event.data?.type !== 'fcm_notification_received') {
        return;
      }

      reloadLeadsPageIfNeeded(event.data.data?.type);
    };

    navigator.serviceWorker?.addEventListener('message', handleServiceWorkerMessage);

    return () => {
      if (unsubscribeRef.current) {
        unsubscribeRef.current();
      }

      navigator.serviceWorker?.removeEventListener(
        'message',
        handleServiceWorkerMessage,
      );
    };
  }, [setNotifications, setUnreadCount]);
};
