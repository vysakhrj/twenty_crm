# Firebase Push Notification Setup

This guide will help you complete the Firebase Cloud Messaging setup for push notifications.

## Your Firebase Configuration

Your project is already configured with these values:

- **Project ID**: `sfs-crm-5f038`
- **API Key**: `AIzaSyBG3M5VG_f65RZJuZM5KiYuRadBFNggheU`
- **Auth Domain**: `sfs-crm-5f038.firebaseapp.com`
- **Messaging Sender ID**: `1048685449819`
- **App ID**: `1:1048685449819:web:cc7bd49fd814bfa0f4a57e`
- **VAPID Key**: `BNv9ljt-ZUDS9r7hSN9K4d3EfVRwdBh4y5ZmlkyPS_4ql5HNP5BOJLOMQ_d1W2nVQ4ziGv7m3IAzUetIjpML7zo`

## Backend Configuration (FCM V1 API - Recommended)

The backend uses the **FCM V1 API** which is more secure and modern than the legacy API.

### Step 1: Generate Service Account Key

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project `sfs-crm-5f038`
3. Click the **gear icon** (⚙️) next to "Project Overview" and select **Project Settings**
4. Go to the **Service Accounts** tab
5. Click **"Generate new private key"**
6. Click **"Generate key"** to confirm
7. Save the JSON file (e.g., `service-account-key.json`)

### Step 2: Configure Environment Variable

Add the path to your service account key file in `packages/twenty-server/.env`:

```bash
FCM_SERVICE_ACCOUNT_PATH=/absolute/path/to/service-account-key.json
```

**Note:** Use the absolute path to the file, not a relative path.

### Example paths:
- macOS/Linux: `/Users/yourname/Downloads/service-account-key.json`
- Windows: `C:\Users\YourName\Downloads\service-account-key.json`
- Docker: Place the file in a mounted volume and use that path

## Frontend Configuration

The frontend is already configured with your Firebase values. The VAPID key has been added to `packages/twenty-front/.env`.

## Alternative: Legacy API (Not Recommended)

If you cannot use the V1 API, you can enable the Legacy API:

1. Go to Firebase Console > Project Settings > Cloud Messaging
2. Scroll to "Cloud Messaging API (Legacy)"
3. Click **Enable**
4. Find the "Server key" in "Project credentials"
5. Add to `packages/twenty-server/.env`:
   ```bash
   FCM_SERVER_KEY=your_server_key_here
   ```

**Note:** The Legacy API will be deprecated in the future. Use the V1 API when possible.

## Testing Push Notifications

Once you've configured the service account:

1. Restart both frontend and backend servers
2. Log in to the CRM
3. Allow notification permissions when prompted by the browser
4. Assign a lead to a sales person
5. The sales person should receive:
   - An in-app notification (appears in the notification center)
   - A browser push notification (if the browser supports it)
   - An email notification

## Troubleshooting

### No push notifications received?

1. Check browser console for errors (F12 > Console)
2. Ensure service worker is registered:
   - Open DevTools > Application > Service Workers
   - Check if `firebase-messaging-sw.js` is registered
3. Verify FCM token is stored:
   - Open DevTools > Application > Local Storage
   - Look for `fcmToken` key
4. Check backend logs for errors when sending notifications

### Service Account Authentication Errors?

- Ensure the JSON file path is correct and absolute
- Verify the service account has the "Firebase Cloud Messaging API" permission
- Check that the file is readable by the application

### VAPID Key errors?

- The VAPID key is already configured in `.env`
- If you need to regenerate it:
  - Go to Firebase Console > Cloud Messaging > Web Push certificates
  - Delete the old key and generate a new one
  - Update `VITE_FIREBASE_VAPID_KEY` in `packages/twenty-front/.env`

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (React)                          │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────┐     │
│  │ Notification │  │  Firebase    │  │  Service Worker │     │
│  │    Center    │  │    SDK       │  │   (Push Notif)  │     │
│  └──────────────┘  └──────────────┘  └─────────────────┘     │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                     BACKEND (NestJS)                        │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────┐     │
│  │ Notification │  │    Email     │  │   FCM V1 API    │     │
│  │    GraphQL   │  │    Service   │  │  (Service Acct) │     │
│  └──────────────┘  └──────────────┘  └─────────────────┘     │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────┐     │
│  │  Lead Assign │  │ Follow-up    │  │    BullMQ       │     │
│  │   Listener   │  │  Cron Job   │  │   Job Queue     │     │
│  └──────────────┘  └──────────────┘  └─────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## Features Implemented

- **Lead Assignment Notifications**: Push + Email + In-app when leads are assigned
- **Follow-up Reminders**: Daily cron job at 9 AM checks for leads due within 24 hours
- **Real-time Updates**: GraphQL subscriptions for instant notification delivery
- **Notification Center**: Slide-out drawer with read/unread status
- **Pagination**: Load more notifications as you scroll
- **Email Templates**: Professional templates for lead assignment and reminders
- **Multi-channel Support**: Push, Email, and In-app notifications

## Next Steps

1. Generate and download your service account key from Firebase Console
2. Add the path to `packages/twenty-server/.env`
3. Run `yarn install` to install dependencies (if not already done)
4. Run the database migration to create the notification table:
   ```bash
   npx nx run twenty-server:typeorm migration:run -d src/database/typeorm/core/core.datasource.ts
   ```
5. Register the cron job:
   ```bash
   npx nx run twenty-server:command cron:register:all
   ```
6. Start the servers and test!
