# Deploying Twenty CRM to Render

Use these settings to deploy the app as a **Web Service** on Render, with **PostgreSQL** and **Redis** (Key Value) on the same region.

## 1. New Web Service form (your screenshot)

| Field | Value |
|-------|--------|
| **Source Code** | `vysakhrj / twenty_crm` (keep as is) |
| **Name** | `twenty_crm` (or any name) |
| **Language** | `Docker` ✓ |
| **Branch** | `sfs-crm` ✓ |
| **Region** | `Virginia (US East)` ✓ (use same region for DB and Redis) |
| **Root Directory** | `/` (repo root; leave as is so Docker build context is the whole repo) |
| **Dockerfile Path** | `packages/twenty-docker/twenty/Dockerfile` |

**Important:** Set **Dockerfile Path** to `packages/twenty-docker/twenty/Dockerfile`. The default `.` looks for `./Dockerfile` at the repo root, but your Dockerfile lives under `packages/twenty-docker/twenty/`.

---

## 2. Add PostgreSQL and Redis

Render does not run docker-compose, so you create Postgres and Redis as separate services:

1. **PostgreSQL**
   In the Render Dashboard: **New → PostgreSQL**.
   - Choose the **same region** (e.g. Virginia).
   - After creation, copy the **Internal Database URL** (e.g. `postgres://user:pass@dpg-xxx/dbname`).

2. **Redis (Key Value)**
   **New → Key Value Store** (Redis).
   - Same region.
   - After creation, copy the **Internal Redis URL** (e.g. `redis://red-xxx:6379`).

---

## 3. Web Service environment variables

In your **Web Service → Environment**, add:

| Key | Value / source |
|-----|------------------|
| `PG_DATABASE_URL` | Internal Database URL from your Render Postgres |
| `REDIS_URL` | Internal Redis URL from your Render Key Value store |
| `SERVER_URL` | `https://<your-service-name>.onrender.com` (your web service URL) |
| `FRONTEND_URL` | Same as `SERVER_URL` (app is served from the same origin) |
| `APP_SECRET` | Generate: `openssl rand -base64 32` (keep secret) |
| `NODE_ENV` | `production` |
| `REACT_APP_SERVER_BASE_URL` | Same as `SERVER_URL` (used at **build** time for the frontend; set before first deploy or redeploy after changing) |

Optional (match your `docker-compose.mycrm.yml` if you use them):

- `STORAGE_TYPE` = `local` (default; consider a disk for persistence)
- `EMAIL_DRIVER`, `EMAIL_SMTP_*` if you use SMTP
- Other env vars from your compose file as needed

**Build-time URL:** Render passes env vars as Docker build args. Set `REACT_APP_SERVER_BASE_URL` to your final `SERVER_URL` (e.g. `https://twenty-crm.onrender.com`) so the frontend is built with the correct API URL. If you don’t know the URL yet, do a first deploy, then set it and redeploy.

---

## 4. Instance type and disk (optional)

- **Instance type:** At least **Starter** (512 MB); **Standard** (2 GB) is better for production.
- **Persistent disk:** For local file storage (e.g. uploads), add a **Disk** and set:
  - **Mount Path:** `/app/packages/twenty-server/.local-storage`
  - So the app’s local storage path matches the Dockerfile and your compose setup.

---

## 5. Health check (optional)

If Render asks for a health check path, use:

- **Path:** `/healthz`
  (Your server exposes this for the Docker healthcheck.)

---

## 6. Deploy

Save the Web Service. Render will:

1. Build the image from `packages/twenty-docker/twenty/Dockerfile` with context at repo root.
2. Start the container; the entrypoint runs DB migrations on first run.
3. Serve the app at `https://<your-service-name>.onrender.com`.

---

## 7. Background worker (optional)

To run the **worker** (same codebase, different command):

1. **New → Background Worker**.
2. Same repo, branch, and **Dockerfile Path**: `packages/twenty-docker/twenty/Dockerfile`.
3. **Docker Command:** `yarn worker:prod`.
4. Use the **same env vars** as the Web Service (especially `PG_DATABASE_URL`, `REDIS_URL`, `APP_SECRET`).
5. Same region as the web service and databases.

---

## 8. Using a Blueprint (`render.yaml`)

A `render.yaml` in the repo root defines Web Service + PostgreSQL + Redis in one go:

1. Commit and push `render.yaml`.
2. In Render: **New → Blueprint**; connect the repo and branch (e.g. `sfs-crm`).
3. Render creates the **PostgreSQL** and **Key Value (Redis)** instances and the **Web Service**.
4. After the first sync, in the **Web Service** environment set:
   - **SERVER_URL** / **FRONTEND_URL** / **REACT_APP_SERVER_BASE_URL** → `https://<your-web-service-name>.onrender.com`
   - **REDIS_URL** → copy the **Internal Redis URL** from the **twenty-redis** service (Dashboard → twenty-redis → Info).
5. Optionally add a **Disk** to the web service for local storage (mount path: `/app/packages/twenty-server/.local-storage`).

---

## Quick checklist

- [ ] **Dockerfile Path** = `packages/twenty-docker/twenty/Dockerfile`
- [ ] **Root Directory** = `/`
- [ ] PostgreSQL and Redis created in the **same region**
- [ ] `PG_DATABASE_URL` and `REDIS_URL` set from those services
- [ ] `SERVER_URL` / `FRONTEND_URL` / `REACT_APP_SERVER_BASE_URL` set to your Render URL
- [ ] `APP_SECRET` set to a strong random value
- [ ] (Optional) Disk mounted at `/app/packages/twenty-server/.local-storage`
- [ ] (Optional) Background Worker with `yarn worker:prod` and same env
