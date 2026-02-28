# Deploying MyCRM to a Server (Docker, all bundled)

This guide describes how to deploy the full stack (app + PostgreSQL + Redis) to a server using your existing `docker-compose.mycrm.yml`.

## Server requirements

- **OS**: Any Linux with Docker (e.g. Ubuntu 22.04, Debian 12)
- **RAM**: At least 2GB
- **Docker**: Docker Engine and Docker Compose (v2+)
- **Port**: 3000 free (or map to 80/443 via reverse proxy)

## 1. Prepare the server

On the server, install Docker and Docker Compose if needed:

```bash
# Example on Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y docker.io docker-compose-plugin
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker $USER   # then log out and back in
```

## 2. Copy the project to the server

Either clone from your git repo or copy the project (e.g. with `rsync` or `scp`). The Docker build needs the **monorepo root** (where `package.json`, `packages/`, and `docker-compose.mycrm.yml` live).

```bash
# From your machine (replace with your repo and server)
rsync -avz --exclude node_modules --exclude .git ./twenty_crm user@your-server:/opt/mycrm
# or
git clone <your-repo-url> /opt/mycrm && cd /opt/mycrm
```

## 3. Create production `.env`

On the server, in the same directory as `docker-compose.mycrm.yml`, create a `.env` file. You can copy from `packages/twenty-server/.env` and adjust, or create from scratch.

**Required for production:**

```bash
# Base URL where users reach the app (use https if you have SSL)
SERVER_URL=https://your-domain.com
FRONTEND_URL=https://your-domain.com

# Strong random secret (e.g. openssl rand -base64 32)
APP_SECRET=your_long_random_secret_here

# Database password (no special characters recommended)
PG_DATABASE_PASSWORD=your_strong_db_password
# Optional: full URL if you need to override (defaults match compose)
# PG_DATABASE_URL=postgres://mycrm:your_strong_db_password@db:5432/mycrm
# REDIS_URL=redis://redis:6379
```

Optional: set `EMAIL_DRIVER`, `EMAIL_SMTP_*`, `STORAGE_*`, etc. as in your local setup.

## 4. Build and start the stack

From the project root on the server:

```bash
cd /opt/mycrm

# Build images (first time or after code changes)
docker compose -f docker-compose.mycrm.yml build

# Start all services (server, worker, db, redis)
docker compose -f docker-compose.mycrm.yml up -d

# Check logs until server is healthy
docker compose -f docker-compose.mycrm.yml logs -f server
```

On first start, the **server** entrypoint runs database setup and migrations automatically (no need to run `database:init:prod` manually). When you see the server healthy, open `SERVER_URL` in a browser.

## 5. Expose the app (firewall + optional reverse proxy)

- **Firewall**: Open port 3000 (or the port you map in the compose file).

  ```bash
  sudo ufw allow 3000
  sudo ufw enable
  ```

- **Direct access**: Users can use `http://your-server-ip:3000` if `SERVER_URL` and `FRONTEND_URL` are set to that (e.g. `http://your-server-ip:3000`).

- **Recommended – reverse proxy with HTTPS**: Put Nginx or Caddy in front and terminate SSL so `SERVER_URL`/`FRONTEND_URL` use `https://your-domain.com` (no port). Example with Caddy:

  ```bash
  # Caddyfile (e.g. /etc/caddy/Caddyfile)
  your-domain.com {
      reverse_proxy localhost:3000
  }
  ```

  Then point `SERVER_URL` and `FRONTEND_URL` to `https://your-domain.com`.

## 6. Updates and maintenance

- **Update app**: Pull/copy new code, then rebuild and recreate:

  ```bash
  docker compose -f docker-compose.mycrm.yml build server worker
  docker compose -f docker-compose.mycrm.yml up -d
  ```

- **Backups**: Back up the Postgres data (and any local storage volume). Example one-off backup:

  ```bash
  docker compose -f docker-compose.mycrm.yml exec -T db pg_dump -U mycrm mycrm > backup_$(date +%Y%m%d_%H%M).sql
  ```

  Schedule this (e.g. cron) and store backups off-server.

- **Logs**:
  `docker compose -f docker-compose.mycrm.yml logs -f server`
  `docker compose -f docker-compose.mycrm.yml logs -f worker`

## Summary

| Step | Command / action |
|------|-------------------|
| 1 | Install Docker + Compose on server |
| 2 | Copy repo to server (e.g. `/opt/mycrm`) |
| 3 | Create `.env` with `SERVER_URL`, `FRONTEND_URL`, `APP_SECRET`, `PG_DATABASE_PASSWORD` |
| 4 | `docker compose -f docker-compose.mycrm.yml build && docker compose -f docker-compose.mycrm.yml up -d` |
| 5 | Open firewall port 3000; optionally put Nginx/Caddy in front with HTTPS |
| 6 | Use backups and rebuild/up on updates |

Your `docker-compose.mycrm.yml` already bundles **server**, **worker**, **PostgreSQL 16**, and **Redis 7** with persistent volumes, so one compose file is enough for a full deployment.
