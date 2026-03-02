#!/usr/bin/env bash
# Dump database from the server (Docker) Postgres container.
# Requires: docker compose -f docker-compose.mycrm.yml up (db service running).
#
# Usage: ./scripts/db-dump-server.sh [output_file]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_FILE="$ROOT_DIR/docker-compose.mycrm.yml"
OUTPUT="${1:-$ROOT_DIR/twenty-server-dump-$(date +%Y%m%d-%H%M%S).sql}"

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "Compose file not found: $COMPOSE_FILE"
  exit 1
fi

echo "Dumping server DB (docker db service) to $OUTPUT"
docker compose -f "$COMPOSE_FILE" exec -T db \
  pg_dump -U mycrm -d mycrm --no-owner --no-acl \
  > "$OUTPUT"

echo "Done: $OUTPUT"
