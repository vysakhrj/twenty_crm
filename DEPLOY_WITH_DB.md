# Deploy to server (with current database objects)

Steps to get the full app running on a server **with your current database** (custom objects, data, and schema).

---

## Prerequisites on server

- **Docker** and **Docker Compose** (v2+)
- **2GB+ RAM**
- Port **3000** free (or reverse proxy on 80/443)

```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y docker.io docker-compose-plugin
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker $USER   # then log out and back in
```

---

## 1. Repo on the server

Project is at **`~/twenty_crm`** (i.e. `/root/twenty_crm` when logged in as root). All commands below run from that directory.

```bash
cd ~/twenty_crm
```

---

## 2. Export your current database (on your local machine)

From your **local** machine (where the app and DB are already set up):

```bash
# If using default local DB URL (e.g. postgres://postgres:postgres@localhost:5432/default)
pg_dump "$PG_DATABASE_URL" --no-owner --no-privileges -F c -f mycrm_backup.dump

# Or with explicit URL
pg_dump "postgres://USER:PASSWORD@HOST:5432/DATABASE" --no-owner --no-privileges -F c -f mycrm_backup.dump
```

Copy the dump to the server (into the project directory):

```bash
scp mycrm_backup.dump root@YOUR_SERVER_IP:~/twenty_crm/
```



---

## 3. Create production `.env` on the server

In the **project root** `~/twenty_crm` (same directory as `docker-compose.mycrm.yml`):

```bash
cd ~/twenty_crm
cp packages/twenty-docker/.env.example .env
```

Edit `.env` and set at least:

```bash
# URLs users will use (use https if you have a domain)
SERVER_URL=https://your-domain.com
FRONTEND_URL=https://your-domain.com

# Generate with: openssl rand -base64 32
APP_SECRET=your_long_random_secret_here

# Must match the db service (user/pass in compose)
PG_DATABASE_PASSWORD=your_strong_db_password
```

Compose builds `PG_DATABASE_URL` from this (default: `postgres://mycrm:your_strong_db_password@db:5432/mycrm`). Do **not** use special characters in the password (e.g. `@`, `#`, `:`).

Optional: set `EMAIL_DRIVER`, `STORAGE_*`, etc. as needed.

---

## 4. Start the stack and restore the database

**4.1 Start only the database and Redis** (so we can restore before the app runs):

```bash
cd ~/twenty_crm
docker compose -f docker-compose.mycrm.yml up -d db redis
```

Wait until the DB is healthy:

```bash
docker compose -f docker-compose.mycrm.yml ps
# db and redis should be "healthy"
```

**4.2 Restore your dump into the empty DB**

```bash
cd ~/twenty_crm

# Create the database if not already there (compose usually creates it)
docker-compose -f docker-compose.mycrm.yml exec -T db psql -U mycrm -d postgres -c "CREATE DATABASE mycrm;" 2>/dev/null || true

# Restore (dump must be in ~/twenty_crm/, e.g. after scp)
docker-compose -f docker-compose.mycrm.yml exec -T db pg_restore -U mycrm -d mycrm --no-owner --no-privileges --clean --if-exists < ~/twenty_crm/mycrm_backup.dump
```

If you used a **plain SQL** dump (e.g. `pg_dump ... -f backup.sql`):

```bash
docker-compose -f docker-compose.mycrm.yml exec -T db psql -U mycrm -d mycrm < ~/twenty_crm/mycrm_backup.sql
```

**4.3 Start the app and worker**

```bash
cd ~/twenty_crm
docker-compose -f docker-compose.mycrm.yml up -d
```

The server entrypoint will see that the DB already has the `core` schema and will **skip** running setup/migrations from scratch; it will still run `yarn command:prod upgrade` for version upgrades.

Check logs:

```bash
docker-compose -f docker-compose.mycrm.yml logs -f server
```

When the server is healthy, open `SERVER_URL` in a browser.

---

## 5. (Alternative) Fresh DB first, then restore

If you prefer to let the app create the DB once, then replace it with your backup:

```bash
cd ~/twenty_crm
docker-compose -f docker-compose.mycrm.yml up -d
# Wait until server is healthy (migrations ran, app started)
docker-compose -f docker-compose.mycrm.yml stop server worker

# Restore over the existing DB
docker-compose -f docker-compose.mycrm.yml exec -T db pg_restore -U mycrm -d mycrm --no-owner --no-privileges --clean --if-exists < ~/twenty_crm/mycrm_backup.dump

# Start again
docker-compose -f docker-compose.mycrm.yml start server worker
```

---

## 6. Firewall and HTTPS

- Open port 3000: `sudo ufw allow 3000 && sudo ufw enable`
- Or put Nginx/Caddy in front and set `SERVER_URL` / `FRONTEND_URL` to `https://your-domain.com`

---

## Summary

| Step | Where | Action |
|------|--------|--------|
| 1 | Server | Repo at `~/twenty_crm`, install Docker + Compose |
| 2 | Local | `pg_dump ... -F c -f mycrm_backup.dump`, then `scp ... root@SERVER:~/twenty_crm/` |
| 3 | Server | In `~/twenty_crm`, create `.env` with `SERVER_URL`, `FRONTEND_URL`, `APP_SECRET`, `PG_DATABASE_PASSWORD` |
| 4 | Server | `cd ~/twenty_crm`, `docker compose -f docker-compose.mycrm.yml up -d db redis` → restore dump → `up -d` |
| 5 | Server | Open firewall / reverse proxy, use `SERVER_URL` in browser |

Your custom objects and data live in the restored database, so the server will have the same structure and content as your current local DB.
