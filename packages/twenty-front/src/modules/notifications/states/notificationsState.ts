import { atom } from 'recoil';

export type Notification = {
  id: string;
  type: 'lead_assigned' | 'follow_up_reminder' | 'ticket_assigned';
  title: string;
  body: string;
  metadata?: Record<string, string>;
  isRead: boolean;
  readAt?: string;
  createdAt: string;
};

export const notificationsState = atom<Notification[]>({
  key: 'notificationsState',
  default: [],
});

export const unreadNotificationsCountState = atom<number>({
  key: 'unreadNotificationsCountState',
  default: 0,
});

export const showNotificationCenterState = atom<boolean>({
  key: 'showNotificationCenterState',
  default: false,
});

export const hasNextPageNotificationsState = atom<boolean>({
  key: 'hasNextPageNotificationsState',
  default: false,
});

export const isLoadingNotificationsState = atom<boolean>({
  key: 'isLoadingNotificationsState',
  default: false,
});
