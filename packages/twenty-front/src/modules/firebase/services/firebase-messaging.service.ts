import { getApp, getApps, initializeApp } from 'firebase/app';
import {
  getMessaging,
  getToken,
  isSupported,
  onMessage,
  type Messaging,
} from 'firebase/messaging';

const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
};

let messaging: Messaging | null = null;
let messagingSwRegistration: ServiceWorkerRegistration | null = null;
const FIREBASE_MESSAGING_SW_VERSION = '2026-03-07-02';
const FIREBASE_MESSAGING_SW_URL =
  `/firebase-messaging-sw.js?v=${FIREBASE_MESSAGING_SW_VERSION}`;
type ForegroundMessagePayload = {
  notification?: {
    title?: string;
    body?: string;
  };
  data?: Record<string, string>;
};
const foregroundMessageCallbacks = new Set<
  (payload: ForegroundMessagePayload) => void
>();
let unsubscribeForegroundOnMessage: (() => void) | null = null;

const ensureForegroundMessageListener = () => {
  if (!messaging || unsubscribeForegroundOnMessage) {
    return;
  }

  unsubscribeForegroundOnMessage = onMessage(messaging, (payload) => {
    const mappedPayload: ForegroundMessagePayload = {
      notification: payload.notification as { title?: string; body?: string } | undefined,
      data: payload.data as Record<string, string> | undefined,
    };

    for (const callback of foregroundMessageCallbacks) {
      callback(mappedPayload);
    }
  });
};

const registerFirebaseMessagingServiceWorker = async (): Promise<ServiceWorkerRegistration | null> => {
  if (!('serviceWorker' in navigator)) {
    return null;
  }

  if (messagingSwRegistration) {
    return messagingSwRegistration;
  }

  try {
    messagingSwRegistration = await navigator.serviceWorker.register(
      FIREBASE_MESSAGING_SW_URL,
      {
        scope: '/',
        updateViaCache: 'none',
      },
    );

    await navigator.serviceWorker.ready;
    await messagingSwRegistration.update();

    return messagingSwRegistration;
  } catch (error) {
    console.error('Failed to register Firebase messaging service worker:', error);

    return null;
  }
};

export const ensureFirebaseMessagingServiceWorkerRegistration = async (): Promise<ServiceWorkerRegistration | null> => {
  if (typeof window === 'undefined') {
    return null;
  }

  return registerFirebaseMessagingServiceWorker();
};

export const initializeFirebaseMessaging = async (): Promise<string | null> => {
  // Check if Firebase config is available
  if (!firebaseConfig.apiKey || !firebaseConfig.projectId) {
    console.warn('Firebase configuration is missing. Push notifications will not be available.');

    return null;
  }

  try {
    const messagingSupported = await isSupported();
    if (!messagingSupported) {
      console.warn('Firebase messaging is not supported in this browser');

      return null;
    }

    const app = getApps().length > 0 ? getApp() : initializeApp(firebaseConfig);
    messaging = getMessaging(app);
    ensureForegroundMessageListener();

    // Request permission
    const permission = await Notification.requestPermission();
    if (permission !== 'granted') {
      console.warn('Notification permission not granted');

      return null;
    }

    const serviceWorkerRegistration =
      await registerFirebaseMessagingServiceWorker();
    if (!serviceWorkerRegistration) {
      console.warn('Firebase messaging service worker registration is unavailable');

      return null;
    }

    // Get FCM token
    const vapidKey = import.meta.env.VITE_FIREBASE_VAPID_KEY;
    const token = await getToken(messaging, {
      serviceWorkerRegistration,
      ...(vapidKey ? { vapidKey } : {}),
    });

    if (token) {
      localStorage.setItem('fcmToken', token);

      return token;
    } else {
      console.warn('No FCM token available');

      return null;
    }
  } catch (error) {
    console.error('Failed to initialize Firebase messaging:', error);

    return null;
  }
};

// Listen for foreground messages
export const onForegroundMessage = (
  callback: (payload: ForegroundMessagePayload) => void,
): (() => void) => {
  foregroundMessageCallbacks.add(callback);
  ensureForegroundMessageListener();

  return () => {
    foregroundMessageCallbacks.delete(callback);

    if (
      foregroundMessageCallbacks.size === 0 &&
      unsubscribeForegroundOnMessage
    ) {
      unsubscribeForegroundOnMessage();
      unsubscribeForegroundOnMessage = null;
    }
  };
};

// Check if notifications are supported
export const areNotificationsSupported = (): boolean => {
  return 'Notification' in window && 'serviceWorker' in navigator;
};
