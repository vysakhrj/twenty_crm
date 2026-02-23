# MyCRM White-Label Setup Guide

This guide documents the white-labeling changes made to transform Twenty CRM into a custom branded lead management CRM.

## What Has Been Changed

### 1. Package Identity
- **File**: `package.json` (root)
- **Change**: Renamed from "twenty" to "mycrm"

### 2. Branding Assets

#### HTML & Meta Tags
- **File**: `packages/twenty-front/index.html`
- **Changes**:
  - Title: "Twenty" → "MyCRM"
  - Description: Updated to "Lead Management CRM for Marketing Teams"
  - Meta theme-color: #000000 → #10b981 (green)
  - OG/Twitter tags: Updated to MyCRM branding
  - Removed external Twenty logo references

#### PWA Manifest
- **File**: `packages/twenty-front/public/manifest.json`
- **Changes**:
  - name: "MyCRM - Lead Management"
  - short_name: "MyCRM"
  - theme_color: #10b981 (green)

#### Page Titles
- **File**: `packages/twenty-front/src/utils/title-utils.ts`
- **Change**: Default title "Twenty" → "MyCRM"

#### Default Logo
- **File**: `packages/twenty-front/src/modules/ui/navigation/navigation-drawer/constants/DefaultWorkspaceLogo.ts`
- **Change**: Points to local icon instead of external Twenty logo

### 3. Theme Colors

#### Light Mode
- **File**: `packages/twenty-ui/src/theme/constants/AccentLight.ts`
- **Change**: Indigo/blue palette → Green palette (using Radix UI greenP3)

#### Dark Mode
- **File**: `packages/twenty-ui/src/theme/constants/AccentDark.ts`
- **Change**: Indigo/blue palette → Green palette (using Radix UI greenDarkP3)

### 4. Navigation Customization

- **File**: `packages/twenty-front/src/modules/object-metadata/components/NavigationDrawerSectionForObjectMetadataItems.tsx`
- **Changes**:
  - Reordered primary objects: Person, Company, Note (removed Opportunity, Task from top)
  - Added `HIDDEN_OBJECTS` array to hide unwanted objects from navigation
  - Currently hidden: Opportunity, Task

### 5. Build Configuration

- **File**: `.env.production` - Production environment template
- **File**: `docker-compose.mycrm.yml` - Custom Docker deployment configuration

## Files to Customize Further

### Replace Logo Assets
Replace these files with your custom logo/icons:
```
packages/twenty-front/public/images/icons/
├── android/
│   ├── android-launchericon-48-48.png (favicon)
│   ├── android-launchericon-72-72.png
│   ├── android-launchericon-96-96.png
│   ├── android-launchericon-144-144.png
│   ├── android-launchericon-192-192.png (main logo)
│   └── android-launchericon-512-512.png
├── ios/
│   └── [various sizes].png
└── windows11/
    └── [various sizes].png
```

### Brand Colors
To change the accent color from green to your brand color:

1. Edit `packages/twenty-ui/src/theme/constants/AccentLight.ts`
2. Edit `packages/twenty-ui/src/theme/constants/AccentDark.ts`

Available Radix UI palettes: `red`, `orange`, `amber`, `yellow`, `lime`, `green`, `emerald`, `teal`, `cyan`, `sky`, `blue`, `indigo`, `violet`, `purple`, `fuchsia`, `pink`, `rose`

### App Name
Search and replace "MyCRM" with your brand name in:
- `packages/twenty-front/index.html`
- `packages/twenty-front/public/manifest.json`
- `packages/twenty-front/src/utils/title-utils.ts`
- `.env.production`
- `docker-compose.mycrm.yml`

### Navigation Objects
Edit `packages/twenty-front/src/modules/object-metadata/components/NavigationDrawerSectionForObjectMetadataItems.tsx`:

```typescript
// Objects shown at top of navigation
const ORDERED_FIRST_STANDARD_OBJECTS: string[] = [
  CoreObjectNameSingular.Person,
  CoreObjectNameSingular.Company,
  CoreObjectNameSingular.Note,
];

// Objects hidden from navigation
const HIDDEN_OBJECTS: string[] = [
  CoreObjectNameSingular.Opportunity,
  CoreObjectNameSingular.Task,
];
```

## Deployment

### Development
```bash
yarn start
```

### Production with Docker

1. Copy and customize the environment file:
```bash
cp .env.production .env
# Edit .env with your settings
```

2. Build and start:
```bash
docker-compose -f docker-compose.mycrm.yml build
docker-compose -f docker-compose.mycrm.yml up -d
```

3. Initialize the database (first time only):
```bash
docker-compose -f docker-compose.mycrm.yml exec server yarn database:init:prod
```

4. Access the application:
- Frontend: http://localhost:3001 (or your configured FRONTEND_URL)
- API: http://localhost:3000 (or your configured SERVER_URL)

### Custom Objects

To add your custom Lead/Ticket objects:
1. Log in as admin
2. Go to Settings → Data Model → + New Object
3. Create your custom fields and relationships

See `CUSTOM_CRM_SETUP.md` for detailed instructions on creating a Ticket/Lead management system.

## Maintenance

### Updating from Upstream Twenty

Since this is a fork:
1. Add upstream remote: `git remote add upstream https://github.com/twentyhq/twenty.git`
2. Fetch updates: `git fetch upstream`
3. Merge selectively: `git merge upstream/main --no-commit`
4. Resolve conflicts in branded files
5. Test thoroughly before committing

### Key Files to Preserve During Merges
- `package.json` (root) - name, description
- `packages/twenty-front/index.html` - branding
- `packages/twenty-front/public/manifest.json` - app name
- `packages/twenty-ui/src/theme/constants/Accent*.ts` - colors
- `packages/twenty-front/src/modules/object-metadata/components/NavigationDrawerSectionForObjectMetadataItems.tsx` - navigation
- `.env.production` - config
- `docker-compose.mycrm.yml` - deployment
