#!/usr/bin/env bash
# Dump Twenty PostgreSQL database.
# Usage: ./scripts/db-dump.sh [output_file]
# Uses PG_DATABASE_URL from packages/twenty-server/.env if set; otherwise defaults.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="$ROOT_DIR/packages/twenty-server/.env"
OUTPUT="${1:-$ROOT_DIR/twenty-dump-$(date +%Y%m%d-%H%M%S).sql}"

if [ -f "$ENV_FILE" ]; then
  # shellcheck source=/dev/null
  source "$ENV_FILE"
fi

# Parse PG_DATABASE_URL (postgres://user:pass@host:port/dbname)
if [ -n "$PG_DATABASE_URL" ]; then
  # Remove protocol
  REST="${PG_DATABASE_URL#postgres://}"
  # Extract user (before first :)
  PG_USER="${REST%%:*}"
  # Extract rest after user:
  REST="${REST#*:}"
  # Extract password (before first @)
  PG_PASS="${REST%%@*}"
  # Extract host and port/db (after @)
  REST="${REST#*@}"
  PG_HOST="${REST%%:*}"
  REST="${REST#*:}"
  PG_PORT="${REST%%/*}"
  PG_DATABASE="${REST#*/}"
  # Remove query string if present
  PG_DATABASE="${PG_DATABASE%%\?*}"
  export PGPASSWORD="$PG_PASS"
else
  PG_HOST="${PG_HOST:-localhost}"
  PG_PORT="${PG_PORT:-5432}"
  PG_USER="${PG_USER:-postgres}"
  PG_DATABASE="${PG_DATABASE:-default}"
  [ -n "$PGPASSWORD" ] || export PGPASSWORD="${PG_PASSWORD:-postgres}"
fi

echo "Dumping database: $PG_DATABASE @ $PG_HOST:$PG_PORT to $OUTPUT"
pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" \
  --no-owner --no-acl \
  -f "$OUTPUT"

echo "Done: $OUTPUT"
