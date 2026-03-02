#!/usr/bin/env bash
# Create lead with person – example using all supported fields.
# Replace BASE_URL and API_KEY with your server URL and API key (or JWT).
# If your server uses a different path, try: /rest/leads/create-with-person or /api/lead/create-with-person

BASE_URL="${BASE_URL:-http://localhost:3000}"
API_KEY="${API_KEY:-your-api-key-or-jwt}"

curl -X POST "${BASE_URL}/rest/leads/create-with-person" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_KEY}" \
  -d '{
  "body": "Interested in 3-bedroom units. Prefers move-in by end of month.",
  "dueDate": "2026-03-15T18:00:00.000Z",
  "convenientTime": "Any time after 6pm",
  "buildingType": ["Apartment", "Villa"],
  "origin": "website",
  "propertyName": "Downtown Office",
  "person": {
    "name": {
      "firstName": "Jane",
      "lastName": "Doe"
    },
    "emails": [
      {
        "email": "jane.doe@example.com",
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
    "companyName": "Acme Inc",
    "city": "New York",
    "linkedin": "https://linkedin.com/in/janedoe",
    "intro": "10+ years in real estate marketing.",
    "performanceRating": 4,
    "whatsapp": [
      {
        "number": "+1-555-987-6543",
        "type": "MOBILE"
      }
    ],
    "workPreference": ["HYBRID", "REMOTE_WORK"]
  }
}'
