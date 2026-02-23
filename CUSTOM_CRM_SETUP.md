# Custom Lead Management CRM - Phased Setup Guide

This guide provides exact steps to transform Twenty CRM into a lead management system for marketing companies.

## What Already Exists (No Changes Needed)

| Feature | Status | Notes |
|---------|--------|-------|
| Table/Kanban views | ✅ Works | Automatically works for any object |
| Admin role | ✅ Exists | Full permissions, can manage members |
| Member role | ✅ Exists | Can view/edit records, limited settings |
| REST API | ✅ Exists | `POST /rest/{objectNamePlural}` with API key |
| Workflow webhooks | ✅ Exists | Public endpoint for external triggers |
| Custom objects | ✅ Exists | Create via Settings → Data Model |
| Workspace dropdown | ✅ Already conditional | Only shows if user has multiple workspaces |
| Comments/Notes | ✅ Exists | Can be linked to any object |

## What Needs to Be Built

| Feature | Phase | Method |
|---------|-------|--------|
| Ticket/Lead object | Phase 1 | Settings UI (no code) |
| Origin field | Phase 1 | Settings UI (no code) |
| Webhook for ticket creation | Phase 1 | Workflow UI (no code) |
| Manager role with limited permissions | Phase 1 | Settings UI (no code) |
| Assignee filtering (see only assigned) | Phase 2 | Code change or View filters |
| White-labeling | Phase 3 | Code changes |

---

# Phase 1: Core Functionality (No Code Required)

## Prerequisites

Your system is already running with:
- Docker containers for PostgreSQL and Redis
- Seeded example data
- Default Admin and Member accounts

## Step 1.1: Access the Application

```bash
# Start the application (if not running)
yarn start
```

Open `http://localhost:3001` in your browser.

**Login credentials** (from seed data):
- Email: `tim@apple.dev` (Admin)
- Password: Check seed data or reset via database

## Step 1.2: Create the Ticket Object

1. Login as Admin
2. Go to **Settings** → **Data Model** → **+ New Object**
3. Create object with:
   - **Name**: `Ticket` (singular) / `Tickets` (plural)
   - **API Name**: `ticket`
   - **Icon**: Choose an appropriate icon (e.g., `IconTicket`)

## Step 1.3: Add Fields to Ticket Object

After creating the object, add these fields:

### Required Fields

| Field Name | Type | Options | Required |
|------------|------|---------|----------|
| `Name` | Text | (default field) | Yes |
| `Description` | Text (Long) | - | No |
| `Status` | Select | New, In Progress, Resolved, Closed | Yes |
| `Origin` | Select | Zapier, Website, Meta - Instagram, Meta - Facebook, Meta - Google Ads, Manual | Yes |
| `Origin Detail` | Text | For specific source info | No |
| `Priority` | Select | Low, Medium, High, Urgent | No |

### Relation Fields

| Field Name | Type | Related To |
|------------|------|------------|
| `Assignee` | Relation | Workspace Member |
| `Company` | Relation | Company (optional) |
| `Contact` | Relation | Person (optional) |

**To add fields:**
1. Click on the Ticket object
2. Click **+ Add Field**
3. Configure each field as specified above

## Step 1.4: Create API Key for Webhooks

1. Go to **Settings** → **APIs & Webhooks**
2. Click **+ Create API Key**
3. Name it: `External Integrations`
4. Copy and save the API key securely

**API Endpoint for creating tickets:**
```
POST http://localhost:3000/rest/tickets
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "name": "New Lead from Website",
  "description": "Customer inquiry about pricing",
  "status": "New",
  "origin": "Website",
  "originDetail": "Contact form - Pricing page"
}
```

## Step 1.5: Create Workflow for Webhook Triggers

For public webhooks (no API key required):

1. Go to **Settings** → **Workflows**
2. Click **+ Create Workflow**
3. Configure:
   - **Name**: `Create Ticket from Webhook`
   - **Trigger**: Webhook
   - **Action**: Create Record → Ticket

4. Map webhook fields to ticket fields:
   ```json
   // Expected webhook payload
   {
     "title": "{{trigger.body.title}}",
     "description": "{{trigger.body.description}}",
     "origin": "{{trigger.body.origin}}",
     "originDetail": "{{trigger.body.source}}"
   }
   ```

5. **Activate** the workflow
6. Copy the webhook URL (shown after activation)

**Webhook URL format:**
```
POST http://localhost:3000/webhooks/workflows/{workspaceId}/{workflowId}
```

## Step 1.6: Create Manager Role (Optional)

The default Member role already has good permissions. If you want a more restricted role:

1. Go to **Settings** → **Roles**
2. Click **+ Create Role**
3. Configure:
   - **Name**: `Manager`
   - **Permissions**:
     - Objects: Read/Write for Tickets
     - Settings: None
     - Tools: Basic (no import/export)

## Step 1.7: Invite Team Members

1. Go to **Settings** → **Members**
2. Click **+ Invite Member**
3. Enter email addresses
4. Assign appropriate role (Admin or Member/Manager)

---

## Phase 1 Testing

### Test 1: Manual Ticket Creation

1. Navigate to **Tickets** in the sidebar
2. Click **+ New Ticket**
3. Fill in the fields
4. Save and verify it appears in the list

### Test 2: API Ticket Creation

```bash
curl -X POST http://localhost:3000/rest/tickets \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Lead from Zapier",
    "description": "Testing API integration",
    "status": "New",
    "origin": "Zapier",
    "originDetail": "Facebook Lead Form"
  }'
```

### Test 3: Webhook Ticket Creation

```bash
curl -X POST "http://localhost:3000/webhooks/workflows/{workspaceId}/{workflowId}" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Webhook Lead",
    "description": "From website form",
    "origin": "Website",
    "source": "Homepage contact form"
  }'
```

### Test 4: Role Permissions

1. Login as Admin - verify full access
2. Login as Member - verify can see/edit tickets
3. Verify Members cannot access Settings → Members

---

## Zapier/Make.com Integration

### Using REST API (Recommended)

Configure your Zapier/Make webhook action:
- **URL**: `http://your-domain.com/rest/tickets`
- **Method**: POST
- **Headers**:
  - `Authorization`: `Bearer YOUR_API_KEY`
  - `Content-Type`: `application/json`
- **Body**:
  ```json
  {
    "name": "{{lead_name}}",
    "description": "{{lead_message}}",
    "status": "New",
    "origin": "Zapier",
    "originDetail": "{{source_name}}"
  }
  ```

### Using Workflow Webhook (No Auth)

Configure your external service to POST to:
- **URL**: `http://your-domain.com/webhooks/workflows/{workspaceId}/{workflowId}`
- **Method**: POST
- **Body**: Match your workflow's expected schema

---

# Phase 2: Advanced Filtering (Requires Code)

## Goal: Members Only See Assigned Tickets

### Option A: Use Views (No Code)

1. Create a saved View: "My Tickets"
2. Add filter: `Assignee` = `Current User`
3. Set as default view for Member role

### Option B: Code Change for Automatic Filtering

This requires modifying the query layer to filter by assignee based on role.

**File to modify:** Create a custom filter in the workspace query service.

---

# Phase 3: White-Labeling (Future)

When ready for white-labeling:

1. **Branding**: Replace logos, icons, colors
2. **App Name**: Replace "Twenty" throughout codebase
3. **Domain**: Configure custom domain
4. **Email Templates**: Customize notification emails

See the detailed white-labeling section below.

---

# Detailed Reference

## Existing Roles

### Admin Role
- **ID**: `20202020-0001-0001-0001-000000000001`
- **Permissions**: Full access to everything
- **Use for**: Super admin who manages the system

### Member Role
- **Permissions**:
  - ✅ Read/Write all object records
  - ✅ Access tools (except some settings)
  - ❌ Cannot manage workspace settings
  - ❌ Cannot manage members/roles
- **Use for**: Managers/Assignees

## API Endpoints

### REST API (Authenticated)
```
Base URL: http://localhost:3000/rest/

# Create ticket
POST /rest/tickets
Authorization: Bearer {API_KEY}

# Get all tickets
GET /rest/tickets

# Get single ticket
GET /rest/tickets/{id}

# Update ticket
PATCH /rest/tickets/{id}

# Delete ticket
DELETE /rest/tickets/{id}
```

### GraphQL API (Authenticated)
```
Endpoint: http://localhost:3000/graphql
Authorization: Bearer {API_KEY}

# Create ticket mutation
mutation {
  createTicket(data: {
    name: "New Lead"
    status: "New"
    origin: "Website"
  }) {
    id
    name
  }
}
```

### Workflow Webhook (Public)
```
POST /webhooks/workflows/{workspaceId}/{workflowId}
No authentication required
```

## Database Seed Users

Check the seed data for default users:
```bash
# View seed data
cat packages/twenty-server/src/engine/workspace-manager/dev-seeder/data/
```

Common seed users:
- `tim@apple.dev` - Admin
- Various member accounts

---

# Quick Start Checklist

## Phase 1 (Today)

- [ ] Login to application as Admin
- [ ] Create Ticket object in Data Model
- [ ] Add all required fields (Status, Origin, etc.)
- [ ] Add relation fields (Assignee, Company, Contact)
- [ ] Create API key for integrations
- [ ] Test manual ticket creation
- [ ] Test API ticket creation
- [ ] Set up workflow for webhook (optional)
- [ ] Invite team members

## Phase 2 (Later)

- [ ] Create "My Tickets" view with assignee filter
- [ ] Set as default view for Members
- [ ] Consider code changes for automatic filtering

## Phase 3 (When Selling)

- [ ] Replace all branding
- [ ] Configure production domain
- [ ] Set up proper SSL
- [ ] Configure email sending

---

## Important Notes

1. **No forking needed for Phase 1** - everything via UI
2. **Workspace toggle**: Already hidden if only one workspace exists
3. **License**: AGPL-3.0 - ensure compliance if selling
4. **Seed data**: You may want to reset database before production:
   ```bash
   npx nx run twenty-server:database:reset:no-seed
   ```

---

# REST API Reference for External Integrations

## Overview

Twenty provides a built-in REST API that works with any object (standard or custom). Once you create the Ticket object, the API endpoints are automatically available.

**Base URL**: `http://localhost:3000` (development) or your production domain

## Authentication

All REST API calls require an API key in the Authorization header.

### Get Your API Key

1. Login as Admin
2. Go to **Settings** → **APIs & Webhooks**
3. Click **+ Create API Key**
4. Name it (e.g., "Zapier Integration")
5. Copy the key immediately (shown only once)

### Header Format

```
Authorization: Bearer {YOUR_API_KEY}
Content-Type: application/json
```

---

## Ticket API Endpoints

Once you create the Ticket object, these endpoints are available:

### Create Ticket

```http
POST /rest/tickets
Authorization: Bearer {API_KEY}
Content-Type: application/json

{
  "name": "New Lead from Website",
  "description": "Customer inquiry about enterprise pricing",
  "status": "New",
  "origin": "Website",
  "originDetail": "Contact form - Pricing page",
  "priority": "High"
}
```

**Response:**
```json
{
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "name": "New Lead from Website",
    "description": "Customer inquiry about enterprise pricing",
    "status": "New",
    "origin": "Website",
    "originDetail": "Contact form - Pricing page",
    "priority": "High",
    "createdAt": "2026-01-26T10:30:00.000Z",
    "updatedAt": "2026-01-26T10:30:00.000Z"
  }
}
```

### Get All Tickets

```http
GET /rest/tickets
Authorization: Bearer {API_KEY}
```

**With Filtering:**
```http
GET /rest/tickets?filter=status[eq]:New
GET /rest/tickets?filter=origin[eq]:Zapier
GET /rest/tickets?filter=status[eq]:New,origin[eq]:Website
```

**With Pagination:**
```http
GET /rest/tickets?limit=20&offset=0
```

### Get Single Ticket

```http
GET /rest/tickets/{id}
Authorization: Bearer {API_KEY}
```

### Update Ticket

```http
PATCH /rest/tickets/{id}
Authorization: Bearer {API_KEY}
Content-Type: application/json

{
  "status": "In Progress",
  "assigneeId": "workspace-member-uuid"
}
```

### Delete Ticket

```http
DELETE /rest/tickets/{id}
Authorization: Bearer {API_KEY}
```

### Create Multiple Tickets (Batch)

```http
POST /rest/batch/tickets
Authorization: Bearer {API_KEY}
Content-Type: application/json

[
  {
    "name": "Lead 1",
    "status": "New",
    "origin": "Zapier"
  },
  {
    "name": "Lead 2",
    "status": "New",
    "origin": "Zapier"
  }
]
```

---

## Zapier Integration Setup

### Option 1: Webhooks by Zapier (Easiest)

1. In Zapier, add action **Webhooks by Zapier** → **POST**
2. Configure:
   - **URL**: `https://your-domain.com/rest/tickets`
   - **Payload Type**: `json`
   - **Data**:
     ```
     name: {{step.name}}
     description: {{step.message}}
     status: New
     origin: Zapier
     originDetail: {{step.source}}
     ```
   - **Headers**:
     ```
     Authorization: Bearer YOUR_API_KEY
     Content-Type: application/json
     ```

### Option 2: Custom Integration (Code by Zapier)

```javascript
// Zapier Code Step
const response = await fetch('https://your-domain.com/rest/tickets', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer YOUR_API_KEY',
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: inputData.leadName || 'New Lead',
    description: inputData.message || '',
    status: 'New',
    origin: 'Zapier',
    originDetail: inputData.source || 'Unknown'
  })
});

return await response.json();
```

---

## Website Backend Integration

### Node.js / Express

```javascript
const axios = require('axios');

const TWENTY_API_URL = 'https://your-domain.com/rest/tickets';
const TWENTY_API_KEY = process.env.TWENTY_API_KEY;

async function createTicket(leadData) {
  const response = await axios.post(TWENTY_API_URL, {
    name: leadData.name,
    description: leadData.message,
    status: 'New',
    origin: 'Website',
    originDetail: leadData.formName || 'Contact Form',
    priority: leadData.priority || 'Medium'
  }, {
    headers: {
      'Authorization': `Bearer ${TWENTY_API_KEY}`,
      'Content-Type': 'application/json'
    }
  });

  return response.data;
}

// Express route example
app.post('/api/contact', async (req, res) => {
  try {
    const ticket = await createTicket({
      name: `${req.body.firstName} ${req.body.lastName}`,
      message: req.body.message,
      formName: 'Homepage Contact Form'
    });
    res.json({ success: true, ticketId: ticket.data.id });
  } catch (error) {
    res.status(500).json({ error: 'Failed to create ticket' });
  }
});
```

### PHP

```php
<?php
function createTicket($leadData) {
    $apiUrl = 'https://your-domain.com/rest/tickets';
    $apiKey = getenv('TWENTY_API_KEY');

    $data = [
        'name' => $leadData['name'],
        'description' => $leadData['message'] ?? '',
        'status' => 'New',
        'origin' => 'Website',
        'originDetail' => $leadData['source'] ?? 'Contact Form'
    ];

    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $apiKey,
        'Content-Type: application/json'
    ]);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $response = curl_exec($ch);
    curl_close($ch);

    return json_decode($response, true);
}

// Usage
$ticket = createTicket([
    'name' => $_POST['name'],
    'message' => $_POST['message'],
    'source' => 'WordPress Contact Form'
]);
?>
```

### Python

```python
import requests
import os

TWENTY_API_URL = 'https://your-domain.com/rest/tickets'
TWENTY_API_KEY = os.environ.get('TWENTY_API_KEY')

def create_ticket(lead_data):
    headers = {
        'Authorization': f'Bearer {TWENTY_API_KEY}',
        'Content-Type': 'application/json'
    }

    payload = {
        'name': lead_data.get('name'),
        'description': lead_data.get('message', ''),
        'status': 'New',
        'origin': 'Website',
        'originDetail': lead_data.get('source', 'Unknown')
    }

    response = requests.post(TWENTY_API_URL, json=payload, headers=headers)
    return response.json()

# Flask example
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/contact', methods=['POST'])
def handle_contact():
    data = request.json
    ticket = create_ticket({
        'name': f"{data['firstName']} {data['lastName']}",
        'message': data.get('message'),
        'source': 'Flask Contact Form'
    })
    return jsonify({'success': True, 'ticketId': ticket['data']['id']})
```

---

## Meta (Facebook/Instagram) Lead Ads Integration

### Via Zapier

1. **Trigger**: Facebook Lead Ads → New Lead
2. **Action**: Webhooks by Zapier → POST
3. **Configuration**:
   - URL: `https://your-domain.com/rest/tickets`
   - Headers: `Authorization: Bearer YOUR_API_KEY`
   - Body:
     ```json
     {
       "name": "{{full_name}}",
       "description": "Phone: {{phone_number}}\nEmail: {{email}}",
       "status": "New",
       "origin": "Meta - Facebook",
       "originDetail": "{{ad_name}} - {{form_name}}"
     }
     ```

### Via Make.com (Integromat)

1. **Trigger**: Facebook Lead Ads → Watch Leads
2. **Action**: HTTP → Make a Request
3. **Configuration**:
   - URL: `https://your-domain.com/rest/tickets`
   - Method: POST
   - Headers:
     - Authorization: `Bearer YOUR_API_KEY`
     - Content-Type: `application/json`
   - Body: Map fields from Facebook trigger

---

## Google Ads Lead Form Integration

### Via Zapier

1. **Trigger**: Google Ads → New Lead Form Entry
2. **Action**: Webhooks by Zapier → POST
3. **Body**:
   ```json
   {
     "name": "{{user_column_data.full_name}}",
     "description": "Phone: {{user_column_data.phone}}\nEmail: {{user_column_data.email}}",
     "status": "New",
     "origin": "Meta - Google Ads",
     "originDetail": "{{campaign_name}} - {{form_name}}"
   }
   ```

---

## Testing the API

### Using cURL

```bash
# Create a ticket
curl -X POST http://localhost:3000/rest/tickets \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Lead",
    "description": "Testing API integration",
    "status": "New",
    "origin": "Manual",
    "originDetail": "cURL test"
  }'

# Get all tickets
curl http://localhost:3000/rest/tickets \
  -H "Authorization: Bearer YOUR_API_KEY"

# Get filtered tickets
curl "http://localhost:3000/rest/tickets?filter=origin[eq]:Zapier" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

### Using Postman

1. Create new request
2. Set method to POST
3. URL: `http://localhost:3000/rest/tickets`
4. Headers tab:
   - `Authorization`: `Bearer YOUR_API_KEY`
   - `Content-Type`: `application/json`
5. Body tab (raw JSON):
   ```json
   {
     "name": "Test from Postman",
     "status": "New",
     "origin": "Manual"
   }
   ```

---

## Error Handling

### Common Error Responses

**401 Unauthorized** - Invalid or missing API key
```json
{
  "statusCode": 401,
  "message": "Unauthorized"
}
```

**400 Bad Request** - Invalid field value
```json
{
  "statusCode": 400,
  "message": "Invalid value for field 'status'"
}
```

**404 Not Found** - Object doesn't exist
```json
{
  "statusCode": 404,
  "message": "Object 'ticket' not found"
}
```

### Best Practices

1. **Always check response status** before processing
2. **Store API keys securely** (environment variables)
3. **Log errors** for debugging
4. **Implement retry logic** for transient failures
5. **Validate data** before sending to API

---

## Rate Limits

Twenty doesn't impose strict rate limits by default, but for production:
- Recommended: Max 100 requests/minute
- Batch operations: Use `/rest/batch/tickets` for multiple records
- Consider implementing queue for high-volume integrations

---

# REST API Examples for Leads and People

Based on your data model, here are complete REST API examples for creating Leads and associated People records.

## Understanding Your Schema

**Leads Object:**
- Fields: `title`, `body`, `status`, `dueDate`
- Relations: `assignee` (Belongs to one), `origins` (Has many), `people` (Has many)

**People Object:**
- Fields: `name`, `emails`, `phones`, `jobTitle`, `city`, `linkedin`, `intro`, `performanceRating`, `whatsapp`, `workPreference`
- Relations: `companies` (Belongs to one), `leads` (Belongs to one - Custom)

---

## Example 1: Create Lead Only (Minimal)

```bash
curl -X POST http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "New Lead from Website",
    "status": "New"
  }'
```

**Response:**
```json
{
  "data": {
    "createLead": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "New Lead from Website",
      "status": "New",
      "createdAt": "2026-01-27T00:00:00.000Z"
    }
  }
}
```

---

## Example 2: Create Lead with All Optional Fields

```bash
curl -X POST http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Enterprise Lead - Acme Corp",
    "body": "Customer interested in enterprise pricing. Requested demo.",
    "status": "New",
    "dueDate": "2026-02-15T00:00:00.000Z",
    "assigneeId": "workspace-member-uuid-here"
  }'
```

**Note:** `assigneeId` requires the UUID of a workspace member. Get it from Settings → Members or via API.

---

## Example 3: Create Person Only (Minimal)

```bash
curl -X POST http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {
      "firstName": "John",
      "lastName": "Doe"
    }
  }'
```

**Response:**
```json
{
  "data": {
    "createPerson": {
      "id": "660e8400-e29b-41d4-a716-446655440001",
      "name": {
        "firstName": "John",
        "lastName": "Doe"
      },
      "createdAt": "2026-01-27T00:00:00.000Z"
    }
  }
}
```

---

## Example 4: Create Person with All Optional Fields

```bash
curl -X POST http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {
      "firstName": "John",
      "lastName": "Doe"
    },
    "emails": [
      {
        "email": "john.doe@example.com",
        "type": "WORK"
      }
    ],
    "phones": [
      {
        "number": "+1-555-123-4567",
        "type": "MOBILE"
      }
    ],
    "jobTitle": "Marketing Director",
    "city": "San Francisco",
    "linkedin": "https://linkedin.com/in/johndoe",
    "intro": "Interested in enterprise CRM solutions",
    "performanceRating": 4,
    "whatsapp": [
      {
        "number": "+1-555-123-4567",
        "type": "MOBILE"
      }
    ],
    "workPreference": ["Remote", "Flexible Hours"]
  }'
```

---

## Example 5: Create Lead + Person Together (Two-Step Process)

Since relations need existing records, create them in sequence:

### Step 1: Create Person First

```bash
PERSON_RESPONSE=$(curl -X POST http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {
      "firstName": "Jane",
      "lastName": "Smith"
    },
    "emails": [
      {
        "email": "jane.smith@example.com",
        "type": "WORK"
      }
    ],
    "phones": [
      {
        "number": "+1-555-987-6543",
        "type": "MOBILE"
      }
    ],
    "jobTitle": "CEO",
    "city": "New York"
  }')
```

**Extract Person ID from response:**
```bash
PERSON_ID=$(echo $PERSON_RESPONSE | jq -r '.data.createPerson.id')
```

### Step 2: Create Lead and Link to Person

```bash
curl -X POST http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"title\": \"Enterprise Lead - Jane Smith\",
    \"body\": \"CEO interested in CRM solution\",
    \"status\": \"New\",
    \"peopleId\": \"$PERSON_ID\"
  }"
```

**Note:** The relation field name depends on your schema. It might be:
- `peopleId` (if relation field is named "people")
- `leadId` (if linking from Person to Lead)
- Check your Data Model to see the exact field name

---

## Example 6: Complete Integration (Zapier/Website)

This example shows how to handle incoming webhook data with optional fields:

```bash
curl -X POST http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Website Inquiry - John Doe",
    "body": "Customer filled out contact form on pricing page",
    "status": "New",
    "dueDate": "2026-02-10T00:00:00.000Z"
  }'
```

Then create the person (if contact info provided):

```bash
curl -X POST http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {
      "firstName": "John",
      "lastName": "Doe"
    },
    "emails": [
      {
        "email": "john@example.com",
        "type": "WORK"
      }
    ],
    "phones": [
      {
        "number": "+1-555-123-4567",
        "type": "MOBILE"
      }
    ],
    "jobTitle": "Marketing Manager",
    "city": "Los Angeles",
    "leadsId": "LEAD_ID_FROM_PREVIOUS_RESPONSE"
  }'
```

---

## Example 7: Node.js/JavaScript Integration

```javascript
const axios = require('axios');

const API_BASE = 'http://localhost:3000';
const API_KEY = 'YOUR_API_KEY';

async function createLeadWithPerson(leadData, personData) {
  const headers = {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json'
  };

  // Step 1: Create Person (if data provided)
  let personId = null;
  if (personData && (personData.name || personData.email)) {
    const personPayload = {
      name: personData.name ? {
        firstName: personData.name.firstName || '',
        lastName: personData.name.lastName || ''
      } : undefined,
      emails: personData.email ? [{
        email: personData.email,
        type: 'WORK'
      }] : undefined,
      phones: personData.phone ? [{
        number: personData.phone,
        type: 'MOBILE'
      }] : undefined,
      jobTitle: personData.jobTitle,
      city: personData.city
    };

    // Remove undefined fields
    Object.keys(personPayload).forEach(key =>
      personPayload[key] === undefined && delete personPayload[key]
    );

    const personResponse = await axios.post(
      `${API_BASE}/rest/people`,
      personPayload,
      { headers }
    );
    personId = personResponse.data.data.createPerson.id;
  }

  // Step 2: Create Lead
  const leadPayload = {
    title: leadData.title || 'New Lead',
    body: leadData.description,
    status: leadData.status || 'New',
    dueDate: leadData.dueDate,
    assigneeId: leadData.assigneeId
  };

  // Link to person if created
  if (personId) {
    leadPayload.peopleId = personId; // Adjust field name based on your schema
  }

  // Remove undefined fields
  Object.keys(leadPayload).forEach(key =>
    leadPayload[key] === undefined && delete leadPayload[key]
  );

  const leadResponse = await axios.post(
    `${API_BASE}/rest/leads`,
    leadPayload,
    { headers }
  );

  return {
    lead: leadResponse.data.data.createLead,
    person: personId ? { id: personId } : null
  };
}

// Usage
createLeadWithPerson(
  {
    title: 'Website Inquiry',
    description: 'Customer interested in pricing',
    status: 'New'
  },
  {
    name: { firstName: 'John', lastName: 'Doe' },
    email: 'john@example.com',
    phone: '+1-555-123-4567',
    jobTitle: 'Marketing Director'
  }
).then(result => {
  console.log('Created:', result);
});
```

---

## Example 8: Python Integration

```python
import requests
import json

API_BASE = 'http://localhost:3000'
API_KEY = 'YOUR_API_KEY'

def create_lead_with_person(lead_data, person_data=None):
    headers = {
        'Authorization': f'Bearer {API_KEY}',
        'Content-Type': 'application/json'
    }

    person_id = None

    # Step 1: Create Person if data provided
    if person_data and (person_data.get('name') or person_data.get('email')):
        person_payload = {}

        if person_data.get('name'):
            person_payload['name'] = {
                'firstName': person_data['name'].get('firstName', ''),
                'lastName': person_data['name'].get('lastName', '')
            }

        if person_data.get('email'):
            person_payload['emails'] = [{
                'email': person_data['email'],
                'type': 'WORK'
            }]

        if person_data.get('phone'):
            person_payload['phones'] = [{
                'number': person_data['phone'],
                'type': 'MOBILE'
            }]

        if person_data.get('jobTitle'):
            person_payload['jobTitle'] = person_data['jobTitle']

        if person_data.get('city'):
            person_payload['city'] = person_data['city']

        person_response = requests.post(
            f'{API_BASE}/rest/people',
            headers=headers,
            json=person_payload
        )
        person_id = person_response.json()['data']['createPerson']['id']

    # Step 2: Create Lead
    lead_payload = {
        'title': lead_data.get('title', 'New Lead'),
        'body': lead_data.get('description'),
        'status': lead_data.get('status', 'New')
    }

    if lead_data.get('dueDate'):
        lead_payload['dueDate'] = lead_data['dueDate']

    if lead_data.get('assigneeId'):
        lead_payload['assigneeId'] = lead_data['assigneeId']

    if person_id:
        lead_payload['peopleId'] = person_id  # Adjust based on your schema

    # Remove None values
    lead_payload = {k: v for k, v in lead_payload.items() if v is not None}

    lead_response = requests.post(
        f'{API_BASE}/rest/leads',
        headers=headers,
        json=lead_payload
    )

    return {
        'lead': lead_response.json()['data']['createLead'],
        'person': {'id': person_id} if person_id else None
    }

# Usage
result = create_lead_with_person(
    {
        'title': 'Website Inquiry',
        'description': 'Customer interested in pricing',
        'status': 'New'
    },
    {
        'name': {'firstName': 'John', 'lastName': 'Doe'},
        'email': 'john@example.com',
        'phone': '+1-555-123-4567',
        'jobTitle': 'Marketing Director'
    }
)
print(result)
```

---

## Field Name Reference

### Leads Object Fields
| API Field Name | Type | Required | Notes |
|----------------|------|----------|-------|
| `title` | Text | Yes | Lead title |
| `body` | Rich Text | No | Description/notes |
| `status` | Select | No | Status value |
| `dueDate` | ISO 8601 | No | `2026-01-27T00:00:00.000Z` |
| `assigneeId` | UUID | No | Workspace member UUID |
| `peopleId` | UUID | No | Person UUID (if relation name is "people") |

### People Object Fields
| API Field Name | Type | Required | Notes |
|----------------|------|----------|-------|
| `name` | Object | Yes | `{firstName, lastName}` |
| `emails` | Array | No | `[{email, type}]` |
| `phones` | Array | No | `[{number, type}]` |
| `jobTitle` | Text | No | Job title |
| `city` | Text | No | City name |
| `linkedin` | Text | No | LinkedIn URL |
| `intro` | Text | No | Introduction text |
| `performanceRating` | Number | No | Rating value |
| `whatsapp` | Array | No | `[{number, type}]` |
| `workPreference` | Array | No | `["Remote", "Flexible"]` |
| `leadsId` | UUID | No | Lead UUID (if relation name is "leads") |

---

## Important Notes

1. **Relation Field Names**: The exact field names for relations depend on how you named them in Data Model. Common patterns:
   - `assigneeId` (for "assignee" relation)
   - `peopleId` (for "people" relation on Lead)
   - `leadsId` (for "leads" relation on Person)

2. **All Fields Optional**: Except `title` for Leads and `name` for People, all other fields are optional.

3. **Date Format**: Use ISO 8601 format: `2026-01-27T00:00:00.000Z`

4. **Arrays**: For multi-value fields like `emails`, `phones`, `workPreference`, always send as arrays even with single values.

5. **Get Field Names**: To see exact API field names, check the GraphQL schema at `/graphql` or inspect network requests in browser DevTools.

---

## Testing Your API

```bash
# Test 1: Create minimal lead
curl -X POST http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Lead"}'

# Test 2: Create person with minimal data
curl -X POST http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": {"firstName": "Test", "lastName": "User"}}'

# Test 3: Get all leads
curl http://localhost:3000/rest/leads \
  -H "Authorization: Bearer YOUR_API_KEY"

# Test 4: Get all people
curl http://localhost:3000/rest/people \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

# Single API Call: Create Lead + Person with Round-Robin Assignment

## New Endpoint: `/rest/leads/create-with-person`

This custom endpoint allows you to create both a Lead and Person in a single API call, automatically links them together, and assigns the Lead to a manager using round-robin distribution.

### Features

✅ **Single API call** - Create Lead and Person together
✅ **Automatic linking** - Links Person to Lead automatically
✅ **Round-robin assignment** - Automatically assigns Lead to available managers
✅ **All fields optional** - Person fields are all optional (except name if provided)

### Endpoint

```http
POST /rest/leads/create-with-person
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json
```

### Request Body

```json
{
  "title": "New Lead from Website",
  "body": "Customer inquiry about pricing",
  "status": "New",
  "dueDate": "2026-02-15T00:00:00.000Z",
  "person": {
    "name": {
      "firstName": "John",
      "lastName": "Doe"
    },
    "emails": [
      {
        "email": "john.doe@example.com",
        "type": "WORK"
      }
    ],
    "phones": [
      {
        "number": "+1-555-123-4567",
        "type": "MOBILE"
      }
    ],
    "jobTitle": "Marketing Director",
    "city": "San Francisco",
    "linkedin": "https://linkedin.com/in/johndoe",
    "intro": "Interested in enterprise CRM solutions",
    "performanceRating": 4,
    "whatsapp": [
      {
        "number": "+1-555-123-4567",
        "type": "MOBILE"
      }
    ],
    "workPreference": ["Remote", "Flexible Hours"]
  }
}
```

### Minimal Request (Person Optional)

```json
{
  "title": "New Lead from Zapier",
  "status": "New"
}
```

### Response

```json
{
  "data": {
    "lead": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "New Lead from Website",
      "body": "Customer inquiry about pricing",
      "status": "New",
      "assigneeId": "workspace-member-uuid",
      "createdAt": "2026-01-27T00:00:00.000Z"
    },
    "person": {
      "id": "660e8400-e29b-41d4-a716-446655440001",
      "name": {
        "firstName": "John",
        "lastName": "Doe"
      },
      "emails": [...],
      "phones": [...]
    }
  }
}
```

If no person data is provided:

```json
{
  "data": {
    "lead": {...},
    "person": null
  }
}
```

### Example: cURL

```bash
curl -X POST http://localhost:3000/rest/leads/create-with-person \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Website Inquiry - John Doe",
    "body": "Customer filled out contact form",
    "status": "New",
    "person": {
      "name": {
        "firstName": "John",
        "lastName": "Doe"
      },
      "emails": [
        {
          "email": "john@example.com",
          "type": "WORK"
        }
      ],
      "phones": [
        {
          "number": "+1-555-123-4567",
          "type": "MOBILE"
        }
      ],
      "jobTitle": "CEO"
    }
  }'
```

### Example: Node.js

```javascript
const axios = require('axios');

async function createLeadWithPerson(leadData) {
  const response = await axios.post(
    'http://localhost:3000/rest/leads/create-with-person',
    {
      title: leadData.title,
      body: leadData.description,
      status: 'New',
      person: {
        name: {
          firstName: leadData.firstName,
          lastName: leadData.lastName
        },
        emails: leadData.email ? [{
          email: leadData.email,
          type: 'WORK'
        }] : undefined,
        phones: leadData.phone ? [{
          number: leadData.phone,
          type: 'MOBILE'
        }] : undefined,
        jobTitle: leadData.jobTitle,
        city: leadData.city
      }
    },
    {
      headers: {
        'Authorization': `Bearer ${process.env.TWENTY_API_KEY}`,
        'Content-Type': 'application/json'
      }
    }
  );

  return response.data;
}

// Usage
createLeadWithPerson({
  title: 'Website Inquiry',
  description: 'Customer interested in pricing',
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  phone: '+1-555-123-4567',
  jobTitle: 'Marketing Director'
}).then(result => {
  console.log('Created:', result);
});
```

### Example: Python

```python
import requests

def create_lead_with_person(lead_data):
    url = 'http://localhost:3000/rest/leads/create-with-person'
    headers = {
        'Authorization': f'Bearer {API_KEY}',
        'Content-Type': 'application/json'
    }

    payload = {
        'title': lead_data.get('title', 'New Lead'),
        'body': lead_data.get('description'),
        'status': lead_data.get('status', 'New')
    }

    # Add person data if provided
    if lead_data.get('firstName') or lead_data.get('email'):
        payload['person'] = {}

        if lead_data.get('firstName') or lead_data.get('lastName'):
            payload['person']['name'] = {
                'firstName': lead_data.get('firstName', ''),
                'lastName': lead_data.get('lastName', '')
            }

        if lead_data.get('email'):
            payload['person']['emails'] = [{
                'email': lead_data['email'],
                'type': 'WORK'
            }]

        if lead_data.get('phone'):
            payload['person']['phones'] = [{
                'number': lead_data['phone'],
                'type': 'MOBILE'
            }]

        if lead_data.get('jobTitle'):
            payload['person']['jobTitle'] = lead_data['jobTitle']

    response = requests.post(url, headers=headers, json=payload)
    return response.json()

# Usage
result = create_lead_with_person({
    'title': 'Website Inquiry',
    'description': 'Customer interested in pricing',
    'firstName': 'John',
    'lastName': 'Doe',
    'email': 'john@example.com',
    'phone': '+1-555-123-4567',
    'jobTitle': 'Marketing Director'
})
print(result)
```

### How Round-Robin Works

1. **Fetches all workspace members** (managers/assignees)
2. **Maintains state per workspace** - tracks last assigned index
3. **Rotates through members** - assigns to next member in sequence
4. **Wraps around** - when reaching the end, starts from the beginning
5. **Resets on member changes** - if members are added/removed, resets the rotation

### Notes

- **Round-robin state** is stored in-memory (per server instance)
- For distributed systems, consider using Redis for shared state
- If no managers are available, `assigneeId` will be `null`
- Person creation is **completely optional** - you can create leads without person data
- All person fields are optional - only include what you have

### Zapier/Make.com Integration

Use this endpoint in your Zapier/Make workflows:

**Zapier:**
1. Add **Webhooks by Zapier** → **POST** action
2. URL: `https://your-domain.com/rest/leads/create-with-person`
3. Headers: `Authorization: Bearer YOUR_API_KEY`
4. Body: Map your trigger fields to the request structure

**Make.com:**
1. Add **HTTP** → **Make a Request** module
2. Method: POST
3. URL: `https://your-domain.com/rest/leads/create-with-person`
4. Headers: `Authorization: Bearer YOUR_API_KEY`
5. Body: Map fields from your trigger
