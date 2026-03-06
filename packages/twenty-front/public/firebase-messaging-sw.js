// Firebase Cloud Messaging Service Worker
// This file is loaded by the browser when a push notification is received

importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

// Firebase configuration for sfs-crm-5f038 project
// These values are replaced during build by vite.config.ts
const firebaseConfig = {
  apiKey: self.__FIREBASE_API_KEY__ || 'AIzaSyBG3M5VG_f65RZJuZM5KiYuRadBFNggheU',
  authDomain: self.__FIREBASE_AUTH_DOMAIN__ || 'sfs-crm-5f038.firebaseapp.com',
  projectId: self.__FIREBASE_PROJECT_ID__ || 'sfs-crm-5f038',
  messagingSenderId: self.__FIREBASE_MESSAGING_SENDER_ID__ || '1048685449819',
  appId: self.__FIREBASE_APP_ID__ || '1:1048685449819:web:cc7bd49fd814bfa0f4a57e',
};
const SW_VERSION = '2026-03-06-01';

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();
const recentNotificationKeys = new Map();
const DEDUPE_WINDOW_MS = 5000;

const getNotificationDedupeKey = (payload) => {
  const payloadData = payload?.data || {};
  return (
    payload?.fcmMessageId ||
    payloadData.notificationId ||
    payloadData['google.c.a.c_id'] ||
    payload?.collapse_key ||
    `${payload?.notification?.title || payloadData.title || 'title'}:${payload?.notification?.body || payloadData.body || 'body'}`
  );
};

const shouldSkipDuplicateNotification = (payload) => {
  const key = getNotificationDedupeKey(payload);
  const now = Date.now();
  const seenAt = recentNotificationKeys.get(key);

  if (seenAt && now - seenAt < DEDUPE_WINDOW_MS) {
    return true;
  }

  recentNotificationKeys.set(key, now);

  if (recentNotificationKeys.size > 50) {
    for (const [recentKey, timestamp] of recentNotificationKeys.entries()) {
      if (now - timestamp >= DEDUPE_WINDOW_MS) {
        recentNotificationKeys.delete(recentKey);
      }
    }
  }

  return false;
};

const showNotificationFromPayload = (payload, fallbackTitle = 'New Notification') => {
  if (shouldSkipDuplicateNotification(payload)) {
    return Promise.resolve();
  }

  const notificationTitle =
    payload?.notification?.title ||
    payload?.data?.title ||
    `${fallbackTitle} (SW ${SW_VERSION})`;
  const notificationOptions = {
    body: payload?.notification?.body || payload?.data?.body || '',
    tag:
      payload?.notification?.tag ||
      payload?.data?.notificationId ||
      payload?.data?.type ||
      payload?.collapse_key ||
      'default',
    data: payload?.data || {},
    requireInteraction: true,
  };

  if (payload?.notification?.icon) {
    notificationOptions.icon = payload.notification.icon;
  }

  if (payload?.notification?.badge) {
    notificationOptions.badge = payload.notification.badge;
  }

  return self.registration
    .showNotification(notificationTitle, notificationOptions)
    .catch((error) => {
      console.error('showNotification failed:', error, payload);
    });
};

const notifyClientsAboutPush = (payload) => {
  return clients
    .matchAll({ type: 'window', includeUncontrolled: true })
    .then((windowClients) => {
      for (const client of windowClients) {
        client.postMessage({
          type: 'fcm_notification_received',
          data: payload?.data || {},
        });
      }
    });
};

const parsePushEventPayload = (event) => {
  if (!event.data) {
    return {};
  }

  try {
    return event.data.json();
  } catch (error) {
    return {
      notification: {
        title: 'New Notification',
        body: event.data.text(),
      },
    };
  }
};

// Handle Firebase SDK background callback
messaging.onBackgroundMessage((payload) => {
  notifyClientsAboutPush(payload);
  showNotificationFromPayload(payload);
});

// Handle raw Push API events (works for DevTools push test and FCM push payloads)
self.addEventListener('push', (event) => {
  const payload = parsePushEventPayload(event);
  event.waitUntil(
    Promise.all([
      notifyClientsAboutPush(payload),
      showNotificationFromPayload(payload, 'Push Notification'),
    ]),
  );
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  const data = event.notification.data || {};
  let url = '/';

  // Navigate based on notification type
  if (data.type === 'lead_assigned' && data.leadId) {
    url = `/objects/leads/${data.leadId}`;
  } else if (data.type === 'follow_up_reminder' && data.leadId) {
    url = `/objects/leads/${data.leadId}`;
  }

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((windowClients) => {
      // If a window client is already open, focus it and navigate
      for (const client of windowClients) {
        if (client.url && 'focus' in client) {
          return client.focus().then(() => {
            if ('navigate' in client) {
              return client.navigate(url);
            }
          });
        }
      }
      // Otherwise open a new window
      if (clients.openWindow) {
        return clients.openWindow(url);
      }
    })
  );
});

// Handle service worker install
self.addEventListener('install', (event) => {
  event.waitUntil(self.skipWaiting());
});

// Handle service worker activate
self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
  console.log(`firebase-messaging-sw activated: ${SW_VERSION}`);
});
