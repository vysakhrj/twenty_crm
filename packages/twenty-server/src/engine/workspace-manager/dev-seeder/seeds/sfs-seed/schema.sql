-- Workspace schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis (fallback from information_schema)
CREATE SCHEMA IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis";

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."_customer" (
  "id" uuid NOT NULL,
  "name" text ,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "updatedBySource" USER-DEFINED NOT NULL,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text NOT NULL,
  "updatedByContext" jsonb ,
  "deletedAt" timestamp with time zone ,
  "createdBySource" USER-DEFINED NOT NULL,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text NOT NULL,
  "createdByContext" jsonb ,
  "position" double precision NOT NULL,
  "searchVector" tsvector ,
  "emailsPrimaryEmail" text ,
  "emailsAdditionalEmails" jsonb ,
  "phonesPrimaryPhoneNumber" text ,
  "phonesPrimaryPhoneCountryCode" text ,
  "phonesPrimaryPhoneCallingCode" text ,
  "phonesAdditionalPhones" jsonb 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."_lead" (
  "id" uuid NOT NULL,
  "name" text ,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "updatedBySource" USER-DEFINED NOT NULL,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text NOT NULL,
  "updatedByContext" jsonb ,
  "deletedAt" timestamp with time zone ,
  "createdBySource" USER-DEFINED NOT NULL,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text NOT NULL,
  "createdByContext" jsonb ,
  "position" double precision NOT NULL,
  "searchVector" tsvector ,
  "originId" uuid ,
  "propertyId" uuid ,
  "assigneeId" uuid ,
  "dueDate" timestamp with time zone ,
  "customerId" uuid ,
  "status" USER-DEFINED ,
  "body" text ,
  "notesBlocknote" text ,
  "notesMarkdown" text 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."_origin" (
  "id" uuid NOT NULL,
  "name" text ,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "updatedBySource" USER-DEFINED NOT NULL,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text NOT NULL,
  "updatedByContext" jsonb ,
  "deletedAt" timestamp with time zone ,
  "createdBySource" USER-DEFINED NOT NULL,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text NOT NULL,
  "createdByContext" jsonb ,
  "position" double precision NOT NULL,
  "searchVector" tsvector 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."_property" (
  "id" uuid NOT NULL,
  "name" text ,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "deletedAt" timestamp with time zone ,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "position" double precision NOT NULL,
  "searchVector" tsvector ,
  "locationAddressStreet1" text ,
  "locationAddressStreet2" text ,
  "locationAddressCity" text ,
  "locationAddressPostcode" text ,
  "locationAddressState" text ,
  "locationAddressCountry" text ,
  "locationAddressLat" numeric ,
  "locationAddressLng" numeric 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."attachment" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "fullPath" text ,
  "fileCategory" USER-DEFINED NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "taskId" uuid ,
  "noteId" uuid ,
  "personId" uuid ,
  "companyId" uuid ,
  "opportunityId" uuid ,
  "dashboardId" uuid ,
  "workflowId" uuid ,
  "propertyId" uuid ,
  "originId" uuid ,
  "leadId" uuid ,
  "customerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."blocklist" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "handle" text ,
  "workspaceMemberId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."calendarChannel" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "handle" text ,
  "visibility" USER-DEFINED NOT NULL,
  "isContactAutoCreationEnabled" boolean NOT NULL,
  "contactAutoCreationPolicy" USER-DEFINED NOT NULL,
  "isSyncEnabled" boolean NOT NULL,
  "syncCursor" text ,
  "syncStatus" USER-DEFINED ,
  "syncStage" USER-DEFINED NOT NULL,
  "syncStageStartedAt" timestamp with time zone ,
  "syncedAt" timestamp with time zone ,
  "throttleFailureCount" double precision NOT NULL,
  "connectedAccountId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."calendarChannelEventAssociation" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "eventExternalId" text ,
  "recurringEventExternalId" text ,
  "calendarChannelId" uuid ,
  "calendarEventId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."calendarEvent" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "title" text ,
  "isCanceled" boolean NOT NULL,
  "isFullDay" boolean NOT NULL,
  "startsAt" timestamp with time zone ,
  "endsAt" timestamp with time zone ,
  "externalCreatedAt" timestamp with time zone ,
  "externalUpdatedAt" timestamp with time zone ,
  "description" text ,
  "location" text ,
  "iCalUid" text ,
  "conferenceSolution" text ,
  "conferenceLinkPrimaryLinkLabel" text ,
  "conferenceLinkPrimaryLinkUrl" text ,
  "conferenceLinkSecondaryLinks" jsonb 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."calendarEventParticipant" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "handle" text ,
  "displayName" text ,
  "isOrganizer" boolean NOT NULL,
  "responseStatus" USER-DEFINED NOT NULL,
  "calendarEventId" uuid ,
  "personId" uuid ,
  "workspaceMemberId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."company" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "domainNamePrimaryLinkLabel" text ,
  "domainNamePrimaryLinkUrl" text ,
  "domainNameSecondaryLinks" jsonb ,
  "addressAddressStreet1" text ,
  "addressAddressStreet2" text ,
  "addressAddressCity" text ,
  "addressAddressPostcode" text ,
  "addressAddressState" text ,
  "addressAddressCountry" text ,
  "addressAddressLat" numeric ,
  "addressAddressLng" numeric ,
  "employees" double precision ,
  "linkedinLinkPrimaryLinkLabel" text ,
  "linkedinLinkPrimaryLinkUrl" text ,
  "linkedinLinkSecondaryLinks" jsonb ,
  "xLinkPrimaryLinkLabel" text ,
  "xLinkPrimaryLinkUrl" text ,
  "xLinkSecondaryLinks" jsonb ,
  "annualRecurringRevenueAmountMicros" numeric ,
  "annualRecurringRevenueCurrencyCode" text ,
  "idealCustomerProfile" boolean NOT NULL,
  "position" double precision NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector ,
  "accountOwnerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."connectedAccount" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "handle" text ,
  "provider" text NOT NULL,
  "accessToken" text ,
  "refreshToken" text ,
  "lastSyncHistoryId" text ,
  "authFailedAt" timestamp with time zone ,
  "lastCredentialsRefreshedAt" timestamp with time zone ,
  "handleAliases" text ,
  "scopes" ARRAY ,
  "connectionParameters" jsonb ,
  "accountOwnerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."dashboard" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "title" text ,
  "position" double precision NOT NULL,
  "pageLayoutId" uuid ,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."favorite" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "position" double precision NOT NULL,
  "viewId" uuid ,
  "forWorkspaceMemberId" uuid ,
  "personId" uuid ,
  "companyId" uuid ,
  "opportunityId" uuid ,
  "workflowId" uuid ,
  "workflowVersionId" uuid ,
  "workflowRunId" uuid ,
  "taskId" uuid ,
  "noteId" uuid ,
  "dashboardId" uuid ,
  "favoriteFolderId" uuid ,
  "propertyId" uuid ,
  "originId" uuid ,
  "leadId" uuid ,
  "customerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."favoriteFolder" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "position" double precision NOT NULL,
  "name" text 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."message" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "headerMessageId" text ,
  "direction" USER-DEFINED NOT NULL,
  "subject" text ,
  "text" text ,
  "receivedAt" timestamp with time zone ,
  "messageThreadId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."messageChannel" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "visibility" USER-DEFINED NOT NULL,
  "handle" text ,
  "type" USER-DEFINED NOT NULL,
  "isContactAutoCreationEnabled" boolean NOT NULL,
  "contactAutoCreationPolicy" USER-DEFINED NOT NULL,
  "messageFolderImportPolicy" USER-DEFINED NOT NULL,
  "excludeNonProfessionalEmails" boolean NOT NULL,
  "excludeGroupEmails" boolean NOT NULL,
  "pendingGroupEmailsAction" USER-DEFINED NOT NULL,
  "isSyncEnabled" boolean NOT NULL,
  "syncCursor" text ,
  "syncedAt" timestamp with time zone ,
  "syncStatus" USER-DEFINED ,
  "syncStage" USER-DEFINED NOT NULL,
  "syncStageStartedAt" timestamp with time zone ,
  "throttleFailureCount" double precision NOT NULL,
  "connectedAccountId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."messageChannelMessageAssociation" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "messageExternalId" text ,
  "messageThreadExternalId" text ,
  "direction" USER-DEFINED NOT NULL,
  "messageChannelId" uuid ,
  "messageThreadId" uuid ,
  "messageId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."messageFolder" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "syncCursor" text ,
  "isSentFolder" boolean NOT NULL,
  "isSynced" boolean NOT NULL,
  "parentFolderId" text ,
  "externalId" text ,
  "pendingSyncAction" USER-DEFINED NOT NULL,
  "messageChannelId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."messageParticipant" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "role" USER-DEFINED NOT NULL,
  "handle" text ,
  "displayName" text ,
  "messageId" uuid ,
  "personId" uuid ,
  "workspaceMemberId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."messageThread" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."note" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "position" double precision NOT NULL,
  "title" text ,
  "bodyV2Blocknote" text ,
  "bodyV2Markdown" text ,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."noteTarget" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "noteId" uuid ,
  "personId" uuid ,
  "companyId" uuid ,
  "opportunityId" uuid ,
  "propertyId" uuid ,
  "originId" uuid ,
  "leadId" uuid ,
  "customerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."opportunity" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "amountAmountMicros" numeric ,
  "amountCurrencyCode" text ,
  "closeDate" timestamp with time zone ,
  "stage" USER-DEFINED NOT NULL,
  "position" double precision NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector ,
  "pointOfContactId" uuid ,
  "companyId" uuid ,
  "ownerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."person" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "nameFirstName" text ,
  "nameLastName" text ,
  "emailsPrimaryEmail" text ,
  "emailsAdditionalEmails" jsonb ,
  "linkedinLinkPrimaryLinkLabel" text ,
  "linkedinLinkPrimaryLinkUrl" text ,
  "linkedinLinkSecondaryLinks" jsonb ,
  "xLinkPrimaryLinkLabel" text ,
  "xLinkPrimaryLinkUrl" text ,
  "xLinkSecondaryLinks" jsonb ,
  "jobTitle" text ,
  "phonesPrimaryPhoneNumber" text ,
  "phonesPrimaryPhoneCountryCode" text ,
  "phonesPrimaryPhoneCallingCode" text ,
  "phonesAdditionalPhones" jsonb ,
  "city" text ,
  "avatarUrl" text ,
  "position" double precision NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector ,
  "companyId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."task" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "position" double precision NOT NULL,
  "title" text ,
  "bodyV2Blocknote" text ,
  "bodyV2Markdown" text ,
  "dueAt" timestamp with time zone ,
  "status" USER-DEFINED ,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector ,
  "assigneeId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."taskTarget" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "taskId" uuid ,
  "personId" uuid ,
  "companyId" uuid ,
  "opportunityId" uuid ,
  "propertyId" uuid ,
  "originId" uuid ,
  "leadId" uuid ,
  "customerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."timelineActivity" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "happensAt" timestamp with time zone NOT NULL,
  "name" text ,
  "properties" jsonb ,
  "linkedRecordCachedName" text ,
  "linkedRecordId" uuid ,
  "linkedObjectMetadataId" uuid ,
  "workspaceMemberId" uuid ,
  "targetPersonId" uuid ,
  "targetCompanyId" uuid ,
  "targetOpportunityId" uuid ,
  "targetNoteId" uuid ,
  "targetTaskId" uuid ,
  "targetWorkflowId" uuid ,
  "targetWorkflowVersionId" uuid ,
  "targetWorkflowRunId" uuid ,
  "targetDashboardId" uuid ,
  "targetPropertyId" uuid ,
  "targetOriginId" uuid ,
  "targetLeadId" uuid ,
  "targetCustomerId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."workflow" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "lastPublishedVersionId" text ,
  "statuses" ARRAY ,
  "position" double precision NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "searchVector" tsvector 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."workflowAutomatedTrigger" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "type" USER-DEFINED NOT NULL,
  "settings" jsonb NOT NULL,
  "workflowId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."workflowRun" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "enqueuedAt" timestamp with time zone ,
  "startedAt" timestamp with time zone ,
  "endedAt" timestamp with time zone ,
  "status" USER-DEFINED NOT NULL,
  "createdBySource" USER-DEFINED ,
  "createdByWorkspaceMemberId" uuid ,
  "createdByName" text ,
  "createdByContext" jsonb ,
  "updatedBySource" USER-DEFINED ,
  "updatedByWorkspaceMemberId" uuid ,
  "updatedByName" text ,
  "updatedByContext" jsonb ,
  "state" jsonb NOT NULL,
  "context" jsonb ,
  "output" jsonb ,
  "position" double precision NOT NULL,
  "searchVector" tsvector ,
  "workflowVersionId" uuid ,
  "workflowId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."workflowVersion" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "name" text ,
  "trigger" jsonb ,
  "steps" jsonb ,
  "status" USER-DEFINED NOT NULL,
  "position" double precision NOT NULL,
  "searchVector" tsvector ,
  "workflowId" uuid 
);

CREATE TABLE IF NOT EXISTS "workspace_9zs4rq4zo2wzg53xjkq5u4qis"."workspaceMember" (
  "id" uuid NOT NULL,
  "createdAt" timestamp with time zone NOT NULL,
  "updatedAt" timestamp with time zone NOT NULL,
  "deletedAt" timestamp with time zone ,
  "position" double precision NOT NULL,
  "nameFirstName" text ,
  "nameLastName" text ,
  "colorScheme" text NOT NULL,
  "locale" text NOT NULL,
  "avatarUrl" text ,
  "userEmail" text ,
  "calendarStartDay" double precision NOT NULL,
  "userId" uuid NOT NULL,
  "timeZone" text NOT NULL,
  "dateFormat" USER-DEFINED NOT NULL,
  "timeFormat" USER-DEFINED NOT NULL,
  "numberFormat" USER-DEFINED NOT NULL,
  "availabilityStartTime" text NOT NULL,
  "availabilityEndTime" text NOT NULL,
  "availabilityHours" double precision ,
  "availableDays" ARRAY NOT NULL,
  "leaveStartDate" timestamp with time zone ,
  "leaveEndDate" timestamp with time zone ,
  "searchVector" tsvector 
);
