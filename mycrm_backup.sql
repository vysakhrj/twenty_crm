--
-- PostgreSQL database dump
--

\restrict 1VvYMeqq8gpgB2iilVO5OyZXAmvnT4ws6tAjKliyde7gy6Nts7IT0vfrf4O3i1g

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA core;


--
-- Name: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA workspace_9zs4rq4zo2wzg53xjkq5u4qis;


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: agentChatMessage_role_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."agentChatMessage_role_enum" AS ENUM (
    'user',
    'assistant'
);


--
-- Name: agentMessage_role_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."agentMessage_role_enum" AS ENUM (
    'user',
    'assistant',
    'system'
);


--
-- Name: commandMenuItem_availabilitytype_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."commandMenuItem_availabilitytype_enum" AS ENUM (
    'GLOBAL',
    'SINGLE_RECORD',
    'BULK_RECORDS'
);


--
-- Name: dataSource_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."dataSource_type_enum" AS ENUM (
    'postgres'
);


--
-- Name: emailingDomain_driver_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."emailingDomain_driver_enum" AS ENUM (
    'AWS_SES'
);


--
-- Name: emailingDomain_status_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."emailingDomain_status_enum" AS ENUM (
    'PENDING',
    'VERIFIED',
    'FAILED',
    'TEMPORARY_FAILURE'
);


--
-- Name: indexMetadata_indextype_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."indexMetadata_indextype_enum" AS ENUM (
    'BTREE',
    'GIN'
);


--
-- Name: keyValuePair_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."keyValuePair_type_enum" AS ENUM (
    'USER_VARIABLE',
    'FEATURE_FLAG',
    'CONFIG_VARIABLE'
);


--
-- Name: pageLayoutWidget_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."pageLayoutWidget_type_enum" AS ENUM (
    'VIEW',
    'IFRAME',
    'FIELD',
    'FIELDS',
    'GRAPH',
    'STANDALONE_RICH_TEXT',
    'TIMELINE',
    'TASKS',
    'NOTES',
    'FILES',
    'EMAILS',
    'CALENDAR',
    'FIELD_RICH_TEXT',
    'WORKFLOW',
    'WORKFLOW_VERSION',
    'WORKFLOW_RUN'
);


--
-- Name: pageLayout_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."pageLayout_type_enum" AS ENUM (
    'RECORD_INDEX',
    'RECORD_PAGE',
    'DASHBOARD'
);


--
-- Name: routeTrigger_httpmethod_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."routeTrigger_httpmethod_enum" AS ENUM (
    'GET',
    'POST',
    'PUT',
    'PATCH',
    'DELETE'
);


--
-- Name: rowLevelPermissionPredicateGroup_logicaloperator_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."rowLevelPermissionPredicateGroup_logicaloperator_enum" AS ENUM (
    'AND',
    'OR'
);


--
-- Name: rowLevelPermissionPredicate_operand_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."rowLevelPermissionPredicate_operand_enum" AS ENUM (
    'IS',
    'IS_NOT_NULL',
    'IS_NOT',
    'LESS_THAN_OR_EQUAL',
    'GREATER_THAN_OR_EQUAL',
    'IS_BEFORE',
    'IS_AFTER',
    'CONTAINS',
    'DOES_NOT_CONTAIN',
    'IS_EMPTY',
    'IS_NOT_EMPTY',
    'IS_RELATIVE',
    'IS_IN_PAST',
    'IS_IN_FUTURE',
    'IS_TODAY',
    'VECTOR_SEARCH'
);


--
-- Name: twoFactorAuthenticationMethod_status_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."twoFactorAuthenticationMethod_status_enum" AS ENUM (
    'PENDING',
    'VERIFIED'
);


--
-- Name: twoFactorAuthenticationMethod_strategy_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."twoFactorAuthenticationMethod_strategy_enum" AS ENUM (
    'TOTP'
);


--
-- Name: viewField_aggregateoperation_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."viewField_aggregateoperation_enum" AS ENUM (
    'MIN',
    'MAX',
    'AVG',
    'SUM',
    'COUNT',
    'COUNT_UNIQUE_VALUES',
    'COUNT_EMPTY',
    'COUNT_NOT_EMPTY',
    'COUNT_TRUE',
    'COUNT_FALSE',
    'PERCENTAGE_EMPTY',
    'PERCENTAGE_NOT_EMPTY'
);


--
-- Name: viewFilterGroup_logicaloperator_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."viewFilterGroup_logicaloperator_enum" AS ENUM (
    'AND',
    'OR',
    'NOT'
);


--
-- Name: viewFilter_operand_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."viewFilter_operand_enum" AS ENUM (
    'IS',
    'IS_NOT_NULL',
    'IS_NOT',
    'LESS_THAN_OR_EQUAL',
    'GREATER_THAN_OR_EQUAL',
    'IS_BEFORE',
    'IS_AFTER',
    'CONTAINS',
    'DOES_NOT_CONTAIN',
    'IS_EMPTY',
    'IS_NOT_EMPTY',
    'IS_RELATIVE',
    'IS_IN_PAST',
    'IS_IN_FUTURE',
    'IS_TODAY',
    'VECTOR_SEARCH'
);


--
-- Name: viewSort_direction_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."viewSort_direction_enum" AS ENUM (
    'ASC',
    'DESC'
);


--
-- Name: view_calendarlayout_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_calendarlayout_enum AS ENUM (
    'DAY',
    'WEEK',
    'MONTH'
);


--
-- Name: view_kanbanaggregateoperation_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_kanbanaggregateoperation_enum AS ENUM (
    'MIN',
    'MAX',
    'AVG',
    'SUM',
    'COUNT',
    'COUNT_UNIQUE_VALUES',
    'COUNT_EMPTY',
    'COUNT_NOT_EMPTY',
    'COUNT_TRUE',
    'COUNT_FALSE',
    'PERCENTAGE_EMPTY',
    'PERCENTAGE_NOT_EMPTY'
);


--
-- Name: view_key_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_key_enum AS ENUM (
    'INDEX'
);


--
-- Name: view_openrecordin_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_openrecordin_enum AS ENUM (
    'SIDE_PANEL',
    'RECORD_PAGE'
);


--
-- Name: view_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_type_enum AS ENUM (
    'TABLE',
    'KANBAN',
    'CALENDAR'
);


--
-- Name: view_visibility_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core.view_visibility_enum AS ENUM (
    'WORKSPACE',
    'UNLISTED'
);


--
-- Name: workspaceSSOIdentityProvider_status_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."workspaceSSOIdentityProvider_status_enum" AS ENUM (
    'Active',
    'Inactive',
    'Error'
);


--
-- Name: workspaceSSOIdentityProvider_type_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."workspaceSSOIdentityProvider_type_enum" AS ENUM (
    'OIDC',
    'SAML'
);


--
-- Name: workspace_activationStatus_enum; Type: TYPE; Schema: core; Owner: -
--

CREATE TYPE core."workspace_activationStatus_enum" AS ENUM (
    'ONGOING_CREATION',
    'PENDING_CREATION',
    'ACTIVE',
    'INACTIVE',
    'SUSPENDED'
);


--
-- Name: _customer_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _customer_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _lead_buildingType_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_buildingType_enum" AS ENUM (
    'OPT1_BHK',
    'OPT2_BHK',
    'OPT3_BHK',
    'OPT4_BHK',
    'APARTMENT',
    'VILLA'
);


--
-- Name: _lead_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _lead_status_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead_status_enum AS ENUM (
    'NEW',
    'CONTACTED',
    'NURTURE',
    'CONVERTED',
    'DECLINED'
);


--
-- Name: _lead_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _origin_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _origin_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _property_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: _property_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: attachment_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: attachment_fileCategory_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_fileCategory_enum" AS ENUM (
    'ARCHIVE',
    'AUDIO',
    'IMAGE',
    'PRESENTATION',
    'SPREADSHEET',
    'TEXT_DOCUMENT',
    'VIDEO',
    'OTHER'
);


--
-- Name: attachment_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: calendarChannel_contactAutoCreationPolicy_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_contactAutoCreationPolicy_enum" AS ENUM (
    'AS_PARTICIPANT_AND_ORGANIZER',
    'AS_PARTICIPANT',
    'AS_ORGANIZER',
    'NONE'
);


--
-- Name: calendarChannel_syncStage_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_syncStage_enum" AS ENUM (
    'CALENDAR_EVENT_LIST_FETCH_PENDING',
    'CALENDAR_EVENT_LIST_FETCH_SCHEDULED',
    'CALENDAR_EVENT_LIST_FETCH_ONGOING',
    'CALENDAR_EVENTS_IMPORT_PENDING',
    'CALENDAR_EVENTS_IMPORT_SCHEDULED',
    'CALENDAR_EVENTS_IMPORT_ONGOING',
    'FAILED',
    'PENDING_CONFIGURATION'
);


--
-- Name: calendarChannel_syncStatus_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_syncStatus_enum" AS ENUM (
    'ONGOING',
    'NOT_SYNCED',
    'ACTIVE',
    'FAILED_INSUFFICIENT_PERMISSIONS',
    'FAILED_UNKNOWN'
);


--
-- Name: calendarChannel_visibility_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_visibility_enum" AS ENUM (
    'METADATA',
    'SHARE_EVERYTHING'
);


--
-- Name: calendarEventParticipant_responseStatus_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant_responseStatus_enum" AS ENUM (
    'NEEDS_ACTION',
    'DECLINED',
    'TENTATIVE',
    'ACCEPTED'
);


--
-- Name: company_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: company_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: dashboard_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: dashboard_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: messageChannelMessageAssociation_direction_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation_direction_enum" AS ENUM (
    'INCOMING',
    'OUTGOING'
);


--
-- Name: messageChannel_contactAutoCreationPolicy_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_contactAutoCreationPolicy_enum" AS ENUM (
    'SENT_AND_RECEIVED',
    'SENT',
    'NONE'
);


--
-- Name: messageChannel_messageFolderImportPolicy_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_messageFolderImportPolicy_enum" AS ENUM (
    'ALL_FOLDERS',
    'SELECTED_FOLDERS'
);


--
-- Name: messageChannel_pendingGroupEmailsAction_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_pendingGroupEmailsAction_enum" AS ENUM (
    'GROUP_EMAILS_DELETION',
    'GROUP_EMAILS_IMPORT',
    'NONE'
);


--
-- Name: messageChannel_syncStage_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_syncStage_enum" AS ENUM (
    'MESSAGE_LIST_FETCH_PENDING',
    'MESSAGE_LIST_FETCH_SCHEDULED',
    'MESSAGE_LIST_FETCH_ONGOING',
    'MESSAGES_IMPORT_PENDING',
    'MESSAGES_IMPORT_SCHEDULED',
    'MESSAGES_IMPORT_ONGOING',
    'FAILED',
    'PENDING_CONFIGURATION'
);


--
-- Name: messageChannel_syncStatus_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_syncStatus_enum" AS ENUM (
    'ONGOING',
    'NOT_SYNCED',
    'ACTIVE',
    'FAILED_INSUFFICIENT_PERMISSIONS',
    'FAILED_UNKNOWN'
);


--
-- Name: messageChannel_type_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_type_enum" AS ENUM (
    'EMAIL',
    'SMS'
);


--
-- Name: messageChannel_visibility_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_visibility_enum" AS ENUM (
    'METADATA',
    'SUBJECT',
    'SHARE_EVERYTHING'
);


--
-- Name: messageFolder_pendingSyncAction_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder_pendingSyncAction_enum" AS ENUM (
    'FOLDER_DELETION',
    'NONE'
);


--
-- Name: messageParticipant_role_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant_role_enum" AS ENUM (
    'FROM',
    'TO',
    'CC',
    'BCC'
);


--
-- Name: message_direction_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis.message_direction_enum AS ENUM (
    'INCOMING',
    'OUTGOING'
);


--
-- Name: note_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: note_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: opportunity_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: opportunity_stage_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity_stage_enum AS ENUM (
    'NEW',
    'SCREENING',
    'MEETING',
    'PROPOSAL',
    'CUSTOMER'
);


--
-- Name: opportunity_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: person_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: person_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: task_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: task_status_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis.task_status_enum AS ENUM (
    'TODO',
    'IN_PROGRESS',
    'DONE'
);


--
-- Name: task_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: workflowAutomatedTrigger_type_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger_type_enum" AS ENUM (
    'DATABASE_EVENT',
    'CRON'
);


--
-- Name: workflowRun_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: workflowRun_status_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_status_enum" AS ENUM (
    'NOT_STARTED',
    'RUNNING',
    'COMPLETED',
    'FAILED',
    'ENQUEUED',
    'STOPPING',
    'STOPPED'
);


--
-- Name: workflowRun_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: workflowVersion_status_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion_status_enum" AS ENUM (
    'DRAFT',
    'ACTIVE',
    'DEACTIVATED',
    'ARCHIVED'
);


--
-- Name: workflow_createdBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_createdBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: workflow_statuses_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow_statuses_enum AS ENUM (
    'DRAFT',
    'ACTIVE',
    'DEACTIVATED'
);


--
-- Name: workflow_updatedBySource_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_updatedBySource_enum" AS ENUM (
    'EMAIL',
    'CALENDAR',
    'WORKFLOW',
    'AGENT',
    'API',
    'IMPORT',
    'MANUAL',
    'SYSTEM',
    'WEBHOOK',
    'APPLICATION'
);


--
-- Name: workspaceMember_availableDays_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum" AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);


--
-- Name: workspaceMember_dateFormat_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_dateFormat_enum" AS ENUM (
    'SYSTEM',
    'MONTH_FIRST',
    'DAY_FIRST',
    'YEAR_FIRST'
);


--
-- Name: workspaceMember_numberFormat_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_numberFormat_enum" AS ENUM (
    'SYSTEM',
    'COMMAS_AND_DOT',
    'SPACES_AND_COMMA',
    'DOTS_AND_COMMA',
    'APOSTROPHE_AND_DOT'
);


--
-- Name: workspaceMember_timeFormat_enum; Type: TYPE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TYPE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_timeFormat_enum" AS ENUM (
    'SYSTEM',
    'HOUR_24',
    'HOUR_12'
);


--
-- Name: unaccent_immutable(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.unaccent_immutable(input text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
        SELECT public.unaccent('public.unaccent'::regdictionary, input)
        $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _typeorm_generated_columns_and_materialized_views; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core._typeorm_generated_columns_and_materialized_views (
    type character varying NOT NULL,
    database character varying,
    schema character varying,
    "table" character varying,
    name character varying,
    value text
);


--
-- Name: _typeorm_migrations; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core._typeorm_migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: _typeorm_migrations_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core._typeorm_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _typeorm_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core._typeorm_migrations_id_seq OWNED BY core._typeorm_migrations.id;


--
-- Name: agent; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.agent (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "standardId" uuid,
    name character varying NOT NULL,
    label character varying NOT NULL,
    icon character varying,
    description text,
    prompt text NOT NULL,
    "modelId" character varying DEFAULT 'default-smart-model'::character varying NOT NULL,
    "responseFormat" jsonb DEFAULT '{"type": "text"}'::jsonb,
    "workspaceId" uuid NOT NULL,
    "isCustom" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL,
    "modelConfiguration" jsonb,
    "universalIdentifier" uuid NOT NULL,
    "evaluationInputs" text[] DEFAULT '{}'::text[] NOT NULL
);


--
-- Name: agentChatThread; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."agentChatThread" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userWorkspaceId" uuid NOT NULL,
    title character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "totalInputTokens" integer DEFAULT 0 NOT NULL,
    "totalOutputTokens" integer DEFAULT 0 NOT NULL,
    "contextWindowTokens" integer,
    "totalInputCredits" bigint DEFAULT 0 NOT NULL,
    "totalOutputCredits" bigint DEFAULT 0 NOT NULL
);


--
-- Name: agentMessage; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."agentMessage" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "threadId" uuid NOT NULL,
    "turnId" uuid NOT NULL,
    "agentId" uuid,
    role core."agentMessage_role_enum" NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: agentMessagePart; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."agentMessagePart" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "messageId" uuid NOT NULL,
    "orderIndex" integer NOT NULL,
    type character varying NOT NULL,
    "textContent" text,
    "reasoningContent" text,
    "toolName" character varying,
    "toolCallId" character varying,
    "toolInput" jsonb,
    "toolOutput" jsonb,
    state character varying,
    "errorMessage" text,
    "errorDetails" jsonb,
    "sourceUrlSourceId" character varying,
    "sourceUrlUrl" character varying,
    "sourceUrlTitle" character varying,
    "sourceDocumentSourceId" character varying,
    "sourceDocumentMediaType" character varying,
    "sourceDocumentTitle" character varying,
    "sourceDocumentFilename" character varying,
    "fileMediaType" character varying,
    "fileFilename" character varying,
    "fileUrl" character varying,
    "providerMetadata" jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: agentTurn; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."agentTurn" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "threadId" uuid NOT NULL,
    "agentId" uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: agentTurnEvaluation; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."agentTurnEvaluation" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "turnId" uuid NOT NULL,
    score integer NOT NULL,
    comment text,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: apiKey; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."apiKey" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "revokedAt" timestamp with time zone,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: appToken; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."appToken" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    "workspaceId" uuid,
    type text DEFAULT 'REFRESH_TOKEN'::text NOT NULL,
    value text,
    "expiresAt" timestamp with time zone NOT NULL,
    "deletedAt" timestamp with time zone,
    "revokedAt" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    context jsonb
);


--
-- Name: application; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.application (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    name text NOT NULL,
    description text,
    version text,
    "sourceType" text DEFAULT 'local'::text NOT NULL,
    "sourcePath" text NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "serverlessFunctionLayerId" uuid,
    "canBeUninstalled" boolean DEFAULT true NOT NULL,
    "defaultServerlessFunctionRoleId" uuid
);


--
-- Name: applicationVariable; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."applicationVariable" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    key text NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    "isSecret" boolean DEFAULT false NOT NULL,
    "applicationId" uuid,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: approvedAccessDomain; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."approvedAccessDomain" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    domain character varying NOT NULL,
    "isValidated" boolean DEFAULT false NOT NULL,
    "workspaceId" uuid NOT NULL
);


--
-- Name: commandMenuItem; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."commandMenuItem" (
    "workspaceId" uuid NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "workflowVersionId" uuid NOT NULL,
    label character varying NOT NULL,
    icon character varying,
    "isPinned" boolean DEFAULT false NOT NULL,
    "availabilityType" core."commandMenuItem_availabilitytype_enum" DEFAULT 'GLOBAL'::core."commandMenuItem_availabilitytype_enum" NOT NULL,
    "availabilityObjectMetadataId" uuid,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: cronTrigger; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."cronTrigger" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    settings jsonb NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "serverlessFunctionId" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: dataSource; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."dataSource" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    label character varying,
    url character varying,
    schema character varying,
    type core."dataSource_type_enum" DEFAULT 'postgres'::core."dataSource_type_enum" NOT NULL,
    "isRemote" boolean DEFAULT false NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: databaseEventTrigger; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."databaseEventTrigger" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    settings jsonb NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "serverlessFunctionId" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: emailingDomain; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."emailingDomain" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    domain character varying NOT NULL,
    driver core."emailingDomain_driver_enum" NOT NULL,
    status core."emailingDomain_status_enum" DEFAULT 'PENDING'::core."emailingDomain_status_enum" NOT NULL,
    "verificationRecords" jsonb,
    "verifiedAt" timestamp with time zone,
    "workspaceId" uuid NOT NULL
);


--
-- Name: featureFlag; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."featureFlag" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    key text NOT NULL,
    "workspaceId" uuid NOT NULL,
    value boolean NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: fieldMetadata; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."fieldMetadata" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "standardId" uuid,
    "objectMetadataId" uuid NOT NULL,
    type character varying NOT NULL,
    name character varying NOT NULL,
    label character varying NOT NULL,
    "defaultValue" jsonb,
    description text,
    icon character varying,
    "standardOverrides" jsonb,
    options jsonb,
    settings jsonb,
    "isCustom" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isUIReadOnly" boolean DEFAULT false NOT NULL,
    "isNullable" boolean DEFAULT true,
    "isUnique" boolean DEFAULT false,
    "workspaceId" uuid NOT NULL,
    "isLabelSyncedWithName" boolean DEFAULT false NOT NULL,
    "relationTargetFieldMetadataId" uuid,
    "relationTargetObjectMetadataId" uuid,
    "morphId" uuid,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    CONSTRAINT "CHK_FIELD_METADATA_MORPH_RELATION_REQUIRES_MORPH_ID" CHECK ((((type)::text <> 'MORPH_RELATION'::text) OR (((type)::text = 'MORPH_RELATION'::text) AND ("morphId" IS NOT NULL))))
);


--
-- Name: fieldPermission; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."fieldPermission" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "roleId" uuid NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    "canReadFieldValue" boolean,
    "canUpdateFieldValue" boolean,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: file; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.file (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    size bigint NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "applicationId" uuid,
    path character varying NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "isStaticAsset" boolean DEFAULT false NOT NULL
);


--
-- Name: frontComponent; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."frontComponent" (
    "workspaceId" uuid NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: indexFieldMetadata; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."indexFieldMetadata" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "indexMetadataId" uuid NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    "order" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: indexMetadata; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."indexMetadata" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    name character varying NOT NULL,
    "workspaceId" uuid NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    "isCustom" boolean DEFAULT false NOT NULL,
    "isUnique" boolean DEFAULT false NOT NULL,
    "indexWhereClause" text,
    "indexType" core."indexMetadata_indextype_enum" DEFAULT 'BTREE'::core."indexMetadata_indextype_enum" NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: keyValuePair; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."keyValuePair" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    "workspaceId" uuid,
    key text NOT NULL,
    value jsonb,
    "textValueDeprecated" text,
    type core."keyValuePair_type_enum" DEFAULT 'USER_VARIABLE'::core."keyValuePair_type_enum" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: navigationMenuItem; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."navigationMenuItem" (
    "workspaceId" uuid NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userWorkspaceId" uuid,
    "targetRecordId" uuid,
    "targetObjectMetadataId" uuid,
    "viewId" uuid,
    name text,
    "folderId" uuid,
    "position" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CHK_navigation_menu_item_target_fields" CHECK (((("targetRecordId" IS NULL) AND ("targetObjectMetadataId" IS NULL)) OR (("targetRecordId" IS NOT NULL) AND ("targetObjectMetadataId" IS NOT NULL))))
);


--
-- Name: objectMetadata; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."objectMetadata" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "standardId" uuid,
    "dataSourceId" uuid NOT NULL,
    "nameSingular" character varying NOT NULL,
    "namePlural" character varying NOT NULL,
    "labelSingular" character varying NOT NULL,
    "labelPlural" character varying NOT NULL,
    description text,
    icon character varying,
    "standardOverrides" jsonb,
    "targetTableName" character varying NOT NULL,
    "isCustom" boolean DEFAULT false NOT NULL,
    "isRemote" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isUIReadOnly" boolean DEFAULT false NOT NULL,
    "isAuditLogged" boolean DEFAULT true NOT NULL,
    "isSearchable" boolean DEFAULT false NOT NULL,
    "duplicateCriteria" jsonb,
    shortcut character varying,
    "labelIdentifierFieldMetadataId" uuid,
    "imageIdentifierFieldMetadataId" uuid,
    "isLabelSyncedWithName" boolean DEFAULT false NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "applicationId" uuid NOT NULL,
    "universalIdentifier" uuid NOT NULL
);


--
-- Name: objectPermission; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."objectPermission" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "roleId" uuid NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    "canReadObjectRecords" boolean,
    "canUpdateObjectRecords" boolean,
    "canSoftDeleteObjectRecords" boolean,
    "canDestroyObjectRecords" boolean,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: pageLayout; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."pageLayout" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    "workspaceId" uuid NOT NULL,
    type core."pageLayout_type_enum" DEFAULT 'RECORD_PAGE'::core."pageLayout_type_enum" NOT NULL,
    "objectMetadataId" uuid,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: pageLayoutTab; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."pageLayoutTab" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    title character varying NOT NULL,
    "workspaceId" uuid NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "pageLayoutId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: pageLayoutWidget; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."pageLayoutWidget" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "pageLayoutTabId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    title character varying NOT NULL,
    type core."pageLayoutWidget_type_enum" DEFAULT 'VIEW'::core."pageLayoutWidget_type_enum" NOT NULL,
    "objectMetadataId" uuid,
    "gridPosition" jsonb NOT NULL,
    configuration jsonb NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL
);


--
-- Name: permissionFlag; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."permissionFlag" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "roleId" uuid NOT NULL,
    flag character varying NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: postgresCredentials; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."postgresCredentials" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "user" character varying NOT NULL,
    "passwordHash" character varying NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "workspaceId" uuid NOT NULL
);


--
-- Name: publicDomain; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."publicDomain" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    domain character varying NOT NULL,
    "isValidated" boolean DEFAULT false NOT NULL,
    "workspaceId" uuid NOT NULL
);


--
-- Name: role; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.role (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "standardId" uuid,
    label character varying NOT NULL,
    "canUpdateAllSettings" boolean DEFAULT false NOT NULL,
    "canAccessAllTools" boolean DEFAULT false NOT NULL,
    "canReadAllObjectRecords" boolean DEFAULT false NOT NULL,
    "canUpdateAllObjectRecords" boolean DEFAULT false NOT NULL,
    "canSoftDeleteAllObjectRecords" boolean DEFAULT false NOT NULL,
    "canDestroyAllObjectRecords" boolean DEFAULT false NOT NULL,
    description text,
    icon character varying,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "isEditable" boolean DEFAULT true NOT NULL,
    "canBeAssignedToUsers" boolean DEFAULT true NOT NULL,
    "canBeAssignedToAgents" boolean DEFAULT true NOT NULL,
    "canBeAssignedToApiKeys" boolean DEFAULT true NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    "canReadOwnObjectRecordsOnly" boolean DEFAULT false NOT NULL
);


--
-- Name: roleTarget; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."roleTarget" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "workspaceId" uuid NOT NULL,
    "roleId" uuid NOT NULL,
    "userWorkspaceId" uuid,
    "agentId" uuid,
    "apiKeyId" uuid,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    CONSTRAINT "CHK_role_target_single_entity" CHECK (((("agentId" IS NOT NULL) AND ("userWorkspaceId" IS NULL) AND ("apiKeyId" IS NULL)) OR (("agentId" IS NULL) AND ("userWorkspaceId" IS NOT NULL) AND ("apiKeyId" IS NULL)) OR (("agentId" IS NULL) AND ("userWorkspaceId" IS NULL) AND ("apiKeyId" IS NOT NULL))))
);


--
-- Name: routeTrigger; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."routeTrigger" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    path character varying NOT NULL,
    "isAuthRequired" boolean DEFAULT true NOT NULL,
    "httpMethod" core."routeTrigger_httpmethod_enum" DEFAULT 'GET'::core."routeTrigger_httpmethod_enum" NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "serverlessFunctionId" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    "forwardedRequestHeaders" jsonb DEFAULT '[]'::jsonb NOT NULL
);


--
-- Name: rowLevelPermissionPredicate; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."rowLevelPermissionPredicate" (
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    operand core."rowLevelPermissionPredicate_operand_enum" DEFAULT 'CONTAINS'::core."rowLevelPermissionPredicate_operand_enum" NOT NULL,
    value jsonb,
    "subFieldName" text,
    "workspaceMemberFieldMetadataId" uuid,
    "workspaceMemberSubFieldName" text,
    "rowLevelPermissionPredicateGroupId" uuid,
    "positionInRowLevelPermissionPredicateGroup" double precision,
    "workspaceId" uuid NOT NULL,
    "roleId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: rowLevelPermissionPredicateGroup; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."rowLevelPermissionPredicateGroup" (
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "parentRowLevelPermissionPredicateGroupId" uuid,
    "logicalOperator" core."rowLevelPermissionPredicateGroup_logicaloperator_enum" DEFAULT 'AND'::core."rowLevelPermissionPredicateGroup_logicaloperator_enum" NOT NULL,
    "positionInRowLevelPermissionPredicateGroup" double precision,
    "workspaceId" uuid NOT NULL,
    "roleId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "objectMetadataId" uuid NOT NULL
);


--
-- Name: searchFieldMetadata; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."searchFieldMetadata" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "workspaceId" uuid NOT NULL
);


--
-- Name: serverlessFunction; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."serverlessFunction" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    description character varying,
    "latestVersion" character varying,
    "publishedVersions" jsonb DEFAULT '[]'::jsonb NOT NULL,
    runtime character varying DEFAULT 'nodejs22.x'::character varying NOT NULL,
    "timeoutSeconds" integer DEFAULT 300 NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    checksum text,
    "serverlessFunctionLayerId" uuid NOT NULL,
    "sourceHandlerPath" character varying DEFAULT 'src/index.ts'::character varying NOT NULL,
    "handlerName" character varying DEFAULT 'main'::character varying NOT NULL,
    "toolInputSchema" jsonb,
    "isTool" boolean DEFAULT false NOT NULL,
    "builtHandlerPath" character varying DEFAULT 'index.mjs'::character varying NOT NULL,
    CONSTRAINT "CHK_4a5179975ee017934a91703247" CHECK ((("timeoutSeconds" >= 1) AND ("timeoutSeconds" <= 900)))
);


--
-- Name: serverlessFunctionLayer; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."serverlessFunctionLayer" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "packageJson" jsonb NOT NULL,
    "yarnLock" text NOT NULL,
    checksum text NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: skill; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.skill (
    "universalIdentifier" uuid NOT NULL,
    "applicationId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "standardId" uuid,
    name character varying NOT NULL,
    label character varying NOT NULL,
    icon character varying,
    description text,
    content text NOT NULL,
    "isCustom" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: twoFactorAuthenticationMethod; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."twoFactorAuthenticationMethod" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userWorkspaceId" uuid NOT NULL,
    secret text NOT NULL,
    status core."twoFactorAuthenticationMethod_status_enum" NOT NULL,
    strategy core."twoFactorAuthenticationMethod_strategy_enum" NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: user; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."user" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "firstName" character varying DEFAULT ''::character varying NOT NULL,
    "lastName" character varying DEFAULT ''::character varying NOT NULL,
    email character varying NOT NULL,
    "defaultAvatarUrl" character varying,
    "isEmailVerified" boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    "passwordHash" character varying,
    "canImpersonate" boolean DEFAULT false NOT NULL,
    "canAccessFullAdminPanel" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    locale character varying DEFAULT 'en'::character varying NOT NULL
);


--
-- Name: userWorkspace; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."userWorkspace" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "defaultAvatarUrl" character varying,
    locale character varying DEFAULT 'en'::character varying NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: view; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.view (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    "objectMetadataId" uuid NOT NULL,
    type core.view_type_enum DEFAULT 'TABLE'::core.view_type_enum NOT NULL,
    key core.view_key_enum,
    icon text NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "isCompact" boolean DEFAULT false NOT NULL,
    "isCustom" boolean DEFAULT false NOT NULL,
    "openRecordIn" core.view_openrecordin_enum DEFAULT 'SIDE_PANEL'::core.view_openrecordin_enum NOT NULL,
    "kanbanAggregateOperation" core.view_kanbanaggregateoperation_enum,
    "kanbanAggregateOperationFieldMetadataId" uuid,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "anyFieldFilterValue" text,
    "calendarLayout" core.view_calendarlayout_enum,
    "calendarFieldMetadataId" uuid,
    "applicationId" uuid NOT NULL,
    visibility core.view_visibility_enum DEFAULT 'WORKSPACE'::core.view_visibility_enum NOT NULL,
    "createdByUserWorkspaceId" uuid,
    "mainGroupByFieldMetadataId" uuid,
    "shouldHideEmptyGroups" boolean DEFAULT false NOT NULL,
    CONSTRAINT "CHK_VIEW_CALENDAR_INTEGRITY" CHECK (((type <> 'CALENDAR'::core.view_type_enum) OR (("calendarLayout" IS NOT NULL) AND ("calendarFieldMetadataId" IS NOT NULL))))
);


--
-- Name: viewField; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."viewField" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    "isVisible" boolean DEFAULT true NOT NULL,
    size integer DEFAULT 0 NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "aggregateOperation" core."viewField_aggregateoperation_enum",
    "viewId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL
);


--
-- Name: viewFilter; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."viewFilter" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    operand core."viewFilter_operand_enum" DEFAULT 'CONTAINS'::core."viewFilter_operand_enum" NOT NULL,
    value jsonb NOT NULL,
    "viewFilterGroupId" uuid,
    "positionInViewFilterGroup" double precision,
    "subFieldName" text,
    "viewId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL
);


--
-- Name: viewFilterGroup; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."viewFilterGroup" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "parentViewFilterGroupId" uuid,
    "logicalOperator" core."viewFilterGroup_logicaloperator_enum" DEFAULT 'AND'::core."viewFilterGroup_logicaloperator_enum" NOT NULL,
    "positionInViewFilterGroup" double precision,
    "viewId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL
);


--
-- Name: viewGroup; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."viewGroup" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "isVisible" boolean DEFAULT true NOT NULL,
    "fieldValue" text NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "viewId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL
);


--
-- Name: viewSort; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."viewSort" (
    "universalIdentifier" uuid NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "fieldMetadataId" uuid NOT NULL,
    direction core."viewSort_direction_enum" DEFAULT 'ASC'::core."viewSort_direction_enum" NOT NULL,
    "viewId" uuid NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "applicationId" uuid NOT NULL
);


--
-- Name: webhook; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.webhook (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "targetUrl" character varying NOT NULL,
    operations text[] DEFAULT '{*.*}'::text[] NOT NULL,
    description character varying,
    secret character varying NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: workspace; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.workspace (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "displayName" character varying,
    logo character varying,
    "inviteHash" character varying,
    "deletedAt" timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "allowImpersonation" boolean DEFAULT true NOT NULL,
    "isPublicInviteLinkEnabled" boolean DEFAULT true NOT NULL,
    "activationStatus" core."workspace_activationStatus_enum" DEFAULT 'INACTIVE'::core."workspace_activationStatus_enum" NOT NULL,
    "metadataVersion" integer DEFAULT 1 NOT NULL,
    "databaseUrl" character varying DEFAULT ''::character varying NOT NULL,
    "databaseSchema" character varying DEFAULT ''::character varying NOT NULL,
    subdomain character varying NOT NULL,
    "customDomain" character varying,
    "isGoogleAuthEnabled" boolean DEFAULT true NOT NULL,
    "isTwoFactorAuthenticationEnforced" boolean DEFAULT false NOT NULL,
    "isPasswordAuthEnabled" boolean DEFAULT true NOT NULL,
    "isMicrosoftAuthEnabled" boolean DEFAULT true NOT NULL,
    "isCustomDomainEnabled" boolean DEFAULT false NOT NULL,
    "defaultRoleId" uuid,
    version character varying,
    "trashRetentionDays" integer DEFAULT 14 NOT NULL,
    "routerModel" character varying DEFAULT 'auto'::character varying NOT NULL,
    "isGoogleAuthBypassEnabled" boolean DEFAULT false NOT NULL,
    "isPasswordAuthBypassEnabled" boolean DEFAULT false NOT NULL,
    "isMicrosoftAuthBypassEnabled" boolean DEFAULT false NOT NULL,
    "workspaceCustomApplicationId" uuid NOT NULL,
    "editableProfileFields" character varying[] DEFAULT '{email,profilePicture,firstName,lastName}'::character varying[],
    "fastModel" character varying DEFAULT 'default-fast-model'::character varying NOT NULL,
    "smartModel" character varying DEFAULT 'default-smart-model'::character varying NOT NULL,
    CONSTRAINT onboarded_workspace_requires_default_role CHECK ((("activationStatus" = ANY (ARRAY['PENDING_CREATION'::core."workspace_activationStatus_enum", 'ONGOING_CREATION'::core."workspace_activationStatus_enum"])) OR ("defaultRoleId" IS NOT NULL)))
);


--
-- Name: workspaceSSOIdentityProvider; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."workspaceSSOIdentityProvider" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    status core."workspaceSSOIdentityProvider_status_enum" DEFAULT 'Active'::core."workspaceSSOIdentityProvider_status_enum" NOT NULL,
    "workspaceId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    type core."workspaceSSOIdentityProvider_type_enum" DEFAULT 'OIDC'::core."workspaceSSOIdentityProvider_type_enum" NOT NULL,
    issuer character varying NOT NULL,
    "clientID" character varying,
    "clientSecret" character varying,
    "ssoURL" character varying,
    certificate character varying,
    fingerprint character varying
);


--
-- Name: _customer; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_updatedBySource_enum" NOT NULL,
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT ''::text NOT NULL,
    "updatedByContext" jsonb,
    "deletedAt" timestamp with time zone,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_customer_createdBySource_enum" NOT NULL,
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT ''::text NOT NULL,
    "createdByContext" jsonb,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "emailsPrimaryEmail" text,
    "emailsAdditionalEmails" jsonb,
    "phonesPrimaryPhoneNumber" text DEFAULT ''::text,
    "phonesPrimaryPhoneCountryCode" text DEFAULT ''::text,
    "phonesPrimaryPhoneCallingCode" text DEFAULT ''::text,
    "phonesAdditionalPhones" jsonb,
    "whatsappPrimaryPhoneNumber" text DEFAULT ''::text,
    "whatsappPrimaryPhoneCountryCode" text DEFAULT ''::text,
    "whatsappPrimaryPhoneCallingCode" text DEFAULT ''::text,
    "whatsappAdditionalPhones" jsonb,
    "companyName" text,
    "jobTitle" text
);


--
-- Name: _lead; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_updatedBySource_enum" NOT NULL,
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT ''::text NOT NULL,
    "updatedByContext" jsonb,
    "deletedAt" timestamp with time zone,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_createdBySource_enum" NOT NULL,
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT ''::text NOT NULL,
    "createdByContext" jsonb,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "originId" uuid,
    "propertyId" uuid,
    "assigneeId" uuid,
    "dueDate" timestamp with time zone,
    "customerId" uuid,
    status workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead_status_enum,
    body text,
    "notesBlocknote" text,
    "notesMarkdown" text,
    "convenientTime" text,
    "buildingType" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_lead_buildingType_enum"[],
    "readAt" timestamp with time zone
);


--
-- Name: _origin; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_updatedBySource_enum" NOT NULL,
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT ''::text NOT NULL,
    "updatedByContext" jsonb,
    "deletedAt" timestamp with time zone,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_origin_createdBySource_enum" NOT NULL,
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT ''::text NOT NULL,
    "createdByContext" jsonb,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED
);


--
-- Name: _property; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis._property (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT ''::text,
    "updatedByContext" jsonb,
    "deletedAt" timestamp with time zone,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."_property_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT ''::text,
    "createdByContext" jsonb,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "locationAddressStreet1" text DEFAULT ''::text,
    "locationAddressStreet2" text,
    "locationAddressCity" text,
    "locationAddressPostcode" text,
    "locationAddressState" text,
    "locationAddressCountry" text DEFAULT 'India'::text,
    "locationAddressLat" numeric,
    "locationAddressLng" numeric
);


--
-- Name: attachment; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "fullPath" text,
    "fileCategory" workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_fileCategory_enum" DEFAULT 'OTHER'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_fileCategory_enum" NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."attachment_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "taskId" uuid,
    "noteId" uuid,
    "personId" uuid,
    "companyId" uuid,
    "opportunityId" uuid,
    "dashboardId" uuid,
    "workflowId" uuid,
    "propertyId" uuid,
    "originId" uuid,
    "leadId" uuid,
    "customerId" uuid
);


--
-- Name: blocklist; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.blocklist (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    handle text,
    "workspaceMemberId" uuid
);


--
-- Name: calendarChannel; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    handle text,
    visibility workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_visibility_enum" DEFAULT 'SHARE_EVERYTHING'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_visibility_enum" NOT NULL,
    "isContactAutoCreationEnabled" boolean DEFAULT true NOT NULL,
    "contactAutoCreationPolicy" workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_contactAutoCreationPolicy_enum" DEFAULT 'AS_PARTICIPANT_AND_ORGANIZER'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_contactAutoCreationPolicy_enum" NOT NULL,
    "isSyncEnabled" boolean DEFAULT true NOT NULL,
    "syncCursor" text,
    "syncStatus" workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_syncStatus_enum",
    "syncStage" workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_syncStage_enum" DEFAULT 'PENDING_CONFIGURATION'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel_syncStage_enum" NOT NULL,
    "syncStageStartedAt" timestamp with time zone,
    "syncedAt" timestamp with time zone,
    "throttleFailureCount" double precision DEFAULT '0'::double precision NOT NULL,
    "connectedAccountId" uuid
);


--
-- Name: calendarChannelEventAssociation; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "eventExternalId" text,
    "recurringEventExternalId" text,
    "calendarChannelId" uuid,
    "calendarEventId" uuid
);


--
-- Name: calendarEvent; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEvent" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    title text,
    "isCanceled" boolean DEFAULT false NOT NULL,
    "isFullDay" boolean DEFAULT false NOT NULL,
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "externalCreatedAt" timestamp with time zone,
    "externalUpdatedAt" timestamp with time zone,
    description text,
    location text,
    "iCalUid" text,
    "conferenceSolution" text,
    "conferenceLinkPrimaryLinkLabel" text,
    "conferenceLinkPrimaryLinkUrl" text,
    "conferenceLinkSecondaryLinks" jsonb
);


--
-- Name: calendarEventParticipant; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    handle text,
    "displayName" text,
    "isOrganizer" boolean DEFAULT false NOT NULL,
    "responseStatus" workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant_responseStatus_enum" DEFAULT 'NEEDS_ACTION'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant_responseStatus_enum" NOT NULL,
    "calendarEventId" uuid,
    "personId" uuid,
    "workspaceMemberId" uuid
);


--
-- Name: company; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.company (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "domainNamePrimaryLinkLabel" text,
    "domainNamePrimaryLinkUrl" text,
    "domainNameSecondaryLinks" jsonb,
    "addressAddressStreet1" text,
    "addressAddressStreet2" text,
    "addressAddressCity" text,
    "addressAddressPostcode" text,
    "addressAddressState" text,
    "addressAddressCountry" text,
    "addressAddressLat" numeric,
    "addressAddressLng" numeric,
    employees double precision,
    "linkedinLinkPrimaryLinkLabel" text,
    "linkedinLinkPrimaryLinkUrl" text,
    "linkedinLinkSecondaryLinks" jsonb,
    "xLinkPrimaryLinkLabel" text,
    "xLinkPrimaryLinkUrl" text,
    "xLinkSecondaryLinks" jsonb,
    "annualRecurringRevenueAmountMicros" numeric,
    "annualRecurringRevenueCurrencyCode" text,
    "idealCustomerProfile" boolean DEFAULT false NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."company_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, ((((((COALESCE(public.unaccent_immutable(name), ''::text) || ' '::text) || COALESCE(public.unaccent_immutable("domainNamePrimaryLinkLabel"), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable("domainNamePrimaryLinkUrl"), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable(translate(regexp_replace(("domainNameSecondaryLinks")::text, '"(label|url)"\s*:\s*'::text, ''::text, 'g'::text), '[]{}",:'::text, '        '::text)), ''::text)))) STORED,
    "accountOwnerId" uuid
);


--
-- Name: connectedAccount; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    handle text,
    provider text DEFAULT 'google'::text NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "lastSyncHistoryId" text,
    "authFailedAt" timestamp with time zone,
    "lastCredentialsRefreshedAt" timestamp with time zone,
    "handleAliases" text,
    scopes text[],
    "connectionParameters" jsonb,
    "accountOwnerId" uuid
);


--
-- Name: dashboard; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    title text,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "pageLayoutId" uuid,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."dashboard_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(title), ''::text))) STORED
);


--
-- Name: favorite; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "viewId" uuid,
    "forWorkspaceMemberId" uuid,
    "personId" uuid,
    "companyId" uuid,
    "opportunityId" uuid,
    "workflowId" uuid,
    "workflowVersionId" uuid,
    "workflowRunId" uuid,
    "taskId" uuid,
    "noteId" uuid,
    "dashboardId" uuid,
    "favoriteFolderId" uuid,
    "propertyId" uuid,
    "originId" uuid,
    "leadId" uuid,
    "customerId" uuid
);


--
-- Name: favoriteFolder; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."favoriteFolder" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    name text
);


--
-- Name: message; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.message (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "headerMessageId" text,
    direction workspace_9zs4rq4zo2wzg53xjkq5u4qis.message_direction_enum DEFAULT 'INCOMING'::workspace_9zs4rq4zo2wzg53xjkq5u4qis.message_direction_enum NOT NULL,
    subject text,
    text text,
    "receivedAt" timestamp with time zone,
    "messageThreadId" uuid
);


--
-- Name: messageChannel; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    visibility workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_visibility_enum" DEFAULT 'SHARE_EVERYTHING'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_visibility_enum" NOT NULL,
    handle text,
    type workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_type_enum" DEFAULT 'EMAIL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_type_enum" NOT NULL,
    "isContactAutoCreationEnabled" boolean DEFAULT true NOT NULL,
    "contactAutoCreationPolicy" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_contactAutoCreationPolicy_enum" DEFAULT 'SENT'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_contactAutoCreationPolicy_enum" NOT NULL,
    "messageFolderImportPolicy" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_messageFolderImportPolicy_enum" DEFAULT 'ALL_FOLDERS'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_messageFolderImportPolicy_enum" NOT NULL,
    "excludeNonProfessionalEmails" boolean DEFAULT true NOT NULL,
    "excludeGroupEmails" boolean DEFAULT true NOT NULL,
    "pendingGroupEmailsAction" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_pendingGroupEmailsAction_enum" DEFAULT 'NONE'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_pendingGroupEmailsAction_enum" NOT NULL,
    "isSyncEnabled" boolean DEFAULT true NOT NULL,
    "syncCursor" text,
    "syncedAt" timestamp with time zone,
    "syncStatus" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_syncStatus_enum",
    "syncStage" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_syncStage_enum" DEFAULT 'PENDING_CONFIGURATION'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel_syncStage_enum" NOT NULL,
    "syncStageStartedAt" timestamp with time zone,
    "throttleFailureCount" double precision DEFAULT '0'::double precision NOT NULL,
    "connectedAccountId" uuid
);


--
-- Name: messageChannelMessageAssociation; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "messageExternalId" text,
    "messageThreadExternalId" text,
    direction workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation_direction_enum" DEFAULT 'INCOMING'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation_direction_enum" NOT NULL,
    "messageChannelId" uuid,
    "messageThreadId" uuid,
    "messageId" uuid
);


--
-- Name: messageFolder; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "syncCursor" text,
    "isSentFolder" boolean DEFAULT false NOT NULL,
    "isSynced" boolean DEFAULT false NOT NULL,
    "parentFolderId" text,
    "externalId" text,
    "pendingSyncAction" workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder_pendingSyncAction_enum" DEFAULT 'NONE'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder_pendingSyncAction_enum" NOT NULL,
    "messageChannelId" uuid
);


--
-- Name: messageParticipant; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    role workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant_role_enum" DEFAULT 'FROM'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant_role_enum" NOT NULL,
    handle text,
    "displayName" text,
    "messageId" uuid,
    "personId" uuid,
    "workspaceMemberId" uuid
);


--
-- Name: messageThread; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageThread" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


--
-- Name: note; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.note (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    title text,
    "bodyV2Blocknote" text,
    "bodyV2Markdown" text,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."note_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, ((COALESCE(public.unaccent_immutable(title), ''::text) || ' '::text) || COALESCE(public.unaccent_immutable("bodyV2Markdown"), ''::text)))) STORED
);


--
-- Name: noteTarget; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "noteId" uuid,
    "personId" uuid,
    "companyId" uuid,
    "opportunityId" uuid,
    "propertyId" uuid,
    "originId" uuid,
    "leadId" uuid,
    "customerId" uuid
);


--
-- Name: opportunity; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "amountAmountMicros" numeric,
    "amountCurrencyCode" text,
    "closeDate" timestamp with time zone,
    stage workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity_stage_enum DEFAULT 'NEW'::workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity_stage_enum NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."opportunity_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "pointOfContactId" uuid,
    "companyId" uuid,
    "ownerId" uuid
);


--
-- Name: person; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.person (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "nameFirstName" text,
    "nameLastName" text,
    "emailsPrimaryEmail" text,
    "emailsAdditionalEmails" jsonb,
    "linkedinLinkPrimaryLinkLabel" text,
    "linkedinLinkPrimaryLinkUrl" text,
    "linkedinLinkSecondaryLinks" jsonb,
    "xLinkPrimaryLinkLabel" text,
    "xLinkPrimaryLinkUrl" text,
    "xLinkSecondaryLinks" jsonb,
    "jobTitle" text,
    "phonesPrimaryPhoneNumber" text,
    "phonesPrimaryPhoneCountryCode" text,
    "phonesPrimaryPhoneCallingCode" text,
    "phonesAdditionalPhones" jsonb,
    city text,
    "avatarUrl" text,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."person_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, ((((((((((((((((((((((((COALESCE(public.unaccent_immutable("nameFirstName"), ''::text) || ' '::text) || COALESCE(public.unaccent_immutable("nameLastName"), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable("emailsPrimaryEmail"), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable(split_part("emailsPrimaryEmail", '@'::text, 2)), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable(translate(("emailsAdditionalEmails")::text, '[]",'::text, '    '::text)), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable(translate(replace(("emailsAdditionalEmails")::text, '@'::text, ' '::text), '[]",'::text, '    '::text)), ''::text)) || ' '::text) || COALESCE("phonesPrimaryPhoneNumber", ''::text)) || ' '::text) || COALESCE("phonesPrimaryPhoneCallingCode", ''::text)) || ' '::text) || COALESCE(("phonesPrimaryPhoneCallingCode" || "phonesPrimaryPhoneNumber"), ''::text)) || ' '::text) || COALESCE((replace("phonesPrimaryPhoneCallingCode", '+'::text, ''::text) || "phonesPrimaryPhoneNumber"), ''::text)) || ' '::text) || COALESCE(('0'::text || "phonesPrimaryPhoneNumber"), ''::text)) || ' '::text) || COALESCE(translate(regexp_replace(("phonesAdditionalPhones")::text, '"(number|countryCode|callingCode)"\s*:\s*'::text, ''::text, 'g'::text), '[]{}",:'::text, '        '::text), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable("jobTitle"), ''::text)))) STORED,
    "companyId" uuid
);


--
-- Name: task; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.task (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    title text,
    "bodyV2Blocknote" text,
    "bodyV2Markdown" text,
    "dueAt" timestamp with time zone,
    status workspace_9zs4rq4zo2wzg53xjkq5u4qis.task_status_enum DEFAULT 'TODO'::workspace_9zs4rq4zo2wzg53xjkq5u4qis.task_status_enum,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."task_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, ((COALESCE(public.unaccent_immutable(title), ''::text) || ' '::text) || COALESCE(public.unaccent_immutable("bodyV2Markdown"), ''::text)))) STORED,
    "assigneeId" uuid
);


--
-- Name: taskTarget; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "taskId" uuid,
    "personId" uuid,
    "companyId" uuid,
    "opportunityId" uuid,
    "propertyId" uuid,
    "originId" uuid,
    "leadId" uuid,
    "customerId" uuid
);


--
-- Name: timelineActivity; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "happensAt" timestamp with time zone DEFAULT now() NOT NULL,
    name text,
    properties jsonb,
    "linkedRecordCachedName" text,
    "linkedRecordId" uuid,
    "linkedObjectMetadataId" uuid,
    "workspaceMemberId" uuid,
    "targetPersonId" uuid,
    "targetCompanyId" uuid,
    "targetOpportunityId" uuid,
    "targetNoteId" uuid,
    "targetTaskId" uuid,
    "targetWorkflowId" uuid,
    "targetWorkflowVersionId" uuid,
    "targetWorkflowRunId" uuid,
    "targetDashboardId" uuid,
    "targetPropertyId" uuid,
    "targetOriginId" uuid,
    "targetLeadId" uuid,
    "targetCustomerId" uuid
);


--
-- Name: workflow; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "lastPublishedVersionId" text,
    statuses workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow_statuses_enum[],
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflow_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED
);


--
-- Name: workflowAutomatedTrigger; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    type workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger_type_enum" NOT NULL,
    settings jsonb NOT NULL,
    "workflowId" uuid
);


--
-- Name: workflowRun; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    "enqueuedAt" timestamp with time zone,
    "startedAt" timestamp with time zone,
    "endedAt" timestamp with time zone,
    status workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_status_enum" DEFAULT 'NOT_STARTED'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_status_enum" NOT NULL,
    "createdBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_createdBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_createdBySource_enum",
    "createdByWorkspaceMemberId" uuid,
    "createdByName" text DEFAULT 'System'::text,
    "createdByContext" jsonb,
    "updatedBySource" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_updatedBySource_enum" DEFAULT 'MANUAL'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun_updatedBySource_enum",
    "updatedByWorkspaceMemberId" uuid,
    "updatedByName" text DEFAULT 'System'::text,
    "updatedByContext" jsonb,
    state jsonb NOT NULL,
    context jsonb,
    output jsonb,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "workflowVersionId" uuid,
    "workflowId" uuid
);


--
-- Name: workflowVersion; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    name text,
    trigger jsonb,
    steps jsonb,
    status workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion_status_enum" DEFAULT 'DRAFT'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion_status_enum" NOT NULL,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, COALESCE(public.unaccent_immutable(name), ''::text))) STORED,
    "workflowId" uuid
);


--
-- Name: workspaceMember; Type: TABLE; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE TABLE workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone,
    "position" double precision DEFAULT '0'::double precision NOT NULL,
    "nameFirstName" text,
    "nameLastName" text,
    "colorScheme" text DEFAULT 'System'::text NOT NULL,
    locale text DEFAULT 'en'::text NOT NULL,
    "avatarUrl" text,
    "userEmail" text,
    "calendarStartDay" double precision DEFAULT '7'::double precision NOT NULL,
    "userId" uuid NOT NULL,
    "timeZone" text DEFAULT 'system'::text NOT NULL,
    "dateFormat" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_dateFormat_enum" DEFAULT 'SYSTEM'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_dateFormat_enum" NOT NULL,
    "timeFormat" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_timeFormat_enum" DEFAULT 'SYSTEM'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_timeFormat_enum" NOT NULL,
    "numberFormat" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_numberFormat_enum" DEFAULT 'SYSTEM'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_numberFormat_enum" NOT NULL,
    "availabilityStartTime" text DEFAULT '0000'::text NOT NULL,
    "availabilityEndTime" text DEFAULT '2400'::text NOT NULL,
    "availabilityHours" double precision,
    "availableDays" workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum"[] DEFAULT ARRAY['MONDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'TUESDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'WEDNESDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'THURSDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'FRIDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'SATURDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum", 'SUNDAY'::workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember_availableDays_enum"] NOT NULL,
    "leaveStartDate" timestamp with time zone,
    "leaveEndDate" timestamp with time zone,
    "searchVector" tsvector GENERATED ALWAYS AS (to_tsvector('simple'::regconfig, ((((COALESCE(public.unaccent_immutable("nameFirstName"), ''::text) || ' '::text) || COALESCE(public.unaccent_immutable("nameLastName"), ''::text)) || ' '::text) || COALESCE(public.unaccent_immutable("userEmail"), ''::text)))) STORED
);


--
-- Name: _typeorm_migrations id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core._typeorm_migrations ALTER COLUMN id SET DEFAULT nextval('core._typeorm_migrations_id_seq'::regclass);


--
-- Data for Name: _typeorm_generated_columns_and_materialized_views; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core._typeorm_generated_columns_and_materialized_views (type, database, schema, "table", name, value) FROM stdin;
\.


--
-- Data for Name: _typeorm_migrations; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core._typeorm_migrations (id, "timestamp", name) FROM stdin;
1	1700140427984	SetupMetadataTables1700140427984
2	1756976545860	UniqueFieldMetadataNameForWorkspaceObjectMetadata1756976545860
3	1757013851879	AddPublicDomainEntity1757013851879
4	1757491357122	AddApplicationEntityAndRelationships1757491357122
5	1757806282417	AddSearchFieldMetadataEntity1757806282417
6	1757809958470	AddWorkspaceForeignKeyToSearchFieldMetadata1757809958470
7	1757858496548	AddCalendarTypeToViewTable1757858496548
8	1757864696439	AddCalendarFieldMetadataIdToViewTable1757864696439
9	1757991657472	RemoveContentFromAgentChatMessage1757991657472
10	1758038863448	AddUniversalIdentifierToIndexMetadata1758038863448
11	1758117800000	ActivateUnaccentExtension1758117800000
12	1758388517321	CreateEmailingDomainEntity1758388517321
13	1758720905726	AddApplicationIdToObjectMetadata1758720905726
14	1758767315179	CreateAgentChatMessagePartTableAndRemoveRawContent1758767315179
15	1758793689363	AddUniversalIdentifierToServerlessFunction1758793689363
16	1758802648930	AddChecksumToServerlessFunction1758802648930
17	1759200603485	AddNativeCapabilitesToAgent1759200603485
18	1759236947406	UpdateServerlessFunctionLayerEntity1759236947406
19	1759341941773	RenameApplicationStandardIdToUniversalIdentifier1759341941773
20	1759378531410	RemoveMessageIdFromFileTable1759378531410
21	1759417994272	SetServerlessFunctionIdInTriggersNonNullable1759417994272
22	1759418198310	RenameRouteToRouteTrigger1759418198310
23	1759433496458	RenameApplicationColumn1759433496458
24	1759931071049	SetServerlessFunctionLayerNotNullable1759931071049
25	1760356369619	AddWorkspaceTrashRetention1760356369619
26	1760628085765	AddNewWidgetTypes1760628085765
27	1760640844181	AddApplicationVariableCoreEntity1760640844181
28	1760700501795	AddApplicationIdToSyncableEntities1760700501795
29	1760965667836	KanbanFieldMetadataIdentifierView1760965667836
30	1760985484643	AddRouterModelToWorkspace1760985484643
31	1760994964826	RemoveDefaultAgentAndThreadAgentId1760994964826
32	1761052489394	CalendarFieldMetadataRelation1761052489394
33	1761153071116	SetServerlessFunctionLayerIdNotNullable1761153071116
34	1761210191095	AddHandlerToServerlessFunction1761210191095
35	1761215000000	AddRichTextWidgetType1761215000000
36	1761574442000	AddWorkflowWidgetTypes1761574442000
37	1761651107128	AddSsoBypassFlag1761651107128
38	1761749599736	WorkspaceIdUuidNotNullable1761749599736
39	1762333916255	NullableApplicationServerlessFunctionLayer1762333916255
40	1762339932345	MakeApplicationWorkspaceFkDeferrable1762339932345
41	1762343994716	AddWorkspaceCustomApplicationIdColumn1762343994716
42	1762351626807	ViewVisibility1762351626807
43	1762437814771	WorkspaceCustomApplicationIdForeignKey1762437814771
44	1762884796640	EditableProfileFields1762884796640
45	1763622159656	UpdateAgentResponseFormat1763622159656
46	1763731277403	AddCanBeUninstalledColumnToApplication1763731277403
47	1763805513241	RemoveAgentHandoffTable1763805513241
48	1763896975223	SyncableRoleTarget1763896975223
49	1763977334519	WorkspaceCustomApplicationIdNonNullable1763977334519
50	1763997530458	AddFastAndSmartModelsToWorkspace1763997530458
51	1764066845539	CoreMigrationCheck1764066845539
52	1764081474225	AddAgentIdToAgentChatMessage1764081474225
53	1764100000000	RefactorAgentChatEntities1764100000000
54	1764200000000	AddAgentTurnEvaluation1764200000000
55	1764210000000	AddSystemRoleToAgentMessage1764210000000
56	1764220000000	AddEvaluationInputsToAgent1764220000000
57	1764329720503	UpdateRoleTargetsUniqueConstraint1764329720503
58	1764671363647	RenameRoleTargets1764671363647
59	1764672601466	ChangeAgentDescriptionToText1764672601466
60	1764680275312	AddMainGroupByFieldMetadataId1764680275312
61	1764700000000	AddUsageColumnsToAgentChatThread1764700000000
62	1764846384501	RenameRichTextToFieldRichTextAndAddStandaloneRichText1764846384501
63	1764923552610	AddApplicationRoleColumns1764923552610
64	1764949394792	AddApplicationIdAndUniversalIdentifierToPageLayouts1764949394792
65	1765153412696	AddViewShouldHideEmptyGroups1765153412696
66	1765200057592	AddApplicationIdAndUniversalIdentifierToPageLayouts1765200057592
67	1765206100942	UpdateRoleColumns1765206100942
68	1765499361805	AddRLS1765499361805
69	1765808791153	RemoveFieldMetadataIdInViewGroup1765808791153
70	1765970658815	AddFieldWidgetType1765970658815
71	1766069735219	CoreMigrationCheck1766069735219
72	1766077618558	RemoveCanBeAssignedToApplications1766077618558
73	1767002571103	AddWorkspaceForeignKeys1767002571103
74	1767003000000	AddSkillEntity1767003000000
75	1767100000000	MakeViewFilterGroupParentFkDeferrable1767100000000
76	1767200000000	FixDataSourceAndWorkspaceMigrationWorkspaceIdType1767200000000
77	1767277454048	MakeFieldMetadataUniversalIdentifierAndApplicationIdNotNullable1767277454048
78	1767364430164	AddToolSchemaToServerlessFunction1767364430164
79	1767812158000	RemoteRemoteTables1767812158000
80	1767876112877	RemoveWorkspaceMigration1767876112877
81	1767998263185	AddObjectMetadataIdToRowLevelPermissionPredicateGroup1767998263185
82	1768212224801	MakeObjectMetadataUniversalIdentifierAndApplicationIdNotNullable1768212224801
83	1768213174271	MakeViewUniversalIdentifierAndApplicationIdNotNullable1768213174271
84	1768213174272	MakeViewFieldUniversalIdentifierAndApplicationIdNotNullable1768213174272
85	1768213174273	MakeViewFilterUniversalIdentifierAndApplicationIdNotNullable1768213174273
86	1768213174274	MakeViewGroupUniversalIdentifierAndApplicationIdNotNullable1768213174274
87	1768213174274	MakeAgentUniversalIdentifierAndApplicationIdNotNullable1768213174274
88	1768213174275	MakeRoleUniversalIdentifierAndApplicationIdNotNullable1768213174275
89	1768399525609	AddForwardedRequestHeadersInRouteTriggers1768399525609
90	1768495429374	AddFrontComponent1768495429374
91	1768503887441	AddCommandMenuItemEntity1768503887441
92	1768572831179	UpdateFileTable1768572831179
93	1768750308557	ForeignKeyIndexStandardization1768750308557
94	1768807499350	AddNavigationMenuItemEntity1768807499350
95	1768830235328	MakeIndexMetadataUniversalIdentifierAndApplicationIdNotNullable1768830235328
96	1768916632478	MakeRemainingEntitiesUniversalIdentifierAndApplicationIdNotNullable1768916632478
97	1769016869438	AddBuiltHandlerPathToServerlessFunctions1769016869438
98	1769091641000	RenameHandlerPathToSourceHandlerPath1769091641000
99	1769500000000	AddCanReadOwnObjectRecordsOnlyToRole1769500000000
\.


--
-- Data for Name: agent; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.agent (id, "standardId", name, label, icon, description, prompt, "modelId", "responseFormat", "workspaceId", "isCustom", "createdAt", "updatedAt", "deletedAt", "applicationId", "modelConfiguration", "universalIdentifier", "evaluationInputs") FROM stdin;
dfd601c9-b802-4c3f-926d-d632daae9dca	20202020-0002-0001-0001-000000000004	helper	Helper	IconHelp	AI agent specialized in helping users learn how to use Twenty CRM	You are a Helper Agent for Twenty. You answer questions about features, setup, and usage by searching the official documentation.\n\nCore workflow:\n1. Use search_help_center tool to find relevant documentation\n2. If the first search doesn't yield complete results, try different search terms\n3. Synthesize information from multiple articles when needed\n4. Provide clear, step-by-step answers based on the documentation\n5. Be honest if the docs don't cover the topic\n\nWhen to search:\n- "How to" questions\n- Feature explanations\n- Setup and configuration help\n- Troubleshooting issues\n- Best practices\n\nResponse format:\n- Summarize key information from the documentation\n- Break down complex topics into clear steps\n- Include important notes or prerequisites\n- Use markdown for readability\n\nAlways base answers on official Twenty documentation. Be patient and helpful.	default-smart-model	{"type": "text"}	a8cf39ab-a363-48fd-8960-096055b51144	f	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	{}	20202020-0002-0001-0001-000000000004	{}
\.


--
-- Data for Name: agentChatThread; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."agentChatThread" (id, "userWorkspaceId", title, "createdAt", "updatedAt", "totalInputTokens", "totalOutputTokens", "contextWindowTokens", "totalInputCredits", "totalOutputCredits") FROM stdin;
\.


--
-- Data for Name: agentMessage; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."agentMessage" (id, "threadId", "turnId", "agentId", role, "createdAt") FROM stdin;
\.


--
-- Data for Name: agentMessagePart; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."agentMessagePart" (id, "messageId", "orderIndex", type, "textContent", "reasoningContent", "toolName", "toolCallId", "toolInput", "toolOutput", state, "errorMessage", "errorDetails", "sourceUrlSourceId", "sourceUrlUrl", "sourceUrlTitle", "sourceDocumentSourceId", "sourceDocumentMediaType", "sourceDocumentTitle", "sourceDocumentFilename", "fileMediaType", "fileFilename", "fileUrl", "providerMetadata", "createdAt") FROM stdin;
\.


--
-- Data for Name: agentTurn; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."agentTurn" (id, "threadId", "agentId", "createdAt") FROM stdin;
\.


--
-- Data for Name: agentTurnEvaluation; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."agentTurnEvaluation" (id, "turnId", score, comment, "createdAt") FROM stdin;
\.


--
-- Data for Name: apiKey; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."apiKey" (id, name, "expiresAt", "revokedAt", "workspaceId", "createdAt", "updatedAt") FROM stdin;
2e203bdb-a27d-4307-a071-457dec5f5908	Webhook API Key	2126-02-04 07:26:53.572+00	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 07:26:53.617656+00	2026-02-28 07:26:54.451895+00
\.


--
-- Data for Name: appToken; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."appToken" (id, "userId", "workspaceId", type, value, "expiresAt", "deletedAt", "revokedAt", "createdAt", "updatedAt", context) FROM stdin;
624f6e54-0984-4452-9904-56a05a3409b3	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:55:21.258+00	\N	2026-02-28 11:26:47.849+00	2026-02-28 10:55:21.257426+00	2026-02-28 11:26:47.849334+00	\N
795aa13c-e98e-47c1-8b0e-000f0a38406c	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 05:07:08.593+00	\N	2026-02-28 05:47:54.972+00	2026-02-28 05:07:08.592684+00	2026-02-28 05:47:54.972572+00	\N
49a67eb4-d28e-4afe-9ed9-e088e512b491	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 05:47:54.986+00	\N	\N	2026-02-28 05:47:54.986549+00	2026-02-28 05:47:54.986549+00	\N
1e25a15b-de4a-40c0-a861-75d6d186ad38	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 05:47:54.991+00	\N	\N	2026-02-28 05:47:54.990524+00	2026-02-28 05:47:54.990524+00	\N
f3db03e3-d76c-4ea6-b698-a80aba267ad7	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:06:59.114+00	\N	\N	2026-02-28 06:06:59.114072+00	2026-02-28 06:06:59.114072+00	\N
68c05db1-3aad-4ca8-9d15-2e14216482f7	80d538c7-4037-424f-bb74-c60da39e9b29	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:08:58.952+00	\N	\N	2026-02-28 06:08:58.951158+00	2026-02-28 06:08:58.951158+00	\N
aa63e9b0-61ad-4f26-8cd4-948724f8d6ca	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 05:47:55.009+00	\N	2026-02-28 06:18:03.21+00	2026-02-28 05:47:55.008529+00	2026-02-28 06:18:03.210653+00	\N
572f906e-9eee-49ce-8802-403c8b9ee53d	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:18:03.23+00	\N	2026-02-28 06:48:32.55+00	2026-02-28 06:18:03.228946+00	2026-02-28 06:48:32.551383+00	\N
a6e16f1a-2b88-4a5b-b37d-03ccfe4a81a1	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:23:02.296+00	\N	2026-02-28 06:53:47.863+00	2026-02-28 06:23:02.295973+00	2026-02-28 06:53:47.866961+00	\N
34f1b06b-3ed8-416d-933a-44ab628cd5a6	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:53:57.669+00	\N	2026-02-28 14:38:46.113+00	2026-02-28 13:53:57.669169+00	2026-02-28 14:38:46.11301+00	\N
83db5261-ef4c-4173-a31d-c3d38fbdd910	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:18:34.488+00	\N	2026-02-28 14:51:03.155+00	2026-02-28 14:18:34.487615+00	2026-02-28 14:51:03.1553+00	\N
63381c47-3916-477c-b6fb-e8dbcd9da2d6	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:48:32.618+00	\N	2026-02-28 07:19:49.708+00	2026-02-28 06:48:32.61949+00	2026-02-28 07:19:49.707142+00	\N
fb8a5737-9018-430f-9822-f7d3e0e441f1	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 07:19:49.738+00	\N	\N	2026-02-28 07:19:49.738611+00	2026-02-28 07:19:49.738611+00	\N
b413a616-b51f-4043-a047-8779c1fe06e3	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 07:19:49.74+00	\N	\N	2026-02-28 07:19:49.739348+00	2026-02-28 07:19:49.739348+00	\N
fa20d145-330f-4820-ac0a-cf8ebcc448ef	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 07:19:49.74+00	\N	2026-02-28 07:55:54.555+00	2026-02-28 07:19:49.739198+00	2026-02-28 07:55:54.556499+00	\N
3a82f1b0-013a-4bc7-827c-f0b57ebea0f2	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:51:26.95+00	\N	2026-02-28 11:52:43.537+00	2026-02-28 10:51:26.949432+00	2026-02-28 11:52:43.536743+00	\N
f38d2220-ad6f-4814-953b-c4ef0dfa72a4	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:52:43.535+00	\N	\N	2026-02-28 11:52:43.536195+00	2026-02-28 11:52:43.536195+00	\N
c3b8d950-c4f7-449c-be83-0dd3f2d8b922	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 07:55:54.573+00	\N	2026-02-28 08:39:27.574+00	2026-02-28 07:55:54.576121+00	2026-02-28 08:39:27.573002+00	\N
0a8d3228-1720-4722-bcb6-408c5b7586fe	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 08:39:27.676+00	\N	\N	2026-02-28 08:39:27.675193+00	2026-02-28 08:39:27.675193+00	\N
52271363-d79c-45a5-b2ec-1151107abea0	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 08:39:27.674+00	\N	\N	2026-02-28 08:39:27.674821+00	2026-02-28 08:39:27.674821+00	\N
f77dde6d-256a-4c56-94d0-dff85cb243bb	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 08:39:27.676+00	\N	2026-02-28 09:12:50.358+00	2026-02-28 08:39:27.675282+00	2026-02-28 09:12:50.359477+00	\N
1c61ae97-346a-4a3b-b455-e1bc26d665bb	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 09:12:50.378+00	\N	2026-02-28 09:51:17.796+00	2026-02-28 09:12:50.379231+00	2026-02-28 09:51:17.79657+00	\N
a636128b-959f-41fb-a02c-a7b4d5ace500	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:52:43.545+00	\N	\N	2026-02-28 11:52:43.544626+00	2026-02-28 11:52:43.544626+00	\N
38520b3b-aabc-446e-b764-d75c4dd09fc0	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:24:56.509+00	\N	\N	2026-02-28 10:24:56.511063+00	2026-02-28 10:24:56.511063+00	\N
88da5bb6-187e-4257-97e8-4ef289bd2fda	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:24:56.517+00	\N	\N	2026-02-28 10:24:56.517078+00	2026-02-28 10:24:56.517078+00	\N
380e3aa1-135a-42d0-b4e6-ae065207f4af	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 09:51:17.813+00	\N	2026-02-28 10:24:56.528+00	2026-02-28 09:51:17.815156+00	2026-02-28 10:24:56.52796+00	\N
2fb24a63-5df7-46ca-aedc-d6df5d71438c	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:10:07.271+00	\N	2026-02-28 13:48:17.809+00	2026-02-28 13:10:07.271168+00	2026-02-28 13:48:17.808347+00	\N
3ac0e56a-949b-43ab-8593-acaeee2040fb	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.844+00	\N	\N	2026-02-28 13:48:17.844021+00	2026-02-28 13:48:17.844021+00	\N
fa0fbea3-3393-43c8-881f-6532b082b59a	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:51:26.913+00	\N	\N	2026-02-28 10:51:26.912497+00	2026-02-28 10:51:26.912497+00	\N
0dc03e53-aa2d-466a-9535-bc1d84a518fc	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:51:26.911+00	\N	\N	2026-02-28 10:51:26.912183+00	2026-02-28 10:51:26.912183+00	\N
3e66b0cc-1b21-4a1f-a02a-c38bd7d3218d	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 06:53:47.879+00	\N	2026-02-28 10:51:26.946+00	2026-02-28 06:53:47.879467+00	2026-02-28 10:51:26.94546+00	\N
2af14713-2ab2-4b2c-8e8e-de983c951940	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:26:47.862+00	\N	2026-02-28 12:29:16.354+00	2026-02-28 11:26:47.862553+00	2026-02-28 12:29:16.351579+00	\N
fd04fbc6-4331-4d4d-a083-14c57678a263	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:16.408+00	\N	\N	2026-02-28 12:29:16.405456+00	2026-02-28 12:29:16.405456+00	\N
f3cd0af9-f1ea-436f-aca0-de9141418303	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:24:56.537+00	\N	2026-02-28 10:55:21.252+00	2026-02-28 10:24:56.537295+00	2026-02-28 10:55:21.251707+00	\N
da796c27-a3e0-44a7-ac58-3ccd19f20734	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:55:21.254+00	\N	\N	2026-02-28 10:55:21.254+00	2026-02-28 10:55:21.254+00	\N
54e7690c-2f2d-41be-85cb-1ce6b895e755	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 10:55:21.257+00	\N	\N	2026-02-28 10:55:21.256403+00	2026-02-28 10:55:21.256403+00	\N
8164dcf0-15de-42cc-81d5-ac3737ad8b6d	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.837+00	\N	\N	2026-02-28 13:48:17.8405+00	2026-02-28 13:48:17.8405+00	\N
06f9486a-6143-432e-8483-61497dbc6d95	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:26:47.771+00	\N	\N	2026-02-28 11:26:47.77307+00	2026-02-28 11:26:47.77307+00	\N
3fb363a0-6bba-456e-9987-dd3eb585fe60	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:26:47.777+00	\N	\N	2026-02-28 11:26:47.776658+00	2026-02-28 11:26:47.776658+00	\N
e006693a-ecdd-4041-93ad-362c7583e7bc	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:16.407+00	\N	\N	2026-02-28 12:29:16.405149+00	2026-02-28 12:29:16.405149+00	\N
d467a4cb-757d-453a-bb81-7fbf9c1c69cc	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.843+00	\N	\N	2026-02-28 13:48:17.842377+00	2026-02-28 13:48:17.842377+00	\N
cada612e-64b6-4434-9e14-306b6ec96d0e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:54.92+00	\N	\N	2026-02-28 12:29:54.920526+00	2026-02-28 12:29:54.920526+00	\N
823f5255-560a-41e0-b45d-7f1053e9cde4	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:54.952+00	\N	\N	2026-02-28 12:29:54.954037+00	2026-02-28 12:29:54.954037+00	\N
f89a5045-d56c-4530-ae14-e95f82eeff84	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 11:52:43.547+00	\N	2026-02-28 12:29:55.057+00	2026-02-28 11:52:43.546605+00	2026-02-28 12:29:55.056988+00	\N
8f79ba33-a37d-484d-bea9-9a48de2ac222	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.851+00	\N	\N	2026-02-28 13:48:17.850695+00	2026-02-28 13:48:17.850695+00	\N
1073064a-f47e-4301-a97a-24e9209d9227	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:16.405+00	\N	2026-02-28 13:10:07.221+00	2026-02-28 12:29:16.404538+00	2026-02-28 13:10:07.222251+00	\N
fbeef931-94a2-455b-b91c-0d519a1d75ba	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:10:07.257+00	\N	\N	2026-02-28 13:10:07.260223+00	2026-02-28 13:10:07.260223+00	\N
bca5f8ce-c2fd-4844-a18e-7cb80b097f1a	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.845+00	\N	\N	2026-02-28 13:48:17.844726+00	2026-02-28 13:48:17.844726+00	\N
17cea150-880e-40c8-bf99-83c903551f13	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:17.851+00	\N	2026-02-28 13:48:18.068+00	2026-02-28 13:48:17.851262+00	2026-02-28 13:48:18.068169+00	\N
cf024f62-be69-4db0-b171-3924b02bd9d4	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:18:34.381+00	\N	\N	2026-02-28 14:18:34.382059+00	2026-02-28 14:18:34.382059+00	\N
c268bf7f-f970-4cf2-94cf-c1b6240e2883	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:18:34.389+00	\N	\N	2026-02-28 14:18:34.388158+00	2026-02-28 14:18:34.388158+00	\N
85943938-940e-4519-90f2-a1beb0c866b9	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:48:18.074+00	\N	2026-02-28 14:18:34.483+00	2026-02-28 13:48:18.073901+00	2026-02-28 14:18:34.482279+00	\N
f508f534-eb75-41c4-a95e-3af0e7ec2908	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:53:57.59+00	\N	\N	2026-02-28 13:53:57.589412+00	2026-02-28 13:53:57.589412+00	\N
ba381b0f-4923-4d76-b085-aff3eb413750	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 13:53:57.587+00	\N	\N	2026-02-28 13:53:57.58898+00	2026-02-28 13:53:57.58898+00	\N
19e112f3-0931-4c74-ae60-74f28e0866c0	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 12:29:55.062+00	\N	2026-02-28 13:53:57.664+00	2026-02-28 12:29:55.061615+00	2026-02-28 13:53:57.664143+00	\N
c70213c3-5f59-455a-8cda-55ca62217c7e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:38:46.065+00	\N	\N	2026-02-28 14:38:46.066231+00	2026-02-28 14:38:46.066231+00	\N
9feb35a2-2866-4c39-84cc-6a390c1f9763	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:38:46.075+00	\N	\N	2026-02-28 14:38:46.074574+00	2026-02-28 14:38:46.074574+00	\N
0a57b495-ff8e-4ee8-b845-d4d3f54e944c	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:38:46.118+00	\N	\N	2026-02-28 14:38:46.117873+00	2026-02-28 14:38:46.117873+00	\N
3e5d65d4-b2c5-4396-8d29-3e4ee1f120de	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:51:03.157+00	\N	\N	2026-02-28 14:51:03.158509+00	2026-02-28 14:51:03.158509+00	\N
f8a91745-f44e-406d-b172-f10a0ac14817	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:51:03.172+00	\N	\N	2026-02-28 14:51:03.171564+00	2026-02-28 14:51:03.171564+00	\N
f7a21c0d-2642-4bd3-b431-8edcd21bcd44	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:52:54.827+00	\N	2026-03-02 07:49:44.04+00	2026-02-28 14:52:54.826896+00	2026-03-02 07:49:44.043141+00	\N
6cb5e827-f22c-4ef6-9c16-38e6bc54eaed	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-29 14:51:03.173+00	\N	2026-03-01 18:59:27.305+00	2026-02-28 14:51:03.172094+00	2026-03-01 18:59:27.306261+00	\N
67af1fe1-d8ad-4731-abfb-0399ccf0ae68	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 18:59:27.424+00	\N	\N	2026-03-01 18:59:27.423625+00	2026-03-01 18:59:27.423625+00	\N
7d79239e-a4c4-410e-a867-0c2e7e0fc58c	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 18:59:27.422+00	\N	\N	2026-03-01 18:59:27.422251+00	2026-03-01 18:59:27.422251+00	\N
682b1545-07f4-40f6-b965-69c569b6238e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 15:25:34.434+00	\N	2026-03-02 17:09:35.684+00	2026-03-02 15:25:34.456614+00	2026-03-02 17:09:35.684189+00	\N
59d79559-316d-427b-be15-3a23f50c49ff	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 18:59:27.424+00	\N	2026-03-01 20:22:36.36+00	2026-03-01 18:59:27.423008+00	2026-03-01 20:22:36.361673+00	\N
8a97df8d-8454-4594-849a-8fa8e3a617e2	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 20:22:36.599+00	\N	\N	2026-03-01 20:22:36.599108+00	2026-03-01 20:22:36.599108+00	\N
7b32c5b1-63ad-4032-9891-03cea5debeb7	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 20:22:36.598+00	\N	\N	2026-03-01 20:22:36.597956+00	2026-03-01 20:22:36.597956+00	\N
34beae50-b4b1-48cd-a3c5-ff1d8ba19778	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 12:09:39.911+00	\N	2026-03-02 13:41:53.764+00	2026-03-02 12:09:39.609563+00	2026-03-02 13:41:53.761203+00	\N
56a9bf99-c393-4a01-9c75-de682df54b3a	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 20:52:39.232+00	\N	\N	2026-03-01 20:52:39.232707+00	2026-03-01 20:52:39.232707+00	\N
be709b4d-7d2a-4422-a9ee-8fdf42afa42e	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 20:22:36.592+00	\N	2026-03-01 20:52:39.236+00	2026-03-01 20:22:36.59406+00	2026-03-01 20:52:39.235445+00	\N
69c46cb2-dfaa-4df0-b911-742129c52341	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 20:52:39.243+00	\N	2026-03-01 21:28:10.35+00	2026-03-01 20:52:39.242639+00	2026-03-01 21:28:10.351496+00	\N
2537e70d-3763-4faf-ab41-a738a56162e2	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:41:53.829+00	\N	\N	2026-03-02 13:41:53.825289+00	2026-03-02 13:41:53.825289+00	\N
a3adbfee-3f8a-40ec-8459-001518f4c161	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-04-30 21:28:10.376+00	\N	2026-03-02 07:22:45.467+00	2026-03-01 21:28:10.378896+00	2026-03-02 07:22:45.462975+00	\N
0f18807d-ced2-4bb3-ad83-b591315c4810	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:22:45.615+00	\N	\N	2026-03-02 07:22:45.61133+00	2026-03-02 07:22:45.61133+00	\N
2b26fdf1-6e12-45e6-9cb6-9b312b3d4422	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:22:45.631+00	\N	\N	2026-03-02 07:22:45.627287+00	2026-03-02 07:22:45.627287+00	\N
5e8a0ed4-bc48-416e-a096-8d77449a1d0d	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:49:44.081+00	\N	\N	2026-03-02 07:49:44.081137+00	2026-03-02 07:49:44.081137+00	\N
69841faf-b2d1-4d6b-9f54-5b5a6a3568ff	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:49:44.045+00	\N	\N	2026-03-02 07:49:44.055967+00	2026-03-02 07:49:44.055967+00	\N
e5ce4888-6490-4d38-a894-d16533cafbf9	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:22:45.633+00	\N	2026-03-02 07:52:51.653+00	2026-03-02 07:22:45.628836+00	2026-03-02 07:52:51.652992+00	\N
8cea7468-d6cb-48e9-8d29-354f87a979e2	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:41:53.826+00	\N	\N	2026-03-02 13:41:53.823722+00	2026-03-02 13:41:53.823722+00	\N
2934af58-bf6e-4572-ba58-f1ef8cfc48f3	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:49:44.057+00	\N	2026-03-02 08:20:00.285+00	2026-03-02 07:49:44.056656+00	2026-03-02 08:20:00.284972+00	\N
de0790ee-8b77-4905-be10-36c9d9cb97b2	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 08:20:00.281+00	\N	\N	2026-03-02 08:20:00.284474+00	2026-03-02 08:20:00.284474+00	\N
6911dc46-f6a0-4d4d-9b4b-d2486eb54c29	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 07:52:51.667+00	\N	2026-03-02 08:24:28.07+00	2026-03-02 07:52:51.666347+00	2026-03-02 08:24:28.070543+00	\N
5e9f59f1-52a4-4135-b62c-227a65c8fb40	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:41:53.821+00	\N	2026-03-02 14:30:17.533+00	2026-03-02 13:41:53.821599+00	2026-03-02 14:30:17.537142+00	\N
86d98d4f-912b-407d-97b6-e9a3e3aade5d	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 08:20:00.295+00	\N	2026-03-02 09:00:21.862+00	2026-03-02 08:20:00.294144+00	2026-03-02 09:00:21.862128+00	\N
65c0b836-1503-4462-a669-13fe431354f5	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:00:21.894+00	\N	\N	2026-03-02 09:00:21.896238+00	2026-03-02 09:00:21.896238+00	\N
e48fe9d4-4cb8-4053-ac26-7dff5b07dd29	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:00:21.897+00	\N	\N	2026-03-02 09:00:21.896646+00	2026-03-02 09:00:21.896646+00	\N
4c3f0cc3-4335-45d0-b088-a4daa4844838	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:31:44.859+00	\N	2026-03-02 14:45:28.357+00	2026-03-02 13:31:44.855587+00	2026-03-02 14:45:28.354903+00	\N
1f143294-96cf-491c-b849-7a8462917450	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:13:12.271+00	\N	\N	2026-03-02 09:13:12.273067+00	2026-03-02 09:13:12.273067+00	\N
633925be-6dc7-4452-8362-3d3d9f7b82e3	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:13:12.273+00	\N	\N	2026-03-02 09:13:12.273612+00	2026-03-02 09:13:12.273612+00	\N
f0131d81-22b6-4d65-8776-a063fe23de0b	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 08:24:28.085+00	\N	2026-03-02 09:13:12.352+00	2026-03-02 08:24:28.084717+00	2026-03-02 09:13:12.352701+00	\N
5de5a16b-8c15-49e6-a452-8f0867f4f8d1	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:13:12.36+00	\N	2026-03-02 09:58:47.345+00	2026-03-02 09:13:12.360538+00	2026-03-02 09:58:47.34969+00	\N
27fbd01b-6dca-41d6-88a1-e8192ca9287b	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 14:30:18.232+00	\N	2026-03-02 15:05:44.541+00	2026-03-02 14:30:18.232035+00	2026-03-02 15:05:44.542699+00	\N
ee053577-6cf5-47f6-b2ce-f318fd0f1c13	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:58:47.398+00	\N	2026-03-02 12:09:39.412+00	2026-03-02 09:58:47.399986+00	2026-03-02 12:09:39.111561+00	\N
d3eb1155-89d9-4df2-94fd-f7b549f65866	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 12:09:39.902+00	\N	\N	2026-03-02 12:09:39.608784+00	2026-03-02 12:09:39.608784+00	\N
2aad15af-9d43-446a-bb11-713ac37cbe2d	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 12:09:39.911+00	\N	\N	2026-03-02 12:09:39.609904+00	2026-03-02 12:09:39.609904+00	\N
f8fa0241-ccd9-47bb-9375-51db9388152f	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 17:09:13.268+00	\N	2026-03-02 19:36:53.584+00	2026-03-02 17:09:13.267765+00	2026-03-02 19:36:53.581593+00	\N
2fe39821-9517-418a-a4c5-da47344e8a75	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:34:28.308+00	\N	2026-03-02 19:11:51.602+00	2026-03-02 18:34:28.301185+00	2026-03-02 19:11:51.602329+00	\N
d8c8b56e-8e88-49ff-a97e-6252d811d15f	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 09:00:21.897+00	\N	2026-03-02 13:31:42.952+00	2026-03-02 09:00:21.897019+00	2026-03-02 13:31:42.946814+00	\N
95b4ddf2-5578-4a20-9a6c-10348ef67600	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:31:44.587+00	\N	\N	2026-03-02 13:31:44.587659+00	2026-03-02 13:31:44.587659+00	\N
d246d749-819c-44a5-9195-a3ed4ee08a6e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 13:31:44.78+00	\N	\N	2026-03-02 13:31:44.789724+00	2026-03-02 13:31:44.789724+00	\N
582fa337-a68c-44a2-a6c8-ed3bd6ea128b	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 14:45:28.384+00	\N	2026-03-02 15:25:33.707+00	2026-03-02 14:45:28.382115+00	2026-03-02 15:25:33.709749+00	\N
02f85cd9-a0df-4f23-8906-8e68e3b84e3e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 15:25:34.261+00	\N	\N	2026-03-02 15:25:34.299329+00	2026-03-02 15:25:34.299329+00	\N
3e08a12a-a71c-4892-8f0e-24bc41b5869e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 15:25:34.303+00	\N	\N	2026-03-02 15:25:34.303992+00	2026-03-02 15:25:34.303992+00	\N
20cf7460-912f-4925-b4d4-943665551a86	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 17:09:35.689+00	\N	2026-03-02 18:04:21.159+00	2026-03-02 17:09:35.688765+00	2026-03-02 18:04:21.159809+00	\N
41172b73-8acb-4353-8f29-22d72b0776b9	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 15:05:44.553+00	\N	2026-03-02 17:09:12.47+00	2026-03-02 15:05:44.553824+00	2026-03-02 17:09:12.469632+00	\N
9194939a-d152-4aa0-8f99-1fb924079a37	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 17:09:13.255+00	\N	\N	2026-03-02 17:09:13.260963+00	2026-03-02 17:09:13.260963+00	\N
67f9f9e1-6269-4f02-9d9a-9b9019d8b6a4	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:04:21.275+00	\N	\N	2026-03-02 18:04:21.276894+00	2026-03-02 18:04:21.276894+00	\N
04530726-dc3f-4257-a74e-092658fa83a9	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 17:09:35.598+00	\N	\N	2026-03-02 17:09:35.598132+00	2026-03-02 17:09:35.598132+00	\N
6b5438bc-9c30-4f75-8844-1a934d84a034	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 17:09:35.604+00	\N	\N	2026-03-02 17:09:35.603785+00	2026-03-02 17:09:35.603785+00	\N
29e7101c-644e-46a6-a02c-29fd9538078e	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:04:21.277+00	\N	\N	2026-03-02 18:04:21.277704+00	2026-03-02 18:04:21.277704+00	\N
adc72e2b-5a17-4690-b44b-8b3733e460d9	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:11:51.636+00	\N	\N	2026-03-02 19:11:51.635597+00	2026-03-02 19:11:51.635597+00	\N
d02537e3-7793-4772-84f4-8575ba538376	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:11:51.633+00	\N	2026-03-02 19:43:52.712+00	2026-03-02 19:11:51.635063+00	2026-03-02 19:43:52.710902+00	\N
785ee42b-fb80-4208-b96b-cc0a6e300785	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:04:21.278+00	\N	2026-03-02 18:34:28.261+00	2026-03-02 18:04:21.278427+00	2026-03-02 18:34:28.254945+00	\N
b1506217-b0c9-4897-b407-0ffb18c8183b	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:34:28.303+00	\N	\N	2026-03-02 18:34:28.300352+00	2026-03-02 18:34:28.300352+00	\N
ae45a888-734a-4847-ad51-a00abf8e1a33	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 18:34:28.307+00	\N	\N	2026-03-02 18:34:28.300696+00	2026-03-02 18:34:28.300696+00	\N
3078d05b-03df-43ef-a766-450bc77083f9	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:36:53.295+00	\N	\N	2026-03-02 19:36:53.295138+00	2026-03-02 19:36:53.295138+00	\N
b781392b-3cf9-4ec8-82a6-a12ca0529d92	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:36:53.298+00	\N	\N	2026-03-02 19:36:53.29556+00	2026-03-02 19:36:53.29556+00	\N
de1d3442-8b88-4928-9813-25a9591ab746	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:43:52.503+00	\N	\N	2026-03-02 19:43:52.502853+00	2026-03-02 19:43:52.502853+00	\N
fbd51b89-3eb5-4fe5-9ce2-5cdfc590dc9f	80d538c7-4037-424f-bb74-c60da39e9b29	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:57:00.134+00	\N	\N	2026-03-02 19:57:00.142851+00	2026-03-02 19:57:00.142851+00	\N
3518e19e-dec2-4cb7-a9bc-dd9859a397ca	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:43:52.574+00	\N	\N	2026-03-02 19:43:52.573035+00	2026-03-02 19:43:52.573035+00	\N
f96597b5-4baa-43cb-beae-4956afc827c3	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:43:52.721+00	\N	\N	2026-03-02 19:43:52.719908+00	2026-03-02 19:43:52.719908+00	\N
a4b42b0e-70c4-4153-949d-c1aaa2f5ad45	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 19:36:53.589+00	\N	2026-03-02 20:07:41.732+00	2026-03-02 19:36:53.586842+00	2026-03-02 20:07:41.732748+00	\N
628b702f-cc2f-4089-9d65-4a12d0617155	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	REFRESH_TOKEN	\N	2026-05-01 20:07:41.773+00	\N	\N	2026-03-02 20:07:41.775666+00	2026-03-02 20:07:41.775666+00	\N
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.application (id, "universalIdentifier", name, description, version, "sourceType", "sourcePath", "workspaceId", "createdAt", "updatedAt", "deletedAt", "serverlessFunctionLayerId", "canBeUninstalled", "defaultServerlessFunctionRoleId") FROM stdin;
bbb719d5-4626-40d6-aec6-7d53f24e5459	bbb719d5-4626-40d6-aec6-7d53f24e5459	Workspace's custom application	Workspace custom application	1.0.0	local	workspace-custom	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:08.544413+00	2026-02-28 05:07:08.544413+00	\N	\N	f	\N
67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-64aa-4b6f-b003-9c74b97cee20	Twenty Standard	Twenty is an open-source CRM that allows you to manage your sales and customer relationships	1.0.0	local	cli-sync	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.351244+00	2026-02-28 05:07:16.351244+00	\N	\N	f	\N
\.


--
-- Data for Name: applicationVariable; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."applicationVariable" (id, key, value, description, "isSecret", "applicationId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: approvedAccessDomain; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."approvedAccessDomain" (id, "createdAt", "updatedAt", domain, "isValidated", "workspaceId") FROM stdin;
\.


--
-- Data for Name: commandMenuItem; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."commandMenuItem" ("workspaceId", "universalIdentifier", "applicationId", id, "workflowVersionId", label, icon, "isPinned", "availabilityType", "availabilityObjectMetadataId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: cronTrigger; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."cronTrigger" ("universalIdentifier", id, settings, "workspaceId", "createdAt", "updatedAt", "serverlessFunctionId", "applicationId") FROM stdin;
\.


--
-- Data for Name: dataSource; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."dataSource" (id, label, url, schema, type, "isRemote", "workspaceId", "createdAt", "updatedAt") FROM stdin;
fbe4525e-6a79-4ade-894f-1abf14324de8	\N	\N	workspace_9zs4rq4zo2wzg53xjkq5u4qis	postgres	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.346422+00	2026-02-28 05:07:16.346422+00
\.


--
-- Data for Name: databaseEventTrigger; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."databaseEventTrigger" ("universalIdentifier", id, settings, "workspaceId", "createdAt", "updatedAt", "serverlessFunctionId", "applicationId") FROM stdin;
\.


--
-- Data for Name: emailingDomain; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."emailingDomain" (id, "createdAt", "updatedAt", domain, driver, status, "verificationRecords", "verifiedAt", "workspaceId") FROM stdin;
\.


--
-- Data for Name: featureFlag; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."featureFlag" (id, key, "workspaceId", value, "createdAt", "updatedAt") FROM stdin;
49b84653-5127-4587-aefa-fd5d63a9954e	IS_TIMELINE_ACTIVITY_MIGRATED	a8cf39ab-a363-48fd-8960-096055b51144	t	2026-02-28 05:07:16.316825+00	2026-02-28 05:07:16.316825+00
\.


--
-- Data for Name: fieldMetadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."fieldMetadata" (id, "standardId", "objectMetadataId", type, name, label, "defaultValue", description, icon, "standardOverrides", options, settings, "isCustom", "isActive", "isSystem", "isUIReadOnly", "isNullable", "isUnique", "workspaceId", "isLabelSyncedWithName", "relationTargetFieldMetadataId", "relationTargetObjectMetadataId", "morphId", "createdAt", "updatedAt", "universalIdentifier", "applicationId") FROM stdin;
49083b22-27b3-4fa2-bacc-4ce874543b85	20202020-a01a-4001-8a01-1d5f8e3c7b2a	b1aae13e-f912-419c-a5b9-8493b54a38cb	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01a-4001-8a01-1d5f8e3c7b2a	67affcc3-762a-4fee-baa4-2a048ddd621e
4f523943-d19d-4e67-8e52-e4cd4b469696	20202020-a01b-4002-9b02-2e6f9f4d8c3b	b1aae13e-f912-419c-a5b9-8493b54a38cb	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01b-4002-9b02-2e6f9f4d8c3b	67affcc3-762a-4fee-baa4-2a048ddd621e
a8218974-3bff-4209-8131-1374d98ad032	20202020-a01c-4003-8c03-3f7fa05d9d4c	b1aae13e-f912-419c-a5b9-8493b54a38cb	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01c-4003-8c03-3f7fa05d9d4c	67affcc3-762a-4fee-baa4-2a048ddd621e
8fd446fb-f94a-4694-8e27-4009e6ab731c	20202020-a01d-4004-9d04-4f8fb16eae5d	b1aae13e-f912-419c-a5b9-8493b54a38cb	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01d-4004-9d04-4f8fb16eae5d	67affcc3-762a-4fee-baa4-2a048ddd621e
14c4d7a2-3c68-418d-b188-a82bc604719b	20202020-87a5-48f8-bbf7-ade388825a57	b1aae13e-f912-419c-a5b9-8493b54a38cb	TEXT	name	Name	\N	Attachment name	IconFileUpload	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-87a5-48f8-bbf7-ade388825a57	67affcc3-762a-4fee-baa4-2a048ddd621e
545712aa-4f6d-482e-8fb8-744eef1ee6df	20202020-0d19-453d-8e8d-fbcda8ca3747	b1aae13e-f912-419c-a5b9-8493b54a38cb	TEXT	fullPath	Full path	\N	Attachment full path	IconLink	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0d19-453d-8e8d-fbcda8ca3747	67affcc3-762a-4fee-baa4-2a048ddd621e
0c877c78-4ff2-46f6-8291-6c478281ad09	20202020-8c3f-4d9e-9a1b-2e5f7a8c9d0e	b1aae13e-f912-419c-a5b9-8493b54a38cb	SELECT	fileCategory	File category	"'OTHER'"	Attachment file category	IconList	\N	[{"id": "2f3774df-fc27-415f-b3bd-49f7546cd595", "color": "gray", "label": "Archive", "value": "ARCHIVE", "position": 0}, {"id": "ed4eeda4-95e5-4d55-b10e-69c0ece91811", "color": "pink", "label": "Audio", "value": "AUDIO", "position": 1}, {"id": "fabf6835-fb25-41e7-ad21-c85fd9d854b0", "color": "yellow", "label": "Image", "value": "IMAGE", "position": 2}, {"id": "97933c58-3269-425a-aaf1-c0ca223414b7", "color": "orange", "label": "Presentation", "value": "PRESENTATION", "position": 3}, {"id": "45d9eff4-eda9-4607-9de7-82da1cdb3254", "color": "turquoise", "label": "Spreadsheet", "value": "SPREADSHEET", "position": 4}, {"id": "5e7344d3-15ee-4a60-b226-c913de51d546", "color": "blue", "label": "Text Document", "value": "TEXT_DOCUMENT", "position": 5}, {"id": "95f3d5f5-e656-4951-9ba5-f90a544a1dd3", "color": "purple", "label": "Video", "value": "VIDEO", "position": 6}, {"id": "3bd01d51-f489-46ea-bb47-17185a881e45", "color": "gray", "label": "Other", "value": "OTHER", "position": 7}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8c3f-4d9e-9a1b-2e5f7a8c9d0e	67affcc3-762a-4fee-baa4-2a048ddd621e
fc6711a4-008d-4c0d-b9cf-5ebf63520703	395be3bd-a5c9-463d-aafe-9bc3bbec3f15	b1aae13e-f912-419c-a5b9-8493b54a38cb	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	395be3bd-a5c9-463d-aafe-9bc3bbec3f15	67affcc3-762a-4fee-baa4-2a048ddd621e
57289d1f-ba77-4882-996f-756cf7a062f4	376239d1-3e65-4cb6-b5d8-e0917d43cc93	b1aae13e-f912-419c-a5b9-8493b54a38cb	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	376239d1-3e65-4cb6-b5d8-e0917d43cc93	67affcc3-762a-4fee-baa4-2a048ddd621e
628c75c7-d054-427b-9d92-5ebbab9ba7a3	20202020-b01a-4011-8b11-5a9fc27fbf6e	b438fbab-6bac-43b0-8550-1e70fb608333	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01a-4011-8b11-5a9fc27fbf6e	67affcc3-762a-4fee-baa4-2a048ddd621e
d61e9286-0ddf-44c6-8dd9-0d4c94287148	20202020-b01b-4012-9c12-6bafd38fcf7f	b438fbab-6bac-43b0-8550-1e70fb608333	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01b-4012-9c12-6bafd38fcf7f	67affcc3-762a-4fee-baa4-2a048ddd621e
818f5b6e-b680-4cdd-b614-d0f3d610876d	20202020-b01c-4013-8d13-7cbfe49fdf8f	b438fbab-6bac-43b0-8550-1e70fb608333	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01c-4013-8d13-7cbfe49fdf8f	67affcc3-762a-4fee-baa4-2a048ddd621e
5569b771-564e-45ee-bf07-82425677153c	20202020-b01d-4014-9e14-8dcff5affef9	b438fbab-6bac-43b0-8550-1e70fb608333	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01d-4014-9e14-8dcff5affef9	67affcc3-762a-4fee-baa4-2a048ddd621e
370f44ae-54e3-4816-9fc7-8537358b2099	20202020-eef3-44ed-aa32-4641d7fd4a3e	b438fbab-6bac-43b0-8550-1e70fb608333	TEXT	handle	Handle	\N	Handle	IconAt	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-eef3-44ed-aa32-4641d7fd4a3e	67affcc3-762a-4fee-baa4-2a048ddd621e
47c09ae2-7e1f-4b97-9a1d-1cdb54c1d521	20202020-c01a-4021-8a21-9edf06bfef0a	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01a-4021-8a21-9edf06bfef0a	67affcc3-762a-4fee-baa4-2a048ddd621e
139431bf-97a7-4366-8582-8f3c573315c9	20202020-c01b-4022-9b22-afefd7cffefb	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01b-4022-9b22-afefd7cffefb	67affcc3-762a-4fee-baa4-2a048ddd621e
c8b33752-68b8-4a3c-ace0-301938f5000e	20202020-c01c-4023-8c23-bffef8dffef0	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01c-4023-8c23-bffef8dffef0	67affcc3-762a-4fee-baa4-2a048ddd621e
74d1e47c-04ea-4ab6-9924-785de0ff7795	20202020-c01d-4024-9d24-cffef9effef1	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01d-4024-9d24-cffef9effef1	67affcc3-762a-4fee-baa4-2a048ddd621e
24c99797-72c2-4738-8d2c-8b4ac44c6035	20202020-9ec8-48bb-b279-21d0734a75a1	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	TEXT	eventExternalId	Event external ID	\N	Event external ID	IconCalendar	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9ec8-48bb-b279-21d0734a75a1	67affcc3-762a-4fee-baa4-2a048ddd621e
d36ddaaa-a959-426b-b254-7a5b6778860d	20202020-c58f-4c69-9bf8-9518fa31aa50	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	TEXT	recurringEventExternalId	Recurring Event ID	\N	Recurring Event ID	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c58f-4c69-9bf8-9518fa31aa50	67affcc3-762a-4fee-baa4-2a048ddd621e
04b356a3-713a-46ac-9d24-2a19e0c248ce	20202020-c02a-4031-8a31-1a2f3b4c5d6e	d98f6957-0ad9-4461-8551-13b1c541fb90	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02a-4031-8a31-1a2f3b4c5d6e	67affcc3-762a-4fee-baa4-2a048ddd621e
a7eab560-f76a-4185-8049-5ca76726725e	20202020-c02b-4032-9b32-2b3f4c5d6e7f	d98f6957-0ad9-4461-8551-13b1c541fb90	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02b-4032-9b32-2b3f4c5d6e7f	67affcc3-762a-4fee-baa4-2a048ddd621e
71073255-311a-4238-aae4-beb472835e2e	20202020-c02c-4033-8c33-3c4f5d6e7f8a	d98f6957-0ad9-4461-8551-13b1c541fb90	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02c-4033-8c33-3c4f5d6e7f8a	67affcc3-762a-4fee-baa4-2a048ddd621e
5aa44801-1d52-4ca7-b026-4cbf1e58ebb3	20202020-c02d-4034-9d34-4d5f6e7f8a9b	d98f6957-0ad9-4461-8551-13b1c541fb90	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02d-4034-9d34-4d5f6e7f8a9b	67affcc3-762a-4fee-baa4-2a048ddd621e
5f444860-9ce3-41ff-a6ca-92b5475fcc36	20202020-1d08-420a-9aa7-22e0f298232d	d98f6957-0ad9-4461-8551-13b1c541fb90	TEXT	handle	Handle	\N	Handle	IconAt	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1d08-420a-9aa7-22e0f298232d	67affcc3-762a-4fee-baa4-2a048ddd621e
83eae26e-0b8e-49d8-80dc-22c6dd8525d5	20202020-1b07-4796-9f01-d626bab7ca4d	d98f6957-0ad9-4461-8551-13b1c541fb90	SELECT	visibility	Visibility	"'SHARE_EVERYTHING'"	Visibility	IconEyeglass	\N	[{"id": "f58ebdb5-c25e-4cb3-aa39-121593e9c91d", "color": "green", "label": "Metadata", "value": "METADATA", "position": 0}, {"id": "a927b5f6-6711-48c1-801b-dd59a270555d", "color": "orange", "label": "Share Everything", "value": "SHARE_EVERYTHING", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1b07-4796-9f01-d626bab7ca4d	67affcc3-762a-4fee-baa4-2a048ddd621e
2a8b57c0-4cf2-4b4f-9f20-1df5a204974b	20202020-d9a6-48e9-990b-b97fdf22e8dd	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	BOOLEAN	isSyncEnabled	Is Sync Enabled	true	Is Sync Enabled	IconRefresh	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d9a6-48e9-990b-b97fdf22e8dd	67affcc3-762a-4fee-baa4-2a048ddd621e
d7f1bd7b-16db-4cd0-a385-37f7b0281b4f	20202020-50fb-404b-ba28-369911a3793a	d98f6957-0ad9-4461-8551-13b1c541fb90	BOOLEAN	isContactAutoCreationEnabled	Is Contact Auto Creation Enabled	true	Is Contact Auto Creation Enabled	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-50fb-404b-ba28-369911a3793a	67affcc3-762a-4fee-baa4-2a048ddd621e
8cbc9025-808e-4083-9a94-8e4129e874ce	20202020-b55d-447d-b4df-226319058775	d98f6957-0ad9-4461-8551-13b1c541fb90	SELECT	contactAutoCreationPolicy	Contact auto creation policy	"'AS_PARTICIPANT_AND_ORGANIZER'"	Automatically create records for people you participated with in an event.	IconUserCircle	\N	[{"id": "ea663e3e-976b-4a66-8415-4c75f8094780", "color": "green", "label": "As Participant and Organizer", "value": "AS_PARTICIPANT_AND_ORGANIZER", "position": 0}, {"id": "6610408d-063f-4682-85be-998ed71cb4a2", "color": "orange", "label": "As Participant", "value": "AS_PARTICIPANT", "position": 1}, {"id": "0e287282-8cbe-463d-ba28-ccc109b5795e", "color": "blue", "label": "As Organizer", "value": "AS_ORGANIZER", "position": 2}, {"id": "9f02c2d4-d171-4fc4-9380-6f319be39c82", "color": "red", "label": "None", "value": "NONE", "position": 3}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b55d-447d-b4df-226319058775	67affcc3-762a-4fee-baa4-2a048ddd621e
e30b5f2a-a155-4f6b-bb48-55d75429f7ac	20202020-fe19-4818-8854-21f7b1b43395	d98f6957-0ad9-4461-8551-13b1c541fb90	BOOLEAN	isSyncEnabled	Is Sync Enabled	true	Is Sync Enabled	IconRefresh	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fe19-4818-8854-21f7b1b43395	67affcc3-762a-4fee-baa4-2a048ddd621e
8eedee18-8910-4ffe-9a1e-68bd52f4f756	20202020-bac2-4852-a5cb-7a7898992b70	d98f6957-0ad9-4461-8551-13b1c541fb90	TEXT	syncCursor	Sync Cursor	\N	Sync Cursor. Used for syncing events from the calendar provider	IconReload	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-bac2-4852-a5cb-7a7898992b70	67affcc3-762a-4fee-baa4-2a048ddd621e
f4a569a7-cf97-44af-9047-c535d690791c	20202020-7116-41da-8b4b-035975c4eb6a	d98f6957-0ad9-4461-8551-13b1c541fb90	SELECT	syncStatus	Sync status	\N	Sync status	IconStatusChange	\N	[{"id": "0faa224e-8477-4f01-81e9-4023c29df98f", "color": "yellow", "label": "Ongoing", "value": "ONGOING", "position": 1}, {"id": "97ee1676-5d7f-4521-8f7b-bb3a7aa67a93", "color": "blue", "label": "Not Synced", "value": "NOT_SYNCED", "position": 2}, {"id": "b0a3c600-5b3c-4b82-9f5a-039bccfd68c5", "color": "green", "label": "Active", "value": "ACTIVE", "position": 3}, {"id": "a72ff37c-e111-4854-bddd-192650b498b0", "color": "red", "label": "Failed Insufficient Permissions", "value": "FAILED_INSUFFICIENT_PERMISSIONS", "position": 4}, {"id": "d665482f-d19c-4c16-ab01-a310335fa24d", "color": "red", "label": "Failed Unknown", "value": "FAILED_UNKNOWN", "position": 5}]	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7116-41da-8b4b-035975c4eb6a	67affcc3-762a-4fee-baa4-2a048ddd621e
da3df9f9-1585-4583-8e10-10b93b8a3a9d	20202020-6246-42e6-b5cd-003bd921782c	d98f6957-0ad9-4461-8551-13b1c541fb90	SELECT	syncStage	Sync stage	"'PENDING_CONFIGURATION'"	Sync stage	IconStatusChange	\N	[{"id": "ad743e90-9e31-4eb9-837b-51d262e19735", "color": "blue", "label": "Calendar event list fetch pending", "value": "CALENDAR_EVENT_LIST_FETCH_PENDING", "position": 0}, {"id": "364f2fc3-83ce-4711-9ccc-a3bcb009f3ea", "color": "green", "label": "Calendar event list fetch scheduled", "value": "CALENDAR_EVENT_LIST_FETCH_SCHEDULED", "position": 1}, {"id": "2cab57fe-e3e7-4f98-bf72-8cc0530190d7", "color": "orange", "label": "Calendar event list fetch ongoing", "value": "CALENDAR_EVENT_LIST_FETCH_ONGOING", "position": 2}, {"id": "83791139-484f-4e96-b3f1-36e6bfcaf2ca", "color": "blue", "label": "Calendar events import pending", "value": "CALENDAR_EVENTS_IMPORT_PENDING", "position": 3}, {"id": "897a493a-9b59-4450-9ded-218e8e798124", "color": "green", "label": "Calendar events import scheduled", "value": "CALENDAR_EVENTS_IMPORT_SCHEDULED", "position": 4}, {"id": "779ef752-695a-4ed1-ae35-c9ee76d6a99b", "color": "orange", "label": "Calendar events import ongoing", "value": "CALENDAR_EVENTS_IMPORT_ONGOING", "position": 5}, {"id": "6547cfca-a72a-4cca-9046-fab3ae87e46c", "color": "red", "label": "Failed", "value": "FAILED", "position": 6}, {"id": "53ebf889-c8c6-40ce-9ac6-c57609ae3e35", "color": "gray", "label": "Pending configuration", "value": "PENDING_CONFIGURATION", "position": 9}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6246-42e6-b5cd-003bd921782c	67affcc3-762a-4fee-baa4-2a048ddd621e
f6e8b804-2c36-460b-a6da-a95e1eb29843	20202020-a934-46f1-a8e7-9568b1e3a53e	d98f6957-0ad9-4461-8551-13b1c541fb90	DATE_TIME	syncStageStartedAt	Sync stage started at	\N	Sync stage started at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a934-46f1-a8e7-9568b1e3a53e	67affcc3-762a-4fee-baa4-2a048ddd621e
b3b20d7e-3e92-4c6d-a1a5-42ef73a2328a	20202020-2ff5-4f70-953a-3d0d36357576	d98f6957-0ad9-4461-8551-13b1c541fb90	DATE_TIME	syncedAt	Last sync date	\N	Last sync date	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2ff5-4f70-953a-3d0d36357576	67affcc3-762a-4fee-baa4-2a048ddd621e
9237d44f-541d-4ea0-a344-9809d6c97f3d	20202020-525c-4b76-b9bd-0dd57fd11d61	d98f6957-0ad9-4461-8551-13b1c541fb90	NUMBER	throttleFailureCount	Throttle Failure Count	0	Throttle Failure Count	IconX	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-525c-4b76-b9bd-0dd57fd11d61	67affcc3-762a-4fee-baa4-2a048ddd621e
428be613-8743-4dab-b32f-0e3cf92546c9	20202020-c03a-4041-8a41-5e6f7a8b9cad	582910b3-32c9-4959-a72c-ebb309bc29f4	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c03a-4041-8a41-5e6f7a8b9cad	67affcc3-762a-4fee-baa4-2a048ddd621e
836dab28-a622-46a2-a2c4-2e54297e04b3	20202020-c03b-4042-9b42-6f7a8b9cadbe	582910b3-32c9-4959-a72c-ebb309bc29f4	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c03b-4042-9b42-6f7a8b9cadbe	67affcc3-762a-4fee-baa4-2a048ddd621e
7542a567-893e-4b65-890e-1fedf6180c79	20202020-c03c-4043-8c43-7a8b9cadbecf	582910b3-32c9-4959-a72c-ebb309bc29f4	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c03c-4043-8c43-7a8b9cadbecf	67affcc3-762a-4fee-baa4-2a048ddd621e
0110b801-e577-431b-b0d7-98e8604ca033	20202020-c03d-4044-9d44-8b9cadbecd0f	582910b3-32c9-4959-a72c-ebb309bc29f4	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c03d-4044-9d44-8b9cadbecd0f	67affcc3-762a-4fee-baa4-2a048ddd621e
7789c372-d38f-4b9b-9d27-89c8e52e772e	20202020-8692-4580-8210-9e09cbd031a7	582910b3-32c9-4959-a72c-ebb309bc29f4	TEXT	handle	Handle	\N	Handle	IconMail	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8692-4580-8210-9e09cbd031a7	67affcc3-762a-4fee-baa4-2a048ddd621e
f053cb0a-b2bd-47fb-b882-6a669e65eef9	20202020-ee1e-4f9f-8ac1-5c0b2f69691e	582910b3-32c9-4959-a72c-ebb309bc29f4	TEXT	displayName	Display Name	\N	Display Name	IconUser	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ee1e-4f9f-8ac1-5c0b2f69691e	67affcc3-762a-4fee-baa4-2a048ddd621e
3b4b128a-684f-44c9-8bf6-0e420402eec1	20202020-66e7-4e00-9e06-d06c92650580	582910b3-32c9-4959-a72c-ebb309bc29f4	BOOLEAN	isOrganizer	Is Organizer	false	Is Organizer	IconUser	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-66e7-4e00-9e06-d06c92650580	67affcc3-762a-4fee-baa4-2a048ddd621e
6e38d457-1f08-4c1d-8ca4-a5657e51b8f1	20202020-cec0-4be8-8fba-c366abc23147	582910b3-32c9-4959-a72c-ebb309bc29f4	SELECT	responseStatus	Response Status	"'NEEDS_ACTION'"	Response Status	IconUser	\N	[{"id": "495ef4e5-004c-4ccd-a33b-d304731df830", "color": "orange", "label": "Needs Action", "value": "NEEDS_ACTION", "position": 0}, {"id": "931849c1-ac12-440d-89eb-d0bc79f8e26f", "color": "red", "label": "Declined", "value": "DECLINED", "position": 1}, {"id": "02eead1a-9874-4469-960e-1d74f964b9ff", "color": "yellow", "label": "Tentative", "value": "TENTATIVE", "position": 2}, {"id": "0564a1c1-96ca-4cf2-91e5-cc0c1d6f8577", "color": "green", "label": "Accepted", "value": "ACCEPTED", "position": 3}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cec0-4be8-8fba-c366abc23147	67affcc3-762a-4fee-baa4-2a048ddd621e
85095cc0-334b-4648-95ac-da2667484461	20202020-c04a-4051-8a51-9cadbe0f1e2d	3964c94e-8e9c-4e92-b9f2-8144df00e793	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c04a-4051-8a51-9cadbe0f1e2d	67affcc3-762a-4fee-baa4-2a048ddd621e
2ce8c312-21b6-423c-85b5-4d65b0bf3bd5	20202020-c04b-4052-9b52-adbecf1f2e3e	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c04b-4052-9b52-adbecf1f2e3e	67affcc3-762a-4fee-baa4-2a048ddd621e
713c4e9d-7650-4cf6-b3ae-fd8e46c81b28	20202020-c04c-4053-8c53-becf0f2f3e4f	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c04c-4053-8c53-becf0f2f3e4f	67affcc3-762a-4fee-baa4-2a048ddd621e
01af6eac-8e91-4125-8c95-ea4253adb0f5	20202020-c04d-4054-9d54-cd0f1f3f4e5f	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c04d-4054-9d54-cd0f1f3f4e5f	67affcc3-762a-4fee-baa4-2a048ddd621e
a2c53edd-fe83-4b96-bf20-af609af74aec	20202020-080e-49d1-b21d-9702a7e2525c	3964c94e-8e9c-4e92-b9f2-8144df00e793	TEXT	title	Title	\N	Title	IconH1	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-080e-49d1-b21d-9702a7e2525c	67affcc3-762a-4fee-baa4-2a048ddd621e
68fe3a5d-3046-4c61-b7b0-82015593db18	20202020-335b-4e04-b470-43b84b64863c	3964c94e-8e9c-4e92-b9f2-8144df00e793	BOOLEAN	isCanceled	Is canceled	false	Is canceled	IconCalendarCancel	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-335b-4e04-b470-43b84b64863c	67affcc3-762a-4fee-baa4-2a048ddd621e
3b580204-6b97-4736-bf3e-fe762dfa0274	20202020-551c-402c-bb6d-dfe9efe86bcb	3964c94e-8e9c-4e92-b9f2-8144df00e793	BOOLEAN	isFullDay	Is Full Day	false	Is Full Day	IconHours24	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-551c-402c-bb6d-dfe9efe86bcb	67affcc3-762a-4fee-baa4-2a048ddd621e
53d86340-2a32-4585-a401-6315e55d63fd	20202020-2c57-4c75-93c5-2ac950a6ed67	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	startsAt	Start Date	\N	Start Date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2c57-4c75-93c5-2ac950a6ed67	67affcc3-762a-4fee-baa4-2a048ddd621e
2e995bee-fd0d-4ce7-abd5-92f1efb0ecdb	20202020-2554-4ee1-a617-17907f6bab21	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	endsAt	End Date	\N	End Date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2554-4ee1-a617-17907f6bab21	67affcc3-762a-4fee-baa4-2a048ddd621e
08a096e6-92d5-4b4c-8b00-5d98049bce8a	20202020-9f03-4058-a898-346c62181599	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	externalCreatedAt	Creation DateTime	\N	Creation DateTime	IconCalendarPlus	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9f03-4058-a898-346c62181599	67affcc3-762a-4fee-baa4-2a048ddd621e
1d1808dc-6f64-43ce-aa43-12e831a2af21	20202020-b355-4c18-8825-ef42c8a5a755	3964c94e-8e9c-4e92-b9f2-8144df00e793	DATE_TIME	externalUpdatedAt	Update DateTime	\N	Update DateTime	IconCalendarCog	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b355-4c18-8825-ef42c8a5a755	67affcc3-762a-4fee-baa4-2a048ddd621e
844438cd-1ec5-4de0-bbfc-01c1564f2b99	20202020-52c4-4266-a98f-e90af0b4d271	3964c94e-8e9c-4e92-b9f2-8144df00e793	TEXT	description	Description	\N	Description	IconFileDescription	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-52c4-4266-a98f-e90af0b4d271	67affcc3-762a-4fee-baa4-2a048ddd621e
0c483011-0d30-4c66-86d0-7932740cc07a	20202020-641a-4ffe-960d-c3c186d95b17	3964c94e-8e9c-4e92-b9f2-8144df00e793	TEXT	location	Location	\N	Location	IconMapPin	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-641a-4ffe-960d-c3c186d95b17	67affcc3-762a-4fee-baa4-2a048ddd621e
ced87512-053b-4131-944f-8ac2ecf3bb3e	20202020-f24b-45f4-b6a3-d2f9fcb98714	3964c94e-8e9c-4e92-b9f2-8144df00e793	TEXT	iCalUid	iCal UID	\N	iCal UID	IconKey	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f24b-45f4-b6a3-d2f9fcb98714	67affcc3-762a-4fee-baa4-2a048ddd621e
9169e92f-1b18-4af6-87da-ab11cf8bfe2c	20202020-1c3f-4b5a-b526-5411a82179eb	3964c94e-8e9c-4e92-b9f2-8144df00e793	TEXT	conferenceSolution	Conference Solution	\N	Conference Solution	IconScreenShare	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1c3f-4b5a-b526-5411a82179eb	67affcc3-762a-4fee-baa4-2a048ddd621e
78986fb3-66e2-4da6-8e00-b4a114d6bc2c	20202020-35da-43ef-9ca0-e936e9dc237b	3964c94e-8e9c-4e92-b9f2-8144df00e793	LINKS	conferenceLink	Meet Link	\N	Meet Link	IconLink	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-35da-43ef-9ca0-e936e9dc237b	67affcc3-762a-4fee-baa4-2a048ddd621e
7550311e-1365-4576-8908-2ffc5236e56b	20202020-c05a-4061-8a61-1e2f3a4b5c6d	d7124df1-9136-4b65-8c71-befa364161f2	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c05a-4061-8a61-1e2f3a4b5c6d	67affcc3-762a-4fee-baa4-2a048ddd621e
6c92eab1-1463-4a90-8336-057354bedde6	20202020-c05b-4062-9b62-2f3a4b5c6d7e	d7124df1-9136-4b65-8c71-befa364161f2	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c05b-4062-9b62-2f3a4b5c6d7e	67affcc3-762a-4fee-baa4-2a048ddd621e
cc78e8b1-c324-4937-8e89-bdbdd339cd30	20202020-c05c-4063-8c63-3a4b5c6d7e8f	d7124df1-9136-4b65-8c71-befa364161f2	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c05c-4063-8c63-3a4b5c6d7e8f	67affcc3-762a-4fee-baa4-2a048ddd621e
58788ce5-99b7-4623-b434-3923d1711793	20202020-c05d-4064-9d64-4b5c6d7e8f9a	d7124df1-9136-4b65-8c71-befa364161f2	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c05d-4064-9d64-4b5c6d7e8f9a	67affcc3-762a-4fee-baa4-2a048ddd621e
eb858483-5937-4ce5-9c68-259d1235607d	20202020-4d99-4e2e-a84c-4a27837b1ece	d7124df1-9136-4b65-8c71-befa364161f2	TEXT	name	Name	\N	The company name	IconBuildingSkyscraper	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4d99-4e2e-a84c-4a27837b1ece	67affcc3-762a-4fee-baa4-2a048ddd621e
f2496f3a-f39f-49f8-9eab-f967d6576e40	20202020-0c28-43d8-8ba5-3659924d3489	d7124df1-9136-4b65-8c71-befa364161f2	LINKS	domainName	Domain Name	\N	The company website URL. We use this url to fetch the company icon	IconLink	\N	\N	{"maxNumberOfValues": 1}	f	t	f	f	t	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0c28-43d8-8ba5-3659924d3489	67affcc3-762a-4fee-baa4-2a048ddd621e
7d7186c9-dec2-4421-8cfd-4d197478e9bc	20202020-c5ce-4adc-b7b6-9c0979fc55e7	d7124df1-9136-4b65-8c71-befa364161f2	ADDRESS	address	Address	\N	Address of the company	IconMap	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c5ce-4adc-b7b6-9c0979fc55e7	67affcc3-762a-4fee-baa4-2a048ddd621e
c62d2bc4-df89-4d6c-9caf-11a760519d11	20202020-8965-464a-8a75-74bafc152a0b	d7124df1-9136-4b65-8c71-befa364161f2	NUMBER	employees	Employees	\N	Number of employees in the company	IconUsers	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8965-464a-8a75-74bafc152a0b	67affcc3-762a-4fee-baa4-2a048ddd621e
1490b8d6-3f3f-4a95-9077-5d9c080192f2	20202020-ebeb-4beb-b9ad-6848036fb451	d7124df1-9136-4b65-8c71-befa364161f2	LINKS	linkedinLink	Linkedin	\N	The company Linkedin account	IconBrandLinkedin	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ebeb-4beb-b9ad-6848036fb451	67affcc3-762a-4fee-baa4-2a048ddd621e
27b1fb04-dc13-4dbe-9578-b8bda3e5ddff	20202020-6f64-4fd9-9580-9c1991c7d8c3	d7124df1-9136-4b65-8c71-befa364161f2	LINKS	xLink	X	\N	The company Twitter/X account	IconBrandX	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6f64-4fd9-9580-9c1991c7d8c3	67affcc3-762a-4fee-baa4-2a048ddd621e
791f3a9f-b234-4b63-8243-0d3cdc2e92ca	20202020-602a-495c-9776-f5d5b11d227b	d7124df1-9136-4b65-8c71-befa364161f2	CURRENCY	annualRecurringRevenue	ARR	\N	Annual Recurring Revenue: The actual or estimated annual revenue of the company	IconMoneybag	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-602a-495c-9776-f5d5b11d227b	67affcc3-762a-4fee-baa4-2a048ddd621e
89cda5da-e569-4a90-8c74-c52ee2f80472	20202020-ba6b-438a-8213-2c5ba28d76a2	d7124df1-9136-4b65-8c71-befa364161f2	BOOLEAN	idealCustomerProfile	ICP	false	Ideal Customer Profile: Indicates whether the company is the most suitable and valuable customer for you	IconTarget	\N	\N	\N	f	t	f	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ba6b-438a-8213-2c5ba28d76a2	67affcc3-762a-4fee-baa4-2a048ddd621e
91d673f9-f1be-4286-98a6-fb8dec7c06db	20202020-9b4e-462b-991d-a0ee33326454	d7124df1-9136-4b65-8c71-befa364161f2	POSITION	position	Position	0	Company record position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9b4e-462b-991d-a0ee33326454	67affcc3-762a-4fee-baa4-2a048ddd621e
27d984fd-a568-463a-9c3b-98e10046291a	20202020-fabc-451d-ab7d-412170916baa	d7124df1-9136-4b65-8c71-befa364161f2	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fabc-451d-ab7d-412170916baa	67affcc3-762a-4fee-baa4-2a048ddd621e
3ba862a0-5453-47b9-9b15-ea699b1f2e92	7444022e-b38f-4d4f-801b-cd664abc4834	d7124df1-9136-4b65-8c71-befa364161f2	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	7444022e-b38f-4d4f-801b-cd664abc4834	67affcc3-762a-4fee-baa4-2a048ddd621e
e88ed9cb-f344-418e-a14b-e850768768dc	85c71601-72f9-4b7b-b343-d46100b2c74d	d7124df1-9136-4b65-8c71-befa364161f2	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"domainNamePrimaryLinkLabel\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"domainNamePrimaryLinkUrl\\"), '') || ' ' || COALESCE(public.unaccent_immutable(TRANSLATE(regexp_replace(\\"domainNameSecondaryLinks\\"::text, '\\"(label|url)\\"\\\\s*:\\\\s*', '', 'g'), '[]{}\\",:', '        ')), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	85c71601-72f9-4b7b-b343-d46100b2c74d	67affcc3-762a-4fee-baa4-2a048ddd621e
892e0b4d-3d82-45dd-9f3d-a0fedd470186	20202020-c06a-4071-8a71-5c6d7e8f9aab	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c06a-4071-8a71-5c6d7e8f9aab	67affcc3-762a-4fee-baa4-2a048ddd621e
21af689d-502d-4d36-b3df-79838343e3d4	20202020-2456-464e-b422-b965a4db4a0b	e386c71a-338d-4a79-ae0e-792bc13d7c22	TEXT	handle	Handle	\N	Handle	IconAt	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2456-464e-b422-b965a4db4a0b	67affcc3-762a-4fee-baa4-2a048ddd621e
9eef1f4a-95bd-4ab9-897b-64c33c301130	20202020-c06b-4072-9b72-6d7e8f9aabbc	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c06b-4072-9b72-6d7e8f9aabbc	67affcc3-762a-4fee-baa4-2a048ddd621e
c9f10206-441e-4a8e-9566-43fc59aec227	20202020-c06c-4073-8c73-7e8f9aabbccd	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c06c-4073-8c73-7e8f9aabbccd	67affcc3-762a-4fee-baa4-2a048ddd621e
38a7c887-308a-4145-a3f9-bf98faff4cf6	20202020-c06d-4074-9d74-8f9aabbccdde	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c06d-4074-9d74-8f9aabbccdde	67affcc3-762a-4fee-baa4-2a048ddd621e
94a1f622-21d9-49f3-ad70-1a73ab196b3c	20202020-c804-4a50-bb05-b3a9e24f1dec	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	handle	handle	\N	The account handle (email, username, phone number, etc.)	IconMail	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c804-4a50-bb05-b3a9e24f1dec	67affcc3-762a-4fee-baa4-2a048ddd621e
4f44879c-c901-49aa-91dc-3b16f0edf0eb	20202020-ebb0-4516-befc-a9e95935efd5	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	provider	provider	"'google'"	The account provider	IconSettings	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ebb0-4516-befc-a9e95935efd5	67affcc3-762a-4fee-baa4-2a048ddd621e
5bfabd59-75bb-4918-aa35-1f3189fdc7c9	20202020-707b-4a0a-8753-2ad42efe1e29	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	accessToken	Access Token	\N	Messaging provider access token	IconKey	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-707b-4a0a-8753-2ad42efe1e29	67affcc3-762a-4fee-baa4-2a048ddd621e
dbb0c597-437d-4e01-9d24-6072acd193fa	20202020-532d-48bd-80a5-c4be6e7f6e49	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	refreshToken	Refresh Token	\N	Messaging provider refresh token	IconKey	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-532d-48bd-80a5-c4be6e7f6e49	67affcc3-762a-4fee-baa4-2a048ddd621e
41027667-c113-405d-ba65-5796d9056915	20202020-115c-4a87-b50f-ac4367a971b9	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	lastSyncHistoryId	Last sync history ID	\N	Last sync history ID	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-115c-4a87-b50f-ac4367a971b9	67affcc3-762a-4fee-baa4-2a048ddd621e
3015aec8-b269-4d6b-b735-a3196b2a834b	20202020-d268-4c6b-baff-400d402b430a	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	DATE_TIME	authFailedAt	Auth failed at	\N	Auth failed at	IconX	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d268-4c6b-baff-400d402b430a	67affcc3-762a-4fee-baa4-2a048ddd621e
1116a230-a29b-42d3-ac92-76074bf2c86c	20202020-aa5e-4e85-903b-fdf90a941941	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	DATE_TIME	lastCredentialsRefreshedAt	Last credentials refreshed at	\N	Last credentials refreshed at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-aa5e-4e85-903b-fdf90a941941	67affcc3-762a-4fee-baa4-2a048ddd621e
950d40b8-9910-4ac8-b8a4-54cd2ca8e95b	20202020-8a3d-46be-814f-6228af16c47b	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	TEXT	handleAliases	Handle Aliases	\N	Handle Aliases	IconMail	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8a3d-46be-814f-6228af16c47b	67affcc3-762a-4fee-baa4-2a048ddd621e
118273c1-9d00-496b-a51c-01df0242b7d6	20202020-8a3d-46be-814f-6228af16c47c	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	ARRAY	scopes	Scopes	\N	Scopes	IconSettings	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8a3d-46be-814f-6228af16c47c	67affcc3-762a-4fee-baa4-2a048ddd621e
2f87b679-2292-4d3d-a127-6f1a153c2105	20202020-a1b2-46be-814f-6228af16c481	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	RAW_JSON	connectionParameters	Custom Connection Parameters	\N	JSON object containing custom connection parameters	IconSettings	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a1b2-46be-814f-6228af16c481	67affcc3-762a-4fee-baa4-2a048ddd621e
b1c6d34d-abcd-4272-93f5-b8e7cde273c9	20202020-da1a-41d1-8ad1-abcdefabcdef	a34181a4-c008-4fcb-b55e-3f1bdf07d717	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-da1a-41d1-8ad1-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
d175b455-be7d-4ad4-86d9-657bc4fcb8e0	20202020-da1b-41d2-9bd2-bcdefabcdefa	a34181a4-c008-4fcb-b55e-3f1bdf07d717	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-da1b-41d2-9bd2-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
4ebade73-9b65-423b-9c2f-c6cfd34024b5	20202020-da1c-41d3-8cd3-cdefabcdefab	a34181a4-c008-4fcb-b55e-3f1bdf07d717	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-da1c-41d3-8cd3-cdefabcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
7c52af5c-068f-4781-89c8-4bc6b1b0b33b	20202020-da1d-41d4-9dd4-defabcdefabc	a34181a4-c008-4fcb-b55e-3f1bdf07d717	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-da1d-41d4-9dd4-defabcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
286c40b6-8226-4460-9494-a830db5ed6da	20202020-20ee-4091-95dc-44b57eda3a89	a34181a4-c008-4fcb-b55e-3f1bdf07d717	TEXT	title	Title	\N	Dashboard title	IconNotes	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-20ee-4091-95dc-44b57eda3a89	67affcc3-762a-4fee-baa4-2a048ddd621e
b2f1a804-eb95-4957-8604-d4df1dfe66fc	20202020-38af-409b-95f0-7f08aa5f420f	a34181a4-c008-4fcb-b55e-3f1bdf07d717	POSITION	position	Position	0	Dashboard record Position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-38af-409b-95f0-7f08aa5f420f	67affcc3-762a-4fee-baa4-2a048ddd621e
c1aa65a9-a5b1-494c-bd58-ac34ccdaeed3	20202020-bb53-4648-aa36-1d9d54e6f7f2	a34181a4-c008-4fcb-b55e-3f1bdf07d717	UUID	pageLayoutId	Page Layout ID	\N	Dashboard page layout	IconLayout	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-bb53-4648-aa36-1d9d54e6f7f2	67affcc3-762a-4fee-baa4-2a048ddd621e
1b9c75c3-c1ec-4637-bc1d-49f95c9ca27d	20202020-ff32-4fa1-b7ad-407cc6aa0734	a34181a4-c008-4fcb-b55e-3f1bdf07d717	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ff32-4fa1-b7ad-407cc6aa0734	67affcc3-762a-4fee-baa4-2a048ddd621e
a9bf5129-a52f-44d7-adc4-d14ab96b63f1	53ee42e7-f157-42b5-b278-a5fa9b378307	a34181a4-c008-4fcb-b55e-3f1bdf07d717	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	53ee42e7-f157-42b5-b278-a5fa9b378307	67affcc3-762a-4fee-baa4-2a048ddd621e
3c6f2b61-43ad-4bd1-a21a-1a3b4f6e8597	20202020-0bcc-47a4-8360-2e35a7133f7a	a34181a4-c008-4fcb-b55e-3f1bdf07d717	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"title\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0bcc-47a4-8360-2e35a7133f7a	67affcc3-762a-4fee-baa4-2a048ddd621e
4eec87a7-64e7-4b42-94a7-e5ccc6ac20c3	20202020-f01a-4091-8a91-ddeeffaabbcc	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01a-4091-8a91-ddeeffaabbcc	67affcc3-762a-4fee-baa4-2a048ddd621e
facc3e58-2c4d-4685-a357-e5a8aa60ca38	20202020-f01b-4092-9b92-eeffaabbccdd	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01b-4092-9b92-eeffaabbccdd	67affcc3-762a-4fee-baa4-2a048ddd621e
308fe297-3e00-443a-9bea-9e5047d8b629	20202020-f01c-4093-8c93-ffaabbccddee	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01c-4093-8c93-ffaabbccddee	67affcc3-762a-4fee-baa4-2a048ddd621e
50a2fc2d-78c1-4942-b872-be43342a7d3d	20202020-f01d-4094-9d94-aabbccddeeff	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01d-4094-9d94-aabbccddeeff	67affcc3-762a-4fee-baa4-2a048ddd621e
ab897251-f617-4b4e-96f2-7917037b89a8	20202020-dd26-42c6-8c3c-2a7598c204f6	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	NUMBER	position	Position	0	Favorite position	IconList	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-dd26-42c6-8c3c-2a7598c204f6	67affcc3-762a-4fee-baa4-2a048ddd621e
ca2164a4-54d0-4a6b-ad7d-422f1739c808	20202020-5a93-4fa9-acce-e73481a0bbdf	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	UUID	viewId	ViewId	\N	ViewId	IconView	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5a93-4fa9-acce-e73481a0bbdf	67affcc3-762a-4fee-baa4-2a048ddd621e
f3275490-eb65-4545-9143-43896b850a58	20202020-f02a-40a1-8aa1-1f2e3d4c5b6a	e471d18a-b548-4710-a2c2-3783966c373d	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02a-40a1-8aa1-1f2e3d4c5b6a	67affcc3-762a-4fee-baa4-2a048ddd621e
8cc558b2-bdff-4cdc-aa17-e4c1c523d376	20202020-f02b-40a2-9ba2-2f3e4d5c6b7a	e471d18a-b548-4710-a2c2-3783966c373d	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02b-40a2-9ba2-2f3e4d5c6b7a	67affcc3-762a-4fee-baa4-2a048ddd621e
507f94d8-1342-40c5-b781-b5b66559f716	20202020-f02c-40a3-8ca3-3f4e5d6c7b8a	e471d18a-b548-4710-a2c2-3783966c373d	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02c-40a3-8ca3-3f4e5d6c7b8a	67affcc3-762a-4fee-baa4-2a048ddd621e
57d8a5fe-906c-4126-ba2d-6cc30c6f92e2	20202020-f02d-40a4-9da4-4f5e6d7c8b9a	e471d18a-b548-4710-a2c2-3783966c373d	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02d-40a4-9da4-4f5e6d7c8b9a	67affcc3-762a-4fee-baa4-2a048ddd621e
2b5cb83a-64ef-4c0d-9b94-3f8a58b33162	20202020-5278-4bde-8909-2cec74d43744	e471d18a-b548-4710-a2c2-3783966c373d	NUMBER	position	Position	0	Favorite folder position	IconList	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5278-4bde-8909-2cec74d43744	67affcc3-762a-4fee-baa4-2a048ddd621e
46a5aa76-832a-45c9-9578-30a4b5dcdc96	20202020-82a3-4537-8ff0-dbce7eec35d6	e471d18a-b548-4710-a2c2-3783966c373d	TEXT	name	Name	\N	Name of the favorite folder	IconText	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-82a3-4537-8ff0-dbce7eec35d6	67affcc3-762a-4fee-baa4-2a048ddd621e
e392a376-02b9-435f-b1a6-b567de720228	20202020-b01a-40b1-8ab1-5a6b7c8d9eaf	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01a-40b1-8ab1-5a6b7c8d9eaf	67affcc3-762a-4fee-baa4-2a048ddd621e
206dedb2-cfae-4143-bcf6-83b32433231f	20202020-b01b-40b2-9bb2-6b7c8d9eafba	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01b-40b2-9bb2-6b7c8d9eafba	67affcc3-762a-4fee-baa4-2a048ddd621e
df02fbc5-da80-43c8-8d85-0a46325970db	20202020-b01c-40b3-8cb3-7c8d9eafbacb	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01c-40b3-8cb3-7c8d9eafbacb	67affcc3-762a-4fee-baa4-2a048ddd621e
a776a77c-b380-4494-a1f4-7288d7ab26bc	20202020-b01d-40b4-9db4-8d9eafbacbdc	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b01d-40b4-9db4-8d9eafbacbdc	67affcc3-762a-4fee-baa4-2a048ddd621e
c0f28c92-cb2b-436d-917a-4b2e6c038f79	20202020-37d6-438f-b6fd-6503596c8f34	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	TEXT	messageExternalId	Message External Id	\N	Message id from the messaging provider	IconHash	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-37d6-438f-b6fd-6503596c8f34	67affcc3-762a-4fee-baa4-2a048ddd621e
69472166-31b7-430a-b639-6e559b42c71c	20202020-35fb-421e-afa0-0b8e8f7f9018	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	TEXT	messageThreadExternalId	Thread External Id	\N	Thread id from the messaging provider	IconHash	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-35fb-421e-afa0-0b8e8f7f9018	67affcc3-762a-4fee-baa4-2a048ddd621e
f8786db3-2bf2-4419-b672-3bc031a1f6c4	75c9b0f7-9e76-44d4-a2f9-47051e61eec7	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	SELECT	direction	Direction	"'INCOMING'"	Message Direction	IconDirection	\N	[{"id": "acf0b8d8-7df9-473a-9118-75de3ab39473", "color": "green", "label": "Incoming", "value": "INCOMING", "position": 0}, {"id": "71cbe1c2-bc50-4742-95af-197238ca5adb", "color": "blue", "label": "Outgoing", "value": "OUTGOING", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	75c9b0f7-9e76-44d4-a2f9-47051e61eec7	67affcc3-762a-4fee-baa4-2a048ddd621e
97bca74d-b8d7-4f69-84f7-01931d1258fc	20202020-b02a-40c1-8ac1-9eafbacbdced	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b02a-40c1-8ac1-9eafbacbdced	67affcc3-762a-4fee-baa4-2a048ddd621e
a4519d5c-86e1-48a4-8ac0-4bc1e955fecd	20202020-b02b-40c2-9bc2-afbacbdcedfe	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b02b-40c2-9bc2-afbacbdcedfe	67affcc3-762a-4fee-baa4-2a048ddd621e
e99f64ca-4cf4-4b82-af56-4e314b6c1f0b	20202020-b02c-40c3-8cc3-bacbdcedfefa	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b02c-40c3-8cc3-bacbdcedfefa	67affcc3-762a-4fee-baa4-2a048ddd621e
0e381632-3535-4e78-8ec8-f237c0745ffd	20202020-b02d-40c4-9dc4-cbdcedfefaab	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b02d-40c4-9dc4-cbdcedfefaab	67affcc3-762a-4fee-baa4-2a048ddd621e
c69179c7-db17-48e2-b9bf-c3d85a0260e5	20202020-6a6b-4532-9767-cbc61b469453	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	visibility	Visibility	"'SHARE_EVERYTHING'"	Visibility	IconEyeglass	\N	[{"id": "87bdaa6c-2750-46db-aba4-7ea96b7912b5", "color": "green", "label": "Metadata", "value": "METADATA", "position": 0}, {"id": "f1ed18e3-ef98-4390-a2df-80c1e95c0039", "color": "blue", "label": "Subject", "value": "SUBJECT", "position": 1}, {"id": "4e9859b6-6740-4ac9-8751-ff555c8e41ed", "color": "orange", "label": "Share Everything", "value": "SHARE_EVERYTHING", "position": 2}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6a6b-4532-9767-cbc61b469453	67affcc3-762a-4fee-baa4-2a048ddd621e
b457a894-412e-4f9e-a687-58b3fec434fc	20202020-2c96-43c3-93e3-ed6b1acb69bc	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	TEXT	handle	Handle	\N	Handle	IconAt	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2c96-43c3-93e3-ed6b1acb69bc	67affcc3-762a-4fee-baa4-2a048ddd621e
7fc47798-c5a3-4309-9116-a0480188fe78	20202020-ae95-42d9-a3f1-797a2ea22122	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	type	Type	"'EMAIL'"	Channel Type	IconMessage	\N	[{"id": "638b520b-0341-4983-aef8-89dddaf150e9", "color": "green", "label": "Email", "value": "EMAIL", "position": 0}, {"id": "8d2ada87-14e1-4ae3-882e-8616a46d3eb8", "color": "blue", "label": "SMS", "value": "SMS", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ae95-42d9-a3f1-797a2ea22122	67affcc3-762a-4fee-baa4-2a048ddd621e
7be9cd5f-fa77-4479-b0e8-89602e8e1cfa	20202020-fabd-4f14-b7c6-3310f6d132c6	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	BOOLEAN	isContactAutoCreationEnabled	Is Contact Auto Creation Enabled	true	Is Contact Auto Creation Enabled	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fabd-4f14-b7c6-3310f6d132c6	67affcc3-762a-4fee-baa4-2a048ddd621e
ec30b041-9945-494e-a656-a89f8a11b47f	20202020-fc0e-4ba6-b259-a66ca89cfa38	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	contactAutoCreationPolicy	Contact auto creation policy	"'SENT'"	Automatically create People records when receiving or sending emails	IconUserCircle	\N	[{"id": "9155dc13-87cd-46b1-873b-0587d6b7528a", "color": "green", "label": "Sent and Received", "value": "SENT_AND_RECEIVED", "position": 0}, {"id": "3cb4568c-5646-47df-9ed0-f6fb14235589", "color": "blue", "label": "Sent", "value": "SENT", "position": 1}, {"id": "8ed0f9d2-859e-47f4-acea-a141fdc3f4af", "color": "red", "label": "None", "value": "NONE", "position": 2}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fc0e-4ba6-b259-a66ca89cfa38	67affcc3-762a-4fee-baa4-2a048ddd621e
068c9ed9-dbca-4708-bc9d-47b28bb8cb64	20202020-cc39-4432-9fe8-ec8ab8bbed95	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	messageFolderImportPolicy	Message folder import policy	"'ALL_FOLDERS'"	Message folder import policy	IconFolder	\N	[{"id": "1196a917-1c8f-4705-9b24-007c2ff7d9c8", "color": "green", "label": "All folders", "value": "ALL_FOLDERS", "position": 0}, {"id": "1e512dc1-40cf-4863-af60-60e26dc1c420", "color": "blue", "label": "Selected folders", "value": "SELECTED_FOLDERS", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cc39-4432-9fe8-ec8ab8bbed95	67affcc3-762a-4fee-baa4-2a048ddd621e
074aa3ab-9255-4d1c-b083-af8120e90c83	20202020-1df5-445d-b4f3-2413ad178431	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	BOOLEAN	excludeNonProfessionalEmails	Exclude non professional emails	true	Exclude non professional emails	IconBriefcase	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1df5-445d-b4f3-2413ad178431	67affcc3-762a-4fee-baa4-2a048ddd621e
d9729938-32d5-425e-8936-2016c05ea8b6	20202020-45a0-4be4-9164-5820a6a109fb	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	BOOLEAN	excludeGroupEmails	Exclude group emails	true	Exclude group emails	IconUsersGroup	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-45a0-4be4-9164-5820a6a109fb	67affcc3-762a-4fee-baa4-2a048ddd621e
066d647d-2534-469d-85de-27e6b20e5b16	20202020-17c5-4e9f-bc50-af46a89fdd42	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	pendingGroupEmailsAction	Pending group emails action	"'NONE'"	Pending action for group emails	IconUsersGroup	\N	[{"id": "b048cd8c-f906-46a2-a19c-162a69aae1a0", "color": "red", "label": "Group emails deletion", "value": "GROUP_EMAILS_DELETION", "position": 0}, {"id": "c6de1245-9901-421f-a50b-53091917d586", "color": "green", "label": "Group emails import", "value": "GROUP_EMAILS_IMPORT", "position": 1}, {"id": "b241d12f-81e8-4cec-b891-b3e58c62dff1", "color": "blue", "label": "None", "value": "NONE", "position": 2}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-17c5-4e9f-bc50-af46a89fdd42	67affcc3-762a-4fee-baa4-2a048ddd621e
ad0c3a88-2bb3-4c54-bb36-ebfe81638e3e	20202020-79d1-41cf-b738-bcf5ed61e256	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	TEXT	syncCursor	Last sync cursor	\N	Last sync cursor	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-79d1-41cf-b738-bcf5ed61e256	67affcc3-762a-4fee-baa4-2a048ddd621e
4d1de18d-4a61-4705-9817-cd923bb92633	20202020-263d-4c6b-ad51-137ada56f7d4	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	DATE_TIME	syncedAt	Last sync date	\N	Last sync date	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-263d-4c6b-ad51-137ada56f7d4	67affcc3-762a-4fee-baa4-2a048ddd621e
455aae1e-b2b1-441b-a0b1-edf94c40fb4e	20202020-56a1-4f7e-9880-a8493bb899cc	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	syncStatus	Sync status	\N	Sync status	IconStatusChange	\N	[{"id": "b32d68d2-6b20-4d4e-8662-0b2f7d25f4ec", "color": "yellow", "label": "Ongoing", "value": "ONGOING", "position": 1}, {"id": "7069c112-209f-4495-9341-7fc6e7dc9233", "color": "blue", "label": "Not Synced", "value": "NOT_SYNCED", "position": 2}, {"id": "93d1067e-6df7-4613-8e3f-659c65332ff4", "color": "green", "label": "Active", "value": "ACTIVE", "position": 3}, {"id": "3bd498b0-2ba1-4d7a-973a-44060064178f", "color": "red", "label": "Failed Insufficient Permissions", "value": "FAILED_INSUFFICIENT_PERMISSIONS", "position": 4}, {"id": "f28d3667-b939-44b4-9e65-f7c9da6dbea7", "color": "red", "label": "Failed Unknown", "value": "FAILED_UNKNOWN", "position": 5}]	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-56a1-4f7e-9880-a8493bb899cc	67affcc3-762a-4fee-baa4-2a048ddd621e
5e9e5627-258d-415f-90db-e43e32ab2f5e	20202020-7979-4b08-89fe-99cb5e698767	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	SELECT	syncStage	Sync stage	"'PENDING_CONFIGURATION'"	Sync stage	IconStatusChange	\N	[{"id": "2bc383fb-0c0a-4ce1-97b1-cc173c30ad73", "color": "blue", "label": "Messages list fetch pending", "value": "MESSAGE_LIST_FETCH_PENDING", "position": 0}, {"id": "69407058-e113-401c-9fdf-407982e60cf0", "color": "green", "label": "Messages list fetch scheduled", "value": "MESSAGE_LIST_FETCH_SCHEDULED", "position": 1}, {"id": "8fdd2024-3f06-4d9d-919c-c46e015a783e", "color": "orange", "label": "Messages list fetch ongoing", "value": "MESSAGE_LIST_FETCH_ONGOING", "position": 2}, {"id": "523663cb-955c-4a7d-a3e5-b141dbc02c43", "color": "blue", "label": "Messages import pending", "value": "MESSAGES_IMPORT_PENDING", "position": 3}, {"id": "abdc5d2e-1603-487c-9b76-c8ccf13000f1", "color": "green", "label": "Messages import scheduled", "value": "MESSAGES_IMPORT_SCHEDULED", "position": 4}, {"id": "574ba152-8396-4031-98f4-f67334cc050e", "color": "orange", "label": "Messages import ongoing", "value": "MESSAGES_IMPORT_ONGOING", "position": 5}, {"id": "cd006069-7b0a-48cf-9fc8-2a932785e2bd", "color": "red", "label": "Failed", "value": "FAILED", "position": 6}, {"id": "8ad54592-2600-485a-a634-ee58a6cd31cf", "color": "gray", "label": "Pending configuration", "value": "PENDING_CONFIGURATION", "position": 7}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7979-4b08-89fe-99cb5e698767	67affcc3-762a-4fee-baa4-2a048ddd621e
7dbea38d-0743-4682-9327-812886bbb4c9	20202020-8c61-4a42-ae63-73c1c3c52e06	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	DATE_TIME	syncStageStartedAt	Sync stage started at	\N	Sync stage started at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8c61-4a42-ae63-73c1c3c52e06	67affcc3-762a-4fee-baa4-2a048ddd621e
f21d14b6-0719-4233-9065-e9daff5da462	20202020-0291-42be-9ad0-d578a51684ab	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	NUMBER	throttleFailureCount	Throttle Failure Count	0	Throttle Failure Count	IconX	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0291-42be-9ad0-d578a51684ab	67affcc3-762a-4fee-baa4-2a048ddd621e
942e5d9b-ddac-4e34-8b3a-f3e8adfecfbb	20202020-b03a-40d1-8ad1-dcedfefaabbc	1e413633-a549-4d9a-9d79-f18adaa748e0	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b03a-40d1-8ad1-dcedfefaabbc	67affcc3-762a-4fee-baa4-2a048ddd621e
e5e53566-beef-4860-bf60-20485407dfe1	20202020-b03b-40d2-9bd2-edfefaabbccd	1e413633-a549-4d9a-9d79-f18adaa748e0	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b03b-40d2-9bd2-edfefaabbccd	67affcc3-762a-4fee-baa4-2a048ddd621e
055473ea-3d0f-4b8b-9159-11c8cc5444c8	20202020-b03c-40d3-8cd3-fefaabbccdde	1e413633-a549-4d9a-9d79-f18adaa748e0	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b03c-40d3-8cd3-fefaabbccdde	67affcc3-762a-4fee-baa4-2a048ddd621e
604381f6-611c-4644-abbb-3a7d370419bd	20202020-b03d-40d4-9dd4-faabbccddeef	1e413633-a549-4d9a-9d79-f18adaa748e0	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b03d-40d4-9dd4-faabbccddeef	67affcc3-762a-4fee-baa4-2a048ddd621e
2d2d18a9-fd00-45ad-8641-bda59017d0ba	20202020-7cf8-40bc-a681-b80b771449b7	1e413633-a549-4d9a-9d79-f18adaa748e0	TEXT	name	Name	\N	Folder name	IconFolder	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7cf8-40bc-a681-b80b771449b7	67affcc3-762a-4fee-baa4-2a048ddd621e
d3a6278a-4c79-4d36-a166-12db24e0a2cd	20202020-98cd-49ed-8dfc-cb5796400e64	1e413633-a549-4d9a-9d79-f18adaa748e0	TEXT	syncCursor	Sync Cursor	\N	Sync Cursor	IconHash	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-98cd-49ed-8dfc-cb5796400e64	67affcc3-762a-4fee-baa4-2a048ddd621e
c2b2941c-930d-4fd5-b97c-78bf640f8c0c	20202020-2af5-4a25-b2de-3c9386da941b	1e413633-a549-4d9a-9d79-f18adaa748e0	BOOLEAN	isSentFolder	Is Sent Folder	false	Is Sent Folder	IconCheck	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2af5-4a25-b2de-3c9386da941b	67affcc3-762a-4fee-baa4-2a048ddd621e
bd38b8ea-36c1-4014-a52d-6e9f8ec80d59	20202020-764f-4e09-8f95-cd46b6bfe3c4	1e413633-a549-4d9a-9d79-f18adaa748e0	BOOLEAN	isSynced	Is Synced	false	Is Synced	IconCheck	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-764f-4e09-8f95-cd46b6bfe3c4	67affcc3-762a-4fee-baa4-2a048ddd621e
8246d508-f09d-440a-adc6-d97e5403f8b5	20202020-e45d-49de-a4aa-587bbf9601f3	1e413633-a549-4d9a-9d79-f18adaa748e0	TEXT	parentFolderId	Parent Folder ID	\N	Parent Folder ID	IconFolder	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e45d-49de-a4aa-587bbf9601f3	67affcc3-762a-4fee-baa4-2a048ddd621e
caf0f59b-4431-4003-8d19-7e6a9dbd670e	20202020-f3a8-4d2b-9c7e-1b5f9a8e4c6d	1e413633-a549-4d9a-9d79-f18adaa748e0	TEXT	externalId	External ID	\N	External ID	IconHash	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f3a8-4d2b-9c7e-1b5f9a8e4c6d	67affcc3-762a-4fee-baa4-2a048ddd621e
4a68a6b5-dbf5-4a9c-bde3-6b370c817c39	20202020-4f97-4c79-9517-16387fe237f7	1e413633-a549-4d9a-9d79-f18adaa748e0	SELECT	pendingSyncAction	Pending Sync Action	"'NONE'"	Pending action for folder sync	IconReload	\N	[{"id": "17217ffe-7925-4f64-bcdf-3790c250323d", "color": "red", "label": "Folder deletion", "value": "FOLDER_DELETION", "position": 0}, {"id": "d4eb0332-70fd-4952-9534-6614186de86d", "color": "blue", "label": "None", "value": "NONE", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4f97-4c79-9517-16387fe237f7	67affcc3-762a-4fee-baa4-2a048ddd621e
fe1f6146-647c-4c61-9dbd-c780e9481d45	20202020-b04a-40e1-8ae1-1a2b3c4d5e6f	e386c71a-338d-4a79-ae0e-792bc13d7c22	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b04a-40e1-8ae1-1a2b3c4d5e6f	67affcc3-762a-4fee-baa4-2a048ddd621e
48e52454-4b81-4922-b5d2-aff9dcec2a34	20202020-b04b-40e2-9be2-2b3c4d5e6f7a	e386c71a-338d-4a79-ae0e-792bc13d7c22	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b04b-40e2-9be2-2b3c4d5e6f7a	67affcc3-762a-4fee-baa4-2a048ddd621e
0ee029bc-ae54-4d67-9914-eae788c8252e	20202020-b04c-40e3-8ce3-3c4d5e6f7a8b	e386c71a-338d-4a79-ae0e-792bc13d7c22	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b04c-40e3-8ce3-3c4d5e6f7a8b	67affcc3-762a-4fee-baa4-2a048ddd621e
2d091b12-593b-4604-bb96-2a5dcb30bf11	20202020-b04d-40e4-9de4-4d5e6f7a8b9c	e386c71a-338d-4a79-ae0e-792bc13d7c22	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b04d-40e4-9de4-4d5e6f7a8b9c	67affcc3-762a-4fee-baa4-2a048ddd621e
c8a6d293-b2f4-4125-9970-c2080ae1429a	20202020-65d1-42f4-8729-c9ec1f52aecd	e386c71a-338d-4a79-ae0e-792bc13d7c22	SELECT	role	Role	"'FROM'"	Role	IconAt	\N	[{"id": "3ab477a4-d519-4a9e-b812-d7d1a5a4c57e", "color": "green", "label": "From", "value": "FROM", "position": 0}, {"id": "fa37965f-3bf9-4485-9b40-9a6746c3b512", "color": "blue", "label": "To", "value": "TO", "position": 1}, {"id": "17b8f6d7-8177-4a51-8d83-ca585c81c15c", "color": "orange", "label": "Cc", "value": "CC", "position": 2}, {"id": "525fa64d-6f58-4c78-abcf-565d2c556859", "color": "red", "label": "Bcc", "value": "BCC", "position": 3}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-65d1-42f4-8729-c9ec1f52aecd	67affcc3-762a-4fee-baa4-2a048ddd621e
2645408d-0a21-4916-b21e-0abff5d14564	20202020-36dd-4a4f-ac02-228425be9fac	e386c71a-338d-4a79-ae0e-792bc13d7c22	TEXT	displayName	Display Name	\N	Display Name	IconUser	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-36dd-4a4f-ac02-228425be9fac	67affcc3-762a-4fee-baa4-2a048ddd621e
3ecfa8f2-854e-4d49-867e-0fbc4e7fb116	20202020-b05a-40f1-8af1-5e6f7a8b9cad	1c726159-0955-4b7d-9232-9971c71d0a38	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b05a-40f1-8af1-5e6f7a8b9cad	67affcc3-762a-4fee-baa4-2a048ddd621e
c5056d6c-206f-4c15-9cdc-961bd001663f	20202020-b05b-40f2-9bf2-6f7a8b9cadbe	1c726159-0955-4b7d-9232-9971c71d0a38	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b05b-40f2-9bf2-6f7a8b9cadbe	67affcc3-762a-4fee-baa4-2a048ddd621e
9beb4761-baf9-429d-bc0e-b98e5f975618	20202020-b05c-40f3-8cf3-7a8b9cadbecf	1c726159-0955-4b7d-9232-9971c71d0a38	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b05c-40f3-8cf3-7a8b9cadbecf	67affcc3-762a-4fee-baa4-2a048ddd621e
b3102ffc-0599-44df-b860-a4064884fc79	20202020-b05d-40f4-9df4-8b9cadbecfda	1c726159-0955-4b7d-9232-9971c71d0a38	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b05d-40f4-9df4-8b9cadbecfda	67affcc3-762a-4fee-baa4-2a048ddd621e
bc9f8455-5c9f-41d9-aed5-80ed77f21e90	20202020-b06a-4101-8a01-9cadbedfaeb1	bb71b55e-db18-48fe-ab10-9047b29b2e12	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b06a-4101-8a01-9cadbedfaeb1	67affcc3-762a-4fee-baa4-2a048ddd621e
db48f287-b86f-4699-beee-9c1522e1f92f	20202020-b06b-4102-9b02-adbecfeafbc2	bb71b55e-db18-48fe-ab10-9047b29b2e12	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b06b-4102-9b02-adbecfeafbc2	67affcc3-762a-4fee-baa4-2a048ddd621e
0109677a-42ab-4f43-a060-35a1dcc2b436	20202020-b06c-4103-8c03-becfdfabfcd3	bb71b55e-db18-48fe-ab10-9047b29b2e12	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b06c-4103-8c03-becfdfabfcd3	67affcc3-762a-4fee-baa4-2a048ddd621e
db157841-7886-49f8-8dad-7e2d672a48ed	20202020-b06d-4104-9d04-cfdfabecdde4	bb71b55e-db18-48fe-ab10-9047b29b2e12	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b06d-4104-9d04-cfdfabecdde4	67affcc3-762a-4fee-baa4-2a048ddd621e
f9090b38-32d0-428b-ae65-f81cf96d02e6	20202020-72b5-416d-aed8-b55609067d01	bb71b55e-db18-48fe-ab10-9047b29b2e12	TEXT	headerMessageId	Header message Id	\N	Message id from the message header	IconHash	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-72b5-416d-aed8-b55609067d01	67affcc3-762a-4fee-baa4-2a048ddd621e
cd29addc-5d8f-4e20-96be-788af8799c82	20202020-0203-4118-8e2a-05b9bdae6dab	bb71b55e-db18-48fe-ab10-9047b29b2e12	SELECT	direction	Direction	"'INCOMING'"	Message Direction	IconDirection	\N	[{"id": "883666e5-1eb0-470b-9c64-475ad531ad33", "color": "green", "label": "Incoming", "value": "INCOMING", "position": 0}, {"id": "7b47592e-7560-4bb0-973e-3806bf27defb", "color": "blue", "label": "Outgoing", "value": "OUTGOING", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0203-4118-8e2a-05b9bdae6dab	67affcc3-762a-4fee-baa4-2a048ddd621e
c39472d6-999f-43f6-bbd2-237473ad6d00	20202020-52d1-4036-b9ae-84bd722bb37a	bb71b55e-db18-48fe-ab10-9047b29b2e12	TEXT	subject	Subject	\N	Subject	IconMessage	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-52d1-4036-b9ae-84bd722bb37a	67affcc3-762a-4fee-baa4-2a048ddd621e
fd4cfe7a-0f8f-4d64-b14e-e08e3ab5c120	20202020-d2ee-4e7e-89de-9a0a9044a143	bb71b55e-db18-48fe-ab10-9047b29b2e12	TEXT	text	Text	\N	Text	IconMessage	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d2ee-4e7e-89de-9a0a9044a143	67affcc3-762a-4fee-baa4-2a048ddd621e
03d83c07-bdc8-40bd-bdb2-085dda8c9d3a	20202020-140a-4a2a-9f86-f13b6a979afc	bb71b55e-db18-48fe-ab10-9047b29b2e12	DATE_TIME	receivedAt	Received At	\N	The date the message was received	IconCalendar	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-140a-4a2a-9f86-f13b6a979afc	67affcc3-762a-4fee-baa4-2a048ddd621e
8e10a10a-7872-48ba-9d92-c300baa97219	20202020-c01a-4111-8a11-dfabcddeef12	415d12c3-c586-4222-9c41-994a99cebf67	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01a-4111-8a11-dfabcddeef12	67affcc3-762a-4fee-baa4-2a048ddd621e
33c68f92-052e-4150-896e-a7adc9f60605	20202020-c01b-4112-9b12-fabcddefe123	415d12c3-c586-4222-9c41-994a99cebf67	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01b-4112-9b12-fabcddefe123	67affcc3-762a-4fee-baa4-2a048ddd621e
21493ad3-c37c-4a6b-b400-527d031fd55d	20202020-c01c-4113-8c13-abcddeef1234	415d12c3-c586-4222-9c41-994a99cebf67	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01c-4113-8c13-abcddeef1234	67affcc3-762a-4fee-baa4-2a048ddd621e
6c1da12b-e052-40cf-bd51-260cc1bfb6be	20202020-c01d-4114-9d14-bcddeef12345	415d12c3-c586-4222-9c41-994a99cebf67	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c01d-4114-9d14-bcddeef12345	67affcc3-762a-4fee-baa4-2a048ddd621e
40510dff-d85c-4137-bd85-2ad1d75b63dc	20202020-368d-4dc2-943f-ed8a49c7fdfb	415d12c3-c586-4222-9c41-994a99cebf67	POSITION	position	Position	0	Note record position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-368d-4dc2-943f-ed8a49c7fdfb	67affcc3-762a-4fee-baa4-2a048ddd621e
099988d7-8eed-4ba1-9a37-74b783630ebf	20202020-faeb-4c76-8ba6-ccbb0b4a965f	415d12c3-c586-4222-9c41-994a99cebf67	TEXT	title	Title	\N	Note title	IconNotes	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-faeb-4c76-8ba6-ccbb0b4a965f	67affcc3-762a-4fee-baa4-2a048ddd621e
7273cfe0-2104-416b-ad94-9d70db31de35	20202020-a7bb-4d94-be51-8f25181502c8	415d12c3-c586-4222-9c41-994a99cebf67	RICH_TEXT_V2	bodyV2	Body	\N	Note body	IconFilePencil	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a7bb-4d94-be51-8f25181502c8	67affcc3-762a-4fee-baa4-2a048ddd621e
0b3a0236-449e-451a-b32b-ae28d3edeebb	20202020-0d79-4e21-ab77-5a394eff97be	415d12c3-c586-4222-9c41-994a99cebf67	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0d79-4e21-ab77-5a394eff97be	67affcc3-762a-4fee-baa4-2a048ddd621e
e1bf0d95-0f44-4297-aaf3-11cc7819e95b	9b446e89-2484-4044-a3b5-420f6b578c0c	415d12c3-c586-4222-9c41-994a99cebf67	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	9b446e89-2484-4044-a3b5-420f6b578c0c	67affcc3-762a-4fee-baa4-2a048ddd621e
0366a133-4c14-4b6b-902d-015357fb4fb5	20202020-7ea8-44d4-9d4c-51dd2a757950	415d12c3-c586-4222-9c41-994a99cebf67	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"title\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"bodyV2Markdown\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7ea8-44d4-9d4c-51dd2a757950	67affcc3-762a-4fee-baa4-2a048ddd621e
dc22e27a-bb55-4878-a076-eb99bf7e815d	20202020-c02a-4121-8a21-cddeef123456	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02a-4121-8a21-cddeef123456	67affcc3-762a-4fee-baa4-2a048ddd621e
651b8cf8-b229-491d-b1d0-d092053e42d1	20202020-c02b-4122-9b22-ddeef1234567	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02b-4122-9b22-ddeef1234567	67affcc3-762a-4fee-baa4-2a048ddd621e
dfc29a3d-e781-4fda-95a5-f7a1038252bc	20202020-c02c-4123-8c23-eef12345678a	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02c-4123-8c23-eef12345678a	67affcc3-762a-4fee-baa4-2a048ddd621e
65af9b26-ff79-42eb-b74c-4fe4f052e0b7	20202020-c02d-4124-9d24-ef123456789b	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c02d-4124-9d24-ef123456789b	67affcc3-762a-4fee-baa4-2a048ddd621e
ca15f5f8-8229-415f-9929-e9432161ae93	20202020-d01a-4131-8a31-f123456789ab	6d830113-2052-4566-a669-df61dd1cd970	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d01a-4131-8a31-f123456789ab	67affcc3-762a-4fee-baa4-2a048ddd621e
0936a820-f223-4a7a-b332-183afa912a2a	20202020-d01b-4132-9b32-123456789abc	6d830113-2052-4566-a669-df61dd1cd970	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d01b-4132-9b32-123456789abc	67affcc3-762a-4fee-baa4-2a048ddd621e
30218deb-9ae9-49bf-b841-482d4c4ad9d9	20202020-d01c-4133-8c33-23456789abcd	6d830113-2052-4566-a669-df61dd1cd970	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d01c-4133-8c33-23456789abcd	67affcc3-762a-4fee-baa4-2a048ddd621e
cb749941-4db5-4ca1-8809-8fcf62f1ce02	20202020-d01d-4134-9d34-3456789abcde	6d830113-2052-4566-a669-df61dd1cd970	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-d01d-4134-9d34-3456789abcde	67affcc3-762a-4fee-baa4-2a048ddd621e
dd0e308f-9482-4753-9ea6-bf04d49559d4	20202020-8609-4f65-a2d9-44009eb422b5	6d830113-2052-4566-a669-df61dd1cd970	TEXT	name	Name	\N	The opportunity name	IconTargetArrow	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8609-4f65-a2d9-44009eb422b5	67affcc3-762a-4fee-baa4-2a048ddd621e
2eb74dc4-86a4-491b-bdb4-4ead9f61074b	20202020-583e-4642-8533-db761d5fa82f	6d830113-2052-4566-a669-df61dd1cd970	CURRENCY	amount	Amount	\N	Opportunity amount	IconCurrencyDollar	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-583e-4642-8533-db761d5fa82f	67affcc3-762a-4fee-baa4-2a048ddd621e
de5aa019-e0b2-4294-95b4-cdfb4bb0cccf	20202020-527e-44d6-b1ac-c4158d307b97	6d830113-2052-4566-a669-df61dd1cd970	DATE_TIME	closeDate	Close date	\N	Opportunity close date	IconCalendarEvent	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-527e-44d6-b1ac-c4158d307b97	67affcc3-762a-4fee-baa4-2a048ddd621e
df2411c7-21a9-414e-a3f7-cd9466bbbb5b	20202020-6f76-477d-8551-28cd65b2b4b9	6d830113-2052-4566-a669-df61dd1cd970	SELECT	stage	Stage	"'NEW'"	Opportunity stage	IconProgressCheck	\N	[{"id": "017d6f4b-8cc3-4798-b0b9-71d4e40fc2ed", "color": "red", "label": "New", "value": "NEW", "position": 0}, {"id": "7cc6a565-c4ac-447c-88b9-3fc8bdf1c814", "color": "purple", "label": "Screening", "value": "SCREENING", "position": 1}, {"id": "4a3beade-bbf2-40d7-8e81-4ec5d4e230a4", "color": "sky", "label": "Meeting", "value": "MEETING", "position": 2}, {"id": "157e8c3b-46b5-4e65-a596-0b366c721cf5", "color": "turquoise", "label": "Proposal", "value": "PROPOSAL", "position": 3}, {"id": "92342fe2-4ed4-4998-b18c-10541ae19a42", "color": "yellow", "label": "Customer", "value": "CUSTOMER", "position": 4}]	\N	f	t	f	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6f76-477d-8551-28cd65b2b4b9	67affcc3-762a-4fee-baa4-2a048ddd621e
5e597d83-b264-42bf-b8d1-83273c254bf6	20202020-806d-493a-bbc6-6313e62958e2	6d830113-2052-4566-a669-df61dd1cd970	POSITION	position	Position	0	Opportunity record position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-806d-493a-bbc6-6313e62958e2	67affcc3-762a-4fee-baa4-2a048ddd621e
00de92ff-6bd3-4f01-80c0-380acbefa1ae	20202020-a63e-4a62-8e63-42a51828f831	6d830113-2052-4566-a669-df61dd1cd970	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a63e-4a62-8e63-42a51828f831	67affcc3-762a-4fee-baa4-2a048ddd621e
3101725d-6766-466e-b6bc-1d6a2db79440	3c8a6095-3f64-4e81-a59e-66c2bd181e11	6d830113-2052-4566-a669-df61dd1cd970	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	3c8a6095-3f64-4e81-a59e-66c2bd181e11	67affcc3-762a-4fee-baa4-2a048ddd621e
9f0549ef-28da-44e5-b311-186cb3ebdbb4	428a0da5-4b2e-4ce3-b695-89a8b384e6e3	6d830113-2052-4566-a669-df61dd1cd970	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	428a0da5-4b2e-4ce3-b695-89a8b384e6e3	67affcc3-762a-4fee-baa4-2a048ddd621e
31e1074c-19ff-43fa-8b33-2698b2303543	20202020-e01a-4141-8a41-456789abcdef	41a553bd-c463-40f2-88bc-07967f17a128	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e01a-4141-8a41-456789abcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
5d6377af-c259-42b8-990f-2aecee76b735	20202020-e01b-4142-9b42-56789abcdefa	41a553bd-c463-40f2-88bc-07967f17a128	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e01b-4142-9b42-56789abcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
f3bcb349-a1f6-4df7-b3e8-bd0b583b0f6d	20202020-e01c-4143-8c43-6789abcdefab	41a553bd-c463-40f2-88bc-07967f17a128	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e01c-4143-8c43-6789abcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
b43ef192-1cdf-48b1-8078-31a45059dfd9	20202020-e01d-4144-9d44-789abcdefabc	41a553bd-c463-40f2-88bc-07967f17a128	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e01d-4144-9d44-789abcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
21455064-b26f-477e-a8c5-61fba1cf2b7c	20202020-3875-44d5-8c33-a6239011cab8	41a553bd-c463-40f2-88bc-07967f17a128	FULL_NAME	name	Name	\N	Contact's name	IconUser	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3875-44d5-8c33-a6239011cab8	67affcc3-762a-4fee-baa4-2a048ddd621e
b64330db-9052-46c7-b5f0-b8de5f214aed	20202020-3c51-43fa-8b6e-af39e29368ab	41a553bd-c463-40f2-88bc-07967f17a128	EMAILS	emails	Emails	\N	Contact's Emails	IconMail	\N	\N	{"maxNumberOfValues": 1}	f	t	f	f	t	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3c51-43fa-8b6e-af39e29368ab	67affcc3-762a-4fee-baa4-2a048ddd621e
cdf1b3a0-2d56-456c-af74-2fa3fecda88e	20202020-f1af-48f7-893b-2007a73dd508	41a553bd-c463-40f2-88bc-07967f17a128	LINKS	linkedinLink	Linkedin	\N	Contact's Linkedin account	IconBrandLinkedin	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f1af-48f7-893b-2007a73dd508	67affcc3-762a-4fee-baa4-2a048ddd621e
496d6527-3e40-47f7-90c2-a961ed6bc61f	20202020-8fc2-487c-b84a-55a99b145cfd	41a553bd-c463-40f2-88bc-07967f17a128	LINKS	xLink	X	\N	Contact's X/Twitter account	IconBrandX	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8fc2-487c-b84a-55a99b145cfd	67affcc3-762a-4fee-baa4-2a048ddd621e
14efd992-f9df-4e37-9fb8-2fd2706e9cc0	20202020-b0d0-415a-bef9-640a26dacd9b	41a553bd-c463-40f2-88bc-07967f17a128	TEXT	jobTitle	Job Title	\N	Contact's job title	IconBriefcase	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b0d0-415a-bef9-640a26dacd9b	67affcc3-762a-4fee-baa4-2a048ddd621e
14f2066d-8a1b-4281-b3eb-6837ddccdc3c	20202020-0638-448e-8825-439134618022	41a553bd-c463-40f2-88bc-07967f17a128	PHONES	phones	Phones	\N	Contact's phone numbers	IconPhone	\N	\N	{"maxNumberOfValues": 1}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0638-448e-8825-439134618022	67affcc3-762a-4fee-baa4-2a048ddd621e
f382801e-a486-470c-a0d2-c11adaa2122b	20202020-5243-4ffb-afc5-2c675da41346	41a553bd-c463-40f2-88bc-07967f17a128	TEXT	city	City	\N	Contact's city	IconMap	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5243-4ffb-afc5-2c675da41346	67affcc3-762a-4fee-baa4-2a048ddd621e
46c9dd40-91dc-4784-80a7-227e1f5c3040	20202020-b8a6-40df-961c-373dc5d2ec21	41a553bd-c463-40f2-88bc-07967f17a128	TEXT	avatarUrl	Avatar	\N	Contact's avatar	IconFileUpload	\N	\N	\N	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b8a6-40df-961c-373dc5d2ec21	67affcc3-762a-4fee-baa4-2a048ddd621e
152f566f-9340-4fc1-8cf5-d748a388937b	20202020-fcd5-4231-aff5-fff583eaa0b1	41a553bd-c463-40f2-88bc-07967f17a128	POSITION	position	Position	0	Person record Position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fcd5-4231-aff5-fff583eaa0b1	67affcc3-762a-4fee-baa4-2a048ddd621e
f33c4cd0-c9ea-4dbc-b6df-c19f5948b459	20202020-f6ab-4d98-af24-a3d5b664148a	41a553bd-c463-40f2-88bc-07967f17a128	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f6ab-4d98-af24-a3d5b664148a	67affcc3-762a-4fee-baa4-2a048ddd621e
701fc28e-6b61-4315-8a1e-83829a06e3fe	e9e0dd35-184c-4742-84da-afadf45ce59a	41a553bd-c463-40f2-88bc-07967f17a128	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	e9e0dd35-184c-4742-84da-afadf45ce59a	67affcc3-762a-4fee-baa4-2a048ddd621e
65d0a979-444b-45ed-b7a7-1a8f08b4a871	20202020-2e0e-48c0-b445-ee6c1e61687d	16136df1-455c-4a8b-8bb6-e98e1d03b033	UUID	linkedRecordId	Linked Record id	\N	Linked Record id	IconAbc	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2e0e-48c0-b445-ee6c1e61687d	67affcc3-762a-4fee-baa4-2a048ddd621e
d95c59d7-d8d6-4985-aae7-aac1b386a310	20202020-c595-449d-9f89-562758c9ee69	16136df1-455c-4a8b-8bb6-e98e1d03b033	UUID	linkedObjectMetadataId	Linked Object Metadata Id	\N	Linked Object Metadata Id	IconAbc	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c595-449d-9f89-562758c9ee69	67affcc3-762a-4fee-baa4-2a048ddd621e
1101230f-0158-4ac2-85be-c8f8e6782a92	20202020-f02a-4181-8a81-efabcdefabcd	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02a-4181-8a81-efabcdefabcd	67affcc3-762a-4fee-baa4-2a048ddd621e
ce7df1af-4f2f-45bd-b2b2-b78d3d634289	20202020-f02b-4182-9b82-fabcdefabcde	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02b-4182-9b82-fabcdefabcde	67affcc3-762a-4fee-baa4-2a048ddd621e
40c9821b-3517-4397-951c-441bc1b78472	20202020-f02c-4183-8c83-abcdefabcdef	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02c-4183-8c83-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
2b0fdcee-33cd-4079-ad7c-d6a56c9222e0	57d1d7ad-fa10-44fc-82f3-ad0959ec2534	41a553bd-c463-40f2-88bc-07967f17a128	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"nameFirstName\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"nameLastName\\"), '') || ' ' || \\n      COALESCE(public.unaccent_immutable(\\"emailsPrimaryEmail\\"), '') || ' ' ||\\n      COALESCE(public.unaccent_immutable(SPLIT_PART(\\"emailsPrimaryEmail\\", '@', 2)), '') || ' ' || COALESCE(public.unaccent_immutable(TRANSLATE(\\"emailsAdditionalEmails\\"::text, '[]\\",', '    ')), '') || ' ' || COALESCE(public.unaccent_immutable(TRANSLATE(REPLACE(\\"emailsAdditionalEmails\\"::text, '@', ' '), '[]\\",', '    ')), '') || ' ' || COALESCE(\\"phonesPrimaryPhoneNumber\\", '') || ' ' || COALESCE(\\"phonesPrimaryPhoneCallingCode\\", '') || ' ' || COALESCE(\\"phonesPrimaryPhoneCallingCode\\" || \\"phonesPrimaryPhoneNumber\\", '') || ' ' || COALESCE(REPLACE(\\"phonesPrimaryPhoneCallingCode\\", '+', '') || \\"phonesPrimaryPhoneNumber\\", '') || ' ' || COALESCE('0' || \\"phonesPrimaryPhoneNumber\\", '') || ' ' || COALESCE(TRANSLATE(regexp_replace(\\"phonesAdditionalPhones\\"::text, '\\"(number|countryCode|callingCode)\\"\\\\s*:\\\\s*', '', 'g'), '[]{}\\",:', '        '), '') || ' ' || COALESCE(public.unaccent_immutable(\\"jobTitle\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	57d1d7ad-fa10-44fc-82f3-ad0959ec2534	67affcc3-762a-4fee-baa4-2a048ddd621e
75d56052-89b4-42d2-a8aa-dc5317e74376	20202020-a02a-4151-8a51-89abcdefabcd	ff60777a-2722-4aa0-ba66-a8e089c7bc94	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a02a-4151-8a51-89abcdefabcd	67affcc3-762a-4fee-baa4-2a048ddd621e
dc0189d7-a50a-45f0-88c1-475e8f8a70d4	20202020-a02b-4152-9b52-9abcdefabcde	ff60777a-2722-4aa0-ba66-a8e089c7bc94	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a02b-4152-9b52-9abcdefabcde	67affcc3-762a-4fee-baa4-2a048ddd621e
0c56b7b2-8c47-4a72-bc0e-65ba50308b8e	20202020-a02c-4153-8c53-abcdefabcdef	ff60777a-2722-4aa0-ba66-a8e089c7bc94	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a02c-4153-8c53-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
404ba650-4f78-4f73-bf40-d9143491afeb	20202020-a02d-4154-9d54-bcdefabcdefa	ff60777a-2722-4aa0-ba66-a8e089c7bc94	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a02d-4154-9d54-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
ef3a335a-6942-46fe-95e0-a7f45db99c80	20202020-7d47-4690-8a98-98b9a0c05dd8	ff60777a-2722-4aa0-ba66-a8e089c7bc94	POSITION	position	Position	0	Task record position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7d47-4690-8a98-98b9a0c05dd8	67affcc3-762a-4fee-baa4-2a048ddd621e
608fec74-7af7-4fd2-8ebf-efdff84c5046	20202020-b386-4cb7-aa5a-08d4a4d92680	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TEXT	title	Title	\N	Task title	IconNotes	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b386-4cb7-aa5a-08d4a4d92680	67affcc3-762a-4fee-baa4-2a048ddd621e
6d4d4bb5-15fc-487b-a824-5b2a81a525ca	20202020-4aa0-4ae8-898d-7df0afd47ab1	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RICH_TEXT_V2	bodyV2	Body	\N	Task body	IconFilePencil	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4aa0-4ae8-898d-7df0afd47ab1	67affcc3-762a-4fee-baa4-2a048ddd621e
19845777-baef-4f8b-a9e0-75f92befc26e	20202020-fd99-40da-951b-4cb9a352fce3	ff60777a-2722-4aa0-ba66-a8e089c7bc94	DATE_TIME	dueAt	Due Date	\N	Task due date	IconCalendarEvent	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fd99-40da-951b-4cb9a352fce3	67affcc3-762a-4fee-baa4-2a048ddd621e
9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	20202020-70bc-48f9-89c5-6aa730b151e0	ff60777a-2722-4aa0-ba66-a8e089c7bc94	SELECT	status	Status	"'TODO'"	Task status	IconCheck	\N	[{"id": "8ade4800-0587-4527-9222-f208f1dc9afa", "color": "sky", "label": "To do", "value": "TODO", "position": 0}, {"id": "0750555b-c8d0-441d-aa35-79c6242e4b1a", "color": "purple", "label": "In progress", "value": "IN_PROGRESS", "position": 1}, {"id": "34d68641-2950-4aaa-85fb-96ef7fe7026c", "color": "green", "label": "Done", "value": "DONE", "position": 2}]	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-70bc-48f9-89c5-6aa730b151e0	67affcc3-762a-4fee-baa4-2a048ddd621e
f152855b-c6b6-4190-b3e3-0a7fbfb88d50	20202020-1a04-48ab-a567-576965ae5387	ff60777a-2722-4aa0-ba66-a8e089c7bc94	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1a04-48ab-a567-576965ae5387	67affcc3-762a-4fee-baa4-2a048ddd621e
d72568f8-b423-4339-a396-bb85019a84f1	9e8bf518-f4ab-433e-9674-efb75fba2802	ff60777a-2722-4aa0-ba66-a8e089c7bc94	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	9e8bf518-f4ab-433e-9674-efb75fba2802	67affcc3-762a-4fee-baa4-2a048ddd621e
0c75bb8d-53dc-4fee-99c1-d6a059818400	20202020-4746-4e2f-870c-52b02c67c90d	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"title\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"bodyV2Markdown\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4746-4e2f-870c-52b02c67c90d	67affcc3-762a-4fee-baa4-2a048ddd621e
dee7bada-a04f-49d4-8a2c-11cc1555265a	20202020-a03a-4161-8a61-cdefabcdefab	77864c8b-b2cf-43bd-8fab-3e77052c50b7	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a03a-4161-8a61-cdefabcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
95e4ef85-66df-4414-a01d-ff1cb1aa56fa	20202020-a03b-4162-9b62-defabcdefabc	77864c8b-b2cf-43bd-8fab-3e77052c50b7	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a03b-4162-9b62-defabcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
f018082f-385a-4051-9833-a8bba9c0b76f	20202020-a03c-4163-8c63-efabcdefabcd	77864c8b-b2cf-43bd-8fab-3e77052c50b7	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a03c-4163-8c63-efabcdefabcd	67affcc3-762a-4fee-baa4-2a048ddd621e
a4a460a0-6595-4117-88d8-4efeb3059929	20202020-a03d-4164-9d64-fabcdefabcde	77864c8b-b2cf-43bd-8fab-3e77052c50b7	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a03d-4164-9d64-fabcdefabcde	67affcc3-762a-4fee-baa4-2a048ddd621e
c76d2216-c09f-4cbd-ac42-eb02fdf05e79	20202020-a01a-4081-8a81-9aabbccddeff	16136df1-455c-4a8b-8bb6-e98e1d03b033	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01a-4081-8a81-9aabbccddeff	67affcc3-762a-4fee-baa4-2a048ddd621e
1e81fe70-8768-4067-b114-edde51e294b3	20202020-a01b-4082-9b82-aabbccddeeff	16136df1-455c-4a8b-8bb6-e98e1d03b033	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01b-4082-9b82-aabbccddeeff	67affcc3-762a-4fee-baa4-2a048ddd621e
da5e0c26-d509-4d8e-9374-0e6622262ee3	20202020-a01c-4083-8c83-bbccddeeffaa	16136df1-455c-4a8b-8bb6-e98e1d03b033	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01c-4083-8c83-bbccddeeffaa	67affcc3-762a-4fee-baa4-2a048ddd621e
ba94c337-4bcb-4429-a0ca-f7096c375ce1	20202020-a01d-4084-9d84-ccddeeffaabb	16136df1-455c-4a8b-8bb6-e98e1d03b033	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a01d-4084-9d84-ccddeeffaabb	67affcc3-762a-4fee-baa4-2a048ddd621e
81a74ab2-afb3-4783-b37f-3ed1edd556e1	20202020-9526-4993-b339-c4318c4d39f0	16136df1-455c-4a8b-8bb6-e98e1d03b033	DATE_TIME	happensAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9526-4993-b339-c4318c4d39f0	67affcc3-762a-4fee-baa4-2a048ddd621e
b4869ecb-fb0c-4dd9-8e77-53f0eb8c544f	20202020-7207-46e8-9dab-849505ae8497	16136df1-455c-4a8b-8bb6-e98e1d03b033	TEXT	name	Event name	\N	Event name	IconAbc	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7207-46e8-9dab-849505ae8497	67affcc3-762a-4fee-baa4-2a048ddd621e
580866f8-10f8-4b9b-94fb-0310ac168782	20202020-f142-4b04-b91b-6a2b4af3bf11	16136df1-455c-4a8b-8bb6-e98e1d03b033	RAW_JSON	properties	Event details	\N	Json value for event details	IconListDetails	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f142-4b04-b91b-6a2b4af3bf11	67affcc3-762a-4fee-baa4-2a048ddd621e
7bac464b-131e-4eaa-b6d4-2ded3d9d4534	20202020-cfdb-4bef-bbce-a29f41230934	16136df1-455c-4a8b-8bb6-e98e1d03b033	TEXT	linkedRecordCachedName	Linked Record cached name	\N	Cached record name	IconAbc	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cfdb-4bef-bbce-a29f41230934	67affcc3-762a-4fee-baa4-2a048ddd621e
643b72ab-7689-48a0-ba66-f8f83e42ed52	20202020-f02d-4184-9d84-bcdefabcdefa	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f02d-4184-9d84-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
4c01aa1f-28f7-4722-a195-6a44586e91d6	20202020-b3d3-478f-acc0-5d901e725b20	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	TEXT	name	Name	\N	The workflow name	IconSettingsAutomation	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b3d3-478f-acc0-5d901e725b20	67affcc3-762a-4fee-baa4-2a048ddd621e
cd7a435d-bfdf-4c71-bb5c-3a1c9deb7f61	20202020-326a-4fba-8639-3456c0a169e8	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	TEXT	lastPublishedVersionId	Last published Version Id	\N	The workflow last published version id	IconVersions	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-326a-4fba-8639-3456c0a169e8	67affcc3-762a-4fee-baa4-2a048ddd621e
23a8bee0-dd14-4c8e-82ee-fb2203b68836	20202020-357c-4432-8c50-8c31b4a552d9	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	MULTI_SELECT	statuses	Statuses	\N	The current statuses of the workflow versions	IconStatusChange	\N	[{"id": "8cb0919e-0bf5-4c12-9caf-281d9e262400", "color": "yellow", "label": "Draft", "value": "DRAFT", "position": 0}, {"id": "74793bc1-0762-4244-873b-50d3413855a9", "color": "green", "label": "Active", "value": "ACTIVE", "position": 1}, {"id": "c34806a4-34c2-4fea-bb64-b97eb23251cd", "color": "gray", "label": "Deactivated", "value": "DEACTIVATED", "position": 2}]	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-357c-4432-8c50-8c31b4a552d9	67affcc3-762a-4fee-baa4-2a048ddd621e
8b3357c8-77c2-4867-8faf-a6dd45273826	20202020-39b0-4d8c-8c5f-33c2326deb5f	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	POSITION	position	Position	0	Workflow record position	IconHierarchy2	\N	\N	\N	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-39b0-4d8c-8c5f-33c2326deb5f	67affcc3-762a-4fee-baa4-2a048ddd621e
97af09e7-f632-4982-81e4-ef7a50d16d84	20202020-6007-401a-8aa5-e6f48581a6f3	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	ACTOR	createdBy	Created by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6007-401a-8aa5-e6f48581a6f3	67affcc3-762a-4fee-baa4-2a048ddd621e
95d50f3a-a179-4df7-b5a7-661312e75d78	3559831e-caf2-4eb5-9db1-b47bf968c774	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	3559831e-caf2-4eb5-9db1-b47bf968c774	67affcc3-762a-4fee-baa4-2a048ddd621e
6dbf5856-35d4-4571-97ac-c1a89af26f59	20202020-535d-4ffa-b7f3-4fa0d5da1b7a	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-535d-4ffa-b7f3-4fa0d5da1b7a	67affcc3-762a-4fee-baa4-2a048ddd621e
48a65724-218d-4475-96d8-758794381309	20202020-f01a-4171-8a71-abcdefabcdef	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01a-4171-8a71-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
11a747dd-5800-470b-9a57-66c12d0a104a	20202020-f01b-4172-9b72-bcdefabcdefa	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01b-4172-9b72-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
b00a01aa-5867-4c8b-952b-b084914718e0	20202020-f01c-4173-8c73-cdefabcdefab	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01c-4173-8c73-cdefabcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
5a1683c1-5275-414d-9b17-9bcc402bafb7	20202020-f01d-4174-9d74-defabcdefabc	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f01d-4174-9d74-defabcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
21ee78f6-f8c9-4088-b146-ef8ea73c7b1c	20202020-3319-4234-a34c-3f92c1ab56e7	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	SELECT	type	Automated Trigger Type	\N	The workflow automated trigger type	IconSettingsAutomation	\N	[{"id": "0d1cec33-c7c2-4281-8764-aae709e47815", "color": "green", "label": "Database Event", "value": "DATABASE_EVENT", "position": 0}, {"id": "8e5e9820-f28f-4805-9337-11df65731d47", "color": "blue", "label": "Cron", "value": "CRON", "position": 1}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3319-4234-a34c-3f92c1ab56e7	67affcc3-762a-4fee-baa4-2a048ddd621e
b2ee475d-0598-4196-a817-c208e09314c6	20202020-3319-4234-a34c-bac8f903de12	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	RAW_JSON	settings	Settings	\N	The workflow automated trigger settings	IconSettings	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3319-4234-a34c-bac8f903de12	67affcc3-762a-4fee-baa4-2a048ddd621e
a9e271aa-1fe1-474d-af12-32f91a518579	20202020-f03a-4191-8a91-cdefabcdefab	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f03a-4191-8a91-cdefabcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
0b6c6dc9-8e7a-4917-99eb-6c73ecad36ae	20202020-f03b-4192-9b92-defabcdefabc	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f03b-4192-9b92-defabcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
8072a095-6fd6-4d72-bc3f-920601d825e2	20202020-f03c-4193-8c93-efabcdefabcd	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f03c-4193-8c93-efabcdefabcd	67affcc3-762a-4fee-baa4-2a048ddd621e
d9cbb0a1-a74d-43d1-b7d8-6c969aa85c31	20202020-f03d-4194-9d94-fabcdefabcde	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f03d-4194-9d94-fabcdefabcde	67affcc3-762a-4fee-baa4-2a048ddd621e
2d5c5097-d9f2-407e-95a6-45ddd91f674f	20202020-b840-4253-aef9-4e5013694587	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	TEXT	name	Name	\N	Name of the workflow run	IconSettingsAutomation	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b840-4253-aef9-4e5013694587	67affcc3-762a-4fee-baa4-2a048ddd621e
d1638528-123e-4478-9eb7-492845a47669	20202020-f1e3-4de1-a461-b5c4fdbc861d	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	enqueuedAt	Workflow run enqueued at	\N	Workflow run enqueued at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f1e3-4de1-a461-b5c4fdbc861d	67affcc3-762a-4fee-baa4-2a048ddd621e
6497ce2d-5d29-47b3-9428-9822d0ab82a5	20202020-a234-4e2d-bd15-85bcea6bb183	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	startedAt	Workflow run started at	\N	Workflow run started at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a234-4e2d-bd15-85bcea6bb183	67affcc3-762a-4fee-baa4-2a048ddd621e
64b8068d-9aaa-49bb-9ba4-cde73d43bce7	20202020-e1c1-4b6b-bbbd-b2beaf2e159e	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	DATE_TIME	endedAt	Workflow run ended at	\N	Workflow run ended at	IconHistory	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e1c1-4b6b-bbbd-b2beaf2e159e	67affcc3-762a-4fee-baa4-2a048ddd621e
1cd7d5b1-2f94-4b5c-8310-8f1ea6cf8d88	20202020-6b3e-4f9c-8c2b-2e5b8e6d6f3b	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	SELECT	status	Workflow run status	"'NOT_STARTED'"	Workflow run status	IconStatusChange	\N	[{"id": "04d0854d-ab80-4706-aa68-a7bea5886084", "color": "gray", "label": "Not started", "value": "NOT_STARTED", "position": 0}, {"id": "ec1be987-3506-499b-8c61-c9e2ee91348f", "color": "yellow", "label": "Running", "value": "RUNNING", "position": 1}, {"id": "5dc5585a-0a91-452f-8cbc-99010c017ac7", "color": "green", "label": "Completed", "value": "COMPLETED", "position": 2}, {"id": "b3da4ef6-cb85-43da-8167-2480f81db518", "color": "red", "label": "Failed", "value": "FAILED", "position": 3}, {"id": "96706acf-21fb-4552-af6a-03c7ece3bac1", "color": "blue", "label": "Enqueued", "value": "ENQUEUED", "position": 4}, {"id": "0497df26-1928-4a2b-9055-c0dab0fe856a", "color": "orange", "label": "Stopping", "value": "STOPPING", "position": 5}, {"id": "171d7c28-b1ef-4594-ace4-fb12236afb07", "color": "gray", "label": "Stopped", "value": "STOPPED", "position": 6}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6b3e-4f9c-8c2b-2e5b8e6d6f3b	67affcc3-762a-4fee-baa4-2a048ddd621e
5e9e6bba-e384-4f18-bc17-aed218f0cfc1	20202020-6007-401a-8aa5-e6f38581a6f3	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	ACTOR	createdBy	Executed by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The executor of the workflow	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6007-401a-8aa5-e6f38581a6f3	67affcc3-762a-4fee-baa4-2a048ddd621e
554e6e50-3692-4cd6-80a7-1f36d2ce9ee8	730dc1c9-34f5-4c22-84a6-bcb55b7604e2	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	ACTOR	updatedBy	Updated by	{"name": "'System'", "source": "'MANUAL'", "workspaceMemberId": null}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	730dc1c9-34f5-4c22-84a6-bcb55b7604e2	67affcc3-762a-4fee-baa4-2a048ddd621e
7a3973a2-77fc-40e0-9878-964bf5916e01	20202020-611f-45f3-9cde-d64927e8ec57	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RAW_JSON	state	State	\N	State of the workflow run	IconHierarchy2	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-611f-45f3-9cde-d64927e8ec57	67affcc3-762a-4fee-baa4-2a048ddd621e
69d80227-df0e-4cfd-9b19-0ff388316e51	20202020-189c-478a-b867-d72feaf5926a	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RAW_JSON	context	Context	\N	Context of the workflow run	IconHierarchy2	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-189c-478a-b867-d72feaf5926a	67affcc3-762a-4fee-baa4-2a048ddd621e
00b935b6-e96f-45c9-9a04-69b6bbcf92c6	20202020-7be4-4db2-8ac6-3ff0d740843d	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RAW_JSON	output	Output	\N	Output of the workflow run	IconHierarchy2	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7be4-4db2-8ac6-3ff0d740843d	67affcc3-762a-4fee-baa4-2a048ddd621e
d5400df9-5f9b-4822-b088-6ac2bd7fcbd6	20202020-7802-4c40-ae89-1f506fe3365c	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	POSITION	position	Position	0	Workflow run position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7802-4c40-ae89-1f506fe3365c	67affcc3-762a-4fee-baa4-2a048ddd621e
7a4e37d3-3a1c-4fa7-9a42-aa110acf7ee9	20202020-0b91-4ded-b1ac-cbd5efa58cb9	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0b91-4ded-b1ac-cbd5efa58cb9	67affcc3-762a-4fee-baa4-2a048ddd621e
b651f506-b7a6-47b3-96ca-6b496ac622bf	20202020-f04a-41a1-8aa1-abcdefabcdef	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f04a-41a1-8aa1-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
56ec52d0-24ee-41af-9593-6274fd40c896	20202020-f04b-41a2-9ba2-bcdefabcdefa	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f04b-41a2-9ba2-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
2b27b62d-604d-481f-a783-4466d1131e39	20202020-f04c-41a3-8ca3-cdefabcdefab	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f04c-41a3-8ca3-cdefabcdefab	67affcc3-762a-4fee-baa4-2a048ddd621e
07aceac8-e96b-4d4d-8803-20d5b4825f93	20202020-f04d-41a4-9da4-defabcdefabc	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f04d-41a4-9da4-defabcdefabc	67affcc3-762a-4fee-baa4-2a048ddd621e
e970f351-175c-468f-a0a3-8c4715bc833c	20202020-a12f-4cca-9937-a2e40cc65509	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	TEXT	name	Name	\N	The workflow version name	IconSettingsAutomation	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a12f-4cca-9937-a2e40cc65509	67affcc3-762a-4fee-baa4-2a048ddd621e
5c6353e9-f63c-458d-8398-fadb4311dc6b	20202020-4eae-43e7-86e0-212b41a30b48	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RAW_JSON	trigger	Version trigger	\N	Json object to provide trigger	IconSettingsAutomation	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4eae-43e7-86e0-212b41a30b48	67affcc3-762a-4fee-baa4-2a048ddd621e
eb8422e3-bf3e-4246-a5ae-6252cdac16d1	20202020-5988-4a64-b94a-1f9b7b989039	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RAW_JSON	steps	Version steps	\N	Json object to provide steps	IconSettingsAutomation	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5988-4a64-b94a-1f9b7b989039	67affcc3-762a-4fee-baa4-2a048ddd621e
fe3f565b-2af3-40e7-a2e1-4bdf5ff5689b	20202020-5a34-440e-8a25-39d8c3d1d4cf	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	SELECT	status	Version status	"'DRAFT'"	The workflow version status	IconStatusChange	\N	[{"id": "6d9c099b-fd21-44c3-8fb4-4d6918f1f1ae", "color": "yellow", "label": "Draft", "value": "DRAFT", "position": 0}, {"id": "a8151881-e30d-4086-9430-8cef1dff3345", "color": "green", "label": "Active", "value": "ACTIVE", "position": 1}, {"id": "61914ed2-0d56-4880-9e0f-30954b8bdf4c", "color": "orange", "label": "Deactivated", "value": "DEACTIVATED", "position": 2}, {"id": "05d30ba0-25a1-49a5-8337-4419f8a3a404", "color": "gray", "label": "Archived", "value": "ARCHIVED", "position": 3}]	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5a34-440e-8a25-39d8c3d1d4cf	67affcc3-762a-4fee-baa4-2a048ddd621e
47bb5895-f889-4de8-86ff-1831c26e7823	20202020-791d-4950-ab28-0e704767ae1c	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	POSITION	position	Position	0	Workflow version position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-791d-4950-ab28-0e704767ae1c	67affcc3-762a-4fee-baa4-2a048ddd621e
f2a363b8-e78b-402f-ac5f-fba91a4c7139	20202020-3f17-44ef-b8c1-b282ae8469b2	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3f17-44ef-b8c1-b282ae8469b2	67affcc3-762a-4fee-baa4-2a048ddd621e
c5c7579a-4f21-44c3-b3e5-254a6b50a3bc	20202020-fb1a-41b1-8ab1-efabcdefabcd	285bf1ca-e489-4b4e-a29c-30127e960da7	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fb1a-41b1-8ab1-efabcdefabcd	67affcc3-762a-4fee-baa4-2a048ddd621e
a248e6e2-2209-46b2-8710-571bd56fa5a2	20202020-fb1b-41b2-9bb2-fabcdefabcde	285bf1ca-e489-4b4e-a29c-30127e960da7	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fb1b-41b2-9bb2-fabcdefabcde	67affcc3-762a-4fee-baa4-2a048ddd621e
2e77fa57-a0ef-405e-8ad0-c5f78d045bfa	20202020-fb1c-41b3-8cb3-abcdefabcdef	285bf1ca-e489-4b4e-a29c-30127e960da7	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fb1c-41b3-8cb3-abcdefabcdef	67affcc3-762a-4fee-baa4-2a048ddd621e
38b35054-4953-4798-8cdb-fcb403fe86a9	20202020-fb1d-41b4-9db4-bcdefabcdefa	285bf1ca-e489-4b4e-a29c-30127e960da7	DATE_TIME	deletedAt	Deleted at	\N	Date when the record was deleted	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fb1d-41b4-9db4-bcdefabcdefa	67affcc3-762a-4fee-baa4-2a048ddd621e
d200a0ac-00b3-4e21-873b-0ff6926a20c1	20202020-1810-4591-a93c-d0df97dca843	285bf1ca-e489-4b4e-a29c-30127e960da7	POSITION	position	Position	0	Workspace member position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1810-4591-a93c-d0df97dca843	67affcc3-762a-4fee-baa4-2a048ddd621e
60308355-6900-418b-8644-6ef9d0a2a9e0	20202020-e914-43a6-9c26-3603c59065f4	285bf1ca-e489-4b4e-a29c-30127e960da7	FULL_NAME	name	Name	\N	Workspace member name	IconCircleUser	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e914-43a6-9c26-3603c59065f4	67affcc3-762a-4fee-baa4-2a048ddd621e
ca863e14-1cd7-41ab-afb4-ecac92c93dec	20202020-66bc-47f2-adac-f2ef7c598b63	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	colorScheme	Color Scheme	"'System'"	Preferred color scheme	IconColorSwatch	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-66bc-47f2-adac-f2ef7c598b63	67affcc3-762a-4fee-baa4-2a048ddd621e
7d4dc9e0-9abb-43e4-9f03-86efe85705a0	20202020-402e-4695-b169-794fa015afbe	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	locale	Language	"'en'"	Preferred language	IconLanguage	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-402e-4695-b169-794fa015afbe	67affcc3-762a-4fee-baa4-2a048ddd621e
2f4d0b77-3f3a-42b3-98ee-d5fe8b73f7b6	20202020-0ced-4c4f-a376-c98a966af3f6	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	avatarUrl	Avatar Url	\N	Workspace member avatar	IconFileUpload	\N	\N	\N	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0ced-4c4f-a376-c98a966af3f6	67affcc3-762a-4fee-baa4-2a048ddd621e
918e92e5-8949-4f89-936c-6ce9b9681078	20202020-4c5f-4e09-bebc-9e624e21ecf4	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	userEmail	User Email	\N	Related user email address	IconMail	\N	\N	\N	f	t	t	t	t	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4c5f-4e09-bebc-9e624e21ecf4	67affcc3-762a-4fee-baa4-2a048ddd621e
dfc251af-209c-4c2a-8c2f-41f513ab8f4b	20202020-92d0-1d7f-a126-25ededa6b142	285bf1ca-e489-4b4e-a29c-30127e960da7	NUMBER	calendarStartDay	Start of the week	7	User's preferred start day of the week	IconCalendar	\N	\N	{"dataType": "int"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-92d0-1d7f-a126-25ededa6b142	67affcc3-762a-4fee-baa4-2a048ddd621e
3aef7758-2d24-4736-9710-981e5b128787	20202020-75a9-4dfc-bf25-2e4b43e89820	285bf1ca-e489-4b4e-a29c-30127e960da7	UUID	userId	User Id	\N	Associated User Id	IconCircleUsers	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-75a9-4dfc-bf25-2e4b43e89820	67affcc3-762a-4fee-baa4-2a048ddd621e
e817e60a-6387-4f33-8872-9b1d71ebf1a2	20202020-2d33-4c21-a86e-5943b050dd54	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	timeZone	Time zone	"'system'"	User time zone	IconTimezone	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2d33-4c21-a86e-5943b050dd54	67affcc3-762a-4fee-baa4-2a048ddd621e
9d775c6d-ba99-4ab8-9385-c9c315026d88	20202020-66ac-4502-9975-e4d959c50311	be33c5f3-ee15-4555-9f5f-209b30f33076	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	9d775c6d-ba99-4ab8-9385-c9c315026d88	bbb719d5-4626-40d6-aec6-7d53f24e5459
16ecd873-b6d1-47bf-8151-19fccb8a352d	20202020-af13-4e11-b1e7-b8cf5ea13dc0	285bf1ca-e489-4b4e-a29c-30127e960da7	SELECT	dateFormat	Date format	"'SYSTEM'"	User's preferred date format	IconCalendarEvent	\N	[{"id": "ab6c767d-1862-4e9e-a60e-e48e47164460", "color": "turquoise", "label": "System", "value": "SYSTEM", "position": 0}, {"id": "5634bbcf-0e46-4cfa-83c3-b0e1c03bb200", "color": "red", "label": "Month First", "value": "MONTH_FIRST", "position": 1}, {"id": "42076bf6-be16-4108-a04a-96691c590cf8", "color": "purple", "label": "Day First", "value": "DAY_FIRST", "position": 2}, {"id": "6298bf65-2c43-4306-8e3d-765a272b8ccf", "color": "sky", "label": "Year First", "value": "YEAR_FIRST", "position": 3}]	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-af13-4e11-b1e7-b8cf5ea13dc0	67affcc3-762a-4fee-baa4-2a048ddd621e
b6d510d3-34c7-4a24-8c79-a679f2e36c41	20202020-8acb-4cf8-a851-a6ed443c8d81	285bf1ca-e489-4b4e-a29c-30127e960da7	SELECT	timeFormat	Time format	"'SYSTEM'"	User's preferred time format	IconClock2	\N	[{"id": "9ea2c966-7f29-4414-9d1f-d01fa680aca5", "color": "sky", "label": "System", "value": "SYSTEM", "position": 0}, {"id": "d75b1d29-c3ad-4ee4-bd4d-0e0cb151dcfc", "color": "red", "label": "24HRS", "value": "HOUR_24", "position": 1}, {"id": "0bc18d7b-00d9-497e-8822-ad352eb3ce39", "color": "purple", "label": "12HRS", "value": "HOUR_12", "position": 2}]	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8acb-4cf8-a851-a6ed443c8d81	67affcc3-762a-4fee-baa4-2a048ddd621e
8f8bb021-2138-4296-81ca-049aad73149c	20202020-7f40-4e7f-b126-11c0eda6b141	285bf1ca-e489-4b4e-a29c-30127e960da7	SELECT	numberFormat	Number format	"'SYSTEM'"	User's preferred number format	IconNumbers	\N	[{"id": "cef09971-8efc-46ed-a365-2d08eb901c97", "color": "turquoise", "label": "System", "value": "SYSTEM", "position": 0}, {"id": "ce0ea9c0-3efc-49ed-a86c-a3bcb4d691eb", "color": "blue", "label": "Commas and dot", "value": "COMMAS_AND_DOT", "position": 1}, {"id": "65c80431-f56b-4a7b-839e-b2612a3f856b", "color": "green", "label": "Spaces and comma", "value": "SPACES_AND_COMMA", "position": 2}, {"id": "bcfcfab8-f09e-4646-856d-c752a60cbebe", "color": "orange", "label": "Dots and comma", "value": "DOTS_AND_COMMA", "position": 3}, {"id": "49eef92a-c768-40a2-807e-21b84b2e2662", "color": "purple", "label": "Apostrophe and dot", "value": "APOSTROPHE_AND_DOT", "position": 4}]	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7f40-4e7f-b126-11c0eda6b141	67affcc3-762a-4fee-baa4-2a048ddd621e
ccbd7737-6d1e-478b-9cd0-e4aff4878fde	20202020-1a11-4f7f-b126-11c0eda6b142	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	availabilityStartTime	Availability start time	"'00:00'"	Daily availability start time (HH:mm)	IconClockHour4	\N	\N	\N	f	t	f	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1a11-4f7f-b126-11c0eda6b142	67affcc3-762a-4fee-baa4-2a048ddd621e
ed957976-e0e8-431b-a658-32c1aa413846	20202020-5e55-4f7f-b126-11c0eda6b146	285bf1ca-e489-4b4e-a29c-30127e960da7	TEXT	availabilityEndTime	Availability end time	"'24:00'"	Daily availability end time (HH:mm)	IconClockHour8	\N	\N	\N	f	t	f	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5e55-4f7f-b126-11c0eda6b146	67affcc3-762a-4fee-baa4-2a048ddd621e
43b53d65-5b51-41e8-a3be-19611961a88f	20202020-6f66-4f7f-b126-11c0eda6b147	285bf1ca-e489-4b4e-a29c-30127e960da7	NUMBER	availabilityHours	Availability end hour	\N	End of availability as hour of day (1-24)	IconClock	\N	\N	{"dataType": "int"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6f66-4f7f-b126-11c0eda6b147	67affcc3-762a-4fee-baa4-2a048ddd621e
fd7ff6f4-bece-4b92-89c4-830480b2c62d	20202020-2b22-4f7f-b126-11c0eda6b143	285bf1ca-e489-4b4e-a29c-30127e960da7	MULTI_SELECT	availableDays	Available days	["'MONDAY'", "'TUESDAY'", "'WEDNESDAY'", "'THURSDAY'", "'FRIDAY'", "'SATURDAY'", "'SUNDAY'"]	Days of week when the user can be assigned	IconCalendarWeek	\N	[{"id": "4c8f23a3-8f9a-4e5c-a86f-698f4b0e9dbd", "color": "blue", "label": "Monday", "value": "MONDAY", "position": 0}, {"id": "875c24a2-2e87-4092-b1d8-70f7ae661f89", "color": "green", "label": "Tuesday", "value": "TUESDAY", "position": 1}, {"id": "9553c369-df25-43fc-a030-e1a907725b23", "color": "yellow", "label": "Wednesday", "value": "WEDNESDAY", "position": 2}, {"id": "9117681f-21f7-473d-902d-c48ad7c828f9", "color": "orange", "label": "Thursday", "value": "THURSDAY", "position": 3}, {"id": "59a2d7c2-3fa7-478d-96c5-6be92bcf02f4", "color": "red", "label": "Friday", "value": "FRIDAY", "position": 4}, {"id": "67b890e9-a265-413e-80e0-6a82b0c85980", "color": "purple", "label": "Saturday", "value": "SATURDAY", "position": 5}, {"id": "5dc8a4bc-03b3-4285-a607-8b803b047055", "color": "sky", "label": "Sunday", "value": "SUNDAY", "position": 6}]	\N	f	t	f	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2b22-4f7f-b126-11c0eda6b143	67affcc3-762a-4fee-baa4-2a048ddd621e
772515cd-6feb-4c03-b617-9d43b1c047b9	20202020-3c33-4f7f-b126-11c0eda6b144	285bf1ca-e489-4b4e-a29c-30127e960da7	DATE_TIME	leaveStartDate	Leave start date	\N	Date and time when leave starts	IconCalendarMinus	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3c33-4f7f-b126-11c0eda6b144	67affcc3-762a-4fee-baa4-2a048ddd621e
5b438dc7-db64-4187-936d-ce006d3f9630	20202020-4d44-4f7f-b126-11c0eda6b145	285bf1ca-e489-4b4e-a29c-30127e960da7	DATE_TIME	leaveEndDate	Leave end date	\N	Date and time when leave ends	IconCalendarCheck	\N	\N	{"displayFormat": "RELATIVE"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4d44-4f7f-b126-11c0eda6b145	67affcc3-762a-4fee-baa4-2a048ddd621e
096dc767-fc6f-4d86-a1b3-81a7c4911cf9	20202020-46d0-4e7f-bc26-74c0edaeb619	285bf1ca-e489-4b4e-a29c-30127e960da7	TS_VECTOR	searchVector	Search vector	\N	Field used for full-text search	IconUser	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"nameFirstName\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"nameLastName\\"), '') || ' ' || COALESCE(public.unaccent_immutable(\\"userEmail\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-46d0-4e7f-bc26-74c0edaeb619	67affcc3-762a-4fee-baa4-2a048ddd621e
f735595c-8902-403f-8f00-19d6150f8025	20202020-51e5-4621-9cf8-215487951c4b	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	task	Task	\N	Attachment task	IconNotes	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "taskId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	43234d0b-36b5-4c05-861b-81d10c4db950	ff60777a-2722-4aa0-ba66-a8e089c7bc94	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-51e5-4621-9cf8-215487951c4b	67affcc3-762a-4fee-baa4-2a048ddd621e
7545787b-07fd-4542-a56a-89eda6f56638	20202020-4f4b-4503-a6fc-6b982f3dffb5	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	note	Note	\N	Attachment note	IconNotes	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "noteId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	94e1fe6e-e071-4766-a172-ce6718f403a3	415d12c3-c586-4222-9c41-994a99cebf67	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4f4b-4503-a6fc-6b982f3dffb5	67affcc3-762a-4fee-baa4-2a048ddd621e
10e3877a-e3bf-449d-8aa0-9d7e71b9a75a	20202020-0158-4aa2-965c-5cdafe21ffa2	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	person	Person	\N	Attachment person	IconUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f318014b-3c44-4e69-879a-457f5eb343ef	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0158-4aa2-965c-5cdafe21ffa2	67affcc3-762a-4fee-baa4-2a048ddd621e
2a9ca173-f438-4bc5-b23a-30a3edb93372	20202020-ceab-4a28-b546-73b06b4c08d5	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	company	Company	\N	Attachment company	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	bfc5139d-de0a-467e-b636-0039d4703995	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ceab-4a28-b546-73b06b4c08d5	67affcc3-762a-4fee-baa4-2a048ddd621e
257d19ad-1090-4f33-8c29-bae938934d31	20202020-7374-499d-bea3-9354890755b5	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	opportunity	Opportunity	\N	Attachment opportunity	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "opportunityId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	5ae5fbf5-0c30-4257-a026-bf0cfdd462ca	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7374-499d-bea3-9354890755b5	67affcc3-762a-4fee-baa4-2a048ddd621e
6a65d64f-1ea1-4ad6-aab0-65a9d301305c	20202020-5324-43f3-9dbf-1a33e7de0ce6	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	dashboard	Dashboard	\N	Attachment dashboard	IconLayout	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "dashboardId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	855c1120-3d51-4c74-85cc-350fc4dd9ca6	a34181a4-c008-4fcb-b55e-3f1bdf07d717	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5324-43f3-9dbf-1a33e7de0ce6	67affcc3-762a-4fee-baa4-2a048ddd621e
ada2aa94-5a69-4126-9a64-91404e576111	20202020-f1e8-4c9d-8a7b-3f5e1d2c9a8b	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	workflow	Workflow	\N	Attachment workflow	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	92dca032-ffc1-4286-8944-bb7a94780a22	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f1e8-4c9d-8a7b-3f5e1d2c9a8b	67affcc3-762a-4fee-baa4-2a048ddd621e
46b0e181-869a-4546-8fd4-7a4ca4ee2f25	20202020-548d-4084-a947-fa20a39f7c06	b438fbab-6bac-43b0-8550-1e70fb608333	RELATION	workspaceMember	WorkspaceMember	\N	WorkspaceMember	IconCircleUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "workspaceMemberId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	83747ca4-72c1-495e-9d0b-7f2ac3bcb81b	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-548d-4084-a947-fa20a39f7c06	67affcc3-762a-4fee-baa4-2a048ddd621e
742c883b-2439-4512-b385-cb0ed2e061c7	20202020-93ee-4da4-8d58-0282c4a9cb7d	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	RELATION	calendarChannel	Channel ID	\N	Channel ID	IconCalendar	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "calendarChannelId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d3225f1c-c4dc-43e2-a2d8-4978570f0d2e	d98f6957-0ad9-4461-8551-13b1c541fb90	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-93ee-4da4-8d58-0282c4a9cb7d	67affcc3-762a-4fee-baa4-2a048ddd621e
59fc7f56-2882-4d1b-91ec-ccd8be1513f5	20202020-5aa5-437e-bb86-f42d457783e3	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	RELATION	calendarEvent	Event ID	\N	Event ID	IconCalendar	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "calendarEventId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	caf8fa39-8034-4e29-a415-e39b6660e39d	3964c94e-8e9c-4e92-b9f2-8144df00e793	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5aa5-437e-bb86-f42d457783e3	67affcc3-762a-4fee-baa4-2a048ddd621e
3b2d1005-7c1d-4c01-a7ea-d3203c779268	20202020-95b1-4f44-82dc-61b042ae2414	d98f6957-0ad9-4461-8551-13b1c541fb90	RELATION	connectedAccount	Connected Account	\N	Connected Account	IconUserCircle	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "connectedAccountId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2fd2ee56-1095-477a-88de-053120623e2d	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-95b1-4f44-82dc-61b042ae2414	67affcc3-762a-4fee-baa4-2a048ddd621e
d3225f1c-c4dc-43e2-a2d8-4978570f0d2e	20202020-afb0-4a9f-979f-2d5087d71d09	d98f6957-0ad9-4461-8551-13b1c541fb90	RELATION	calendarChannelEventAssociations	Calendar Channel Event Associations	\N	Calendar Channel Event Associations	IconCalendar	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	742c883b-2439-4512-b385-cb0ed2e061c7	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-afb0-4a9f-979f-2d5087d71d09	67affcc3-762a-4fee-baa4-2a048ddd621e
7ab83ae2-459e-4933-82f3-27015a9be304	20202020-fe3a-401c-b889-af4f4657a861	582910b3-32c9-4959-a72c-ebb309bc29f4	RELATION	calendarEvent	Event ID	\N	Event ID	IconCalendar	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "calendarEventId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	29b8dddb-8a17-4c65-a0c5-f82f368d62af	3964c94e-8e9c-4e92-b9f2-8144df00e793	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fe3a-401c-b889-af4f4657a861	67affcc3-762a-4fee-baa4-2a048ddd621e
069959f4-99ea-433d-a0ab-db690b92875e	20202020-5761-4842-8186-e1898ef93966	582910b3-32c9-4959-a72c-ebb309bc29f4	RELATION	person	Person	\N	Person	IconUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	27e30450-c86c-49a3-809b-fc27aff23e8a	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-5761-4842-8186-e1898ef93966	67affcc3-762a-4fee-baa4-2a048ddd621e
e6b72d67-67c3-4549-8159-7b69af043a3e	20202020-20e4-4591-93ed-aeb17a4dcbd2	582910b3-32c9-4959-a72c-ebb309bc29f4	RELATION	workspaceMember	Workspace Member	\N	Workspace Member	IconUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "workspaceMemberId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8c8c728c-70b5-4fb1-b9ce-96273883f871	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-20e4-4591-93ed-aeb17a4dcbd2	67affcc3-762a-4fee-baa4-2a048ddd621e
caf8fa39-8034-4e29-a415-e39b6660e39d	20202020-bdf8-4572-a2cc-ecbb6bcc3a02	3964c94e-8e9c-4e92-b9f2-8144df00e793	RELATION	calendarChannelEventAssociations	Calendar Channel Event Associations	\N	Calendar Channel Event Associations	IconCalendar	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	59fc7f56-2882-4d1b-91ec-ccd8be1513f5	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-bdf8-4572-a2cc-ecbb6bcc3a02	67affcc3-762a-4fee-baa4-2a048ddd621e
29b8dddb-8a17-4c65-a0c5-f82f368d62af	20202020-e07e-4ccb-88f5-6f3d00458eec	3964c94e-8e9c-4e92-b9f2-8144df00e793	RELATION	calendarEventParticipants	Event Participants	\N	Event Participants	IconUserCircle	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7ab83ae2-459e-4933-82f3-27015a9be304	582910b3-32c9-4959-a72c-ebb309bc29f4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e07e-4ccb-88f5-6f3d00458eec	67affcc3-762a-4fee-baa4-2a048ddd621e
0b77046a-2396-4655-ae12-b0ab2c81e12f	20202020-3213-4ddf-9494-6422bcff8d7c	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	people	People	\N	People linked to the company.	IconUsers	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2aa99259-fefd-4c96-8660-029d7eaf7050	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3213-4ddf-9494-6422bcff8d7c	67affcc3-762a-4fee-baa4-2a048ddd621e
b20c80a8-b163-4946-89bf-fccc4c8248a7	20202020-95b8-4e10-9881-edb5d4765f9d	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	accountOwner	Account Owner	\N	Your team member responsible for managing the company account	IconUserCircle	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "accountOwnerId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	00ba8267-88db-41ae-96eb-78c63da446cc	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-95b8-4e10-9881-edb5d4765f9d	67affcc3-762a-4fee-baa4-2a048ddd621e
f6f85d12-d2fb-48da-ab76-efa12ef1982a	20202020-cb17-4a61-8f8f-3be6730480de	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	taskTargets	Tasks	\N	Tasks tied to the company	IconCheckbox	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d4cf4089-b705-471c-978a-0911724cf4dc	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cb17-4a61-8f8f-3be6730480de	67affcc3-762a-4fee-baa4-2a048ddd621e
2fc8ae33-67f4-43dd-bc10-08d1e5e04532	20202020-bae0-4556-a74a-a9c686f77a88	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	noteTargets	Notes	\N	Notes tied to the company	IconNotes	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0b8666f5-b6c6-415f-aa21-ecc10c0dd0d2	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-bae0-4556-a74a-a9c686f77a88	67affcc3-762a-4fee-baa4-2a048ddd621e
b8448e0e-7e56-46d2-aad0-03472508b935	20202020-add3-4658-8e23-d70dccb6d0ec	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	opportunities	Opportunities	\N	Opportunities linked to the company.	IconTargetArrow	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	5642d645-5dad-42d2-a255-14b88b8b0bb3	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-add3-4658-8e23-d70dccb6d0ec	67affcc3-762a-4fee-baa4-2a048ddd621e
c986e4b4-25e4-4ad5-92db-e39875050065	20202020-4d1d-41ac-b13b-621631298d55	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	favorites	Favorites	\N	Favorites linked to the company	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	3a79bb40-10bc-4598-a80b-e6112c1a845e	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4d1d-41ac-b13b-621631298d55	67affcc3-762a-4fee-baa4-2a048ddd621e
bfc5139d-de0a-467e-b636-0039d4703995	20202020-c1b5-4120-b0f0-987ca401ed53	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	attachments	Attachments	\N	Attachments linked to the company	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2a9ca173-f438-4bc5-b23a-30a3edb93372	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c1b5-4120-b0f0-987ca401ed53	67affcc3-762a-4fee-baa4-2a048ddd621e
0f149ce4-0e08-4576-b6ae-3d83f826e3e5	20202020-0414-4daf-9c0d-64fe7b27f89f	d7124df1-9136-4b65-8c71-befa364161f2	RELATION	timelineActivities	Timeline Activities	\N	Timeline Activities linked to the company	IconIconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9ed9edd8-0de4-4782-923b-4189878c916b	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0414-4daf-9c0d-64fe7b27f89f	67affcc3-762a-4fee-baa4-2a048ddd621e
5a5c299e-7726-4c47-9dab-bf13eef39195	20202020-3517-4896-afac-b1d0aa362af6	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	RELATION	accountOwner	Account Owner	\N	Account Owner	IconUserCircle	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "accountOwnerId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9c0bdc43-fe72-466a-9240-f525292152ee	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3517-4896-afac-b1d0aa362af6	67affcc3-762a-4fee-baa4-2a048ddd621e
6990e464-54dc-4f01-926f-267e3633027e	20202020-24f7-4362-8468-042204d1e445	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	RELATION	messageChannels	Message Channels	\N	Message Channels	IconMessage	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	27405b57-dc97-4ab9-badb-ffa407d82493	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-24f7-4362-8468-042204d1e445	67affcc3-762a-4fee-baa4-2a048ddd621e
2fd2ee56-1095-477a-88de-053120623e2d	20202020-af4a-47bb-99ec-51911c1d3977	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	RELATION	calendarChannels	Calendar Channels	\N	Calendar Channels	IconCalendar	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	3b2d1005-7c1d-4c01-a7ea-d3203c779268	d98f6957-0ad9-4461-8551-13b1c541fb90	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-af4a-47bb-99ec-51911c1d3977	67affcc3-762a-4fee-baa4-2a048ddd621e
3bb08151-a6fd-495d-b3f5-4b55f71a47b8	20202020-9b0c-5d6e-7f8a-9b0c1d2e3f4a	a34181a4-c008-4fcb-b55e-3f1bdf07d717	RELATION	timelineActivities	Timeline Activities	\N	Timeline activities linked to the dashboard	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	28bdcb9a-ea63-4a1a-8671-b51884df6ea9	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9b0c-5d6e-7f8a-9b0c1d2e3f4a	67affcc3-762a-4fee-baa4-2a048ddd621e
2482f7d6-b04c-4098-8f63-68d880a68646	20202020-f032-478f-88fa-6426ff6f1e4c	a34181a4-c008-4fcb-b55e-3f1bdf07d717	RELATION	favorites	Favorites	\N	Favorites linked to the dashboard	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	be437f66-87de-4535-8fca-6c9dc8dd4b84	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f032-478f-88fa-6426ff6f1e4c	67affcc3-762a-4fee-baa4-2a048ddd621e
855c1120-3d51-4c74-85cc-350fc4dd9ca6	20202020-bf6f-4220-8c55-2764f1175870	a34181a4-c008-4fcb-b55e-3f1bdf07d717	RELATION	attachments	Attachments	\N	Attachments linked to the dashboard	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	6a65d64f-1ea1-4ad6-aab0-65a9d301305c	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-bf6f-4220-8c55-2764f1175870	67affcc3-762a-4fee-baa4-2a048ddd621e
ccd51550-64be-49b4-a593-0b0048b79e2a	20202020-d767-4622-bdcf-d8a084834d86	be33c5f3-ee15-4555-9f5f-209b30f33076	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	ccd51550-64be-49b4-a593-0b0048b79e2a	bbb719d5-4626-40d6-aec6-7d53f24e5459
cfd497ce-69b3-4c17-9b43-58a6a968ed0e	20202020-ce63-49cb-9676-fdc0c45892cd	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	forWorkspaceMember	Workspace Member	\N	Favorite workspace member	IconCircleUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "forWorkspaceMemberId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	30792e06-c85a-4eb5-be2b-31421ea983c2	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ce63-49cb-9676-fdc0c45892cd	67affcc3-762a-4fee-baa4-2a048ddd621e
a420621f-912b-4d2b-839f-c36e9879bb11	20202020-c428-4f40-b6f3-86091511c41c	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	person	Person	\N	Favorite person	IconUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8ab2cb6f-fbc0-4086-a3be-a59381f82f69	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c428-4f40-b6f3-86091511c41c	67affcc3-762a-4fee-baa4-2a048ddd621e
3a79bb40-10bc-4598-a80b-e6112c1a845e	20202020-cff5-4682-8bf9-069169e08279	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	company	Company	\N	Favorite company	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	c986e4b4-25e4-4ad5-92db-e39875050065	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cff5-4682-8bf9-069169e08279	67affcc3-762a-4fee-baa4-2a048ddd621e
2b770b3c-651e-478e-ac73-b47720bfb9d3	20202020-dabc-48e1-8318-2781a2b32aa2	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	opportunity	Opportunity	\N	Favorite opportunity	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "opportunityId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	6275b301-58b2-42b6-b8d1-356feb1b8092	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-dabc-48e1-8318-2781a2b32aa2	67affcc3-762a-4fee-baa4-2a048ddd621e
2f7d9b3c-e8d6-42de-97b6-1606a8e829c0	20202020-b11b-4dc8-999a-6bd0a947b463	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	workflow	Workflow	\N	Favorite workflow	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	325c3e9d-7269-44fb-a9bf-f25fea56e434	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b11b-4dc8-999a-6bd0a947b463	67affcc3-762a-4fee-baa4-2a048ddd621e
bc86ad93-0b90-4023-9930-ab5088f492f1	20202020-e1b8-4caf-b55a-3ab4d4cbcd21	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	workflowVersion	Workflow	\N	Favorite workflow version	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowVersionId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9f44f4a1-e08d-4c29-bef8-30d2c660a9fc	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e1b8-4caf-b55a-3ab4d4cbcd21	67affcc3-762a-4fee-baa4-2a048ddd621e
c3387e21-0126-4671-a766-93cd0f305598	20202020-db5a-4fe4-9a13-9afa22b1e762	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	workflowRun	Workflow	\N	Favorite workflow run	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowRunId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ae5e6fe5-701d-4dc4-b2e0-e878c032d4ff	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-db5a-4fe4-9a13-9afa22b1e762	67affcc3-762a-4fee-baa4-2a048ddd621e
d7e08160-79be-4034-8be6-230bcd571fe6	20202020-1b1b-4b3b-8b1b-7f8d6a1d7d5c	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	task	Task	\N	Favorite task	IconCheckbox	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "taskId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	09768190-55a9-411a-ab8f-a1f4ab9ad285	ff60777a-2722-4aa0-ba66-a8e089c7bc94	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1b1b-4b3b-8b1b-7f8d6a1d7d5c	67affcc3-762a-4fee-baa4-2a048ddd621e
8c176228-a931-47f9-9ef8-81d3a4f80b73	20202020-1f25-43fe-8b00-af212fdde824	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	note	Note	\N	Favorite note	IconNotes	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "noteId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	937a92da-503b-45fd-9874-29071556b949	415d12c3-c586-4222-9c41-994a99cebf67	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1f25-43fe-8b00-af212fdde824	67affcc3-762a-4fee-baa4-2a048ddd621e
be437f66-87de-4535-8fca-6c9dc8dd4b84	20202020-6ef9-45e4-b440-cc986f687c91	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	dashboard	Dashboard	\N	Favorite dashboard	IconLayoutDashboard	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "dashboardId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2482f7d6-b04c-4098-8f63-68d880a68646	a34181a4-c008-4fcb-b55e-3f1bdf07d717	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6ef9-45e4-b440-cc986f687c91	67affcc3-762a-4fee-baa4-2a048ddd621e
78c0bd1a-1799-4c99-b51c-5786faa10f5d	20202020-f658-4d12-8b4d-248356aa4bd9	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	favoriteFolder	Favorite Folder	\N	The folder this favorite belongs to	IconFolder	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "favoriteFolderId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	3443c872-fcee-4f73-bc09-510398676c34	e471d18a-b548-4710-a2c2-3783966c373d	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f658-4d12-8b4d-248356aa4bd9	67affcc3-762a-4fee-baa4-2a048ddd621e
3443c872-fcee-4f73-bc09-510398676c34	20202020-b5e3-4b42-8af2-03cd4fd2e4d2	e471d18a-b548-4710-a2c2-3783966c373d	RELATION	favorites	Favorites	\N	Favorites in this folder	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	78c0bd1a-1799-4c99-b51c-5786faa10f5d	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b5e3-4b42-8af2-03cd4fd2e4d2	67affcc3-762a-4fee-baa4-2a048ddd621e
758b4564-d24c-4466-bb28-f2b8ab1a3b05	20202020-30f2-4ccd-9f5c-e41bb9d26214	bb71b55e-db18-48fe-ab10-9047b29b2e12	RELATION	messageThread	Message Thread Id	\N	Message Thread Id	IconHash	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageThreadId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	726d0ec5-8db2-4f43-ab32-87894bfe4433	1c726159-0955-4b7d-9232-9971c71d0a38	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-30f2-4ccd-9f5c-e41bb9d26214	67affcc3-762a-4fee-baa4-2a048ddd621e
c1ff1a4a-63d3-403b-8596-059169cd295c	20202020-7cff-4a74-b63c-73228448cbd9	bb71b55e-db18-48fe-ab10-9047b29b2e12	RELATION	messageParticipants	Message Participants	\N	Message Participants	IconUserCircle	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ea71a7bf-ed43-44bf-8e35-5cb151a14fb2	e386c71a-338d-4a79-ae0e-792bc13d7c22	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7cff-4a74-b63c-73228448cbd9	67affcc3-762a-4fee-baa4-2a048ddd621e
5129d80a-88c8-4c2a-a70f-58f21e8a9f80	20202020-3cef-43a3-82c6-50e7cfbc9ae4	bb71b55e-db18-48fe-ab10-9047b29b2e12	RELATION	messageChannelMessageAssociations	Message Channel Association	\N	Messages from the channel.	IconMessage	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7793de19-ff23-4b03-9bba-ced63f35ce96	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3cef-43a3-82c6-50e7cfbc9ae4	67affcc3-762a-4fee-baa4-2a048ddd621e
27405b57-dc97-4ab9-badb-ffa407d82493	20202020-49a2-44a4-b470-282c0440d15d	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	RELATION	connectedAccount	Connected Account	\N	Connected Account	IconUserCircle	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "connectedAccountId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	6990e464-54dc-4f01-926f-267e3633027e	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-49a2-44a4-b470-282c0440d15d	67affcc3-762a-4fee-baa4-2a048ddd621e
85b59662-e9d6-4d59-aa69-6fd3f79e36cd	20202020-49b8-4766-88fd-75f1e21b3d5f	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	RELATION	messageChannelMessageAssociations	Message Channel Association	\N	Messages from the channel.	IconMessage	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f6eb29c6-1500-490d-9420-11a5724165fe	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-49b8-4766-88fd-75f1e21b3d5f	67affcc3-762a-4fee-baa4-2a048ddd621e
8314ba36-e8cc-42df-baa8-8aa3a9eaf680	20202020-cc39-4432-9fe8-ec8ab8bbed94	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	RELATION	messageFolders	Message Folders	\N	Message Folders	IconFolder	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	aa3639b0-5d49-423c-a99d-759f49cd2516	1e413633-a549-4d9a-9d79-f18adaa748e0	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cc39-4432-9fe8-ec8ab8bbed94	67affcc3-762a-4fee-baa4-2a048ddd621e
f6eb29c6-1500-490d-9420-11a5724165fe	20202020-b658-408f-bd46-3bd2d15d7e52	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	RELATION	messageChannel	Message Channel Id	\N	Message Channel Id	IconHash	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageChannelId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	85b59662-e9d6-4d59-aa69-6fd3f79e36cd	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b658-408f-bd46-3bd2d15d7e52	67affcc3-762a-4fee-baa4-2a048ddd621e
7e3314d5-4afa-4d2e-bcaa-dfd93c660fe9	20202020-fac8-42a8-94dd-44dbc920ae16	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	RELATION	messageThread	Message Thread Id	\N	Message Thread Id	IconHash	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageThreadId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	98cda01c-1824-4741-872c-910f8e40b8f1	1c726159-0955-4b7d-9232-9971c71d0a38	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fac8-42a8-94dd-44dbc920ae16	67affcc3-762a-4fee-baa4-2a048ddd621e
7793de19-ff23-4b03-9bba-ced63f35ce96	20202020-da5d-4ac5-8743-342ab0a0336b	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	RELATION	message	Message Id	\N	Message Id	IconHash	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	5129d80a-88c8-4c2a-a70f-58f21e8a9f80	bb71b55e-db18-48fe-ab10-9047b29b2e12	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-da5d-4ac5-8743-342ab0a0336b	67affcc3-762a-4fee-baa4-2a048ddd621e
aa3639b0-5d49-423c-a99d-759f49cd2516	20202020-c9f8-43db-a3e7-7f2e8b5d9c1a	1e413633-a549-4d9a-9d79-f18adaa748e0	RELATION	messageChannel	Message Channel	\N	Message Channel	IconMessage	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageChannelId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8314ba36-e8cc-42df-baa8-8aa3a9eaf680	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c9f8-43db-a3e7-7f2e8b5d9c1a	67affcc3-762a-4fee-baa4-2a048ddd621e
ea71a7bf-ed43-44bf-8e35-5cb151a14fb2	20202020-985b-429a-9db9-9e55f4898a2a	e386c71a-338d-4a79-ae0e-792bc13d7c22	RELATION	message	Message	\N	Message	IconMessage	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "messageId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	c1ff1a4a-63d3-403b-8596-059169cd295c	bb71b55e-db18-48fe-ab10-9047b29b2e12	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-985b-429a-9db9-9e55f4898a2a	67affcc3-762a-4fee-baa4-2a048ddd621e
70bbf161-fa08-4e74-bcdf-946523d54930	d047ccb4-9469-4514-a982-29c4ae49317d	be33c5f3-ee15-4555-9f5f-209b30f33076	ACTOR	updatedBy	Updated by	{"name": "''", "source": "'MANUAL'"}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	70bbf161-fa08-4e74-bcdf-946523d54930	bbb719d5-4626-40d6-aec6-7d53f24e5459
9db0d8eb-e1f7-475e-9f02-c6b2a8e008f0	20202020-249d-4e0f-82cd-1b9df5cd3da2	e386c71a-338d-4a79-ae0e-792bc13d7c22	RELATION	person	Person	\N	Person	IconUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	256381a3-d9c5-45c3-a3ee-fd75d225f6f3	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-249d-4e0f-82cd-1b9df5cd3da2	67affcc3-762a-4fee-baa4-2a048ddd621e
b8de3e96-8287-428c-8863-24b7b6e67a8f	20202020-77a7-4845-99ed-1bcbb478be6f	e386c71a-338d-4a79-ae0e-792bc13d7c22	RELATION	workspaceMember	Workspace Member	\N	Workspace member	IconCircleUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "workspaceMemberId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9f364ce9-4212-4c98-b1b3-9bb1e5e9de3c	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-77a7-4845-99ed-1bcbb478be6f	67affcc3-762a-4fee-baa4-2a048ddd621e
726d0ec5-8db2-4f43-ab32-87894bfe4433	20202020-3115-404f-aade-e1154b28e35a	1c726159-0955-4b7d-9232-9971c71d0a38	RELATION	messages	Messages	\N	Messages from the thread.	IconMessage	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	758b4564-d24c-4466-bb28-f2b8ab1a3b05	bb71b55e-db18-48fe-ab10-9047b29b2e12	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3115-404f-aade-e1154b28e35a	67affcc3-762a-4fee-baa4-2a048ddd621e
98cda01c-1824-4741-872c-910f8e40b8f1	20202020-314e-40a4-906d-a5d5d6c285f6	1c726159-0955-4b7d-9232-9971c71d0a38	RELATION	messageChannelMessageAssociations	Message Channel Association	\N	Messages from the channel.	IconMessage	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7e3314d5-4afa-4d2e-bcaa-dfd93c660fe9	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-314e-40a4-906d-a5d5d6c285f6	67affcc3-762a-4fee-baa4-2a048ddd621e
6685f802-de0d-4a07-bbbe-dbd41627f99a	20202020-1f25-43fe-8b00-af212fdde823	415d12c3-c586-4222-9c41-994a99cebf67	RELATION	noteTargets	Relations	\N	Note targets	IconArrowUpRight	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	76b10284-6ec9-43b9-8a3d-161bcda99cee	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1f25-43fe-8b00-af212fdde823	67affcc3-762a-4fee-baa4-2a048ddd621e
94e1fe6e-e071-4766-a172-ce6718f403a3	20202020-4986-4c92-bf19-39934b149b16	415d12c3-c586-4222-9c41-994a99cebf67	RELATION	attachments	Attachments	\N	Note attachments	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7545787b-07fd-4542-a56a-89eda6f56638	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4986-4c92-bf19-39934b149b16	67affcc3-762a-4fee-baa4-2a048ddd621e
b802145a-d6a5-4e19-9a3b-48a555c8b82e	20202020-7030-42f8-929c-1a57b25d6bce	415d12c3-c586-4222-9c41-994a99cebf67	RELATION	timelineActivities	Timeline Activities	\N	Timeline Activities linked to the note.	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b0f66363-9837-4281-a846-d20ba8905020	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7030-42f8-929c-1a57b25d6bce	67affcc3-762a-4fee-baa4-2a048ddd621e
937a92da-503b-45fd-9874-29071556b949	20202020-4d1d-41ac-b13b-621631298d67	415d12c3-c586-4222-9c41-994a99cebf67	RELATION	favorites	Favorites	\N	Favorites linked to the note	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8c176228-a931-47f9-9ef8-81d3a4f80b73	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4d1d-41ac-b13b-621631298d67	67affcc3-762a-4fee-baa4-2a048ddd621e
76b10284-6ec9-43b9-8a3d-161bcda99cee	20202020-57f3-4f50-9599-fc0f671df003	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	note	Note	\N	NoteTarget note	IconNotes	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "noteId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	6685f802-de0d-4a07-bbbe-dbd41627f99a	415d12c3-c586-4222-9c41-994a99cebf67	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-57f3-4f50-9599-fc0f671df003	67affcc3-762a-4fee-baa4-2a048ddd621e
89c515e2-6d66-4934-8718-f2aaf5956667	20202020-38ca-4aab-92f5-8a605ca2e4c5	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	person	Person	\N	NoteTarget person	IconUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9bc9b370-e006-4585-ae91-7c272bdca0f6	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-38ca-4aab-92f5-8a605ca2e4c5	67affcc3-762a-4fee-baa4-2a048ddd621e
0b8666f5-b6c6-415f-aa21-ecc10c0dd0d2	c500fbc0-d6f2-4982-a959-5a755431696c	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	company	Company	\N	NoteTarget company	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2fc8ae33-67f4-43dd-bc10-08d1e5e04532	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	c500fbc0-d6f2-4982-a959-5a755431696c	67affcc3-762a-4fee-baa4-2a048ddd621e
ef70664d-0792-47db-9672-bac7e18bf010	20202020-4e42-417a-a705-76581c9ade79	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	opportunity	Opportunity	\N	NoteTarget opportunity	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "opportunityId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b72653ae-e957-4099-8d49-3ace766474f3	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4e42-417a-a705-76581c9ade79	67affcc3-762a-4fee-baa4-2a048ddd621e
7908ad88-69e7-440d-b824-b718cc469677	20202020-8dfb-42fc-92b6-01afb759ed16	6d830113-2052-4566-a669-df61dd1cd970	RELATION	pointOfContact	Point of Contact	\N	Opportunity point of contact	IconUser	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "pointOfContactId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	bec0d248-5b94-4274-8461-c58aa43144cf	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8dfb-42fc-92b6-01afb759ed16	67affcc3-762a-4fee-baa4-2a048ddd621e
5642d645-5dad-42d2-a255-14b88b8b0bb3	20202020-cbac-457e-b565-adece5fc815f	6d830113-2052-4566-a669-df61dd1cd970	RELATION	company	Company	\N	Opportunity company	IconBuildingSkyscraper	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b8448e0e-7e56-46d2-aad0-03472508b935	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cbac-457e-b565-adece5fc815f	67affcc3-762a-4fee-baa4-2a048ddd621e
6275b301-58b2-42b6-b8d1-356feb1b8092	20202020-a1c2-4500-aaae-83ba8a0e827a	6d830113-2052-4566-a669-df61dd1cd970	RELATION	favorites	Favorites	\N	Favorites linked to the opportunity	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2b770b3c-651e-478e-ac73-b47720bfb9d3	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a1c2-4500-aaae-83ba8a0e827a	67affcc3-762a-4fee-baa4-2a048ddd621e
99265a76-b28e-40c1-8d5e-f13b1031829e	20202020-59c0-4179-a208-4a255f04a5be	6d830113-2052-4566-a669-df61dd1cd970	RELATION	taskTargets	Tasks	\N	Tasks tied to the opportunity	IconCheckbox	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	644979e1-eff3-4247-bfa4-1554b1fa9381	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-59c0-4179-a208-4a255f04a5be	67affcc3-762a-4fee-baa4-2a048ddd621e
b72653ae-e957-4099-8d49-3ace766474f3	20202020-dd3f-42d5-a382-db58aabf43d3	6d830113-2052-4566-a669-df61dd1cd970	RELATION	noteTargets	Notes	\N	Notes tied to the opportunity	IconNotes	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ef70664d-0792-47db-9672-bac7e18bf010	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-dd3f-42d5-a382-db58aabf43d3	67affcc3-762a-4fee-baa4-2a048ddd621e
5ae5fbf5-0c30-4257-a026-bf0cfdd462ca	20202020-87c7-4118-83d6-2f4031005209	6d830113-2052-4566-a669-df61dd1cd970	RELATION	attachments	Attachments	\N	Attachments linked to the opportunity	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	257d19ad-1090-4f33-8c29-bae938934d31	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-87c7-4118-83d6-2f4031005209	67affcc3-762a-4fee-baa4-2a048ddd621e
68ae4805-307a-4c80-a8f7-1451b9a77c44	20202020-30e2-421f-96c7-19c69d1cf631	6d830113-2052-4566-a669-df61dd1cd970	RELATION	timelineActivities	Timeline Activities	\N	Timeline Activities linked to the opportunity.	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	594d1d3a-b146-41e5-a95d-bb6081de32c1	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-30e2-421f-96c7-19c69d1cf631	67affcc3-762a-4fee-baa4-2a048ddd621e
109c99ae-2de0-42a4-8f3e-dcef05bf9ab1	20202020-be7e-4d1e-8e19-3d5c7c4b9f2a	6d830113-2052-4566-a669-df61dd1cd970	RELATION	owner	Owner	\N	Opportunity owner	IconUserCircle	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "ownerId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	c3b345dc-f7b6-41e9-ac4c-5b98bd49310b	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-be7e-4d1e-8e19-3d5c7c4b9f2a	67affcc3-762a-4fee-baa4-2a048ddd621e
2aa99259-fefd-4c96-8660-029d7eaf7050	20202020-e2f3-448e-b34c-2d625f0025fd	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	company	Company	\N	Contact's company	IconBuildingSkyscraper	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0b77046a-2396-4655-ae12-b0ab2c81e12f	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e2f3-448e-b34c-2d625f0025fd	67affcc3-762a-4fee-baa4-2a048ddd621e
bec0d248-5b94-4274-8461-c58aa43144cf	20202020-911b-4a7d-b67b-918aa9a5b33a	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	pointOfContactForOpportunities	Opportunities	\N	List of opportunities for which that person is the point of contact	IconTargetArrow	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7908ad88-69e7-440d-b824-b718cc469677	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-911b-4a7d-b67b-918aa9a5b33a	67affcc3-762a-4fee-baa4-2a048ddd621e
ae0de9da-507f-4458-b5a5-c7b7db2cd07e	20202020-584b-4d3e-88b6-53ab1fa03c3a	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	taskTargets	Tasks	\N	Tasks tied to the contact	IconCheckbox	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	a1e54687-b9d2-4717-adcb-a3a858e8004c	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-584b-4d3e-88b6-53ab1fa03c3a	67affcc3-762a-4fee-baa4-2a048ddd621e
9bc9b370-e006-4585-ae91-7c272bdca0f6	20202020-c8fc-4258-8250-15905d3fcfec	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	noteTargets	Notes	\N	Notes tied to the contact	IconNotes	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	89c515e2-6d66-4934-8718-f2aaf5956667	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c8fc-4258-8250-15905d3fcfec	67affcc3-762a-4fee-baa4-2a048ddd621e
8ab2cb6f-fbc0-4086-a3be-a59381f82f69	20202020-4073-4117-9cf1-203bcdc91cbd	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	favorites	Favorites	\N	Favorites linked to the contact	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	a420621f-912b-4d2b-839f-c36e9879bb11	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4073-4117-9cf1-203bcdc91cbd	67affcc3-762a-4fee-baa4-2a048ddd621e
f318014b-3c44-4e69-879a-457f5eb343ef	20202020-cd97-451f-87fa-bcb789bdbf3a	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	attachments	Attachments	\N	Attachments linked to the contact.	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	10e3877a-e3bf-449d-8aa0-9d7e71b9a75a	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-cd97-451f-87fa-bcb789bdbf3a	67affcc3-762a-4fee-baa4-2a048ddd621e
256381a3-d9c5-45c3-a3ee-fd75d225f6f3	20202020-498e-4c61-8158-fa04f0638334	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	messageParticipants	Message Participants	\N	Message Participants	IconUserCircle	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9db0d8eb-e1f7-475e-9f02-c6b2a8e008f0	e386c71a-338d-4a79-ae0e-792bc13d7c22	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-498e-4c61-8158-fa04f0638334	67affcc3-762a-4fee-baa4-2a048ddd621e
27e30450-c86c-49a3-809b-fc27aff23e8a	20202020-52ee-45e9-a702-b64b3753e3a9	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	calendarEventParticipants	Calendar Event Participants	\N	Calendar Event Participants	IconCalendar	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	069959f4-99ea-433d-a0ab-db690b92875e	582910b3-32c9-4959-a72c-ebb309bc29f4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-52ee-45e9-a702-b64b3753e3a9	67affcc3-762a-4fee-baa4-2a048ddd621e
05602e10-ddc7-448e-88b2-515290ee88f4	20202020-a43e-4873-9c23-e522de906ce5	41a553bd-c463-40f2-88bc-07967f17a128	RELATION	timelineActivities	Events	\N	Events linked to the person	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7d013749-da84-4768-a40c-2d6d97048b36	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-a43e-4873-9c23-e522de906ce5	67affcc3-762a-4fee-baa4-2a048ddd621e
f0bfd996-8714-435b-960d-94f0b665f931	20202020-de9c-4d0e-a452-713d4a3e5fc7	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RELATION	taskTargets	Relations	\N	Task targets	IconArrowUpRight	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	e1930bc6-edc1-495c-8618-e9cd3eea7815	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-de9c-4d0e-a452-713d4a3e5fc7	67affcc3-762a-4fee-baa4-2a048ddd621e
43234d0b-36b5-4c05-861b-81d10c4db950	20202020-794d-4783-a8ff-cecdb15be139	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RELATION	attachments	Attachments	\N	Task attachments	IconFileImport	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f735595c-8902-403f-8f00-19d6150f8025	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-794d-4783-a8ff-cecdb15be139	67affcc3-762a-4fee-baa4-2a048ddd621e
9d29a26e-ef11-4808-96ac-6ac7b9705ece	20202020-065a-4f42-a906-e20422c1753f	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RELATION	assignee	Assignee	\N	Task assignee	IconUserCircle	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "assigneeId"}	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	69ec3dbd-de34-4e7a-a957-07cf0e3ac944	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-065a-4f42-a906-e20422c1753f	67affcc3-762a-4fee-baa4-2a048ddd621e
55f0c828-c68b-43f5-8319-e39ece33e69c	20202020-c778-4278-99ee-23a2837aee64	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RELATION	timelineActivities	Timeline Activities	\N	Timeline Activities linked to the task.	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d1e65c1b-0d1c-4da6-a454-d620d508f725	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c778-4278-99ee-23a2837aee64	67affcc3-762a-4fee-baa4-2a048ddd621e
09768190-55a9-411a-ab8f-a1f4ab9ad285	20202020-4d1d-41ac-b13b-621631298d65	ff60777a-2722-4aa0-ba66-a8e089c7bc94	RELATION	favorites	Favorites	\N	Favorites linked to the task	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d7e08160-79be-4034-8be6-230bcd571fe6	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4d1d-41ac-b13b-621631298d65	67affcc3-762a-4fee-baa4-2a048ddd621e
e1930bc6-edc1-495c-8618-e9cd3eea7815	20202020-e881-457a-8758-74aaef4ae78a	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	task	Task	\N	TaskTarget task	IconCheckbox	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "taskId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f0bfd996-8714-435b-960d-94f0b665f931	ff60777a-2722-4aa0-ba66-a8e089c7bc94	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e881-457a-8758-74aaef4ae78a	67affcc3-762a-4fee-baa4-2a048ddd621e
a1e54687-b9d2-4717-adcb-a3a858e8004c	20202020-c8a0-4e85-a016-87e2349cfbec	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	person	Person	\N	TaskTarget person	IconUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "personId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ae0de9da-507f-4458-b5a5-c7b7db2cd07e	41a553bd-c463-40f2-88bc-07967f17a128	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c8a0-4e85-a016-87e2349cfbec	67affcc3-762a-4fee-baa4-2a048ddd621e
d4cf4089-b705-471c-978a-0911724cf4dc	20202020-4703-4a4e-948c-487b0c60a92c	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	company	Company	\N	TaskTarget company	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "companyId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f6f85d12-d2fb-48da-ab76-efa12ef1982a	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4703-4a4e-948c-487b0c60a92c	67affcc3-762a-4fee-baa4-2a048ddd621e
644979e1-eff3-4247-bfa4-1554b1fa9381	20202020-6cb2-4c01-a9a5-aca3dbc11d41	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	opportunity	Opportunity	\N	TaskTarget opportunity	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "opportunityId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	99265a76-b28e-40c1-8d5e-f13b1031829e	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6cb2-4c01-a9a5-aca3dbc11d41	67affcc3-762a-4fee-baa4-2a048ddd621e
d85cb182-4f51-4ab2-87b8-54ad24285098	20202020-af23-4479-9a30-868edc474b36	16136df1-455c-4a8b-8bb6-e98e1d03b033	RELATION	workspaceMember	Workspace Member	\N	Event workspace member	IconCircleUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workspaceMemberId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	bda3af27-5bdf-4c87-b93a-2e2b0a156f34	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-af23-4479-9a30-868edc474b36	67affcc3-762a-4fee-baa4-2a048ddd621e
7d013749-da84-4768-a40c-2d6d97048b36	20202020-c414-45b9-a60a-ac27aa96229f	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetPerson	Person	\N	Event person	IconUser	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "targetPersonId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	05602e10-ddc7-448e-88b2-515290ee88f4	41a553bd-c463-40f2-88bc-07967f17a128	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c414-45b9-a60a-ac27aa96229f	67affcc3-762a-4fee-baa4-2a048ddd621e
9ed9edd8-0de4-4782-923b-4189878c916b	20202020-04ad-4221-a744-7a8278a5ce21	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetCompany	Company	\N	Event company	IconBuildingSkyscraper	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "targetCompanyId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0f149ce4-0e08-4576-b6ae-3d83f826e3e5	d7124df1-9136-4b65-8c71-befa364161f2	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-04ad-4221-a744-7a8278a5ce21	67affcc3-762a-4fee-baa4-2a048ddd621e
594d1d3a-b146-41e5-a95d-bb6081de32c1	20202020-7664-4a35-a3df-580d389fd527	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetOpportunity	Opportunity	\N	Event opportunity	IconTargetArrow	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetOpportunityId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	68ae4805-307a-4c80-a8f7-1451b9a77c44	6d830113-2052-4566-a669-df61dd1cd970	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7664-4a35-a3df-580d389fd527	67affcc3-762a-4fee-baa4-2a048ddd621e
b0f66363-9837-4281-a846-d20ba8905020	20202020-ec55-4135-8da5-3a20badc0156	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetNote	Note	\N	Event note	IconTargetArrow	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetNoteId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b802145a-d6a5-4e19-9a3b-48a555c8b82e	415d12c3-c586-4222-9c41-994a99cebf67	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-ec55-4135-8da5-3a20badc0156	67affcc3-762a-4fee-baa4-2a048ddd621e
d1e65c1b-0d1c-4da6-a454-d620d508f725	20202020-b2f5-415c-9135-a31dfe49501b	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetTask	Task	\N	Event task	IconTargetArrow	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetTaskId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	55f0c828-c68b-43f5-8319-e39ece33e69c	ff60777a-2722-4aa0-ba66-a8e089c7bc94	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b2f5-415c-9135-a31dfe49501b	67affcc3-762a-4fee-baa4-2a048ddd621e
35a25a0a-e3ad-4a62-b8fa-3eec59095c0e	20202020-616c-4ad3-a2e9-c477c341e295	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetWorkflow	Workflow	\N	Event workflow	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "targetWorkflowId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2b5726bd-a5ce-4190-8b1f-1d146a75db89	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-616c-4ad3-a2e9-c477c341e295	67affcc3-762a-4fee-baa4-2a048ddd621e
8866f1ab-080a-4f3b-bd69-6bf3943dd25e	20202020-74f1-4711-a129-e14ca0ecd744	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetWorkflowVersion	WorkflowVersion	\N	Event workflow version	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "targetWorkflowVersionId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	a9409b1b-af10-4744-9eee-6f102c61e75b	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-74f1-4711-a129-e14ca0ecd744	67affcc3-762a-4fee-baa4-2a048ddd621e
8298d97d-be98-407b-b656-8047a061c2a3	20202020-96f0-401b-9186-a3a0759225ac	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetWorkflowRun	Workflow Run	\N	Event workflow run	IconTargetArrow	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "targetWorkflowRunId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8be079e2-4bd3-41b2-950b-65d29a5030a1	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-96f0-401b-9186-a3a0759225ac	67affcc3-762a-4fee-baa4-2a048ddd621e
28bdcb9a-ea63-4a1a-8671-b51884df6ea9	20202020-7864-48f5-af7c-9e4b60140948	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetDashboard	Dashboard	\N	Event dashboard	IconTargetArrow	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetDashboardId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	3bb08151-a6fd-495d-b3f5-4b55f71a47b8	a34181a4-c008-4fcb-b55e-3f1bdf07d717	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-7864-48f5-af7c-9e4b60140948	67affcc3-762a-4fee-baa4-2a048ddd621e
5dee97cb-17ba-4496-896c-db1480be3336	20202020-b9a7-48d8-8387-b9a3090a50ec	be33c5f3-ee15-4555-9f5f-209b30f33076	DATE_TIME	deletedAt	Deleted at	\N	Deletion date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	5dee97cb-17ba-4496-896c-db1480be3336	bbb719d5-4626-40d6-aec6-7d53f24e5459
ed3a3450-95cb-4a65-b945-949f7a018da4	20202020-9432-416e-8f3c-27ee3153d099	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	versions	Versions	\N	Workflow versions linked to the workflow.	IconVersions	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	961bf741-22a8-480e-92fa-20920451dc70	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9432-416e-8f3c-27ee3153d099	67affcc3-762a-4fee-baa4-2a048ddd621e
8a6db815-72ac-4c30-a068-6e25e1e799ae	20202020-759b-4340-b58b-e73595c4df4f	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	runs	Runs	\N	Workflow runs linked to the workflow.	IconRun	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	a29232bd-cadb-42ba-90e8-b0a18121f675	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-759b-4340-b58b-e73595c4df4f	67affcc3-762a-4fee-baa4-2a048ddd621e
70f0d516-aa8c-460e-8450-a8967344d841	20202020-3319-4234-a34c-117ecad2b8a9	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	automatedTriggers	Automated Triggers	\N	Workflow automated triggers linked to the workflow.	IconSettingsAutomation	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	a4211d48-22e3-4b86-93b3-d6fa251eb669	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3319-4234-a34c-117ecad2b8a9	67affcc3-762a-4fee-baa4-2a048ddd621e
325c3e9d-7269-44fb-a9bf-f25fea56e434	20202020-c554-4c41-be7a-cf9cd4b0d512	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	favorites	Favorites	\N	Favorites linked to the workflow	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2f7d9b3c-e8d6-42de-97b6-1606a8e829c0	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-c554-4c41-be7a-cf9cd4b0d512	67affcc3-762a-4fee-baa4-2a048ddd621e
2b5726bd-a5ce-4190-8b1f-1d146a75db89	20202020-906e-486a-a798-131a5f081faf	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	timelineActivities	Timeline Activities	\N	Timeline activities linked to the workflow	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	35a25a0a-e3ad-4a62-b8fa-3eec59095c0e	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-906e-486a-a798-131a5f081faf	67affcc3-762a-4fee-baa4-2a048ddd621e
92dca032-ffc1-4286-8944-bb7a94780a22	20202020-4a8c-4e2d-9b1c-7e5f3a2b4c6d	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	RELATION	attachments	Attachments	\N	Attachments linked to the workflow	IconFileUpload	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	f	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ada2aa94-5a69-4126-9a64-91404e576111	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4a8c-4e2d-9b1c-7e5f3a2b4c6d	67affcc3-762a-4fee-baa4-2a048ddd621e
a4211d48-22e3-4b86-93b3-d6fa251eb669	20202020-3319-4234-a34c-8e1a4d2f7c03	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	RELATION	workflow	Workflow	\N	WorkflowAutomatedTrigger workflow	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	70f0d516-aa8c-460e-8450-a8967344d841	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-3319-4234-a34c-8e1a4d2f7c03	67affcc3-762a-4fee-baa4-2a048ddd621e
7d1a1e8b-b6e2-48c1-84b1-c31c71e03aaa	20202020-2f52-4ba8-8dc4-d0d6adb9578d	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RELATION	workflowVersion	Workflow version	\N	Workflow version linked to the run.	IconVersions	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowVersionId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	fa2e0d68-2317-4cc1-b115-93df592e589d	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-2f52-4ba8-8dc4-d0d6adb9578d	67affcc3-762a-4fee-baa4-2a048ddd621e
a29232bd-cadb-42ba-90e8-b0a18121f675	20202020-8c57-4e7f-84f5-f373f68e1b82	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RELATION	workflow	Workflow	\N	Workflow linked to the run.	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowId"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8a6db815-72ac-4c30-a068-6e25e1e799ae	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8c57-4e7f-84f5-f373f68e1b82	67affcc3-762a-4fee-baa4-2a048ddd621e
ae5e6fe5-701d-4dc4-b2e0-e878c032d4ff	20202020-4baf-4604-b899-2f7fcfbbf90d	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RELATION	favorites	Favorites	\N	Favorites linked to the workflow run	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	c3387e21-0126-4671-a766-93cd0f305598	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-4baf-4604-b899-2f7fcfbbf90d	67affcc3-762a-4fee-baa4-2a048ddd621e
8be079e2-4bd3-41b2-950b-65d29a5030a1	20202020-af4d-4eb0-babc-eb960a45b356	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	RELATION	timelineActivities	Timeline Activities	\N	Timeline activities linked to the run	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8298d97d-be98-407b-b656-8047a061c2a3	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-af4d-4eb0-babc-eb960a45b356	67affcc3-762a-4fee-baa4-2a048ddd621e
961bf741-22a8-480e-92fa-20920451dc70	20202020-afa3-46c3-91b0-0631ca6aa1c8	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RELATION	workflow	Workflow	\N	WorkflowVersion workflow	IconSettingsAutomation	\N	\N	{"onDelete": "CASCADE", "relationType": "MANY_TO_ONE", "joinColumnName": "workflowId"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ed3a3450-95cb-4a65-b945-949f7a018da4	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-afa3-46c3-91b0-0631ca6aa1c8	67affcc3-762a-4fee-baa4-2a048ddd621e
fa2e0d68-2317-4cc1-b115-93df592e589d	20202020-1d08-46df-901a-85045f18099a	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RELATION	runs	Runs	\N	Workflow runs linked to the version.	IconRun	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7d1a1e8b-b6e2-48c1-84b1-c31c71e03aaa	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-1d08-46df-901a-85045f18099a	67affcc3-762a-4fee-baa4-2a048ddd621e
9f44f4a1-e08d-4c29-bef8-30d2c660a9fc	20202020-b8e0-4e57-928d-b51671cc71f2	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RELATION	favorites	Favorites	\N	Favorites linked to the workflow version	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	bc86ad93-0b90-4023-9930-ab5088f492f1	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-b8e0-4e57-928d-b51671cc71f2	67affcc3-762a-4fee-baa4-2a048ddd621e
a9409b1b-af10-4744-9eee-6f102c61e75b	20202020-fcb0-4695-b17e-3b43a421c633	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	RELATION	timelineActivities	Timeline Activities	\N	Timeline activities linked to the version	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	8866f1ab-080a-4f3b-bd69-6bf3943dd25e	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-fcb0-4695-b17e-3b43a421c633	67affcc3-762a-4fee-baa4-2a048ddd621e
69ec3dbd-de34-4e7a-a957-07cf0e3ac944	20202020-61dc-4a1c-99e8-38ebf8d2bbeb	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	assignedTasks	Assigned tasks	\N	Tasks assigned to the workspace member	IconCheckbox	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9d29a26e-ef11-4808-96ac-6ac7b9705ece	ff60777a-2722-4aa0-ba66-a8e089c7bc94	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-61dc-4a1c-99e8-38ebf8d2bbeb	67affcc3-762a-4fee-baa4-2a048ddd621e
30792e06-c85a-4eb5-be2b-31421ea983c2	20202020-f3c1-4faf-b343-cf7681038757	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	favorites	Favorites	\N	Favorites linked to the workspace member	IconHeart	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	cfd497ce-69b3-4c17-9b43-58a6a968ed0e	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-f3c1-4faf-b343-cf7681038757	67affcc3-762a-4fee-baa4-2a048ddd621e
00ba8267-88db-41ae-96eb-78c63da446cc	20202020-dc29-4bd4-a3c1-29eafa324bee	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	accountOwnerForCompanies	Account Owner For Companies	\N	Account owner for companies	IconBriefcase	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b20c80a8-b163-4946-89bf-fccc4c8248a7	d7124df1-9136-4b65-8c71-befa364161f2	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-dc29-4bd4-a3c1-29eafa324bee	67affcc3-762a-4fee-baa4-2a048ddd621e
9c0bdc43-fe72-466a-9240-f525292152ee	20202020-e322-4bde-a525-727079b4a100	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	connectedAccounts	Connected accounts	\N	Connected accounts	IconAt	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	5a5c299e-7726-4c47-9dab-bf13eef39195	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e322-4bde-a525-727079b4a100	67affcc3-762a-4fee-baa4-2a048ddd621e
9f364ce9-4212-4c98-b1b3-9bb1e5e9de3c	20202020-8f99-48bc-a5eb-edd33dd54188	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	messageParticipants	Message Participants	\N	Message Participants	IconUserCircle	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b8de3e96-8287-428c-8863-24b7b6e67a8f	e386c71a-338d-4a79-ae0e-792bc13d7c22	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-8f99-48bc-a5eb-edd33dd54188	67affcc3-762a-4fee-baa4-2a048ddd621e
83747ca4-72c1-495e-9d0b-7f2ac3bcb81b	20202020-6cb2-4161-9f29-a4b7f1283859	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	blocklist	Blocklist	\N	Blocklisted handles	IconForbid2	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	46b0e181-869a-4546-8fd4-7a4ca4ee2f25	b438fbab-6bac-43b0-8550-1e70fb608333	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-6cb2-4161-9f29-a4b7f1283859	67affcc3-762a-4fee-baa4-2a048ddd621e
8c8c728c-70b5-4fb1-b9ce-96273883f871	20202020-0dbc-4841-9ce1-3e793b5b3512	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	calendarEventParticipants	Calendar Event Participants	\N	Calendar Event Participants	IconCalendar	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	e6b72d67-67c3-4549-8159-7b69af043a3e	582910b3-32c9-4959-a72c-ebb309bc29f4	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-0dbc-4841-9ce1-3e793b5b3512	67affcc3-762a-4fee-baa4-2a048ddd621e
bda3af27-5bdf-4c87-b93a-2e2b0a156f34	20202020-e15b-47b8-94fe-8200e3c66615	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	timelineActivities	Events	\N	Events linked to the workspace member	IconTimelineEvent	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d85cb182-4f51-4ab2-87b8-54ad24285098	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-e15b-47b8-94fe-8200e3c66615	67affcc3-762a-4fee-baa4-2a048ddd621e
c3b345dc-f7b6-41e9-ac4c-5b98bd49310b	20202020-9e4d-4b3a-8c1f-6d7e8f9a0b1c	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	ownedOpportunities	Owned opportunities	\N	Opportunities owned by the workspace member	IconTargetArrow	\N	\N	{"relationType": "ONE_TO_MANY"}	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	109c99ae-2de0-42a4-8f3e-dcef05bf9ab1	6d830113-2052-4566-a669-df61dd1cd970	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	20202020-9e4d-4b3a-8c1f-6d7e8f9a0b1c	67affcc3-762a-4fee-baa4-2a048ddd621e
26318504-58db-40f9-94e9-74e92c35a7df	20202020-eda0-4cee-9577-3eb357e3c22b	be33c5f3-ee15-4555-9f5f-209b30f33076	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	26318504-58db-40f9-94e9-74e92c35a7df	bbb719d5-4626-40d6-aec6-7d53f24e5459
e7b8f0eb-d5af-43a5-b01e-b0c607b833b9	20202020-ba07-4ffd-ba63-009491f5749c	be33c5f3-ee15-4555-9f5f-209b30f33076	TEXT	name	Name	\N	Name	IconAbc	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	e7b8f0eb-d5af-43a5-b01e-b0c607b833b9	bbb719d5-4626-40d6-aec6-7d53f24e5459
8d88839b-7de7-4968-b57d-b0afe4339f32	20202020-be0e-4971-865b-32ca87cbb315	be33c5f3-ee15-4555-9f5f-209b30f33076	ACTOR	createdBy	Created by	{"name": "''", "source": "'MANUAL'"}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	8d88839b-7de7-4968-b57d-b0afe4339f32	bbb719d5-4626-40d6-aec6-7d53f24e5459
07954832-740c-456d-ba83-e16522c0fa5d	20202020-c2bd-4e16-bb9a-c8b0411bf49d	be33c5f3-ee15-4555-9f5f-209b30f33076	POSITION	position	Position	0	Position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	07954832-740c-456d-ba83-e16522c0fa5d	bbb719d5-4626-40d6-aec6-7d53f24e5459
e14176e8-734a-406e-9da0-332b5c074e23	70e56537-18ef-4811-b1c7-0a444006b815	be33c5f3-ee15-4555-9f5f-209b30f33076	TS_VECTOR	searchVector	Search vector	\N	Search vector	IconSearch	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	e14176e8-734a-406e-9da0-332b5c074e23	bbb719d5-4626-40d6-aec6-7d53f24e5459
90922d68-8d3a-4487-aef5-e7bdda1dd5b6	20202020-f1ef-4ba4-8f33-1a4577afa477	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	timelineActivities	Timeline Activities	\N	Properties tied to the Timeline Activity	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b47f9a28-2927-499c-9f81-acf7bb9ad329	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:19:34.491+00	2026-02-28 05:19:34.491+00	27a66d08-0948-4c29-a904-2bd70574b134	bbb719d5-4626-40d6-aec6-7d53f24e5459
72667c22-8636-48ee-9f8b-50b3eafa43e2	20202020-a4a7-4686-b296-1c6c3482ee21	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	favorites	Favorites	\N	Properties tied to the Favorite	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	2a872f3c-4096-4449-8e22-26c634368bb7	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:19:34.493+00	2026-02-28 05:19:34.493+00	2195f236-6eed-4c9f-95d7-2c35236353c0	bbb719d5-4626-40d6-aec6-7d53f24e5459
dbd5cea3-f490-496f-a576-a0753d234602	20202020-8d59-46ca-b7b2-73d167712134	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	attachments	Attachments	\N	Properties tied to the Attachment	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	db92560a-f092-4952-822b-57134eb3e8fb	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:19:34.494+00	2026-02-28 05:19:34.494+00	1ebc5a39-8aaf-4d26-acfa-067d29cefd77	bbb719d5-4626-40d6-aec6-7d53f24e5459
eac85a0e-7eb5-4699-8b58-1a1a9652bbdd	20202020-01fd-4f37-99dc-9427a444018a	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	noteTargets	Note Targets	\N	Properties tied to the Note Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	e9864e4e-21a0-403d-a515-26441c0671f0	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:19:34.494+00	2026-02-28 05:19:34.494+00	ad62ce28-0a72-421d-845f-a3c2d603f4c5	bbb719d5-4626-40d6-aec6-7d53f24e5459
df576a0a-64ce-4e39-86e8-5539afed1ebc	20202020-0860-4566-b865-bff3c626c303	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	taskTargets	Task Targets	\N	Properties tied to the Task Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b2773567-9096-49bb-92b2-325bd4dad805	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:19:34.494+00	2026-02-28 05:19:34.494+00	6f053a00-32ec-4ea5-a3e5-f5cd37e2f628	bbb719d5-4626-40d6-aec6-7d53f24e5459
b47f9a28-2927-499c-9f81-acf7bb9ad329	\N	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetProperty	Property	\N	TimelineActivities Property	IconTimelineEvent	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetPropertyId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	90922d68-8d3a-4487-aef5-e7bdda1dd5b6	be33c5f3-ee15-4555-9f5f-209b30f33076	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:19:34.491+00	2026-02-28 05:19:34.491+00	7d7294ea-29a2-449a-8676-39c2588293e1	bbb719d5-4626-40d6-aec6-7d53f24e5459
2a872f3c-4096-4449-8e22-26c634368bb7	\N	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	property	Property	\N	Favorites Property	IconHeart	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "propertyId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	72667c22-8636-48ee-9f8b-50b3eafa43e2	be33c5f3-ee15-4555-9f5f-209b30f33076	\N	2026-02-28 05:19:34.493+00	2026-02-28 05:19:34.493+00	cda827bf-8ec0-4141-a648-ca6898c8da65	bbb719d5-4626-40d6-aec6-7d53f24e5459
db92560a-f092-4952-822b-57134eb3e8fb	\N	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	property	Property	\N	Attachments Property	IconFileImport	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "propertyId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	dbd5cea3-f490-496f-a576-a0753d234602	be33c5f3-ee15-4555-9f5f-209b30f33076	\N	2026-02-28 05:19:34.494+00	2026-02-28 05:19:34.494+00	fc8c2d89-4735-4ed2-b5c9-bbc58ccbb636	bbb719d5-4626-40d6-aec6-7d53f24e5459
e9864e4e-21a0-403d-a515-26441c0671f0	\N	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	property	Property	\N	NoteTargets Property	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "propertyId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	eac85a0e-7eb5-4699-8b58-1a1a9652bbdd	be33c5f3-ee15-4555-9f5f-209b30f33076	\N	2026-02-28 05:19:34.494+00	2026-02-28 05:19:34.494+00	cea7796e-1841-4aed-95a9-631fadfa2472	bbb719d5-4626-40d6-aec6-7d53f24e5459
b2773567-9096-49bb-92b2-325bd4dad805	\N	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	property	Property	\N	TaskTargets Property	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "propertyId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	df576a0a-64ce-4e39-86e8-5539afed1ebc	be33c5f3-ee15-4555-9f5f-209b30f33076	\N	2026-02-28 05:19:34.495+00	2026-02-28 05:19:34.495+00	5847bb8c-0ffe-4ba0-bc58-47b4f2e9e0a5	bbb719d5-4626-40d6-aec6-7d53f24e5459
9d75f191-9d18-4fab-88a5-3f6926761076	\N	be33c5f3-ee15-4555-9f5f-209b30f33076	ADDRESS	location	Location	{"addressLat": null, "addressLng": null, "addressCity": null, "addressState": null, "addressCountry": "'India'", "addressStreet1": "''", "addressStreet2": null, "addressPostcode": null}	\N	IconMap	\N	\N	{"subFields": ["addressStreet1", "addressStreet2", "addressCity", "addressState", "addressPostcode", "addressCountry"]}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 05:22:20.049+00	2026-02-28 05:22:20.049+00	397af348-600e-435b-83fe-60c806b435fb	bbb719d5-4626-40d6-aec6-7d53f24e5459
d70dc5dd-7ff5-469a-ad5e-d92b0e703b2c	20202020-eda0-4cee-9577-3eb357e3c22b	430929f9-3e67-479e-8af2-aa6ae925ff82	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	d70dc5dd-7ff5-469a-ad5e-d92b0e703b2c	bbb719d5-4626-40d6-aec6-7d53f24e5459
67ce61ef-73a8-47ee-85e7-390db6fadb9a	20202020-ba07-4ffd-ba63-009491f5749c	430929f9-3e67-479e-8af2-aa6ae925ff82	TEXT	name	Name	\N	Name	IconAbc	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	67ce61ef-73a8-47ee-85e7-390db6fadb9a	bbb719d5-4626-40d6-aec6-7d53f24e5459
2d2fb0bb-695e-4b59-9257-e168acf725b9	20202020-66ac-4502-9975-e4d959c50311	430929f9-3e67-479e-8af2-aa6ae925ff82	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	2d2fb0bb-695e-4b59-9257-e168acf725b9	bbb719d5-4626-40d6-aec6-7d53f24e5459
f0433ca0-a931-444f-b8e0-18f078bb3151	20202020-d767-4622-bdcf-d8a084834d86	430929f9-3e67-479e-8af2-aa6ae925ff82	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	f0433ca0-a931-444f-b8e0-18f078bb3151	bbb719d5-4626-40d6-aec6-7d53f24e5459
6b778324-ad5b-44c4-bc23-ed2c23464587	d047ccb4-9469-4514-a982-29c4ae49317d	430929f9-3e67-479e-8af2-aa6ae925ff82	ACTOR	updatedBy	Updated by	{"name": "''", "source": "'MANUAL'"}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	6b778324-ad5b-44c4-bc23-ed2c23464587	bbb719d5-4626-40d6-aec6-7d53f24e5459
769720ee-2788-4ae3-889a-286b3d8ccd63	20202020-b9a7-48d8-8387-b9a3090a50ec	430929f9-3e67-479e-8af2-aa6ae925ff82	DATE_TIME	deletedAt	Deleted at	\N	Deletion date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	769720ee-2788-4ae3-889a-286b3d8ccd63	bbb719d5-4626-40d6-aec6-7d53f24e5459
c37c131f-05dd-417c-a7ac-eb37079bf14f	20202020-be0e-4971-865b-32ca87cbb315	430929f9-3e67-479e-8af2-aa6ae925ff82	ACTOR	createdBy	Created by	{"name": "''", "source": "'MANUAL'"}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	c37c131f-05dd-417c-a7ac-eb37079bf14f	bbb719d5-4626-40d6-aec6-7d53f24e5459
5a070a05-830e-4fc4-bffa-5eeed521f5da	20202020-c2bd-4e16-bb9a-c8b0411bf49d	430929f9-3e67-479e-8af2-aa6ae925ff82	POSITION	position	Position	0	Position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	5a070a05-830e-4fc4-bffa-5eeed521f5da	bbb719d5-4626-40d6-aec6-7d53f24e5459
0a9e5328-f462-48f6-9842-e54040239c76	70e56537-18ef-4811-b1c7-0a444006b815	430929f9-3e67-479e-8af2-aa6ae925ff82	TS_VECTOR	searchVector	Search vector	\N	Search vector	IconSearch	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	0a9e5328-f462-48f6-9842-e54040239c76	bbb719d5-4626-40d6-aec6-7d53f24e5459
645b40a3-5284-420c-9333-d1de7d0f7cc8	20202020-f1ef-4ba4-8f33-1a4577afa477	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	timelineActivities	Timeline Activities	\N	Origins tied to the Timeline Activity	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	cb64b0d8-2a42-4094-8323-0392a8f080fc	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	e1fd7d2b-d1df-4910-9f61-7b5332e605c1	bbb719d5-4626-40d6-aec6-7d53f24e5459
feb6d0e4-72d7-436c-8798-c0b956192a73	20202020-a4a7-4686-b296-1c6c3482ee21	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	favorites	Favorites	\N	Origins tied to the Favorite	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	890499a0-d969-4563-9002-1fa93261f2f5	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	5b6fb6e3-b9ea-438c-afe7-fdb623d70e20	bbb719d5-4626-40d6-aec6-7d53f24e5459
fdebecdd-c8a0-493a-ad94-687492a637d9	20202020-8d59-46ca-b7b2-73d167712134	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	attachments	Attachments	\N	Origins tied to the Attachment	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0a7b0119-163f-4546-bebe-5730e6933bfa	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	fdf6970b-6df1-4b38-94fd-6612d2609a3c	bbb719d5-4626-40d6-aec6-7d53f24e5459
ba0eb8f0-8517-466d-af89-c3ec7dd42949	20202020-01fd-4f37-99dc-9427a444018a	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	noteTargets	Note Targets	\N	Origins tied to the Note Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	bc1d6d1c-7926-4276-ad16-c4be6cd89e38	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	b80f2b7e-7f6e-4d3a-a929-6578e3ead22b	bbb719d5-4626-40d6-aec6-7d53f24e5459
64e404c9-1550-4cb5-9f05-dc5f082d03ea	20202020-0860-4566-b865-bff3c626c303	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	taskTargets	Task Targets	\N	Origins tied to the Task Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	f7c1c9a6-5c09-4014-abe8-cb8b79becf92	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	309ac48e-e30f-4efa-a905-d81af19381cb	bbb719d5-4626-40d6-aec6-7d53f24e5459
cb64b0d8-2a42-4094-8323-0392a8f080fc	\N	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetOrigin	Origin	\N	TimelineActivities Origin	IconTimelineEvent	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetOriginId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	645b40a3-5284-420c-9333-d1de7d0f7cc8	430929f9-3e67-479e-8af2-aa6ae925ff82	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	b0e93ab4-96fc-4e95-aa44-5163a819ea9c	bbb719d5-4626-40d6-aec6-7d53f24e5459
890499a0-d969-4563-9002-1fa93261f2f5	\N	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	origin	Origin	\N	Favorites Origin	IconHeart	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "originId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	feb6d0e4-72d7-436c-8798-c0b956192a73	430929f9-3e67-479e-8af2-aa6ae925ff82	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	74f22ee8-271a-4fc3-acf3-b53076b96d21	bbb719d5-4626-40d6-aec6-7d53f24e5459
0a7b0119-163f-4546-bebe-5730e6933bfa	\N	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	origin	Origin	\N	Attachments Origin	IconFileImport	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "originId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	fdebecdd-c8a0-493a-ad94-687492a637d9	430929f9-3e67-479e-8af2-aa6ae925ff82	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	0588bd58-83f7-4291-89d7-a461c9c3cd8d	bbb719d5-4626-40d6-aec6-7d53f24e5459
bc1d6d1c-7926-4276-ad16-c4be6cd89e38	\N	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	origin	Origin	\N	NoteTargets Origin	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "originId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ba0eb8f0-8517-466d-af89-c3ec7dd42949	430929f9-3e67-479e-8af2-aa6ae925ff82	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	f63130a4-4347-48ea-bf16-1402c99fc56d	bbb719d5-4626-40d6-aec6-7d53f24e5459
f7c1c9a6-5c09-4014-abe8-cb8b79becf92	\N	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	origin	Origin	\N	TaskTargets Origin	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "originId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	64e404c9-1550-4cb5-9f05-dc5f082d03ea	430929f9-3e67-479e-8af2-aa6ae925ff82	\N	2026-02-28 05:53:09.685+00	2026-02-28 05:53:09.685+00	de425ed4-c778-4258-9db4-5695cb6d184d	bbb719d5-4626-40d6-aec6-7d53f24e5459
8a8dab81-c095-4808-9034-de4e91827404	20202020-eda0-4cee-9577-3eb357e3c22b	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	8a8dab81-c095-4808-9034-de4e91827404	bbb719d5-4626-40d6-aec6-7d53f24e5459
044735bf-c886-450b-ae9d-fa4f03eca30b	20202020-ba07-4ffd-ba63-009491f5749c	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	TEXT	name	Name	\N	Name	IconAbc	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	044735bf-c886-450b-ae9d-fa4f03eca30b	bbb719d5-4626-40d6-aec6-7d53f24e5459
1c1291f6-1047-4609-927d-24218ec3a392	20202020-66ac-4502-9975-e4d959c50311	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	1c1291f6-1047-4609-927d-24218ec3a392	bbb719d5-4626-40d6-aec6-7d53f24e5459
3f005c6b-4dba-448f-a954-ca1e8ec8b942	20202020-d767-4622-bdcf-d8a084834d86	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	3f005c6b-4dba-448f-a954-ca1e8ec8b942	bbb719d5-4626-40d6-aec6-7d53f24e5459
e8086330-01e9-469d-81e6-703229f170b0	d047ccb4-9469-4514-a982-29c4ae49317d	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	ACTOR	updatedBy	Updated by	{"name": "''", "source": "'MANUAL'"}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	e8086330-01e9-469d-81e6-703229f170b0	bbb719d5-4626-40d6-aec6-7d53f24e5459
118d39b8-adfb-4407-b613-e408af274dd5	20202020-b9a7-48d8-8387-b9a3090a50ec	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	DATE_TIME	deletedAt	Deleted at	\N	Deletion date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	118d39b8-adfb-4407-b613-e408af274dd5	bbb719d5-4626-40d6-aec6-7d53f24e5459
91900025-c565-460d-be3e-86c4a7b9e465	20202020-be0e-4971-865b-32ca87cbb315	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	ACTOR	createdBy	Created by	{"name": "''", "source": "'MANUAL'"}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	91900025-c565-460d-be3e-86c4a7b9e465	bbb719d5-4626-40d6-aec6-7d53f24e5459
515e91cf-5cf5-4e57-a7e3-8489c188e558	20202020-c2bd-4e16-bb9a-c8b0411bf49d	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	POSITION	position	Position	0	Position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	515e91cf-5cf5-4e57-a7e3-8489c188e558	bbb719d5-4626-40d6-aec6-7d53f24e5459
47629a92-4307-460a-a256-503950184789	70e56537-18ef-4811-b1c7-0a444006b815	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	TS_VECTOR	searchVector	Search vector	\N	Search vector	IconSearch	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:14:51.758+00	2026-02-28 06:14:51.758+00	47629a92-4307-460a-a256-503950184789	bbb719d5-4626-40d6-aec6-7d53f24e5459
5406aa36-178e-470b-9f17-817697b93d8e	20202020-f1ef-4ba4-8f33-1a4577afa477	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	timelineActivities	Timeline Activities	\N	Leads tied to the Timeline Activity	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ae1151fb-f869-4a61-b50b-d94ef4b77208	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 06:14:51.76+00	2026-02-28 06:14:51.76+00	7f851922-39fa-42ab-af30-682de8d115e9	bbb719d5-4626-40d6-aec6-7d53f24e5459
4ca264c6-e9f6-49a1-87c0-b49bf44ce205	20202020-a4a7-4686-b296-1c6c3482ee21	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	favorites	Favorites	\N	Leads tied to the Favorite	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	091ff4ec-e54f-48be-bd86-46fbb9ef1d60	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	11508c7b-d59d-49ab-b454-de7a74779470	bbb719d5-4626-40d6-aec6-7d53f24e5459
ea13638f-0f07-49e9-91a3-c6f2a1736951	20202020-8d59-46ca-b7b2-73d167712134	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	attachments	Attachments	\N	Leads tied to the Attachment	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ef3f8e1e-e878-4afc-a1d6-9ab4290fc8df	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	e44b2799-0ed9-4e3d-aa1e-f6e42c6bda7d	bbb719d5-4626-40d6-aec6-7d53f24e5459
434038b5-057e-492c-9e95-8de7caab39ac	20202020-01fd-4f37-99dc-9427a444018a	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	noteTargets	Note Targets	\N	Leads tied to the Note Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	45773be2-cf95-4ba2-b842-0a2582234041	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	463d97e9-8230-47b9-afa5-3bf1ae73fb23	bbb719d5-4626-40d6-aec6-7d53f24e5459
4ae9f935-cf92-4828-947c-c74cb4ea89c3	20202020-0860-4566-b865-bff3c626c303	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	taskTargets	Task Targets	\N	Leads tied to the Task Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	7c93b797-1827-4b7f-ac27-880925b1c72d	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	13a7aca8-4b43-4025-9593-f108616a766d	bbb719d5-4626-40d6-aec6-7d53f24e5459
ae1151fb-f869-4a61-b50b-d94ef4b77208	\N	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetLead	Lead	\N	TimelineActivities Lead	IconTimelineEvent	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetLeadId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	5406aa36-178e-470b-9f17-817697b93d8e	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 06:14:51.76+00	2026-02-28 06:14:51.76+00	721e845b-34c0-454d-a5de-bbf0b25ae09d	bbb719d5-4626-40d6-aec6-7d53f24e5459
091ff4ec-e54f-48be-bd86-46fbb9ef1d60	\N	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	lead	Lead	\N	Favorites Lead	IconHeart	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "leadId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	4ca264c6-e9f6-49a1-87c0-b49bf44ce205	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	ce14bbf2-adde-41ca-9136-b88ad201f367	bbb719d5-4626-40d6-aec6-7d53f24e5459
ef3f8e1e-e878-4afc-a1d6-9ab4290fc8df	\N	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	lead	Lead	\N	Attachments Lead	IconFileImport	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "leadId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	ea13638f-0f07-49e9-91a3-c6f2a1736951	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	a64e3c79-8d61-4393-80e1-d9649c667e97	bbb719d5-4626-40d6-aec6-7d53f24e5459
45773be2-cf95-4ba2-b842-0a2582234041	\N	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	lead	Lead	\N	NoteTargets Lead	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "leadId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	434038b5-057e-492c-9e95-8de7caab39ac	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	3755fb20-dfc5-4c67-8b17-97b0fef49bd0	bbb719d5-4626-40d6-aec6-7d53f24e5459
7c93b797-1827-4b7f-ac27-880925b1c72d	\N	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	lead	Lead	\N	TaskTargets Lead	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "leadId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	4ae9f935-cf92-4828-947c-c74cb4ea89c3	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	b7dac406-f1c5-4da4-a67c-968d995d8a7f	bbb719d5-4626-40d6-aec6-7d53f24e5459
b57d57cb-65e6-4b2d-aea8-bc10d22b66d4	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	origin	Origin	\N	Leads tied to the Origin	IconRelationOneToMany	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "originId"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	38b4df8b-3f77-4dfe-a142-cfe36719b696	430929f9-3e67-479e-8af2-aa6ae925ff82	\N	2026-02-28 06:15:29.179+00	2026-02-28 06:15:29.179+00	bf4d6436-25be-412d-9f70-8c5d35eda706	bbb719d5-4626-40d6-aec6-7d53f24e5459
38b4df8b-3f77-4dfe-a142-cfe36719b696	\N	430929f9-3e67-479e-8af2-aa6ae925ff82	RELATION	lead	lead	\N	Origins Lead	IconUsers	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b57d57cb-65e6-4b2d-aea8-bc10d22b66d4	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:15:29.179+00	2026-02-28 06:15:29.179+00	23d3d160-3444-46e1-a231-094e788113e1	bbb719d5-4626-40d6-aec6-7d53f24e5459
4bf15d7b-5629-42ca-bcd0-7c1bf2a0d833	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	property	Property	\N	Leads tied to the Property	IconRelationOneToMany	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "propertyId"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	0d15e328-1f6a-4c06-ac15-9166e70c2efc	be33c5f3-ee15-4555-9f5f-209b30f33076	\N	2026-02-28 06:16:56.697+00	2026-02-28 06:16:56.697+00	9692e9a0-81b6-4c05-ac58-6c637064eb26	bbb719d5-4626-40d6-aec6-7d53f24e5459
0d15e328-1f6a-4c06-ac15-9166e70c2efc	\N	be33c5f3-ee15-4555-9f5f-209b30f33076	RELATION	leads	leads	\N	Properties Lead	IconUsers	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	4bf15d7b-5629-42ca-bcd0-7c1bf2a0d833	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:16:56.697+00	2026-02-28 06:16:56.697+00	80897984-6adf-44eb-a334-7a03e9c9318c	bbb719d5-4626-40d6-aec6-7d53f24e5459
30fbbac7-01f7-4c6c-94a6-c60e3d9b0f19	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	assignee	Assignee	\N	Leads tied to the Workspace Member	IconRelationOneToMany	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "assigneeId"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	d193ff89-951b-4d68-9cda-7ce603a095eb	285bf1ca-e489-4b4e-a29c-30127e960da7	\N	2026-02-28 06:17:17.583+00	2026-02-28 06:17:17.583+00	bba9df5f-18ef-45ce-ab5d-77fe8d746548	bbb719d5-4626-40d6-aec6-7d53f24e5459
d193ff89-951b-4d68-9cda-7ce603a095eb	\N	285bf1ca-e489-4b4e-a29c-30127e960da7	RELATION	leads	leads	\N	WorkspaceMembers Lead	IconUsers	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	30fbbac7-01f7-4c6c-94a6-c60e3d9b0f19	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 06:17:17.583+00	2026-02-28 06:17:17.583+00	9ba86504-996e-453e-9d97-e8858b09aa5b	bbb719d5-4626-40d6-aec6-7d53f24e5459
c0618af3-c06b-4a1e-86d5-24fa8475d288	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	DATE_TIME	dueDate	Due date	\N	\N	IconCalendarClock	\N	\N	{"displayFormat": "USER_SETTINGS"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 06:21:37.538+00	2026-02-28 06:21:37.538+00	f611e827-224d-4c8b-9f2d-22f07925540d	bbb719d5-4626-40d6-aec6-7d53f24e5459
ea01eef1-64ef-4141-9c13-43abf2f4e1f2	20202020-eda0-4cee-9577-3eb357e3c22b	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	UUID	id	Id	"uuid"	Id	Icon123	\N	\N	\N	f	t	t	t	f	t	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	ea01eef1-64ef-4141-9c13-43abf2f4e1f2	bbb719d5-4626-40d6-aec6-7d53f24e5459
dbd2a7f1-8a29-46a6-93f5-79512d201f4a	20202020-ba07-4ffd-ba63-009491f5749c	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	TEXT	name	Name	\N	Name	IconAbc	\N	\N	\N	f	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	dbd2a7f1-8a29-46a6-93f5-79512d201f4a	bbb719d5-4626-40d6-aec6-7d53f24e5459
0325d646-7e2c-47b7-9457-9b1daba695d7	20202020-66ac-4502-9975-e4d959c50311	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	DATE_TIME	createdAt	Creation date	"now"	Creation date	IconCalendar	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	0325d646-7e2c-47b7-9457-9b1daba695d7	bbb719d5-4626-40d6-aec6-7d53f24e5459
8a2441b1-6d99-4b16-999d-87a0508a82be	20202020-d767-4622-bdcf-d8a084834d86	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	DATE_TIME	updatedAt	Last update	"now"	Last time the record was changed	IconCalendarClock	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	8a2441b1-6d99-4b16-999d-87a0508a82be	bbb719d5-4626-40d6-aec6-7d53f24e5459
66972d5b-9044-4dc5-a909-daf2b2cb2965	d047ccb4-9469-4514-a982-29c4ae49317d	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	ACTOR	updatedBy	Updated by	{"name": "''", "source": "'MANUAL'"}	The workspace member who last updated the record	IconUserCircle	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	66972d5b-9044-4dc5-a909-daf2b2cb2965	bbb719d5-4626-40d6-aec6-7d53f24e5459
e6d06afd-b181-4ffc-ab11-583d0a0efb69	20202020-b9a7-48d8-8387-b9a3090a50ec	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	DATE_TIME	deletedAt	Deleted at	\N	Deletion date	IconCalendarClock	\N	\N	\N	f	t	f	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	e6d06afd-b181-4ffc-ab11-583d0a0efb69	bbb719d5-4626-40d6-aec6-7d53f24e5459
f0212328-7cec-4a56-aa21-ca6849970ae0	20202020-be0e-4971-865b-32ca87cbb315	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	ACTOR	createdBy	Created by	{"name": "''", "source": "'MANUAL'"}	The creator of the record	IconCreativeCommonsSa	\N	\N	\N	f	t	f	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	f0212328-7cec-4a56-aa21-ca6849970ae0	bbb719d5-4626-40d6-aec6-7d53f24e5459
907afb89-5a3a-40b6-b76d-94f715ba0dec	20202020-c2bd-4e16-bb9a-c8b0411bf49d	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	POSITION	position	Position	0	Position	IconHierarchy2	\N	\N	\N	f	t	t	t	f	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	907afb89-5a3a-40b6-b76d-94f715ba0dec	bbb719d5-4626-40d6-aec6-7d53f24e5459
59839cd2-8657-4498-85b7-47905db69243	70e56537-18ef-4811-b1c7-0a444006b815	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	TS_VECTOR	searchVector	Search vector	\N	Search vector	IconSearch	\N	\N	{"asExpression": "to_tsvector('simple', COALESCE(public.unaccent_immutable(\\"name\\"), ''))", "generatedType": "STORED"}	f	t	t	t	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 06:54:36.853+00	2026-02-28 06:54:36.853+00	59839cd2-8657-4498-85b7-47905db69243	bbb719d5-4626-40d6-aec6-7d53f24e5459
baebbf93-4992-480c-bc1c-4b9f78b34791	20202020-f1ef-4ba4-8f33-1a4577afa477	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	timelineActivities	Timeline Activities	\N	Customers tied to the Timeline Activity	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	9f485151-6110-4d31-9dd8-e85ae3832185	16136df1-455c-4a8b-8bb6-e98e1d03b033	\N	2026-02-28 06:54:36.858+00	2026-02-28 06:54:36.858+00	907ef8d9-b1d4-4841-9e71-0a4a597e85a9	bbb719d5-4626-40d6-aec6-7d53f24e5459
b04547af-637e-4903-9e10-0e6725752456	20202020-a4a7-4686-b296-1c6c3482ee21	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	favorites	Favorites	\N	Customers tied to the Favorite	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	e6060399-600f-44d2-b024-06a6aff40073	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	8dd45a5c-3a03-45a0-83b5-1662a72fb5dd	bbb719d5-4626-40d6-aec6-7d53f24e5459
d74b57a2-7ba7-43ff-a101-4068fe589bef	20202020-8d59-46ca-b7b2-73d167712134	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	attachments	Attachments	\N	Customers tied to the Attachment	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0082fa9e-4370-4a9b-8c38-e19a4fe35a8d	b1aae13e-f912-419c-a5b9-8493b54a38cb	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	c5c3d07f-8585-4fb1-b43f-d988069d3011	bbb719d5-4626-40d6-aec6-7d53f24e5459
0a341445-c5c2-4b2a-a0ff-f70d33280c24	20202020-01fd-4f37-99dc-9427a444018a	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	noteTargets	Note Targets	\N	Customers tied to the Note Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	51962bfd-b490-421d-aec8-c72c30cffbd4	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	e4fe2487-1f9c-43c4-8961-f64dfa3c3b26	bbb719d5-4626-40d6-aec6-7d53f24e5459
837d252f-8b22-4183-965f-e3be0f0877c4	20202020-0860-4566-b865-bff3c626c303	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	taskTargets	Task Targets	\N	Customers tied to the Task Target	IconBuildingSkyscraper	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	db85bc2c-5899-455a-9d82-bd4d07a9bfff	77864c8b-b2cf-43bd-8fab-3e77052c50b7	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	76cb1bea-bd34-4df3-a2f9-01137852d027	bbb719d5-4626-40d6-aec6-7d53f24e5459
9f485151-6110-4d31-9dd8-e85ae3832185	\N	16136df1-455c-4a8b-8bb6-e98e1d03b033	MORPH_RELATION	targetCustomer	Customer	\N	TimelineActivities Customer	IconTimelineEvent	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "targetCustomerId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	baebbf93-4992-480c-bc1c-4b9f78b34791	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	20202020-9a2b-4c3d-a4e5-f6a7b8c9d0e1	2026-02-28 06:54:36.858+00	2026-02-28 06:54:36.858+00	12d66a26-7c12-476f-b853-914ad8c68eca	bbb719d5-4626-40d6-aec6-7d53f24e5459
e6060399-600f-44d2-b024-06a6aff40073	\N	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	RELATION	customer	Customer	\N	Favorites Customer	IconHeart	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "customerId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	b04547af-637e-4903-9e10-0e6725752456	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	fe4a56f5-856a-4446-bf6a-f816633863dd	bbb719d5-4626-40d6-aec6-7d53f24e5459
0082fa9e-4370-4a9b-8c38-e19a4fe35a8d	\N	b1aae13e-f912-419c-a5b9-8493b54a38cb	RELATION	customer	Customer	\N	Attachments Customer	IconFileImport	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "customerId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	d74b57a2-7ba7-43ff-a101-4068fe589bef	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	b5057966-730c-4f2f-9c7c-0dfdcb74d496	bbb719d5-4626-40d6-aec6-7d53f24e5459
51962bfd-b490-421d-aec8-c72c30cffbd4	\N	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	RELATION	customer	Customer	\N	NoteTargets Customer	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "customerId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	0a341445-c5c2-4b2a-a0ff-f70d33280c24	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	2026-02-28 06:54:36.863+00	2026-02-28 06:54:36.863+00	a4a3014b-26ed-425a-b312-85e3e8f3efe0	bbb719d5-4626-40d6-aec6-7d53f24e5459
db85bc2c-5899-455a-9d82-bd4d07a9bfff	\N	77864c8b-b2cf-43bd-8fab-3e77052c50b7	RELATION	customer	Customer	\N	TaskTargets Customer	IconCheckbox	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "customerId"}	t	t	t	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	837d252f-8b22-4183-965f-e3be0f0877c4	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	2026-02-28 06:54:36.864+00	2026-02-28 06:54:36.864+00	ff11034a-bc9d-45a8-ad68-9fdea2ce9002	bbb719d5-4626-40d6-aec6-7d53f24e5459
4042f6ba-f103-4553-804f-666b73983602	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RELATION	customer	Customer	\N	Leads tied to the Customer	IconRelationOneToMany	\N	\N	{"onDelete": "SET_NULL", "relationType": "MANY_TO_ONE", "joinColumnName": "customerId"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	c6bc07fa-380d-4bb1-a5a8-c61fb7300683	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	2026-02-28 07:01:57.366+00	2026-02-28 07:01:57.366+00	5679b3fa-f3be-4824-92b0-d946c2bb1e73	bbb719d5-4626-40d6-aec6-7d53f24e5459
c6bc07fa-380d-4bb1-a5a8-c61fb7300683	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	RELATION	leads	leads	\N	Customers Lead	IconUsers	\N	\N	{"relationType": "ONE_TO_MANY"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	4042f6ba-f103-4553-804f-666b73983602	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	2026-02-28 07:01:57.367+00	2026-02-28 07:01:57.367+00	c2be655c-230a-484d-ad7f-41dcc8809739	bbb719d5-4626-40d6-aec6-7d53f24e5459
7fedae9f-b476-4b71-b295-9e9603872484	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	SELECT	status	Status	\N	\N	IconTag	\N	[{"id": "5469c344-c34f-4186-8d63-6c1f18353a88", "color": "gold", "label": "New", "value": "NEW", "position": 0}, {"id": "ab7c7494-e91e-4ef4-8116-ff9dbb1a1506", "color": "blue", "label": "Contacted", "value": "CONTACTED", "position": 1}, {"id": "1a77edf2-81a0-4dee-bb1e-75d0afed097d", "color": "yellow", "label": "Nurture", "value": "NURTURE", "position": 2}, {"id": "8c0a8a44-4306-47b2-b36f-25e9ad758b9d", "color": "grass", "label": "Converted", "value": "CONVERTED", "position": 3}, {"id": "67bda000-092a-4349-b768-ee6445211558", "color": "red", "label": "Declined", "value": "DECLINED", "position": 4}]	\N	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 07:34:23.66+00	2026-02-28 07:34:23.66+00	25d83a6d-3fce-47be-8af7-ec746df05be1	bbb719d5-4626-40d6-aec6-7d53f24e5459
7a73ab40-8501-4059-9391-c0adf9785eef	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	EMAILS	emails	Emails	\N	\N	IconMail	\N	\N	{"maxNumberOfValues": 10}	t	t	f	f	t	t	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 06:55:17.599+00	2026-02-28 08:10:55.42254+00	7ceca36f-c507-4765-acbd-94a2658877c6	bbb719d5-4626-40d6-aec6-7d53f24e5459
7ee83b05-c96b-4a33-a421-d06fe9c7be98	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	PHONES	phones	Phones	{"additionalPhones": null, "primaryPhoneNumber": "''", "primaryPhoneCallingCode": "''", "primaryPhoneCountryCode": "''"}	\N	IconPhone	\N	\N	{"maxNumberOfValues": 10}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 06:56:10.994+00	2026-02-28 08:11:01.908239+00	70301859-1468-4de0-86ae-8986797b31a5	bbb719d5-4626-40d6-aec6-7d53f24e5459
cf3c96f5-7a25-42e0-b270-f8276b6d1660	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	RICH_TEXT_V2	notes	Notes	\N	Lead notes (rich text)	IconAlignJustified	\N	\N	\N	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	f	\N	\N	\N	2026-02-28 09:51:11.587+00	2026-02-28 10:01:45.748296+00	4c94ac57-4b07-4b86-84b2-e4909aa135fc	bbb719d5-4626-40d6-aec6-7d53f24e5459
7b0821aa-6c73-45af-87f7-e86ff95c5c58	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	PHONES	whatsapp	Whatsapp	{"additionalPhones": null, "primaryPhoneNumber": "''", "primaryPhoneCallingCode": "''", "primaryPhoneCountryCode": "''"}	\N	IconPhone	\N	\N	{"maxNumberOfValues": 10}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-01 20:24:00.507+00	2026-03-01 20:24:00.507+00	71404c1d-1550-49be-a750-a1266c9e1056	bbb719d5-4626-40d6-aec6-7d53f24e5459
0b99ff29-ee24-4d79-95a3-ed7b9e6a0b6b	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	TEXT	companyName	Company Name	\N	\N	IconTypography	\N	\N	{"displayedMaxRows": 0}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-01 20:24:28.346+00	2026-03-01 20:24:28.346+00	b9dfa4c3-eb34-4e2f-aed8-cdf2755fab50	bbb719d5-4626-40d6-aec6-7d53f24e5459
b61a817e-99da-453f-bb42-bfa370c4d956	\N	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	TEXT	jobTitle	Job Title	\N	\N	IconTypography	\N	\N	{"displayedMaxRows": 0}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-01 20:24:41.222+00	2026-03-01 20:24:41.222+00	fa3ce40e-c42c-4283-9680-442d885062f2	bbb719d5-4626-40d6-aec6-7d53f24e5459
4b804da9-0e45-4b9e-873a-866dcd6c43bf	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	TEXT	convenientTime	Convenient Time	\N	\N	IconTypography	\N	\N	{"displayedMaxRows": 2}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-02 07:52:10.676+00	2026-03-02 07:52:10.676+00	119d0ff1-cc5c-4f44-8836-f8f56e690b89	bbb719d5-4626-40d6-aec6-7d53f24e5459
618c4c90-f9cd-4f26-b966-a91852aa5ef1	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	TEXT	body	Body	\N	\N	IconTypography	\N	\N	{"displayedMaxRows": 5}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-02-28 07:45:55.431+00	2026-03-02 07:52:30.518897+00	84ab6ad1-f515-436c-9a0f-178138ba6bcc	bbb719d5-4626-40d6-aec6-7d53f24e5459
03e00e87-cf3d-4d9c-9191-4321d49b20ab	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	MULTI_SELECT	buildingType	Building Type	\N	\N	IconTags	\N	[{"id": "a43a4b15-cd2d-485f-82f3-90c671d86a5e", "color": "green", "label": "1 BHK", "value": "OPT1_BHK", "position": 0}, {"id": "8249547b-83e4-4b9e-bcbe-9f023c1377ef", "color": "jade", "label": "2 BHK", "value": "OPT2_BHK", "position": 1}, {"id": "56ba8478-20a7-4a3b-9c72-be4f4f490f76", "color": "mint", "label": "3 BHK", "value": "OPT3_BHK", "position": 2}, {"id": "e922a7c6-b383-41f9-9df1-ca5cc819da22", "color": "turquoise", "label": "4 BHK", "value": "OPT4_BHK", "position": 3}, {"id": "3dce3b5a-0fc6-434d-bb96-cd63b0353c42", "color": "cyan", "label": "Apartment", "value": "APARTMENT", "position": 4}, {"id": "b160ed96-abed-42e3-bde1-b3fc29948c71", "color": "sky", "label": "Villa", "value": "VILLA", "position": 5}]	\N	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-02 08:24:28.14+00	2026-03-02 08:24:40.903859+00	1583c13b-a93d-4b68-9e8d-724010994684	bbb719d5-4626-40d6-aec6-7d53f24e5459
34c4c0fd-5b40-41b3-82aa-45c3b1f06b87	\N	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	DATE_TIME	readAt	readAt	\N	\N	IconCalendarClock	\N	\N	{"displayFormat": "USER_SETTINGS"}	t	t	f	f	t	f	a8cf39ab-a363-48fd-8960-096055b51144	t	\N	\N	\N	2026-03-02 08:25:17.88+00	2026-03-02 08:25:17.88+00	8003acd7-57f8-41d0-bf8c-8baad7e3f9c6	bbb719d5-4626-40d6-aec6-7d53f24e5459
\.


--
-- Data for Name: fieldPermission; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."fieldPermission" (id, "roleId", "objectMetadataId", "fieldMetadataId", "canReadFieldValue", "canUpdateFieldValue", "workspaceId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: file; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.file (id, size, "workspaceId", "createdAt", "applicationId", path, "updatedAt", "deletedAt", "isStaticAsset") FROM stdin;
\.


--
-- Data for Name: frontComponent; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."frontComponent" ("workspaceId", "universalIdentifier", "applicationId", id, name, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: indexFieldMetadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."indexFieldMetadata" (id, "indexMetadataId", "fieldMetadataId", "order", "createdAt", "updatedAt") FROM stdin;
eba11c7b-3c96-43b4-8ec4-d5eb8634232c	e769af18-71db-4d05-964f-f02a17426a10	f735595c-8902-403f-8f00-19d6150f8025	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5962d92b-d3fb-4a1d-84bd-a018d9044fb1	96062248-798f-4cf8-86c3-2f4485b82bca	7545787b-07fd-4542-a56a-89eda6f56638	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
1dd1db15-da77-4593-b21a-387b8cfc6c60	0cbbed26-1aa7-4a79-a902-ee5b2630a7c1	10e3877a-e3bf-449d-8aa0-9d7e71b9a75a	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5ca7ecea-2d10-4d86-aa58-b67ecf69db4d	730f20c2-4742-4208-899e-00f6d44a2b2c	2a9ca173-f438-4bc5-b23a-30a3edb93372	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
1fc6ca7a-6bd3-48a0-a27d-69898ed55758	5a7a3326-075e-48f5-abfb-266515b69c8b	257d19ad-1090-4f33-8c29-bae938934d31	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e81d55d3-65f3-4153-82cc-43b862b153cb	1709cc62-ca66-4cab-893b-60b82f341d86	6a65d64f-1ea1-4ad6-aab0-65a9d301305c	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
f14b8eea-efc0-4c63-a7f2-6dd5bb9c2d4b	ebc1f4f5-2d96-4cb4-898c-c3c6e22dd959	ada2aa94-5a69-4126-9a64-91404e576111	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e9d0f564-7150-4767-88a0-6184ecb8d92c	ca7027a0-c57e-4ec4-94ce-0bd4e809f34e	46b0e181-869a-4546-8fd4-7a4ca4ee2f25	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
145e65d2-0765-4179-802b-ff8521c62964	e430d0df-0e6e-4ded-82d8-5ad0011fe2b7	742c883b-2439-4512-b385-cb0ed2e061c7	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c8410eb3-1cc4-4c37-80b2-436dc59b03c8	34715f25-51d6-4f26-8d36-f1171ed48828	59fc7f56-2882-4d1b-91ec-ccd8be1513f5	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
fdcd8c07-26d5-46f8-b68f-c68eca4342ba	59ecd22e-c81d-4d40-900c-6ce4b1e037d1	3b2d1005-7c1d-4c01-a7ea-d3203c779268	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
cbeceefc-f04a-44bb-936c-7b24b1f79448	08290f11-78b5-4797-adc3-4bca069ec8bb	7ab83ae2-459e-4933-82f3-27015a9be304	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
70b9e553-856f-423b-9efa-1a4bb0112bc1	a7c1ac25-4ae9-483b-9a8b-979e05f4e6d1	069959f4-99ea-433d-a0ab-db690b92875e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
71d7e460-b266-42e8-a5ed-35a664047cc4	b9b5c9e9-e55b-44aa-85dc-3666e4fa4250	e6b72d67-67c3-4549-8159-7b69af043a3e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c697761b-6c09-458e-8c6d-a523e2068f21	b443f4be-1f0c-49dd-95a7-b38e8ddab2b7	b20c80a8-b163-4946-89bf-fccc4c8248a7	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5853aa04-d43f-4a9c-aa80-50022cb56149	425ab42a-c68d-47a1-b338-2440957b0416	f2496f3a-f39f-49f8-9eab-f967d6576e40	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
6da2060c-6001-4f6a-8268-d4b7cd3be8bb	8bcc8662-54df-46a8-8f67-b2bcfa3db7ef	e88ed9cb-f344-418e-a14b-e850768768dc	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
f3e9b30e-bb20-41ec-8d86-74948cdf9c0f	007fc007-727f-483b-b7cd-09f727de235e	5a5c299e-7726-4c47-9dab-bf13eef39195	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
0f4502cb-c916-4380-ba0c-11dcb640542f	31f2b3df-820a-4ce4-8eb9-22328e14dd6e	3c6f2b61-43ad-4bd1-a21a-1a3b4f6e8597	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
34f88223-117c-4d8f-a5d5-494d345b2497	d067c191-25d9-41e3-b298-2972447c348f	cfd497ce-69b3-4c17-9b43-58a6a968ed0e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
a8978b6b-f365-4b7c-b91b-943e11399aa9	fc70e517-91b6-43f4-af7b-1aa6a3f46ced	a420621f-912b-4d2b-839f-c36e9879bb11	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
0ead2652-c7d6-4589-9f05-337d7d19acdc	0759a328-1f3f-4924-8235-0155d2bd6dae	3a79bb40-10bc-4598-a80b-e6112c1a845e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
d24711f3-c25d-4c1c-8d56-3f945d3a0f1b	f9b9ef9e-5d41-43b6-8e06-f660ddc210c7	78c0bd1a-1799-4c99-b51c-5786faa10f5d	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
fd76e7ca-6580-4ab0-bd58-be70d1c54f71	4fe9a906-fd3c-49a0-adb6-aad946a70518	2b770b3c-651e-478e-ac73-b47720bfb9d3	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5a1b0e1c-8891-4ebb-9185-9d76dd376f56	e340b7fb-7bb2-4bc3-8b31-c9d964eea454	2f7d9b3c-e8d6-42de-97b6-1606a8e829c0	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
49258cce-bbb1-4fdf-846d-e0e7fc8c8acb	86db45a8-5ede-4e74-90fb-f4e10fbc6cea	bc86ad93-0b90-4023-9930-ab5088f492f1	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
3937b089-b5a1-4865-b7ef-896b7b5b7760	937090fe-ee09-4870-a2eb-d2b5c2a287aa	c3387e21-0126-4671-a766-93cd0f305598	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
2b2fa91b-0d06-4ac9-a1ca-2c85681376ef	2847fd7d-42c6-4750-b1cd-b6b00a54c746	d7e08160-79be-4034-8be6-230bcd571fe6	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
ebdd2f1a-79ec-4844-aeca-2e9b93ae21d4	0d9a7cf5-e130-4c8b-9f81-92641d8900d7	8c176228-a931-47f9-9ef8-81d3a4f80b73	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
f0216f76-a02d-4fcb-a478-3de2441c22ea	597277a6-10e3-40a5-9f6f-912a911b6478	be437f66-87de-4535-8fca-6c9dc8dd4b84	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
362efb53-97ce-4af2-9592-831f20b0417f	d9e815ce-483e-46ca-b867-db6e8f6534b8	758b4564-d24c-4466-bb28-f2b8ab1a3b05	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5d608f5c-35e9-45f6-9669-74dd632662f8	a117de92-a43b-454a-ab0c-0deb765daa17	27405b57-dc97-4ab9-badb-ffa407d82493	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e4a22bf0-9e24-42e4-986b-482c40f8e6f8	494fedec-f073-429a-9c18-6794c0aad21d	f6eb29c6-1500-490d-9420-11a5724165fe	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
dff9c692-c9f8-4910-954c-db60fe047735	593ff3a2-13eb-4a07-9986-991a84d88ea0	7793de19-ff23-4b03-9bba-ced63f35ce96	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
59416dea-4e51-422a-b508-074e403faad1	76d28953-292b-431e-a523-757d3f3306fb	f6eb29c6-1500-490d-9420-11a5724165fe	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
44fbca7f-5049-42ac-8c00-7473dc5744b8	76d28953-292b-431e-a523-757d3f3306fb	7793de19-ff23-4b03-9bba-ced63f35ce96	1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e50eef82-4005-4309-819a-319ce9b597b2	26f77524-d7d0-449c-8423-5151c8b53c6d	aa3639b0-5d49-423c-a99d-759f49cd2516	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
6ea4c0f4-b4fe-4435-91f6-5b43ada979ae	4381a1f8-ab1d-48ad-b47c-eb74a156704f	ea71a7bf-ed43-44bf-8e35-5cb151a14fb2	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
14e23825-b3fc-4cd0-b263-20ce28a0c873	c83a4c75-d31c-4042-9a16-aff1a07f8005	9db0d8eb-e1f7-475e-9f02-c6b2a8e008f0	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
40767e07-9ba5-480a-b0a1-183801ea2b30	e2c8211c-d894-43ee-ac7f-a0c40cf4391a	b8de3e96-8287-428c-8863-24b7b6e67a8f	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c16d5cea-1022-4eaf-a9f7-866e70c0dae3	35142719-6ac0-4f43-a8f8-eeaf85fca5d6	0366a133-4c14-4b6b-902d-015357fb4fb5	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
fa1aacbb-e070-45eb-bfe5-e31d706a294c	ff93135b-b753-4f2f-9f7c-f95607b4302a	76b10284-6ec9-43b9-8a3d-161bcda99cee	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
5da773ee-1bdf-410c-bd34-2c80e24c500c	13aecbb2-f09d-4d51-aa98-bd048dae836b	89c515e2-6d66-4934-8718-f2aaf5956667	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
87ff34e1-1286-4b38-8099-aec0c399e354	b84c9aa6-c364-4558-af95-61278915aabc	0b8666f5-b6c6-415f-aa21-ecc10c0dd0d2	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
9970867a-cf0c-45b0-8d3b-6cb1917008f4	6726d29a-2c78-4758-a997-3a4f5a68d826	ef70664d-0792-47db-9672-bac7e18bf010	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
4d1104cb-a008-4ccd-ab0a-af149fa67ce9	69e78482-34b8-4f5e-a959-1b7196aa4ede	7908ad88-69e7-440d-b824-b718cc469677	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
6a0a76c7-6986-47b4-87d2-36770c147c90	cf266d8e-6ca5-4cb9-922d-b49fe495ae28	5642d645-5dad-42d2-a255-14b88b8b0bb3	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
81b51de9-b7c5-4d79-9922-1f0d3e17b88d	5c481772-d6f0-4670-ae06-2ad3743bb137	df2411c7-21a9-414e-a3f7-cd9466bbbb5b	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
31afa321-f8db-4207-965d-5b340d325e04	c7c0e300-4055-479d-9249-f17bbdcce191	9f0549ef-28da-44e5-b311-186cb3ebdbb4	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
346db25a-cdd0-4579-ad76-1e0a8fd32942	52e04f81-6f0d-48fd-b723-58a6bdbf089f	2aa99259-fefd-4c96-8660-029d7eaf7050	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
2bf83bc9-4075-4c19-b943-3cb294f41f71	b6e6ca17-aa4e-4053-adf8-c3a78d2a0b32	b64330db-9052-46c7-b5f0-b8de5f214aed	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
ef5628eb-95ba-4639-8623-45c79054093f	fc3b4794-c18b-46a3-b7ed-6fd32809a6e7	2b0fdcee-33cd-4079-ad7c-d6a56c9222e0	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
6db1e72f-57c4-435f-81b0-abcfcf9555ef	40610c40-787e-486a-93fa-12eed06f8e99	9d29a26e-ef11-4808-96ac-6ac7b9705ece	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
28c62fba-e47e-4f85-adb3-324b5627d1c6	22f90783-4279-413a-8583-25ccb965ba1f	0c75bb8d-53dc-4fee-99c1-d6a059818400	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e3826997-8515-42db-a90a-de01dc24980a	f1ef3019-558f-46ee-bb47-772c62c0d06c	e1930bc6-edc1-495c-8618-e9cd3eea7815	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
2df5d593-5e52-4a0f-8a5f-6faf30ce9882	e2984b4e-e7a3-48c3-b78d-841a76ac28c1	a1e54687-b9d2-4717-adcb-a3a858e8004c	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
2ce14dfd-3041-4945-88df-e6e0f930087f	b1b236fa-f23a-40d9-8293-ff8874387745	d4cf4089-b705-471c-978a-0911724cf4dc	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
e575c317-6964-4242-a3b2-a09a59711f81	39b71386-76ea-44d1-989c-6429982446ba	644979e1-eff3-4247-bfa4-1554b1fa9381	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c3c1ec99-7831-4f5c-9ed7-ff031b3b178b	bcc86a15-d499-466a-a3ee-cffbe50686e8	d85cb182-4f51-4ab2-87b8-54ad24285098	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
1a12f89f-668b-4c6a-90f8-b96c7ee9d36a	597e264b-e362-485f-93ec-b590c18b8847	7d013749-da84-4768-a40c-2d6d97048b36	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
8b63409c-eaca-42d4-9668-5deb05c769c9	f4d4fa5a-3e64-4844-83b7-f837a1d42711	9ed9edd8-0de4-4782-923b-4189878c916b	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
8801321b-cc4d-4439-bb14-824f64750fe0	7b623242-ebdc-4f20-b909-930883b69d68	594d1d3a-b146-41e5-a95d-bb6081de32c1	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
4efde378-e77c-4619-9620-608b9becc671	fd127dcf-9e23-405a-951a-2a002b699edf	b0f66363-9837-4281-a846-d20ba8905020	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
d0341fbb-71c6-43fd-bdde-91579b518ba0	5f21cd10-98e8-417b-8eea-3fa6e0ef7126	d1e65c1b-0d1c-4da6-a454-d620d508f725	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
8b5cb49d-d4a5-4a8b-b588-49b23dd7e260	a04d5b71-134b-41cf-a81b-de7da82c3b15	35a25a0a-e3ad-4a62-b8fa-3eec59095c0e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
654b0aa4-1480-40ec-8a64-f90237d4747d	40426834-7088-41fa-8209-33dfa9dd0076	8866f1ab-080a-4f3b-bd69-6bf3943dd25e	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
6dfd980d-89a5-4814-bd96-8252a98f7548	752b566b-11c8-4920-9381-f242654fde03	8298d97d-be98-407b-b656-8047a061c2a3	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
ff77b534-2052-4a8e-ac87-7189215126fb	e3174055-42bd-4f48-8669-4287995431ec	28bdcb9a-ea63-4a1a-8671-b51884df6ea9	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c2786579-9825-4fc5-9c53-bd1a0f62bc5e	c0597fbe-f233-41e8-88bf-48f91c723879	6dbf5856-35d4-4571-97ac-c1a89af26f59	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
91d1ea89-a344-476e-9e7f-7d10b6aed549	fe58f79f-58d8-4e18-9833-242d700a2828	a4211d48-22e3-4b86-93b3-d6fa251eb669	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
826b18a9-cdf4-4ccc-bb8e-62c335c9dafa	6986ccf3-3f18-4eee-a3af-06bf39c784e7	7d1a1e8b-b6e2-48c1-84b1-c31c71e03aaa	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
3c43b156-f01a-41f4-bce2-2cf72bda7a02	32b3ed14-bbc3-4712-a5de-aea42d9eb581	a29232bd-cadb-42ba-90e8-b0a18121f675	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
ce7e83f4-805e-48ba-99b1-76146d7405f7	cbcadb89-f1df-44a2-b760-bc00a0fb58be	7a4e37d3-3a1c-4fa7-9a42-aa110acf7ee9	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
d7e0953a-b599-4eed-a4e3-2760d82f570d	1929cca7-33d5-4c04-a9da-07d2592ad5b2	961bf741-22a8-480e-92fa-20920451dc70	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
c3c63dee-20df-44a8-a35d-95a7956de8c9	5f8566e4-6d5c-4173-b47d-9c55db0054db	f2a363b8-e78b-402f-ac5f-fba91a4c7139	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
b07f061d-59b6-4ad9-9e8b-99db46c205be	456c4185-f61a-409e-a0d7-bb8bbde0781c	918e92e5-8949-4f89-936c-6ce9b9681078	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
a04da6e9-542d-41a9-a1a7-b1c87a7ae053	8e9112a2-5801-4158-a373-e1acc22a67c1	096dc767-fc6f-4d86-a1b3-81a7c4911cf9	0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
f2ae53f9-68f0-4007-995d-0ec2b063eee5	4ebabd90-7853-423a-84f3-41a3619d711e	e14176e8-734a-406e-9da0-332b5c074e23	0	2026-02-28 05:19:34.495+00	2026-02-28 05:19:34.495+00
a7dc4b8c-36bc-4e9d-b47d-ba9a7ca47d92	ad308385-8180-479b-b1bb-56814427a4d8	0a9e5328-f462-48f6-9842-e54040239c76	0	2026-02-28 05:53:09.686+00	2026-02-28 05:53:09.686+00
fd51f76f-130b-4bfe-acfa-400b37610344	6b1689d7-b365-4231-a5ad-2db92e239aef	47629a92-4307-460a-a256-503950184789	0	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00
9cb72c17-10c9-4daf-9bf8-481eac484811	32e661a1-2249-41c8-bee5-bd0838a7f13f	b57d57cb-65e6-4b2d-aea8-bc10d22b66d4	0	2026-02-28 06:15:29.18+00	2026-02-28 06:15:29.18+00
954635af-1188-46b5-8a97-b6acdec5032e	71d4d2f7-eaa4-4856-bdd2-e526bd3d964c	4bf15d7b-5629-42ca-bcd0-7c1bf2a0d833	0	2026-02-28 06:16:56.697+00	2026-02-28 06:16:56.697+00
d719a0e8-66a4-4890-a2e2-fdd8324b3038	f3cb8680-0c2e-40a2-ac5d-2a92f8999452	30fbbac7-01f7-4c6c-94a6-c60e3d9b0f19	0	2026-02-28 06:17:17.583+00	2026-02-28 06:17:17.583+00
0be218a9-f226-474f-854b-a33e53b4b0e6	acea0739-68aa-47c6-b2c0-d08e8669e014	59839cd2-8657-4498-85b7-47905db69243	0	2026-02-28 06:54:36.864+00	2026-02-28 06:54:36.864+00
7158514b-e830-4357-a057-69d794d54802	a0e5352f-8d51-4543-bd95-05490c72953b	4042f6ba-f103-4553-804f-666b73983602	0	2026-02-28 07:01:57.368+00	2026-02-28 07:01:57.368+00
7fb81fb5-20c4-4f20-9c03-549bc7c03cfa	6b70b1b7-f785-4a95-952d-1ae403c68900	7a73ab40-8501-4059-9391-c0adf9785eef	0	2026-02-28 06:55:17.6+00	2026-02-28 06:55:17.6+00
\.


--
-- Data for Name: indexMetadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."indexMetadata" (id, "createdAt", "updatedAt", name, "workspaceId", "objectMetadataId", "isCustom", "isUnique", "indexWhereClause", "indexType", "universalIdentifier", "applicationId") FROM stdin;
e769af18-71db-4d05-964f-f02a17426a10	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_0e8eed53c694ed1404526d9f23a	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	b8d4f9a3-0c25-4e7b-9f6a-2d3e4c5b6f70	67affcc3-762a-4fee-baa4-2a048ddd621e
96062248-798f-4cf8-86c3-2f4485b82bca	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_2ae248a51e6d7fb29b65b47a633	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	c9e5a0b4-1d36-4f8c-0a7b-3e4f5d6c7a81	67affcc3-762a-4fee-baa4-2a048ddd621e
0cbbed26-1aa7-4a79-a902-ee5b2630a7c1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_5d1a679dc009176fa89db7976ee	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	d0f6b1c5-2e47-4a9d-1b8c-4f5a6e7d8b92	67affcc3-762a-4fee-baa4-2a048ddd621e
730f20c2-4742-4208-899e-00f6d44a2b2c	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_478dcebf8f1e7b807ddd137a9ca	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	e1a7c2d6-3f58-4b0e-2c9d-5a6b7f8e9c03	67affcc3-762a-4fee-baa4-2a048ddd621e
5a7a3326-075e-48f5-abfb-266515b69c8b	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_27e76883626e898b6f872153917	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	f2b8d3e7-4a69-4c1f-3d0e-6b7c8a9f0d14	67affcc3-762a-4fee-baa4-2a048ddd621e
1709cc62-ca66-4cab-893b-60b82f341d86	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_464ad6e30f0a65e9adf06aeefdf	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	03c9e4f8-5b70-4d2a-4e1f-7c8d9b0a1e25	67affcc3-762a-4fee-baa4-2a048ddd621e
ebc1f4f5-2d96-4cb4-898c-c3c6e22dd959	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_59b2ccfa622e6d924ab0cd9db55	a8cf39ab-a363-48fd-8960-096055b51144	b1aae13e-f912-419c-a5b9-8493b54a38cb	f	f	\N	BTREE	14d0f5a9-6c81-4e3b-5f2a-8d9e0c1b2f36	67affcc3-762a-4fee-baa4-2a048ddd621e
ca7027a0-c57e-4ec4-94ce-0bd4e809f34e	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9e247b4ab168100e4aa8fb6a853	a8cf39ab-a363-48fd-8960-096055b51144	b438fbab-6bac-43b0-8550-1e70fb608333	f	f	\N	BTREE	25e1a6b0-7d92-4f4c-6a3b-9e0f1d2c3a47	67affcc3-762a-4fee-baa4-2a048ddd621e
e430d0df-0e6e-4ded-82d8-5ad0011fe2b7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_968d4fd721a78b75c13a1b9ec12	a8cf39ab-a363-48fd-8960-096055b51144	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	f	f	\N	BTREE	36f2b7c1-8e03-4a5d-7b4c-0f1a2e3d4b58	67affcc3-762a-4fee-baa4-2a048ddd621e
34715f25-51d6-4f26-8d36-f1171ed48828	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_733381453fca683f36c05af5478	a8cf39ab-a363-48fd-8960-096055b51144	8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	f	f	\N	BTREE	47a3c8d2-9f14-4b6e-8c5d-1a2b3f4e5c69	67affcc3-762a-4fee-baa4-2a048ddd621e
59ecd22e-c81d-4d40-900c-6ce4b1e037d1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_7b40c7f03dd1f998ba765ad0730	a8cf39ab-a363-48fd-8960-096055b51144	d98f6957-0ad9-4461-8551-13b1c541fb90	f	f	\N	BTREE	58b4d9e3-0a25-4c7f-9d6e-2b3c4a5f6d70	67affcc3-762a-4fee-baa4-2a048ddd621e
08290f11-78b5-4797-adc3-4bca069ec8bb	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_40150517e4f1ab6154e426eafce	a8cf39ab-a363-48fd-8960-096055b51144	582910b3-32c9-4959-a72c-ebb309bc29f4	f	f	\N	BTREE	69c5e0f4-1b36-4d8a-0e7f-3c4d5b6a7e81	67affcc3-762a-4fee-baa4-2a048ddd621e
a7c1ac25-4ae9-483b-9a8b-979e05f4e6d1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_ba8418718688702d3113fde2fe1	a8cf39ab-a363-48fd-8960-096055b51144	582910b3-32c9-4959-a72c-ebb309bc29f4	f	f	\N	BTREE	70d6f1a5-2c47-4e9b-1f8a-4d5e6c7b8f92	67affcc3-762a-4fee-baa4-2a048ddd621e
b9b5c9e9-e55b-44aa-85dc-3666e4fa4250	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_70c8cfc3c0c8407789db32ad9cf	a8cf39ab-a363-48fd-8960-096055b51144	582910b3-32c9-4959-a72c-ebb309bc29f4	f	f	\N	BTREE	81e7a2b6-3d58-4f0c-2a9b-5e6f7d8c9003	67affcc3-762a-4fee-baa4-2a048ddd621e
b443f4be-1f0c-49dd-95a7-b38e8ddab2b7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_f719a95179070eac397ba18dc70	a8cf39ab-a363-48fd-8960-096055b51144	d7124df1-9136-4b65-8c71-befa364161f2	f	f	\N	BTREE	92f8b3c7-4e69-4a1d-3b0c-6f7a8e9d0114	67affcc3-762a-4fee-baa4-2a048ddd621e
425ab42a-c68d-47a1-b338-2440957b0416	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_UNIQUE_2a32339058d0b6910b0834ddf81	a8cf39ab-a363-48fd-8960-096055b51144	d7124df1-9136-4b65-8c71-befa364161f2	f	t	\N	BTREE	a3a9c4d8-5f70-4b2e-4c1d-7a8b9f0e1225	67affcc3-762a-4fee-baa4-2a048ddd621e
8bcc8662-54df-46a8-8f67-b2bcfa3db7ef	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_fb1f4905546cfc6d70a971c76f7	a8cf39ab-a363-48fd-8960-096055b51144	d7124df1-9136-4b65-8c71-befa364161f2	f	f	\N	GIN	b4b0d5e9-6a81-4c3f-5d2e-8b9c0a1f2336	67affcc3-762a-4fee-baa4-2a048ddd621e
007fc007-727f-483b-b7cd-09f727de235e	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_3c8bbe54bd34f40dfe2d05ac964	a8cf39ab-a363-48fd-8960-096055b51144	2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	f	f	\N	BTREE	c5c1e6f0-7b92-4d4a-6e3f-9c0d1b2a3447	67affcc3-762a-4fee-baa4-2a048ddd621e
31f2b3df-820a-4ce4-8eb9-22328e14dd6e	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_f3b76c5322b31cba175b2eccec8	a8cf39ab-a363-48fd-8960-096055b51144	a34181a4-c008-4fcb-b55e-3f1bdf07d717	f	f	\N	GIN	d6d2f7a1-8c03-4e5b-7f4a-0d1e2c3b4558	67affcc3-762a-4fee-baa4-2a048ddd621e
d067c191-25d9-41e3-b298-2972447c348f	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_e6a755f59ac856c2af85d0b1857	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	e7e3a8b2-9d14-4f6c-8a5b-1e2f3d4c5669	67affcc3-762a-4fee-baa4-2a048ddd621e
fc70e517-91b6-43f4-af7b-1aa6a3f46ced	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_c6a04c62f1b835de81b87c8d5cb	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	f8f4b9c3-0e25-4a7d-9b6c-2f3a4e5d677a	67affcc3-762a-4fee-baa4-2a048ddd621e
0759a328-1f3f-4924-8235-0155d2bd6dae	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_f54929018ffb0a56df35a15ee1a	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	0905c0d4-1f36-4b8e-0c7d-3a4b5f6e788b	67affcc3-762a-4fee-baa4-2a048ddd621e
f9b9ef9e-5d41-43b6-8e06-f660ddc210c7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_03c5b5ea0ebe0cdd54c16f01cd4	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	1016d1e5-2a47-4c9f-1d8e-4b5c6a7f899c	67affcc3-762a-4fee-baa4-2a048ddd621e
4fe9a906-fd3c-49a0-adb6-aad946a70518	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_2ef95462446ad1fad48894bd459	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	2127e2f6-3b58-4d0a-2e9f-5c6d7b80900d	67affcc3-762a-4fee-baa4-2a048ddd621e
e340b7fb-7bb2-4bc3-8b31-c9d964eea454	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_7b93282d4e9b5a9851d07829996	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	3238f3a7-4c69-4e1b-3f0a-6d7e8c91011e	67affcc3-762a-4fee-baa4-2a048ddd621e
86db45a8-5ede-4e74-90fb-f4e10fbc6cea	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_352fe024686b6bcf5e7e1b65449	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	4349a4b8-5d70-4f2c-4a1b-7e8f9d02122f	67affcc3-762a-4fee-baa4-2a048ddd621e
937090fe-ee09-4870-a2eb-d2b5c2a287aa	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_17f260b2397f21011117688a00c	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	5450b5c9-6e81-4a3d-5b2c-8f90ae132340	67affcc3-762a-4fee-baa4-2a048ddd621e
2847fd7d-42c6-4750-b1cd-b6b00a54c746	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_f08a4bc49e7422db941d7c1be50	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	6561c6d0-7f92-4b4e-6c3d-90a1bf243451	67affcc3-762a-4fee-baa4-2a048ddd621e
0d9a7cf5-e130-4c8b-9f81-92641d8900d7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_36f8b958533baaeabdde3479b31	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	7672d7e1-8003-4c5f-7d4e-01b2c0354562	67affcc3-762a-4fee-baa4-2a048ddd621e
597277a6-10e3-40a5-9f6f-912a911b6478	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_d85e3f572ec0d3c406cc58f79af	a8cf39ab-a363-48fd-8960-096055b51144	62e41cfe-1de5-4e19-8473-c7ac4792b0f8	f	f	\N	BTREE	8783e8f2-9114-4d6a-8e5f-12c3d1465673	67affcc3-762a-4fee-baa4-2a048ddd621e
d9e815ce-483e-46ca-b867-db6e8f6534b8	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_5d002cd3b5be1cb05c0b7b28582	a8cf39ab-a363-48fd-8960-096055b51144	bb71b55e-db18-48fe-ab10-9047b29b2e12	f	f	\N	BTREE	7072b7c1-8003-4a5d-7b4c-01f2a03f4f02	67affcc3-762a-4fee-baa4-2a048ddd621e
a117de92-a43b-454a-ab0c-0deb765daa17	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_bf1967e8710f32f1a65c67fb4b4	a8cf39ab-a363-48fd-8960-096055b51144	8c7b0491-0035-4d6f-b3e1-1171ee08afbc	f	f	\N	BTREE	2b27c2d6-3558-4b0e-2c9d-56a7b58a9ab7	67affcc3-762a-4fee-baa4-2a048ddd621e
494fedec-f073-429a-9c18-6794c0aad21d	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_2e85541b739066142845bdef99a	a8cf39ab-a363-48fd-8960-096055b51144	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	f	f	\N	BTREE	9894f9a3-0225-4e7b-9f6a-23d4e2576784	67affcc3-762a-4fee-baa4-2a048ddd621e
593ff3a2-13eb-4a07-9986-991a84d88ea0	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_3f4c0095cf17b62868bec089fab	a8cf39ab-a363-48fd-8960-096055b51144	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	f	f	\N	BTREE	0905a0b4-1336-4f8c-0a7b-34e5f3687895	67affcc3-762a-4fee-baa4-2a048ddd621e
76d28953-292b-431e-a523-757d3f3306fb	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_da56d8b595a778d404eae01f29b	a8cf39ab-a363-48fd-8960-096055b51144	5ce17e32-6f5a-4be7-828c-d84a35a15e4b	f	f	"deletedAt" IS NULL	BTREE	1a16b1c5-2447-4a9d-1b8c-45f6a47989a6	67affcc3-762a-4fee-baa4-2a048ddd621e
26f77524-d7d0-449c-8423-5151c8b53c6d	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_a1bbe482462d9f016582d99d4e6	a8cf39ab-a363-48fd-8960-096055b51144	1e413633-a549-4d9a-9d79-f18adaa748e0	f	f	\N	BTREE	3c38d3e7-4669-4c1f-3d0e-67b8c69b0bc8	67affcc3-762a-4fee-baa4-2a048ddd621e
4381a1f8-ab1d-48ad-b47c-eb74a156704f	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_19ad12ae96a5d4357ff3a15ba2b	a8cf39ab-a363-48fd-8960-096055b51144	e386c71a-338d-4a79-ae0e-792bc13d7c22	f	f	\N	BTREE	4d49e4f8-5770-4d2a-4e1f-78c9d70c1cd9	67affcc3-762a-4fee-baa4-2a048ddd621e
c83a4c75-d31c-4042-9a16-aff1a07f8005	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_47a5ea9e149973d6ef980bdc4f1	a8cf39ab-a363-48fd-8960-096055b51144	e386c71a-338d-4a79-ae0e-792bc13d7c22	f	f	\N	BTREE	5e50f5a9-6881-4e3b-5f2a-89d0e81d2de0	67affcc3-762a-4fee-baa4-2a048ddd621e
e2c8211c-d894-43ee-ac7f-a0c40cf4391a	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_7a56509bca48a709378017a9135	a8cf39ab-a363-48fd-8960-096055b51144	e386c71a-338d-4a79-ae0e-792bc13d7c22	f	f	\N	BTREE	6f61a6b0-7992-4f4c-6a3b-90e1f92e3ef1	67affcc3-762a-4fee-baa4-2a048ddd621e
35142719-6ac0-4f43-a8f8-eeaf85fca5d6	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_f20de8d7fc74a405e4083051275	a8cf39ab-a363-48fd-8960-096055b51144	415d12c3-c586-4222-9c41-994a99cebf67	f	f	\N	GIN	8183c8d2-9114-4b6e-8c5d-12a3b14a5a13	67affcc3-762a-4fee-baa4-2a048ddd621e
ff93135b-b753-4f2f-9f7c-f95607b4302a	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_7e2582241f3b749d7a43d7d0231	a8cf39ab-a363-48fd-8960-096055b51144	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	f	f	\N	BTREE	9294d9e3-0225-4c7f-9d6e-23b4c25b6b24	67affcc3-762a-4fee-baa4-2a048ddd621e
13aecbb2-f09d-4d51-aa98-bd048dae836b	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_5c3e2cfc25e814aa84b86885105	a8cf39ab-a363-48fd-8960-096055b51144	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	f	f	\N	BTREE	0305e0f4-1336-4d8a-0e7f-34c5d36c7c35	67affcc3-762a-4fee-baa4-2a048ddd621e
b84c9aa6-c364-4558-af95-61278915aabc	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_6805c7ab083ba48f7664d5602a0	a8cf39ab-a363-48fd-8960-096055b51144	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	f	f	\N	BTREE	1416f1a5-2447-4e9b-1f8a-45d6e47d8d46	67affcc3-762a-4fee-baa4-2a048ddd621e
6726d29a-2c78-4758-a997-3a4f5a68d826	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_76e046116d45bcd23167f68d940	a8cf39ab-a363-48fd-8960-096055b51144	c6a21a1b-a7bc-4c5e-88a1-aec070dac319	f	f	\N	BTREE	2527a2b6-3558-4f0c-2a9b-56e7f58e9e57	67affcc3-762a-4fee-baa4-2a048ddd621e
69e78482-34b8-4f5e-a959-1b7196aa4ede	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_c0ac950d77b75527f654b7f6a06	a8cf39ab-a363-48fd-8960-096055b51144	6d830113-2052-4566-a669-df61dd1cd970	f	f	\N	BTREE	3638b3c7-4669-4a1d-3b0c-67f8a69f0f68	67affcc3-762a-4fee-baa4-2a048ddd621e
cf266d8e-6ca5-4cb9-922d-b49fe495ae28	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_4b9feee3298c853326bf6ff8e42	a8cf39ab-a363-48fd-8960-096055b51144	6d830113-2052-4566-a669-df61dd1cd970	f	f	\N	BTREE	4749c4d8-5770-4b2e-4c1d-78a9b70a1a79	67affcc3-762a-4fee-baa4-2a048ddd621e
5c481772-d6f0-4670-ae06-2ad3743bb137	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_ae112c10e060420923011767b14	a8cf39ab-a363-48fd-8960-096055b51144	6d830113-2052-4566-a669-df61dd1cd970	f	f	\N	BTREE	5850d5e9-6881-4c3f-5d2e-89b0c81b2b80	67affcc3-762a-4fee-baa4-2a048ddd621e
c7c0e300-4055-479d-9249-f17bbdcce191	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9f96d65260c4676faac27cb6bf3	a8cf39ab-a363-48fd-8960-096055b51144	6d830113-2052-4566-a669-df61dd1cd970	f	f	\N	GIN	6961e6f0-7992-4d4a-6e3f-90c1d92c3c91	67affcc3-762a-4fee-baa4-2a048ddd621e
52e04f81-6f0d-48fd-b723-58a6bdbf089f	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_ae09ff97967369e0644bacc0fce	a8cf39ab-a363-48fd-8960-096055b51144	41a553bd-c463-40f2-88bc-07967f17a128	f	f	\N	BTREE	7072f7a1-8003-4e5b-7f4a-01d2e03d4d02	67affcc3-762a-4fee-baa4-2a048ddd621e
b6e6ca17-aa4e-4053-adf8-c3a78d2a0b32	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_UNIQUE_87914cd3ce963115f8cb943e2ac	a8cf39ab-a363-48fd-8960-096055b51144	41a553bd-c463-40f2-88bc-07967f17a128	f	t	\N	BTREE	8183a8b2-9114-4f6c-8a5b-12e3f14e5e13	67affcc3-762a-4fee-baa4-2a048ddd621e
fc3b4794-c18b-46a3-b7ed-6fd32809a6e7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_bbd7aec1976fc684a0a5e4816c9	a8cf39ab-a363-48fd-8960-096055b51144	41a553bd-c463-40f2-88bc-07967f17a128	f	f	\N	GIN	9294b9c3-0225-4a7d-9b6c-23f4a25f6f24	67affcc3-762a-4fee-baa4-2a048ddd621e
40610c40-787e-486a-93fa-12eed06f8e99	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_b5b4da613fc4d734f65fb1deb6b	a8cf39ab-a363-48fd-8960-096055b51144	ff60777a-2722-4aa0-ba66-a8e089c7bc94	f	f	\N	BTREE	0305c0d4-1336-4b8e-0c7d-34a5b36a7a35	67affcc3-762a-4fee-baa4-2a048ddd621e
22f90783-4279-413a-8583-25ccb965ba1f	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_d01a000cf26e1225d894dc3d364	a8cf39ab-a363-48fd-8960-096055b51144	ff60777a-2722-4aa0-ba66-a8e089c7bc94	f	f	\N	GIN	1416d1e5-2447-4c9f-1d8e-45b6c47b8b46	67affcc3-762a-4fee-baa4-2a048ddd621e
f1ef3019-558f-46ee-bb47-772c62c0d06c	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_74ad70941560ba6b2a179ad460c	a8cf39ab-a363-48fd-8960-096055b51144	77864c8b-b2cf-43bd-8fab-3e77052c50b7	f	f	\N	BTREE	2527e2f6-3558-4d0a-2e9f-56c7d58c9c57	67affcc3-762a-4fee-baa4-2a048ddd621e
e2984b4e-e7a3-48c3-b78d-841a76ac28c1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_6e1236c5438bb19bc32315856b2	a8cf39ab-a363-48fd-8960-096055b51144	77864c8b-b2cf-43bd-8fab-3e77052c50b7	f	f	\N	BTREE	3638f3a7-4669-4e1b-3f0a-67d8e69d0d68	67affcc3-762a-4fee-baa4-2a048ddd621e
b1b236fa-f23a-40d9-8293-ff8874387745	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9f7a699f2e8b7de91da33245144	a8cf39ab-a363-48fd-8960-096055b51144	77864c8b-b2cf-43bd-8fab-3e77052c50b7	f	f	\N	BTREE	4749a4b8-5770-4f2c-4a1b-78e9f70e1e79	67affcc3-762a-4fee-baa4-2a048ddd621e
39b71386-76ea-44d1-989c-6429982446ba	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_d6a852b3d9c7430cd4a9ebcdb37	a8cf39ab-a363-48fd-8960-096055b51144	77864c8b-b2cf-43bd-8fab-3e77052c50b7	f	f	\N	BTREE	5850b5c9-6881-4a3d-5b2c-89f0a81f2f80	67affcc3-762a-4fee-baa4-2a048ddd621e
bcc86a15-d499-466a-a3ee-cffbe50686e8	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_dc68847d0ff0b17baef8fb632c2	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	6961c6d0-7992-4b4e-6c3d-90a1b92a3a91	67affcc3-762a-4fee-baa4-2a048ddd621e
597e264b-e362-485f-93ec-b590c18b8847	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_e49dd7da4ed5c919babcd31c93b	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	7072d7e1-8003-4c5f-7d4e-01b2c03b4b02	67affcc3-762a-4fee-baa4-2a048ddd621e
f4d4fa5a-3e64-4844-83b7-f837a1d42711	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9b267fc4a89dd1aaec4c5340f05	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	8183e8f2-9114-4d6a-8e5f-12c3d14c5c13	67affcc3-762a-4fee-baa4-2a048ddd621e
7b623242-ebdc-4f20-b909-930883b69d68	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_62d09af534224aa478109b2d585	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	9294f9a3-0225-4e7b-9f6a-23d4e25d6d24	67affcc3-762a-4fee-baa4-2a048ddd621e
fd127dcf-9e23-405a-951a-2a002b699edf	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_26a021921ba73b428be8f244ded	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	0305a0b4-1336-4f8c-0a7b-34e5f36e7e35	67affcc3-762a-4fee-baa4-2a048ddd621e
5f21cd10-98e8-417b-8eea-3fa6e0ef7126	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_1ff229b8237e8368a92c08d11f0	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	1416b1c5-2447-4a9d-1b8c-45f6a47f8f46	67affcc3-762a-4fee-baa4-2a048ddd621e
a04d5b71-134b-41cf-a81b-de7da82c3b15	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9a2065c2b56ffe8b74d1a12705f	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	2527c2d6-3558-4b0e-2c9d-56a7b58a9a57	67affcc3-762a-4fee-baa4-2a048ddd621e
40426834-7088-41fa-8209-33dfa9dd0076	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_953cb9c73db904f98697f4867b2	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	3638d3e7-4669-4c1f-3d0e-67b8c69b0b68	67affcc3-762a-4fee-baa4-2a048ddd621e
752b566b-11c8-4920-9381-f242654fde03	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_58b130a455b1451066c84dc63e2	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	4749e4f8-5770-4d2a-4e1f-78c9d70c1c79	67affcc3-762a-4fee-baa4-2a048ddd621e
e3174055-42bd-4f48-8669-4287995431ec	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_6b2a27852dd0e0846577662a33a	a8cf39ab-a363-48fd-8960-096055b51144	16136df1-455c-4a8b-8bb6-e98e1d03b033	f	f	\N	BTREE	5850f5a9-6881-4e3b-5f2a-89d0e81d2d80	67affcc3-762a-4fee-baa4-2a048ddd621e
c0597fbe-f233-41e8-88bf-48f91c723879	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_d09fc4b1711543f42c127270f1e	a8cf39ab-a363-48fd-8960-096055b51144	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	f	f	\N	GIN	6961a6b0-7992-4f4c-6a3b-90e1f92e3e91	67affcc3-762a-4fee-baa4-2a048ddd621e
fe58f79f-58d8-4e18-9833-242d700a2828	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_397bfb7946782933c476b98d925	a8cf39ab-a363-48fd-8960-096055b51144	fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	f	f	\N	BTREE	7072b7c1-8003-4a5d-7b4c-01f2a03f4f03	67affcc3-762a-4fee-baa4-2a048ddd621e
6986ccf3-3f18-4eee-a3af-06bf39c784e7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_9fdeb410f15f569f2843698c5b3	a8cf39ab-a363-48fd-8960-096055b51144	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	f	f	\N	BTREE	8183c8d2-9114-4b6e-8c5d-12a3b14a5a14	67affcc3-762a-4fee-baa4-2a048ddd621e
32b3ed14-bbc3-4712-a5de-aea42d9eb581	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_eced9eb2a6cc8f9a5b49fe4b04e	a8cf39ab-a363-48fd-8960-096055b51144	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	f	f	\N	BTREE	9294d9e3-0225-4c7f-9d6e-23b4c25b6b25	67affcc3-762a-4fee-baa4-2a048ddd621e
cbcadb89-f1df-44a2-b760-bc00a0fb58be	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_261d8661b94dbb98cc85cffab46	a8cf39ab-a363-48fd-8960-096055b51144	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	f	f	\N	GIN	0305e0f4-1336-4d8a-0e7f-34c5d36c7c36	67affcc3-762a-4fee-baa4-2a048ddd621e
1929cca7-33d5-4c04-a9da-07d2592ad5b2	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_6dbfc4d091e55b676e5f698c2c2	a8cf39ab-a363-48fd-8960-096055b51144	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	f	f	\N	BTREE	1416f1a5-2447-4e9b-1f8a-45d6e47d8d47	67affcc3-762a-4fee-baa4-2a048ddd621e
5f8566e4-6d5c-4173-b47d-9c55db0054db	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_51329bbcdab6618a75361670c26	a8cf39ab-a363-48fd-8960-096055b51144	1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	f	f	\N	GIN	2527a2b6-3558-4f0c-2a9b-56e7f58e9e58	67affcc3-762a-4fee-baa4-2a048ddd621e
456c4185-f61a-409e-a0d7-bb8bbde0781c	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_UNIQUE_39954942ffa78c957b5dee47739	a8cf39ab-a363-48fd-8960-096055b51144	285bf1ca-e489-4b4e-a29c-30127e960da7	f	t	\N	BTREE	3638b3c7-4669-4a1d-3b0c-67f8a69f0f69	67affcc3-762a-4fee-baa4-2a048ddd621e
8e9112a2-5801-4158-a373-e1acc22a67c1	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	IDX_e47451872f70c8f187a6b460ac7	a8cf39ab-a363-48fd-8960-096055b51144	285bf1ca-e489-4b4e-a29c-30127e960da7	f	f	\N	GIN	4749c4d8-5770-4b2e-4c1d-78a9b70a1a7a	67affcc3-762a-4fee-baa4-2a048ddd621e
4ebabd90-7853-423a-84f3-41a3619d711e	2026-02-28 05:19:34.495+00	2026-02-28 05:19:34.495+00	IDX_b633ee61a71e5d326da65d791b6	a8cf39ab-a363-48fd-8960-096055b51144	be33c5f3-ee15-4555-9f5f-209b30f33076	f	f	\N	GIN	4ebabd90-7853-423a-84f3-41a3619d711e	bbb719d5-4626-40d6-aec6-7d53f24e5459
ad308385-8180-479b-b1bb-56814427a4d8	2026-02-28 05:53:09.686+00	2026-02-28 05:53:09.686+00	IDX_964ef63518b8f73d7d0b294b3f8	a8cf39ab-a363-48fd-8960-096055b51144	430929f9-3e67-479e-8af2-aa6ae925ff82	f	f	\N	GIN	ad308385-8180-479b-b1bb-56814427a4d8	bbb719d5-4626-40d6-aec6-7d53f24e5459
6b1689d7-b365-4231-a5ad-2db92e239aef	2026-02-28 06:14:51.761+00	2026-02-28 06:14:51.761+00	IDX_55ce81c272804f98df7989358fd	a8cf39ab-a363-48fd-8960-096055b51144	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	f	f	\N	GIN	6b1689d7-b365-4231-a5ad-2db92e239aef	bbb719d5-4626-40d6-aec6-7d53f24e5459
32e661a1-2249-41c8-bee5-bd0838a7f13f	2026-02-28 06:15:29.18+00	2026-02-28 06:15:29.18+00	IDX_0b7f9331eb98fa90a6c21e4e582	a8cf39ab-a363-48fd-8960-096055b51144	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	t	f	\N	BTREE	32e661a1-2249-41c8-bee5-bd0838a7f13f	bbb719d5-4626-40d6-aec6-7d53f24e5459
71d4d2f7-eaa4-4856-bdd2-e526bd3d964c	2026-02-28 06:16:56.697+00	2026-02-28 06:16:56.697+00	IDX_05aa997ec9e818519e400ba6428	a8cf39ab-a363-48fd-8960-096055b51144	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	t	f	\N	BTREE	71d4d2f7-eaa4-4856-bdd2-e526bd3d964c	bbb719d5-4626-40d6-aec6-7d53f24e5459
f3cb8680-0c2e-40a2-ac5d-2a92f8999452	2026-02-28 06:17:17.583+00	2026-02-28 06:17:17.583+00	IDX_da8d3b8cffaba31b70b7ead927c	a8cf39ab-a363-48fd-8960-096055b51144	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	t	f	\N	BTREE	f3cb8680-0c2e-40a2-ac5d-2a92f8999452	bbb719d5-4626-40d6-aec6-7d53f24e5459
acea0739-68aa-47c6-b2c0-d08e8669e014	2026-02-28 06:54:36.864+00	2026-02-28 06:54:36.864+00	IDX_b313a3bb044d3031121a81c42da	a8cf39ab-a363-48fd-8960-096055b51144	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	f	f	\N	GIN	acea0739-68aa-47c6-b2c0-d08e8669e014	bbb719d5-4626-40d6-aec6-7d53f24e5459
a0e5352f-8d51-4543-bd95-05490c72953b	2026-02-28 07:01:57.368+00	2026-02-28 07:01:57.368+00	IDX_3c2578d931b79954786d34a66e3	a8cf39ab-a363-48fd-8960-096055b51144	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	t	f	\N	BTREE	a0e5352f-8d51-4543-bd95-05490c72953b	bbb719d5-4626-40d6-aec6-7d53f24e5459
6b70b1b7-f785-4a95-952d-1ae403c68900	2026-02-28 06:55:17.6+00	2026-02-28 06:55:17.6+00	IDX_UNIQUE_eb4d84464c154a790c497570334	a8cf39ab-a363-48fd-8960-096055b51144	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	t	t	\N	BTREE	6b70b1b7-f785-4a95-952d-1ae403c68900	bbb719d5-4626-40d6-aec6-7d53f24e5459
\.


--
-- Data for Name: keyValuePair; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."keyValuePair" (id, "userId", "workspaceId", key, value, "textValueDeprecated", type, "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- Data for Name: navigationMenuItem; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."navigationMenuItem" ("workspaceId", "universalIdentifier", "applicationId", id, "userWorkspaceId", "targetRecordId", "targetObjectMetadataId", "viewId", name, "folderId", "position", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: objectMetadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."objectMetadata" (id, "standardId", "dataSourceId", "nameSingular", "namePlural", "labelSingular", "labelPlural", description, icon, "standardOverrides", "targetTableName", "isCustom", "isRemote", "isActive", "isSystem", "isUIReadOnly", "isAuditLogged", "isSearchable", "duplicateCriteria", shortcut, "labelIdentifierFieldMetadataId", "imageIdentifierFieldMetadataId", "isLabelSyncedWithName", "workspaceId", "createdAt", "updatedAt", "applicationId", "universalIdentifier") FROM stdin;
b1aae13e-f912-419c-a5b9-8493b54a38cb	20202020-bd3d-4c60-8dca-571c71d4447a	fbe4525e-6a79-4ade-894f-1abf14324de8	attachment	attachments	Attachment	Attachments	An attachment	IconFileImport	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	14c4d7a2-3c68-418d-b188-a82bc604719b	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-bd3d-4c60-8dca-571c71d4447a
b438fbab-6bac-43b0-8550-1e70fb608333	20202020-0408-4f38-b8a8-4d5e3e26e24d	fbe4525e-6a79-4ade-894f-1abf14324de8	blocklist	blocklists	Blocklist	Blocklists	Blocklist	IconForbid2	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	370f44ae-54e3-4816-9fc7-8537358b2099	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-0408-4f38-b8a8-4d5e3e26e24d
8cf51c2b-57c6-47ec-a9c1-4c8be497f16a	20202020-491b-4aaa-9825-afd1bae6ae00	fbe4525e-6a79-4ade-894f-1abf14324de8	calendarChannelEventAssociation	calendarChannelEventAssociations	Calendar Channel Event Association	Calendar Channel Event Associations	Calendar Channel Event Associations	IconCalendar	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	47c09ae2-7e1f-4b97-9a1d-1cdb54c1d521	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-491b-4aaa-9825-afd1bae6ae00
d98f6957-0ad9-4461-8551-13b1c541fb90	20202020-e8f2-40e1-a39c-c0e0039c5034	fbe4525e-6a79-4ade-894f-1abf14324de8	calendarChannel	calendarChannels	Calendar Channel	Calendar Channels	Calendar Channels	IconCalendar	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	5f444860-9ce3-41ff-a6ca-92b5475fcc36	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-e8f2-40e1-a39c-c0e0039c5034
582910b3-32c9-4959-a72c-ebb309bc29f4	20202020-a1c3-47a6-9732-27e5b1e8436d	fbe4525e-6a79-4ade-894f-1abf14324de8	calendarEventParticipant	calendarEventParticipants	Calendar event participant	Calendar event participants	Calendar event participants	IconCalendar	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	7789c372-d38f-4b9b-9d27-89c8e52e772e	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-a1c3-47a6-9732-27e5b1e8436d
3964c94e-8e9c-4e92-b9f2-8144df00e793	20202020-8f1d-4eef-9f85-0d1965e27221	fbe4525e-6a79-4ade-894f-1abf14324de8	calendarEvent	calendarEvents	Calendar event	Calendar events	Calendar events	IconCalendar	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	a2c53edd-fe83-4b96-bf20-af609af74aec	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-8f1d-4eef-9f85-0d1965e27221
2fb20ce7-56cd-4cc5-a304-f1bddbba55b1	20202020-977e-46b2-890b-c3002ddfd5c5	fbe4525e-6a79-4ade-894f-1abf14324de8	connectedAccount	connectedAccounts	Connected Account	Connected Accounts	A connected account	IconAt	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	94a1f622-21d9-49f3-ad70-1a73ab196b3c	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-977e-46b2-890b-c3002ddfd5c5
62e41cfe-1de5-4e19-8473-c7ac4792b0f8	20202020-ab56-4e05-92a3-e2414a499860	fbe4525e-6a79-4ade-894f-1abf14324de8	favorite	favorites	Favorite	Favorites	A favorite	IconHeart	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	4eec87a7-64e7-4b42-94a7-e5ccc6ac20c3	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-ab56-4e05-92a3-e2414a499860
e471d18a-b548-4710-a2c2-3783966c373d	20202020-7cf8-401f-8211-a9587d27fd2d	fbe4525e-6a79-4ade-894f-1abf14324de8	favoriteFolder	favoriteFolders	Favorite Folder	Favorite Folders	A favorite folder	IconFolder	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	f3275490-eb65-4545-9143-43896b850a58	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-7cf8-401f-8211-a9587d27fd2d
5ce17e32-6f5a-4be7-828c-d84a35a15e4b	20202020-ad1e-4127-bccb-d83ae04d2ccb	fbe4525e-6a79-4ade-894f-1abf14324de8	messageChannelMessageAssociation	messageChannelMessageAssociations	Message Channel Message Association	Message Channel Message Associations	Message Synced with a Message Channel	IconMessage	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	e392a376-02b9-435f-b1a6-b567de720228	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-ad1e-4127-bccb-d83ae04d2ccb
8c7b0491-0035-4d6f-b3e1-1171ee08afbc	20202020-fe8c-40bc-a681-b80b771449b7	fbe4525e-6a79-4ade-894f-1abf14324de8	messageChannel	messageChannels	Message Channel	Message Channels	Message Channels	IconMessage	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	b457a894-412e-4f9e-a687-58b3fec434fc	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-fe8c-40bc-a681-b80b771449b7
1e413633-a549-4d9a-9d79-f18adaa748e0	20202020-4955-4fd9-8e59-2dbd373f2a46	fbe4525e-6a79-4ade-894f-1abf14324de8	messageFolder	messageFolders	Message Folder	Message Folders	Message Folders	IconFolder	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	942e5d9b-ddac-4e34-8b3a-f3e8adfecfbb	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-4955-4fd9-8e59-2dbd373f2a46
e386c71a-338d-4a79-ae0e-792bc13d7c22	20202020-a433-4456-aa2d-fd9cb26b774a	fbe4525e-6a79-4ade-894f-1abf14324de8	messageParticipant	messageParticipants	Message Participant	Message Participants	Message Participants	IconUserCircle	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	21af689d-502d-4d36-b3df-79838343e3d4	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-a433-4456-aa2d-fd9cb26b774a
1c726159-0955-4b7d-9232-9971c71d0a38	20202020-849a-4c3e-84f5-a25a7d802271	fbe4525e-6a79-4ade-894f-1abf14324de8	messageThread	messageThreads	Message Thread	Message Threads	Message Thread	IconMessage	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	3ecfa8f2-854e-4d49-867e-0fbc4e7fb116	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-849a-4c3e-84f5-a25a7d802271
bb71b55e-db18-48fe-ab10-9047b29b2e12	20202020-3f6b-4425-80ab-e468899ab4b2	fbe4525e-6a79-4ade-894f-1abf14324de8	message	messages	Message	Messages	Message	IconMessage	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	c39472d6-999f-43f6-bbd2-237473ad6d00	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-3f6b-4425-80ab-e468899ab4b2
c6a21a1b-a7bc-4c5e-88a1-aec070dac319	20202020-fff0-4b44-be82-bda313884400	fbe4525e-6a79-4ade-894f-1abf14324de8	noteTarget	noteTargets	Note Target	Note Targets	A note target	IconCheckbox	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	dc22e27a-bb55-4878-a076-eb99bf7e815d	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-fff0-4b44-be82-bda313884400
77864c8b-b2cf-43bd-8fab-3e77052c50b7	20202020-5a9a-44e8-95df-771cd06d0fb1	fbe4525e-6a79-4ade-894f-1abf14324de8	taskTarget	taskTargets	Task Target	Task Targets	A task target	IconCheckbox	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	dee7bada-a04f-49d4-8a2c-11cc1555265a	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-5a9a-44e8-95df-771cd06d0fb1
16136df1-455c-4a8b-8bb6-e98e1d03b033	20202020-6736-4337-b5c4-8b39fae325a5	fbe4525e-6a79-4ade-894f-1abf14324de8	timelineActivity	timelineActivities	Timeline Activity	Timeline Activities	Aggregated / filtered event to be displayed on the timeline	IconTimelineEvent	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	b4869ecb-fb0c-4dd9-8e77-53f0eb8c544f	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-6736-4337-b5c4-8b39fae325a5
fdc1c527-a8e2-48bf-ad0d-7bb7037d58fe	20202020-3319-4234-a34c-7f3b9d2e4d1f	fbe4525e-6a79-4ade-894f-1abf14324de8	workflowAutomatedTrigger	workflowAutomatedTriggers	Workflow Automated Trigger	Workflow Automated Triggers	A workflow automated trigger	IconSettingsAutomation	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	48a65724-218d-4475-96d8-758794381309	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-3319-4234-a34c-7f3b9d2e4d1f
a7cfcff2-c38b-4f4a-922e-7574e0338ec4	20202020-4e28-4e95-a9d7-6c00874f843c	fbe4525e-6a79-4ade-894f-1abf14324de8	workflowRun	workflowRuns	Workflow Run	Workflow Runs	A workflow run	IconHistoryToggle	\N	DEPRECATED	f	f	t	t	f	f	f	\N	\N	2d5c5097-d9f2-407e-95a6-45ddd91f674f	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-4e28-4e95-a9d7-6c00874f843c
1ea1c8cd-1607-4f5c-b1d3-1f74e52a747d	20202020-d65d-4ab9-9344-d77bfb376a3d	fbe4525e-6a79-4ade-894f-1abf14324de8	workflowVersion	workflowVersions	Workflow Version	Workflow Versions	A workflow version	IconVersions	\N	DEPRECATED	f	f	t	t	f	t	f	\N	\N	e970f351-175c-468f-a0a3-8c4715bc833c	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-d65d-4ab9-9344-d77bfb376a3d
6d830113-2052-4566-a669-df61dd1cd970	20202020-9549-49dd-b2b2-883999db8938	fbe4525e-6a79-4ade-894f-1abf14324de8	opportunity	opportunities	Opportunity	Opportunities	An opportunity	IconTargetArrow	\N	DEPRECATED	f	f	f	f	f	t	t	\N	O	dd0e308f-9482-4753-9ea6-bf04d49559d4	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:10:49.677288+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-9549-49dd-b2b2-883999db8938
415d12c3-c586-4222-9c41-994a99cebf67	20202020-0b00-45cd-b6f6-6cd806fc6804	fbe4525e-6a79-4ade-894f-1abf14324de8	note	notes	Note	Notes	A note	IconNotes	\N	DEPRECATED	f	f	f	f	f	t	t	\N	N	099988d7-8eed-4ba1-9a37-74b783630ebf	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:14:11.710169+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-0b00-45cd-b6f6-6cd806fc6804
3e0e25f7-98a7-4e8a-a30d-ab67057aee93	20202020-62be-406c-b9ca-8caa50d51392	fbe4525e-6a79-4ade-894f-1abf14324de8	workflow	workflows	Workflow	Workflows	A workflow	IconSettingsAutomation	\N	DEPRECATED	f	f	f	f	f	t	f	\N	W	4c01aa1f-28f7-4722-a195-6a44586e91d6	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:13:44.178177+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-62be-406c-b9ca-8caa50d51392
a34181a4-c008-4fcb-b55e-3f1bdf07d717	20202020-3840-4b6d-9425-0c5188b05ca8	fbe4525e-6a79-4ade-894f-1abf14324de8	dashboard	dashboards	Dashboard	Dashboards	A dashboard	IconLayoutDashboard	\N	DEPRECATED	f	f	f	f	f	t	t	\N	D	286c40b6-8226-4460-9494-a830db5ed6da	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:15:33.862798+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-3840-4b6d-9425-0c5188b05ca8
41a553bd-c463-40f2-88bc-07967f17a128	20202020-e674-48e5-a542-72570eee7213	fbe4525e-6a79-4ade-894f-1abf14324de8	person	people	Person	People	A person	IconUser	\N	DEPRECATED	f	f	f	f	f	t	t	[["nameFirstName", "nameLastName"], ["linkedinLinkPrimaryLinkUrl"], ["emailsPrimaryEmail"]]	P	21455064-b26f-477e-a8c5-61fba1cf2b7c	46c9dd40-91dc-4784-80a7-227e1f5c3040	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:18:10.585982+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-e674-48e5-a542-72570eee7213
ff60777a-2722-4aa0-ba66-a8e089c7bc94	20202020-1ba1-48ba-bc83-ef7e5990ed10	fbe4525e-6a79-4ade-894f-1abf14324de8	task	tasks	Task	Tasks	A task	IconCheckbox	\N	DEPRECATED	f	f	f	f	f	t	t	\N	T	608fec74-7af7-4fd2-8ebf-efdff84c5046	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 13:23:56.611396+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-1ba1-48ba-bc83-ef7e5990ed10
285bf1ca-e489-4b4e-a29c-30127e960da7	20202020-3319-4234-a34c-82d5c0e881a6	fbe4525e-6a79-4ade-894f-1abf14324de8	workspaceMember	workspaceMembers	Workspace Member	Workspace Members	A workspace member	IconUserCircle	\N	DEPRECATED	f	f	t	t	f	t	t	\N	\N	60308355-6900-418b-8644-6ef9d0a2a9e0	2f4d0b77-3f3a-42b3-98ee-d5fe8b73f7b6	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-3319-4234-a34c-82d5c0e881a6
d7124df1-9136-4b65-8c71-befa364161f2	20202020-b374-4779-a561-80086cb2e17f	fbe4525e-6a79-4ade-894f-1abf14324de8	company	companies	Company	Companies	A company	IconBuildingSkyscraper	\N	DEPRECATED	f	f	f	f	f	t	t	[["name"], ["domainNamePrimaryLinkUrl"]]	C	eb858483-5937-4ce5-9c68-259d1235607d	\N	f	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:11:30.910478+00	67affcc3-762a-4fee-baa4-2a048ddd621e	20202020-b374-4779-a561-80086cb2e17f
be33c5f3-ee15-4555-9f5f-209b30f33076	\N	fbe4525e-6a79-4ade-894f-1abf14324de8	property	properties	Property	Properties	Listed properties	IconListNumbers	\N	DEPRECATED	t	f	t	f	f	t	t	\N	\N	e7b8f0eb-d5af-43a5-b01e-b0c607b833b9	\N	t	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.488+00	2026-02-28 05:19:34.488+00	bbb719d5-4626-40d6-aec6-7d53f24e5459	9e054ea6-f623-401f-8fe9-bf451687ce8d
430929f9-3e67-479e-8af2-aa6ae925ff82	\N	fbe4525e-6a79-4ade-894f-1abf14324de8	origin	origins	Origin	Origins	Origin of lead	IconSourceCode	\N	DEPRECATED	t	f	t	f	f	t	t	\N	\N	67ce61ef-73a8-47ee-85e7-390db6fadb9a	\N	t	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.683+00	2026-02-28 05:53:09.683+00	bbb719d5-4626-40d6-aec6-7d53f24e5459	96fd7e9b-e46a-4a2e-b3d9-e5c8deeadbd0
5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	\N	fbe4525e-6a79-4ade-894f-1abf14324de8	lead	leads	Lead	Leads	Leads	IconListNumbers	\N	DEPRECATED	t	f	t	f	f	t	t	\N	\N	044735bf-c886-450b-ae9d-fa4f03eca30b	\N	t	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.759+00	2026-02-28 06:14:51.759+00	bbb719d5-4626-40d6-aec6-7d53f24e5459	8df2938d-1b4e-4c82-b061-b85eb8fd2c10
7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	\N	fbe4525e-6a79-4ade-894f-1abf14324de8	customer	customers	Customer	Customers	Customer information	IconUserCode	\N	DEPRECATED	t	f	t	f	f	t	t	\N	\N	dbd2a7f1-8a29-46a6-93f5-79512d201f4a	\N	t	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.856+00	2026-02-28 06:54:36.856+00	bbb719d5-4626-40d6-aec6-7d53f24e5459	212033d4-8064-4e0c-93dc-6016b079c3c9
\.


--
-- Data for Name: objectPermission; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."objectPermission" (id, "roleId", "objectMetadataId", "canReadObjectRecords", "canUpdateObjectRecords", "canSoftDeleteObjectRecords", "canDestroyObjectRecords", "workspaceId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: pageLayout; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."pageLayout" (id, name, "workspaceId", type, "objectMetadataId", "createdAt", "updatedAt", "deletedAt", "universalIdentifier", "applicationId") FROM stdin;
61102e6d-8b99-4d2f-b789-338aac15b8a7	My First Dashboard	a8cf39ab-a363-48fd-8960-096055b51144	DASHBOARD	\N	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d001-4d01-8d01-da5ab0a00001	67affcc3-762a-4fee-baa4-2a048ddd621e
\.


--
-- Data for Name: pageLayoutTab; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."pageLayoutTab" (id, title, "workspaceId", "position", "pageLayoutId", "createdAt", "updatedAt", "deletedAt", "universalIdentifier", "applicationId") FROM stdin;
409927b6-f8b0-495e-95bb-73ef5ec69684	Tab 1	a8cf39ab-a363-48fd-8960-096055b51144	0	61102e6d-8b99-4d2f-b789-338aac15b8a7	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d011-4d11-8d11-da5ab0a01001	67affcc3-762a-4fee-baa4-2a048ddd621e
\.


--
-- Data for Name: pageLayoutWidget; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."pageLayoutWidget" (id, "pageLayoutTabId", "workspaceId", title, type, "objectMetadataId", "gridPosition", configuration, "createdAt", "updatedAt", "deletedAt", "universalIdentifier", "applicationId") FROM stdin;
84db66cd-c5ca-4f44-9a63-67eaa1def397	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Untitled Rich Text	STANDALONE_RICH_TEXT	\N	{"row": 0, "column": 0, "rowSpan": 6, "columnSpan": 6}	{"body": {"markdown": null, "blocknote": "[{\\"id\\":\\"6361f6bc-8b6b-443f-96cb-1877e7cca259\\",\\"type\\":\\"heading\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\",\\"level\\":3},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Welcome to your workspace\\",\\"styles\\":{}}],\\"children\\":[]},{\\"id\\":\\"e32f3ba2-9f75-4201-be2b-4d3c645365cb\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[],\\"children\\":[]},{\\"id\\":\\"f5005a73-17d1-4af3-96e7-a5161e57dc08\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"You can edit this dashboard by clicking the \\",\\"styles\\":{}},{\\"type\\":\\"text\\",\\"text\\":\\"Edit\\",\\"styles\\":{\\"code\\":true}},{\\"type\\":\\"text\\",\\"text\\":\\" button in the top-right corner to add your own charts or customize this one.\\",\\"styles\\":{}}],\\"children\\":[]},{\\"id\\":\\"f720d4d3-4210-4cf1-b093-04b8b1e56823\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[],\\"children\\":[]},{\\"id\\":\\"503affda-4b20-422a-a2d9-319d78ca75cb\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Don't forget to replace the sample data with your own.\\",\\"styles\\":{}}],\\"children\\":[]},{\\"id\\":\\"57d4a1e0-c148-4b87-827d-579ba7e6df09\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[],\\"children\\":[]},{\\"id\\":\\"c8ab01ca-1c65-458c-adb8-e81699a94b54\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"If you have any issues, you can check \\",\\"styles\\":{}},{\\"type\\":\\"link\\",\\"href\\":\\"https://docs.twenty.com/user-guide/introduction\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"our documentation\\",\\"styles\\":{}}]},{\\"type\\":\\"text\\",\\"text\\":\\" or contact us through the Support section in Settings.\\",\\"styles\\":{}}],\\"children\\":[]},{\\"id\\":\\"1d4b69b7-e43b-4305-b28f-7d4396ae73d3\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[],\\"children\\":[]}]"}, "configurationType": "STANDALONE_RICH_TEXT"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11001	67affcc3-762a-4fee-baa4-2a048ddd621e
a29bc78b-52b4-430b-b325-90e2ba15b866	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Deals by Company	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 0, "column": 6, "rowSpan": 6, "columnSpan": 6}	{"color": "orange", "orderBy": "FIELD_ASC", "timezone": "UTC", "displayLegend": true, "displayDataLabel": false, "showCenterMetric": true, "configurationType": "PIE_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "COUNT", "groupBySubFieldName": "name", "groupByFieldMetadataId": "5642d645-5dad-42d2-a255-14b88b8b0bb3", "aggregateFieldMetadataId": "ca15f5f8-8229-415f-9929-e9432161ae93"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11002	67affcc3-762a-4fee-baa4-2a048ddd621e
5625af9a-9a15-44c9-9565-868f5a9108e6	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Pipeline Value by Stage	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 6, "column": 0, "rowSpan": 6, "columnSpan": 6}	{"color": "green", "layout": "VERTICAL", "timezone": "UTC", "displayLegend": true, "axisNameDisplay": "NONE", "displayDataLabel": true, "configurationType": "BAR_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "SUM", "primaryAxisOrderBy": "FIELD_POSITION_ASC", "secondaryAxisOrderBy": "FIELD_ASC", "aggregateFieldMetadataId": "2eb74dc4-86a4-491b-bdb4-4ead9f61074b", "primaryAxisDateGranularity": "DAY", "secondaryAxisGroupBySubFieldName": "name", "primaryAxisGroupByFieldMetadataId": "df2411c7-21a9-414e-a3f7-cd9466bbbb5b", "secondaryAxisGroupByDateGranularity": "DAY", "secondaryAxisGroupByFieldMetadataId": "5642d645-5dad-42d2-a255-14b88b8b0bb3"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11003	67affcc3-762a-4fee-baa4-2a048ddd621e
83c55f49-9e92-4e15-a64c-68d56461a7fc	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Revenue Timeline	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 6, "column": 6, "rowSpan": 6, "columnSpan": 6}	{"color": "crimson", "timezone": "UTC", "isCumulative": false, "displayLegend": true, "axisNameDisplay": "NONE", "displayDataLabel": false, "configurationType": "LINE_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "SUM", "primaryAxisOrderBy": "FIELD_ASC", "aggregateFieldMetadataId": "2eb74dc4-86a4-491b-bdb4-4ead9f61074b", "primaryAxisDateGranularity": "DAY", "primaryAxisGroupByFieldMetadataId": "de5aa019-e0b2-4294-95b4-cdfb4bb0cccf"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11004	67affcc3-762a-4fee-baa4-2a048ddd621e
3a95bdeb-e597-4164-8ca2-b8bd4783a105	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Opportunities by Owner	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 12, "column": 0, "rowSpan": 6, "columnSpan": 6}	{"color": "blue", "layout": "HORIZONTAL", "timezone": "UTC", "isCumulative": false, "displayLegend": true, "axisNameDisplay": "NONE", "displayDataLabel": false, "configurationType": "BAR_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "COUNT", "primaryAxisOrderBy": "FIELD_ASC", "secondaryAxisOrderBy": "FIELD_ASC", "aggregateFieldMetadataId": "ca15f5f8-8229-415f-9929-e9432161ae93", "primaryAxisDateGranularity": "DAY", "primaryAxisGroupBySubFieldName": "name.firstName", "secondaryAxisGroupBySubFieldName": "name.firstName", "primaryAxisGroupByFieldMetadataId": "109c99ae-2de0-42a4-8f3e-dcef05bf9ab1", "secondaryAxisGroupByDateGranularity": "DAY", "secondaryAxisGroupByFieldMetadataId": "109c99ae-2de0-42a4-8f3e-dcef05bf9ab1"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11005	67affcc3-762a-4fee-baa4-2a048ddd621e
0de327fa-55cb-4f2e-8886-43ec92ed0abd	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Stock market (Iframe)	IFRAME	\N	{"row": 12, "column": 6, "rowSpan": 8, "columnSpan": 6}	{"url": "https://www.tradingview.com/embed-widget/hotlists/?locale=en", "configurationType": "IFRAME"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11006	67affcc3-762a-4fee-baa4-2a048ddd621e
b9e5825d-d6ed-45c1-a9b6-f8d1132c317e	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Deals created this month	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 18, "column": 0, "rowSpan": 2, "columnSpan": 3}	{"filter": {"recordFilters": [{"id": "f7f1fd69-aa65-4352-a040-28f6a7d7022e", "type": "DATE_TIME", "label": "Creation date", "value": "THIS_1_MONTH;;UTC;;SUNDAY;;", "operand": "IS_RELATIVE", "displayValue": "THIS_1_MONTH;;UTC;;SUNDAY;;", "fieldMetadataId": "0936a820-f223-4a7a-b332-183afa912a2a", "recordFilterGroupId": "f6018760-e1d5-4ce6-a53e-9be125f97793"}], "recordFilterGroups": [{"id": "f6018760-e1d5-4ce6-a53e-9be125f97793", "logicalOperator": "AND"}]}, "prefix": "", "timezone": "UTC", "displayDataLabel": false, "configurationType": "AGGREGATE_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "COUNT", "aggregateFieldMetadataId": "ca15f5f8-8229-415f-9929-e9432161ae93"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11007	67affcc3-762a-4fee-baa4-2a048ddd621e
beb8e9d4-bc4e-4b21-a6ba-bf71e84a5d03	409927b6-f8b0-495e-95bb-73ef5ec69684	a8cf39ab-a363-48fd-8960-096055b51144	Deal value created this month	GRAPH	6d830113-2052-4566-a669-df61dd1cd970	{"row": 18, "column": 3, "rowSpan": 2, "columnSpan": 3}	{"filter": {"recordFilters": [{"id": "defaac17-c7d9-4a21-9795-b0f6f9df7304", "type": "DATE_TIME", "label": "Creation date", "value": "THIS_1_MONTH;;UTC;;SUNDAY;;", "operand": "IS_RELATIVE", "displayValue": "THIS_1_MONTH;;UTC;;SUNDAY;;", "fieldMetadataId": "0936a820-f223-4a7a-b332-183afa912a2a", "recordFilterGroupId": "a55701fa-2206-4107-a44d-b392713249ce"}], "recordFilterGroups": [{"id": "a55701fa-2206-4107-a44d-b392713249ce", "logicalOperator": "AND"}]}, "prefix": "$", "timezone": "UTC", "displayDataLabel": false, "configurationType": "AGGREGATE_CHART", "firstDayOfTheWeek": 0, "aggregateOperation": "SUM", "aggregateFieldMetadataId": "2eb74dc4-86a4-491b-bdb4-4ead9f61074b"}	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	20202020-d111-4d11-8d11-da5ab0a11008	67affcc3-762a-4fee-baa4-2a048ddd621e
\.


--
-- Data for Name: permissionFlag; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."permissionFlag" (id, "roleId", flag, "workspaceId", "createdAt", "updatedAt") FROM stdin;
4ec87e84-5a8c-4208-b885-67c11744fece	9b10f843-22ed-4429-ba95-c218fea6be03	DOWNLOAD_FILE	a8cf39ab-a363-48fd-8960-096055b51144	2026-03-02 13:45:23.133048+00	2026-03-02 13:45:23.133048+00
de383063-3e5c-49b8-b77b-8b6ec8a3d318	9b10f843-22ed-4429-ba95-c218fea6be03	UPLOAD_FILE	a8cf39ab-a363-48fd-8960-096055b51144	2026-03-02 13:45:23.133048+00	2026-03-02 13:45:23.133048+00
3ee8d53d-8f56-42aa-92dc-d061e4da585d	9b10f843-22ed-4429-ba95-c218fea6be03	EXPORT_CSV	a8cf39ab-a363-48fd-8960-096055b51144	2026-03-02 13:45:23.133048+00	2026-03-02 13:45:23.133048+00
bed1e748-a9c1-4af1-8a5b-e5f225475a1a	cc53fcd4-c62d-432c-a3c7-2c8825b6a1fc	WORKSPACE_MEMBERS	a8cf39ab-a363-48fd-8960-096055b51144	2026-03-02 15:07:17.237021+00	2026-03-02 15:07:17.237021+00
\.


--
-- Data for Name: postgresCredentials; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."postgresCredentials" (id, "user", "passwordHash", "createdAt", "updatedAt", "deletedAt", "workspaceId") FROM stdin;
\.


--
-- Data for Name: publicDomain; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."publicDomain" (id, "createdAt", "updatedAt", domain, "isValidated", "workspaceId") FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.role (id, "standardId", label, "canUpdateAllSettings", "canAccessAllTools", "canReadAllObjectRecords", "canUpdateAllObjectRecords", "canSoftDeleteAllObjectRecords", "canDestroyAllObjectRecords", description, icon, "workspaceId", "createdAt", "updatedAt", "isEditable", "canBeAssignedToUsers", "canBeAssignedToAgents", "canBeAssignedToApiKeys", "universalIdentifier", "applicationId", "canReadOwnObjectRecordsOnly") FROM stdin;
f813e483-06f1-4d06-9106-728bace8cba4	20202020-0001-0001-0001-000000000001	Admin	t	t	t	t	t	t	Admin role	IconUserCog	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	f	t	f	t	20202020-0001-0001-0001-000000000001	67affcc3-762a-4fee-baa4-2a048ddd621e	f
cc53fcd4-c62d-432c-a3c7-2c8825b6a1fc	\N	Manager	f	t	t	t	t	t	Manager role	IconUser	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:17.175+00	2026-02-28 05:17:12.280388+00	t	t	f	f	fc1da1ee-86fc-4433-a3b1-311407208817	bbb719d5-4626-40d6-aec6-7d53f24e5459	f
9b10f843-22ed-4429-ba95-c218fea6be03	\N	Sales	f	f	t	f	f	f	Sales person	IconUser	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:17:39.674+00	2026-02-28 12:32:41.898486+00	t	t	t	t	d6f477df-7855-40aa-b704-79df5287f0af	bbb719d5-4626-40d6-aec6-7d53f24e5459	t
\.


--
-- Data for Name: roleTarget; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."roleTarget" (id, "workspaceId", "roleId", "userWorkspaceId", "agentId", "apiKeyId", "createdAt", "updatedAt", "universalIdentifier", "applicationId") FROM stdin;
92a279ea-b883-4359-8dd4-b8ed2f23cfa6	a8cf39ab-a363-48fd-8960-096055b51144	f813e483-06f1-4d06-9106-728bace8cba4	a88cd381-21dc-491a-9bba-01f056e8855f	\N	\N	2026-02-28 05:07:17.157+00	2026-02-28 05:07:17.157+00	eaa97067-d64d-46bc-8be6-c5283a6d206e	bbb719d5-4626-40d6-aec6-7d53f24e5459
7d0cb314-79c5-4ace-91dc-967a54e2c913	a8cf39ab-a363-48fd-8960-096055b51144	9b10f843-22ed-4429-ba95-c218fea6be03	16df559e-4544-4243-9058-a5ec76f0873f	\N	\N	2026-02-28 06:08:58.782+00	2026-02-28 06:08:58.782+00	0c7f2eec-4220-4916-8c4b-56eaa3bc1caa	bbb719d5-4626-40d6-aec6-7d53f24e5459
45042ccf-021d-4ded-9d2d-0d69f1b90219	a8cf39ab-a363-48fd-8960-096055b51144	f813e483-06f1-4d06-9106-728bace8cba4	\N	\N	2e203bdb-a27d-4307-a071-457dec5f5908	2026-02-28 07:26:53.631+00	2026-02-28 07:26:53.631+00	22f747a6-3d71-466b-8c83-6db5cb4c1dc5	bbb719d5-4626-40d6-aec6-7d53f24e5459
d1820a83-baea-42f4-b719-f647a30038c9	a8cf39ab-a363-48fd-8960-096055b51144	cc53fcd4-c62d-432c-a3c7-2c8825b6a1fc	7f520551-cf9d-42fa-9033-168b205f566b	\N	\N	2026-03-02 17:10:39.055+00	2026-03-02 17:10:39.055+00	af0cc426-464d-46cb-970a-7b05884bfca5	bbb719d5-4626-40d6-aec6-7d53f24e5459
\.


--
-- Data for Name: routeTrigger; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."routeTrigger" ("universalIdentifier", id, path, "isAuthRequired", "httpMethod", "workspaceId", "createdAt", "updatedAt", "serverlessFunctionId", "applicationId", "forwardedRequestHeaders") FROM stdin;
\.


--
-- Data for Name: rowLevelPermissionPredicate; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."rowLevelPermissionPredicate" ("universalIdentifier", "applicationId", id, "fieldMetadataId", "objectMetadataId", operand, value, "subFieldName", "workspaceMemberFieldMetadataId", "workspaceMemberSubFieldName", "rowLevelPermissionPredicateGroupId", "positionInRowLevelPermissionPredicateGroup", "workspaceId", "roleId", "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- Data for Name: rowLevelPermissionPredicateGroup; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."rowLevelPermissionPredicateGroup" ("universalIdentifier", "applicationId", id, "parentRowLevelPermissionPredicateGroupId", "logicalOperator", "positionInRowLevelPermissionPredicateGroup", "workspaceId", "roleId", "createdAt", "updatedAt", "deletedAt", "objectMetadataId") FROM stdin;
\.


--
-- Data for Name: searchFieldMetadata; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."searchFieldMetadata" (id, "objectMetadataId", "fieldMetadataId", "createdAt", "updatedAt", "workspaceId") FROM stdin;
\.


--
-- Data for Name: serverlessFunction; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."serverlessFunction" (id, name, description, "latestVersion", "publishedVersions", runtime, "timeoutSeconds", "workspaceId", "createdAt", "updatedAt", "deletedAt", "universalIdentifier", "applicationId", checksum, "serverlessFunctionLayerId", "sourceHandlerPath", "handlerName", "toolInputSchema", "isTool", "builtHandlerPath") FROM stdin;
\.


--
-- Data for Name: serverlessFunctionLayer; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."serverlessFunctionLayer" (id, "packageJson", "yarnLock", checksum, "workspaceId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.skill ("universalIdentifier", "applicationId", "workspaceId", id, "standardId", name, label, icon, description, content, "isCustom", "isActive", "createdAt", "updatedAt") FROM stdin;
20202020-6155-838a-b64e-44a791fbdc13	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	95acc3b7-09c4-4b0c-9926-462f26fe5478	20202020-6155-838a-b64e-44a791fbdc13	workflow-building	Workflow Building	IconSettingsAutomation	Creating and managing automation workflows with triggers and steps	# Workflow Building Skill\n\nYou help users create and manage automation workflows.\n\n## Capabilities\n\n- Create workflows from scratch\n- Modify existing workflows (add, remove, update steps)\n- Explain workflow structure and suggest improvements\n\n## Key Concepts\n\n- **Triggers**: DATABASE_EVENT, MANUAL, CRON, WEBHOOK\n- **Steps**: CREATE_RECORD, SEND_EMAIL, CODE, etc.\n- **Data flow**: Use {{stepId.fieldName}} to reference previous step outputs\n- **Relationships**: Use nested objects like {"company": {"id": "{{reference}}"}}\n\n## CRON Trigger Settings Schema\n\nFor CRON triggers, settings.type must be one of these exact values:\n\n1. **DAYS** - Daily schedule\n   - Requires: schedule: { day: number (1+), hour: number (0-23), minute: number (0-59) }\n   - Example: { type: "DAYS", schedule: { day: 1, hour: 9, minute: 0 }, outputSchema: {} }\n\n2. **HOURS** - Hourly schedule (USE THIS FOR "EVERY HOUR")\n   - Requires: schedule: { hour: number (1+), minute: number (0-59) }\n   - Example: { type: "HOURS", schedule: { hour: 1, minute: 0 }, outputSchema: {} }\n   - This runs every X hours at Y minutes past the hour\n\n3. **MINUTES** - Minute-based schedule\n   - Requires: schedule: { minute: number (1+) }\n   - Example: { type: "MINUTES", schedule: { minute: 15 }, outputSchema: {} }\n\n4. **CUSTOM** - Custom cron pattern\n   - Requires: pattern: string (cron expression)\n   - Example: { type: "CUSTOM", pattern: "0 * * * *", outputSchema: {} }\n\n## Critical Notes\n\nAlways rely on tool schema definitions:\n- The workflow creation tool provides comprehensive schemas with examples\n- Follow schema definitions exactly for field names, types, and structures\n- Schema includes validation rules and common patterns\n\n## Approach\n\n- Ask clarifying questions to understand user needs\n- Suggest appropriate actions for the use case\n- Explain each step and why it's needed\n- For modifications, understand current structure first\n- Ensure workflow logic remains coherent\n\nPrioritize user understanding and workflow effectiveness.	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-e225-f5c7-3d56-45feaa36f2e6	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	002592e5-e981-45eb-aa3c-6d91356f084c	20202020-e225-f5c7-3d56-45feaa36f2e6	data-manipulation	Data Manipulation	IconDatabase	Searching, filtering, creating, and updating records across all objects	# Data Manipulation Skill\n\nYou explore and manage data across companies, people, opportunities, tasks, notes, and custom objects.\n\n## Capabilities\n\n- Search, filter, sort, create, update records\n- Manage relationships between records\n- Bulk operations and data analysis\n\n## Constraints\n\n- READ and WRITE access to all objects\n- CANNOT delete records or access workflow objects\n- CANNOT modify workspace settings\n\n## Multi-step Approach\n\n- Chain queries to solve complex requests (e.g., find companies → get their opportunities → calculate totals)\n- If a query fails or returns no results, try alternative filters or approaches\n- Validate data exists before referencing it (search before update)\n- Use results from one query to inform the next\n- Try 2-3 different approaches before giving up\n\n## Sorting (Critical)\n\nFor "top N" queries, use orderBy with limit:\n- Examples: orderBy: [{"employees": "DescNullsLast"}], orderBy: [{"createdAt": "AscNullsFirst"}]\n- Valid directions: "AscNullsFirst", "AscNullsLast", "DescNullsFirst", "DescNullsLast"\n\n## Before Bulk Operations\n\n- Confirm the scope and impact\n- Explain what will change\n\nPrioritize data integrity and provide clear feedback on operations performed.	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-398f-0d7a-82db-4f43bc7e7044	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	1308873c-eee2-4382-be44-b5f7c2af418c	20202020-398f-0d7a-82db-4f43bc7e7044	dashboard-building	Dashboard Building	IconLayoutDashboard	Creating and managing dashboards with widgets and layouts	# Dashboard Building Skill\n\nYou help users create and manage dashboards with widgets.\n\n## CRITICAL: Creating GRAPH Widgets\n\nBefore creating any GRAPH widget, you MUST:\n1. Use list_object_metadata_items to get the objectMetadataId (e.g., for "opportunity", "company")\n2. From the response, get the field IDs you need (aggregateFieldMetadataId, primaryAxisGroupByFieldMetadataId)\n\nGRAPH widgets require real UUIDs from the workspace metadata, NOT made-up values.\n\n## Understanding User Language\n\nUsers describe charts using UI terminology. Here's how to translate:\n\n### Bar/Line Chart Settings\n\n**Data section:**\n- "Source" / "change the object": objectMetadataId\n\n**X axis section (primary grouping - the bars/categories):**\n- "X axis" / "data on display" / "categories": primaryAxisGroupByFieldMetadataId\n- "X axis subfield" / "Address.city": primaryAxisGroupBySubFieldName\n- "Date granularity" (on X axis): primaryAxisDateGranularity\n- "Sort by" (on X axis): primaryAxisOrderBy\n\n**Y axis section (what's being measured + optional secondary grouping):**\n- "Y axis" / "data on display" / "measure" / "metric": aggregateFieldMetadataId + aggregateOperation\n- "Group by" / "stacking" / "colors" / "breakdown": secondaryAxisGroupByFieldMetadataId\n- "Group by subfield" / "Address.city": secondaryAxisGroupBySubFieldName\n- "Date granularity" (on Group by): secondaryAxisGroupByDateGranularity\n- "Sort by" (on Group by): secondaryAxisOrderBy\n- "Cumulative" / "running total": isCumulative\n- "Min range" / "Max range": rangeMin, rangeMax\n- "Hide empty values" / "omit nulls": omitNullValues\n\n**Style section:**\n- "Stacked" / "stacked bars": layout stays same, it's about secondaryAxisGroupByFieldMetadataId\n- "Data labels" / "show values": displayDataLabel\n- "Legend" / "show legend": displayLegend\n\n### CRITICAL: "Remove groupby" / "remove stacking" / "unstacked"\nWhen users say this for bar/line charts, they mean remove the SECONDARY grouping (the colors/stacking).\n- Set secondaryAxisGroupByFieldMetadataId to null\n- Keep the chart type (BAR_CHART/LINE_CHART)\n- Keep primaryAxisGroupByFieldMetadataId (the X axis categories)\n- DO NOT convert to AGGREGATE_CHART unless user explicitly asks for "just a number" or "KPI"\n\n### Pie Chart Settings\n- "Each slice represents" / "slices": groupByFieldMetadataId\n- "Slice subfield" / "Address.city": groupBySubFieldName\n- "Hide empty category": hideEmptyCategory\n- "Show value in center": showValueInCenter\n\n### Aggregate Chart Settings (KPI numbers)\n- "Prefix" (e.g., "$"): prefix\n- "Suffix" (e.g., "%"): suffix\n- "Ratio by option" / "percent of a value": ratioAggregateConfig\n\n## Widget Configuration Types\n\n### AGGREGATE_CHART (KPI number widget)\nShows a single aggregated value.\nRequired:\n- objectMetadataId: UUID of the object\n- configuration.configurationType: "AGGREGATE_CHART"\n- configuration.aggregateFieldMetadataId: UUID of field to aggregate\n- configuration.aggregateOperation: "COUNT", "SUM", "AVG", "MIN", "MAX"\nOptional: prefix, suffix, displayDataLabel, ratioAggregateConfig\n\n### BAR_CHART\nShows data grouped by categories with optional secondary grouping.\nRequired:\n- objectMetadataId: UUID of the object\n- configuration.configurationType: "BAR_CHART"\n- configuration.aggregateFieldMetadataId: field to aggregate\n- configuration.aggregateOperation: aggregation type\n- configuration.primaryAxisGroupByFieldMetadataId: X axis categories\n- configuration.layout: "VERTICAL" or "HORIZONTAL"\nOptional: secondaryAxisGroupByFieldMetadataId (for stacking/colors), primaryAxisGroupBySubFieldName, secondaryAxisGroupBySubFieldName, omitNullValues, displayDataLabel, displayLegend\n\n### LINE_CHART\nShows trends over a dimension.\nRequired:\n- objectMetadataId: UUID of the object\n- configuration.configurationType: "LINE_CHART"\n- configuration.aggregateFieldMetadataId: field to aggregate\n- configuration.aggregateOperation: aggregation type\n- configuration.primaryAxisGroupByFieldMetadataId: X axis (usually date)\nOptional: secondaryAxisGroupByFieldMetadataId (for multiple lines), primaryAxisGroupBySubFieldName, secondaryAxisGroupBySubFieldName, omitNullValues, isCumulative, displayDataLabel\n\n### PIE_CHART\nShows data distribution as slices.\nRequired:\n- objectMetadataId: UUID of the object\n- configuration.configurationType: "PIE_CHART"\n- configuration.aggregateFieldMetadataId: field to aggregate\n- configuration.aggregateOperation: aggregation type\n- configuration.groupByFieldMetadataId: field to slice by (NOTE: different field name than bar/line!)\nOptional: groupBySubFieldName, displayDataLabel, hideEmptyCategory, showValueInCenter\n\n### IFRAME\nEmbeds external content:\n- configuration.configurationType: "IFRAME"\n- configuration.url: "https://..."\n\n### STANDALONE_RICH_TEXT\nText content widget:\n- configuration.configurationType: "STANDALONE_RICH_TEXT"\n- configuration.body: rich text content\n\n## Grid System\n\n- 12 columns (0-11)\n- KPI widgets: rowSpan 2-4, columnSpan 3-4\n- Charts: rowSpan 6-8, columnSpan 6-12\n- Common layouts:\n  - 4 KPIs in a row: each { columnSpan: 3 }\n  - 2 charts side by side: each { columnSpan: 6 }\n  - Full width chart: { column: 0, columnSpan: 12 }\n\n## Workflow\n\n1. Ask user what data they want to visualize\n2. Load list_object_metadata_items to discover available objects and fields\n3. Create dashboard with appropriate widgets using real field IDs\n4. Use get_dashboard to verify creation and see current configuration\n5. When modifying, first understand current config before making changes\n\n## Best Practices\n\n- Place KPIs at the top (row 0)\n- Group related charts together\n- Use consistent heights within rows\n- Start simple, add complexity as needed\n- When user asks to modify a chart, clarify if they want to change settings OR change chart type	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-c66a-5fed-4a74-46e0b42a6332	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	4f39196d-7029-4b72-a917-c9c6dea859db	20202020-c66a-5fed-4a74-46e0b42a6332	metadata-building	Metadata Building	IconBuildingSkyscraper	Managing the data model: creating objects, fields, and relations	# Metadata Building Skill\n\nYou help users manage their workspace data model by creating, updating, and organizing custom objects and fields.\n\n## Capabilities\n\n- Create new custom objects with appropriate naming and configuration\n- Add fields to existing objects (text, number, date, select, relation, etc.)\n- Update object and field properties (labels, descriptions, icons)\n- Manage field settings (required, unique, default values)\n- Create relations between objects\n\n## Key Concepts\n\n- **Objects**: Represent entities in the data model (e.g., Company, Person, Opportunity)\n- **Fields**: Properties of objects with specific types (TEXT, NUMBER, DATE_TIME, SELECT, RELATION, etc.)\n- **Relations**: Links between objects (one-to-many, many-to-one)\n- **Labels vs Names**: Labels are for display, names are internal identifiers (camelCase)\n\n## Field Types Available\n\n- **TEXT**: Simple text fields\n- **NUMBER**: Numeric values (integers or decimals)\n- **BOOLEAN**: True/false values\n- **DATE_TIME**: Date and time values\n- **DATE**: Date only values\n- **SELECT**: Single choice from options\n- **MULTI_SELECT**: Multiple choices from options\n- **LINK**: URL fields\n- **LINKS**: Multiple URL fields\n- **EMAIL**: Email address fields\n- **EMAILS**: Multiple email fields\n- **PHONE**: Phone number fields\n- **PHONES**: Multiple phone fields\n- **CURRENCY**: Monetary values\n- **RATING**: Star ratings\n- **RELATION**: Links to other objects\n- **RICH_TEXT**: Formatted text content\n\n## Best Practices\n\n- Use clear, descriptive names for objects and fields\n- Follow naming conventions: singular for object names, camelCase for field names\n- Add helpful descriptions to objects and fields\n- Choose appropriate field types for the data being stored\n- Consider relationships between objects when designing the data model\n\n## Approach\n\n- Ask clarifying questions to understand the user's data modeling needs\n- Suggest best practices for naming and organization\n- Explain the impact of changes to the data model\n- Verify object and field existence before making updates\n- Provide clear feedback on operations performed\n\nPrioritize data model integrity and user understanding.	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-db75-4fca-6813-4c7db0f964a0	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	1b4832d2-b76a-4d0d-ba7c-13a3099a2ee4	20202020-db75-4fca-6813-4c7db0f964a0	research	Research	IconSearch	Finding information and gathering facts from the web	# Research Skill\n\nYou find information and gather facts from the web.\n\n## Capabilities\n\n- Search for current information and facts\n- Research companies, people, technologies, trends\n- Gather competitive intelligence and market data\n- Find contact details and verify information\n\n## Research Strategy\n\n- Try multiple search queries from different angles\n- If initial searches fail, use alternative search terms\n- Cross-reference information when possible\n- Cite sources and provide context\n\n## Present Findings\n\n- Be thorough but concise\n- Organize information logically\n- Distinguish facts from speculation\n- Note if information might be outdated\n- Include relevant sources\n\nBe persistent in finding accurate information.	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-5eb9-e775-cf4e-4f22be7be362	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	0e9ba682-7fd1-4f1b-87df-e8ddccac0d45	20202020-5eb9-e775-cf4e-4f22be7be362	code-interpreter	Code Interpreter	IconCode	Python code execution for data analysis, complex multi-step operations, and efficient bulk processing via MCP bridge	# Code Interpreter Skill\n\nYou have access to the `code_interpreter` tool to execute Python code in a sandboxed environment.\n\n## How to Use\nCall the `code_interpreter` tool with your Python code. The tool will execute the code and return stdout, stderr, and any generated files.\n\n## Capabilities\n- Analyze CSV, Excel, and JSON data files\n- Create charts and visualizations (matplotlib, seaborn)\n- Generate reports (PDF, PPTX, Excel)\n- Perform calculations and data transformations\n\n## Pre-installed Libraries\npandas, numpy, matplotlib, seaborn, scikit-learn, openpyxl, python-pptx\n\n## Input Files\n- User-uploaded files are available at `/home/user/{filename}`\n- Always check the file exists before processing\n\n## Output Files\n- Charts: Save to `/home/user/output/` directory - these are automatically returned as downloadable URLs\n- For matplotlib: `plt.savefig('/home/user/output/chart.png')`\n- Generated files: Save to `/home/user/output/{filename}`\n\n## Example: Create a Bar Chart\n```python\nimport matplotlib.pyplot as plt\nimport os\n\n# Data\nmonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']\nsales = [100, 150, 200, 175, 250, 300]\n\n# Create chart\nplt.figure(figsize=(10, 6))\nplt.bar(months, sales, color='skyblue')\nplt.title('Monthly Sales')\nplt.xlabel('Month')\nplt.ylabel('Sales')\nplt.tight_layout()\n\n# Save to output directory\nos.makedirs('/home/user/output', exist_ok=True)\nplt.savefig('/home/user/output/sales_chart.png')\nprint('Chart saved!')\n```\n\n## Example: Analyze CSV\n```python\nimport pandas as pd\nimport matplotlib.pyplot as plt\nimport os\n\n# Load data\ndf = pd.read_csv('/home/user/data.csv')\nprint(f"Loaded {len(df)} rows")\n\n# Create visualization\nplt.figure(figsize=(10, 6))\ndf.groupby('category')['value'].mean().plot(kind='bar')\nplt.title('Average Value by Category')\nplt.tight_layout()\n\nos.makedirs('/home/user/output', exist_ok=True)\nplt.savefig('/home/user/output/analysis.png')\nprint('Analysis complete!')\n```\n\n## Calling Twenty Tools from Python (MCP Bridge)\n\nA `twenty` helper is automatically available in your code. Use it to call any Twenty tool directly from Python:\n\n```python\n# Find records\npeople = twenty.call_tool('find_person_records', {'limit': 10})\nprint(f"Found {len(people['edges'])} people")\n\n# Create a record\nresult = twenty.call_tool('create_company_record', {\n    'data': {'name': 'Acme Corp', 'domainName': {'primaryLinkUrl': 'acme.com'}}\n})\nprint(f"Created company: {result['id']}")\n\n# Update a record\ntwenty.call_tool('update_person_record', {\n    'id': 'person-uuid',\n    'data': {'jobTitle': 'CEO'}\n})\n\n# List available tools\ntools = twenty.list_tools()\nfor tool in tools:\n    print(f"- {tool['name']}: {tool['description']}")\n```\n\nThis allows you to orchestrate complex multi-step operations in a single code execution, which is more efficient than multiple tool calls.	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-2c7f-5b77-dfa4-494b84752ab7	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	e2ddc7a8-6b89-45e1-9fa6-8a07dbfc4ff6	20202020-2c7f-5b77-dfa4-494b84752ab7	xlsx	Excel & Spreadsheets	IconFileSpreadsheet	Excel/spreadsheet creation, editing, and analysis with formulas, formatting, and visualization	# Excel Processing Skill\n\n**IMPORTANT**: Save all output files to `/home/user/output/` for them to be downloadable.\n\n## Pre-installed Scripts\n\n- `python /home/user/scripts/xlsx/recalc.py <excel_file> [timeout]` - Recalculate formulas using LibreOffice\n\n## Requirements\n\n### Zero Formula Errors\nEvery Excel model MUST be delivered with ZERO formula errors (#REF!, #DIV/0!, #VALUE!, #N/A, #NAME?)\n\n### Use Formulas, Not Hardcoded Values\n**Always use Excel formulas instead of calculating values in Python and hardcoding them.**\n\n```python\n# ❌ WRONG - Hardcoding\ntotal = df['Sales'].sum()\nsheet['B10'] = total\n\n# ✅ CORRECT - Using formulas\nsheet['B10'] = '=SUM(B2:B9)'\n```\n\n## Reading and Analyzing Data\n\n```python\nimport pandas as pd\n\n# Read Excel\ndf = pd.read_excel('file.xlsx')\nall_sheets = pd.read_excel('file.xlsx', sheet_name=None)  # All sheets as dict\n\n# Analyze\ndf.head()\ndf.info()\ndf.describe()\n```\n\n## Creating New Excel Files\n\n```python\nfrom openpyxl import Workbook\nfrom openpyxl.styles import Font, PatternFill, Alignment\n\nwb = Workbook()\nsheet = wb.active\n\n# Add data\nsheet['A1'] = 'Hello'\nsheet.append(['Row', 'of', 'data'])\n\n# Add formula\nsheet['B2'] = '=SUM(A1:A10)'\n\n# Formatting\nsheet['A1'].font = Font(bold=True)\nsheet['A1'].fill = PatternFill('solid', start_color='FFFF00')\nsheet['A1'].alignment = Alignment(horizontal='center')\n\n# Column width\nsheet.column_dimensions['A'].width = 20\n\nwb.save('/home/user/output/output.xlsx')\n```\n\n## Editing Existing Files\n\n```python\nfrom openpyxl import load_workbook\n\nwb = load_workbook('existing.xlsx')\nsheet = wb.active\n\n# Modify cells\nsheet['A1'] = 'New Value'\nsheet.insert_rows(2)\n\nwb.save('/home/user/output/modified.xlsx')\n```\n\n## Recalculating Formulas (MANDATORY)\n\nAfter creating/editing files with formulas, run:\n```bash\npython /home/user/scripts/xlsx/recalc.py /home/user/output/output.xlsx\n```\n\nThe script returns JSON with error details:\n```json\n{\n  "status": "success",\n  "total_errors": 0,\n  "total_formulas": 42,\n  "error_summary": {}\n}\n```\n\nIf errors found, fix them and recalculate again.\n\n## Financial Model Color Coding\n\n- **Blue text**: Hardcoded inputs\n- **Black text**: Formulas and calculations\n- **Green text**: Links from other worksheets\n- **Yellow background**: Key assumptions needing attention\n\n## Number Formatting\n\n- Years: Format as text ("2024" not "2,024")\n- Currency: Use $#,##0 format\n- Percentages: 0.0% format\n- Negatives: Use parentheses (123) not minus -123\n\n## Quick Reference\n\n| Task | Tool | Example |\n|------|------|---------|\n| Read Excel | pandas | `pd.read_excel('file.xlsx')` |\n| Create Excel | openpyxl | `Workbook()` |\n| Add formula | openpyxl | `sheet['B2'] = '=SUM(A1:A10)'` |\n| Recalculate | script | `python /home/user/scripts/xlsx/recalc.py file.xlsx` |	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-c3d1-e0c9-2f93-45648b8bbd26	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	641150e5-6063-4505-ae15-ce15f9f28f30	20202020-c3d1-e0c9-2f93-45648b8bbd26	pdf	PDF Processing	IconFileTypePdf	PDF form filling, field extraction, table parsing, and validation	# PDF Processing Skill\n\n**IMPORTANT**: Save all output files to `/home/user/output/` for them to be downloadable.\n\n## Pre-installed Scripts\n\n### Field Extraction\n- `python /home/user/scripts/pdf/extract_form_field_info.py <pdf_file>` - Extract all fillable field names and types (JSON output)\n- `python /home/user/scripts/pdf/check_fillable_fields.py <pdf_file>` - Check if PDF has fillable fields\n\n### Form Filling\n- `python /home/user/scripts/pdf/fill_fillable_fields.py <pdf_file> <json_data> <output_file>` - Fill PDF form fields\n- `python /home/user/scripts/pdf/fill_pdf_form_with_annotations.py <pdf_file> <json_data> <output_file>` - Fill with annotation support\n\n### Validation\n- `python /home/user/scripts/pdf/create_validation_image.py <pdf_file>` - Create validation image of filled PDF\n- `python /home/user/scripts/pdf/check_bounding_boxes.py <pdf_file>` - Check field boundaries\n- `python /home/user/scripts/pdf/convert_pdf_to_images.py <pdf_file>` - Convert PDF pages to images\n\n## Reading PDFs\n\n```python\nimport fitz  # PyMuPDF\n\n# Open PDF\ndoc = fitz.open('document.pdf')\n\n# Extract text from all pages\nfor page in doc:\n    text = page.get_text()\n    print(text)\n\n# Extract text from specific page\npage = doc[0]  # First page\ntext = page.get_text()\n```\n\n## Extracting Tables\n\n```python\nimport pdfplumber\n\nwith pdfplumber.open('document.pdf') as pdf:\n    for page in pdf.pages:\n        tables = page.extract_tables()\n        for table in tables:\n            for row in table:\n                print(row)\n```\n\n## Filling PDF Forms\n\n### Step 1: Extract field information\n```bash\npython /home/user/scripts/pdf/extract_form_field_info.py form.pdf > fields.json\n```\n\n### Step 2: Create fill data JSON\n```json\n{\n  "field_name_1": "value1",\n  "field_name_2": "value2",\n  "checkbox_field": true\n}\n```\n\n### Step 3: Fill the form\n```bash\npython /home/user/scripts/pdf/fill_fillable_fields.py form.pdf fill_data.json /home/user/output/output.pdf\n```\n\n### Step 4: Validate the output\n```bash\npython /home/user/scripts/pdf/create_validation_image.py /home/user/output/output.pdf\n```\n\n## Creating PDFs\n\n```python\nfrom reportlab.lib.pagesizes import letter\nfrom reportlab.pdfgen import canvas\n\nc = canvas.Canvas('/home/user/output/output.pdf', pagesize=letter)\nc.drawString(100, 750, 'Hello World!')\nc.save()\n```\n\n## Merging PDFs\n\n```python\nfrom PyPDF2 import PdfMerger\n\nmerger = PdfMerger()\nmerger.append('file1.pdf')\nmerger.append('file2.pdf')\nmerger.write('/home/user/output/merged.pdf')\nmerger.close()\n```\n\n## Splitting PDFs\n\n```python\nfrom PyPDF2 import PdfReader, PdfWriter\n\nreader = PdfReader('document.pdf')\n\n# Extract specific pages\nwriter = PdfWriter()\nwriter.add_page(reader.pages[0])  # First page\nwriter.write('/home/user/output/page1.pdf')\n```\n\n## Quick Reference\n\n| Task | Tool | Command/Example |\n|------|------|-----------------|\n| Extract text | PyMuPDF | `page.get_text()` |\n| Extract tables | pdfplumber | `page.extract_tables()` |\n| List form fields | script | `python extract_form_field_info.py form.pdf` |\n| Fill form | script | `python fill_fillable_fields.py form.pdf data.json out.pdf` |\n| Validate fill | script | `python create_validation_image.py filled.pdf` |\n| Create PDF | reportlab | `canvas.Canvas('out.pdf')` |\n| Merge PDFs | PyPDF2 | `PdfMerger()` |	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-6f15-2432-0537-4e23a2efd1cb	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	be516fd2-0c93-4955-a94a-977949aa5d0a	20202020-6f15-2432-0537-4e23a2efd1cb	docx	Word Documents	IconFileTypeDocx	Word document creation, editing, template processing, and OOXML manipulation	# Word Document Processing Skill\n\n**IMPORTANT**: Save all output files to `/home/user/output/` for them to be downloadable.\n\n## Pre-installed Scripts (OOXML Editing)\n\n- `python /home/user/scripts/docx/unpack.py <docx_file> <output_dir>` - Unpack .docx to XML files for direct editing\n- `python /home/user/scripts/docx/pack.py <input_dir> <docx_file>` - Repack XML files into .docx\n- `python /home/user/scripts/docx/validate.py <docx_file>` - Validate document structure\n\n### Validation Scripts\n- `/home/user/scripts/docx/validation/docx.py` - DOCX validation module\n- `/home/user/scripts/docx/validation/redlining.py` - Track changes/redline validation\n\n## High-Level API (python-docx)\n\n### Reading Documents\n\n```python\nfrom docx import Document\n\ndoc = Document('document.docx')\n\n# Read paragraphs\nfor para in doc.paragraphs:\n    print(para.text)\n\n# Read tables\nfor table in doc.tables:\n    for row in table.rows:\n        for cell in row.cells:\n            print(cell.text)\n```\n\n### Creating Documents\n\n```python\nfrom docx import Document\nfrom docx.shared import Inches, Pt\nfrom docx.enum.text import WD_ALIGN_PARAGRAPH\n\ndoc = Document()\n\n# Add heading\ndoc.add_heading('Document Title', 0)\n\n# Add paragraph with formatting\npara = doc.add_paragraph('Normal text. ')\nrun = para.add_run('Bold text.')\nrun.bold = True\n\n# Add table\ntable = doc.add_table(rows=2, cols=2)\ntable.cell(0, 0).text = 'Header 1'\ntable.cell(0, 1).text = 'Header 2'\n\n# Add image\ndoc.add_picture('image.png', width=Inches(4))\n\ndoc.save('/home/user/output/output.docx')\n```\n\n## Low-Level OOXML Editing\n\nFor complex edits (tracked changes, custom XML), use the unpack/edit/pack workflow:\n\n### Step 1: Unpack\n```bash\npython /home/user/scripts/docx/unpack.py document.docx ./unpacked/\n```\n\n### Step 2: Edit XML directly\n```python\nimport xml.etree.ElementTree as ET\n\ntree = ET.parse('./unpacked/word/document.xml')\nroot = tree.getroot()\n\n# Edit XML...\n# Namespaces: w = http://schemas.openxmlformats.org/wordprocessingml/2006/main\n\ntree.write('./unpacked/word/document.xml', xml_declaration=True, encoding='UTF-8')\n```\n\n### Step 3: Validate & Repack\n```bash\npython /home/user/scripts/docx/validate.py ./unpacked/\npython /home/user/scripts/docx/pack.py ./unpacked/ /home/user/output/output.docx\n```\n\n## Template Processing\n\n### Find and Replace\n```python\nfrom docx import Document\n\ndoc = Document('template.docx')\n\nfor para in doc.paragraphs:\n    if '{{name}}' in para.text:\n        para.text = para.text.replace('{{name}}', 'John Doe')\n\ndoc.save('/home/user/output/filled.docx')\n```\n\n### Preserve Formatting During Replace\n```python\ndef replace_in_paragraph(para, old_text, new_text):\n    """Replace text while preserving formatting"""\n    for run in para.runs:\n        if old_text in run.text:\n            run.text = run.text.replace(old_text, new_text)\n\nfor para in doc.paragraphs:\n    replace_in_paragraph(para, '{{name}}', 'John Doe')\n```\n\n## Working with Styles\n\n```python\nfrom docx.shared import Pt, RGBColor\n\n# Set font\nrun.font.name = 'Arial'\nrun.font.size = Pt(12)\nrun.font.color.rgb = RGBColor(0, 0, 0)\n\n# Paragraph formatting\npara.alignment = WD_ALIGN_PARAGRAPH.CENTER\npara.paragraph_format.space_before = Pt(12)\npara.paragraph_format.space_after = Pt(12)\n```\n\n## Quick Reference\n\n| Task | Tool | Example |\n|------|------|---------|\n| Read document | python-docx | `Document('file.docx')` |\n| Create document | python-docx | `Document()` |\n| Add heading | python-docx | `doc.add_heading('Title', 0)` |\n| Add table | python-docx | `doc.add_table(rows=2, cols=2)` |\n| Unpack for editing | script | `python unpack.py doc.docx ./out/` |\n| Repack | script | `python pack.py ./out/ doc.docx` |\n| Validate | script | `python validate.py doc.docx` |	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
20202020-c81b-baf8-5255-4c34bd0eac9b	67affcc3-762a-4fee-baa4-2a048ddd621e	a8cf39ab-a363-48fd-8960-096055b51144	a67365a7-3148-42dc-8e20-653725bbb0ce	20202020-c81b-baf8-5255-4c34bd0eac9b	pptx	PowerPoint	IconPresentation	PowerPoint creation, editing, templates, thumbnails, and slide manipulation	# PowerPoint Processing Skill\n\n**IMPORTANT**: Save all output files to `/home/user/output/` for them to be downloadable.\n\n## Pre-installed Scripts\n\n- `python /home/user/scripts/pptx/thumbnail.py <pptx_file> [output_dir]` - Generate slide thumbnails\n- `python /home/user/scripts/pptx/rearrange.py <pptx_file> <slide_order_json> <output_file>` - Reorder slides\n- `python /home/user/scripts/pptx/inventory.py <pptx_file>` - List all slides and their content\n- `python /home/user/scripts/pptx/replace.py <pptx_file> <replacements_json> <output_file>` - Find/replace text\n\n## Reading Presentations\n\n```python\nfrom pptx import Presentation\n\nprs = Presentation('presentation.pptx')\n\n# Iterate through slides\nfor slide in prs.slides:\n    for shape in slide.shapes:\n        if shape.has_text_frame:\n            print(shape.text)\n```\n\n## Creating Presentations\n\n```python\nfrom pptx import Presentation\nfrom pptx.util import Inches, Pt\n\nprs = Presentation()\n\n# Add title slide\nslide_layout = prs.slide_layouts[0]  # Title layout\nslide = prs.slides.add_slide(slide_layout)\ntitle = slide.shapes.title\nsubtitle = slide.placeholders[1]\n\ntitle.text = "Presentation Title"\nsubtitle.text = "Subtitle goes here"\n\n# Add content slide\nslide_layout = prs.slide_layouts[1]  # Title and content\nslide = prs.slides.add_slide(slide_layout)\ntitle = slide.shapes.title\nbody = slide.placeholders[1]\n\ntitle.text = "Slide Title"\ntf = body.text_frame\ntf.text = "First bullet"\np = tf.add_paragraph()\np.text = "Second bullet"\np.level = 1\n\nprs.save('/home/user/output/output.pptx')\n```\n\n## Adding Images\n\n```python\nfrom pptx.util import Inches\n\nslide = prs.slides.add_slide(prs.slide_layouts[6])  # Blank layout\nslide.shapes.add_picture(\n    'image.png',\n    left=Inches(1),\n    top=Inches(1),\n    width=Inches(5)\n)\n```\n\n## Adding Tables\n\n```python\nfrom pptx.util import Inches\n\nslide = prs.slides.add_slide(prs.slide_layouts[6])\ntable = slide.shapes.add_table(\n    rows=3, cols=3,\n    left=Inches(1), top=Inches(1),\n    width=Inches(8), height=Inches(2)\n).table\n\n# Set cell values\ntable.cell(0, 0).text = "Header 1"\ntable.cell(0, 1).text = "Header 2"\ntable.cell(1, 0).text = "Data 1"\n```\n\n## Adding Charts\n\n```python\nfrom pptx.chart.data import CategoryChartData\nfrom pptx.enum.chart import XL_CHART_TYPE\nfrom pptx.util import Inches\n\nchart_data = CategoryChartData()\nchart_data.categories = ['East', 'West', 'Midwest']\nchart_data.add_series('Series 1', (19.2, 21.4, 16.7))\n\nslide = prs.slides.add_slide(prs.slide_layouts[6])\nchart = slide.shapes.add_chart(\n    XL_CHART_TYPE.COLUMN_CLUSTERED,\n    Inches(1), Inches(1), Inches(8), Inches(5),\n    chart_data\n).chart\n```\n\n## Using Scripts\n\n### Generate Thumbnails\n```bash\npython /home/user/scripts/pptx/thumbnail.py presentation.pptx ./thumbnails/\n# Creates: thumbnails/slide_1.png, slide_2.png, etc.\n```\n\n### Get Slide Inventory\n```bash\npython /home/user/scripts/pptx/inventory.py presentation.pptx\n# Returns JSON with all slide content and shapes\n```\n\n### Reorder Slides\n```bash\n# Order: [3, 1, 2] means slide 3 becomes first, slide 1 second, etc.\npython /home/user/scripts/pptx/rearrange.py input.pptx '[3, 1, 2]' output.pptx\n```\n\n### Find and Replace Text\n```bash\npython /home/user/scripts/pptx/replace.py input.pptx '{"{{company}}": "Acme Corp", "{{date}}": "2024"}' output.pptx\n```\n\n## Template Processing Workflow\n\n1. **Generate thumbnails** to understand slide structure:\n   ```bash\n   python /home/user/scripts/pptx/thumbnail.py template.pptx ./preview/\n   ```\n\n2. **Get inventory** to find placeholder text:\n   ```bash\n   python /home/user/scripts/pptx/inventory.py template.pptx\n   ```\n\n3. **Replace placeholders**:\n   ```bash\n   python /home/user/scripts/pptx/replace.py template.pptx '{"{{title}}": "Q4 Report"}' output.pptx\n   ```\n\n## Quick Reference\n\n| Task | Tool | Example |\n|------|------|---------|\n| Read presentation | python-pptx | `Presentation('file.pptx')` |\n| Create presentation | python-pptx | `Presentation()` |\n| Add slide | python-pptx | `prs.slides.add_slide(layout)` |\n| Generate thumbnails | script | `python thumbnail.py pres.pptx ./out/` |\n| Get slide inventory | script | `python inventory.py pres.pptx` |\n| Reorder slides | script | `python rearrange.py pres.pptx '[2,1,3]' out.pptx` |\n| Find/replace | script | `python replace.py pres.pptx '{...}' out.pptx` |	f	t	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00
\.


--
-- Data for Name: twoFactorAuthenticationMethod; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."twoFactorAuthenticationMethod" (id, "userWorkspaceId", secret, status, strategy, "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."user" (id, "firstName", "lastName", email, "defaultAvatarUrl", "isEmailVerified", disabled, "passwordHash", "canImpersonate", "canAccessFullAdminPanel", "createdAt", "updatedAt", "deletedAt", locale) FROM stdin;
4b1fd975-bd63-456e-b441-60b020914433			visakhrj@gmail.com	\N	f	f	$2b$10$3YjwSXBtu6urmW0gipf88uCoqV1vXjerl.PMsfQMZlwkoynBGQht6	t	t	2026-02-28 05:07:08.544413+00	2026-02-28 05:07:08.544413+00	\N	en
a764a0de-fcea-4803-a93e-dbf11f5b4db1			vasishtrj@gmail.com	\N	f	f	$2b$10$Yn8jVbvFrsRQTM42sDBp7.BxASAkNZpd2YhiyUnNZqgtvhSG1T1xq	f	f	2026-02-28 06:06:58.909915+00	2026-02-28 06:06:58.909915+00	\N	en
80d538c7-4037-424f-bb74-c60da39e9b29			arjunsaji6@gmail.com	\N	f	f	$2b$10$QEElvOaVL/5sy60i8vX1M.uiDSEdr21vb2H/Qj4gZ954LGO4Lr6Aa	f	f	2026-02-28 06:08:58.7269+00	2026-02-28 06:08:58.7269+00	\N	en
\.


--
-- Data for Name: userWorkspace; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."userWorkspace" (id, "userId", "workspaceId", "defaultAvatarUrl", locale, "createdAt", "updatedAt", "deletedAt") FROM stdin;
a88cd381-21dc-491a-9bba-01f056e8855f	4b1fd975-bd63-456e-b441-60b020914433	a8cf39ab-a363-48fd-8960-096055b51144	\N	en	2026-02-28 05:07:08.544413+00	2026-02-28 05:07:08.544413+00	\N
7f520551-cf9d-42fa-9033-168b205f566b	a764a0de-fcea-4803-a93e-dbf11f5b4db1	a8cf39ab-a363-48fd-8960-096055b51144	\N	en	2026-02-28 06:06:58.934494+00	2026-02-28 06:06:58.934494+00	\N
16df559e-4544-4243-9058-a5ec76f0873f	80d538c7-4037-424f-bb74-c60da39e9b29	a8cf39ab-a363-48fd-8960-096055b51144	\N	en	2026-02-28 06:08:58.743857+00	2026-02-28 06:08:58.743857+00	\N
\.


--
-- Data for Name: view; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.view ("universalIdentifier", id, name, "objectMetadataId", type, key, icon, "position", "isCompact", "isCustom", "openRecordIn", "kanbanAggregateOperation", "kanbanAggregateOperationFieldMetadataId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "anyFieldFilterValue", "calendarLayout", "calendarFieldMetadataId", "applicationId", visibility, "createdByUserWorkspaceId", "mainGroupByFieldMetadataId", "shouldHideEmptyGroups") FROM stdin;
20202020-c001-4c01-8c01-ca1ebe0ca001	5cd586f3-79f0-41da-98ac-44d67e8df434	All Calendar Events	3964c94e-8e9c-4e92-b9f2-8144df00e793	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	53d86340-2a32-4585-a401-6315e55d63fd	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a001-4a01-8a01-c0aba11c0001	3723a8d2-07ea-4256-83be-e5201a439931	All Companies	d7124df1-9136-4b65-8c71-befa364161f2	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a012-4a12-8a12-da5ab0b0a001	23f7f89e-2e1e-4995-898e-49e63c22b8a0	All Dashboards	a34181a4-c008-4fcb-b55e-3f1bdf07d717	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-d001-4d01-8d01-ae55a9e5a001	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	All Messages	bb71b55e-db18-48fe-ab10-9047b29b2e12	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-d002-4d02-8d02-ae55a9ba2002	3d42e109-7be2-406d-936c-2da88a9fec19	All Message Threads	1c726159-0955-4b7d-9232-9971c71d0a38	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a005-4a05-8a05-a0be5a11a000	3a15597a-cdeb-402c-a063-374d56cff3c4	All Notes	415d12c3-c586-4222-9c41-994a99cebf67	TABLE	INDEX	IconNotes	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a003-4a03-8a03-0aa0b1ca1ba0	644303fc-d0dd-4f24-8aa6-da28d3dfda29	All Opportunities	6d830113-2052-4566-a669-df61dd1cd970	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a004-4a04-8a04-0aa0b1ca1ba0	57e505bc-2cb5-404f-ade5-a310e925f0cb	By Stage	6d830113-2052-4566-a669-df61dd1cd970	KANBAN	\N	IconLayoutKanban	2	f	f	SIDE_PANEL	SUM	2eb74dc4-86a4-491b-bdb4-4ead9f61074b	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	df2411c7-21a9-414e-a3f7-cd9466bbbb5b	f
20202020-a002-4a02-8a02-ae0a1ea11a00	12ef8d12-50f1-4b04-88d8-cf955997a7e0	All People	41a553bd-c463-40f2-88bc-07967f17a128	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a006-4a06-8a06-ba5ca11a1ea0	b906b5b6-1980-4c50-8da9-8d985d2f6053	All Tasks	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a008-4a08-8a08-ba5cba51aba5	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	By Status	ff60777a-2722-4aa0-ba66-a8e089c7bc94	KANBAN	\N	IconLayoutKanban	1	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	f
20202020-a007-4a07-8a07-ba5ca551aaed	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	Assigned to Me	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TABLE	\N	IconUserCircle	2	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	f
20202020-a009-4a09-8a09-a0bcf10aa11a	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	All Workflows	3e0e25f7-98a7-4e8a-a30d-ab67057aee93	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
20202020-a011-4a11-8a11-a0bcf10abca5	d0b30e3c-eee2-4f31-841d-5798e473bb33	All Workflow Runs	a7cfcff2-c38b-4f4a-922e-7574e0338ec4	TABLE	INDEX	IconList	0	f	f	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	\N	\N	\N	67affcc3-762a-4fee-baa4-2a048ddd621e	WORKSPACE	\N	\N	f
b995521d-9d53-4763-a8dd-9c62edde4a55	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	All {objectLabelPlural}	be33c5f3-ee15-4555-9f5f-209b30f33076	TABLE	INDEX	IconList	0	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.495+00	2026-02-28 05:19:34.495+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	\N	f
817d0b74-dca1-4bdb-9ee4-7d11ab90c58b	11d36386-2b79-4923-a08e-b996cb3df940	All {objectLabelPlural}	430929f9-3e67-479e-8af2-aa6ae925ff82	TABLE	INDEX	IconList	0	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.687+00	2026-02-28 05:53:09.687+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	\N	f
013031b5-f538-44c5-865a-ec7284107eb4	4d3c9f01-dea1-4481-a2ac-edace2eb9169	Assigned to vasishtrj@gmail.com	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TABLE	\N	IconUserCircle	3	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	f
ba0bd322-f063-4d7f-bad7-5c954cb5c1c8	540188fc-4dcb-4c72-8a76-722b09bad285	Assigned to arjunsaji6@gmail.com	ff60777a-2722-4aa0-ba66-a8e089c7bc94	TABLE	\N	IconUserCircle	4	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	f
43d4cc42-9182-4e3d-976a-844911087de6	84e44f0f-b8d5-4fd0-a252-e81e32893673	All {objectLabelPlural}	5065d6d0-7cb0-47ad-8f23-56e1b06a34f8	TABLE	INDEX	IconList	0	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	\N	f
4d9035d5-64bf-4ef0-957a-2672cea15c8f	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	All {objectLabelPlural}	7d1c964d-b5b4-4f13-bd47-600bfab3b5ba	TABLE	INDEX	IconList	0	f	t	SIDE_PANEL	\N	\N	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.868+00	2026-02-28 06:54:36.868+00	\N	\N	\N	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459	WORKSPACE	\N	\N	f
\.


--
-- Data for Name: viewField; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."viewField" ("universalIdentifier", id, "fieldMetadataId", "isVisible", size, "position", "aggregateOperation", "viewId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "applicationId") FROM stdin;
20202020-cf01-4c01-8c01-ca1ebe0caf01	93c420fa-8d63-4fcc-9fb7-f7d39645a671	a2c53edd-fe83-4b96-bf20-af609af74aec	t	180	0	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf02	01774c99-9646-43ce-8f8c-5f38bfe157c2	53d86340-2a32-4585-a401-6315e55d63fd	t	150	1	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf03	4da5a703-4b9e-402b-b181-ff614ffb3fbd	2e995bee-fd0d-4ce7-abd5-92f1efb0ecdb	t	150	2	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf04	c77aaafe-085e-4c15-ba36-dd03a0ab31f8	3b580204-6b97-4736-bf3e-fe762dfa0274	t	100	3	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf05	e792a0b7-9ca3-47bb-9958-b0211341d25c	0c483011-0d30-4c66-86d0-7932740cc07a	t	150	4	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf06	817c3271-adf5-47dd-91a6-2f85442afa07	78986fb3-66e2-4da6-8e00-b4a114d6bc2c	t	150	5	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf07	f1baa4d0-c122-44d1-9635-0e2a50b0e997	68fe3a5d-3046-4c61-b7b0-82015593db18	t	100	6	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-cf01-4c01-8c01-ca1ebe0caf08	2d5b7dae-5a30-416b-b1b9-50b53869071a	2ce8c312-21b6-423c-85b5-4d65b0bf3bd5	t	150	7	\N	5cd586f3-79f0-41da-98ac-44d67e8df434	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf001	da1a4f3d-27c8-43b0-b0ae-31de9359ed8b	eb858483-5937-4ce5-9c68-259d1235607d	t	180	0	\N	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf002	2eaa37ae-1ac9-4cfe-9d62-24a05cb749fe	f2496f3a-f39f-49f8-9eab-f967d6576e40	t	100	1	COUNT	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf003	bae856a7-8443-4737-9093-04aa34e4379e	27d984fd-a568-463a-9c3b-98e10046291a	t	150	2	\N	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf004	2c797d91-e7ab-4d93-a7f7-c29b18d26efd	b20c80a8-b163-4946-89bf-fccc4c8248a7	t	150	3	\N	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf005	f9ec5a3d-a4c6-41ba-a6a6-befe829688db	6c92eab1-1463-4a90-8336-057354bedde6	t	150	4	\N	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf006	103f6f16-7157-4586-9cb3-1d783a0b6de0	c62d2bc4-df89-4d6c-9caf-11a760519d11	t	150	5	MAX	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf007	0adeeeea-d1be-4079-be98-fe6ef8fe5650	1490b8d6-3f3f-4a95-9077-5d9c080192f2	t	170	6	PERCENTAGE_EMPTY	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af01-4a01-8a01-c0aba11cf008	e7dc7a6b-ea5c-4190-b4ef-6debba7371c1	7d7186c9-dec2-4421-8cfd-4d197478e9bc	t	170	7	COUNT_NOT_EMPTY	3723a8d2-07ea-4256-83be-e5201a439931	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af12-4a12-8a12-da5ab0b0af01	d37330d8-594f-44d2-b73f-17616ea5b1bf	286c40b6-8226-4460-9494-a830db5ed6da	t	200	0	\N	23f7f89e-2e1e-4995-898e-49e63c22b8a0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af12-4a12-8a12-da5ab0b0af02	a5c6a5a2-844f-46bb-aca7-99f1fdab3872	1b9c75c3-c1ec-4637-bc1d-49f95c9ca27d	t	150	1	\N	23f7f89e-2e1e-4995-898e-49e63c22b8a0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af12-4a12-8a12-da5ab0b0af03	afc7c363-42a7-4574-bb72-a005d3f20241	d175b455-be7d-4ad4-86d9-657bc4fcb8e0	t	150	2	\N	23f7f89e-2e1e-4995-898e-49e63c22b8a0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af12-4a12-8a12-da5ab0b0af04	9343142f-c441-465f-9cf4-d5098e086775	4ebade73-9b65-423b-9c2f-c6cfd34024b5	t	150	3	\N	23f7f89e-2e1e-4995-898e-49e63c22b8a0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af01	1c19086d-e9b4-4321-bbf2-5f63ebe0324c	c39472d6-999f-43f6-bbd2-237473ad6d00	t	180	0	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af02	45140f68-b4d0-479b-9bf6-de69bc195051	758b4564-d24c-4466-bb28-f2b8ab1a3b05	t	150	1	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af03	596c96c1-f842-418e-ac5a-4b31d7c60e37	c1ff1a4a-63d3-403b-8596-059169cd295c	t	150	2	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af04	03fc2618-c1ce-4717-a7f4-d357d19cbac4	03d83c07-bdc8-40bd-bdb2-085dda8c9d3a	t	150	3	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af05	30337ec6-373f-44d4-9d35-2126e0d8d22b	f9090b38-32d0-428b-ae65-f81cf96d02e6	t	180	4	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af06	59690c13-7000-448e-843f-aa0973a5202b	fd4cfe7a-0f8f-4d64-b14e-e08e3ab5c120	t	200	5	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df01-4d01-8d01-ae55a9e5af07	2eb25dd5-c3d0-4d27-94d0-2dc4e55d37d7	db48f287-b86f-4699-beee-9c1522e1f92f	t	150	6	\N	4fc3fcd1-e0e7-4ab0-8aaf-405cddfa905e	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df02-4d02-8d02-ae55a9ba2f01	5015cc70-dec1-4a33-991f-1d2ea01dea2e	726d0ec5-8db2-4f43-ab32-87894bfe4433	t	180	0	\N	3d42e109-7be2-406d-936c-2da88a9fec19	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-df02-4d02-8d02-ae55a9ba2f02	9ad9227b-ddf9-44b3-9daa-c4234ef20ab0	c5056d6c-206f-4c15-9cdc-961bd001663f	t	150	1	\N	3d42e109-7be2-406d-936c-2da88a9fec19	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af05-4a05-8a05-a0be5a11af00	308aa1cf-a802-4bc5-8adb-2d0c1ecfac47	099988d7-8eed-4ba1-9a37-74b783630ebf	t	210	0	\N	3a15597a-cdeb-402c-a063-374d56cff3c4	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af05-4a05-8a05-a0be5a11af01	a08569b4-ddf7-4a26-b953-d24391a60369	6685f802-de0d-4a07-bbbe-dbd41627f99a	t	150	1	\N	3a15597a-cdeb-402c-a063-374d56cff3c4	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af05-4a05-8a05-a0be5a11af02	74323502-a72d-4406-bce4-576035cbbb11	7273cfe0-2104-416b-ad94-9d70db31de35	t	150	2	\N	3a15597a-cdeb-402c-a063-374d56cff3c4	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af05-4a05-8a05-a0be5a11af03	d5ce6a6f-2c06-4da2-b679-844ce555abff	0b3a0236-449e-451a-b32b-ae28d3edeebb	t	150	3	\N	3a15597a-cdeb-402c-a063-374d56cff3c4	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af05-4a05-8a05-a0be5a11af04	17f4cba4-fabf-4e59-82e8-ca18bc1aaf95	33c68f92-052e-4150-896e-a7adc9f60605	t	150	4	\N	3a15597a-cdeb-402c-a063-374d56cff3c4	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1baf	96ef57ec-07ba-4faf-ba16-bfd6464b4e82	dd0e308f-9482-4753-9ea6-bf04d49559d4	t	150	0	\N	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1bb0	8c6c50f4-ecc0-4aab-9448-986d1e033abc	2eb74dc4-86a4-491b-bdb4-4ead9f61074b	t	150	1	AVG	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1bb1	f20f6eb7-492f-45b3-90a7-c32ecb6d1e63	00de92ff-6bd3-4f01-80c0-380acbefa1ae	t	150	2	\N	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1bb2	b38cac27-8714-473f-9b61-c9d6990f2e40	de5aa019-e0b2-4294-95b4-cdfb4bb0cccf	t	150	3	MIN	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1bb3	c50bc694-b15a-430d-afff-6e6eb8ceb4cd	5642d645-5dad-42d2-a255-14b88b8b0bb3	t	150	4	\N	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af03-4a03-8a03-0aa0b1ca1bb4	a04238c1-0000-449f-aff0-4f898d5a7466	7908ad88-69e7-440d-b824-b718cc469677	t	150	5	\N	644303fc-d0dd-4f24-8aa6-da28d3dfda29	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2baf	adb84da5-fa94-4c82-ab86-08cb8e0ceee2	dd0e308f-9482-4753-9ea6-bf04d49559d4	t	150	0	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2bb0	21910021-ffa3-4d02-9eec-ff26bdbbf1e1	2eb74dc4-86a4-491b-bdb4-4ead9f61074b	t	150	1	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2bb1	2678c98c-be77-4566-a6aa-7d16afa9dbcb	00de92ff-6bd3-4f01-80c0-380acbefa1ae	t	150	2	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2bb2	30cd99c4-62db-4309-ba3a-d87e371cba9a	de5aa019-e0b2-4294-95b4-cdfb4bb0cccf	t	150	3	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2bb3	2f9359b9-c7aa-40a1-90fa-b66e08bd758b	5642d645-5dad-42d2-a255-14b88b8b0bb3	t	150	4	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af04-4a04-8a04-0aa0b2ca2bb4	9126b5bc-07ae-4953-9127-48269182ee84	7908ad88-69e7-440d-b824-b718cc469677	t	150	5	\N	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af0	4437d46f-db8a-4c75-8267-e8286cae2933	21455064-b26f-477e-a8c5-61fba1cf2b7c	t	210	0	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af1	f9457961-9cdc-498f-a143-2873fdd601df	b64330db-9052-46c7-b5f0-b8de5f214aed	t	150	1	COUNT_UNIQUE_VALUES	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af2	54b150c0-83db-4637-816a-ed2968f608cd	f33c4cd0-c9ea-4dbc-b6df-c19f5948b459	t	150	2	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af3	622d9d55-1b0d-4d7e-a58d-028f907bf5d0	2aa99259-fefd-4c96-8660-029d7eaf7050	t	150	3	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af4	7d68ab58-f225-46be-8072-c84d08197c28	14f2066d-8a1b-4281-b3eb-6837ddccdc3c	t	150	4	PERCENTAGE_EMPTY	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af5	e3aaa099-257b-4880-ad9d-e35043454488	5d6377af-c259-42b8-990f-2aecee76b735	t	150	5	MIN	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af6	c966a0e9-1cea-42f5-b30a-5c892a83162a	f382801e-a486-470c-a0d2-c11adaa2122b	t	150	6	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af7	4a1d5200-3ee8-477a-bc09-feed3946cba8	14efd992-f9df-4e37-9fb8-2fd2706e9cc0	t	150	7	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af8	61a52b79-dad7-4e36-a44b-c59ecabf3c94	cdf1b3a0-2d56-456c-af74-2fa3fecda88e	t	150	8	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af02-4a02-8a02-ae0a1ea11af9	f47e4af5-683c-47d5-b6cd-71a0c7653fcd	496d6527-3e40-47f7-90c2-a961ed6bc61f	t	150	9	\N	12ef8d12-50f1-4b04-88d8-cf955997a7e0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eaf	57da20b7-8e7e-4b93-b5a2-6a75b6bf8a84	608fec74-7af7-4fd2-8ebf-efdff84c5046	t	210	0	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb0	dacbab7f-999f-4f05-bdea-85165908df82	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	t	150	2	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb1	ba81cc25-84f7-4aee-b185-b212059e61da	f0bfd996-8714-435b-960d-94f0b665f931	t	150	3	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb2	ebb13330-a0d1-4d62-a381-cb6b7ee448e6	f152855b-c6b6-4190-b3e3-0a7fbfb88d50	t	150	4	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb3	b56b4344-7caa-476e-9c58-bc342250a05c	19845777-baef-4f8b-a9e0-75f92befc26e	t	150	5	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb4	a9a53b58-45f5-4261-bbb6-d740300cd0fb	9d29a26e-ef11-4808-96ac-6ac7b9705ece	t	150	6	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb5	6ab4db94-9bc9-45fe-aa36-76876520727f	6d4d4bb5-15fc-487b-a824-5b2a81a525ca	t	150	7	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af06-4a06-8a06-ba5ca11a1eb6	6f465d89-0a45-4127-b057-330e63a5751f	dc0189d7-a50a-45f0-88c1-475e8f8a70d4	t	150	8	\N	b906b5b6-1980-4c50-8da9-8d985d2f6053	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af08-4a08-8a08-ba5cba5babf0	fc317ab5-c4ea-4d9e-8d2d-888cb709880d	608fec74-7af7-4fd2-8ebf-efdff84c5046	t	210	0	\N	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af08-4a08-8a08-ba5cba5babf1	e5d58991-d4a1-4be4-bea7-8cf2bbd514b5	9d7a827b-35b3-4776-9ca0-0dfabcdc2e2c	t	150	2	\N	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af08-4a08-8a08-ba5cba5babf2	ad27563d-6c46-4127-8f17-6148af527e5a	19845777-baef-4f8b-a9e0-75f92befc26e	t	150	3	\N	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af08-4a08-8a08-ba5cba5babf3	dc6ecfdc-0a06-4970-a5ca-d91666d2fcb2	9d29a26e-ef11-4808-96ac-6ac7b9705ece	t	150	4	\N	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af08-4a08-8a08-ba5cba5babf4	3df1fbae-d54e-4208-a0c0-7bf08ade8a01	dc0189d7-a50a-45f0-88c1-475e8f8a70d4	t	150	6	\N	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaed	5a6ae9a3-4f37-4863-a30a-751844fc863d	608fec74-7af7-4fd2-8ebf-efdff84c5046	t	210	0	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaee	4f4d43e3-4886-426c-a9b7-cd0122283645	f0bfd996-8714-435b-960d-94f0b665f931	t	150	3	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaef	fcfc0461-7b92-4b35-bba0-7ebca531cb5e	f152855b-c6b6-4190-b3e3-0a7fbfb88d50	t	150	4	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaf0	cffe7a2f-931f-4b59-a2e5-8121cae1f64d	19845777-baef-4f8b-a9e0-75f92befc26e	t	150	5	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaf1	2d0b8297-3143-4977-97ca-59a5f1d2e3a9	9d29a26e-ef11-4808-96ac-6ac7b9705ece	t	150	6	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaf2	fd3ca732-e999-4431-a03d-f4f519e2cb37	6d4d4bb5-15fc-487b-a824-5b2a81a525ca	t	150	7	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af07-4a07-8a07-ba5ca551aaf3	dd170ca5-5475-4ce5-8ec6-87bee51f077c	dc0189d7-a50a-45f0-88c1-475e8f8a70d4	t	150	8	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11a	8a4ce212-05be-44de-91b5-0e0da7eae508	4c01aa1f-28f7-4722-a195-6a44586e91d6	t	150	0	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11b	8b65605b-b0b0-4048-9905-6a985aad76c0	23a8bee0-dd14-4c8e-82ee-fb2203b68836	t	150	1	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11c	34ec9d43-f769-4a94-a62b-5cf2204467e1	40c9821b-3517-4397-951c-441bc1b78472	t	150	2	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11d	7b34a55b-f06e-45fd-9441-3e87f8d2b12f	97af09e7-f632-4982-81e4-ef7a50d16d84	t	150	3	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11e	092ede18-bf6d-4882-9992-6e655aa122c7	ed3a3450-95cb-4a65-b945-949f7a018da4	t	150	4	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af09-4a09-8a09-a0bcf10aa11f	a0b5dcc2-3a89-41c8-a8c0-0d0688ae0357	8a6db815-72ac-4c30-a068-6e25e1e799ae	t	150	5	\N	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af11-4a11-8a11-a0bcf10abcaf	37fe8ea5-7d64-4e5b-af09-f4e26b47553a	2d5c5097-d9f2-407e-95a6-45ddd91f674f	t	150	0	\N	d0b30e3c-eee2-4f31-841d-5798e473bb33	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af11-4a11-8a11-a0bcf10abcb0	c968a28d-24b6-4baa-8ea8-899c7df63678	a29232bd-cadb-42ba-90e8-b0a18121f675	t	150	1	\N	d0b30e3c-eee2-4f31-841d-5798e473bb33	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af11-4a11-8a11-a0bcf10abcb1	e4db5610-35d1-4f22-8c92-4f1e706b1cea	1cd7d5b1-2f94-4b5c-8310-8f1ea6cf8d88	t	150	2	\N	d0b30e3c-eee2-4f31-841d-5798e473bb33	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
980da288-f186-4f70-a8b3-6288c2c9f223	e62b6043-1815-4bf9-924a-c72f9a752c8b	e7b8f0eb-d5af-43a5-b01e-b0c607b833b9	t	180	0	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
48252cc5-5dc3-4f50-b329-11d108ca0455	224f5dfa-6dc9-4251-82ca-651ba58ad86b	9d775c6d-ba99-4ab8-9385-c9c315026d88	t	180	1	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
3727f88f-737d-433a-b5f8-24db47843cfc	549e705e-4166-442a-8989-fe1c8eba4708	ccd51550-64be-49b4-a593-0b0048b79e2a	t	180	2	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
a47dae01-2a5e-4bf4-b636-3b0c51ae2718	457b9a64-159b-4fdf-90a6-48ff0578fa4c	70bbf161-fa08-4e74-bcdf-946523d54930	t	180	3	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
ea779bb4-7d57-4bc1-8195-c1dc5d166676	97e5010e-2738-4329-b0f0-d68dba9bfd1d	8d88839b-7de7-4968-b57d-b0afe4339f32	t	180	4	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
c8bb02ae-60b6-4ddb-8acc-3d2fcf08c85f	2073465c-cbe6-41b1-afb6-39f8f92c841f	07954832-740c-456d-ba83-e16522c0fa5d	t	180	5	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
347404ac-394f-4a59-b378-eb0397ff2c74	5bfb1719-0367-4a16-8f5e-b9d5a7fb83eb	e14176e8-734a-406e-9da0-332b5c074e23	t	180	6	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
22bb3261-7085-4701-8b2d-bf463c47f03d	9d9e15e5-f98e-49d0-a7a0-7a1ac4b5fd12	90922d68-8d3a-4487-aef5-e7bdda1dd5b6	t	180	7	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
e949a971-90f8-4bd8-bd1c-92d18be88ee7	729e7bfd-ffcc-4f91-9801-9da6e345cfbf	72667c22-8636-48ee-9f8b-50b3eafa43e2	t	180	8	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
e34eb1e6-2825-44ba-9dc5-cdc5383f44bb	f0e6f14b-0f21-496c-91d0-bd51bb7a4107	dbd5cea3-f490-496f-a576-a0753d234602	t	180	9	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
f2031f88-9e6f-415b-93b6-4143d6615447	00bea50f-1a39-4e51-91d4-7cf36cb1fa01	eac85a0e-7eb5-4699-8b58-1a1a9652bbdd	t	180	10	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
fef73089-88fd-4005-907f-ce5b20df0fc5	026c0853-6168-4562-9ef9-8eb54f8c358a	df576a0a-64ce-4e39-86e8-5539afed1ebc	t	180	11	\N	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:19:34.496+00	2026-02-28 05:19:34.496+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
c573b010-dfca-4744-9a66-a7c95807f80d	ca99c053-663a-4708-b247-d3fd50ef0953	67ce61ef-73a8-47ee-85e7-390db6fadb9a	t	180	0	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
2909dd65-ae97-4406-9eaf-99f2d76101b0	31ae5b90-1fd4-4046-a62c-dbc67d5abc76	2d2fb0bb-695e-4b59-9257-e168acf725b9	t	180	1	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
12817b1e-d3fe-441f-a6e7-4134f97529b5	9bf4f6c1-eb9f-4787-8c5e-d887dca9dfe0	f0433ca0-a931-444f-b8e0-18f078bb3151	t	180	2	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
d49b19d1-1b02-4fdf-8fdd-08fee5a2ae23	f29faf54-805a-4817-bda8-2407ddea8602	6b778324-ad5b-44c4-bc23-ed2c23464587	t	180	3	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
eec116ac-0328-49fb-b0e8-fb82862ef510	1bdb346f-17e7-4cb8-a181-c8a171590b36	c37c131f-05dd-417c-a7ac-eb37079bf14f	t	180	4	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
37a13dc0-143e-4f7b-80bf-ecfe0adeab3a	e7d22ee3-c5cd-4086-b197-5057db62cfae	5a070a05-830e-4fc4-bffa-5eeed521f5da	t	180	5	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
e38f49c9-3db6-41a6-ad5b-26e2550fbfe2	88c96110-7538-40d2-ba70-282107631d0f	0a9e5328-f462-48f6-9842-e54040239c76	t	180	6	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
4186d046-e9a4-4532-94a9-7ca7ebef20b8	e3f1a134-c709-4960-a3ad-a60e2647439b	645b40a3-5284-420c-9333-d1de7d0f7cc8	t	180	7	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
8b1fe9b5-44ae-4da4-970b-5cdf72075630	47eeb853-7210-4e55-92fa-2b379ca72d32	feb6d0e4-72d7-436c-8798-c0b956192a73	t	180	8	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
2cd8de93-3e74-4f83-9be7-0a5c49d63cfc	46deeb87-e4e3-46ab-a5ea-54a422a26304	fdebecdd-c8a0-493a-ad94-687492a637d9	t	180	9	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
4eac93c3-32fa-4370-a211-24de4af33d13	16760952-9055-466b-8ff4-443cd7bbe6a7	ba0eb8f0-8517-466d-af89-c3ec7dd42949	t	180	10	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
c28a5ced-8f30-4fce-a441-94b222097bb9	002e5f25-bd8b-4e82-b74f-0eeba6e5cf2f	64e404c9-1550-4cb5-9f05-dc5f082d03ea	t	180	11	\N	11d36386-2b79-4923-a08e-b996cb3df940	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:53:09.688+00	2026-02-28 05:53:09.688+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
32b50b73-161a-42c9-bdc7-7abfef3a8249	169bd9bb-4e93-481e-a9c7-b88e37c30307	1c1291f6-1047-4609-927d-24218ec3a392	t	180	1	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
1ad4765b-f15d-4d28-826a-2fd4697c94d0	6233d41d-5831-47f6-b257-caae11bfdeb1	91900025-c565-460d-be3e-86c4a7b9e465	t	180	4	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
d2956008-f389-4b8e-9f04-345432c4cef5	e530a7a5-b869-4283-a14f-6070c19888c7	515e91cf-5cf5-4e57-a7e3-8489c188e558	t	180	5	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
90b0bf65-cae5-4a19-89b7-cc8cca5d1999	3e8e5197-89e4-4554-add4-00a3d2633e32	47629a92-4307-460a-a256-503950184789	t	180	6	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
d9d2ab51-c81a-4c03-90b5-5ecfe7d11bb3	50c00114-730c-4d9f-8fbe-a3777ca7a3c1	5406aa36-178e-470b-9f17-817697b93d8e	t	180	7	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
9976c7a2-16cf-4cc8-9b8b-d98353e3dfa5	9eaea647-65bc-4324-a26a-ebc58d8d0872	4ca264c6-e9f6-49a1-87c0-b49bf44ce205	t	180	8	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
87b75476-96c8-4b4c-a415-b886646cdfdc	dd7c1715-4b49-48f7-b5cb-0308393c5ab0	ea13638f-0f07-49e9-91a3-c6f2a1736951	t	180	9	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
c7cdc1e4-7893-4242-9276-638f2c9c99a2	d1c7afd4-9a20-4de2-8ce9-aad45899796c	434038b5-057e-492c-9e95-8de7caab39ac	t	180	10	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
649c0862-9bbd-448a-908d-32f8b65fefce	255e601f-d324-470c-ad34-9fb86ddeb10d	4ae9f935-cf92-4828-947c-c74cb4ea89c3	t	180	11	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 06:14:51.762+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
f5192e1e-d6f5-44f4-9c94-4101b26a1c94	12df2812-6b0f-47de-b715-5eeb72d4054f	b57d57cb-65e6-4b2d-aea8-bc10d22b66d4	t	100	0.5	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:49:30.896+00	2026-02-28 06:49:58.179578+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
fc01398a-1afc-4cb8-96a0-13c888eca479	c5cfd18f-f895-488f-bb63-566fddde1c91	044735bf-c886-450b-ae9d-fa4f03eca30b	t	109	0	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 11:00:46.771284+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
b1ef1e3e-4c40-4cf9-86e4-5fada88a2e92	43a04ae2-a7b5-4142-961f-11bfede52157	30fbbac7-01f7-4c6c-94a6-c60e3d9b0f19	t	100	1.5	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:49:33.5+00	2026-02-28 06:50:10.173667+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
41cdbeda-7bb9-4d51-b258-bf8003f1eb04	f03fcf06-efef-4360-83b6-5c043d04e8aa	4bf15d7b-5629-42ca-bcd0-7c1bf2a0d833	t	159	0.25	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:49:32.303+00	2026-02-28 06:50:15.457413+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
aad3db1d-a58e-4c36-a3ff-4be7d3480a51	296a37b8-420a-4006-bf42-b2dd62e23aef	dbd2a7f1-8a29-46a6-93f5-79512d201f4a	t	180	0	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
a5a0d631-8839-4416-a1ce-226def408ff0	334bd5fc-2e07-430b-8406-3f4c384281e4	0325d646-7e2c-47b7-9457-9b1daba695d7	t	180	1	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
7c580be3-b13d-4461-b1e5-84f658582794	3b21cea0-dcc9-456d-a6bb-15ddc5674ff0	8a2441b1-6d99-4b16-999d-87a0508a82be	t	180	2	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
bd2a07c3-7010-4390-83d7-66c4fdcff627	a9d57e89-abd3-4de3-ad25-40e15de6e0a1	66972d5b-9044-4dc5-a909-daf2b2cb2965	t	180	3	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
1f9e4ad1-6b01-48a2-8c8d-aa4cbbedc12f	ffff1489-55b3-466f-a4ac-73eab48b4494	f0212328-7cec-4a56-aa21-ca6849970ae0	t	180	4	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
aaa05a0a-9e8c-4c88-b69a-fc79c8e0df47	2270fb8d-5b1e-4503-8a62-592d9f58dd5a	907afb89-5a3a-40b6-b76d-94f715ba0dec	t	180	5	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
09f36426-a79f-4527-a0ff-63fd6bd5b999	7b5b7b6c-a460-4414-9840-d1e84c2a1375	59839cd2-8657-4498-85b7-47905db69243	t	180	6	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
c6482dfe-33a2-4aa2-a7ec-5f7788cf4ce9	5d727bd6-b7d0-444f-bcf4-0939a198c7e8	baebbf93-4992-480c-bc1c-4b9f78b34791	t	180	7	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
4b8e0a51-21dc-46a2-be14-31979453789d	67ac54bc-f14a-4958-b1ed-69da863b9a5d	b04547af-637e-4903-9e10-0e6725752456	t	180	8	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
54a628f9-632d-4e00-9077-7b6ed3f2d422	2f599d68-adca-4339-825a-9f02ca2f1658	d74b57a2-7ba7-43ff-a101-4068fe589bef	t	180	9	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
173ea165-7191-4a67-b7f7-80b1d7848ecd	81857212-e18b-49cd-a755-1e764f96dcf4	0a341445-c5c2-4b2a-a0ff-f70d33280c24	t	180	10	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
359ba7e6-a21c-45f6-998f-4dc58b0e9230	4e64370a-0311-42f5-a58f-f4d34e4e08fd	837d252f-8b22-4183-965f-e3be0f0877c4	t	180	11	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:54:36.869+00	2026-02-28 06:54:36.869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
51a3fc3b-5ae6-400f-a26c-b9eafab0ee7b	f98afea9-7f1f-46d1-85f5-852d337c4552	7ee83b05-c96b-4a33-a421-d06fe9c7be98	t	147	0.25	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:59:48.233+00	2026-02-28 06:59:58.186878+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
9bdd1100-fef0-44b9-a57e-5c6e90cec362	ebd4c7cc-4f11-4f73-98d9-0ad1ac626ca8	7a73ab40-8501-4059-9391-c0adf9785eef	t	167	0.5	\N	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:59:47.246+00	2026-02-28 07:00:00.043747+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
3ed7595b-c34e-468c-bba0-5e10c7e4185e	7d8670b6-7923-42a3-b069-37c45c1f2cbe	7fedae9f-b476-4b71-b295-9e9603872484	t	100	0.125	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 07:34:54.002+00	2026-02-28 11:00:23.164143+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
69a9d6de-dc94-4573-ae5e-b258fe17f533	c098d842-916f-439c-ba22-a6dd28bcc08f	4042f6ba-f103-4553-804f-666b73983602	t	100	0.625	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 07:34:54.885+00	2026-02-28 11:00:37.045264+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
8dafc0a9-3dfd-4f46-bffa-5a44f8ede33c	f6709ac9-70f1-42aa-939a-43e76975e88e	c0618af3-c06b-4a1e-86d5-24fa8475d288	t	152	0.75	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:49:34.608+00	2026-02-28 11:00:43.44949+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
58722a56-6fbf-4cce-971a-33db0ff1dd19	64fccb42-0a74-4046-b378-7a137a34e880	e8086330-01e9-469d-81e6-703229f170b0	t	134	3	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 11:00:53.690396+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
56c19a66-6d12-469e-82d4-bc91e1477994	ad51fdec-a030-4700-b600-8315bfa3994e	3f005c6b-4dba-448f-a954-ca1e8ec8b942	t	134	2	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:14:51.762+00	2026-02-28 11:00:55.609855+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
dfd924bb-2e06-451e-a854-d77b8c15d8f9	134695f7-7429-421a-a87c-d44a5444d662	618c4c90-f9cd-4f26-b966-a91852aa5ef1	t	152	15	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 09:56:46.5+00	2026-03-02 13:43:25.957841+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
581aa696-388a-46b1-8878-056abf10c7aa	3a776efe-9e99-4be1-935f-39aa1d203b74	cf3c96f5-7a25-42e0-b270-f8276b6d1660	t	191	14	\N	84e44f0f-b8d5-4fd0-a252-e81e32893673	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 09:53:52.932+00	2026-03-02 13:43:27.974869+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
\.


--
-- Data for Name: viewFilter; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."viewFilter" ("universalIdentifier", id, "fieldMetadataId", operand, value, "viewFilterGroupId", "positionInViewFilterGroup", "subFieldName", "viewId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "applicationId") FROM stdin;
20202020-af17-4a07-8a07-ba5ca551abf1	7a3d32ac-1415-40c8-9590-e311f7ba3cb3	9d29a26e-ef11-4808-96ac-6ac7b9705ece	IS	"{\\"isCurrentWorkspaceMemberSelected\\":true,\\"selectedRecordIds\\":[]}"	\N	\N	\N	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
09bdbb9f-894f-4df7-82ea-46225826ce9d	df737196-4d8a-490a-b845-0d69cd709688	9d29a26e-ef11-4808-96ac-6ac7b9705ece	IS	{"selectedRecordIds": ["fed85579-aad3-4bca-b301-f877957b8c40"]}	\N	\N	\N	4d3c9f01-dea1-4481-a2ac-edace2eb9169	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
ccdd4561-f46f-4172-ba92-3cb11d00986a	554757ac-d978-4ebe-a064-3873bca2abc3	9d29a26e-ef11-4808-96ac-6ac7b9705ece	IS	{"selectedRecordIds": ["0f7c9c48-c43e-4010-b786-87fad4ebfb47"]}	\N	\N	\N	540188fc-4dcb-4c72-8a76-722b09bad285	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	bbb719d5-4626-40d6-aec6-7d53f24e5459
\.


--
-- Data for Name: viewFilterGroup; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."viewFilterGroup" ("universalIdentifier", id, "parentViewFilterGroupId", "logicalOperator", "positionInViewFilterGroup", "viewId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "applicationId") FROM stdin;
\.


--
-- Data for Name: viewGroup; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."viewGroup" ("universalIdentifier", id, "isVisible", "fieldValue", "position", "viewId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "applicationId") FROM stdin;
20202020-af14-4a04-8a04-0aa0b2ca2bf1	c51c358c-93b2-4e4c-bdc2-51fd93a9e8d7	t	NEW	0	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af14-4a04-8a04-0aa0b2ca2bf2	9e7099f7-3595-414b-9f32-a046f1b1db3d	t	SCREENING	1	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af14-4a04-8a04-0aa0b2ca2bf3	3ae9984e-fd5c-429b-9b97-80727e8a1f39	t	MEETING	2	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af14-4a04-8a04-0aa0b2ca2bf4	73ef5d32-eeed-43ae-8ce1-b2834f8ce3e8	t	PROPOSAL	3	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af14-4a04-8a04-0aa0b2ca2bf5	64084292-901e-4918-aecb-3cb027388610	t	CUSTOMER	4	57e505bc-2cb5-404f-ade5-a310e925f0cb	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af17-4a07-8a07-ba5ca551abf2	af2f81cf-a253-44ee-bf4d-43fdc36d725d	t	TODO	0	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af17-4a07-8a07-ba5ca551abf3	7bb41336-0268-4d21-80a1-2c4a94e87151	t	IN_PROGRESS	1	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af17-4a07-8a07-ba5ca551abf4	a9c791e0-66b7-4435-86f7-894e0011374c	t	DONE	2	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af17-4a07-8a07-ba5ca551abf5	3ddfdf9c-8a49-4e2c-8d7c-ee07a97b4ace	t		3	8d4e69c5-e680-49ea-b6fa-3b9642c2a7c6	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af18-4a08-8a08-ba5cba5bbf01	d9a01504-1666-4ea4-8783-e415d5d160fa	t	TODO	0	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af18-4a08-8a08-ba5cba5bbf02	fb04e5b7-9460-4804-9908-c17a5d1ae61e	t	IN_PROGRESS	1	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
20202020-af18-4a08-8a08-ba5cba5bbf03	1c8e1675-a99c-4f29-ad8b-2cbde493a636	t	DONE	2	5b7c4977-fad2-4b71-9aff-a50dbbf197c0	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 05:07:16.392+00	2026-02-28 05:07:16.392+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
d6c5c837-4463-499b-8292-2164860ee0f1	d6c5c837-4463-499b-8292-2164860ee0f1	t	TODO	0	4d3c9f01-dea1-4481-a2ac-edace2eb9169	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
a728a27e-9213-49f5-98d3-59a6845fa68e	a728a27e-9213-49f5-98d3-59a6845fa68e	t	IN_PROGRESS	1	4d3c9f01-dea1-4481-a2ac-edace2eb9169	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
a3fc1134-0faf-4b86-984d-d87465ce0c1c	a3fc1134-0faf-4b86-984d-d87465ce0c1c	t	DONE	2	4d3c9f01-dea1-4481-a2ac-edace2eb9169	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
4fe1a16d-a744-4597-a069-eb26d7cd08c5	4fe1a16d-a744-4597-a069-eb26d7cd08c5	t		3	4d3c9f01-dea1-4481-a2ac-edace2eb9169	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:06:58.966+00	2026-02-28 06:06:58.966+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
e63772a7-3c12-492e-ab11-982a9980d2e1	e63772a7-3c12-492e-ab11-982a9980d2e1	t	TODO	0	540188fc-4dcb-4c72-8a76-722b09bad285	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
b032f7e6-5526-4686-8d8d-0757207eb50c	b032f7e6-5526-4686-8d8d-0757207eb50c	t	IN_PROGRESS	1	540188fc-4dcb-4c72-8a76-722b09bad285	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
196be2af-45a4-45c1-b72b-bb486afd0e6f	196be2af-45a4-45c1-b72b-bb486afd0e6f	t	DONE	2	540188fc-4dcb-4c72-8a76-722b09bad285	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
6fedf45a-1739-476d-a426-9e6196dc983c	6fedf45a-1739-476d-a426-9e6196dc983c	t		3	540188fc-4dcb-4c72-8a76-722b09bad285	a8cf39ab-a363-48fd-8960-096055b51144	2026-02-28 06:08:58.768+00	2026-02-28 06:08:58.768+00	\N	67affcc3-762a-4fee-baa4-2a048ddd621e
\.


--
-- Data for Name: viewSort; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."viewSort" ("universalIdentifier", id, "fieldMetadataId", direction, "viewId", "workspaceId", "createdAt", "updatedAt", "deletedAt", "applicationId") FROM stdin;
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.webhook (id, "targetUrl", operations, description, secret, "workspaceId", "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- Data for Name: workspace; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core.workspace (id, "displayName", logo, "inviteHash", "deletedAt", "createdAt", "updatedAt", "allowImpersonation", "isPublicInviteLinkEnabled", "activationStatus", "metadataVersion", "databaseUrl", "databaseSchema", subdomain, "customDomain", "isGoogleAuthEnabled", "isTwoFactorAuthenticationEnforced", "isPasswordAuthEnabled", "isMicrosoftAuthEnabled", "isCustomDomainEnabled", "defaultRoleId", version, "trashRetentionDays", "routerModel", "isGoogleAuthBypassEnabled", "isPasswordAuthBypassEnabled", "isMicrosoftAuthBypassEnabled", "workspaceCustomApplicationId", "editableProfileFields", "fastModel", "smartModel") FROM stdin;
a8cf39ab-a363-48fd-8960-096055b51144	SFS-CRM	\N	7fc05642-3a59-4a0f-8de4-c5fa017c5d4b	\N	2026-02-28 05:07:08.544413+00	2026-03-02 20:07:46.433978+00	t	t	ACTIVE	61			excellent-silver-raccoon	\N	t	f	t	t	f	9b10f843-22ed-4429-ba95-c218fea6be03	\N	14	auto	f	f	f	bbb719d5-4626-40d6-aec6-7d53f24e5459	{email,profilePicture,firstName,lastName}	default-fast-model	default-smart-model
\.


--
-- Data for Name: workspaceSSOIdentityProvider; Type: TABLE DATA; Schema: core; Owner: -
--

COPY core."workspaceSSOIdentityProvider" (id, name, status, "workspaceId", "createdAt", "updatedAt", type, issuer, "clientID", "clientSecret", "ssoURL", certificate, fingerprint) FROM stdin;
\.


--
-- Data for Name: _customer; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer (id, name, "createdAt", "updatedAt", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "deletedAt", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "position", "emailsPrimaryEmail", "emailsAdditionalEmails", "phonesPrimaryPhoneNumber", "phonesPrimaryPhoneCountryCode", "phonesPrimaryPhoneCallingCode", "phonesAdditionalPhones", "whatsappPrimaryPhoneNumber", "whatsappPrimaryPhoneCountryCode", "whatsappPrimaryPhoneCallingCode", "whatsappAdditionalPhones", "companyName", "jobTitle") FROM stdin;
44abda2f-63bb-46d2-8ece-aca83bd763f2	Customer1	2026-02-28 06:58:08.170511+00	2026-02-28 06:59:35.914726+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	0	bdsdf@yopmail.com	\N	9999999999	IN	+91	\N				\N	\N	\N
f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	Ajith Imprezz	2026-02-28 08:11:06.376955+00	2026-02-28 08:11:06.376955+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-1	ajith@imprezz.com	\N	9824502345		+91	\N				\N	\N	\N
2c64656e-5c10-42d2-ba37-2782908d61b5	New Customer	2026-02-28 12:29:04.940271+00	2026-02-28 12:29:04.940271+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-2	customer@inceptra.com	\N	9898989898		+91	\N				\N	\N	\N
46cd7e38-be9c-4a3b-9e18-856cbd1c4390	Jane Doe	2026-03-01 20:51:52.156298+00	2026-03-01 20:51:52.156298+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-3	jane.doe@example.com	\N	5551234567		+1	\N	5559876543		+1	\N	Acme Inc	Marketing Director
\.


--
-- Data for Name: _lead; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead (id, name, "createdAt", "updatedAt", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "deletedAt", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "position", "originId", "propertyId", "assigneeId", "dueDate", "customerId", status, body, "notesBlocknote", "notesMarkdown", "convenientTime", "buildingType", "readAt") FROM stdin;
a162cbac-1ab1-49db-9aaf-effa83715fb7	SFS-9	2026-03-01 20:52:35.783277+00	2026-03-01 20:53:46.233762+00	API	\N	Webhook API Key	{}	2026-03-01 20:53:46.233762+00	API	\N	Webhook API Key	{}	-10	2e5c95af-4a46-44c7-8f68-a1de1e3bf938	45f84f36-3c11-48eb-ae87-b5e10e8730bc	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-03-15 18:00:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NEW	Interested in 3-bedroom units. Prefers move-in by end of month.	[{"id":"e96d3463-678f-4027-ad1d-2c80096dc6f1","type":"paragraph","props":{"textColor":"default","backgroundColor":"default","textAlignment":"left"},"content":[{"type":"text","text":"Interested in 3-bedroom units. Prefers move-in by end of month.","styles":{}}],"children":[]}]	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	\N
b0b4087a-75c0-40af-b963-9c7c38fcf283	SFS-1	2026-02-28 09:21:34.443031+00	2026-02-28 10:20:28.261311+00	API	\N	Webhook API Key	{}	2026-02-28 10:20:28.261311+00	API	\N	Webhook API Key	{}	-4	b3bae279-4406-406e-a5b0-ac525cddaac0	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-02 09:21:34.431+00	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	NEW	First floor	\N	\N	\N	\N	\N
84a0e3b1-7abf-49b9-9763-013ca66a2a4a	SFS-4	2026-02-28 12:29:05.78787+00	2026-02-28 13:19:43.398945+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	API	\N	Webhook API Key	{}	-5	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-02 12:29:04.98+00	2c64656e-5c10-42d2-ba37-2782908d61b5	NEW	Last floor	[{"type":"paragraph","content":[{"type":"text","text":"notes"}]}]	notes\n	\N	\N	\N
e98585c1-ca96-4f8f-bca6-fd330c97c4ac	SFS-5	2026-02-28 12:29:28.939961+00	2026-02-28 14:10:01.496228+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	API	\N	Webhook API Key	{}	-6	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-03-02 12:29:28.92+00	2c64656e-5c10-42d2-ba37-2782908d61b5	NEW	Last floor	[{"type":"paragraph","content":[{"type":"text","text":"kooppite kidaykale"}]},{"type":"paragraph"}]	kooppite kidaykale\n	\N	\N	\N
05d4880c-36c3-414d-9b29-f73bda42aaec	Lead -SFS#12	2026-02-28 06:45:27.733879+00	2026-02-28 10:58:20.543198+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	2026-02-28 10:58:20.543198+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	0	035787f5-659e-46a8-b668-005c6ba474d3	dfa27ca1-3364-4db9-a452-fe739549a64f	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-14 06:52:00+00	44abda2f-63bb-46d2-8ece-aca83bd763f2	NEW	\N	\N	\N	\N	\N	\N
057ebbdb-4ef3-4e94-aad3-b64b4c76937f	SFS-1	2026-02-28 08:05:18.579248+00	2026-02-28 10:58:20.543198+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	2026-02-28 10:58:20.543198+00	API	\N	Webhook API Key	{}	-1	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2025-02-04 11:12:34+00	\N	NEW	Top floor	\N	\N	\N	\N	\N
35198393-bf74-4028-af38-1678b988bfb8	SFS-1	2026-02-28 08:11:55.017571+00	2026-02-28 10:58:20.543198+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	2026-02-28 10:58:20.543198+00	API	\N	Webhook API Key	{}	-2	b3bae279-4406-406e-a5b0-ac525cddaac0	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2025-02-10 11:12:34+00	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	NURTURE	Top floor	\N	\N	\N	\N	\N
6b81024c-279e-44de-aa15-5306e2d120c0	SFS-7	2026-02-28 13:17:47.297934+00	2026-02-28 14:13:30.017935+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	API	\N	Webhook API Key	{}	-8	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-03-02 13:17:47.242+00	2c64656e-5c10-42d2-ba37-2782908d61b5	CONTACTED	new teset body floor	[{"type":"paragraph","content":[{"type":"text","marks":[{"type":"bold"}],"text":"new teset body floor"}]},{"type":"paragraph","content":[{"type":"text","text":"test check"}]},{"type":"paragraph","content":[{"type":"text","text":"nnosdfsdf"}]},{"type":"paragraph"}]	new teset body floor\n\ntest check\n\nnnosdfsdf\n	\N	\N	\N
4c973eb6-271c-4d6d-98f4-6e6917007989	SFS-3	2026-02-28 11:49:51.185123+00	2026-03-02 13:36:16.543646+00	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	\N	API	\N	Webhook API Key	{}	-4	b3bae279-4406-406e-a5b0-ac525cddaac0	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-07 03:49:00+00	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	NURTURE	Last floor	[{"type":"paragraph","content":[{"type":"text","text":"Last floor"}]},{"type":"paragraph"},{"type":"paragraph","content":[{"type":"text","marks":[{"type":"link","attrs":{"href":"https://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php","target":"_blank","rel":"noopener noreferrer nofollow","class":null}}],"text":"https://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php"}]},{"type":"paragraph"}]	Last floor\n\nhttps://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php\n	\N	\N	2026-03-02 13:35:12.036+00
3b5706ba-017b-4ee4-a479-366723c49fe1	SFS-5	2026-02-28 10:31:13.366409+00	2026-03-02 13:34:06.114422+00	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	\N	API	\N	Webhook API Key	{}	1	b3bae279-4406-406e-a5b0-ac525cddaac0	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-02 10:31:12.534+00	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	NURTURE	First floor	[{"type":"paragraph","content":[{"type":"text","text":"First floor"}]},{"type":"paragraph","content":[{"type":"text","text":"dsfsdf"}]}]	First floor\n\ndsfsdf\n	\N	\N	2026-03-02 13:34:06.021+00
3753e5b0-63b1-4ba1-a3b7-cd7173d22be3	SFS-8	2026-03-01 20:51:53.147605+00	2026-03-01 20:53:46.233762+00	API	\N	Webhook API Key	{}	2026-03-01 20:53:46.233762+00	API	\N	Webhook API Key	{}	-9	2e5c95af-4a46-44c7-8f68-a1de1e3bf938	\N	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-15 18:00:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NEW	Interested in 3-bedroom units. Prefers move-in by end of month.	[{"id":"c95313dc-00ee-46e5-88e9-57c492b4fbad","type":"paragraph","props":{"textColor":"default","backgroundColor":"default","textAlignment":"left"},"content":[{"type":"text","text":"Interested in 3-bedroom units. Prefers move-in by end of month.","styles":{}}],"children":[]}]	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	\N
a289e87f-414e-4a22-947f-01813ca96994	SFS-11	2026-03-02 13:41:29.046597+00	2026-03-02 13:41:29.046597+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-12	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-03-04 13:41:29.036+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NEW	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	2026-03-05T14:00:00.000Z	\N	\N
a77906bb-228b-451b-9005-c470d71b7361	SFS-8	2026-03-01 20:54:00.645447+00	2026-03-01 21:28:10.426983+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	API	\N	Webhook API Key	{}	-9	035787f5-659e-46a8-b668-005c6ba474d3	45f84f36-3c11-48eb-ae87-b5e10e8730bc	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-15 18:00:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NURTURE	Interested in 3-bedroom units. Prefers move-in by end of month.	[{"id":"8b12df4b-77b7-4ee3-9f10-d423bfdaf727","type":"paragraph","props":{"textColor":"default","backgroundColor":"default","textAlignment":"left"},"content":[{"type":"text","text":"Interested in 3-bedroom units. Prefers move-in by end of month.","styles":{}}],"children":[]}]	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	\N
bd4044b5-6645-4d44-8231-339d15ff7f83	SFS-9	2026-03-02 09:12:58.748609+00	2026-03-02 09:12:58.748609+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-10	035787f5-659e-46a8-b668-005c6ba474d3	45f84f36-3c11-48eb-ae87-b5e10e8730bc	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-03-15 18:00:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NEW	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	2026-03-05T14:00:00.000Z	\N	\N
06a6126a-bc17-4585-8995-9e7d2a08895c	SFS-10	2026-03-02 09:13:29.253117+00	2026-03-02 09:13:29.253117+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-11	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-15 18:00:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	NEW	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	2026-03-05T14:00:00.000Z	\N	\N
fbe732b6-e0fd-490b-bcaf-2637143d830a	SFS-6	2026-02-28 12:29:41.778434+00	2026-03-02 09:27:38.693907+00	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	\N	API	\N	Webhook API Key	{}	-7	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-03 12:29:00+00	2c64656e-5c10-42d2-ba37-2782908d61b5	NURTURE	Last floor	[{"type":"paragraph","content":[{"type":"text","text":"Last floor"}]},{"type":"paragraph","content":[{"type":"text","text":"jkkjhn"}]},{"type":"paragraph","content":[{"type":"text","text":"knkjn"}]},{"type":"paragraph"}]	Last floor\n\njkkjhn\n\nknkjn\n	\N	\N	\N
0e16dbd1-46c9-438f-8687-59175d12b796	SFS-1	2026-02-28 08:45:02.215571+00	2026-03-02 19:57:12.300765+00	MANUAL	0f7c9c48-c43e-4010-b786-87fad4ebfb47	Arjun S	{}	\N	API	\N	Webhook API Key	{}	-3	b3bae279-4406-406e-a5b0-ac525cddaac0	43432eab-1591-487c-9bcc-ba6d3d5b4057	0f7c9c48-c43e-4010-b786-87fad4ebfb47	2025-02-10 11:12:34+00	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5	CONTACTED	First floor	\N	\N	\N	\N	2026-03-02 19:57:12.262+00
f8fe9937-8069-4e4d-bdc2-c5e35d7510c2	SFS-12	2026-03-02 14:25:19.762774+00	2026-03-02 19:39:59.932516+00	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	\N	API	\N	Webhook API Key	{}	-13	035787f5-659e-46a8-b668-005c6ba474d3	43432eab-1591-487c-9bcc-ba6d3d5b4057	fed85579-aad3-4bca-b301-f877957b8c40	2026-03-13 17:30:00+00	46cd7e38-be9c-4a3b-9e18-856cbd1c4390	CONVERTED	Interested in 3-bedroom units. Prefers move-in by end of month.	\N	\N	2026-03-05T14:00:00.000Z	\N	2026-03-02 14:45:41.066+00
\.


--
-- Data for Name: _origin; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin (id, name, "createdAt", "updatedAt", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "deletedAt", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "position") FROM stdin;
035787f5-659e-46a8-b668-005c6ba474d3	Google	2026-02-28 06:04:23.627667+00	2026-02-28 06:04:30.282395+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	0
b3bae279-4406-406e-a5b0-ac525cddaac0	Meta	2026-02-28 06:04:41.012308+00	2026-02-28 06:04:47.867227+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	-1
8d8a3fc8-c19a-4a60-adc9-fa712a9ef850	Web	2026-02-28 07:27:20.506365+00	2026-02-28 07:27:20.506365+00	API	\N	Webhook API Key	{}	\N	API	\N	Webhook API Key	{}	-3
7e19892e-5b93-4c35-974f-b4b235ba12f0	Website	2026-02-28 06:04:49.23266+00	2026-03-01 20:53:28.805072+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	2026-03-01 20:53:28.805072+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	-2
2e5c95af-4a46-44c7-8f68-a1de1e3bf938	website	2026-03-01 20:51:52.214158+00	2026-03-01 20:53:28.805072+00	API	\N	Webhook API Key	{}	2026-03-01 20:53:28.805072+00	API	\N	Webhook API Key	{}	-4
\.


--
-- Data for Name: _property; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis._property (id, name, "createdAt", "updatedAt", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "deletedAt", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "position", "locationAddressStreet1", "locationAddressStreet2", "locationAddressCity", "locationAddressPostcode", "locationAddressState", "locationAddressCountry", "locationAddressLat", "locationAddressLng") FROM stdin;
dfa27ca1-3364-4db9-a452-fe739549a64f	SFS Rhythm	2026-02-28 05:50:58.725938+00	2026-02-28 05:51:27.272117+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	0	Kakkanad	\N	Kochi	\N	Kerala	India	\N	\N
43432eab-1591-487c-9bcc-ba6d3d5b4057	SFS Orchard	2026-02-28 05:51:30.706055+00	2026-02-28 05:51:53.276631+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	-1	Kuravankonam	Marappalam Rd	Thiruvananthapuram	695004	Kerala	India	\N	\N
45f84f36-3c11-48eb-ae87-b5e10e8730bc	SFS Cyber Palms	2026-02-28 05:51:57.309378+00	2026-02-28 05:52:18.870586+00	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	-2	Technopark	\N	Trivandrum	\N	Kerala	India	\N	\N
\.


--
-- Data for Name: attachment; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment (id, "createdAt", "updatedAt", "deletedAt", name, "fullPath", "fileCategory", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "taskId", "noteId", "personId", "companyId", "opportunityId", "dashboardId", "workflowId", "propertyId", "originId", "leadId", "customerId") FROM stdin;
a7889322-0193-4fab-9990-6c62d1a7346b	2026-02-28 11:19:30.337256+00	2026-02-28 11:19:30.337256+00	\N	Screenshot 2026-02-10 at 12.11.28 AM.png	attachment/681b5b4c-8739-4368-beee-828a6faf7a8f.png	IMAGE	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
f6a91a73-2683-4c37-a2bf-762bcc94864e	2026-02-28 12:37:07.146112+00	2026-02-28 12:37:07.146112+00	\N	Screenshot 2026-02-09 at 7.18.41 PM.png	attachment/46ce4fa8-91be-47b8-99e8-4f4d3c2cfdf2.png	IMAGE	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	MANUAL	fed85579-aad3-4bca-b301-f877957b8c40	Vasisht RJ	{}	\N	\N	\N	\N	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
\.


--
-- Data for Name: blocklist; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.blocklist (id, "createdAt", "updatedAt", "deletedAt", handle, "workspaceMemberId") FROM stdin;
\.


--
-- Data for Name: calendarChannel; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel" (id, "createdAt", "updatedAt", "deletedAt", handle, visibility, "isContactAutoCreationEnabled", "contactAutoCreationPolicy", "isSyncEnabled", "syncCursor", "syncStatus", "syncStage", "syncStageStartedAt", "syncedAt", "throttleFailureCount", "connectedAccountId") FROM stdin;
\.


--
-- Data for Name: calendarChannelEventAssociation; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation" (id, "createdAt", "updatedAt", "deletedAt", "eventExternalId", "recurringEventExternalId", "calendarChannelId", "calendarEventId") FROM stdin;
\.


--
-- Data for Name: calendarEvent; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEvent" (id, "createdAt", "updatedAt", "deletedAt", title, "isCanceled", "isFullDay", "startsAt", "endsAt", "externalCreatedAt", "externalUpdatedAt", description, location, "iCalUid", "conferenceSolution", "conferenceLinkPrimaryLinkLabel", "conferenceLinkPrimaryLinkUrl", "conferenceLinkSecondaryLinks") FROM stdin;
\.


--
-- Data for Name: calendarEventParticipant; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant" (id, "createdAt", "updatedAt", "deletedAt", handle, "displayName", "isOrganizer", "responseStatus", "calendarEventId", "personId", "workspaceMemberId") FROM stdin;
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.company (id, "createdAt", "updatedAt", "deletedAt", name, "domainNamePrimaryLinkLabel", "domainNamePrimaryLinkUrl", "domainNameSecondaryLinks", "addressAddressStreet1", "addressAddressStreet2", "addressAddressCity", "addressAddressPostcode", "addressAddressState", "addressAddressCountry", "addressAddressLat", "addressAddressLng", employees, "linkedinLinkPrimaryLinkLabel", "linkedinLinkPrimaryLinkUrl", "linkedinLinkSecondaryLinks", "xLinkPrimaryLinkLabel", "xLinkPrimaryLinkUrl", "xLinkSecondaryLinks", "annualRecurringRevenueAmountMicros", "annualRecurringRevenueCurrencyCode", "idealCustomerProfile", "position", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "accountOwnerId") FROM stdin;
c776ee49-f608-4a77-8cc8-6fe96ae1e43f	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Airbnb	\N	https://airbnb.com	\N	888 Brannan St	\N	San Francisco	94103	CA	United States	\N	\N	5000	\N	\N	\N	\N	\N	\N	\N	\N	f	1	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	\N
f45ee421-8a3e-4aa5-a1cf-7207cc6754e1	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Anthropic	\N	https://anthropic.com	\N	548 Market Street	\N	San Francisco	94104	CA	United States	\N	\N	1100	\N	\N	\N	\N	\N	\N	\N	\N	f	2	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	\N
1f70157c-4ea5-4d81-bc49-e1401abfbb94	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Stripe	\N	https://stripe.com	\N	Eutaw Street	\N	Dublin	\N	\N	Ireland	\N	\N	8000	\N	\N	\N	\N	\N	\N	\N	\N	f	3	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	\N
9d5bcf43-7d38-4e88-82cb-d6d4ce638bf0	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Figma	\N	https://figma.com	\N	760 Market St	Floor 10	San Francisco	94102	\N	United States	\N	\N	800	\N	\N	\N	\N	\N	\N	\N	\N	f	4	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	\N
06290608-8bf0-4806-99ae-a715a6a93fad	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Notion	\N	https://notion.com	\N	2300 Harrison St	\N	San Francisco	94110	CA	United States	\N	\N	400	\N	\N	\N	\N	\N	\N	\N	\N	f	5	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	\N
\.


--
-- Data for Name: connectedAccount; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount" (id, "createdAt", "updatedAt", "deletedAt", handle, provider, "accessToken", "refreshToken", "lastSyncHistoryId", "authFailedAt", "lastCredentialsRefreshedAt", "handleAliases", scopes, "connectionParameters", "accountOwnerId") FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard (id, "createdAt", "updatedAt", "deletedAt", title, "position", "pageLayoutId", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext") FROM stdin;
f31ecf3b-87d3-4e8a-a84b-b6f0f3f8c7e2	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	My First Dashboard	0	61102e6d-8b99-4d2f-b789-338aac15b8a7	SYSTEM	\N	System	{}	SYSTEM	\N	System	{}
\.


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite (id, "createdAt", "updatedAt", "deletedAt", "position", "viewId", "forWorkspaceMemberId", "personId", "companyId", "opportunityId", "workflowId", "workflowVersionId", "workflowRunId", "taskId", "noteId", "dashboardId", "favoriteFolderId", "propertyId", "originId", "leadId", "customerId") FROM stdin;
b0678fc4-30bf-4aef-ae71-b41b6de093d9	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	0	3723a8d2-07ea-4256-83be-e5201a439931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
a831f4a2-a806-446a-88d2-31d2ff641ae4	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	1	23f7f89e-2e1e-4995-898e-49e63c22b8a0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
e07ff68e-7d8b-4133-8734-10ee32dd93d6	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	2	3a15597a-cdeb-402c-a063-374d56cff3c4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190a7d13-3e55-4d08-b8e1-3f6a9ac9f0a1	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	3	644303fc-d0dd-4f24-8aa6-da28d3dfda29	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7c96ac17-e225-4b6d-a297-b92cbbc27b50	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	4	12ef8d12-50f1-4b04-88d8-cf955997a7e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5724e79a-4b39-4d2b-a817-1d9ee13bb9db	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	5	b906b5b6-1980-4c50-8da9-8d985d2f6053	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10dff9cf-b5c7-402f-9231-84c2c48420df	2026-02-28 05:07:17.142164+00	2026-02-28 05:07:17.142164+00	\N	6	3f27dd55-eadf-4d4e-b2a6-6e3224276d67	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5130b092-a3bb-4529-a6e0-8fda7744d48c	2026-02-28 05:19:34.763855+00	2026-02-28 05:19:34.763855+00	\N	7	1d659ecc-515f-4bcf-8b91-665ff3e4a6da	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5902d470-9dc9-4418-8533-84bc57082c7d	2026-02-28 05:53:10.111149+00	2026-02-28 05:53:10.111149+00	\N	8	11d36386-2b79-4923-a08e-b996cb3df940	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
fb2263b6-7285-43d2-88ba-a422c3c0edb1	2026-02-28 06:14:52.150412+00	2026-02-28 06:14:52.150412+00	\N	9	84e44f0f-b8d5-4fd0-a252-e81e32893673	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
a87f4163-f3e9-4499-a163-c5ab1a7d711e	2026-02-28 06:54:37.576889+00	2026-02-28 06:54:37.576889+00	\N	10	925be0ce-9cf6-428d-b5bd-a8e0cde45fa0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
07d33c13-7fcc-4b04-be04-dcc994d75433	2026-02-28 11:52:26.544303+00	2026-02-28 11:52:28.768221+00	2026-02-28 11:52:28.768221+00	1	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
\.


--
-- Data for Name: favoriteFolder; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."favoriteFolder" (id, "createdAt", "updatedAt", "deletedAt", "position", name) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.message (id, "createdAt", "updatedAt", "deletedAt", "headerMessageId", direction, subject, text, "receivedAt", "messageThreadId") FROM stdin;
\.


--
-- Data for Name: messageChannel; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel" (id, "createdAt", "updatedAt", "deletedAt", visibility, handle, type, "isContactAutoCreationEnabled", "contactAutoCreationPolicy", "messageFolderImportPolicy", "excludeNonProfessionalEmails", "excludeGroupEmails", "pendingGroupEmailsAction", "isSyncEnabled", "syncCursor", "syncedAt", "syncStatus", "syncStage", "syncStageStartedAt", "throttleFailureCount", "connectedAccountId") FROM stdin;
\.


--
-- Data for Name: messageChannelMessageAssociation; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation" (id, "createdAt", "updatedAt", "deletedAt", "messageExternalId", "messageThreadExternalId", direction, "messageChannelId", "messageThreadId", "messageId") FROM stdin;
\.


--
-- Data for Name: messageFolder; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder" (id, "createdAt", "updatedAt", "deletedAt", name, "syncCursor", "isSentFolder", "isSynced", "parentFolderId", "externalId", "pendingSyncAction", "messageChannelId") FROM stdin;
\.


--
-- Data for Name: messageParticipant; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant" (id, "createdAt", "updatedAt", "deletedAt", role, handle, "displayName", "messageId", "personId", "workspaceMemberId") FROM stdin;
\.


--
-- Data for Name: messageThread; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageThread" (id, "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.note (id, "createdAt", "updatedAt", "deletedAt", "position", title, "bodyV2Blocknote", "bodyV2Markdown", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext") FROM stdin;
\.


--
-- Data for Name: noteTarget; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" (id, "createdAt", "updatedAt", "deletedAt", "noteId", "personId", "companyId", "opportunityId", "propertyId", "originId", "leadId", "customerId") FROM stdin;
\.


--
-- Data for Name: opportunity; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity (id, "createdAt", "updatedAt", "deletedAt", name, "amountAmountMicros", "amountCurrencyCode", "closeDate", stage, "position", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "pointOfContactId", "companyId", "ownerId") FROM stdin;
822639e5-9bf7-40f1-8882-a11140362339	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Platform Migration	60000000000	USD	2026-01-31 16:25:00+00	PROPOSAL	1	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	edf6d445-13a7-4373-9a47-8f89e8c0a877	1f70157c-4ea5-4d81-bc49-e1401abfbb94	913aaa02-8d40-4303-be73-e32349a8c9d0
fc747edc-cb00-4078-8d6b-1fab2611dae4	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	AI Model Training	100000000000	USD	2026-02-15 16:25:00+00	CUSTOMER	2	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	93c72d2e-e65c-44c4-99ad-f87f50349dcf	f45ee421-8a3e-4aa5-a1cf-7207cc6754e1	913aaa02-8d40-4303-be73-e32349a8c9d0
75de302f-1044-4957-8da4-1f67ebefd52b	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Workspace Expansion	45000000000	USD	2026-01-20 16:26:00+00	MEETING	3	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	7a93d1e5-3f74-4945-8a65-d7f996083f72	06290608-8bf0-4806-99ae-a715a6a93fad	913aaa02-8d40-4303-be73-e32349a8c9d0
2beb07b0-340c-41d7-be33-5aa91757f329	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	API Integration Deal	75000000000	USD	2026-01-25 16:26:00+00	SCREENING	4	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	edf6d445-13a7-4373-9a47-8f89e8c0a877	1f70157c-4ea5-4d81-bc49-e1401abfbb94	913aaa02-8d40-4303-be73-e32349a8c9d0
9543adcf-ec03-44e2-9233-3c2d3ebae98a	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Enterprise Plan Upgrade	50000000000	USD	2026-03-10 16:26:00+00	NEW	5	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	a2e78a5e-338b-46df-8811-fa08c7d19d35	c776ee49-f608-4a77-8cc8-6fe96ae1e43f	913aaa02-8d40-4303-be73-e32349a8c9d0
9457f8e9-16ae-43b9-92ee-cbd21f3dded5	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Design Partnership	30000000000	USD	2026-01-15 16:27:00+00	NEW	6	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	b1e26fa6-c757-4c88-abfa-4b11f5cf3acf	9d5bcf43-7d38-4e88-82cb-d6d4ce638bf0	913aaa02-8d40-4303-be73-e32349a8c9d0
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.person (id, "createdAt", "updatedAt", "deletedAt", "nameFirstName", "nameLastName", "emailsPrimaryEmail", "emailsAdditionalEmails", "linkedinLinkPrimaryLinkLabel", "linkedinLinkPrimaryLinkUrl", "linkedinLinkSecondaryLinks", "xLinkPrimaryLinkLabel", "xLinkPrimaryLinkUrl", "xLinkSecondaryLinks", "jobTitle", "phonesPrimaryPhoneNumber", "phonesPrimaryPhoneCountryCode", "phonesPrimaryPhoneCallingCode", "phonesAdditionalPhones", city, "avatarUrl", "position", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "companyId") FROM stdin;
a2e78a5e-338b-46df-8811-fa08c7d19d35	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Brian	Chesky	chesky@airbnb.com	\N	\N	\N	\N	\N	\N	\N	\N	123456789	\N	+1	\N	San Francisco	https://twentyhq.github.io/placeholder-images/people/image-3.png	1	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	c776ee49-f608-4a77-8cc8-6fe96ae1e43f
93c72d2e-e65c-44c4-99ad-f87f50349dcf	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Dario	Amodei	amodei@anthropic.com	\N	\N	\N	\N	\N	\N	\N	\N	555123456	\N	+1	\N	San Francisco	https://twentyhq.github.io/placeholder-images/people/image-89.png	2	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	f45ee421-8a3e-4aa5-a1cf-7207cc6754e1
edf6d445-13a7-4373-9a47-8f89e8c0a877	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Patrick	Collison	collison@stripe.com	\N	\N	\N	\N	\N	\N	\N	\N	987625341	\N	+1	\N	San Francisco	https://twentyhq.github.io/placeholder-images/people/image-47.png	3	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	1f70157c-4ea5-4d81-bc49-e1401abfbb94
b1e26fa6-c757-4c88-abfa-4b11f5cf3acf	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Dylan	Field	field@figma.com	\N	\N	\N	\N	\N	\N	\N	\N	098822619	\N	+1	\N	San Francisco	https://twentyhq.github.io/placeholder-images/people/image-40.png	4	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	9d5bcf43-7d38-4e88-82cb-d6d4ce638bf0
7a93d1e5-3f74-4945-8a65-d7f996083f72	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Ivan	Zhao	zhao@notion.com	\N	\N	\N	\N	\N	\N	\N	\N	882261739	\N	+1	\N	San Francisco	https://twentyhq.github.io/placeholder-images/people/image-68.png	5	SYSTEM	\N	System	\N	SYSTEM	\N	System	\N	06290608-8bf0-4806-99ae-a715a6a93fad
951aebd2-52b4-498d-b3b8-78f6e4b5f935	2026-02-28 07:27:20.483454+00	2026-02-28 07:27:20.483454+00	\N	Ajith 	Imprezz	ajith@imprezz.com	\N	\N	\N	\N	\N	\N	\N	\N	9824502345		+91	\N	\N	\N	0	API	\N	Webhook API Key	{}	API	\N	Webhook API Key	{}	\N
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.task (id, "createdAt", "updatedAt", "deletedAt", "position", title, "bodyV2Blocknote", "bodyV2Markdown", "dueAt", status, "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", "assigneeId") FROM stdin;
a1222cf8-f5bc-43b2-b67a-d95803add482	2026-02-28 10:08:16.207603+00	2026-02-28 10:08:16.207603+00	\N	0	\N	\N	\N	\N	TODO	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N
cb680d92-953e-4a19-9013-15aee2b481f6	2026-02-28 10:20:07.575156+00	2026-02-28 10:20:25.564898+00	\N	1	\N	\N	\N	\N	TODO	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N
293d4750-db80-4ef8-8e78-a81377f678ae	2026-02-28 13:22:33.182921+00	2026-02-28 13:22:46.20484+00	\N	2	Show the demo	\N	\N	\N	TODO	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N
338457c5-4306-45e9-a44b-0214a212b43c	2026-02-28 13:22:56.038018+00	2026-02-28 13:23:00.734123+00	\N	3	Estimation	\N	\N	\N	TODO	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	MANUAL	913aaa02-8d40-4303-be73-e32349a8c9d0	Vysakh RJ	{}	\N
\.


--
-- Data for Name: taskTarget; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" (id, "createdAt", "updatedAt", "deletedAt", "taskId", "personId", "companyId", "opportunityId", "propertyId", "originId", "leadId", "customerId") FROM stdin;
e16b2292-c6bc-401c-ae64-37cbbaad22b2	2026-02-28 10:20:07.653614+00	2026-02-28 10:20:07.653614+00	\N	cb680d92-953e-4a19-9013-15aee2b481f6	\N	\N	\N	\N	\N	b0b4087a-75c0-40af-b963-9c7c38fcf283	\N
d24029e2-9140-4eb0-b6c4-86c5dc15f2d9	2026-02-28 13:22:33.250997+00	2026-02-28 13:22:33.250997+00	\N	293d4750-db80-4ef8-8e78-a81377f678ae	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
317b61a1-d4d7-44fb-b98d-45e5565cabfd	2026-02-28 13:22:56.104069+00	2026-02-28 13:22:56.104069+00	\N	338457c5-4306-45e9-a44b-0214a212b43c	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
\.


--
-- Data for Name: timelineActivity; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" (id, "createdAt", "updatedAt", "deletedAt", "happensAt", name, properties, "linkedRecordCachedName", "linkedRecordId", "linkedObjectMetadataId", "workspaceMemberId", "targetPersonId", "targetCompanyId", "targetOpportunityId", "targetNoteId", "targetTaskId", "targetWorkflowId", "targetWorkflowVersionId", "targetWorkflowRunId", "targetDashboardId", "targetPropertyId", "targetOriginId", "targetLeadId", "targetCustomerId") FROM stdin;
69bbc401-f5a1-45fa-8b34-565ed259270b	2026-02-28 05:50:58.987448+00	2026-02-28 05:50:58.987448+00	\N	2026-02-28 05:50:58.987448+00	property.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	dfa27ca1-3364-4db9-a452-fe739549a64f	\N	\N	\N
449d247a-7f07-4d73-b6c7-a441e7bbc283	2026-02-28 05:51:13.238501+00	2026-02-28 05:51:27.385987+00	\N	2026-02-28 05:51:13.238501+00	property.updated	{"diff": {"name": {"after": "SFS Rhythm", "before": ""}, "location": {"after": {"addressLat": null, "addressLng": null, "addressCity": "Kochi", "addressState": "Kerala", "addressCountry": "India", "addressStreet1": "Kakkanad", "addressStreet2": "", "addressPostcode": ""}, "before": {"addressLat": null, "addressLng": null, "addressCity": "", "addressState": "", "addressCountry": "India", "addressStreet1": "", "addressStreet2": "", "addressPostcode": ""}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	dfa27ca1-3364-4db9-a452-fe739549a64f	\N	\N	\N
bd520776-2733-46ef-aadf-7bc4233de7ac	2026-02-28 05:51:30.726272+00	2026-02-28 05:51:30.726272+00	\N	2026-02-28 05:51:30.726272+00	property.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	43432eab-1591-487c-9bcc-ba6d3d5b4057	\N	\N	\N
b6701395-0d47-46f1-ba44-400d864a7f61	2026-02-28 05:51:39.135149+00	2026-02-28 05:51:53.336008+00	\N	2026-02-28 05:51:39.135149+00	property.updated	{"diff": {"name": {"after": "SFS Orchard", "before": ""}, "location": {"after": {"addressLat": null, "addressLng": null, "addressCity": "Thiruvananthapuram", "addressState": "Kerala", "addressCountry": "India", "addressStreet1": "Kuravankonam", "addressStreet2": "Marappalam Rd", "addressPostcode": "695004"}, "before": {"addressLat": null, "addressLng": null, "addressCity": "", "addressState": "", "addressCountry": "India", "addressStreet1": "", "addressStreet2": "", "addressPostcode": ""}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	43432eab-1591-487c-9bcc-ba6d3d5b4057	\N	\N	\N
b7004d9a-4974-41ad-bd4e-ea5ab58d16b7	2026-02-28 05:51:57.457634+00	2026-02-28 05:51:57.457634+00	\N	2026-02-28 05:51:57.457634+00	property.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	45f84f36-3c11-48eb-ae87-b5e10e8730bc	\N	\N	\N
52390706-48ec-4be2-af08-7e7c4d48e22d	2026-02-28 05:52:05.129244+00	2026-02-28 05:52:18.954108+00	\N	2026-02-28 05:52:05.129244+00	property.updated	{"diff": {"name": {"after": "SFS Cyber Palms", "before": ""}, "location": {"after": {"addressLat": null, "addressLng": null, "addressCity": "Trivandrum", "addressState": "Kerala", "addressCountry": "India", "addressStreet1": "Technopark", "addressStreet2": "", "addressPostcode": ""}, "before": {"addressLat": null, "addressLng": null, "addressCity": "", "addressState": "", "addressCountry": "India", "addressStreet1": "", "addressStreet2": "", "addressPostcode": ""}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	45f84f36-3c11-48eb-ae87-b5e10e8730bc	\N	\N	\N
be138d79-080b-4a86-ad0e-2597cdac42f0	2026-02-28 06:04:23.821704+00	2026-02-28 06:04:23.821704+00	\N	2026-02-28 06:04:23.821704+00	origin.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	035787f5-659e-46a8-b668-005c6ba474d3	\N	\N
1791e4fd-07df-4664-bbf6-46e9853677ef	2026-02-28 06:04:30.310338+00	2026-02-28 06:04:30.310338+00	\N	2026-02-28 06:04:30.310338+00	origin.updated	{"diff": {"name": {"after": "Google", "before": ""}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	035787f5-659e-46a8-b668-005c6ba474d3	\N	\N
1ecdac42-afde-4da7-956b-7785130dbf82	2026-02-28 06:04:41.221181+00	2026-02-28 06:04:41.221181+00	\N	2026-02-28 06:04:41.221181+00	origin.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b3bae279-4406-406e-a5b0-ac525cddaac0	\N	\N
4a5e1235-f6a8-41ff-8605-a856fa5bb6f7	2026-02-28 06:04:47.892567+00	2026-02-28 06:04:47.892567+00	\N	2026-02-28 06:04:47.892567+00	origin.updated	{"diff": {"name": {"after": "Meta", "before": ""}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b3bae279-4406-406e-a5b0-ac525cddaac0	\N	\N
3d6e4fd4-1518-4aaa-a772-1305e1aa2a70	2026-02-28 06:04:49.247471+00	2026-02-28 06:04:49.247471+00	\N	2026-02-28 06:04:49.247471+00	origin.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e19892e-5b93-4c35-974f-b4b235ba12f0	\N	\N
05dd9d82-d821-46db-a366-0465e9606403	2026-02-28 06:04:56.35855+00	2026-02-28 06:04:56.35855+00	\N	2026-02-28 06:04:56.35855+00	origin.updated	{"diff": {"name": {"after": "Website", "before": ""}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e19892e-5b93-4c35-974f-b4b235ba12f0	\N	\N
2fb5eee8-ad49-4819-954e-90d9a86b2073	2026-02-28 06:45:28.481012+00	2026-02-28 06:45:28.481012+00	\N	2026-02-28 06:45:28.481012+00	lead.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d4880c-36c3-414d-9b29-f73bda42aaec	\N
9144d1da-b6d7-4681-9fa2-a75ec5e5cd22	2026-02-28 07:06:15.434977+00	2026-02-28 07:06:15.434977+00	\N	2026-02-28 07:06:15.434977+00	lead.updated	{"diff": {"customerId": {"after": "44abda2f-63bb-46d2-8ece-aca83bd763f2", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d4880c-36c3-414d-9b29-f73bda42aaec	\N
ff09d7db-a18c-4fa5-a438-570e11b19b2f	2026-02-28 07:27:20.590955+00	2026-02-28 07:27:20.590955+00	\N	2026-02-28 07:27:20.590955+00	person.created	{}		\N	\N	\N	951aebd2-52b4-498d-b3b8-78f6e4b5f935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
f152e6ab-d7ec-45a3-8f8e-6e41df00bef5	2026-02-28 07:27:20.601515+00	2026-02-28 07:27:20.601515+00	\N	2026-02-28 07:27:20.601515+00	origin.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8d8a3fc8-c19a-4a60-adc9-fa712a9ef850	\N	\N
f701152e-6fdd-4f67-9b1e-bd8d9d9112be	2026-02-28 06:45:54.952557+00	2026-02-28 06:52:49.285669+00	\N	2026-02-28 06:45:54.952557+00	lead.updated	{"diff": {"name": {"after": "Lead -SFS#12", "before": ""}, "dueDate": {"after": "2026-03-14T06:52:00.000Z", "before": null}, "originId": {"after": "035787f5-659e-46a8-b668-005c6ba474d3", "before": null}, "assigneeId": {"after": "fed85579-aad3-4bca-b301-f877957b8c40", "before": null}, "propertyId": {"after": "dfa27ca1-3364-4db9-a452-fe739549a64f", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d4880c-36c3-414d-9b29-f73bda42aaec	\N
8f4aaab7-1dab-4e59-a6c1-22cc135efc21	2026-02-28 06:58:08.308374+00	2026-02-28 06:58:08.308374+00	\N	2026-02-28 06:58:08.308374+00	customer.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	44abda2f-63bb-46d2-8ece-aca83bd763f2
ba1121c4-a917-4877-9bf0-c75c766bf6fd	2026-02-28 06:58:16.614903+00	2026-02-28 06:59:35.959184+00	\N	2026-02-28 06:58:16.614903+00	customer.updated	{"diff": {"name": {"after": "Customer1", "before": ""}, "email": {"after": {"primaryEmail": "bdsdf@yopmail.com", "additionalEmails": []}, "before": {"primaryEmail": "", "additionalEmails": []}}, "phone": {"after": {"additionalPhones": [], "primaryPhoneNumber": "9999999999", "primaryPhoneCallingCode": "+91", "primaryPhoneCountryCode": "IN"}, "before": {"additionalPhones": [], "primaryPhoneNumber": "", "primaryPhoneCallingCode": "", "primaryPhoneCountryCode": ""}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	44abda2f-63bb-46d2-8ece-aca83bd763f2
d2ab21d0-2fcc-4cfc-a3d6-0928b5da129b	2026-02-28 07:32:36.14345+00	2026-02-28 07:34:31.056062+00	\N	2026-02-28 07:32:36.14345+00	lead.updated	{"diff": {"status": {"after": "NEW", "before": []}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d4880c-36c3-414d-9b29-f73bda42aaec	\N
2253a95b-2c3d-4ac7-93be-9a5b1d3fecfc	2026-02-28 08:05:18.807347+00	2026-02-28 08:05:18.807347+00	\N	2026-02-28 08:05:18.807347+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	057ebbdb-4ef3-4e94-aad3-b64b4c76937f	\N
2a044185-ccb8-44ab-920c-a49eae72929b	2026-02-28 08:09:57.790818+00	2026-02-28 08:09:57.790818+00	\N	2026-02-28 08:09:57.790818+00	lead.updated	{"diff": {"status": {"after": "NEW", "before": null}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	057ebbdb-4ef3-4e94-aad3-b64b4c76937f	\N
faa90591-d061-4144-8691-ede2a5509f3d	2026-02-28 08:11:06.548969+00	2026-02-28 08:11:06.548969+00	\N	2026-02-28 08:11:06.548969+00	customer.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f64f9fde-bee9-4bf4-9e5b-91ec6d5d5ac5
d452293a-3554-47b0-a377-455bd080b3c1	2026-02-28 08:11:55.324391+00	2026-02-28 08:11:55.324391+00	\N	2026-02-28 08:11:55.324391+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	35198393-bf74-4028-af38-1678b988bfb8	\N
6a280816-63a3-449f-b903-0709c83b3e01	2026-02-28 08:45:02.382417+00	2026-02-28 08:45:02.382417+00	\N	2026-02-28 08:45:02.382417+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
0ea56344-a5f8-4929-9066-1291647cd9f6	2026-02-28 09:18:44.563907+00	2026-02-28 09:18:44.563907+00	\N	2026-02-28 09:18:44.563907+00	lead.updated	{"diff": {"status": {"after": "CONTACTED", "before": "NEW"}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
cfc6ea88-95a6-4b99-b2af-48d39ffde01d	2026-02-28 09:21:34.503187+00	2026-02-28 09:21:34.503187+00	\N	2026-02-28 09:21:34.503187+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0b4087a-75c0-40af-b963-9c7c38fcf283	\N
5a69dd66-746f-45d8-8787-6dde19a95b05	2026-02-28 10:08:16.349099+00	2026-02-28 10:08:16.349099+00	\N	2026-02-28 10:08:16.349099+00	task.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	a1222cf8-f5bc-43b2-b67a-d95803add482	\N	\N	\N	\N	\N	\N	\N	\N
4b84b876-09f2-48a3-aebe-7db587af7cf1	2026-02-28 10:20:07.707849+00	2026-02-28 10:20:07.707849+00	\N	2026-02-28 10:20:07.707849+00	task.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	cb680d92-953e-4a19-9013-15aee2b481f6	\N	\N	\N	\N	\N	\N	\N	\N
deaf8214-68c5-4e6c-8890-01d4095683d5	2026-02-28 10:20:07.723695+00	2026-02-28 10:20:07.723695+00	\N	2026-02-28 10:20:07.723695+00	linked-task.created	{}		cb680d92-953e-4a19-9013-15aee2b481f6	ff60777a-2722-4aa0-ba66-a8e089c7bc94	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0b4087a-75c0-40af-b963-9c7c38fcf283	\N
be074635-c9c1-4eb2-b5eb-e81536ada4bd	2026-02-28 10:20:14.273814+00	2026-02-28 10:20:25.631438+00	\N	2026-02-28 10:20:14.273814+00	task.updated	{"diff": {"status": {"after": "TODO", "before": "TODO"}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	cb680d92-953e-4a19-9013-15aee2b481f6	\N	\N	\N	\N	\N	\N	\N	\N
56f139cd-b95b-43b4-bb50-91bcda2476e6	2026-02-28 10:20:28.273699+00	2026-02-28 10:20:28.273699+00	\N	2026-02-28 10:20:28.273699+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-02-28T10:20:28.261Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0b4087a-75c0-40af-b963-9c7c38fcf283	\N
21c52bc9-10c1-41b6-ac89-25844a7ba5c4	2026-02-28 10:29:06.975636+00	2026-02-28 10:29:06.975636+00	\N	2026-02-28 10:29:06.975636+00	lead.updated	{"diff": {"status": {"after": "NURTURE", "before": null}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	35198393-bf74-4028-af38-1678b988bfb8	\N
a473daa3-d471-46f2-988d-7818849a2567	2026-02-28 10:31:13.614006+00	2026-02-28 10:31:13.614006+00	\N	2026-02-28 10:31:13.614006+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b5706ba-017b-4ee4-a479-366723c49fe1	\N
84f9d302-4fc5-4aee-8442-3b479e0c400f	2026-02-28 10:52:47.514035+00	2026-02-28 10:52:47.514035+00	\N	2026-02-28 10:52:47.514035+00	lead.updated	{"diff": {"status": {"after": "CONTACTED", "before": "NEW"}, "position": {"after": 1, "before": -4}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b5706ba-017b-4ee4-a479-366723c49fe1	\N
2a6547f2-9413-495b-8f95-5a74101978ba	2026-02-28 10:56:23.478625+00	2026-02-28 10:56:23.478625+00	\N	2026-02-28 10:56:23.478625+00	lead.updated	{"diff": {"updates": {"after": ["contacted"], "before": []}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
a7fb4fb6-f40b-4d17-be11-0f1ed6a88cba	2026-02-28 10:58:20.631767+00	2026-02-28 10:58:20.631767+00	\N	2026-02-28 10:58:20.631767+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-02-28T10:58:20.543Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d4880c-36c3-414d-9b29-f73bda42aaec	\N
bb2ca71a-0305-40f3-8a4e-3530326c997f	2026-02-28 10:58:20.631767+00	2026-02-28 10:58:20.631767+00	\N	2026-02-28 10:58:20.631767+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-02-28T10:58:20.543Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	057ebbdb-4ef3-4e94-aad3-b64b4c76937f	\N
235fc0d2-a0ec-415e-84cf-a50363a1b90c	2026-02-28 10:58:20.631767+00	2026-02-28 10:58:20.631767+00	\N	2026-02-28 10:58:20.631767+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-02-28T10:58:20.543Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	35198393-bf74-4028-af38-1678b988bfb8	\N
2839eb26-a3a5-42b0-ae37-fb84660b3bd3	2026-02-28 11:22:38.318665+00	2026-02-28 11:22:38.318665+00	\N	2026-02-28 11:22:38.318665+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "First floor\\n\\ndsfsdf\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"First floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"dsfsdf\\"}]}]"}, "before": {"markdown": "First floor", "blocknote": "[{\\"id\\":\\"9dbe2cbf-c0f6-453d-a9a7-408cece73957\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"First floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b5706ba-017b-4ee4-a479-366723c49fe1	\N
25514256-7a8c-429e-b225-ffdf32195453	2026-02-28 11:35:38.511319+00	2026-02-28 11:35:38.511319+00	\N	2026-02-28 11:35:38.511319+00	lead.updated	{"diff": {"status": {"after": "NURTURE", "before": "CONTACTED"}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b5706ba-017b-4ee4-a479-366723c49fe1	\N
d94f0b0d-f219-43e8-93b0-be6a5efc6d3c	2026-02-28 11:49:51.352919+00	2026-02-28 11:49:51.352919+00	\N	2026-02-28 11:49:51.352919+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4c973eb6-271c-4d6d-98f4-6e6917007989	\N
4d49c45e-1631-477f-a4ab-80a6029f8540	2026-02-28 12:29:05.141332+00	2026-02-28 12:29:05.141332+00	\N	2026-02-28 12:29:05.141332+00	customer.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2c64656e-5c10-42d2-ba37-2782908d61b5
fd24573b-94a1-4cfd-a113-291e438b4a05	2026-02-28 12:29:05.829533+00	2026-02-28 12:29:05.829533+00	\N	2026-02-28 12:29:05.829533+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
9f6746b7-f073-489e-92c8-45be2397c8d6	2026-02-28 12:29:29.014374+00	2026-02-28 12:29:29.014374+00	\N	2026-02-28 12:29:29.014374+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e98585c1-ca96-4f8f-bca6-fd330c97c4ac	\N
1fa966d6-7218-4938-8f8d-c8effedd7139	2026-02-28 12:29:41.818084+00	2026-02-28 12:29:41.818084+00	\N	2026-02-28 12:29:41.818084+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbe732b6-e0fd-490b-bcaf-2637143d830a	\N
0c19f945-87aa-4e57-8f06-9369adaa1e87	2026-02-28 12:30:30.17159+00	2026-02-28 12:37:16.609619+00	\N	2026-02-28 12:30:30.17159+00	lead.updated	{"diff": {"status": {"after": "CONVERTED", "before": "NEW"}, "dueDate": {"after": "2026-03-03T12:29:00.000Z", "before": "2026-03-02T12:29:41.752Z"}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbe732b6-e0fd-490b-bcaf-2637143d830a	\N
fb91a970-57b7-4b7d-b455-4184409a341f	2026-02-28 13:12:08.21747+00	2026-02-28 13:12:26.805122+00	\N	2026-02-28 13:12:08.21747+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "Last floor\\n\\njkkjhn\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"jkkjhn\\"}]}]"}, "before": {"markdown": "Last floor", "blocknote": "[{\\"id\\":\\"bc073a87-d8c7-400c-812b-bfd90fde8dad\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbe732b6-e0fd-490b-bcaf-2637143d830a	\N
7995ce6b-c20f-4d3e-87cb-d91992eea1e9	2026-02-28 13:17:47.373418+00	2026-02-28 13:17:47.373418+00	\N	2026-02-28 13:17:47.373418+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6b81024c-279e-44de-aa15-5306e2d120c0	\N
341b4604-6053-4fd6-aaad-cbb7a9ec70c0	2026-02-28 13:17:19.37571+00	2026-02-28 13:19:43.535677+00	\N	2026-02-28 13:17:19.37571+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "notes\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"notes\\"}]}]"}, "before": {"markdown": "Last floor", "blocknote": "[{\\"id\\":\\"1eaa0772-62f5-4d1a-8020-3e28d37705b3\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
8e29465c-b545-44ed-8b76-b89873586a00	2026-02-28 13:22:33.250429+00	2026-02-28 13:22:33.250429+00	\N	2026-02-28 13:22:33.250429+00	task.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	293d4750-db80-4ef8-8e78-a81377f678ae	\N	\N	\N	\N	\N	\N	\N	\N
92e66f51-9b97-40d1-9370-025e6cdc146b	2026-02-28 13:22:33.266284+00	2026-02-28 13:22:33.266284+00	\N	2026-02-28 13:22:33.266284+00	linked-task.created	{}		293d4750-db80-4ef8-8e78-a81377f678ae	ff60777a-2722-4aa0-ba66-a8e089c7bc94	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
c3ddefe6-e354-443e-9a11-df2b0564e13b	2026-02-28 13:22:46.463965+00	2026-02-28 13:22:46.463965+00	\N	2026-02-28 13:22:46.463965+00	linked-task.updated	{"diff": {"title": {"after": "Show the demo", "before": ""}}}	Show the demo	293d4750-db80-4ef8-8e78-a81377f678ae	ff60777a-2722-4aa0-ba66-a8e089c7bc94	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10f7b101-0daa-4380-a007-dbb447bc87e7	2026-02-28 13:22:46.463965+00	2026-02-28 13:22:46.463965+00	\N	2026-02-28 13:22:46.463965+00	task.updated	{"diff": {"title": {"after": "Show the demo", "before": ""}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	293d4750-db80-4ef8-8e78-a81377f678ae	\N	\N	\N	\N	\N	\N	\N	\N
ea73505f-3133-4f98-bed7-6de208ce337b	2026-02-28 13:22:56.055697+00	2026-02-28 13:22:56.055697+00	\N	2026-02-28 13:22:56.055697+00	task.created	{}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	338457c5-4306-45e9-a44b-0214a212b43c	\N	\N	\N	\N	\N	\N	\N	\N
62064d2a-5a84-4740-a889-2c51782f9691	2026-02-28 13:22:56.11918+00	2026-02-28 13:22:56.11918+00	\N	2026-02-28 13:22:56.11918+00	linked-task.created	{}		338457c5-4306-45e9-a44b-0214a212b43c	ff60777a-2722-4aa0-ba66-a8e089c7bc94	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	84a0e3b1-7abf-49b9-9763-013ca66a2a4a	\N
8c7b322f-685c-40e3-bea9-17169a63f03b	2026-02-28 13:23:00.763349+00	2026-02-28 13:23:00.763349+00	\N	2026-02-28 13:23:00.763349+00	linked-task.updated	{"diff": {"title": {"after": "Estimation", "before": ""}}}	Estimation	338457c5-4306-45e9-a44b-0214a212b43c	ff60777a-2722-4aa0-ba66-a8e089c7bc94	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
bb36deb9-e54b-466f-9475-5ba46bafa1ca	2026-02-28 13:23:00.763349+00	2026-02-28 13:23:00.763349+00	\N	2026-02-28 13:23:00.763349+00	task.updated	{"diff": {"title": {"after": "Estimation", "before": ""}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	338457c5-4306-45e9-a44b-0214a212b43c	\N	\N	\N	\N	\N	\N	\N	\N
56ba55ec-6063-4456-bf07-f97aec138601	2026-02-28 13:18:04.89841+00	2026-02-28 13:23:11.894675+00	\N	2026-02-28 13:18:04.89841+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "new teset body floor\\n\\ntest check\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"new teset body floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"test check\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "new teset body floor", "blocknote": "[{\\"id\\":\\"0ce7939b-fc86-4cc7-9078-8014fbb8b2cb\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"new teset body floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "status": {"after": "CONTACTED", "before": "NEW"}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6b81024c-279e-44de-aa15-5306e2d120c0	\N
20ca09fe-a065-40b8-b76a-8f536ff020aa	2026-02-28 13:51:17.796704+00	2026-02-28 13:51:17.796704+00	\N	2026-02-28 13:51:17.796704+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "Last floor\\n\\njkkjhn\\n\\nknkjn\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"jkkjhn\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"knkjn\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "Last floor\\n\\njkkjhn\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"jkkjhn\\"}]}]"}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbe732b6-e0fd-490b-bcaf-2637143d830a	\N
80a33056-6604-400a-9e85-44a40a4fbc51	2026-02-28 13:51:26.176268+00	2026-02-28 13:51:26.176268+00	\N	2026-02-28 13:51:26.176268+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "new teset body floor\\n\\ntest check\\n\\nnnosdfsdf\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"new teset body floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"test check\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"nnosdfsdf\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "new teset body floor\\n\\ntest check\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"new teset body floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"test check\\"}]},{\\"type\\":\\"paragraph\\"}]"}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6b81024c-279e-44de-aa15-5306e2d120c0	\N
6e262940-21fc-420e-ad62-f628f7c56eb3	2026-02-28 14:09:38.126193+00	2026-02-28 14:13:30.111799+00	\N	2026-02-28 14:09:38.126193+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "new teset body floor\\n\\ntest check\\n\\nnnosdfsdf\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"marks\\":[{\\"type\\":\\"bold\\"}],\\"text\\":\\"new teset body floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"test check\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"nnosdfsdf\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "new teset body floor\\n\\ntest check\\n\\nnnosdfsdf\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"new teset body floor\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"test check\\"}]},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"nnosdfsdf\\"}]},{\\"type\\":\\"paragraph\\"}]"}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6b81024c-279e-44de-aa15-5306e2d120c0	\N
9e63bdf4-b26c-4355-a0e2-9c96234920c4	2026-02-28 14:09:44.201324+00	2026-02-28 14:10:01.511778+00	\N	2026-02-28 14:09:44.201324+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "kooppite kidaykale\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"kooppite kidaykale\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "Last floor", "blocknote": "[{\\"id\\":\\"1e60dd76-0d0c-414f-913e-101d9bab0656\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e98585c1-ca96-4f8f-bca6-fd330c97c4ac	\N
9a8b4bdb-abd4-47f9-a7b1-8b03143f4294	2026-02-28 14:13:54.104631+00	2026-02-28 14:13:56.410974+00	\N	2026-02-28 14:13:54.104631+00	lead.updated	{"diff": {"notes": {"after": {"markdown": "Last floor\\n\\nhttps://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php\\n", "blocknote": "[{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\"}]},{\\"type\\":\\"paragraph\\"},{\\"type\\":\\"paragraph\\",\\"content\\":[{\\"type\\":\\"text\\",\\"marks\\":[{\\"type\\":\\"link\\",\\"attrs\\":{\\"href\\":\\"https://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php\\",\\"target\\":\\"_blank\\",\\"rel\\":\\"noopener noreferrer nofollow\\",\\"class\\":null}}],\\"text\\":\\"https://www.kalyanjewellers.net/Jewellery/Rings/couple-band-engagement-rings.php\\"}]},{\\"type\\":\\"paragraph\\"}]"}, "before": {"markdown": "Last floor", "blocknote": "[{\\"id\\":\\"39ac065c-4b18-45a6-a28b-010804444412\\",\\"type\\":\\"paragraph\\",\\"props\\":{\\"textColor\\":\\"default\\",\\"backgroundColor\\":\\"default\\",\\"textAlignment\\":\\"left\\"},\\"content\\":[{\\"type\\":\\"text\\",\\"text\\":\\"Last floor\\",\\"styles\\":{}}],\\"children\\":[]}]"}}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4c973eb6-271c-4d6d-98f4-6e6917007989	\N
9a38ae49-4262-4f23-8f4d-c104b72854e7	2026-03-01 20:51:53.082433+00	2026-03-01 20:51:53.082433+00	\N	2026-03-01 20:51:53.082433+00	customer.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	46cd7e38-be9c-4a3b-9e18-856cbd1c4390
9d9a6fd1-b83f-4e14-b5d1-eed1b7dacf55	2026-03-01 20:51:53.108188+00	2026-03-01 20:51:53.108188+00	\N	2026-03-01 20:51:53.108188+00	origin.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2e5c95af-4a46-44c7-8f68-a1de1e3bf938	\N	\N
5b84e755-c97c-43b1-94e6-76c587de62b9	2026-03-01 20:51:53.557327+00	2026-03-01 20:51:53.557327+00	\N	2026-03-01 20:51:53.557327+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3753e5b0-63b1-4ba1-a3b7-cd7173d22be3	\N
39c09877-3e49-46b6-b05d-450ac80be662	2026-03-01 20:52:36.005865+00	2026-03-01 20:52:36.005865+00	\N	2026-03-01 20:52:36.005865+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a162cbac-1ab1-49db-9aaf-effa83715fb7	\N
2623e515-95d7-4972-a67a-ef2380a6b9ed	2026-03-01 20:53:29.00921+00	2026-03-01 20:53:29.00921+00	\N	2026-03-01 20:53:29.00921+00	origin.deleted	{"diff": {"deletedAt": {"after": "2026-03-01T20:53:28.805Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e19892e-5b93-4c35-974f-b4b235ba12f0	\N	\N
24dbcfca-a51e-4b6d-bad4-12cb56bb0cb5	2026-03-01 20:53:29.00921+00	2026-03-01 20:53:29.00921+00	\N	2026-03-01 20:53:29.00921+00	origin.deleted	{"diff": {"deletedAt": {"after": "2026-03-01T20:53:28.805Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2e5c95af-4a46-44c7-8f68-a1de1e3bf938	\N	\N
4b6ac16a-2afe-4817-b671-f992be33a1f4	2026-03-01 20:53:46.281504+00	2026-03-01 20:53:46.281504+00	\N	2026-03-01 20:53:46.281504+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-03-01T20:53:46.233Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a162cbac-1ab1-49db-9aaf-effa83715fb7	\N
1fbd1383-6b29-4632-bed5-af48dbfe0c16	2026-03-01 20:53:46.281504+00	2026-03-01 20:53:46.281504+00	\N	2026-03-01 20:53:46.281504+00	lead.deleted	{"diff": {"deletedAt": {"after": "2026-03-01T20:53:46.233Z", "before": null}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3753e5b0-63b1-4ba1-a3b7-cd7173d22be3	\N
a4972dfa-b3c8-4e3a-99a5-00d892a36ae8	2026-03-01 20:54:00.721005+00	2026-03-01 20:54:00.721005+00	\N	2026-03-01 20:54:00.721005+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a77906bb-228b-451b-9005-c470d71b7361	\N
0237a38a-aa69-4619-aa17-e49782fb68d0	2026-03-01 21:28:10.644873+00	2026-03-01 21:28:10.644873+00	\N	2026-03-01 21:28:10.644873+00	lead.updated	{"diff": {"status": {"after": "NURTURE", "before": "NEW"}, "updatedBy": {"after": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	913aaa02-8d40-4303-be73-e32349a8c9d0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a77906bb-228b-451b-9005-c470d71b7361	\N
94aca7ec-40a9-4836-ab8c-5058d9b11d66	2026-03-02 09:13:00.87416+00	2026-03-02 09:13:00.87416+00	\N	2026-03-02 09:13:00.87416+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bd4044b5-6645-4d44-8231-339d15ff7f83	\N
58e48728-3e22-48bf-a3c2-cf3159a45ab4	2026-03-02 09:13:29.389213+00	2026-03-02 09:13:29.389213+00	\N	2026-03-02 09:13:29.389213+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	06a6126a-bc17-4585-8995-9e7d2a08895c	\N
71d7e684-bc31-4e47-8c69-22595a6d159c	2026-03-02 09:27:38.826119+00	2026-03-02 09:27:38.826119+00	\N	2026-03-02 09:27:38.826119+00	lead.updated	{"diff": {"status": {"after": "NURTURE", "before": "CONVERTED"}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbe732b6-e0fd-490b-bcaf-2637143d830a	\N
5e9ebb25-b20f-4d54-9183-94e40c7aadc6	2026-03-02 13:34:06.385509+00	2026-03-02 13:34:06.385509+00	\N	2026-03-02 13:34:06.385509+00	lead.updated	{"diff": {"readAt": {"after": "2026-03-02T13:34:06.021Z", "before": null}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b5706ba-017b-4ee4-a479-366723c49fe1	\N
d8584543-bb98-41c5-9f6f-92fecac93ecd	2026-03-02 13:41:29.177815+00	2026-03-02 13:41:29.177815+00	\N	2026-03-02 13:41:29.177815+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a289e87f-414e-4a22-947f-01813ca96994	\N
ad52c5b2-3197-4dce-aebf-37a83d096669	2026-03-02 14:25:20.087222+00	2026-03-02 14:25:20.087222+00	\N	2026-03-02 14:25:20.087222+00	lead.created	{}		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f8fe9937-8069-4e4d-bdc2-c5e35d7510c2	\N
111d3f4d-d232-43fb-a41c-155ec8ccefbc	2026-03-02 14:45:41.420677+00	2026-03-02 14:45:41.420677+00	\N	2026-03-02 14:45:41.420677+00	lead.updated	{"diff": {"readAt": {"after": "2026-03-02T14:45:41.066Z", "before": null}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Webhook API Key", "source": "API", "context": {}, "workspaceMemberId": null}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f8fe9937-8069-4e4d-bdc2-c5e35d7510c2	\N
5eb5be9f-7630-4690-962b-6a7f8adc8ec7	2026-03-02 13:35:12.223584+00	2026-03-02 13:36:16.684727+00	\N	2026-03-02 13:35:12.223584+00	lead.updated	{"diff": {"readAt": {"after": "2026-03-02T13:35:12.036Z", "before": null}, "status": {"after": "NURTURE", "before": "NEW"}, "dueDate": {"after": "2026-03-07T03:49:00.000Z", "before": "2026-03-02T11:49:50.547Z"}, "updatedBy": {"after": {"name": "Vasisht RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "fed85579-aad3-4bca-b301-f877957b8c40"}, "before": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4c973eb6-271c-4d6d-98f4-6e6917007989	\N
f26ed8be-401a-463c-9aab-2c83553c3c60	2026-03-02 19:39:49.489395+00	2026-03-02 19:39:59.948051+00	\N	2026-03-02 19:39:49.489395+00	lead.updated	{"diff": {"status": {"after": "CONVERTED", "before": "NEW"}, "dueDate": {"after": "2026-03-13T17:30:00.000Z", "before": "2026-03-04T14:25:19.730Z"}}}		\N	\N	fed85579-aad3-4bca-b301-f877957b8c40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f8fe9937-8069-4e4d-bdc2-c5e35d7510c2	\N
cd56b7b3-1d75-4dda-bc6a-976d3e4fbaa9	2026-03-02 19:57:12.92314+00	2026-03-02 19:57:12.92314+00	\N	2026-03-02 19:57:12.92314+00	lead.updated	{"diff": {"readAt": {"after": "2026-03-02T19:57:12.262Z", "before": null}, "updatedBy": {"after": {"name": "Arjun S", "source": "MANUAL", "context": {}, "workspaceMemberId": "0f7c9c48-c43e-4010-b786-87fad4ebfb47"}, "before": {"name": "Vysakh RJ", "source": "MANUAL", "context": {}, "workspaceMemberId": "913aaa02-8d40-4303-be73-e32349a8c9d0"}}}}		\N	\N	0f7c9c48-c43e-4010-b786-87fad4ebfb47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0e16dbd1-46c9-438f-8687-59175d12b796	\N
\.


--
-- Data for Name: workflow; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow (id, "createdAt", "updatedAt", "deletedAt", name, "lastPublishedVersionId", statuses, "position", "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext") FROM stdin;
8b213cac-a68b-4ffe-817a-3ec994e9932d	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	Quick Lead	ac67974f-c524-4288-9d88-af8515400b68	{ACTIVE}	1	SYSTEM	\N	System	{}	SYSTEM	\N	System	\N
\.


--
-- Data for Name: workflowAutomatedTrigger; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger" (id, "createdAt", "updatedAt", "deletedAt", type, settings, "workflowId") FROM stdin;
\.


--
-- Data for Name: workflowRun; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun" (id, "createdAt", "updatedAt", "deletedAt", name, "enqueuedAt", "startedAt", "endedAt", status, "createdBySource", "createdByWorkspaceMemberId", "createdByName", "createdByContext", "updatedBySource", "updatedByWorkspaceMemberId", "updatedByName", "updatedByContext", state, context, output, "position", "workflowVersionId", "workflowId") FROM stdin;
\.


--
-- Data for Name: workflowVersion; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion" (id, "createdAt", "updatedAt", "deletedAt", name, trigger, steps, status, "position", "workflowId") FROM stdin;
ac67974f-c524-4288-9d88-af8515400b68	2026-02-28 05:07:17.19946+00	2026-02-28 05:07:17.19946+00	\N	v1	{"name": "Launch manually", "type": "MANUAL", "settings": {"icon": "IconUserPlus", "availability": {"type": "GLOBAL"}, "outputSchema": {}}, "nextStepIds": ["6e089bc9-aabd-435f-865f-f31c01c8f4a7"]}	[{"id": "6e089bc9-aabd-435f-865f-f31c01c8f4a7", "name": "Quick Lead Form", "type": "FORM", "valid": false, "settings": {"input": [{"id": "14d669f0-5249-4fa4-b0bb-f8bd408328d5", "name": "firstName", "type": "TEXT", "label": "First name", "placeholder": "Tim"}, {"id": "4eb6ce85-d231-4aef-9837-744490c026d0", "name": "lastName", "type": "TEXT", "label": "Last Name", "placeholder": "Apple"}, {"id": "adbf0e9f-1427-49be-b4fb-092b34d97350", "name": "email", "type": "TEXT", "label": "Email", "placeholder": "timapple@apple.com"}, {"id": "4ffc7992-9e65-4a4d-9baf-b52e62f2c273", "name": "jobTitle", "type": "TEXT", "label": "Job title", "placeholder": "CEO"}, {"id": "42f11926-04ea-4924-94a4-2293cc748362", "name": "companyName", "type": "TEXT", "label": "Company name", "placeholder": "Apple"}, {"id": "d6ca80ee-26cd-466d-91bf-984d7205451c", "name": "companyDomain", "type": "TEXT", "label": "Company domain", "placeholder": "https://www.apple.com"}], "outputSchema": {"email": {"type": "TEXT", "label": "Email", "value": "My text", "isLeaf": true}, "jobTitle": {"type": "TEXT", "label": "Job title", "value": "My text", "isLeaf": true}, "lastName": {"type": "TEXT", "label": "Last Name", "value": "My text", "isLeaf": true}, "firstName": {"type": "TEXT", "label": "First name", "value": "My text", "isLeaf": true}, "companyName": {"type": "TEXT", "label": "Company name", "value": "My text", "isLeaf": true}, "companyDomain": {"type": "TEXT", "label": "Company domain", "value": "My text", "isLeaf": true}}, "errorHandlingOptions": {"retryOnFailure": {"value": false}, "continueOnFailure": {"value": false}}}, "__typename": "WorkflowAction", "nextStepIds": ["0715b6cd-7cc1-4b98-971b-00f54dfe643b"]}, {"id": "0715b6cd-7cc1-4b98-971b-00f54dfe643b", "name": "Create Company", "type": "CREATE_RECORD", "valid": false, "settings": {"input": {"objectName": "company", "objectRecord": {"name": "{{6e089bc9-aabd-435f-865f-f31c01c8f4a7.companyName}}", "domainName": {"primaryLinkUrl": "{{6e089bc9-aabd-435f-865f-f31c01c8f4a7.companyDomain}}", "primaryLinkLabel": ""}}}, "outputSchema": {"fields": {"id": {"icon": "Icon123", "type": "UUID", "label": "Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "7550311e-1365-4576-8908-2ffc5236e56b"}, "name": {"icon": "IconBuildingSkyscraper", "type": "TEXT", "label": "Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "eb858483-5937-4ce5-9c68-259d1235607d"}, "xLink": {"icon": "IconBrandX", "type": "LINKS", "label": "X", "value": {"primaryLinkUrl": {"type": "TEXT", "label": "Primary Link Url", "value": "My text", "isLeaf": true, "fieldMetadataId": "27b1fb04-dc13-4dbe-9578-b8bda3e5ddff", "isCompositeSubField": true}, "secondaryLinks": {"type": "RAW_JSON", "label": "Secondary Links", "value": null, "isLeaf": true, "fieldMetadataId": "27b1fb04-dc13-4dbe-9578-b8bda3e5ddff", "isCompositeSubField": true}, "primaryLinkLabel": {"type": "TEXT", "label": "Primary Link Label", "value": "My text", "isLeaf": true, "fieldMetadataId": "27b1fb04-dc13-4dbe-9578-b8bda3e5ddff", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "27b1fb04-dc13-4dbe-9578-b8bda3e5ddff"}, "address": {"icon": "IconMap", "type": "ADDRESS", "label": "Address", "value": {"addressLat": {"type": "NUMERIC", "label": "Address Lat", "value": null, "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressLng": {"type": "NUMERIC", "label": "Address Lng", "value": null, "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressCity": {"type": "TEXT", "label": "Address City", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressState": {"type": "TEXT", "label": "Address State", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressCountry": {"type": "TEXT", "label": "Address Country", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressStreet1": {"type": "TEXT", "label": "Address Street1", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressStreet2": {"type": "TEXT", "label": "Address Street2", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}, "addressPostcode": {"type": "TEXT", "label": "Address Postcode", "value": "My text", "isLeaf": true, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "7d7186c9-dec2-4421-8cfd-4d197478e9bc"}, "createdAt": {"icon": "IconCalendar", "type": "DATE_TIME", "label": "Creation date", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "6c92eab1-1463-4a90-8336-057354bedde6"}, "createdBy": {"icon": "IconCreativeCommonsSa", "type": "ACTOR", "label": "Created by", "value": {"name": {"type": "TEXT", "label": "Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "27d984fd-a568-463a-9c3b-98e10046291a", "isCompositeSubField": true}, "source": {"type": "SELECT", "label": "Source", "value": null, "isLeaf": true, "fieldMetadataId": "27d984fd-a568-463a-9c3b-98e10046291a", "isCompositeSubField": true}, "context": {"type": "RAW_JSON", "label": "Context", "value": null, "isLeaf": true, "fieldMetadataId": "27d984fd-a568-463a-9c3b-98e10046291a", "isCompositeSubField": true}, "workspaceMemberId": {"type": "UUID", "label": "Workspace Member Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "27d984fd-a568-463a-9c3b-98e10046291a", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "27d984fd-a568-463a-9c3b-98e10046291a"}, "deletedAt": {"icon": "IconCalendarMinus", "type": "DATE_TIME", "label": "Deleted at", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "58788ce5-99b7-4623-b434-3923d1711793"}, "employees": {"icon": "IconUsers", "type": "NUMBER", "label": "Employees", "value": 20, "isLeaf": true, "fieldMetadataId": "c62d2bc4-df89-4d6c-9caf-11a760519d11"}, "updatedAt": {"icon": "IconCalendarClock", "type": "DATE_TIME", "label": "Last update", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "cc78e8b1-c324-4937-8e89-bdbdd339cd30"}, "updatedBy": {"icon": "IconUserCircle", "type": "ACTOR", "label": "Updated by", "value": {"name": {"type": "TEXT", "label": "Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "3ba862a0-5453-47b9-9b15-ea699b1f2e92", "isCompositeSubField": true}, "source": {"type": "SELECT", "label": "Source", "value": null, "isLeaf": true, "fieldMetadataId": "3ba862a0-5453-47b9-9b15-ea699b1f2e92", "isCompositeSubField": true}, "context": {"type": "RAW_JSON", "label": "Context", "value": null, "isLeaf": true, "fieldMetadataId": "3ba862a0-5453-47b9-9b15-ea699b1f2e92", "isCompositeSubField": true}, "workspaceMemberId": {"type": "UUID", "label": "Workspace Member Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "3ba862a0-5453-47b9-9b15-ea699b1f2e92", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "3ba862a0-5453-47b9-9b15-ea699b1f2e92"}, "domainName": {"icon": "IconLink", "type": "LINKS", "label": "Domain Name", "value": {"primaryLinkUrl": {"type": "TEXT", "label": "Primary Link Url", "value": "My text", "isLeaf": true, "fieldMetadataId": "f2496f3a-f39f-49f8-9eab-f967d6576e40", "isCompositeSubField": true}, "secondaryLinks": {"type": "RAW_JSON", "label": "Secondary Links", "value": null, "isLeaf": true, "fieldMetadataId": "f2496f3a-f39f-49f8-9eab-f967d6576e40", "isCompositeSubField": true}, "primaryLinkLabel": {"type": "TEXT", "label": "Primary Link Label", "value": "My text", "isLeaf": true, "fieldMetadataId": "f2496f3a-f39f-49f8-9eab-f967d6576e40", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "f2496f3a-f39f-49f8-9eab-f967d6576e40"}, "linkedinLink": {"icon": "IconBrandLinkedin", "type": "LINKS", "label": "Linkedin", "value": {"primaryLinkUrl": {"type": "TEXT", "label": "Primary Link Url", "value": "My text", "isLeaf": true, "fieldMetadataId": "1490b8d6-3f3f-4a95-9077-5d9c080192f2", "isCompositeSubField": true}, "secondaryLinks": {"type": "RAW_JSON", "label": "Secondary Links", "value": null, "isLeaf": true, "fieldMetadataId": "1490b8d6-3f3f-4a95-9077-5d9c080192f2", "isCompositeSubField": true}, "primaryLinkLabel": {"type": "TEXT", "label": "Primary Link Label", "value": "My text", "isLeaf": true, "fieldMetadataId": "1490b8d6-3f3f-4a95-9077-5d9c080192f2", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "1490b8d6-3f3f-4a95-9077-5d9c080192f2"}, "accountOwnerId": {"icon": "IconUserCircle", "type": "UUID", "label": "Account Owner Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "b20c80a8-b163-4946-89bf-fccc4c8248a7"}, "idealCustomerProfile": {"icon": "IconTarget", "type": "BOOLEAN", "label": "ICP", "value": true, "isLeaf": true, "fieldMetadataId": "89cda5da-e569-4a90-8c74-c52ee2f80472"}, "annualRecurringRevenue": {"icon": "IconMoneybag", "type": "CURRENCY", "label": "ARR", "value": {"amountMicros": {"type": "NUMERIC", "label": "Amount Micros", "value": null, "isLeaf": true, "fieldMetadataId": "791f3a9f-b234-4b63-8243-0d3cdc2e92ca", "isCompositeSubField": true}, "currencyCode": {"type": "TEXT", "label": "Currency Code", "value": "My text", "isLeaf": true, "fieldMetadataId": "791f3a9f-b234-4b63-8243-0d3cdc2e92ca", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "791f3a9f-b234-4b63-8243-0d3cdc2e92ca"}}, "object": {"icon": "IconBuildingSkyscraper", "label": "Company", "value": "A company", "isLeaf": true, "fieldIdName": "id", "nameSingular": "company"}, "_outputSchemaType": "RECORD"}, "errorHandlingOptions": {"retryOnFailure": {"value": false}, "continueOnFailure": {"value": false}}}, "__typename": "WorkflowAction", "nextStepIds": ["6f553ea7-b00e-4371-9d88-d8298568a246"]}, {"id": "6f553ea7-b00e-4371-9d88-d8298568a246", "name": "Create Person", "type": "CREATE_RECORD", "valid": false, "settings": {"input": {"objectName": "person", "objectRecord": {"name": {"lastName": "{{6e089bc9-aabd-435f-865f-f31c01c8f4a7.lastName}}", "firstName": "{{6e089bc9-aabd-435f-865f-f31c01c8f4a7.firstName}}"}, "emails": {"primaryEmail": "{{6e089bc9-aabd-435f-865f-f31c01c8f4a7.email}}", "additionalEmails": []}, "company": {"id": "{{0715b6cd-7cc1-4b98-971b-00f54dfe643b.id}}"}}}, "outputSchema": {"fields": {"id": {"icon": "Icon123", "type": "UUID", "label": "Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "31e1074c-19ff-43fa-8b33-2698b2303543"}, "city": {"icon": "IconMap", "type": "TEXT", "label": "City", "value": "My text", "isLeaf": true, "fieldMetadataId": "f382801e-a486-470c-a0d2-c11adaa2122b"}, "name": {"icon": "IconUser", "type": "FULL_NAME", "label": "Name", "value": {"lastName": {"type": "TEXT", "label": "Last Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "21455064-b26f-477e-a8c5-61fba1cf2b7c", "isCompositeSubField": true}, "firstName": {"type": "TEXT", "label": "First Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "21455064-b26f-477e-a8c5-61fba1cf2b7c", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "21455064-b26f-477e-a8c5-61fba1cf2b7c"}, "xLink": {"icon": "IconBrandX", "type": "LINKS", "label": "X", "value": {"primaryLinkUrl": {"type": "TEXT", "label": "Primary Link Url", "value": "My text", "isLeaf": true, "fieldMetadataId": "496d6527-3e40-47f7-90c2-a961ed6bc61f", "isCompositeSubField": true}, "secondaryLinks": {"type": "RAW_JSON", "label": "Secondary Links", "value": null, "isLeaf": true, "fieldMetadataId": "496d6527-3e40-47f7-90c2-a961ed6bc61f", "isCompositeSubField": true}, "primaryLinkLabel": {"type": "TEXT", "label": "Primary Link Label", "value": "My text", "isLeaf": true, "fieldMetadataId": "496d6527-3e40-47f7-90c2-a961ed6bc61f", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "496d6527-3e40-47f7-90c2-a961ed6bc61f"}, "emails": {"icon": "IconMail", "type": "EMAILS", "label": "Emails", "value": {"primaryEmail": {"type": "TEXT", "label": "Primary Email", "value": "My text", "isLeaf": true, "fieldMetadataId": "b64330db-9052-46c7-b5f0-b8de5f214aed", "isCompositeSubField": true}, "additionalEmails": {"type": "RAW_JSON", "label": "Additional Emails", "value": null, "isLeaf": true, "fieldMetadataId": "b64330db-9052-46c7-b5f0-b8de5f214aed", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "b64330db-9052-46c7-b5f0-b8de5f214aed"}, "phones": {"icon": "IconPhone", "type": "PHONES", "label": "Phones", "value": {"additionalPhones": {"type": "RAW_JSON", "label": "Additional Phones", "value": null, "isLeaf": true, "fieldMetadataId": "14f2066d-8a1b-4281-b3eb-6837ddccdc3c", "isCompositeSubField": true}, "primaryPhoneNumber": {"type": "TEXT", "label": "Primary Phone Number", "value": "My text", "isLeaf": true, "fieldMetadataId": "14f2066d-8a1b-4281-b3eb-6837ddccdc3c", "isCompositeSubField": true}, "primaryPhoneCallingCode": {"type": "TEXT", "label": "Primary Phone Calling Code", "value": "My text", "isLeaf": true, "fieldMetadataId": "14f2066d-8a1b-4281-b3eb-6837ddccdc3c", "isCompositeSubField": true}, "primaryPhoneCountryCode": {"type": "TEXT", "label": "Primary Phone Country Code", "value": "My text", "isLeaf": true, "fieldMetadataId": "14f2066d-8a1b-4281-b3eb-6837ddccdc3c", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "14f2066d-8a1b-4281-b3eb-6837ddccdc3c"}, "jobTitle": {"icon": "IconBriefcase", "type": "TEXT", "label": "Job Title", "value": "My text", "isLeaf": true, "fieldMetadataId": "14efd992-f9df-4e37-9fb8-2fd2706e9cc0"}, "avatarUrl": {"icon": "IconFileUpload", "type": "TEXT", "label": "Avatar", "value": "My text", "isLeaf": true, "fieldMetadataId": "46c9dd40-91dc-4784-80a7-227e1f5c3040"}, "companyId": {"icon": "IconBuildingSkyscraper", "type": "UUID", "label": "Company Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "2aa99259-fefd-4c96-8660-029d7eaf7050"}, "createdAt": {"icon": "IconCalendar", "type": "DATE_TIME", "label": "Creation date", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "5d6377af-c259-42b8-990f-2aecee76b735"}, "createdBy": {"icon": "IconCreativeCommonsSa", "type": "ACTOR", "label": "Created by", "value": {"name": {"type": "TEXT", "label": "Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "f33c4cd0-c9ea-4dbc-b6df-c19f5948b459", "isCompositeSubField": true}, "source": {"type": "SELECT", "label": "Source", "value": null, "isLeaf": true, "fieldMetadataId": "f33c4cd0-c9ea-4dbc-b6df-c19f5948b459", "isCompositeSubField": true}, "context": {"type": "RAW_JSON", "label": "Context", "value": null, "isLeaf": true, "fieldMetadataId": "f33c4cd0-c9ea-4dbc-b6df-c19f5948b459", "isCompositeSubField": true}, "workspaceMemberId": {"type": "UUID", "label": "Workspace Member Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "f33c4cd0-c9ea-4dbc-b6df-c19f5948b459", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "f33c4cd0-c9ea-4dbc-b6df-c19f5948b459"}, "deletedAt": {"icon": "IconCalendarMinus", "type": "DATE_TIME", "label": "Deleted at", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "b43ef192-1cdf-48b1-8078-31a45059dfd9"}, "updatedAt": {"icon": "IconCalendarClock", "type": "DATE_TIME", "label": "Last update", "value": "01/23/2025 15:16", "isLeaf": true, "fieldMetadataId": "f3bcb349-a1f6-4df7-b3e8-bd0b583b0f6d"}, "updatedBy": {"icon": "IconUserCircle", "type": "ACTOR", "label": "Updated by", "value": {"name": {"type": "TEXT", "label": "Name", "value": "My text", "isLeaf": true, "fieldMetadataId": "701fc28e-6b61-4315-8a1e-83829a06e3fe", "isCompositeSubField": true}, "source": {"type": "SELECT", "label": "Source", "value": null, "isLeaf": true, "fieldMetadataId": "701fc28e-6b61-4315-8a1e-83829a06e3fe", "isCompositeSubField": true}, "context": {"type": "RAW_JSON", "label": "Context", "value": null, "isLeaf": true, "fieldMetadataId": "701fc28e-6b61-4315-8a1e-83829a06e3fe", "isCompositeSubField": true}, "workspaceMemberId": {"type": "UUID", "label": "Workspace Member Id", "value": "123e4567-e89b-12d3-a456-426614174000", "isLeaf": true, "fieldMetadataId": "701fc28e-6b61-4315-8a1e-83829a06e3fe", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "701fc28e-6b61-4315-8a1e-83829a06e3fe"}, "linkedinLink": {"icon": "IconBrandLinkedin", "type": "LINKS", "label": "Linkedin", "value": {"primaryLinkUrl": {"type": "TEXT", "label": "Primary Link Url", "value": "My text", "isLeaf": true, "fieldMetadataId": "cdf1b3a0-2d56-456c-af74-2fa3fecda88e", "isCompositeSubField": true}, "secondaryLinks": {"type": "RAW_JSON", "label": "Secondary Links", "value": null, "isLeaf": true, "fieldMetadataId": "cdf1b3a0-2d56-456c-af74-2fa3fecda88e", "isCompositeSubField": true}, "primaryLinkLabel": {"type": "TEXT", "label": "Primary Link Label", "value": "My text", "isLeaf": true, "fieldMetadataId": "cdf1b3a0-2d56-456c-af74-2fa3fecda88e", "isCompositeSubField": true}}, "isLeaf": false, "fieldMetadataId": "cdf1b3a0-2d56-456c-af74-2fa3fecda88e"}}}, "errorHandlingOptions": {"retryOnFailure": {"value": false}, "continueOnFailure": {"value": false}}}, "__typename": "WorkflowAction", "nextStepIds": null}]	ACTIVE	1	8b213cac-a68b-4ffe-817a-3ec994e9932d
\.


--
-- Data for Name: workspaceMember; Type: TABLE DATA; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

COPY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember" (id, "createdAt", "updatedAt", "deletedAt", "position", "nameFirstName", "nameLastName", "colorScheme", locale, "avatarUrl", "userEmail", "calendarStartDay", "userId", "timeZone", "dateFormat", "timeFormat", "numberFormat", "availabilityStartTime", "availabilityEndTime", "availabilityHours", "availableDays", "leaveStartDate", "leaveEndDate") FROM stdin;
0f7c9c48-c43e-4010-b786-87fad4ebfb47	2026-02-28 06:08:58.750947+00	2026-02-28 06:09:04.845133+00	\N	0	Arjun	S	System	en		arjunsaji6@gmail.com	7	80d538c7-4037-424f-bb74-c60da39e9b29	system	SYSTEM	SYSTEM	SYSTEM	0000	2400	\N	{MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY}	\N	\N
913aaa02-8d40-4303-be73-e32349a8c9d0	2026-02-28 05:07:17.191346+00	2026-03-02 18:35:52.890901+00	\N	0	Vysakh	RJ	Light	en		visakhrj@gmail.com	7	4b1fd975-bd63-456e-b441-60b020914433	system	SYSTEM	SYSTEM	SYSTEM	0000	2400	\N	{MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY}	\N	\N
fed85579-aad3-4bca-b301-f877957b8c40	2026-02-28 06:06:58.941835+00	2026-03-02 19:21:32.834246+00	\N	0	Vasisht	RJ	Dark	en		vasishtrj@gmail.com	7	a764a0de-fcea-4803-a93e-dbf11f5b4db1	system	SYSTEM	SYSTEM	SYSTEM	00:00	24:00	\N	{MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SUNDAY,SATURDAY}	\N	\N
\.


--
-- Name: _typeorm_migrations_id_seq; Type: SEQUENCE SET; Schema: core; Owner: -
--

SELECT pg_catalog.setval('core._typeorm_migrations_id_seq', 99, true);


--
-- Name: applicationVariable IDX_APPLICATION_VARIABLE_KEY_APPLICATION_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."applicationVariable"
    ADD CONSTRAINT "IDX_APPLICATION_VARIABLE_KEY_APPLICATION_ID_UNIQUE" UNIQUE (key, "applicationId");


--
-- Name: approvedAccessDomain IDX_APPROVED_ACCESS_DOMAIN_DOMAIN_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."approvedAccessDomain"
    ADD CONSTRAINT "IDX_APPROVED_ACCESS_DOMAIN_DOMAIN_WORKSPACE_ID_UNIQUE" UNIQUE (domain, "workspaceId");


--
-- Name: emailingDomain IDX_EMAILING_DOMAIN_DOMAIN_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."emailingDomain"
    ADD CONSTRAINT "IDX_EMAILING_DOMAIN_DOMAIN_WORKSPACE_ID_UNIQUE" UNIQUE (domain, "workspaceId");


--
-- Name: featureFlag IDX_FEATURE_FLAG_KEY_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."featureFlag"
    ADD CONSTRAINT "IDX_FEATURE_FLAG_KEY_WORKSPACE_ID_UNIQUE" UNIQUE (key, "workspaceId");


--
-- Name: fieldMetadata IDX_FIELD_METADATA_NAME_OBJECT_METADATA_ID_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "IDX_FIELD_METADATA_NAME_OBJECT_METADATA_ID_WORKSPACE_ID_UNIQUE" UNIQUE (name, "objectMetadataId", "workspaceId");


--
-- Name: fieldPermission IDX_FIELD_PERMISSION_FIELD_METADATA_ID_ROLE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "IDX_FIELD_PERMISSION_FIELD_METADATA_ID_ROLE_ID_UNIQUE" UNIQUE ("fieldMetadataId", "roleId");


--
-- Name: indexMetadata IDX_INDEX_METADATA_NAME_WORKSPACE_ID_OBJECT_METADATA_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexMetadata"
    ADD CONSTRAINT "IDX_INDEX_METADATA_NAME_WORKSPACE_ID_OBJECT_METADATA_ID_UNIQUE" UNIQUE (name, "workspaceId", "objectMetadataId");


--
-- Name: keyValuePair IDX_KEY_VALUE_PAIR_KEY_USER_ID_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."keyValuePair"
    ADD CONSTRAINT "IDX_KEY_VALUE_PAIR_KEY_USER_ID_WORKSPACE_ID_UNIQUE" UNIQUE (key, "userId", "workspaceId");


--
-- Name: objectMetadata IDX_OBJECT_METADATA_NAME_PLURAL_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "IDX_OBJECT_METADATA_NAME_PLURAL_WORKSPACE_ID_UNIQUE" UNIQUE ("namePlural", "workspaceId");


--
-- Name: objectMetadata IDX_OBJECT_METADATA_NAME_SINGULAR_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "IDX_OBJECT_METADATA_NAME_SINGULAR_WORKSPACE_ID_UNIQUE" UNIQUE ("nameSingular", "workspaceId");


--
-- Name: objectPermission IDX_OBJECT_PERMISSION_OBJECT_METADATA_ID_ROLE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectPermission"
    ADD CONSTRAINT "IDX_OBJECT_PERMISSION_OBJECT_METADATA_ID_ROLE_ID_UNIQUE" UNIQUE ("objectMetadataId", "roleId");


--
-- Name: permissionFlag IDX_PERMISSION_FLAG_FLAG_ROLE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."permissionFlag"
    ADD CONSTRAINT "IDX_PERMISSION_FLAG_FLAG_ROLE_ID_UNIQUE" UNIQUE (flag, "roleId");


--
-- Name: role IDX_ROLE_LABEL_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT "IDX_ROLE_LABEL_WORKSPACE_ID_UNIQUE" UNIQUE (label, "workspaceId");


--
-- Name: roleTarget IDX_ROLE_TARGET_UNIQUE_AGENT; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "IDX_ROLE_TARGET_UNIQUE_AGENT" UNIQUE ("workspaceId", "agentId");


--
-- Name: roleTarget IDX_ROLE_TARGET_UNIQUE_API_KEY; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "IDX_ROLE_TARGET_UNIQUE_API_KEY" UNIQUE ("workspaceId", "apiKeyId");


--
-- Name: roleTarget IDX_ROLE_TARGET_UNIQUE_USER_WORKSPACE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "IDX_ROLE_TARGET_UNIQUE_USER_WORKSPACE" UNIQUE ("workspaceId", "userWorkspaceId");


--
-- Name: routeTrigger IDX_ROUTE_TRIGGER_PATH_HTTP_METHOD_WORKSPACE_ID_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."routeTrigger"
    ADD CONSTRAINT "IDX_ROUTE_TRIGGER_PATH_HTTP_METHOD_WORKSPACE_ID_UNIQUE" UNIQUE (path, "httpMethod", "workspaceId");


--
-- Name: searchFieldMetadata IDX_SEARCH_FIELD_METADATA_OBJECT_FIELD_UNIQUE; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."searchFieldMetadata"
    ADD CONSTRAINT "IDX_SEARCH_FIELD_METADATA_OBJECT_FIELD_UNIQUE" UNIQUE ("objectMetadataId", "fieldMetadataId");


--
-- Name: searchFieldMetadata PK_085190eb7531f4aeb8ccab3f42c; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."searchFieldMetadata"
    ADD CONSTRAINT "PK_085190eb7531f4aeb8ccab3f42c" PRIMARY KEY (id);


--
-- Name: routeTrigger PK_08affcd076e46415e5821acf52d; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."routeTrigger"
    ADD CONSTRAINT "PK_08affcd076e46415e5821acf52d" PRIMARY KEY (id);


--
-- Name: viewFilter PK_09f9ffa2f66263b9eb301460137; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "PK_09f9ffa2f66263b9eb301460137" PRIMARY KEY (id);


--
-- Name: agentTurn PK_0e3f599ba7cf6a02fc940d9f18d; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentTurn"
    ADD CONSTRAINT "PK_0e3f599ba7cf6a02fc940d9f18d" PRIMARY KEY (id);


--
-- Name: roleTarget PK_0fe0b3be0a4a966e76c00f44df9; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "PK_0fe0b3be0a4a966e76c00f44df9" PRIMARY KEY (id);


--
-- Name: agent PK_1000e989398c5d4ed585cf9a46f; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.agent
    ADD CONSTRAINT "PK_1000e989398c5d4ed585cf9a46f" PRIMARY KEY (id);


--
-- Name: appToken PK_143bfe36c6284c6d3a52c94741f; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."appToken"
    ADD CONSTRAINT "PK_143bfe36c6284c6d3a52c94741f" PRIMARY KEY (id);


--
-- Name: cronTrigger PK_153e054abdb2663942d4661e3bb; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."cronTrigger"
    ADD CONSTRAINT "PK_153e054abdb2663942d4661e3bb" PRIMARY KEY (id);


--
-- Name: viewFilterGroup PK_16f55359d609168b826405ed307; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilterGroup"
    ADD CONSTRAINT "PK_16f55359d609168b826405ed307" PRIMARY KEY (id);


--
-- Name: userWorkspace PK_222871f3641385e36e0b9f82aeb; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."userWorkspace"
    ADD CONSTRAINT "PK_222871f3641385e36e0b9f82aeb" PRIMARY KEY (id);


--
-- Name: objectPermission PK_23a4033c1aa380d0d1431731add; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectPermission"
    ADD CONSTRAINT "PK_23a4033c1aa380d0d1431731add" PRIMARY KEY (id);


--
-- Name: apiKey PK_2ae3a5e8e04fb402b2dc8d6ce4b; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."apiKey"
    ADD CONSTRAINT "PK_2ae3a5e8e04fb402b2dc8d6ce4b" PRIMARY KEY (id);


--
-- Name: pageLayoutWidget PK_2f997489b8b15cb26a0b9d4220b; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutWidget"
    ADD CONSTRAINT "PK_2f997489b8b15cb26a0b9d4220b" PRIMARY KEY (id);


--
-- Name: databaseEventTrigger PK_30dd6c9713cb9dc86d75211d84c; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."databaseEventTrigger"
    ADD CONSTRAINT "PK_30dd6c9713cb9dc86d75211d84c" PRIMARY KEY (id);


--
-- Name: file PK_36b46d232307066b3a2c9ea3a1d; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.file
    ADD CONSTRAINT "PK_36b46d232307066b3a2c9ea3a1d" PRIMARY KEY (id);


--
-- Name: postgresCredentials PK_3f9c4cdf895bfea0a6ea15bdd81; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."postgresCredentials"
    ADD CONSTRAINT "PK_3f9c4cdf895bfea0a6ea15bdd81" PRIMARY KEY (id);


--
-- Name: serverlessFunction PK_49bfacee064bee9d0d486483b60; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunction"
    ADD CONSTRAINT "PK_49bfacee064bee9d0d486483b60" PRIMARY KEY (id);


--
-- Name: pageLayout PK_5028ccb46ffa0c945d2f9246dfa; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayout"
    ADD CONSTRAINT "PK_5028ccb46ffa0c945d2f9246dfa" PRIMARY KEY (id);


--
-- Name: rowLevelPermissionPredicateGroup PK_5084d63eb632c38d70b974841f3; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "PK_5084d63eb632c38d70b974841f3" PRIMARY KEY (id);


--
-- Name: approvedAccessDomain PK_523281ce57c84e1a039f4538c19; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."approvedAccessDomain"
    ADD CONSTRAINT "PK_523281ce57c84e1a039f4538c19" PRIMARY KEY (id);


--
-- Name: application PK_569e0c3e863ebdf5f2408ee1670; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.application
    ADD CONSTRAINT "PK_569e0c3e863ebdf5f2408ee1670" PRIMARY KEY (id);


--
-- Name: indexFieldMetadata PK_5928f67e43eff7d95aa79fd96fd; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexFieldMetadata"
    ADD CONSTRAINT "PK_5928f67e43eff7d95aa79fd96fd" PRIMARY KEY (id);


--
-- Name: applicationVariable PK_62f7823eb5f1e416c9d60614dfb; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."applicationVariable"
    ADD CONSTRAINT "PK_62f7823eb5f1e416c9d60614dfb" PRIMARY KEY (id);


--
-- Name: dataSource PK_6d01ae6c0f47baf4f8e37342268; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."dataSource"
    ADD CONSTRAINT "PK_6d01ae6c0f47baf4f8e37342268" PRIMARY KEY (id);


--
-- Name: agentMessagePart PK_7e8c9f0b1a2b3c4d5e6f7a8b9c0; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentMessagePart"
    ADD CONSTRAINT "PK_7e8c9f0b1a2b3c4d5e6f7a8b9c0" PRIMARY KEY (id);


--
-- Name: objectMetadata PK_81fb7f4f4244211cfbd188af1e8; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "PK_81fb7f4f4244211cfbd188af1e8" PRIMARY KEY (id);


--
-- Name: agentChatThread PK_82f67c93227868769e9553f059e; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentChatThread"
    ADD CONSTRAINT "PK_82f67c93227868769e9553f059e" PRIMARY KEY (id);


--
-- Name: frontComponent PK_843479d93ef40e58dc4587339aa; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."frontComponent"
    ADD CONSTRAINT "PK_843479d93ef40e58dc4587339aa" PRIMARY KEY (id);


--
-- Name: view PK_86cfb9e426c77d60b900fe2b543; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "PK_86cfb9e426c77d60b900fe2b543" PRIMARY KEY (id);


--
-- Name: featureFlag PK_894efa1b1822de801f3b9e04069; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."featureFlag"
    ADD CONSTRAINT "PK_894efa1b1822de801f3b9e04069" PRIMARY KEY (id);


--
-- Name: agentMessage PK_8c2e7b0c3c9e1b7a9e5e3f4d5c6; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentMessage"
    ADD CONSTRAINT "PK_8c2e7b0c3c9e1b7a9e5e3f4d5c6" PRIMARY KEY (id);


--
-- Name: permissionFlag PK_a02789db60620a1e9f90147b50f; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."permissionFlag"
    ADD CONSTRAINT "PK_a02789db60620a1e9f90147b50f" PRIMARY KEY (id);


--
-- Name: serverlessFunctionLayer PK_a1077708d1b19463ab2eda7c246; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunctionLayer"
    ADD CONSTRAINT "PK_a1077708d1b19463ab2eda7c246" PRIMARY KEY (id);


--
-- Name: workspaceSSOIdentityProvider PK_a4e3928eb641e7cd612042b628b; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."workspaceSSOIdentityProvider"
    ADD CONSTRAINT "PK_a4e3928eb641e7cd612042b628b" PRIMARY KEY (id);


--
-- Name: skill PK_a5167c44f4d4e61423f7f5e43bf; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.skill
    ADD CONSTRAINT "PK_a5167c44f4d4e61423f7f5e43bf" PRIMARY KEY (id);


--
-- Name: _typeorm_migrations PK_a6ff2a8e8bb563f3d15635efd01; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core._typeorm_migrations
    ADD CONSTRAINT "PK_a6ff2a8e8bb563f3d15635efd01" PRIMARY KEY (id);


--
-- Name: agentTurnEvaluation PK_agentTurnEvaluation; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentTurnEvaluation"
    ADD CONSTRAINT "PK_agentTurnEvaluation" PRIMARY KEY (id);


--
-- Name: role PK_b36bcfe02fc8de3c57a8b2391c2; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT "PK_b36bcfe02fc8de3c57a8b2391c2" PRIMARY KEY (id);


--
-- Name: viewField PK_ba2a5aa5f0bd7ac82788fae921e; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewField"
    ADD CONSTRAINT "PK_ba2a5aa5f0bd7ac82788fae921e" PRIMARY KEY (id);


--
-- Name: twoFactorAuthenticationMethod PK_c455f6a499e7110fc95e4bea540; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."twoFactorAuthenticationMethod"
    ADD CONSTRAINT "PK_c455f6a499e7110fc95e4bea540" PRIMARY KEY (id);


--
-- Name: keyValuePair PK_c5a1ca828435d3eaf8f9361ed4b; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."keyValuePair"
    ADD CONSTRAINT "PK_c5a1ca828435d3eaf8f9361ed4b" PRIMARY KEY (id);


--
-- Name: workspace PK_ca86b6f9b3be5fe26d307d09b49; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.workspace
    ADD CONSTRAINT "PK_ca86b6f9b3be5fe26d307d09b49" PRIMARY KEY (id);


--
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- Name: fieldMetadata PK_d046b1c7cea325ebc4cdc25e7a9; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "PK_d046b1c7cea325ebc4cdc25e7a9" PRIMARY KEY (id);


--
-- Name: viewGroup PK_d2aa8cad01e9d5e99c23f9ccec3; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewGroup"
    ADD CONSTRAINT "PK_d2aa8cad01e9d5e99c23f9ccec3" PRIMARY KEY (id);


--
-- Name: fieldPermission PK_d7bb911e4f9b1b5e3bfcfdd1c4b; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "PK_d7bb911e4f9b1b5e3bfcfdd1c4b" PRIMARY KEY (id);


--
-- Name: navigationMenuItem PK_d8689756f55769faea7dc0ae968; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "PK_d8689756f55769faea7dc0ae968" PRIMARY KEY (id);


--
-- Name: emailingDomain PK_dca7032537b5d307f8cc6d74f1d; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."emailingDomain"
    ADD CONSTRAINT "PK_dca7032537b5d307f8cc6d74f1d" PRIMARY KEY (id);


--
-- Name: webhook PK_e6765510c2d078db49632b59020; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.webhook
    ADD CONSTRAINT "PK_e6765510c2d078db49632b59020" PRIMARY KEY (id);


--
-- Name: rowLevelPermissionPredicate PK_e7ac2b75856fc7f300b5feb0e39; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "PK_e7ac2b75856fc7f300b5feb0e39" PRIMARY KEY (id);


--
-- Name: viewSort PK_eceb74d297f926313af6463d496; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewSort"
    ADD CONSTRAINT "PK_eceb74d297f926313af6463d496" PRIMARY KEY (id);


--
-- Name: pageLayoutTab PK_f1327f6ea950cdc59fe17569c5c; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutTab"
    ADD CONSTRAINT "PK_f1327f6ea950cdc59fe17569c5c" PRIMARY KEY (id);


--
-- Name: indexMetadata PK_f73bb3c3678aee204e341f0ca4e; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexMetadata"
    ADD CONSTRAINT "PK_f73bb3c3678aee204e341f0ca4e" PRIMARY KEY (id);


--
-- Name: commandMenuItem PK_fd076dc869e721593133fe8a007; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."commandMenuItem"
    ADD CONSTRAINT "PK_fd076dc869e721593133fe8a007" PRIMARY KEY (id);


--
-- Name: publicDomain PK_ff55a0f1bc3b6e2c32feff734b1; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."publicDomain"
    ADD CONSTRAINT "PK_ff55a0f1bc3b6e2c32feff734b1" PRIMARY KEY (id);


--
-- Name: fieldMetadata REL_47a6c57e1652b6475f8248cff7; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "REL_47a6c57e1652b6475f8248cff7" UNIQUE ("relationTargetFieldMetadataId");


--
-- Name: publicDomain UQ_1311e24fbd049c561c53a274f2a; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."publicDomain"
    ADD CONSTRAINT "UQ_1311e24fbd049c561c53a274f2a" UNIQUE (domain);


--
-- Name: workspace UQ_900f0a3eb789159c26c8bcb39cd; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.workspace
    ADD CONSTRAINT "UQ_900f0a3eb789159c26c8bcb39cd" UNIQUE ("customDomain");


--
-- Name: workspace UQ_cba6255a24deb1fff07dd7351b8; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.workspace
    ADD CONSTRAINT "UQ_cba6255a24deb1fff07dd7351b8" UNIQUE (subdomain);


--
-- Name: _customer _customer_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer
    ADD CONSTRAINT _customer_pkey PRIMARY KEY (id);


--
-- Name: _lead _lead_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead
    ADD CONSTRAINT _lead_pkey PRIMARY KEY (id);


--
-- Name: _origin _origin_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin
    ADD CONSTRAINT _origin_pkey PRIMARY KEY (id);


--
-- Name: _property _property_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._property
    ADD CONSTRAINT _property_pkey PRIMARY KEY (id);


--
-- Name: attachment attachment_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);


--
-- Name: blocklist blocklist_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.blocklist
    ADD CONSTRAINT blocklist_pkey PRIMARY KEY (id);


--
-- Name: calendarChannelEventAssociation calendarChannelEventAssociation_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation"
    ADD CONSTRAINT "calendarChannelEventAssociation_pkey" PRIMARY KEY (id);


--
-- Name: calendarChannel calendarChannel_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel"
    ADD CONSTRAINT "calendarChannel_pkey" PRIMARY KEY (id);


--
-- Name: calendarEventParticipant calendarEventParticipant_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant"
    ADD CONSTRAINT "calendarEventParticipant_pkey" PRIMARY KEY (id);


--
-- Name: calendarEvent calendarEvent_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEvent"
    ADD CONSTRAINT "calendarEvent_pkey" PRIMARY KEY (id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: connectedAccount connectedAccount_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount"
    ADD CONSTRAINT "connectedAccount_pkey" PRIMARY KEY (id);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (id);


--
-- Name: favoriteFolder favoriteFolder_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."favoriteFolder"
    ADD CONSTRAINT "favoriteFolder_pkey" PRIMARY KEY (id);


--
-- Name: favorite favorite_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (id);


--
-- Name: messageChannelMessageAssociation messageChannelMessageAssociation_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation"
    ADD CONSTRAINT "messageChannelMessageAssociation_pkey" PRIMARY KEY (id);


--
-- Name: messageChannel messageChannel_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel"
    ADD CONSTRAINT "messageChannel_pkey" PRIMARY KEY (id);


--
-- Name: messageFolder messageFolder_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder"
    ADD CONSTRAINT "messageFolder_pkey" PRIMARY KEY (id);


--
-- Name: messageParticipant messageParticipant_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant"
    ADD CONSTRAINT "messageParticipant_pkey" PRIMARY KEY (id);


--
-- Name: messageThread messageThread_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageThread"
    ADD CONSTRAINT "messageThread_pkey" PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: noteTarget noteTarget_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "noteTarget_pkey" PRIMARY KEY (id);


--
-- Name: note note_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id);


--
-- Name: opportunity opportunity_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity
    ADD CONSTRAINT opportunity_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: taskTarget taskTarget_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "taskTarget_pkey" PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: timelineActivity timelineActivity_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "timelineActivity_pkey" PRIMARY KEY (id);


--
-- Name: workflowAutomatedTrigger workflowAutomatedTrigger_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger"
    ADD CONSTRAINT "workflowAutomatedTrigger_pkey" PRIMARY KEY (id);


--
-- Name: workflowRun workflowRun_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun"
    ADD CONSTRAINT "workflowRun_pkey" PRIMARY KEY (id);


--
-- Name: workflowVersion workflowVersion_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion"
    ADD CONSTRAINT "workflowVersion_pkey" PRIMARY KEY (id);


--
-- Name: workflow workflow_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- Name: workspaceMember workspaceMember_pkey; Type: CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"
    ADD CONSTRAINT "workspaceMember_pkey" PRIMARY KEY (id);


--
-- Name: IDX_0082568653b80c15903c5a2ba9; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_0082568653b80c15903c5a2ba9" ON core."roleTarget" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_0cc4d03dbcc269e77ba4d297fb; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_0cc4d03dbcc269e77ba4d297fb" ON core.agent USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_256fabec226411154baba649df; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_256fabec226411154baba649df" ON core."pageLayout" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_2909f5139c479e4632df03fd5e; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_2909f5139c479e4632df03fd5e" ON core."twoFactorAuthenticationMethod" USING btree ("userWorkspaceId", strategy);


--
-- Name: IDX_2a33a0e7e44c393ca7bb578dae; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_2a33a0e7e44c393ca7bb578dae" ON core."pageLayoutWidget" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_2aff9daad5cc3b5e15ca717334; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_2aff9daad5cc3b5e15ca717334" ON core."agentMessagePart" USING btree ("messageId");


--
-- Name: IDX_3763c4e8f942ff1e24040a13a9; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_3763c4e8f942ff1e24040a13a9" ON core."pageLayoutTab" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_38232fc0c6567ed029c2b1a12c; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_38232fc0c6567ed029c2b1a12c" ON core."viewSort" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_3a00d35710f4227ded320fd96d; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_3a00d35710f4227ded320fd96d" ON core."objectMetadata" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_3b7ff27925c0959777682c1adc; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_3b7ff27925c0959777682c1adc" ON core.role USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_3bd935d6f8c5ce87194b8db824; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_3bd935d6f8c5ce87194b8db824" ON core."agentChatThread" USING btree ("userWorkspaceId");


--
-- Name: IDX_3be906dca9d5b50fbfe40e33f0; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_3be906dca9d5b50fbfe40e33f0" ON core."agentTurn" USING btree ("threadId");


--
-- Name: IDX_48c75cb32ff0d2887ef0dc547f; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_48c75cb32ff0d2887ef0dc547f" ON core."agentMessage" USING btree ("agentId");


--
-- Name: IDX_4c31daa882e3130534995bf90c; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_4c31daa882e3130534995bf90c" ON core."agentMessage" USING btree ("threadId");


--
-- Name: IDX_4d8beaebdfcd5d82ebe6e8b58f; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_4d8beaebdfcd5d82ebe6e8b58f" ON core."navigationMenuItem" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_552aa6908966e980099b3e5ebf; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_552aa6908966e980099b3e5ebf" ON core.view USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_5b43e65e322d516c9307bed97a; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_5b43e65e322d516c9307bed97a" ON core."serverlessFunction" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_87dbab10ac94d9a091f8efaa67; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_87dbab10ac94d9a091f8efaa67" ON core."agentMessage" USING btree ("turnId");


--
-- Name: IDX_8adc1fd6cb0dad2fbfd945954d; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_8adc1fd6cb0dad2fbfd945954d" ON core."cronTrigger" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_960465af116edf9ac501bfb3db; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_960465af116edf9ac501bfb3db" ON core."databaseEventTrigger" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_AGENT_ID_DELETED_AT; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_AGENT_ID_DELETED_AT" ON core.agent USING btree (id, "deletedAt");


--
-- Name: IDX_AGENT_NAME_WORKSPACE_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_AGENT_NAME_WORKSPACE_ID_UNIQUE" ON core.agent USING btree (name, "workspaceId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_API_KEY_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_API_KEY_WORKSPACE_ID" ON core."apiKey" USING btree ("workspaceId");


--
-- Name: IDX_APPLICATION_UNIVERSAL_IDENTIFIER_WORKSPACE_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_APPLICATION_UNIVERSAL_IDENTIFIER_WORKSPACE_ID_UNIQUE" ON core.application USING btree ("universalIdentifier", "workspaceId") WHERE (("deletedAt" IS NULL) AND ("universalIdentifier" IS NOT NULL));


--
-- Name: IDX_APPLICATION_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_APPLICATION_WORKSPACE_ID" ON core.application USING btree ("workspaceId");


--
-- Name: IDX_COMMAND_MENU_ITEM_AVAILABILITY_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_COMMAND_MENU_ITEM_AVAILABILITY_OBJECT_METADATA_ID" ON core."commandMenuItem" USING btree ("availabilityObjectMetadataId");


--
-- Name: IDX_COMMAND_MENU_ITEM_WORKFLOW_VERSION_ID_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_COMMAND_MENU_ITEM_WORKFLOW_VERSION_ID_WORKSPACE_ID" ON core."commandMenuItem" USING btree ("workflowVersionId", "workspaceId");


--
-- Name: IDX_CRON_TRIGGER_SERVERLESS_FUNCTION_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_CRON_TRIGGER_SERVERLESS_FUNCTION_ID" ON core."cronTrigger" USING btree ("serverlessFunctionId");


--
-- Name: IDX_CRON_TRIGGER_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_CRON_TRIGGER_WORKSPACE_ID" ON core."cronTrigger" USING btree ("workspaceId");


--
-- Name: IDX_DATABASE_EVENT_TRIGGER_SERVERLESS_FUNCTION_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_DATABASE_EVENT_TRIGGER_SERVERLESS_FUNCTION_ID" ON core."databaseEventTrigger" USING btree ("serverlessFunctionId");


--
-- Name: IDX_DATABASE_EVENT_TRIGGER_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_DATABASE_EVENT_TRIGGER_WORKSPACE_ID" ON core."databaseEventTrigger" USING btree ("workspaceId");


--
-- Name: IDX_DATA_SOURCE_WORKSPACE_ID_CREATED_AT; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_DATA_SOURCE_WORKSPACE_ID_CREATED_AT" ON core."dataSource" USING btree ("workspaceId", "createdAt");


--
-- Name: IDX_FIELD_METADATA_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_METADATA_OBJECT_METADATA_ID" ON core."fieldMetadata" USING btree ("objectMetadataId");


--
-- Name: IDX_FIELD_METADATA_OBJECT_METADATA_ID_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_METADATA_OBJECT_METADATA_ID_WORKSPACE_ID" ON core."fieldMetadata" USING btree ("objectMetadataId", "workspaceId");


--
-- Name: IDX_FIELD_METADATA_RELATION_TARGET_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_METADATA_RELATION_TARGET_FIELD_METADATA_ID" ON core."fieldMetadata" USING btree ("relationTargetFieldMetadataId");


--
-- Name: IDX_FIELD_METADATA_RELATION_TARGET_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_METADATA_RELATION_TARGET_OBJECT_METADATA_ID" ON core."fieldMetadata" USING btree ("relationTargetObjectMetadataId");


--
-- Name: IDX_FIELD_METADATA_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_METADATA_WORKSPACE_ID" ON core."fieldMetadata" USING btree ("workspaceId");


--
-- Name: IDX_FIELD_PERMISSION_WORKSPACE_ID_ROLE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FIELD_PERMISSION_WORKSPACE_ID_ROLE_ID" ON core."fieldPermission" USING btree ("workspaceId", "roleId");


--
-- Name: IDX_FILE_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_FILE_WORKSPACE_ID" ON core.file USING btree ("workspaceId");


--
-- Name: IDX_INDEX_FIELD_METADATA_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_INDEX_FIELD_METADATA_FIELD_METADATA_ID" ON core."indexFieldMetadata" USING btree ("fieldMetadataId");


--
-- Name: IDX_INDEX_METADATA_WORKSPACE_ID_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_INDEX_METADATA_WORKSPACE_ID_OBJECT_METADATA_ID" ON core."indexMetadata" USING btree ("workspaceId", "objectMetadataId");


--
-- Name: IDX_KEY_VALUE_PAIR_KEY_USER_ID_NULL_WORKSPACE_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_KEY_VALUE_PAIR_KEY_USER_ID_NULL_WORKSPACE_ID_UNIQUE" ON core."keyValuePair" USING btree (key, "userId") WHERE ("workspaceId" IS NULL);


--
-- Name: IDX_KEY_VALUE_PAIR_KEY_WORKSPACE_ID_NULL_USER_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_KEY_VALUE_PAIR_KEY_WORKSPACE_ID_NULL_USER_ID_UNIQUE" ON core."keyValuePair" USING btree (key, "workspaceId") WHERE ("userId" IS NULL);


--
-- Name: IDX_NAVIGATION_MENU_ITEM_FOLDER_ID_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_NAVIGATION_MENU_ITEM_FOLDER_ID_WORKSPACE_ID" ON core."navigationMenuItem" USING btree ("folderId", "workspaceId");


--
-- Name: IDX_NAVIGATION_MENU_ITEM_TARGET_RECORD_OBJ_METADATA_WS_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_NAVIGATION_MENU_ITEM_TARGET_RECORD_OBJ_METADATA_WS_ID" ON core."navigationMenuItem" USING btree ("targetRecordId", "targetObjectMetadataId", "workspaceId");


--
-- Name: IDX_NAVIGATION_MENU_ITEM_USER_WORKSPACE_ID_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_NAVIGATION_MENU_ITEM_USER_WORKSPACE_ID_WORKSPACE_ID" ON core."navigationMenuItem" USING btree ("userWorkspaceId", "workspaceId");


--
-- Name: IDX_NAVIGATION_MENU_ITEM_VIEW_ID_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_NAVIGATION_MENU_ITEM_VIEW_ID_WORKSPACE_ID" ON core."navigationMenuItem" USING btree ("viewId", "workspaceId");


--
-- Name: IDX_OBJECT_METADATA_DATA_SOURCE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_OBJECT_METADATA_DATA_SOURCE_ID" ON core."objectMetadata" USING btree ("dataSourceId");


--
-- Name: IDX_OBJECT_PERMISSION_WORKSPACE_ID_ROLE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_OBJECT_PERMISSION_WORKSPACE_ID_ROLE_ID" ON core."objectPermission" USING btree ("workspaceId", "roleId");


--
-- Name: IDX_PAGE_LAYOUT_TAB_WORKSPACE_ID_PAGE_LAYOUT_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_PAGE_LAYOUT_TAB_WORKSPACE_ID_PAGE_LAYOUT_ID" ON core."pageLayoutTab" USING btree ("workspaceId", "pageLayoutId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_PAGE_LAYOUT_WIDGET_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_PAGE_LAYOUT_WIDGET_OBJECT_METADATA_ID" ON core."pageLayoutWidget" USING btree ("objectMetadataId");


--
-- Name: IDX_PAGE_LAYOUT_WIDGET_WORKSPACE_ID_PAGE_LAYOUT_TAB_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_PAGE_LAYOUT_WIDGET_WORKSPACE_ID_PAGE_LAYOUT_TAB_ID" ON core."pageLayoutWidget" USING btree ("workspaceId", "pageLayoutTabId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_PAGE_LAYOUT_WORKSPACE_ID_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_PAGE_LAYOUT_WORKSPACE_ID_OBJECT_METADATA_ID" ON core."pageLayout" USING btree ("workspaceId", "objectMetadataId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_RLPPG_PARENT_GROUP_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPPG_PARENT_GROUP_ID" ON core."rowLevelPermissionPredicateGroup" USING btree ("parentRowLevelPermissionPredicateGroupId");


--
-- Name: IDX_RLPPG_WORKSPACE_ID_ROLE_ID_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPPG_WORKSPACE_ID_ROLE_ID_OBJECT_METADATA_ID" ON core."rowLevelPermissionPredicateGroup" USING btree ("workspaceId", "roleId", "objectMetadataId");


--
-- Name: IDX_RLPP_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPP_FIELD_METADATA_ID" ON core."rowLevelPermissionPredicate" USING btree ("fieldMetadataId");


--
-- Name: IDX_RLPP_GROUP_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPP_GROUP_ID" ON core."rowLevelPermissionPredicate" USING btree ("rowLevelPermissionPredicateGroupId");


--
-- Name: IDX_RLPP_WORKSPACE_ID_ROLE_ID_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPP_WORKSPACE_ID_ROLE_ID_OBJECT_METADATA_ID" ON core."rowLevelPermissionPredicate" USING btree ("workspaceId", "roleId", "objectMetadataId");


--
-- Name: IDX_RLPP_WORKSPACE_MEMBER_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_RLPP_WORKSPACE_MEMBER_FIELD_METADATA_ID" ON core."rowLevelPermissionPredicate" USING btree ("workspaceMemberFieldMetadataId");


--
-- Name: IDX_ROLE_TARGET_AGENT_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_ROLE_TARGET_AGENT_ID" ON core."roleTarget" USING btree ("agentId");


--
-- Name: IDX_ROLE_TARGET_API_KEY_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_ROLE_TARGET_API_KEY_ID" ON core."roleTarget" USING btree ("apiKeyId");


--
-- Name: IDX_ROLE_TARGET_ROLE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_ROLE_TARGET_ROLE_ID" ON core."roleTarget" USING btree ("roleId");


--
-- Name: IDX_ROLE_TARGET_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_ROLE_TARGET_WORKSPACE_ID" ON core."roleTarget" USING btree ("userWorkspaceId", "workspaceId");


--
-- Name: IDX_ROUTE_TRIGGER_SERVERLESS_FUNCTION_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_ROUTE_TRIGGER_SERVERLESS_FUNCTION_ID" ON core."routeTrigger" USING btree ("serverlessFunctionId");


--
-- Name: IDX_SEARCH_FIELD_METADATA_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_SEARCH_FIELD_METADATA_OBJECT_METADATA_ID" ON core."searchFieldMetadata" USING btree ("objectMetadataId");


--
-- Name: IDX_SEARCH_FIELD_METADATA_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_SEARCH_FIELD_METADATA_WORKSPACE_ID" ON core."searchFieldMetadata" USING btree ("workspaceId");


--
-- Name: IDX_SERVERLESS_FUNCTION_ID_DELETED_AT; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_SERVERLESS_FUNCTION_ID_DELETED_AT" ON core."serverlessFunction" USING btree (id, "deletedAt");


--
-- Name: IDX_SERVERLESS_FUNCTION_LAYER_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_SERVERLESS_FUNCTION_LAYER_ID" ON core."serverlessFunction" USING btree ("serverlessFunctionLayerId");


--
-- Name: IDX_SKILL_ID_IS_ACTIVE; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_SKILL_ID_IS_ACTIVE" ON core.skill USING btree (id, "isActive");


--
-- Name: IDX_SKILL_NAME_WORKSPACE_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_SKILL_NAME_WORKSPACE_ID_UNIQUE" ON core.skill USING btree (name, "workspaceId") WHERE ("isActive" = true);


--
-- Name: IDX_USER_WORKSPACE_USER_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_USER_WORKSPACE_USER_ID" ON core."userWorkspace" USING btree ("userId");


--
-- Name: IDX_USER_WORKSPACE_USER_ID_WORKSPACE_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_USER_WORKSPACE_USER_ID_WORKSPACE_ID_UNIQUE" ON core."userWorkspace" USING btree ("userId", "workspaceId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_USER_WORKSPACE_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_USER_WORKSPACE_WORKSPACE_ID" ON core."userWorkspace" USING btree ("workspaceId");


--
-- Name: IDX_VIEW_CALENDAR_FIELD_METADATA; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_CALENDAR_FIELD_METADATA" ON core.view USING btree ("calendarFieldMetadataId");


--
-- Name: IDX_VIEW_CREATED_BY_USER_WORKSPACE; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_CREATED_BY_USER_WORKSPACE" ON core.view USING btree ("createdByUserWorkspaceId");


--
-- Name: IDX_VIEW_FIELD_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FIELD_FIELD_METADATA_ID" ON core."viewField" USING btree ("fieldMetadataId");


--
-- Name: IDX_VIEW_FIELD_FIELD_METADATA_ID_VIEW_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_VIEW_FIELD_FIELD_METADATA_ID_VIEW_ID_UNIQUE" ON core."viewField" USING btree ("fieldMetadataId", "viewId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_VIEW_FIELD_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FIELD_VIEW_ID" ON core."viewField" USING btree ("viewId");


--
-- Name: IDX_VIEW_FIELD_WORKSPACE_ID_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FIELD_WORKSPACE_ID_VIEW_ID" ON core."viewField" USING btree ("workspaceId", "viewId");


--
-- Name: IDX_VIEW_FILTER_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_FIELD_METADATA_ID" ON core."viewFilter" USING btree ("fieldMetadataId");


--
-- Name: IDX_VIEW_FILTER_GROUP_PARENT_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_GROUP_PARENT_ID" ON core."viewFilterGroup" USING btree ("parentViewFilterGroupId");


--
-- Name: IDX_VIEW_FILTER_GROUP_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_GROUP_VIEW_ID" ON core."viewFilterGroup" USING btree ("viewId");


--
-- Name: IDX_VIEW_FILTER_GROUP_WORKSPACE_ID_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_GROUP_WORKSPACE_ID_VIEW_ID" ON core."viewFilterGroup" USING btree ("workspaceId", "viewId");


--
-- Name: IDX_VIEW_FILTER_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_VIEW_ID" ON core."viewFilter" USING btree ("viewId");


--
-- Name: IDX_VIEW_FILTER_WORKSPACE_ID_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_FILTER_WORKSPACE_ID_VIEW_ID" ON core."viewFilter" USING btree ("workspaceId", "viewId");


--
-- Name: IDX_VIEW_GROUP_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_GROUP_VIEW_ID" ON core."viewGroup" USING btree ("viewId");


--
-- Name: IDX_VIEW_GROUP_WORKSPACE_ID_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_GROUP_WORKSPACE_ID_VIEW_ID" ON core."viewGroup" USING btree ("workspaceId", "viewId");


--
-- Name: IDX_VIEW_KANBAN_FIELD_METADATA; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_KANBAN_FIELD_METADATA" ON core.view USING btree ("kanbanAggregateOperationFieldMetadataId");


--
-- Name: IDX_VIEW_MAIN_GROUP_BY_FIELD_METADATA; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_MAIN_GROUP_BY_FIELD_METADATA" ON core.view USING btree ("mainGroupByFieldMetadataId");


--
-- Name: IDX_VIEW_SORT_FIELD_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_SORT_FIELD_METADATA_ID" ON core."viewSort" USING btree ("fieldMetadataId");


--
-- Name: IDX_VIEW_SORT_FIELD_METADATA_ID_VIEW_ID_UNIQUE; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_VIEW_SORT_FIELD_METADATA_ID_VIEW_ID_UNIQUE" ON core."viewSort" USING btree ("fieldMetadataId", "viewId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_VIEW_SORT_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_SORT_VIEW_ID" ON core."viewSort" USING btree ("viewId");


--
-- Name: IDX_VIEW_SORT_WORKSPACE_ID_VIEW_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_SORT_WORKSPACE_ID_VIEW_ID" ON core."viewSort" USING btree ("workspaceId", "viewId");


--
-- Name: IDX_VIEW_VISIBILITY; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_VISIBILITY" ON core.view USING btree (visibility);


--
-- Name: IDX_VIEW_WORKSPACE_ID_OBJECT_METADATA_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_VIEW_WORKSPACE_ID_OBJECT_METADATA_ID" ON core.view USING btree ("workspaceId", "objectMetadataId");


--
-- Name: IDX_WEBHOOK_WORKSPACE_ID; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_WEBHOOK_WORKSPACE_ID" ON core.webhook USING btree ("workspaceId");


--
-- Name: IDX_WORKSPACE_ACTIVATION_STATUS; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_WORKSPACE_ACTIVATION_STATUS" ON core.workspace USING btree ("activationStatus");


--
-- Name: IDX_a1413f7f0e71cb5825ac40c4fa; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_a1413f7f0e71cb5825ac40c4fa" ON core."frontComponent" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_a14b5665091e86d461fb585924; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_a14b5665091e86d461fb585924" ON core."rowLevelPermissionPredicateGroup" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_a3a5976e1b580ba1086c595802; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_a3a5976e1b580ba1086c595802" ON core."commandMenuItem" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_a44e3b03f0eca32d0504d5ef73; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_a44e3b03f0eca32d0504d5ef73" ON core."viewGroup" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_b27c681286ac581f81498c5d4b; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_b27c681286ac581f81498c5d4b" ON core."indexMetadata" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_b86af4ea24cae518dee8eae996; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_b86af4ea24cae518dee8eae996" ON core."viewField" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_c94f072dbd3c11f7df51db5293; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_c94f072dbd3c11f7df51db5293" ON core."agentTurnEvaluation" USING btree ("turnId");


--
-- Name: IDX_cd4588bfc9ad73345b3953a039; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_cd4588bfc9ad73345b3953a039" ON core."viewFilter" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_e46f3e01227f1c8ee0c8041821; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_e46f3e01227f1c8ee0c8041821" ON core."rowLevelPermissionPredicate" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_e6398c21e6bb31b525272fac84; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_e6398c21e6bb31b525272fac84" ON core.skill USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_e6d7c07f32e6f0f08cf639d4f5; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX "IDX_e6d7c07f32e6f0f08cf639d4f5" ON core."agentTurn" USING btree ("agentId");


--
-- Name: IDX_e6ed40a61e4584e98584019a47; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_e6ed40a61e4584e98584019a47" ON core."viewFilterGroup" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_e9c53b9ac5035d3202a8737020; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_e9c53b9ac5035d3202a8737020" ON core."routeTrigger" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: IDX_f1c88fdfc3ad8910b17fc1fd73; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "IDX_f1c88fdfc3ad8910b17fc1fd73" ON core."fieldMetadata" USING btree ("workspaceId", "universalIdentifier");


--
-- Name: UQ_USER_EMAIL; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX "UQ_USER_EMAIL" ON core."user" USING btree (email) WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_03c5b5ea0ebe0cdd54c16f01cd4; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_03c5b5ea0ebe0cdd54c16f01cd4" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("favoriteFolderId");


--
-- Name: IDX_05aa997ec9e818519e400ba6428; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_05aa997ec9e818519e400ba6428" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead USING btree ("propertyId");


--
-- Name: IDX_0b7f9331eb98fa90a6c21e4e582; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_0b7f9331eb98fa90a6c21e4e582" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead USING btree ("originId");


--
-- Name: IDX_0e8eed53c694ed1404526d9f23a; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_0e8eed53c694ed1404526d9f23a" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("taskId");


--
-- Name: IDX_17f260b2397f21011117688a00c; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_17f260b2397f21011117688a00c" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("workflowRunId");


--
-- Name: IDX_19ad12ae96a5d4357ff3a15ba2b; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_19ad12ae96a5d4357ff3a15ba2b" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant" USING btree ("messageId");


--
-- Name: IDX_1ff229b8237e8368a92c08d11f0; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_1ff229b8237e8368a92c08d11f0" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetTaskId");


--
-- Name: IDX_261d8661b94dbb98cc85cffab46; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_261d8661b94dbb98cc85cffab46" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun" USING gin ("searchVector");


--
-- Name: IDX_26a021921ba73b428be8f244ded; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_26a021921ba73b428be8f244ded" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetNoteId");


--
-- Name: IDX_27e76883626e898b6f872153917; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_27e76883626e898b6f872153917" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("opportunityId");


--
-- Name: IDX_2ae248a51e6d7fb29b65b47a633; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_2ae248a51e6d7fb29b65b47a633" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("noteId");


--
-- Name: IDX_2e85541b739066142845bdef99a; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_2e85541b739066142845bdef99a" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation" USING btree ("messageChannelId");


--
-- Name: IDX_2ef95462446ad1fad48894bd459; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_2ef95462446ad1fad48894bd459" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("opportunityId");


--
-- Name: IDX_352fe024686b6bcf5e7e1b65449; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_352fe024686b6bcf5e7e1b65449" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("workflowVersionId");


--
-- Name: IDX_36f8b958533baaeabdde3479b31; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_36f8b958533baaeabdde3479b31" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("noteId");


--
-- Name: IDX_397bfb7946782933c476b98d925; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_397bfb7946782933c476b98d925" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger" USING btree ("workflowId");


--
-- Name: IDX_3c2578d931b79954786d34a66e3; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_3c2578d931b79954786d34a66e3" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead USING btree ("customerId");


--
-- Name: IDX_3c8bbe54bd34f40dfe2d05ac964; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_3c8bbe54bd34f40dfe2d05ac964" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount" USING btree ("accountOwnerId");


--
-- Name: IDX_3f4c0095cf17b62868bec089fab; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_3f4c0095cf17b62868bec089fab" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation" USING btree ("messageId");


--
-- Name: IDX_40150517e4f1ab6154e426eafce; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_40150517e4f1ab6154e426eafce" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant" USING btree ("calendarEventId");


--
-- Name: IDX_464ad6e30f0a65e9adf06aeefdf; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_464ad6e30f0a65e9adf06aeefdf" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("dashboardId");


--
-- Name: IDX_478dcebf8f1e7b807ddd137a9ca; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_478dcebf8f1e7b807ddd137a9ca" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("companyId");


--
-- Name: IDX_47a5ea9e149973d6ef980bdc4f1; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_47a5ea9e149973d6ef980bdc4f1" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant" USING btree ("personId");


--
-- Name: IDX_4b9feee3298c853326bf6ff8e42; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_4b9feee3298c853326bf6ff8e42" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity USING btree ("companyId");


--
-- Name: IDX_51329bbcdab6618a75361670c26; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_51329bbcdab6618a75361670c26" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion" USING gin ("searchVector");


--
-- Name: IDX_55ce81c272804f98df7989358fd; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_55ce81c272804f98df7989358fd" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead USING gin ("searchVector");


--
-- Name: IDX_58b130a455b1451066c84dc63e2; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_58b130a455b1451066c84dc63e2" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetWorkflowRunId");


--
-- Name: IDX_59b2ccfa622e6d924ab0cd9db55; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_59b2ccfa622e6d924ab0cd9db55" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("workflowId");


--
-- Name: IDX_5c3e2cfc25e814aa84b86885105; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_5c3e2cfc25e814aa84b86885105" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" USING btree ("personId");


--
-- Name: IDX_5d002cd3b5be1cb05c0b7b28582; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_5d002cd3b5be1cb05c0b7b28582" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.message USING btree ("messageThreadId");


--
-- Name: IDX_5d1a679dc009176fa89db7976ee; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_5d1a679dc009176fa89db7976ee" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment USING btree ("personId");


--
-- Name: IDX_62d09af534224aa478109b2d585; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_62d09af534224aa478109b2d585" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetOpportunityId");


--
-- Name: IDX_6805c7ab083ba48f7664d5602a0; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_6805c7ab083ba48f7664d5602a0" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" USING btree ("companyId");


--
-- Name: IDX_6b2a27852dd0e0846577662a33a; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_6b2a27852dd0e0846577662a33a" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetDashboardId");


--
-- Name: IDX_6dbfc4d091e55b676e5f698c2c2; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_6dbfc4d091e55b676e5f698c2c2" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion" USING btree ("workflowId");


--
-- Name: IDX_6e1236c5438bb19bc32315856b2; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_6e1236c5438bb19bc32315856b2" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" USING btree ("personId");


--
-- Name: IDX_70c8cfc3c0c8407789db32ad9cf; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_70c8cfc3c0c8407789db32ad9cf" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant" USING btree ("workspaceMemberId");


--
-- Name: IDX_733381453fca683f36c05af5478; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_733381453fca683f36c05af5478" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation" USING btree ("calendarEventId");


--
-- Name: IDX_74ad70941560ba6b2a179ad460c; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_74ad70941560ba6b2a179ad460c" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" USING btree ("taskId");


--
-- Name: IDX_76e046116d45bcd23167f68d940; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_76e046116d45bcd23167f68d940" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" USING btree ("opportunityId");


--
-- Name: IDX_7a56509bca48a709378017a9135; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_7a56509bca48a709378017a9135" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant" USING btree ("workspaceMemberId");


--
-- Name: IDX_7b40c7f03dd1f998ba765ad0730; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_7b40c7f03dd1f998ba765ad0730" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel" USING btree ("connectedAccountId");


--
-- Name: IDX_7b93282d4e9b5a9851d07829996; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_7b93282d4e9b5a9851d07829996" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("workflowId");


--
-- Name: IDX_7e2582241f3b749d7a43d7d0231; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_7e2582241f3b749d7a43d7d0231" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget" USING btree ("noteId");


--
-- Name: IDX_953cb9c73db904f98697f4867b2; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_953cb9c73db904f98697f4867b2" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetWorkflowVersionId");


--
-- Name: IDX_964ef63518b8f73d7d0b294b3f8; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_964ef63518b8f73d7d0b294b3f8" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin USING gin ("searchVector");


--
-- Name: IDX_968d4fd721a78b75c13a1b9ec12; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_968d4fd721a78b75c13a1b9ec12" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation" USING btree ("calendarChannelId");


--
-- Name: IDX_9a2065c2b56ffe8b74d1a12705f; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9a2065c2b56ffe8b74d1a12705f" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetWorkflowId");


--
-- Name: IDX_9b267fc4a89dd1aaec4c5340f05; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9b267fc4a89dd1aaec4c5340f05" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetCompanyId");


--
-- Name: IDX_9e247b4ab168100e4aa8fb6a853; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9e247b4ab168100e4aa8fb6a853" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.blocklist USING btree ("workspaceMemberId");


--
-- Name: IDX_9f7a699f2e8b7de91da33245144; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9f7a699f2e8b7de91da33245144" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" USING btree ("companyId");


--
-- Name: IDX_9f96d65260c4676faac27cb6bf3; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9f96d65260c4676faac27cb6bf3" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity USING gin ("searchVector");


--
-- Name: IDX_9fdeb410f15f569f2843698c5b3; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_9fdeb410f15f569f2843698c5b3" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun" USING btree ("workflowVersionId");


--
-- Name: IDX_UNIQUE_2a32339058d0b6910b0834ddf81; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE UNIQUE INDEX "IDX_UNIQUE_2a32339058d0b6910b0834ddf81" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.company USING btree ("domainNamePrimaryLinkUrl");


--
-- Name: IDX_UNIQUE_39954942ffa78c957b5dee47739; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE UNIQUE INDEX "IDX_UNIQUE_39954942ffa78c957b5dee47739" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember" USING btree ("userEmail");


--
-- Name: IDX_UNIQUE_87914cd3ce963115f8cb943e2ac; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE UNIQUE INDEX "IDX_UNIQUE_87914cd3ce963115f8cb943e2ac" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.person USING btree ("emailsPrimaryEmail");


--
-- Name: IDX_UNIQUE_eb4d84464c154a790c497570334; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE UNIQUE INDEX "IDX_UNIQUE_eb4d84464c154a790c497570334" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer USING btree ("emailsPrimaryEmail");


--
-- Name: IDX_a1bbe482462d9f016582d99d4e6; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_a1bbe482462d9f016582d99d4e6" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder" USING btree ("messageChannelId");


--
-- Name: IDX_ae09ff97967369e0644bacc0fce; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_ae09ff97967369e0644bacc0fce" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.person USING btree ("companyId");


--
-- Name: IDX_ae112c10e060420923011767b14; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_ae112c10e060420923011767b14" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity USING btree (stage);


--
-- Name: IDX_b313a3bb044d3031121a81c42da; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_b313a3bb044d3031121a81c42da" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer USING gin ("searchVector");


--
-- Name: IDX_b5b4da613fc4d734f65fb1deb6b; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_b5b4da613fc4d734f65fb1deb6b" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.task USING btree ("assigneeId");


--
-- Name: IDX_b633ee61a71e5d326da65d791b6; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_b633ee61a71e5d326da65d791b6" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._property USING gin ("searchVector");


--
-- Name: IDX_ba8418718688702d3113fde2fe1; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_ba8418718688702d3113fde2fe1" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant" USING btree ("personId");


--
-- Name: IDX_bbd7aec1976fc684a0a5e4816c9; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_bbd7aec1976fc684a0a5e4816c9" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.person USING gin ("searchVector");


--
-- Name: IDX_bf1967e8710f32f1a65c67fb4b4; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_bf1967e8710f32f1a65c67fb4b4" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel" USING btree ("connectedAccountId");


--
-- Name: IDX_c0ac950d77b75527f654b7f6a06; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_c0ac950d77b75527f654b7f6a06" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity USING btree ("pointOfContactId");


--
-- Name: IDX_c6a04c62f1b835de81b87c8d5cb; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_c6a04c62f1b835de81b87c8d5cb" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("personId");


--
-- Name: IDX_d01a000cf26e1225d894dc3d364; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_d01a000cf26e1225d894dc3d364" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.task USING gin ("searchVector");


--
-- Name: IDX_d09fc4b1711543f42c127270f1e; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_d09fc4b1711543f42c127270f1e" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow USING gin ("searchVector");


--
-- Name: IDX_d6a852b3d9c7430cd4a9ebcdb37; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_d6a852b3d9c7430cd4a9ebcdb37" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget" USING btree ("opportunityId");


--
-- Name: IDX_d85e3f572ec0d3c406cc58f79af; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_d85e3f572ec0d3c406cc58f79af" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("dashboardId");


--
-- Name: IDX_da56d8b595a778d404eae01f29b; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_da56d8b595a778d404eae01f29b" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation" USING btree ("messageChannelId", "messageId") WHERE ("deletedAt" IS NULL);


--
-- Name: IDX_da8d3b8cffaba31b70b7ead927c; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_da8d3b8cffaba31b70b7ead927c" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead USING btree ("assigneeId");


--
-- Name: IDX_dc68847d0ff0b17baef8fb632c2; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_dc68847d0ff0b17baef8fb632c2" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("workspaceMemberId");


--
-- Name: IDX_e47451872f70c8f187a6b460ac7; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_e47451872f70c8f187a6b460ac7" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember" USING gin ("searchVector");


--
-- Name: IDX_e49dd7da4ed5c919babcd31c93b; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_e49dd7da4ed5c919babcd31c93b" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity" USING btree ("targetPersonId");


--
-- Name: IDX_e6a755f59ac856c2af85d0b1857; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_e6a755f59ac856c2af85d0b1857" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("forWorkspaceMemberId");


--
-- Name: IDX_eced9eb2a6cc8f9a5b49fe4b04e; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_eced9eb2a6cc8f9a5b49fe4b04e" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun" USING btree ("workflowId");


--
-- Name: IDX_f08a4bc49e7422db941d7c1be50; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_f08a4bc49e7422db941d7c1be50" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("taskId");


--
-- Name: IDX_f20de8d7fc74a405e4083051275; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_f20de8d7fc74a405e4083051275" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.note USING gin ("searchVector");


--
-- Name: IDX_f3b76c5322b31cba175b2eccec8; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_f3b76c5322b31cba175b2eccec8" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard USING gin ("searchVector");


--
-- Name: IDX_f54929018ffb0a56df35a15ee1a; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_f54929018ffb0a56df35a15ee1a" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite USING btree ("companyId");


--
-- Name: IDX_f719a95179070eac397ba18dc70; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_f719a95179070eac397ba18dc70" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.company USING btree ("accountOwnerId");


--
-- Name: IDX_fb1f4905546cfc6d70a971c76f7; Type: INDEX; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

CREATE INDEX "IDX_fb1f4905546cfc6d70a971c76f7" ON workspace_9zs4rq4zo2wzg53xjkq5u4qis.company USING gin ("searchVector");


--
-- Name: pageLayoutTab FK_0177b1574efe6e6f24651977340; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutTab"
    ADD CONSTRAINT "FK_0177b1574efe6e6f24651977340" FOREIGN KEY ("pageLayoutId") REFERENCES core."pageLayout"(id) ON DELETE CASCADE;


--
-- Name: navigationMenuItem FK_03c63a0b00ddc3ade21ed0b1a80; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "FK_03c63a0b00ddc3ade21ed0b1a80" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: indexMetadata FK_051487e9b745cb175950130b63f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexMetadata"
    ADD CONSTRAINT "FK_051487e9b745cb175950130b63f" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: fieldMetadata FK_05453a954e458e3d91f2ff5043f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "FK_05453a954e458e3d91f2ff5043f" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: indexMetadata FK_056363e1599f5b9a0e33323d9da; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexMetadata"
    ADD CONSTRAINT "FK_056363e1599f5b9a0e33323d9da" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: cronTrigger FK_058c319eeb9799a4637908ce362; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."cronTrigger"
    ADD CONSTRAINT "FK_058c319eeb9799a4637908ce362" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: pageLayoutWidget FK_0659a4d171c93f5c046f18d24cd; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutWidget"
    ADD CONSTRAINT "FK_0659a4d171c93f5c046f18d24cd" FOREIGN KEY ("pageLayoutTabId") REFERENCES core."pageLayoutTab"(id) ON DELETE CASCADE;


--
-- Name: viewFilter FK_06858adf0fb54ec88fa602198ca; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "FK_06858adf0fb54ec88fa602198ca" FOREIGN KEY ("viewId") REFERENCES core.view(id) ON DELETE CASCADE;


--
-- Name: application FK_08d1d5e33c2a3ce7c140e9b335b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.application
    ADD CONSTRAINT "FK_08d1d5e33c2a3ce7c140e9b335b" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: viewField FK_0a48a0b66daedac1314437be5eb; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewField"
    ADD CONSTRAINT "FK_0a48a0b66daedac1314437be5eb" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: objectMetadata FK_0b19dd17369574578bc18c405b2; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "FK_0b19dd17369574578bc18c405b2" FOREIGN KEY ("dataSourceId") REFERENCES core."dataSource"(id) ON DELETE CASCADE;


--
-- Name: keyValuePair FK_0dae35d1c0fbdda6495be4ae71a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."keyValuePair"
    ADD CONSTRAINT "FK_0dae35d1c0fbdda6495be4ae71a" FOREIGN KEY ("userId") REFERENCES core."user"(id) ON DELETE CASCADE;


--
-- Name: permissionFlag FK_13f8ca9c517976733a1ce4c10eb; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."permissionFlag"
    ADD CONSTRAINT "FK_13f8ca9c517976733a1ce4c10eb" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_15199deab40d48dd1480a2faf85; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_15199deab40d48dd1480a2faf85" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: navigationMenuItem FK_175fc64110c36793eaf9765d1c6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "FK_175fc64110c36793eaf9765d1c6" FOREIGN KEY ("folderId") REFERENCES core."navigationMenuItem"(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: viewFilter FK_193548db5abc45713087f7d1af6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "FK_193548db5abc45713087f7d1af6" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: searchFieldMetadata FK_1b78544eb06f82059a2a01013a3; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."searchFieldMetadata"
    ADD CONSTRAINT "FK_1b78544eb06f82059a2a01013a3" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicateGroup FK_1e82563accb67114f65a3993b86; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "FK_1e82563accb67114f65a3993b86" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: userWorkspace FK_22f5e76f493c3fb20237cfc48b0; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."userWorkspace"
    ADD CONSTRAINT "FK_22f5e76f493c3fb20237cfc48b0" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_23b36d07d363f81200654fa1334; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_23b36d07d363f81200654fa1334" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: pageLayoutTab FK_2528e67c8c0c953d8303172989e; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutTab"
    ADD CONSTRAINT "FK_2528e67c8c0c953d8303172989e" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: agent FK_259c48f99f625708723414adb5d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.agent
    ADD CONSTRAINT "FK_259c48f99f625708723414adb5d" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicateGroup FK_25bbd97a29478e18061cb58950f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "FK_25bbd97a29478e18061cb58950f" FOREIGN KEY ("parentRowLevelPermissionPredicateGroupId") REFERENCES core."rowLevelPermissionPredicateGroup"(id) ON DELETE CASCADE;


--
-- Name: fieldPermission FK_2763aee5614b54019d692333fe1; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "FK_2763aee5614b54019d692333fe1" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: agentMessagePart FK_2aff9daad5cc3b5e15ca7173342; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentMessagePart"
    ADD CONSTRAINT "FK_2aff9daad5cc3b5e15ca7173342" FOREIGN KEY ("messageId") REFERENCES core."agentMessage"(id) ON DELETE CASCADE;


--
-- Name: viewSort FK_2b36c6adea4542b4844d9fb1806; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewSort"
    ADD CONSTRAINT "FK_2b36c6adea4542b4844d9fb1806" FOREIGN KEY ("viewId") REFERENCES core.view(id) ON DELETE CASCADE;


--
-- Name: viewGroup FK_2d7cfc4748058a0ca648835d046; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewGroup"
    ADD CONSTRAINT "FK_2d7cfc4748058a0ca648835d046" FOREIGN KEY ("viewId") REFERENCES core.view(id) ON DELETE CASCADE;


--
-- Name: viewFilter FK_32cabc67e40d24acab541c469a8; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "FK_32cabc67e40d24acab541c469a8" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: view FK_348e25d584c7e51417f4e097941; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_348e25d584c7e51417f4e097941" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: view FK_394132f681ecbffa8ac912d1e5f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_394132f681ecbffa8ac912d1e5f" FOREIGN KEY ("createdByUserWorkspaceId") REFERENCES core."userWorkspace"(id) ON DELETE SET NULL;


--
-- Name: workspace FK_3b1acb13a5dac9956d1a4b32755; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.workspace
    ADD CONSTRAINT "FK_3b1acb13a5dac9956d1a4b32755" FOREIGN KEY ("workspaceCustomApplicationId") REFERENCES core.application(id) ON DELETE RESTRICT;


--
-- Name: agentChatThread FK_3bd935d6f8c5ce87194b8db8240; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentChatThread"
    ADD CONSTRAINT "FK_3bd935d6f8c5ce87194b8db8240" FOREIGN KEY ("userWorkspaceId") REFERENCES core."userWorkspace"(id) ON DELETE CASCADE;


--
-- Name: agentTurn FK_3be906dca9d5b50fbfe40e33f07; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentTurn"
    ADD CONSTRAINT "FK_3be906dca9d5b50fbfe40e33f07" FOREIGN KEY ("threadId") REFERENCES core."agentChatThread"(id) ON DELETE CASCADE;


--
-- Name: view FK_3e5ea41c239ef1b75b0d42bef99; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_3e5ea41c239ef1b75b0d42bef99" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicateGroup FK_3f1abc7557a4e9f4334d41b07d7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "FK_3f1abc7557a4e9f4334d41b07d7" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: file FK_413aaaf293284c3c0266d0bab3a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.file
    ADD CONSTRAINT "FK_413aaaf293284c3c0266d0bab3a" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE RESTRICT;


--
-- Name: pageLayoutTab FK_4493447c2e4029aa26cabf30460; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutTab"
    ADD CONSTRAINT "FK_4493447c2e4029aa26cabf30460" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: skill FK_46f69b93b58666bb388c5c7785a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.skill
    ADD CONSTRAINT "FK_46f69b93b58666bb388c5c7785a" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: fieldMetadata FK_47a6c57e1652b6475f8248cff78; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "FK_47a6c57e1652b6475f8248cff78" FOREIGN KEY ("relationTargetFieldMetadataId") REFERENCES core."fieldMetadata"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: roleTarget FK_4b3865868c7da0747ee8e480851; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "FK_4b3865868c7da0747ee8e480851" FOREIGN KEY ("apiKeyId") REFERENCES core."apiKey"(id) ON DELETE CASCADE;


--
-- Name: serverlessFunction FK_4b9625a4babf7f4fa942fd26514; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunction"
    ADD CONSTRAINT "FK_4b9625a4babf7f4fa942fd26514" FOREIGN KEY ("serverlessFunctionLayerId") REFERENCES core."serverlessFunctionLayer"(id);


--
-- Name: agentMessage FK_4c31daa882e3130534995bf90ca; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentMessage"
    ADD CONSTRAINT "FK_4c31daa882e3130534995bf90ca" FOREIGN KEY ("threadId") REFERENCES core."agentChatThread"(id) ON DELETE CASCADE;


--
-- Name: applicationVariable FK_51adb49e7f8df35dd23e01c4830; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."applicationVariable"
    ADD CONSTRAINT "FK_51adb49e7f8df35dd23e01c4830" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: pageLayoutWidget FK_555948f84165dce1fe1f5f955ce; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutWidget"
    ADD CONSTRAINT "FK_555948f84165dce1fe1f5f955ce" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: view FK_580dad12c8b92f3a3c307c4e66d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_580dad12c8b92f3a3c307c4e66d" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: webhook FK_597ab5e7de76f1836b8fd80d6b9; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.webhook
    ADD CONSTRAINT "FK_597ab5e7de76f1836b8fd80d6b9" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: viewGroup FK_5aff384532c78fa8a42ceeae282; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewGroup"
    ADD CONSTRAINT "FK_5aff384532c78fa8a42ceeae282" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: view FK_5c0d21d6b8d5544a24ab9787114; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_5c0d21d6b8d5544a24ab9787114" FOREIGN KEY ("calendarFieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: indexMetadata FK_5c988136a6d6f25a100c1064789; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexMetadata"
    ADD CONSTRAINT "FK_5c988136a6d6f25a100c1064789" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: routeTrigger FK_5e004929fcf5e67398544b43885; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."routeTrigger"
    ADD CONSTRAINT "FK_5e004929fcf5e67398544b43885" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: pageLayout FK_5e7f19b88c0864db19e2bad0fc5; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayout"
    ADD CONSTRAINT "FK_5e7f19b88c0864db19e2bad0fc5" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: searchFieldMetadata FK_5f10e00da471e19f52513f47d8b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."searchFieldMetadata"
    ADD CONSTRAINT "FK_5f10e00da471e19f52513f47d8b" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: viewSort FK_5f3278d6791aa4c58423e556ae6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewSort"
    ADD CONSTRAINT "FK_5f3278d6791aa4c58423e556ae6" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_5fb4b0cebaf1b6418412bf65170; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_5fb4b0cebaf1b6418412bf65170" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: viewGroup FK_61053f5509cc31e5d7139fba1cb; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewGroup"
    ADD CONSTRAINT "FK_61053f5509cc31e5d7139fba1cb" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: serverlessFunction FK_62cbd26626ff76df897181c7994; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunction"
    ADD CONSTRAINT "FK_62cbd26626ff76df897181c7994" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: navigationMenuItem FK_62d47d14b50b67a03f832481de7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "FK_62d47d14b50b67a03f832481de7" FOREIGN KEY ("targetObjectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: frontComponent FK_63e430d5f8e554c4282e7b48876; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."frontComponent"
    ADD CONSTRAINT "FK_63e430d5f8e554c4282e7b48876" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_67519abd77fc637444720192737; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_67519abd77fc637444720192737" FOREIGN KEY ("rowLevelPermissionPredicateGroupId") REFERENCES core."rowLevelPermissionPredicateGroup"(id) ON DELETE CASCADE;


--
-- Name: viewFilterGroup FK_6aa17342705ae5526de377bf7ed; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilterGroup"
    ADD CONSTRAINT "FK_6aa17342705ae5526de377bf7ed" FOREIGN KEY ("parentViewFilterGroupId") REFERENCES core."viewFilterGroup"(id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: featureFlag FK_6be7761fa8453f3a498aab6e72b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."featureFlag"
    ADD CONSTRAINT "FK_6be7761fa8453f3a498aab6e72b" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: searchFieldMetadata FK_6d5c6922bfd1578b1eff2abb9d6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."searchFieldMetadata"
    ADD CONSTRAINT "FK_6d5c6922bfd1578b1eff2abb9d6" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: commandMenuItem FK_6e050fb56a8385718123a4f8bc6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."commandMenuItem"
    ADD CONSTRAINT "FK_6e050fb56a8385718123a4f8bc6" FOREIGN KEY ("availabilityObjectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: routeTrigger FK_6edf47a8bfe17a5811998dc7162; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."routeTrigger"
    ADD CONSTRAINT "FK_6edf47a8bfe17a5811998dc7162" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: fieldMetadata FK_6f6c87ec32cca956d8be321071c; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "FK_6f6c87ec32cca956d8be321071c" FOREIGN KEY ("relationTargetObjectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: navigationMenuItem FK_6fd84a774fe4ea4daa9aeeee5ed; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "FK_6fd84a774fe4ea4daa9aeeee5ed" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: objectMetadata FK_71a7af5a5c916f0b96f358f25f7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "FK_71a7af5a5c916f0b96f358f25f7" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: approvedAccessDomain FK_73d3e340b6ce0716a25a86361fc; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."approvedAccessDomain"
    ADD CONSTRAINT "FK_73d3e340b6ce0716a25a86361fc" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: pageLayout FK_760ec8b78721991220b76accd55; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayout"
    ADD CONSTRAINT "FK_760ec8b78721991220b76accd55" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: databaseEventTrigger FK_7650f1b8b693cde204f44ab0aa4; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."databaseEventTrigger"
    ADD CONSTRAINT "FK_7650f1b8b693cde204f44ab0aa4" FOREIGN KEY ("serverlessFunctionId") REFERENCES core."serverlessFunction"(id) ON DELETE CASCADE;


--
-- Name: emailingDomain FK_793a938bef2aae0a2129f78951f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."emailingDomain"
    ADD CONSTRAINT "FK_793a938bef2aae0a2129f78951f" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: publicDomain FK_7e9ca5fd7aa30b8396ea3d1d6be; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."publicDomain"
    ADD CONSTRAINT "FK_7e9ca5fd7aa30b8396ea3d1d6be" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: role FK_7f3b96f15aaf5a27549288d264b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT "FK_7f3b96f15aaf5a27549288d264b" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: cronTrigger FK_817ea28e71e3b19acc258dd7dcd; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."cronTrigger"
    ADD CONSTRAINT "FK_817ea28e71e3b19acc258dd7dcd" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: viewSort FK_818522b962a9b756accb5b3149d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewSort"
    ADD CONSTRAINT "FK_818522b962a9b756accb5b3149d" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: objectPermission FK_826052747c82e59f0a006204256; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectPermission"
    ADD CONSTRAINT "FK_826052747c82e59f0a006204256" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: permissionFlag FK_835bc9f7ef959debfc5cd268049; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."permissionFlag"
    ADD CONSTRAINT "FK_835bc9f7ef959debfc5cd268049" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: roleTarget FK_83ea4a0433da5007a198db7667e; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "FK_83ea4a0433da5007a198db7667e" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: agentMessage FK_87dbab10ac94d9a091f8efaa67b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentMessage"
    ADD CONSTRAINT "FK_87dbab10ac94d9a091f8efaa67b" FOREIGN KEY ("turnId") REFERENCES core."agentTurn"(id) ON DELETE CASCADE;


--
-- Name: viewFilterGroup FK_8919a390f4022ab1e40182a5ac3; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilterGroup"
    ADD CONSTRAINT "FK_8919a390f4022ab1e40182a5ac3" FOREIGN KEY ("viewId") REFERENCES core.view(id) ON DELETE CASCADE;


--
-- Name: appToken FK_8cd4819144baf069777b5729136; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."appToken"
    ADD CONSTRAINT "FK_8cd4819144baf069777b5729136" FOREIGN KEY ("userId") REFERENCES core."user"(id) ON DELETE CASCADE;


--
-- Name: postgresCredentials FK_9494639abc06f9c8c3691bf5d22; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."postgresCredentials"
    ADD CONSTRAINT "FK_9494639abc06f9c8c3691bf5d22" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: commandMenuItem FK_94947770f00413f134a1ec01dd7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."commandMenuItem"
    ADD CONSTRAINT "FK_94947770f00413f134a1ec01dd7" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: viewField FK_96158de54c78944b5340b6f708e; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewField"
    ADD CONSTRAINT "FK_96158de54c78944b5340b6f708e" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: databaseEventTrigger FK_9acc2804037a5c885633024368d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."databaseEventTrigger"
    ADD CONSTRAINT "FK_9acc2804037a5c885633024368d" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: fieldMetadata FK_9ce5ba7878f498bcf79e447a9a6; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "FK_9ce5ba7878f498bcf79e447a9a6" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: userWorkspace FK_a2da2ea7d6cd1e5a4c5cb1791f8; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."userWorkspace"
    ADD CONSTRAINT "FK_a2da2ea7d6cd1e5a4c5cb1791f8" FOREIGN KEY ("userId") REFERENCES core."user"(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicateGroup FK_a41b6a06e3a7ded2204b0fc815d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "FK_a41b6a06e3a7ded2204b0fc815d" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: roleTarget FK_a86894bed7b7e1cc8b3f1d6186f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "FK_a86894bed7b7e1cc8b3f1d6186f" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: commandMenuItem FK_ad42dd64b117491a38120466d65; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."commandMenuItem"
    ADD CONSTRAINT "FK_ad42dd64b117491a38120466d65" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: twoFactorAuthenticationMethod FK_b0f44ffd7c794beb48cb1e1b1a9; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."twoFactorAuthenticationMethod"
    ADD CONSTRAINT "FK_b0f44ffd7c794beb48cb1e1b1a9" FOREIGN KEY ("userWorkspaceId") REFERENCES core."userWorkspace"(id) ON DELETE CASCADE;


--
-- Name: roleTarget FK_b1db027b64f44029389ace305ac; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."roleTarget"
    ADD CONSTRAINT "FK_b1db027b64f44029389ace305ac" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: indexFieldMetadata FK_b20192c432612eb710801dd5664; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexFieldMetadata"
    ADD CONSTRAINT "FK_b20192c432612eb710801dd5664" FOREIGN KEY ("indexMetadataId") REFERENCES core."indexMetadata"(id) ON DELETE CASCADE;


--
-- Name: navigationMenuItem FK_b2e02050a5faa58ed3e08624659; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."navigationMenuItem"
    ADD CONSTRAINT "FK_b2e02050a5faa58ed3e08624659" FOREIGN KEY ("userWorkspaceId") REFERENCES core."userWorkspace"(id) ON DELETE CASCADE;


--
-- Name: view FK_b3cc95732479f7a1337350c398f; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_b3cc95732479f7a1337350c398f" FOREIGN KEY ("kanbanAggregateOperationFieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: viewFilter FK_b518bd61175e0963370e09ef15e; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "FK_b518bd61175e0963370e09ef15e" FOREIGN KEY ("viewFilterGroupId") REFERENCES core."viewFilterGroup"(id) ON DELETE CASCADE;


--
-- Name: viewField FK_b560ea62a958deff0c6059caa45; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewField"
    ADD CONSTRAINT "FK_b560ea62a958deff0c6059caa45" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_b575e84d5ba7f183079c5c8c421; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_b575e84d5ba7f183079c5c8c421" FOREIGN KEY ("workspaceMemberFieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE SET NULL;


--
-- Name: frontComponent FK_b5e4eea33659f066e865ab6afe0; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."frontComponent"
    ADD CONSTRAINT "FK_b5e4eea33659f066e865ab6afe0" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: skill FK_b832ffda9048fae83e52fbe48a7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.skill
    ADD CONSTRAINT "FK_b832ffda9048fae83e52fbe48a7" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: fieldPermission FK_bbf16a91f5a10199e5b18c019ba; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "FK_bbf16a91f5a10199e5b18c019ba" FOREIGN KEY ("roleId") REFERENCES core.role(id) ON DELETE CASCADE;


--
-- Name: workspaceSSOIdentityProvider FK_bc8d8855198de1fbc32fba8df93; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."workspaceSSOIdentityProvider"
    ADD CONSTRAINT "FK_bc8d8855198de1fbc32fba8df93" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: indexFieldMetadata FK_be0950612a54b58c72bd62d629e; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."indexFieldMetadata"
    ADD CONSTRAINT "FK_be0950612a54b58c72bd62d629e" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: viewFilterGroup FK_bfc3498b964ef1bfc89b1f2bee3; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilterGroup"
    ADD CONSTRAINT "FK_bfc3498b964ef1bfc89b1f2bee3" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: keyValuePair FK_c137e3d8b3980901e114941daa2; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."keyValuePair"
    ADD CONSTRAINT "FK_c137e3d8b3980901e114941daa2" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: agent FK_c4cb56621768a4a325dd772bbe1; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.agent
    ADD CONSTRAINT "FK_c4cb56621768a4a325dd772bbe1" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: pageLayoutWidget FK_c4dc95034f53a12601e623d9171; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutWidget"
    ADD CONSTRAINT "FK_c4dc95034f53a12601e623d9171" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: viewField FK_c5ab40cd4debb51d588752a4857; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewField"
    ADD CONSTRAINT "FK_c5ab40cd4debb51d588752a4857" FOREIGN KEY ("viewId") REFERENCES core.view(id) ON DELETE CASCADE;


--
-- Name: routeTrigger FK_c89ed9d929873119478fc0d9cc5; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."routeTrigger"
    ADD CONSTRAINT "FK_c89ed9d929873119478fc0d9cc5" FOREIGN KEY ("serverlessFunctionId") REFERENCES core."serverlessFunction"(id) ON DELETE CASCADE;


--
-- Name: apiKey FK_c8b3efa54a29aa873043e72fb1d; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."apiKey"
    ADD CONSTRAINT "FK_c8b3efa54a29aa873043e72fb1d" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: agentTurnEvaluation FK_c94f072dbd3c11f7df51db52934; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."agentTurnEvaluation"
    ADD CONSTRAINT "FK_c94f072dbd3c11f7df51db52934" FOREIGN KEY ("turnId") REFERENCES core."agentTurn"(id) ON DELETE CASCADE;


--
-- Name: serverlessFunctionLayer FK_ca0699c3c906e903d7381c6a771; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunctionLayer"
    ADD CONSTRAINT "FK_ca0699c3c906e903d7381c6a771" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicateGroup FK_ca604fd5ee245bca9f32ed67b9b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicateGroup"
    ADD CONSTRAINT "FK_ca604fd5ee245bca9f32ed67b9b" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: databaseEventTrigger FK_cf158c3199dcf2d52b0da05c33b; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."databaseEventTrigger"
    ADD CONSTRAINT "FK_cf158c3199dcf2d52b0da05c33b" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: view FK_d1fa625016e36ec6f79fb13e824; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.view
    ADD CONSTRAINT "FK_d1fa625016e36ec6f79fb13e824" FOREIGN KEY ("mainGroupByFieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: role FK_d2532f520d84f8c22ee45681c5a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT "FK_d2532f520d84f8c22ee45681c5a" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: viewFilter FK_d5651cf33fa56a47cd262a3fb2c; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilter"
    ADD CONSTRAINT "FK_d5651cf33fa56a47cd262a3fb2c" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: fieldPermission FK_d5c47a26fe71648894d05da3d3a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "FK_d5c47a26fe71648894d05da3d3a" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_d5ee96a9a03761f2c328a29523c; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_d5ee96a9a03761f2c328a29523c" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: appToken FK_d6ae19a7aa2bbd4919053257772; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."appToken"
    ADD CONSTRAINT "FK_d6ae19a7aa2bbd4919053257772" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: objectMetadata FK_d82a05a204136c01388ea80bc7a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectMetadata"
    ADD CONSTRAINT "FK_d82a05a204136c01388ea80bc7a" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: fieldPermission FK_dc8e552397f5e44d175fedf752a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldPermission"
    ADD CONSTRAINT "FK_dc8e552397f5e44d175fedf752a" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: viewFilterGroup FK_dce74ab06fa7a2effcbf1b98dff; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewFilterGroup"
    ADD CONSTRAINT "FK_dce74ab06fa7a2effcbf1b98dff" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: pageLayout FK_dd63ca42614bacf58971aabdcbb; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayout"
    ADD CONSTRAINT "FK_dd63ca42614bacf58971aabdcbb" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: fieldMetadata FK_de2a09b9e3e690440480d2dee26; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."fieldMetadata"
    ADD CONSTRAINT "FK_de2a09b9e3e690440480d2dee26" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: file FK_de468b3d8dcf7e94f7074220929; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.file
    ADD CONSTRAINT "FK_de468b3d8dcf7e94f7074220929" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: dataSource FK_e1914827ee8b22fba4254578311; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."dataSource"
    ADD CONSTRAINT "FK_e1914827ee8b22fba4254578311" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: rowLevelPermissionPredicate FK_eadcbbb92b6d58c6785a780b5b7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."rowLevelPermissionPredicate"
    ADD CONSTRAINT "FK_eadcbbb92b6d58c6785a780b5b7" FOREIGN KEY ("fieldMetadataId") REFERENCES core."fieldMetadata"(id) ON DELETE CASCADE;


--
-- Name: objectPermission FK_edcd87df18d3284141757bf6e16; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectPermission"
    ADD CONSTRAINT "FK_edcd87df18d3284141757bf6e16" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: serverlessFunction FK_ef5dde6a681970b9c1e10563498; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."serverlessFunction"
    ADD CONSTRAINT "FK_ef5dde6a681970b9c1e10563498" FOREIGN KEY ("workspaceId") REFERENCES core.workspace(id) ON DELETE CASCADE;


--
-- Name: objectPermission FK_efbcf3528718de2b5c45c0a8a83; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."objectPermission"
    ADD CONSTRAINT "FK_efbcf3528718de2b5c45c0a8a83" FOREIGN KEY ("objectMetadataId") REFERENCES core."objectMetadata"(id) ON DELETE CASCADE;


--
-- Name: cronTrigger FK_f70831ec336e0cb42d6a33b80ba; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."cronTrigger"
    ADD CONSTRAINT "FK_f70831ec336e0cb42d6a33b80ba" FOREIGN KEY ("serverlessFunctionId") REFERENCES core."serverlessFunction"(id) ON DELETE CASCADE;


--
-- Name: pageLayoutWidget FK_fb84d310b4cfe5916ced6fc3e2a; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."pageLayoutWidget"
    ADD CONSTRAINT "FK_fb84d310b4cfe5916ced6fc3e2a" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: viewSort FK_ff8cbebe1704954120df82bf393; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."viewSort"
    ADD CONSTRAINT "FK_ff8cbebe1704954120df82bf393" FOREIGN KEY ("applicationId") REFERENCES core.application(id) ON DELETE CASCADE;


--
-- Name: timelineActivity FK_017f8e2306dc1b0182a33b062a5; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_017f8e2306dc1b0182a33b062a5" FOREIGN KEY ("targetWorkflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: timelineActivity FK_0482ca18fc5e49456ce97cf61aa; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_0482ca18fc5e49456ce97cf61aa" FOREIGN KEY ("targetOpportunityId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_068146151017a5f32c3b152ac04; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_068146151017a5f32c3b152ac04" FOREIGN KEY ("targetNoteId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.note(id) ON DELETE SET NULL;


--
-- Name: calendarEventParticipant FK_082f03025609e55b3d55de7cc28; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant"
    ADD CONSTRAINT "FK_082f03025609e55b3d55de7cc28" FOREIGN KEY ("calendarEventId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEvent"(id) ON DELETE CASCADE;


--
-- Name: attachment FK_0d85015fe57c6272ef639a17f23; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_0d85015fe57c6272ef639a17f23" FOREIGN KEY ("originId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: taskTarget FK_1cfafa011d5f7f58b1b734cf4a1; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_1cfafa011d5f7f58b1b734cf4a1" FOREIGN KEY ("customerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_1e94666e8325eda6b7c0dea7698; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_1e94666e8325eda6b7c0dea7698" FOREIGN KEY ("targetLeadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead(id) ON DELETE SET NULL;


--
-- Name: calendarChannelEventAssociation FK_1fc99b189521f153bf3bbac7324; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation"
    ADD CONSTRAINT "FK_1fc99b189521f153bf3bbac7324" FOREIGN KEY ("calendarEventId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEvent"(id) ON DELETE CASCADE;


--
-- Name: favorite FK_202ea98eb9e6c2e264c4f445909; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_202ea98eb9e6c2e264c4f445909" FOREIGN KEY ("workflowVersionId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion"(id) ON DELETE CASCADE;


--
-- Name: timelineActivity FK_23ea8a9080759633a448287c157; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_23ea8a9080759633a448287c157" FOREIGN KEY ("targetWorkflowVersionId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion"(id) ON DELETE CASCADE;


--
-- Name: workflowRun FK_25b2bf1832ffa264f8dc39f7dab; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun"
    ADD CONSTRAINT "FK_25b2bf1832ffa264f8dc39f7dab" FOREIGN KEY ("workflowVersionId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion"(id) ON DELETE SET NULL;


--
-- Name: messageChannel FK_2e966cbb240771c67630d52895c; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel"
    ADD CONSTRAINT "FK_2e966cbb240771c67630d52895c" FOREIGN KEY ("connectedAccountId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount"(id) ON DELETE CASCADE;


--
-- Name: attachment FK_336215924656712491529388934; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_336215924656712491529388934" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE CASCADE;


--
-- Name: _lead FK_37f8ab949da81a67816b0804188; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead
    ADD CONSTRAINT "FK_37f8ab949da81a67816b0804188" FOREIGN KEY ("assigneeId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_393340ea834ab8660b51d482f29; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_393340ea834ab8660b51d482f29" FOREIGN KEY ("targetDashboardId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard(id) ON DELETE SET NULL;


--
-- Name: attachment FK_3b82bb3c0a8cbb7cc62cdeff2cc; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_3b82bb3c0a8cbb7cc62cdeff2cc" FOREIGN KEY ("propertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_3c53994e4a67712996d6a9cbf8d; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_3c53994e4a67712996d6a9cbf8d" FOREIGN KEY ("targetWorkflowRunId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun"(id) ON DELETE CASCADE;


--
-- Name: messageFolder FK_4237a2fe8a6583354f807c2f8fe; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageFolder"
    ADD CONSTRAINT "FK_4237a2fe8a6583354f807c2f8fe" FOREIGN KEY ("messageChannelId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel"(id) ON DELETE CASCADE;


--
-- Name: attachment FK_42fc94f92226780b74dbca6c0ff; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_42fc94f92226780b74dbca6c0ff" FOREIGN KEY ("customerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_4d266cbeff57096026be4b97ee3; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_4d266cbeff57096026be4b97ee3" FOREIGN KEY ("targetTaskId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.task(id) ON DELETE SET NULL;


--
-- Name: favorite FK_50b4b08647162251102055f8605; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_50b4b08647162251102055f8605" FOREIGN KEY ("opportunityId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity(id) ON DELETE CASCADE;


--
-- Name: message FK_51fa5df1094bfdbf99ea91a72fa; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.message
    ADD CONSTRAINT "FK_51fa5df1094bfdbf99ea91a72fa" FOREIGN KEY ("messageThreadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageThread"(id) ON DELETE CASCADE;


--
-- Name: noteTarget FK_52050fd9cf6b7ba9982ef9d867a; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_52050fd9cf6b7ba9982ef9d867a" FOREIGN KEY ("noteId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.note(id) ON DELETE CASCADE;


--
-- Name: taskTarget FK_5358b06590355cca96d43c56a89; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_5358b06590355cca96d43c56a89" FOREIGN KEY ("leadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead(id) ON DELETE SET NULL;


--
-- Name: favorite FK_543e20855ce2bde06d0acb29b51; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_543e20855ce2bde06d0acb29b51" FOREIGN KEY ("customerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: opportunity FK_5a104112b21bbebb37fca93a548; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity
    ADD CONSTRAINT "FK_5a104112b21bbebb37fca93a548" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE SET NULL;


--
-- Name: favorite FK_5abbb386c4f07b05622d7e5dbd7; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_5abbb386c4f07b05622d7e5dbd7" FOREIGN KEY ("workflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: attachment FK_5bf006c84a1a7f95f165d8b4432; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_5bf006c84a1a7f95f165d8b4432" FOREIGN KEY ("dashboardId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard(id) ON DELETE CASCADE;


--
-- Name: attachment FK_611282e10752b2ecbd5c8525ab5; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_611282e10752b2ecbd5c8525ab5" FOREIGN KEY ("taskId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.task(id) ON DELETE SET NULL;


--
-- Name: favorite FK_64cc36ffa2e72ad304dfff1c1b6; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_64cc36ffa2e72ad304dfff1c1b6" FOREIGN KEY ("noteId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.note(id) ON DELETE CASCADE;


--
-- Name: messageParticipant FK_670c8b151ad702613fce89b3662; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant"
    ADD CONSTRAINT "FK_670c8b151ad702613fce89b3662" FOREIGN KEY ("messageId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.message(id) ON DELETE CASCADE;


--
-- Name: opportunity FK_67371a1e3fd5bac524f7e914bad; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity
    ADD CONSTRAINT "FK_67371a1e3fd5bac524f7e914bad" FOREIGN KEY ("ownerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: noteTarget FK_688e789dd150f8aaa0498a615aa; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_688e789dd150f8aaa0498a615aa" FOREIGN KEY ("customerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_69c9f89fe0c2cd4540c4dceb206; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_69c9f89fe0c2cd4540c4dceb206" FOREIGN KEY ("targetCustomerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: connectedAccount FK_6b4f87f1cff07faee5635ff6a6d; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount"
    ADD CONSTRAINT "FK_6b4f87f1cff07faee5635ff6a6d" FOREIGN KEY ("accountOwnerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE CASCADE;


--
-- Name: taskTarget FK_6bf30a6234085e67b5754d1270a; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_6bf30a6234085e67b5754d1270a" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE CASCADE;


--
-- Name: favorite FK_6c07cb1ca91ef6ddf680ea76c23; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_6c07cb1ca91ef6ddf680ea76c23" FOREIGN KEY ("taskId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.task(id) ON DELETE CASCADE;


--
-- Name: task FK_7384988f7eeb777e44802a0baca; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.task
    ADD CONSTRAINT "FK_7384988f7eeb777e44802a0baca" FOREIGN KEY ("assigneeId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_7460f3992bc8d73165b3b2874e6; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_7460f3992bc8d73165b3b2874e6" FOREIGN KEY ("targetCompanyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE CASCADE;


--
-- Name: attachment FK_76c5cd056cd033bd8a9b6117bf4; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_76c5cd056cd033bd8a9b6117bf4" FOREIGN KEY ("noteId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.note(id) ON DELETE SET NULL;


--
-- Name: taskTarget FK_77baecea6c197525c17c8e04a4b; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_77baecea6c197525c17c8e04a4b" FOREIGN KEY ("opportunityId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity(id) ON DELETE CASCADE;


--
-- Name: calendarEventParticipant FK_78e8a7e863f3d614d3d30034479; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant"
    ADD CONSTRAINT "FK_78e8a7e863f3d614d3d30034479" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE SET NULL;


--
-- Name: attachment FK_79ecbbd8c212dc3877c7d0d1785; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_79ecbbd8c212dc3877c7d0d1785" FOREIGN KEY ("workflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: taskTarget FK_7bf39dec144e4b69c9d9c305987; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_7bf39dec144e4b69c9d9c305987" FOREIGN KEY ("propertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: noteTarget FK_7c8dbf2aeb3aa49f1db27bece61; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_7c8dbf2aeb3aa49f1db27bece61" FOREIGN KEY ("propertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: attachment FK_7e7734164970ebef01a8542c341; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_7e7734164970ebef01a8542c341" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE CASCADE;


--
-- Name: favorite FK_7f94f531f1d68952732ce0713b8; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_7f94f531f1d68952732ce0713b8" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE CASCADE;


--
-- Name: messageParticipant FK_840b9ccea0055abb8b3e980638c; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant"
    ADD CONSTRAINT "FK_840b9ccea0055abb8b3e980638c" FOREIGN KEY ("workspaceMemberId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_875809b410c253073b5aa812c9a; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_875809b410c253073b5aa812c9a" FOREIGN KEY ("targetPersonId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE CASCADE;


--
-- Name: favorite FK_87c60f46f8b173156d5443dff94; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_87c60f46f8b173156d5443dff94" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE CASCADE;


--
-- Name: messageChannelMessageAssociation FK_882fe28be3f73b2c3fd84acc866; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation"
    ADD CONSTRAINT "FK_882fe28be3f73b2c3fd84acc866" FOREIGN KEY ("messageChannelId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannel"(id) ON DELETE CASCADE;


--
-- Name: noteTarget FK_89d3f25e1ff1084ff7ecbc45e9f; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_89d3f25e1ff1084ff7ecbc45e9f" FOREIGN KEY ("opportunityId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity(id) ON DELETE CASCADE;


--
-- Name: attachment FK_8cfd54311aaba8ecba3f30c1428; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_8cfd54311aaba8ecba3f30c1428" FOREIGN KEY ("opportunityId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity(id) ON DELETE CASCADE;


--
-- Name: favorite FK_97f80e6d19fc07de479037da8bd; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_97f80e6d19fc07de479037da8bd" FOREIGN KEY ("originId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: favorite FK_9b2f7992b7be7ef4894f9164402; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_9b2f7992b7be7ef4894f9164402" FOREIGN KEY ("workflowRunId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun"(id) ON DELETE CASCADE;


--
-- Name: messageChannelMessageAssociation FK_9b53fe617a3a4c0fa231703a64f; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation"
    ADD CONSTRAINT "FK_9b53fe617a3a4c0fa231703a64f" FOREIGN KEY ("messageId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.message(id) ON DELETE CASCADE;


--
-- Name: favorite FK_9e2a1c3f92bf49bfd046b672a7d; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_9e2a1c3f92bf49bfd046b672a7d" FOREIGN KEY ("leadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead(id) ON DELETE SET NULL;


--
-- Name: company FK_abe91dff1e48d77edca339f387c; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.company
    ADD CONSTRAINT "FK_abe91dff1e48d77edca339f387c" FOREIGN KEY ("accountOwnerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: taskTarget FK_ad73a9e465ad357cf3ccb26a86e; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_ad73a9e465ad357cf3ccb26a86e" FOREIGN KEY ("originId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_b4eb8dc9e277fbcb7d29437db84; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_b4eb8dc9e277fbcb7d29437db84" FOREIGN KEY ("targetPropertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: noteTarget FK_b7f4c99a3f58104e013ecb50350; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_b7f4c99a3f58104e013ecb50350" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE CASCADE;


--
-- Name: timelineActivity FK_b8af01591f389f596f7be54b13d; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_b8af01591f389f596f7be54b13d" FOREIGN KEY ("workspaceMemberId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE CASCADE;


--
-- Name: calendarChannelEventAssociation FK_b9d204c4dacbb164d1ec444116e; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannelEventAssociation"
    ADD CONSTRAINT "FK_b9d204c4dacbb164d1ec444116e" FOREIGN KEY ("calendarChannelId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel"(id) ON DELETE CASCADE;


--
-- Name: blocklist FK_bbaebad9d11e773689cb3cdf997; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.blocklist
    ADD CONSTRAINT "FK_bbaebad9d11e773689cb3cdf997" FOREIGN KEY ("workspaceMemberId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: noteTarget FK_c0bc2ab9c86f6061f87f58b8921; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_c0bc2ab9c86f6061f87f58b8921" FOREIGN KEY ("leadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead(id) ON DELETE SET NULL;


--
-- Name: workflowVersion FK_c3d1cd364eab2fe2a207964738c; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowVersion"
    ADD CONSTRAINT "FK_c3d1cd364eab2fe2a207964738c" FOREIGN KEY ("workflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: favorite FK_c5e1f330d88ce857fa72f5734a8; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_c5e1f330d88ce857fa72f5734a8" FOREIGN KEY ("favoriteFolderId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."favoriteFolder"(id) ON DELETE SET NULL;


--
-- Name: calendarChannel FK_c7bc368c97a18a072413d67cf45; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarChannel"
    ADD CONSTRAINT "FK_c7bc368c97a18a072413d67cf45" FOREIGN KEY ("connectedAccountId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."connectedAccount"(id) ON DELETE CASCADE;


--
-- Name: taskTarget FK_c95f3cce2b95309005a9d1ed824; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_c95f3cce2b95309005a9d1ed824" FOREIGN KEY ("taskId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.task(id) ON DELETE CASCADE;


--
-- Name: noteTarget FK_c9b4f47ea3e51d43ea121434708; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_c9b4f47ea3e51d43ea121434708" FOREIGN KEY ("originId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: messageParticipant FK_cbfaa3bb38cced64ea9576016c2; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageParticipant"
    ADD CONSTRAINT "FK_cbfaa3bb38cced64ea9576016c2" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE SET NULL;


--
-- Name: favorite FK_ccdc459572d1ae97dea4281fb3b; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_ccdc459572d1ae97dea4281fb3b" FOREIGN KEY ("propertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: taskTarget FK_cd49e6663fc94ba1b22cb831f5f; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."taskTarget"
    ADD CONSTRAINT "FK_cd49e6663fc94ba1b22cb831f5f" FOREIGN KEY ("personId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE CASCADE;


--
-- Name: calendarEventParticipant FK_cd980caeb07e091a71780e5a367; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."calendarEventParticipant"
    ADD CONSTRAINT "FK_cd980caeb07e091a71780e5a367" FOREIGN KEY ("workspaceMemberId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE SET NULL;


--
-- Name: timelineActivity FK_ce01b63aa393902f859085066ca; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."timelineActivity"
    ADD CONSTRAINT "FK_ce01b63aa393902f859085066ca" FOREIGN KEY ("targetOriginId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: opportunity FK_ce5aa294b17fe23a0b19267f1e1; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.opportunity
    ADD CONSTRAINT "FK_ce5aa294b17fe23a0b19267f1e1" FOREIGN KEY ("pointOfContactId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.person(id) ON DELETE SET NULL;


--
-- Name: attachment FK_d5fb96e806732eb59895a816266; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.attachment
    ADD CONSTRAINT "FK_d5fb96e806732eb59895a816266" FOREIGN KEY ("leadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead(id) ON DELETE SET NULL;


--
-- Name: workflowRun FK_da6e20d423109a993f1d63938e6; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowRun"
    ADD CONSTRAINT "FK_da6e20d423109a993f1d63938e6" FOREIGN KEY ("workflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: favorite FK_db69e02d020b006ee625873748c; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_db69e02d020b006ee625873748c" FOREIGN KEY ("dashboardId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.dashboard(id) ON DELETE CASCADE;


--
-- Name: workflowAutomatedTrigger FK_e078063f0cbce9767a0f8ca431d; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."workflowAutomatedTrigger"
    ADD CONSTRAINT "FK_e078063f0cbce9767a0f8ca431d" FOREIGN KEY ("workflowId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.workflow(id) ON DELETE CASCADE;


--
-- Name: _lead FK_e080b85e02c08fbca1004d4ebb2; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead
    ADD CONSTRAINT "FK_e080b85e02c08fbca1004d4ebb2" FOREIGN KEY ("originId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._origin(id) ON DELETE SET NULL;


--
-- Name: _lead FK_e222d7a391f00c9c806d9c576c1; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead
    ADD CONSTRAINT "FK_e222d7a391f00c9c806d9c576c1" FOREIGN KEY ("customerId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._customer(id) ON DELETE SET NULL;


--
-- Name: _lead FK_e7a23314804ae618bf9fba10d5e; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis._lead
    ADD CONSTRAINT "FK_e7a23314804ae618bf9fba10d5e" FOREIGN KEY ("propertyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis._property(id) ON DELETE SET NULL;


--
-- Name: messageChannelMessageAssociation FK_ed17eebc0ece37ca05951cefb30; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageChannelMessageAssociation"
    ADD CONSTRAINT "FK_ed17eebc0ece37ca05951cefb30" FOREIGN KEY ("messageThreadId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."messageThread"(id) ON DELETE CASCADE;


--
-- Name: person FK_ee066ddacfce46c9a7cb90edd1a; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.person
    ADD CONSTRAINT "FK_ee066ddacfce46c9a7cb90edd1a" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE SET NULL;


--
-- Name: favorite FK_f81cf8d2eb2a9e36b44f32e7ccc; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis.favorite
    ADD CONSTRAINT "FK_f81cf8d2eb2a9e36b44f32e7ccc" FOREIGN KEY ("forWorkspaceMemberId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis."workspaceMember"(id) ON DELETE CASCADE;


--
-- Name: noteTarget FK_fc8e7addc9538c81a60dd2ef894; Type: FK CONSTRAINT; Schema: workspace_9zs4rq4zo2wzg53xjkq5u4qis; Owner: -
--

ALTER TABLE ONLY workspace_9zs4rq4zo2wzg53xjkq5u4qis."noteTarget"
    ADD CONSTRAINT "FK_fc8e7addc9538c81a60dd2ef894" FOREIGN KEY ("companyId") REFERENCES workspace_9zs4rq4zo2wzg53xjkq5u4qis.company(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 1VvYMeqq8gpgB2iilVO5OyZXAmvnT4ws6tAjKliyde7gy6Nts7IT0vfrf4O3i1g

