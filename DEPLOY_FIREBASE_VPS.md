# Deploy Twenty CRM with Firebase Notifications to a VPS

This guide covers deploying your latest changes (including Firebase push notifications) to a VPS using Docker and `docker-compose.mycrm.yml`.

## Prerequisites

- VPS with Docker and Docker Compose (see [DEPLOY.md](./DEPLOY.md) for server setup)
- Firebase project with Cloud Messaging enabled
- FCM V1 service account key (JSON) from Firebase Console

## 1. Prepare Firebase on the VPS

### 1.1 Get Firebase config and service account

From your **local** Firebase setup (or [FIREBASE_SETUP.md](./FIREBASE_SETUP.md)):

- **Frontend (build-time):** In Firebase Console → Project Settings → General → Your apps (web):
  - API Key, Auth Domain, Project ID, Messaging Sender ID, App ID
  - Cloud Messaging → Web Push certificates → **VAPID key**

- **Backend (runtime):** In Firebase Console → Project Settings → Service Accounts:
  - Generate new private key → download the JSON file.

### 1.2 Put the service account file on the VPS

Copy the service account JSON to the server in a non-web-visible directory (e.g. `/opt/mycrm/secrets/`). The filename can be anything (e.g. `service-account.json`).

```bash
# From your machine (use any filename you like)
scp /path/to/service-account-key.json user@your-vps:/opt/mycrm/secrets/service-account.json
```

On the VPS, restrict permissions:

```bash
sudo chmod 600 /opt/mycrm/secrets/service-account.json
```

Then set `FCM_SERVICE_ACCOUNT_HOST_PATH` in `.env` to the **full path to that file** (see step 2).

## 2. Production `.env` on the VPS

In the project root on the VPS (same directory as `docker-compose.mycrm.yml`), create or edit `.env` with at least:

```bash
# Base URLs (use https if you use a reverse proxy)
SERVER_URL=https://your-domain.com
FRONTEND_URL=https://your-domain.com

# Secrets
APP_SECRET=your_long_random_secret_here
PG_DATABASE_PASSWORD=your_strong_db_password

# Firebase – frontend (used at Docker build time)
VITE_FIREBASE_API_KEY=your_firebase_api_key
VITE_FIREBASE_AUTH_DOMAIN=your_project_id.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your_project_id
VITE_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
VITE_FIREBASE_APP_ID=your_app_id
VITE_FIREBASE_VAPID_KEY=your_vapid_key_from_firebase_console

# Firebase – backend (runtime). Path = full path to the JSON file in secrets/
FCM_NOTIFICATIONS_ENABLED=true
FCM_SERVICE_ACCOUNT_HOST_PATH=/opt/mycrm/secrets/service-account.json
```

- **Important:** `SERVER_URL` and `FRONTEND_URL` must be the final URL users use (e.g. `https://crm.example.com`). The frontend and service worker are built with this.
- If you do **not** want push notifications, omit the `VITE_FIREBASE_*` and FCM vars (or set `FCM_NOTIFICATIONS_ENABLED=false`). The app will run without FCM.

## 3. Deploy or update the stack

### First-time deploy

```bash
cd /opt/mycrm

# Build images (includes frontend with Firebase config and service worker)
docker compose -f docker-compose.mycrm.yml build

# Start all services
docker compose -f docker-compose.mycrm.yml up -d

# Watch until server is healthy
docker compose -f docker-compose.mycrm.yml logs -f server
```

### Deploy latest changes (e.g. after git pull)

Rebuild so the new frontend (and any backend) code is in the image, then recreate the containers and run any new database migrations:

```bash
cd /opt/mycrm

git pull   # or rsync your latest code

# Rebuild server and worker (frontend is baked into the server image)
docker compose -f docker-compose.mycrm.yml build server worker

# Recreate and start
docker compose -f docker-compose.mycrm.yml up -d

# Run database migrations (creates new tables like core.notification, etc.)
docker compose -f docker-compose.mycrm.yml exec server yarn database:migrate:prod

# Optional: check logs
docker compose -f docker-compose.mycrm.yml logs -f server
```

After this, the server serves the new build (including `firebase-messaging-sw.js` and Firebase config). **Always run migrations after deploying code that adds or changes database schema.**

## 4. Verify Firebase and push notifications

1. **Service worker:** Open `https://your-domain.com/firebase-messaging-sw.js` in a browser. It should return JavaScript (not 404), with your Firebase config in the file (no secrets; only client config).

2. **In the app:** Log in, allow notification permission when prompted, then assign a lead to a user. That user should get:
   - In-app notification
   - Browser push (if supported)
   - Email (if email is configured)

3. **Backend logs:** If push fails, check server logs for FCM errors:
   ```bash
   docker compose -f docker-compose.mycrm.yml logs server | grep -i fcm
   ```

## 5. Checklist summary

| Step | Action |
|------|--------|
| 1 | Copy FCM service account JSON to VPS (e.g. `/opt/mycrm/secrets/fcm-service-account.json`) |
| 2 | Create `.env` with `SERVER_URL`, `FRONTEND_URL`, `VITE_FIREBASE_*`, `VITE_FIREBASE_VAPID_KEY`, `FCM_NOTIFICATIONS_ENABLED=true`, `FCM_SERVICE_ACCOUNT_HOST_PATH=...` |
| 3 | Run `docker compose -f docker-compose.mycrm.yml build server worker` then `up -d` |
| 4 | Run `docker compose -f docker-compose.mycrm.yml exec server yarn database:migrate:prod` (required for notifications and any new DB schema) |
| 5 | Confirm `https://your-domain.com/firebase-messaging-sw.js` is served and push works in the app |

## 6. Troubleshooting

- **`relation "core.notification" does not exist` / GET_NOTIFICATIONS failed:** The notification table was added in a migration that has not been run on this database. Run migrations: `docker compose -f docker-compose.mycrm.yml exec server yarn database:migrate:prod`. Then reload the app; the notification center should work.
- **Push not received:** Ensure the browser has notification permission, the tab or PWA is from the same origin as `SERVER_URL`, and the service worker is registered (DevTools → Application → Service Workers).
- **FCM errors in logs:** Check that `FCM_SERVICE_ACCOUNT_HOST_PATH` points to the real JSON file on the host and the volume mount is correct (`docker compose -f docker-compose.mycrm.yml exec server cat /app/fcm-service-account.json` should print the JSON).
- **Service worker 404:** Rebuild the image so the frontend build (including `firebase-messaging-sw.js`) is updated and redeploy.
- **Wrong API URL in app:** Rebuild with the correct `SERVER_URL` and `FRONTEND_URL` in `.env`; these are baked in at build time.

For more on Firebase setup and backend config, see [FIREBASE_SETUP.md](./FIREBASE_SETUP.md). For general VPS deployment, see [DEPLOY.md](./DEPLOY.md).
