# Twenty CRM - Complete Setup Guide

This guide will walk you through setting up Twenty CRM for local development and personal use.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js**: Version ^24.5.0 (check with `node --version`)
- **Yarn**: Version >=4.0.2 (check with `yarn --version`)
- **PostgreSQL**: Version 16 or higher
- **Redis**: Latest stable version

## Step 1: Install Dependencies

First, install all project dependencies:

```bash
yarn install
```

## Step 2: Set Up PostgreSQL Database

### Option A: Using Docker (Recommended for Quick Setup)

If you have Docker installed, you can quickly start PostgreSQL and Redis.

**If you have local PostgreSQL (Homebrew, Postgres.app) on port 5432**, use port **5433** so Twenty reaches the Docker Postgres (which has the `postgres` user) instead of your local instance:

```bash
# Remove existing container if you created one on 5432
docker rm -f twenty-postgres 2>/dev/null || true

# Start PostgreSQL (use 5433 if local Postgres is on 5432)
docker run --name twenty-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=default \
  -p 5433:5432 \
  -d postgres:16

# Start Redis
docker run --name twenty-redis \
  -p 6379:6379 \
  -d redis
```

For `.env`, use: `PG_DATABASE_URL=postgres://postgres:postgres@localhost:5433/default`

**If port 5432 is free** (no local PostgreSQL), you can use 5432 instead:

```bash
docker run --name twenty-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=default \
  -p 5432:5432 \
  -d postgres:16
```

Then use: `PG_DATABASE_URL=postgres://postgres:postgres@localhost:5432/default`

### Option B: Local PostgreSQL Installation

If you have PostgreSQL installed locally, create a database:

```bash
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE default;

# Exit psql
\q
```

## Step 3: Configure Environment Variables

Create a `.env` file in the `packages/twenty-server` directory with the following variables:

```bash
cd packages/twenty-server
```

Create `.env` file:

```bash
# Database Configuration
# Use 5433 if you ran Docker Postgres on 5433 (e.g. when local Postgres is on 5432)
PG_DATABASE_URL=postgres://postgres:postgres@localhost:5432/default

# Server Configuration
SERVER_URL=http://localhost:3000
NODE_PORT=3000

# Redis Configuration
REDIS_URL=redis://localhost:6379

# Application Secret (generate a random string)
APP_SECRET=your-random-secret-key-here-change-this

# Optional: Storage Configuration (for file uploads)
# For local development, you can use local storage (default)
STORAGE_TYPE=local

# Optional: Disable migrations on startup (set to "true" if you want to run migrations manually)
DISABLE_DB_MIGRATIONS=

# Optional: Disable cron jobs registration
DISABLE_CRON_JOBS_REGISTRATION=
```

**Important**: Replace `your-random-secret-key-here-change-this` with a secure random string. You can generate one using:

```bash
# On macOS/Linux
openssl rand -base64 32

# Or use Node.js
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

## Step 4: Initialize Database

The database setup process will:
1. Create necessary schemas (`public` and `core`)
2. Install required PostgreSQL extensions (`uuid-ossp`, `unaccent`)
3. Run all migrations to create tables
4. Seed the database with initial data (optional)

### Initialize and Migrate Database

```bash
# From the project root
npx nx run twenty-server:database:init:prod
```

This command:
- Runs `setup-db.ts` to create schemas and extensions
- Runs all TypeORM migrations to create tables

### Alternative: Full Database Reset (Recommended for First Setup)

If you want to start fresh with seeded data:

```bash
# Build the server first
npx nx build twenty-server

# Reset database with seed data
npx nx run twenty-server:database:reset
```

This will:
1. Truncate existing data
2. Set up schemas and extensions
3. Run migrations
4. Seed the database with development data

## Step 5: Start the Application

### Start Both Server and Frontend

From the project root, run:

```bash
yarn start
```

This command will:
- Start the backend server on `http://localhost:3000`
- Start the frontend development server (typically on `http://localhost:3001` or `http://localhost:5173`)
- Start the worker process for background jobs

### Start Components Individually

If you prefer to start components separately:

**Terminal 1 - Backend Server:**
```bash
npx nx run twenty-server:start
```

**Terminal 2 - Frontend:**
```bash
npx nx run twenty-front:start
```

**Terminal 3 - Worker (for background jobs):**
```bash
npx nx run twenty-server:worker
```

## Step 6: Access the Application

Once everything is running:

1. **Frontend**: Open your browser and navigate to `http://localhost:3001` (or the port shown in the terminal)
2. **Backend API**: The GraphQL API will be available at `http://localhost:3000/graphql`
3. **Health Check**: Verify the server is running at `http://localhost:3000/healthz`

## Step 7: Create Your First Workspace

When you first access the application, you'll need to:
1. Sign up for an account
2. Create your first workspace
3. Start using the CRM!

## Troubleshooting

### Database Connection Issues

If you encounter database connection errors:

1. **Verify PostgreSQL is running:**
   ```bash
   # Check if PostgreSQL is running
   psql -U postgres -c "SELECT version();"
   ```

2. **Check your connection string:**
   - Format: `postgres://username:password@host:port/database`
   - Ensure credentials match your PostgreSQL setup

3. **Test connection:**
   ```bash
   # Test connection using the connection string from .env
   psql postgres://postgres:postgres@localhost:5432/default
   ```

### Redis Connection Issues

If Redis connection fails:

1. **Verify Redis is running:**
   ```bash
   redis-cli ping
   # Should return: PONG
   ```

2. **Check Redis URL format:**
   - Format: `redis://localhost:6379`
   - Or with password: `redis://:password@localhost:6379`

### Migration Issues

If migrations fail:

1. **Check if database is initialized:**
   ```bash
   npx nx run twenty-server:database:reset:no-seed
   ```

2. **Manually run migrations:**
   ```bash
   npx nx run twenty-server:database:migrate
   ```

### Error: role "postgres" does not exist

This occurs when the app connects to **local PostgreSQL** (Homebrew, Postgres.app) on port 5432. Those installs usually create a superuser with your macOS username, not `postgres`, so the `postgres` role does not exist.

**Fix: use Docker Postgres on a different port (5433)** so the app talks to the Docker instance:

1. **Recreate the Docker container on 5433:**
   ```bash
   docker rm -f twenty-postgres 2>/dev/null || true
   docker run --name twenty-postgres \
     -e POSTGRES_USER=postgres \
     -e POSTGRES_PASSWORD=postgres \
     -e POSTGRES_DB=default \
     -p 5433:5432 \
     -d postgres:16
   ```

2. **In `packages/twenty-server/.env`, set:**
   ```
   PG_DATABASE_URL=postgres://postgres:postgres@localhost:5433/default
   ```

3. Re-run migrations or `npx nx run twenty-server:database:init:prod`.

### Port Already in Use

If port 3000 is already in use:

1. **Change the port in `.env`:**
   ```
   NODE_PORT=3001
   SERVER_URL=http://localhost:3001
   ```

2. **Or kill the process using the port:**
   ```bash
   # Find process using port 3000
   lsof -ti:3000

   # Kill it
   kill -9 $(lsof -ti:3000)
   ```

## Environment Variables Reference

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PG_DATABASE_URL` | PostgreSQL connection string | `postgres://user:pass@localhost:5432/db` |
| `SERVER_URL` | Base URL of the server | `http://localhost:3000` |
| `REDIS_URL` | Redis connection string | `redis://localhost:6379` |
| `APP_SECRET` | Secret key for encryption | Random 32+ character string |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `STORAGE_TYPE` | Storage driver type (`local` or `s3`) | `local` |
| `DISABLE_DB_MIGRATIONS` | Disable auto-migrations on startup | `false` |
| `DISABLE_CRON_JOBS_REGISTRATION` | Disable cron jobs | `false` |
| `NODE_PORT` | Server port | `3000` |
| `ORM_QUERY_LOGGING` | Enable SQL query logging | `disabled` |

## Useful Commands

### Database Commands

```bash
# Reset database with seed data
npx nx run twenty-server:database:reset

# Reset database without seed data
npx nx run twenty-server:database:reset:no-seed

# Run migrations only
npx nx run twenty-server:database:migrate

# Generate a new migration
npx nx run twenty-server:database:migrate:generate --migrationName=YourMigrationName

# Revert last migration
npx nx run twenty-server:database:migrate:revert
```

### Development Commands

```bash
# Start everything (server + frontend + worker)
yarn start

# Build server
npx nx build twenty-server

# Build frontend
npx nx build twenty-front

# Run tests
npx nx test twenty-server
npx nx test twenty-front

# Type checking
npx nx typecheck twenty-server
npx nx typecheck twenty-front

# Linting
npx nx lint:diff-with-main twenty-server
npx nx lint:diff-with-main twenty-front
```

## Next Steps

Once your application is running:

1. **Explore the UI**: Navigate through the different views (Table, Kanban, etc.)
2. **Create Objects**: Set up custom objects and fields
3. **Import Data**: Import your existing data
4. **Configure Integrations**: Set up email, calendar, and other integrations
5. **Customize**: Personalize your workspace with filters, views, and permissions

## Additional Resources

- **Documentation**: https://docs.twenty.com
- **Local Setup Docs**: https://docs.twenty.com/developers/local-setup
- **Self-hosting**: https://docs.twenty.com/developers/self-hosting/docker-compose
- **Discord Community**: https://discord.gg/cx5n4Jzs57

## Notes

- The database migrations run automatically on server startup unless `DISABLE_DB_MIGRATIONS=true`
- The first time you run the application, it will create all necessary tables
- Development seed data is included when using `database:reset` (default configuration)
- All file uploads are stored locally by default (in `packages/twenty-server/.local-storage`)
