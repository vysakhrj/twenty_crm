# Seed: sfs-seed

Exported from workspace **SFS-CRM** (excellent-silver-raccoon) on 2026-02-28T15:13:40.425Z.

## Contents

- `metadata.json` – Core schema metadata (objects, fields, views, etc.) for this workspace
- `schema.sql` – Workspace schema DDL (table definitions)

## Restoring this seed

To initialize a server with this structure:

1. Ensure the workspace exists in `core.workspace` (create it or use workspace:seed:dev with sfs-crm).
2. Insert the metadata from `metadata.json` into the core schema tables (respecting foreign key order).
3. Run the schema SQL to create workspace tables, or let the workspace migration runner recreate them from metadata.

For development, you can add this workspace to the dev seeder (see `.agent/plan-sfs-crm-seed-customisation.md`).
