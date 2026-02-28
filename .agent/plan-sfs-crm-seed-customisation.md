# Plan: Customise dev seed for workspace "sfs-crm"

## Goal

After creating data in the app, customise the dev seed so that a workspace named **sfs-crm** is seeded and its data models (custom objects, fields, and optionally record data) match what you already created.

---

## How the current seed works

- **Command:** `npx nx run twenty-server:command workspace:seed:dev`
- **Workspaces today:** Two fixed workspaces (Apple, YCombinator) identified by UUID in `seeder-workspaces.constant.ts`.
- **Flow:** For each workspace ID the seed:
  1. **Core schema** – Creates workspace row, users, user-workspaces, applications, feature flags, billing, etc.
  2. **Metadata** – Creates custom objects and custom fields per workspace config in `dev-seeder-metadata.service.ts` (`workspaceConfigs`).
  3. **Data** – Inserts record seeds in batches; tables that don’t exist for that workspace are skipped (see `dev-seeder-data.service.ts` ~line 368).

So “data models” = **metadata** (custom objects + fields). Record **data** is optional and defined in constants; the seeder only inserts into tables that exist for that workspace.

---

## Option A: Add sfs-crm as a third seed workspace (recommended)

Use the existing seed pipeline and add sfs-crm as a first-class seed workspace. You can start minimal (standard objects only) and later add custom objects/fields/records to match what you built in the UI.

### Step 1 – Define sfs-crm in workspace constants

**File:** `packages/twenty-server/src/engine/workspace-manager/dev-seeder/core/constants/seeder-workspaces.constant.ts`

- Add a new UUID constant, e.g. `SEED_SFS_CRM_WORKSPACE_ID`.
- Add an entry in `SEEDER_CREATE_WORKSPACE_INPUT` with:
  - `displayName: 'sfs-crm'` (or your preferred label)
  - `subdomain: 'sfs-crm'`
  - Same shape as Apple/YC (id, inviteHash, logo, activationStatus, etc.).
- Extend type `SeededWorkspacesIds` to include the new ID.

### Step 2 – Include sfs-crm in the seed command

**File:** `packages/twenty-server/src/database/commands/data-seed-dev-workspace.command.ts`

- Add `SEED_SFS_CRM_WORKSPACE_ID` to the `workspaceIds` array so `workspace:seed:dev` runs for sfs-crm as well.

### Step 3 – Core schema and user/workspace wiring

These utilities branch on `workspaceId`. Add a branch for `SEED_SFS_CRM_WORKSPACE_ID` (or a shared “default” path) in:

- `seed-core-schema.util.ts` – Uses `SEEDER_CREATE_WORKSPACE_INPUT`; no change if sfs-crm is in that map.
- `seed-user-workspaces.util.ts` – Assign which seed users belong to sfs-crm (reuse existing user IDs or define new ones).
- `seed-agents.util.ts` – Optional: assign agent/thread for sfs-crm.
- `workspace-member-data-seeds.constant.ts` – `getWorkspaceMemberDataSeeds(workspaceId)`; return members for sfs-crm.
- `dev-seeder-permissions.service.ts` – Set admin/member permissions for sfs-crm (e.g. who is admin).

### Step 4 – Metadata: “data models as per data already created”

**File:** `packages/twenty-server/src/engine/workspace-manager/dev-seeder/metadata/services/dev-seeder-metadata.service.ts`

- Add `[SEED_SFS_CRM_WORKSPACE_ID]: { ... }` to `workspaceConfigs`.

**Two sub-options:**

- **4a) Minimal (standard objects only)**  
  Use an empty config so only Twenty standard objects exist:
  - `objects: []`
  - `fields: []`
  - No `morphRelations`, `junctionFields`, or `junctionConfigs`.  
  Then the existing data seeder will only insert into standard tables (company, person, etc.); custom tables are skipped automatically.

- **4b) Match your existing data models**  
  Document the custom objects and fields you created in the UI (names, types, relations). For each:
  - Add **object seeds** (see e.g. `rocket-custom-object-seed.constant.ts`, `pet-custom-object-seed.constant.ts`) under `dev-seeder/metadata/custom-objects/constants/`.
  - Add **field seeds** (see e.g. `company-custom-field-seeds.constant.ts`) under `dev-seeder/metadata/custom-fields/constants/`.
  - Add **relation seeds** if you have relations (morph, junction) – mirror the patterns used for Apple/YC in `dev-seeder-metadata.service.ts`.  
  Reference: `ObjectMetadataSeed` in `dev-seeder/metadata/types/object-metadata-seed.type.ts` and existing custom object/field constants.

### Step 5 – Optional: custom record data for sfs-crm

If you want seed **records** that match data you already created:

- Add workspace-specific record seeds (e.g. in `dev-seeder/data/constants/`) or extend helpers like `getWorkspaceMemberDataSeeds` to return sfs-crm-specific rows.
- Ensure `getRecordSeedsBatches` in `dev-seeder-data.service.ts` includes the tables you need. The seeder already skips tables that don’t exist for the workspace, so you only need to add seeds for objects you defined in Step 4b.

### Step 6 – Page layout seeds (optional)

If you care about default dashboards/navigation for sfs-crm:

- `get-page-layout-data-seeds.util.ts` / `get-page-layout-tab-data-seeds.util.ts` / `get-page-layout-widget-data-seeds.util.ts` and `get-page-layout-widget-data-seeds-v2.util.ts` may need to handle sfs-crm (e.g. by workspaceId or a default) so widgets don’t reference missing custom objects.

---

## Option B: Export existing workspace → seed (advanced)

If the goal is “capture whatever I already created in the DB and turn it into seed,” that’s not supported today. You would need to:

1. **Export workspace metadata** – Query `metadata` (and related) tables for the sfs-crm workspace and dump object/field definitions into the same shape as the existing seed constants (object seeds, field seeds, relations).
2. **Export record data** – For each object, export rows from the workspace schema into record-seed constants (or JSON that the seeder can load), respecting foreign keys and order of insertion.
3. **Wire into the seed** – Add sfs-crm as in Option A and point its metadata config and record batches at the exported definitions/data.

This is a larger one-off or tooling task (scripts or admin endpoints); it’s not required for Option A.

---

## Recommended path

1. **Short term:** Implement **Option A** with **Step 4a** (minimal metadata). That gives you a reproducible sfs-crm workspace with standard objects and standard seed data; `workspace:seed:dev` will create “sfs-crm” and seed it.
2. **Then:** As you solidify your data model in the UI, document it and add **Option A Step 4b** (custom object/field seeds) so the seed creates the same structure. Add **Step 5** only if you need specific record data in the seed.
3. **Later:** If you often need to “snapshot current DB → seed,” consider **Option B** as a separate export/sync tool.

---

## Files to touch (Option A, minimal sfs-crm)

| Purpose | File |
|--------|------|
| Workspace ID and display/subdomain | `dev-seeder/core/constants/seeder-workspaces.constant.ts` |
| Run seed for sfs-crm | `database/commands/data-seed-dev-workspace.command.ts` |
| User–workspace membership | `dev-seeder/core/utils/seed-user-workspaces.util.ts` |
| Workspace members | `dev-seeder/data/constants/workspace-member-data-seeds.constant.ts` |
| Permissions (admin/member) | `dev-seeder/core/services/dev-seeder-permissions.service.ts` |
| Metadata (custom objects/fields) | `dev-seeder/metadata/services/dev-seeder-metadata.service.ts` |
| Agents (optional) | `dev-seeder/core/utils/seed-agents.util.ts` |

No change to the data batch list is required for minimal sfs-crm: the data seeder already skips tables that don’t exist for the workspace.
