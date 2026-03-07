// Firebase Cloud Messaging Service Worker
// This file is loaded by the browser when a push notification is received

importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

// Firebase config is injected at build time from VITE_FIREBASE_* env vars (vite.config.ts)
const firebaseConfig = {
  apiKey: self.__FIREBASE_API_KEY__ || '',
  authDomain: self.__FIREBASE_AUTH_DOMAIN__ || '',
  projectId: self.__FIREBASE_PROJECT_ID__ || '',
  messagingSenderId: self.__FIREBASE_MESSAGING_SENDER_ID__ || '',
  appId: self.__FIREBASE_APP_ID__ || '',
};
const SW_VERSION = '2026-03-07-02';

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

// Absolute URL for notification icon (Chrome needs 96x96+ for reliable display)
const getDefaultNotificationIconUrl = () => {
  const base = self.registration?.scope || self.location.origin + '/';
  return new URL('/inceptra-favicon.png', base).href;
};

const showNotificationFromPayload = (payload, fallbackTitle = 'New Notification') => {
  if (shouldSkipDuplicateNotification(payload)) {
    return Promise.resolve();
  }

  const notificationTitle =
    payload?.notification?.title ||
    payload?.data?.title ||
    `${fallbackTitle} (SW ${SW_VERSION})`;
  const payloadIcon =
    payload?.notification?.icon || payload?.data?.icon;
  const iconUrl =
    typeof payloadIcon === 'string' && payloadIcon.trim()
      ? payloadIcon
      : getDefaultNotificationIconUrl();
  const notificationOptions = {
    body: payload?.notification?.body || payload?.data?.body || '',
    icon: iconUrl,
    tag:
      payload?.notification?.tag ||
      payload?.data?.notificationId ||
      payload?.data?.type ||
      payload?.collapse_key ||
      'default',
    data: payload?.data || {},
    requireInteraction: true,
  };

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

// Handle Firebase SDK background callback (notification is shown by push listener below)
messaging.onBackgroundMessage((payload) => {
  notifyClientsAboutPush(payload);
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
