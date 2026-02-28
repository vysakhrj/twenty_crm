/**
 * Exports the current database schema and metadata for a workspace as a seed.
 * Use this to capture your workspace structure (objects, fields, dynamic schema)
 * so you can initialize it on another server.
 *
 * Usage:
 *   npx ts-node scripts/export-workspace-seed.ts --name sfs-seed [--workspace-id <uuid> | --workspace-subdomain <subdomain>]
 *
 * If no workspace is specified, exports the first workspace found.
 */

import { config } from 'dotenv';
import { execFileSync } from 'child_process';
import * as fs from 'fs';
import * as path from 'path';

import { rawDataSource } from 'src/database/typeorm/raw/raw.datasource';
import { getWorkspaceSchemaName } from 'src/engine/workspace-datasource/utils/get-workspace-schema-name.util';

config({ path: process.env.NODE_ENV === 'test' ? '.env.test' : '.env', override: true });

const CORE_METADATA_TABLES = [
  'workspace',
  'dataSource',
  'objectMetadata',
  'fieldMetadata',
  'indexMetadata',
  'indexFieldMetadata',
  'objectPermission',
  'fieldPermission',
  'view',
  'viewField',
  'viewFilter',
  'viewSort',
  'viewGroup',
  'viewFilterGroup',
  'pageLayout',
  'pageLayoutTab',
  'pageLayoutWidget',
  'role',
  'roleTarget',
  'searchFieldMetadata',
  'navigationMenuItem',
  'commandMenuItem',
] as const;

type ExportSeedOptions = {
  seedName: string;
  workspaceId?: string;
  workspaceSubdomain?: string;
};

async function findWorkspaceId(
  subdomain?: string,
  workspaceId?: string,
): Promise<{ id: string; displayName: string; subdomain: string } | null> {
  if (workspaceId) {
    const rows = await rawDataSource.query<{ id: string; displayName: string; subdomain: string }[]>(
      `SELECT id, "displayName", subdomain FROM core.workspace WHERE id = $1`,
      [workspaceId],
    );
    return rows[0] ?? null;
  }

  if (subdomain) {
    const rows = await rawDataSource.query<{ id: string; displayName: string; subdomain: string }[]>(
      `SELECT id, "displayName", subdomain FROM core.workspace WHERE subdomain = $1`,
      [subdomain],
    );
    return rows[0] ?? null;
  }

  const rows = await rawDataSource.query<{ id: string; displayName: string; subdomain: string }[]>(
    `SELECT id, "displayName", subdomain FROM core.workspace ORDER BY "createdAt" ASC LIMIT 1`,
  );
  return rows[0] ?? null;
}

async function exportMetadataForWorkspace(workspaceId: string): Promise<Record<string, unknown[]>> {
  const result: Record<string, unknown[]> = {};

  for (const table of CORE_METADATA_TABLES) {
    try {
      if (table === 'workspace') {
        const rows = await rawDataSource.query(
          `SELECT * FROM core.workspace WHERE id = $1`,
          [workspaceId],
        );
        result[table] = rows as unknown[];
        continue;
      }

      const hasWorkspaceId = await rawDataSource.query<{ exists: boolean }[]>(
        `SELECT EXISTS (
          SELECT 1 FROM information_schema.columns
          WHERE table_schema = 'core' AND table_name = $1 AND column_name = 'workspaceId'
        ) as exists`,
        [table],
      );

      if (!hasWorkspaceId[0]?.exists) {
        continue;
      }

      const rows = await rawDataSource.query(
        `SELECT * FROM core."${table}" WHERE "workspaceId" = $1`,
        [workspaceId],
      );
      result[table] = rows as unknown[];
    } catch (error) {
      const tableExists = await rawDataSource.query<{ exists: boolean }[]>(
        `SELECT EXISTS (
          SELECT 1 FROM information_schema.tables
          WHERE table_schema = 'core' AND table_name = $1
        ) as exists`,
        [table],
      );
      if (tableExists[0]?.exists) {
        console.warn(`Warning: Could not export core.${table}:`, (error as Error).message);
      }
    }
  }

  return result;
}

async function exportWorkspaceSchemaDdl(workspaceId: string): Promise<string | null> {
  const schemaName = getWorkspaceSchemaName(workspaceId);

  const schemaExists = await rawDataSource.query<{ exists: boolean }[]>(
    `SELECT EXISTS (
      SELECT 1 FROM information_schema.schemata WHERE schema_name = $1
    ) as exists`,
    [schemaName],
  );

  if (!schemaExists[0]?.exists) {
    return null;
  }

  const databaseUrl = process.env.PG_DATABASE_URL;
  if (!databaseUrl) {
    console.warn('PG_DATABASE_URL not set, skipping schema DDL export');
    return null;
  }

  try {
    const pgDumpOutput = execFileSync(
      'pg_dump',
      [
        '--dbname=' + databaseUrl,
        '--schema-only',
        '--schema=' + schemaName,
        '--no-owner',
        '--no-privileges',
      ],
      { encoding: 'utf-8', maxBuffer: 10 * 1024 * 1024 },
    );
    return pgDumpOutput;
  } catch {
    const tables = await rawDataSource.query<{ tablename: string }[]>(
      `SELECT tablename FROM pg_tables WHERE schemaname = $1 ORDER BY tablename`,
      [schemaName],
    );

    const ddlParts: string[] = [
      `-- Workspace schema: ${schemaName} (fallback from information_schema)`,
      `CREATE SCHEMA IF NOT EXISTS "${schemaName}";`,
      '',
    ];

    for (const { tablename } of tables) {
      const columnDefs = await rawDataSource.query<
        { column_name: string; data_type: string; is_nullable: string }[]
      >(
        `SELECT column_name, data_type, is_nullable
         FROM information_schema.columns
         WHERE table_schema = $1 AND table_name = $2
         ORDER BY ordinal_position`,
        [schemaName, tablename],
      );

      const columns = columnDefs
        .map(
          (c) =>
            `  "${c.column_name}" ${c.data_type} ${c.is_nullable === 'NO' ? 'NOT NULL' : ''}`,
        )
        .join(',\n');
      ddlParts.push(
        `CREATE TABLE IF NOT EXISTS "${schemaName}"."${tablename}" (\n${columns}\n);`,
      );
      ddlParts.push('');
    }

    return ddlParts.join('\n');
  }
}

async function run(options: ExportSeedOptions): Promise<void> {
  await rawDataSource.initialize();

  try {
    const workspace = await findWorkspaceId(options.workspaceSubdomain, options.workspaceId);
    if (!workspace) {
      throw new Error(
        'No workspace found. Specify --workspace-id or --workspace-subdomain, or ensure the database has at least one workspace.',
      );
    }

    console.log(`Exporting workspace: ${workspace.displayName} (${workspace.subdomain})`);
    console.log(`Workspace ID: ${workspace.id}`);

    const metadata = await exportMetadataForWorkspace(workspace.id);
    const schemaDdl = await exportWorkspaceSchemaDdl(workspace.id);

    const seedDir = path.join(
      __dirname,
      '../src/engine/workspace-manager/dev-seeder/seeds',
      options.seedName,
    );
    fs.mkdirSync(seedDir, { recursive: true });

    const seedData = {
      exportedAt: new Date().toISOString(),
      workspace: {
        id: workspace.id,
        displayName: workspace.displayName,
        subdomain: workspace.subdomain,
      },
      metadata,
      schemaName: getWorkspaceSchemaName(workspace.id),
    };

    const metadataPath = path.join(seedDir, 'metadata.json');
    fs.writeFileSync(metadataPath, JSON.stringify(seedData, null, 2), 'utf-8');
    console.log(`Saved metadata to ${metadataPath}`);

    if (schemaDdl) {
      const schemaPath = path.join(seedDir, 'schema.sql');
      fs.writeFileSync(schemaPath, schemaDdl, 'utf-8');
      console.log(`Saved schema DDL to ${schemaPath}`);
    } else {
      console.log('No workspace schema found (workspace may not have been initialized yet)');
    }

    const readmePath = path.join(seedDir, 'README.md');
    const readme = `# Seed: ${options.seedName}

Exported from workspace **${workspace.displayName}** (${workspace.subdomain}) on ${seedData.exportedAt}.

## Contents

- \`metadata.json\` – Core schema metadata (objects, fields, views, etc.) for this workspace
- \`schema.sql\` – Workspace schema DDL (table definitions)

## Restoring this seed

To initialize a server with this structure:

1. Ensure the workspace exists in \`core.workspace\` (create it or use workspace:seed:dev with sfs-crm).
2. Insert the metadata from \`metadata.json\` into the core schema tables (respecting foreign key order).
3. Run the schema SQL to create workspace tables, or let the workspace migration runner recreate them from metadata.

For development, you can add this workspace to the dev seeder (see \`.agent/plan-sfs-crm-seed-customisation.md\`).
`;
    fs.writeFileSync(readmePath, readme, 'utf-8');
    console.log(`Saved README to ${readmePath}`);
  } finally {
    await rawDataSource.destroy();
  }
}

function parseArgs(): ExportSeedOptions {
  const args = process.argv.slice(2);
  let seedName = 'sfs-seed';
  let workspaceId: string | undefined;
  let workspaceSubdomain: string | undefined;

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--name' && args[i + 1]) {
      seedName = args[++i];
    } else if (args[i] === '--workspace-id' && args[i + 1]) {
      workspaceId = args[++i];
    } else if (args[i] === '--workspace-subdomain' && args[i + 1]) {
      workspaceSubdomain = args[++i];
    }
  }

  return { seedName, workspaceId, workspaceSubdomain };
}

const options = parseArgs();
run(options).catch((error) => {
  console.error('Export failed:', error);
  process.exit(1);
});
