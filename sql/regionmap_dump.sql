--
-- PostgreSQL database dump
--

\restrict cbWmz1oMyc5chiP2AvKGsHfWthwUwbDG8qPMWS10SWpzg6Zj1glfoIHTVIqi7dK

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-30 23:30:53

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 242 (class 1259 OID 30644)
-- Name: AbpAuditLogActions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpAuditLogActions" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "AuditLogId" uuid NOT NULL,
    "ServiceName" character varying(256),
    "MethodName" character varying(128),
    "Parameters" character varying(2000),
    "ExecutionTime" timestamp without time zone NOT NULL,
    "ExecutionDuration" integer NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE public."AbpAuditLogActions" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 30355)
-- Name: AbpAuditLogExcelFiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpAuditLogExcelFiles" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "FileName" character varying(256),
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE public."AbpAuditLogExcelFiles" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 30362)
-- Name: AbpAuditLogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpAuditLogs" (
    "Id" uuid NOT NULL,
    "ApplicationName" character varying(96),
    "UserId" uuid,
    "UserName" character varying(256),
    "TenantId" uuid,
    "TenantName" character varying(64),
    "ImpersonatorUserId" uuid,
    "ImpersonatorUserName" character varying(256),
    "ImpersonatorTenantId" uuid,
    "ImpersonatorTenantName" character varying(64),
    "ExecutionTime" timestamp without time zone NOT NULL,
    "ExecutionDuration" integer NOT NULL,
    "ClientIpAddress" character varying(64),
    "ClientName" character varying(128),
    "ClientId" character varying(64),
    "CorrelationId" character varying(64),
    "BrowserInfo" character varying(512),
    "HttpMethod" character varying(16),
    "Url" character varying(256),
    "Exceptions" text,
    "Comments" character varying(256),
    "HttpStatusCode" integer,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpAuditLogs" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 30374)
-- Name: AbpBackgroundJobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpBackgroundJobs" (
    "Id" uuid NOT NULL,
    "ApplicationName" character varying(96),
    "JobName" character varying(128) NOT NULL,
    "JobArgs" character varying(1048576) NOT NULL,
    "TryCount" smallint DEFAULT 0 NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "NextTryTime" timestamp without time zone NOT NULL,
    "LastTryTime" timestamp without time zone,
    "IsAbandoned" boolean DEFAULT false NOT NULL,
    "Priority" smallint DEFAULT 15 NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpBackgroundJobs" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 30394)
-- Name: AbpBlobContainers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpBlobContainers" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(128) NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpBlobContainers" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 30677)
-- Name: AbpBlobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpBlobs" (
    "Id" uuid NOT NULL,
    "ContainerId" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(256) NOT NULL,
    "Content" bytea,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpBlobs" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 30405)
-- Name: AbpClaimTypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpClaimTypes" (
    "Id" uuid NOT NULL,
    "Name" character varying(256) NOT NULL,
    "Required" boolean NOT NULL,
    "IsStatic" boolean NOT NULL,
    "Regex" character varying(512),
    "RegexDescription" character varying(128),
    "Description" character varying(256),
    "ValueType" integer NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpClaimTypes" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 30660)
-- Name: AbpEntityChanges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpEntityChanges" (
    "Id" uuid NOT NULL,
    "AuditLogId" uuid NOT NULL,
    "TenantId" uuid,
    "ChangeTime" timestamp without time zone NOT NULL,
    "ChangeType" smallint NOT NULL,
    "EntityTenantId" uuid,
    "EntityId" character varying(128),
    "EntityTypeFullName" character varying(128) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE public."AbpEntityChanges" OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 30820)
-- Name: AbpEntityPropertyChanges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpEntityPropertyChanges" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "EntityChangeId" uuid NOT NULL,
    "NewValue" character varying(512),
    "OriginalValue" character varying(512),
    "PropertyName" character varying(128) NOT NULL,
    "PropertyTypeFullName" character varying(64) NOT NULL
);


ALTER TABLE public."AbpEntityPropertyChanges" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 30420)
-- Name: AbpFeatureGroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpFeatureGroups" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE public."AbpFeatureGroups" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 30443)
-- Name: AbpFeatureValues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpFeatureValues" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "Value" character varying(128) NOT NULL,
    "ProviderName" character varying(64),
    "ProviderKey" character varying(64)
);


ALTER TABLE public."AbpFeatureValues" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 30430)
-- Name: AbpFeatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpFeatures" (
    "Id" uuid NOT NULL,
    "GroupName" character varying(128) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "ParentName" character varying(128),
    "DisplayName" character varying(256) NOT NULL,
    "Description" character varying(256),
    "DefaultValue" character varying(256),
    "IsVisibleToClients" boolean NOT NULL,
    "IsAvailableToHost" boolean NOT NULL,
    "AllowedProviders" character varying(256),
    "ValueType" character varying(2048),
    "ExtraProperties" text
);


ALTER TABLE public."AbpFeatures" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 30451)
-- Name: AbpLinkUsers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpLinkUsers" (
    "Id" uuid NOT NULL,
    "SourceUserId" uuid NOT NULL,
    "SourceTenantId" uuid,
    "TargetUserId" uuid NOT NULL,
    "TargetTenantId" uuid
);


ALTER TABLE public."AbpLinkUsers" OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 30694)
-- Name: AbpOrganizationUnitRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpOrganizationUnitRoles" (
    "RoleId" uuid NOT NULL,
    "OrganizationUnitId" uuid NOT NULL,
    "TenantId" uuid,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE public."AbpOrganizationUnitRoles" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 30459)
-- Name: AbpOrganizationUnits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpOrganizationUnits" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "ParentId" uuid,
    "Code" character varying(95) NOT NULL,
    "DisplayName" character varying(128) NOT NULL,
    "EntityVersion" integer NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE public."AbpOrganizationUnits" OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 30480)
-- Name: AbpPermissionGrants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpPermissionGrants" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(128) NOT NULL,
    "ProviderName" character varying(64) NOT NULL,
    "ProviderKey" character varying(64) NOT NULL
);


ALTER TABLE public."AbpPermissionGrants" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 30489)
-- Name: AbpPermissionGroups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpPermissionGroups" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE public."AbpPermissionGroups" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 30499)
-- Name: AbpPermissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpPermissions" (
    "Id" uuid NOT NULL,
    "GroupName" character varying(128) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "ParentName" character varying(128),
    "DisplayName" character varying(256) NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "MultiTenancySide" smallint NOT NULL,
    "Providers" character varying(128),
    "StateCheckers" character varying(256),
    "ExtraProperties" text
);


ALTER TABLE public."AbpPermissions" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 30712)
-- Name: AbpRoleClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpRoleClaims" (
    "Id" uuid NOT NULL,
    "RoleId" uuid NOT NULL,
    "TenantId" uuid,
    "ClaimType" character varying(256) NOT NULL,
    "ClaimValue" character varying(1024)
);


ALTER TABLE public."AbpRoleClaims" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 30512)
-- Name: AbpRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpRoles" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "Name" character varying(256) NOT NULL,
    "NormalizedName" character varying(256) NOT NULL,
    "IsDefault" boolean NOT NULL,
    "IsStatic" boolean NOT NULL,
    "IsPublic" boolean NOT NULL,
    "EntityVersion" integer NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpRoles" OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 30529)
-- Name: AbpSecurityLogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpSecurityLogs" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "ApplicationName" character varying(96),
    "Identity" character varying(96),
    "Action" character varying(96),
    "UserId" uuid,
    "UserName" character varying(256),
    "TenantName" character varying(64),
    "ClientId" character varying(64),
    "CorrelationId" character varying(64),
    "ClientIpAddress" character varying(64),
    "BrowserInfo" character varying(512),
    "CreationTime" timestamp without time zone NOT NULL,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."AbpSecurityLogs" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 30540)
-- Name: AbpSessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpSessions" (
    "Id" uuid NOT NULL,
    "SessionId" character varying(128) NOT NULL,
    "Device" character varying(64) NOT NULL,
    "DeviceInfo" character varying(64),
    "TenantId" uuid,
    "UserId" uuid NOT NULL,
    "ClientId" character varying(64),
    "IpAddresses" character varying(2048),
    "SignedIn" timestamp without time zone NOT NULL,
    "LastAccessed" timestamp without time zone,
    "ExtraProperties" text
);


ALTER TABLE public."AbpSessions" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 30552)
-- Name: AbpSettingDefinitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpSettingDefinitions" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "DisplayName" character varying(256) NOT NULL,
    "Description" character varying(512),
    "DefaultValue" character varying(2048),
    "IsVisibleToClients" boolean NOT NULL,
    "Providers" character varying(1024),
    "IsInherited" boolean NOT NULL,
    "IsEncrypted" boolean NOT NULL,
    "ExtraProperties" text
);


ALTER TABLE public."AbpSettingDefinitions" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 30565)
-- Name: AbpSettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpSettings" (
    "Id" uuid NOT NULL,
    "Name" character varying(128) NOT NULL,
    "Value" character varying(2048) NOT NULL,
    "ProviderName" character varying(64),
    "ProviderKey" character varying(64)
);


ALTER TABLE public."AbpSettings" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 30727)
-- Name: AbpUserClaims; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserClaims" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "TenantId" uuid,
    "ClaimType" character varying(256) NOT NULL,
    "ClaimValue" character varying(1024)
);


ALTER TABLE public."AbpUserClaims" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 30575)
-- Name: AbpUserDelegations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserDelegations" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "SourceUserId" uuid NOT NULL,
    "TargetUserId" uuid NOT NULL,
    "StartTime" timestamp without time zone NOT NULL,
    "EndTime" timestamp without time zone NOT NULL
);


ALTER TABLE public."AbpUserDelegations" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 30742)
-- Name: AbpUserLogins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserLogins" (
    "UserId" uuid NOT NULL,
    "LoginProvider" character varying(64) NOT NULL,
    "TenantId" uuid,
    "ProviderKey" character varying(196) NOT NULL,
    "ProviderDisplayName" character varying(128)
);


ALTER TABLE public."AbpUserLogins" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 30755)
-- Name: AbpUserOrganizationUnits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserOrganizationUnits" (
    "UserId" uuid NOT NULL,
    "OrganizationUnitId" uuid NOT NULL,
    "TenantId" uuid,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid
);


ALTER TABLE public."AbpUserOrganizationUnits" OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 30773)
-- Name: AbpUserRoles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserRoles" (
    "UserId" uuid NOT NULL,
    "RoleId" uuid NOT NULL,
    "TenantId" uuid
);


ALTER TABLE public."AbpUserRoles" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 30790)
-- Name: AbpUserTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUserTokens" (
    "UserId" uuid NOT NULL,
    "LoginProvider" character varying(64) NOT NULL,
    "Name" character varying(128) NOT NULL,
    "TenantId" uuid,
    "Value" text
);


ALTER TABLE public."AbpUserTokens" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 30585)
-- Name: AbpUsers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AbpUsers" (
    "Id" uuid NOT NULL,
    "TenantId" uuid,
    "UserName" character varying(256) NOT NULL,
    "NormalizedUserName" character varying(256) NOT NULL,
    "Name" character varying(64),
    "Surname" character varying(64),
    "Email" character varying(256) NOT NULL,
    "NormalizedEmail" character varying(256) NOT NULL,
    "EmailConfirmed" boolean DEFAULT false NOT NULL,
    "PasswordHash" character varying(256),
    "SecurityStamp" character varying(256) NOT NULL,
    "IsExternal" boolean DEFAULT false NOT NULL,
    "PhoneNumber" character varying(16),
    "PhoneNumberConfirmed" boolean DEFAULT false NOT NULL,
    "IsActive" boolean NOT NULL,
    "TwoFactorEnabled" boolean DEFAULT false NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean DEFAULT false NOT NULL,
    "AccessFailedCount" integer DEFAULT 0 NOT NULL,
    "ShouldChangePasswordOnNextLogin" boolean NOT NULL,
    "EntityVersion" integer NOT NULL,
    "LastPasswordChangeTime" timestamp with time zone,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE public."AbpUsers" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 30618)
-- Name: OpenIddictApplications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenIddictApplications" (
    "Id" uuid NOT NULL,
    "ApplicationType" character varying(50),
    "ClientId" character varying(100),
    "ClientSecret" text,
    "ClientType" character varying(50),
    "ConsentType" character varying(50),
    "DisplayName" text,
    "DisplayNames" text,
    "JsonWebKeySet" text,
    "Permissions" text,
    "PostLogoutRedirectUris" text,
    "Properties" text,
    "RedirectUris" text,
    "Requirements" text,
    "Settings" text,
    "ClientUri" text,
    "LogoUri" text,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE public."OpenIddictApplications" OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 30805)
-- Name: OpenIddictAuthorizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenIddictAuthorizations" (
    "Id" uuid NOT NULL,
    "ApplicationId" uuid,
    "CreationDate" timestamp without time zone,
    "Properties" text,
    "Scopes" text,
    "Status" character varying(50),
    "Subject" character varying(400),
    "Type" character varying(50),
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."OpenIddictAuthorizations" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 30631)
-- Name: OpenIddictScopes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenIddictScopes" (
    "Id" uuid NOT NULL,
    "Description" text,
    "Descriptions" text,
    "DisplayName" text,
    "DisplayNames" text,
    "Name" character varying(200),
    "Properties" text,
    "Resources" text,
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL,
    "CreationTime" timestamp without time zone NOT NULL,
    "CreatorId" uuid,
    "LastModificationTime" timestamp without time zone,
    "LastModifierId" uuid,
    "IsDeleted" boolean DEFAULT false NOT NULL,
    "DeleterId" uuid,
    "DeletionTime" timestamp without time zone
);


ALTER TABLE public."OpenIddictScopes" OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 30836)
-- Name: OpenIddictTokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OpenIddictTokens" (
    "Id" uuid NOT NULL,
    "ApplicationId" uuid,
    "AuthorizationId" uuid,
    "CreationDate" timestamp without time zone,
    "ExpirationDate" timestamp without time zone,
    "Payload" text,
    "Properties" text,
    "RedemptionDate" timestamp without time zone,
    "ReferenceId" character varying(100),
    "Status" character varying(50),
    "Subject" character varying(400),
    "Type" character varying(50),
    "ExtraProperties" text NOT NULL,
    "ConcurrencyStamp" character varying(40) NOT NULL
);


ALTER TABLE public."OpenIddictTokens" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 30348)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 5269 (class 0 OID 30644)
-- Dependencies: 242
-- Data for Name: AbpAuditLogActions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpAuditLogActions" ("Id", "TenantId", "AuditLogId", "ServiceName", "MethodName", "Parameters", "ExecutionTime", "ExecutionDuration", "ExtraProperties") FROM stdin;
\.


--
-- TOC entry 5247 (class 0 OID 30355)
-- Dependencies: 220
-- Data for Name: AbpAuditLogExcelFiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpAuditLogExcelFiles" ("Id", "TenantId", "FileName", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5248 (class 0 OID 30362)
-- Dependencies: 221
-- Data for Name: AbpAuditLogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpAuditLogs" ("Id", "ApplicationName", "UserId", "UserName", "TenantId", "TenantName", "ImpersonatorUserId", "ImpersonatorUserName", "ImpersonatorTenantId", "ImpersonatorTenantName", "ExecutionTime", "ExecutionDuration", "ClientIpAddress", "ClientName", "ClientId", "CorrelationId", "BrowserInfo", "HttpMethod", "Url", "Exceptions", "Comments", "HttpStatusCode", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5249 (class 0 OID 30374)
-- Dependencies: 222
-- Data for Name: AbpBackgroundJobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpBackgroundJobs" ("Id", "ApplicationName", "JobName", "JobArgs", "TryCount", "CreationTime", "NextTryTime", "LastTryTime", "IsAbandoned", "Priority", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5250 (class 0 OID 30394)
-- Dependencies: 223
-- Data for Name: AbpBlobContainers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpBlobContainers" ("Id", "TenantId", "Name", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5271 (class 0 OID 30677)
-- Dependencies: 244
-- Data for Name: AbpBlobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpBlobs" ("Id", "ContainerId", "TenantId", "Name", "Content", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5251 (class 0 OID 30405)
-- Dependencies: 224
-- Data for Name: AbpClaimTypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpClaimTypes" ("Id", "Name", "Required", "IsStatic", "Regex", "RegexDescription", "Description", "ValueType", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5270 (class 0 OID 30660)
-- Dependencies: 243
-- Data for Name: AbpEntityChanges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpEntityChanges" ("Id", "AuditLogId", "TenantId", "ChangeTime", "ChangeType", "EntityTenantId", "EntityId", "EntityTypeFullName", "ExtraProperties") FROM stdin;
\.


--
-- TOC entry 5280 (class 0 OID 30820)
-- Dependencies: 253
-- Data for Name: AbpEntityPropertyChanges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpEntityPropertyChanges" ("Id", "TenantId", "EntityChangeId", "NewValue", "OriginalValue", "PropertyName", "PropertyTypeFullName") FROM stdin;
\.


--
-- TOC entry 5252 (class 0 OID 30420)
-- Dependencies: 225
-- Data for Name: AbpFeatureGroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpFeatureGroups" ("Id", "Name", "DisplayName", "ExtraProperties") FROM stdin;
3a1e81db-2451-7148-c2a6-170da0b5cbf5	SettingManagement	L:AbpSettingManagement,Feature:SettingManagementGroup	{}
\.


--
-- TOC entry 5254 (class 0 OID 30443)
-- Dependencies: 227
-- Data for Name: AbpFeatureValues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpFeatureValues" ("Id", "Name", "Value", "ProviderName", "ProviderKey") FROM stdin;
\.


--
-- TOC entry 5253 (class 0 OID 30430)
-- Dependencies: 226
-- Data for Name: AbpFeatures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpFeatures" ("Id", "GroupName", "Name", "ParentName", "DisplayName", "Description", "DefaultValue", "IsVisibleToClients", "IsAvailableToHost", "AllowedProviders", "ValueType", "ExtraProperties") FROM stdin;
3a1e81db-2457-6512-e344-1096a543e59b	SettingManagement	SettingManagement.Enable	\N	L:AbpSettingManagement,Feature:SettingManagementEnable	L:AbpSettingManagement,Feature:SettingManagementEnableDescription	true	t	f	\N	{"name":"ToggleStringValueType","properties":{},"validator":{"name":"BOOLEAN","properties":{}}}	{}
3a1e81db-246c-1b0e-7446-68bddcb0f83c	SettingManagement	SettingManagement.AllowChangingEmailSettings	SettingManagement.Enable	L:AbpSettingManagement,Feature:AllowChangingEmailSettings	\N	false	t	f	\N	{"name":"ToggleStringValueType","properties":{},"validator":{"name":"BOOLEAN","properties":{}}}	{}
\.


--
-- TOC entry 5255 (class 0 OID 30451)
-- Dependencies: 228
-- Data for Name: AbpLinkUsers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpLinkUsers" ("Id", "SourceUserId", "SourceTenantId", "TargetUserId", "TargetTenantId") FROM stdin;
\.


--
-- TOC entry 5272 (class 0 OID 30694)
-- Dependencies: 245
-- Data for Name: AbpOrganizationUnitRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpOrganizationUnitRoles" ("RoleId", "OrganizationUnitId", "TenantId", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5256 (class 0 OID 30459)
-- Dependencies: 229
-- Data for Name: AbpOrganizationUnits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpOrganizationUnits" ("Id", "TenantId", "ParentId", "Code", "DisplayName", "EntityVersion", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5257 (class 0 OID 30480)
-- Dependencies: 230
-- Data for Name: AbpPermissionGrants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpPermissionGrants" ("Id", "TenantId", "Name", "ProviderName", "ProviderKey") FROM stdin;
3a1e81d7-5cb7-022d-8bb8-43ba5e340b4f	\N	AbpIdentity.Users.Update	R	admin
3a1e81d7-5cb7-1aae-24d1-b9645f4630d3	\N	AbpIdentity.Roles.Delete	R	admin
3a1e81d7-5cb7-319b-62d9-365bd83554c8	\N	AbpIdentity.Roles.Update	R	admin
3a1e81d7-5cb7-5275-8af8-ae3fdd6b8907	\N	FeatureManagement.ManageHostFeatures	R	admin
3a1e81d7-5cb7-57a2-8d43-a69b03ba40a2	\N	AbpIdentity.Roles.Create	R	admin
3a1e81d7-5cb7-5c5f-bc58-2f16622b9b0a	\N	AbpIdentity.Users.Update.ManageRoles	R	admin
3a1e81d7-5cb7-93e4-9e0b-f1d280be94ad	\N	SettingManagement.Emailing.Test	R	admin
3a1e81d7-5cb7-b917-92ac-9ed621d5d736	\N	AbpIdentity.Users.Create	R	admin
3a1e81d7-5cb7-bd47-3eba-93826905c821	\N	SettingManagement.Emailing	R	admin
3a1e81d7-5cb7-c0a1-c952-4f4b9cc9f09d	\N	SettingManagement.TimeZone	R	admin
3a1e81d7-5cb7-c0f2-f242-d7222216978b	\N	AbpIdentity.Users.ManagePermissions	R	admin
3a1e81d7-5cb7-da11-adb2-553576e6eeb5	\N	AbpIdentity.Users	R	admin
3a1e81d7-5cb7-da9c-a5ba-51bb3cab9ec4	\N	AbpIdentity.Roles	R	admin
3a1e81d7-5cb7-f504-3059-aff0ee037928	\N	AbpIdentity.Users.Delete	R	admin
3a1e81d7-5cb7-ff1d-bfa2-a6808f20444f	\N	AbpIdentity.Roles.ManagePermissions	R	admin
\.


--
-- TOC entry 5258 (class 0 OID 30489)
-- Dependencies: 231
-- Data for Name: AbpPermissionGroups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpPermissionGroups" ("Id", "Name", "DisplayName", "ExtraProperties") FROM stdin;
3a1e81db-2454-2b73-4d5e-4a2df36b0e73	AbpIdentity	L:AbpIdentity,Permission:IdentityManagement	{}
3a1e81db-2459-9ba0-d7d0-e9fcf5227500	FeatureManagement	L:AbpFeatureManagement,Permission:FeatureManagement	{}
3a1e81db-2459-e336-359b-72a52e1cc358	SettingManagement	L:AbpSettingManagement,Permission:SettingManagement	{}
3a1e81db-245b-0739-7115-aa13dd05374e	RegionMap	F:RegionMap	{}
\.


--
-- TOC entry 5259 (class 0 OID 30499)
-- Dependencies: 232
-- Data for Name: AbpPermissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpPermissions" ("Id", "GroupName", "Name", "ParentName", "DisplayName", "IsEnabled", "MultiTenancySide", "Providers", "StateCheckers", "ExtraProperties") FROM stdin;
3a1e81db-2457-815a-d935-640414854c2c	AbpIdentity	AbpIdentity.Roles	\N	L:AbpIdentity,Permission:RoleManagement	t	3	\N	\N	{}
3a1e81db-2459-434b-15ad-0c1bf4c21edd	AbpIdentity	AbpIdentity.Users.Update.ManageRoles	AbpIdentity.Users.Update	L:AbpIdentity,Permission:ManageRoles	t	3	\N	\N	{}
3a1e81db-2459-53c3-e635-ffcba53fe65f	AbpIdentity	AbpIdentity.Users.ManagePermissions	AbpIdentity.Users	L:AbpIdentity,Permission:ChangePermissions	t	3	\N	\N	{}
3a1e81db-2459-5499-ffed-688a2d411d01	AbpIdentity	AbpIdentity.Users.Delete	AbpIdentity.Users	L:AbpIdentity,Permission:Delete	t	3	\N	\N	{}
3a1e81db-2459-5ce1-a8bc-5111a6b7d937	AbpIdentity	AbpIdentity.Users	\N	L:AbpIdentity,Permission:UserManagement	t	3	\N	\N	{}
3a1e81db-2459-745a-0d37-cc52b74ba585	AbpIdentity	AbpIdentity.Users.Create	AbpIdentity.Users	L:AbpIdentity,Permission:Create	t	3	\N	\N	{}
3a1e81db-2459-990b-a4f6-2a860fe4c75a	AbpIdentity	AbpIdentity.Roles.ManagePermissions	AbpIdentity.Roles	L:AbpIdentity,Permission:ChangePermissions	t	3	\N	\N	{}
3a1e81db-2459-c735-8a5f-fe294b36e204	AbpIdentity	AbpIdentity.UserLookup	\N	L:AbpIdentity,Permission:UserLookup	t	3	C	\N	{}
3a1e81db-2459-d76e-aba2-9aa81b0a3e15	AbpIdentity	AbpIdentity.Roles.Delete	AbpIdentity.Roles	L:AbpIdentity,Permission:Delete	t	3	\N	\N	{}
3a1e81db-2459-db9f-bc1a-fc3b4d1370d6	AbpIdentity	AbpIdentity.Roles.Create	AbpIdentity.Roles	L:AbpIdentity,Permission:Create	t	3	\N	\N	{}
3a1e81db-2459-e303-ea29-1b5f2a3c05a6	FeatureManagement	FeatureManagement.ManageHostFeatures	\N	L:AbpFeatureManagement,Permission:FeatureManagement.ManageHostFeatures	t	2	\N	\N	{}
3a1e81db-2459-f049-7ab9-d47922f52c97	SettingManagement	SettingManagement.Emailing	\N	L:AbpSettingManagement,Permission:Emailing	t	3	\N	\N	{}
3a1e81db-2459-f263-9953-7dcc3c7a707e	AbpIdentity	AbpIdentity.Roles.Update	AbpIdentity.Roles	L:AbpIdentity,Permission:Edit	t	3	\N	\N	{}
3a1e81db-2459-f5ec-207e-d58448e31fd6	AbpIdentity	AbpIdentity.Users.Update	AbpIdentity.Users	L:AbpIdentity,Permission:Edit	t	3	\N	\N	{}
3a1e81db-245b-5b80-0293-4c17e11a5a61	SettingManagement	SettingManagement.TimeZone	\N	L:AbpSettingManagement,Permission:TimeZone	t	3	\N	\N	{}
3a1e81db-245b-8dc7-1755-4a2e388a27f6	SettingManagement	SettingManagement.Emailing.Test	SettingManagement.Emailing	L:AbpSettingManagement,Permission:EmailingTest	t	3	\N	\N	{}
\.


--
-- TOC entry 5273 (class 0 OID 30712)
-- Dependencies: 246
-- Data for Name: AbpRoleClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpRoleClaims" ("Id", "RoleId", "TenantId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5260 (class 0 OID 30512)
-- Dependencies: 233
-- Data for Name: AbpRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpRoles" ("Id", "TenantId", "Name", "NormalizedName", "IsDefault", "IsStatic", "IsPublic", "EntityVersion", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
3a1e81d7-5a95-bd49-5e5e-d59f3c8ef9da	\N	admin	ADMIN	f	t	t	2	2025-12-30 21:30:04.21998	{}	76bbedbc6864458c951124533c24b022
\.


--
-- TOC entry 5261 (class 0 OID 30529)
-- Dependencies: 234
-- Data for Name: AbpSecurityLogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpSecurityLogs" ("Id", "TenantId", "ApplicationName", "Identity", "Action", "UserId", "UserName", "TenantName", "ClientId", "CorrelationId", "ClientIpAddress", "BrowserInfo", "CreationTime", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5262 (class 0 OID 30540)
-- Dependencies: 235
-- Data for Name: AbpSessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpSessions" ("Id", "SessionId", "Device", "DeviceInfo", "TenantId", "UserId", "ClientId", "IpAddresses", "SignedIn", "LastAccessed", "ExtraProperties") FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 30552)
-- Dependencies: 236
-- Data for Name: AbpSettingDefinitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpSettingDefinitions" ("Id", "Name", "DisplayName", "Description", "DefaultValue", "IsVisibleToClients", "Providers", "IsInherited", "IsEncrypted", "ExtraProperties") FROM stdin;
3a1e81db-2465-6657-c152-71182a58bec8	Abp.Localization.DefaultLanguage	L:AbpLocalization,DisplayName:Abp.Localization.DefaultLanguage	L:AbpLocalization,Description:Abp.Localization.DefaultLanguage	en	t	\N	t	f	{}
3a1e81db-2466-244e-747a-f55eac17ecf5	Abp.Mailing.Smtp.Password	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Password	L:AbpEmailing,Description:Abp.Mailing.Smtp.Password	\N	f	\N	t	t	{}
3a1e81db-2466-2550-4834-1274b1e2ab15	Abp.Identity.Password.RequireUppercase	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireUppercase	L:AbpIdentity,Description:Abp.Identity.Password.RequireUppercase	True	t	\N	t	f	{}
3a1e81db-2466-27bc-17a9-ae860256f8b3	Abp.Account.IsSelfRegistrationEnabled	L:AbpAccount,DisplayName:Abp.Account.IsSelfRegistrationEnabled	L:AbpAccount,Description:Abp.Account.IsSelfRegistrationEnabled	true	t	\N	t	f	{}
3a1e81db-2466-2bdf-df9c-c1db1939bd85	Abp.Identity.Lockout.LockoutDuration	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.LockoutDuration	L:AbpIdentity,Description:Abp.Identity.Lockout.LockoutDuration	300	t	\N	t	f	{}
3a1e81db-2466-2c6b-b3c5-e4d50b5994fe	Abp.Mailing.Smtp.UseDefaultCredentials	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.UseDefaultCredentials	L:AbpEmailing,Description:Abp.Mailing.Smtp.UseDefaultCredentials	true	f	\N	t	f	{}
3a1e81db-2466-2d66-28bb-8a1523229431	Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	L:AbpIdentity,DisplayName:Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	L:AbpIdentity,Description:Abp.Identity.Password.ForceUsersToPeriodicallyChangePassword	False	t	\N	t	f	{}
3a1e81db-2466-3109-8bc7-9df3f36020eb	Abp.Identity.Password.RequiredLength	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequiredLength	L:AbpIdentity,Description:Abp.Identity.Password.RequiredLength	6	t	\N	t	f	{}
3a1e81db-2466-3b1f-53b1-04ebde4105e7	Abp.Identity.User.IsEmailUpdateEnabled	L:AbpIdentity,DisplayName:Abp.Identity.User.IsEmailUpdateEnabled	L:AbpIdentity,Description:Abp.Identity.User.IsEmailUpdateEnabled	True	t	\N	t	f	{}
3a1e81db-2466-3e32-5f83-032944bbc689	Abp.Timing.TimeZone	L:AbpTiming,DisplayName:Abp.Timing.Timezone	L:AbpTiming,Description:Abp.Timing.Timezone		t	\N	t	f	{}
3a1e81db-2466-4088-c7a4-d0e332ab47cd	Abp.Identity.SignIn.RequireConfirmedEmail	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireConfirmedEmail	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireConfirmedEmail	False	t	\N	t	f	{}
3a1e81db-2466-495c-e8ee-ec1679c2cd6d	Abp.Identity.OrganizationUnit.MaxUserMembershipCount	L:AbpIdentity,Identity.OrganizationUnit.MaxUserMembershipCount	L:AbpIdentity,Identity.OrganizationUnit.MaxUserMembershipCount	2147483647	t	\N	t	f	{}
3a1e81db-2466-4add-f03a-d8921c2a57d1	Abp.Mailing.DefaultFromDisplayName	L:AbpEmailing,DisplayName:Abp.Mailing.DefaultFromDisplayName	L:AbpEmailing,Description:Abp.Mailing.DefaultFromDisplayName	ABP application	f	\N	t	f	{}
3a1e81db-2466-4db3-558b-d1331eb7f029	Abp.Identity.Lockout.AllowedForNewUsers	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.AllowedForNewUsers	L:AbpIdentity,Description:Abp.Identity.Lockout.AllowedForNewUsers	True	t	\N	t	f	{}
3a1e81db-2466-4fcd-5f19-375897e53de4	Abp.Account.EnableLocalLogin	L:AbpAccount,DisplayName:Abp.Account.EnableLocalLogin	L:AbpAccount,Description:Abp.Account.EnableLocalLogin	true	t	\N	t	f	{}
3a1e81db-2466-57cd-e73f-30a7cd2fde57	Abp.Identity.Password.RequireNonAlphanumeric	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireNonAlphanumeric	L:AbpIdentity,Description:Abp.Identity.Password.RequireNonAlphanumeric	True	t	\N	t	f	{}
3a1e81db-2466-59f5-0fd1-38fc4eff792b	Abp.Identity.SignIn.EnablePhoneNumberConfirmation	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.EnablePhoneNumberConfirmation	L:AbpIdentity,Description:Abp.Identity.SignIn.EnablePhoneNumberConfirmation	True	t	\N	t	f	{}
3a1e81db-2466-63c9-fa34-19b87fa03801	Abp.Mailing.Smtp.Port	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Port	L:AbpEmailing,Description:Abp.Mailing.Smtp.Port	25	f	\N	t	f	{}
3a1e81db-2466-7513-ed7d-020faaf142c4	Abp.Identity.Password.RequireDigit	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireDigit	L:AbpIdentity,Description:Abp.Identity.Password.RequireDigit	True	t	\N	t	f	{}
3a1e81db-2466-815f-8601-e64fcf6494b4	Abp.Mailing.Smtp.Domain	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Domain	L:AbpEmailing,Description:Abp.Mailing.Smtp.Domain	\N	f	\N	t	f	{}
3a1e81db-2466-9ba1-1e3a-acae898d30b9	Abp.Mailing.Smtp.UserName	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.UserName	L:AbpEmailing,Description:Abp.Mailing.Smtp.UserName	\N	f	\N	t	f	{}
3a1e81db-2466-a6bb-fcf0-c78bf60f443e	Abp.Mailing.DefaultFromAddress	L:AbpEmailing,DisplayName:Abp.Mailing.DefaultFromAddress	L:AbpEmailing,Description:Abp.Mailing.DefaultFromAddress	noreply@abp.io	f	\N	t	f	{}
3a1e81db-2466-afc1-26cf-e7ccd96cd6b8	Abp.Identity.SignIn.RequireEmailVerificationToRegister	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireEmailVerificationToRegister	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireEmailVerificationToRegister	False	f	\N	t	f	{}
3a1e81db-2466-d09f-70ac-7aa0c7696352	Abp.Identity.User.IsUserNameUpdateEnabled	L:AbpIdentity,DisplayName:Abp.Identity.User.IsUserNameUpdateEnabled	L:AbpIdentity,Description:Abp.Identity.User.IsUserNameUpdateEnabled	True	t	\N	t	f	{}
3a1e81db-2466-d2ac-d418-ccd09c103fd9	Abp.Identity.Lockout.MaxFailedAccessAttempts	L:AbpIdentity,DisplayName:Abp.Identity.Lockout.MaxFailedAccessAttempts	L:AbpIdentity,Description:Abp.Identity.Lockout.MaxFailedAccessAttempts	5	t	\N	t	f	{}
3a1e81db-2466-db9e-d080-dbe3abca3930	Abp.Identity.SignIn.RequireConfirmedPhoneNumber	L:AbpIdentity,DisplayName:Abp.Identity.SignIn.RequireConfirmedPhoneNumber	L:AbpIdentity,Description:Abp.Identity.SignIn.RequireConfirmedPhoneNumber	False	t	\N	t	f	{}
3a1e81db-2466-ec54-5126-0d1442a52441	Abp.Identity.Password.PasswordChangePeriodDays	L:AbpIdentity,DisplayName:Abp.Identity.Password.PasswordChangePeriodDays	L:AbpIdentity,Description:Abp.Identity.Password.PasswordChangePeriodDays	0	t	\N	t	f	{}
3a1e81db-2466-f5a0-2e2f-288a2c13007a	Abp.Mailing.Smtp.EnableSsl	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.EnableSsl	L:AbpEmailing,Description:Abp.Mailing.Smtp.EnableSsl	false	f	\N	t	f	{}
3a1e81db-2466-fa20-6522-2da6b9009ce5	Abp.Identity.Password.RequiredUniqueChars	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequiredUniqueChars	L:AbpIdentity,Description:Abp.Identity.Password.RequiredUniqueChars	1	t	\N	t	f	{}
3a1e81db-2466-fab9-c67d-291da3e0d698	Abp.Identity.Password.RequireLowercase	L:AbpIdentity,DisplayName:Abp.Identity.Password.RequireLowercase	L:AbpIdentity,Description:Abp.Identity.Password.RequireLowercase	True	t	\N	t	f	{}
3a1e81db-2466-ffd2-7580-cafd594735ec	Abp.Mailing.Smtp.Host	L:AbpEmailing,DisplayName:Abp.Mailing.Smtp.Host	L:AbpEmailing,Description:Abp.Mailing.Smtp.Host	127.0.0.1	f	\N	t	f	{}
\.


--
-- TOC entry 5264 (class 0 OID 30565)
-- Dependencies: 237
-- Data for Name: AbpSettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpSettings" ("Id", "Name", "Value", "ProviderName", "ProviderKey") FROM stdin;
\.


--
-- TOC entry 5274 (class 0 OID 30727)
-- Dependencies: 247
-- Data for Name: AbpUserClaims; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserClaims" ("Id", "UserId", "TenantId", "ClaimType", "ClaimValue") FROM stdin;
\.


--
-- TOC entry 5265 (class 0 OID 30575)
-- Dependencies: 238
-- Data for Name: AbpUserDelegations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserDelegations" ("Id", "TenantId", "SourceUserId", "TargetUserId", "StartTime", "EndTime") FROM stdin;
\.


--
-- TOC entry 5275 (class 0 OID 30742)
-- Dependencies: 248
-- Data for Name: AbpUserLogins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserLogins" ("UserId", "LoginProvider", "TenantId", "ProviderKey", "ProviderDisplayName") FROM stdin;
\.


--
-- TOC entry 5276 (class 0 OID 30755)
-- Dependencies: 249
-- Data for Name: AbpUserOrganizationUnits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserOrganizationUnits" ("UserId", "OrganizationUnitId", "TenantId", "CreationTime", "CreatorId") FROM stdin;
\.


--
-- TOC entry 5277 (class 0 OID 30773)
-- Dependencies: 250
-- Data for Name: AbpUserRoles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserRoles" ("UserId", "RoleId", "TenantId") FROM stdin;
3a1e81d7-574c-c0d1-5090-9efc5ed32a35	3a1e81d7-5a95-bd49-5e5e-d59f3c8ef9da	\N
\.


--
-- TOC entry 5278 (class 0 OID 30790)
-- Dependencies: 251
-- Data for Name: AbpUserTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUserTokens" ("UserId", "LoginProvider", "Name", "TenantId", "Value") FROM stdin;
\.


--
-- TOC entry 5266 (class 0 OID 30585)
-- Dependencies: 239
-- Data for Name: AbpUsers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AbpUsers" ("Id", "TenantId", "UserName", "NormalizedUserName", "Name", "Surname", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "IsExternal", "PhoneNumber", "PhoneNumberConfirmed", "IsActive", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount", "ShouldChangePasswordOnNextLogin", "EntityVersion", "LastPasswordChangeTime", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
3a1e81d7-574c-c0d1-5090-9efc5ed32a35	\N	admin	ADMIN	admin	\N	admin@abp.io	ADMIN@ABP.IO	f	AQAAAAIAAYagAAAAEEnjehMNbvE+LDn69XnInef8OM/XnzwDytcju8RKVh1agnRiFCHSGHgx0znPnnkn5A==	B72HLSVGC7GRRZBIVSLLS5RHPANQWSQ7	f	\N	f	t	f	\N	t	0	f	2	2025-12-30 21:30:03.447114+07	{}	41e675ef54354e7d8622c55832268326	2025-12-30 21:30:03.674959	\N	2025-12-30 21:30:04.537884	\N	f	\N	\N
\.


--
-- TOC entry 5267 (class 0 OID 30618)
-- Dependencies: 240
-- Data for Name: OpenIddictApplications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenIddictApplications" ("Id", "ApplicationType", "ClientId", "ClientSecret", "ClientType", "ConsentType", "DisplayName", "DisplayNames", "JsonWebKeySet", "Permissions", "PostLogoutRedirectUris", "Properties", "RedirectUris", "Requirements", "Settings", "ClientUri", "LogoUri", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5279 (class 0 OID 30805)
-- Dependencies: 252
-- Data for Name: OpenIddictAuthorizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenIddictAuthorizations" ("Id", "ApplicationId", "CreationDate", "Properties", "Scopes", "Status", "Subject", "Type", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5268 (class 0 OID 30631)
-- Dependencies: 241
-- Data for Name: OpenIddictScopes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenIddictScopes" ("Id", "Description", "Descriptions", "DisplayName", "DisplayNames", "Name", "Properties", "Resources", "ExtraProperties", "ConcurrencyStamp", "CreationTime", "CreatorId", "LastModificationTime", "LastModifierId", "IsDeleted", "DeleterId", "DeletionTime") FROM stdin;
\.


--
-- TOC entry 5281 (class 0 OID 30836)
-- Dependencies: 254
-- Data for Name: OpenIddictTokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OpenIddictTokens" ("Id", "ApplicationId", "AuthorizationId", "CreationDate", "ExpirationDate", "Payload", "Properties", "RedemptionDate", "ReferenceId", "Status", "Subject", "Type", "ExtraProperties", "ConcurrencyStamp") FROM stdin;
\.


--
-- TOC entry 5246 (class 0 OID 30348)
-- Dependencies: 219
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20251230142924_Initial	9.0.5
\.


--
-- TOC entry 5041 (class 2606 OID 30654)
-- Name: AbpAuditLogActions PK_AbpAuditLogActions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpAuditLogActions"
    ADD CONSTRAINT "PK_AbpAuditLogActions" PRIMARY KEY ("Id");


--
-- TOC entry 4964 (class 2606 OID 30361)
-- Name: AbpAuditLogExcelFiles PK_AbpAuditLogExcelFiles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpAuditLogExcelFiles"
    ADD CONSTRAINT "PK_AbpAuditLogExcelFiles" PRIMARY KEY ("Id");


--
-- TOC entry 4968 (class 2606 OID 30373)
-- Name: AbpAuditLogs PK_AbpAuditLogs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpAuditLogs"
    ADD CONSTRAINT "PK_AbpAuditLogs" PRIMARY KEY ("Id");


--
-- TOC entry 4971 (class 2606 OID 30393)
-- Name: AbpBackgroundJobs PK_AbpBackgroundJobs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpBackgroundJobs"
    ADD CONSTRAINT "PK_AbpBackgroundJobs" PRIMARY KEY ("Id");


--
-- TOC entry 4974 (class 2606 OID 30404)
-- Name: AbpBlobContainers PK_AbpBlobContainers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpBlobContainers"
    ADD CONSTRAINT "PK_AbpBlobContainers" PRIMARY KEY ("Id");


--
-- TOC entry 5049 (class 2606 OID 30688)
-- Name: AbpBlobs PK_AbpBlobs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpBlobs"
    ADD CONSTRAINT "PK_AbpBlobs" PRIMARY KEY ("Id");


--
-- TOC entry 4976 (class 2606 OID 30419)
-- Name: AbpClaimTypes PK_AbpClaimTypes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpClaimTypes"
    ADD CONSTRAINT "PK_AbpClaimTypes" PRIMARY KEY ("Id");


--
-- TOC entry 5045 (class 2606 OID 30671)
-- Name: AbpEntityChanges PK_AbpEntityChanges; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpEntityChanges"
    ADD CONSTRAINT "PK_AbpEntityChanges" PRIMARY KEY ("Id");


--
-- TOC entry 5075 (class 2606 OID 30830)
-- Name: AbpEntityPropertyChanges PK_AbpEntityPropertyChanges; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpEntityPropertyChanges"
    ADD CONSTRAINT "PK_AbpEntityPropertyChanges" PRIMARY KEY ("Id");


--
-- TOC entry 4979 (class 2606 OID 30429)
-- Name: AbpFeatureGroups PK_AbpFeatureGroups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpFeatureGroups"
    ADD CONSTRAINT "PK_AbpFeatureGroups" PRIMARY KEY ("Id");


--
-- TOC entry 4986 (class 2606 OID 30450)
-- Name: AbpFeatureValues PK_AbpFeatureValues; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpFeatureValues"
    ADD CONSTRAINT "PK_AbpFeatureValues" PRIMARY KEY ("Id");


--
-- TOC entry 4983 (class 2606 OID 30442)
-- Name: AbpFeatures PK_AbpFeatures; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpFeatures"
    ADD CONSTRAINT "PK_AbpFeatures" PRIMARY KEY ("Id");


--
-- TOC entry 4989 (class 2606 OID 30458)
-- Name: AbpLinkUsers PK_AbpLinkUsers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpLinkUsers"
    ADD CONSTRAINT "PK_AbpLinkUsers" PRIMARY KEY ("Id");


--
-- TOC entry 5052 (class 2606 OID 30701)
-- Name: AbpOrganizationUnitRoles PK_AbpOrganizationUnitRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "PK_AbpOrganizationUnitRoles" PRIMARY KEY ("OrganizationUnitId", "RoleId");


--
-- TOC entry 4993 (class 2606 OID 30474)
-- Name: AbpOrganizationUnits PK_AbpOrganizationUnits; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpOrganizationUnits"
    ADD CONSTRAINT "PK_AbpOrganizationUnits" PRIMARY KEY ("Id");


--
-- TOC entry 4996 (class 2606 OID 30488)
-- Name: AbpPermissionGrants PK_AbpPermissionGrants; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpPermissionGrants"
    ADD CONSTRAINT "PK_AbpPermissionGrants" PRIMARY KEY ("Id");


--
-- TOC entry 4999 (class 2606 OID 30498)
-- Name: AbpPermissionGroups PK_AbpPermissionGroups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpPermissionGroups"
    ADD CONSTRAINT "PK_AbpPermissionGroups" PRIMARY KEY ("Id");


--
-- TOC entry 5003 (class 2606 OID 30511)
-- Name: AbpPermissions PK_AbpPermissions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpPermissions"
    ADD CONSTRAINT "PK_AbpPermissions" PRIMARY KEY ("Id");


--
-- TOC entry 5055 (class 2606 OID 30721)
-- Name: AbpRoleClaims PK_AbpRoleClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpRoleClaims"
    ADD CONSTRAINT "PK_AbpRoleClaims" PRIMARY KEY ("Id");


--
-- TOC entry 5006 (class 2606 OID 30528)
-- Name: AbpRoles PK_AbpRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpRoles"
    ADD CONSTRAINT "PK_AbpRoles" PRIMARY KEY ("Id");


--
-- TOC entry 5012 (class 2606 OID 30539)
-- Name: AbpSecurityLogs PK_AbpSecurityLogs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpSecurityLogs"
    ADD CONSTRAINT "PK_AbpSecurityLogs" PRIMARY KEY ("Id");


--
-- TOC entry 5017 (class 2606 OID 30551)
-- Name: AbpSessions PK_AbpSessions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpSessions"
    ADD CONSTRAINT "PK_AbpSessions" PRIMARY KEY ("Id");


--
-- TOC entry 5020 (class 2606 OID 30564)
-- Name: AbpSettingDefinitions PK_AbpSettingDefinitions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpSettingDefinitions"
    ADD CONSTRAINT "PK_AbpSettingDefinitions" PRIMARY KEY ("Id");


--
-- TOC entry 5023 (class 2606 OID 30574)
-- Name: AbpSettings PK_AbpSettings; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpSettings"
    ADD CONSTRAINT "PK_AbpSettings" PRIMARY KEY ("Id");


--
-- TOC entry 5058 (class 2606 OID 30736)
-- Name: AbpUserClaims PK_AbpUserClaims; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserClaims"
    ADD CONSTRAINT "PK_AbpUserClaims" PRIMARY KEY ("Id");


--
-- TOC entry 5025 (class 2606 OID 30584)
-- Name: AbpUserDelegations PK_AbpUserDelegations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserDelegations"
    ADD CONSTRAINT "PK_AbpUserDelegations" PRIMARY KEY ("Id");


--
-- TOC entry 5061 (class 2606 OID 30749)
-- Name: AbpUserLogins PK_AbpUserLogins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserLogins"
    ADD CONSTRAINT "PK_AbpUserLogins" PRIMARY KEY ("UserId", "LoginProvider");


--
-- TOC entry 5064 (class 2606 OID 30762)
-- Name: AbpUserOrganizationUnits PK_AbpUserOrganizationUnits; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserOrganizationUnits"
    ADD CONSTRAINT "PK_AbpUserOrganizationUnits" PRIMARY KEY ("OrganizationUnitId", "UserId");


--
-- TOC entry 5067 (class 2606 OID 30779)
-- Name: AbpUserRoles PK_AbpUserRoles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserRoles"
    ADD CONSTRAINT "PK_AbpUserRoles" PRIMARY KEY ("UserId", "RoleId");


--
-- TOC entry 5069 (class 2606 OID 30799)
-- Name: AbpUserTokens PK_AbpUserTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserTokens"
    ADD CONSTRAINT "PK_AbpUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name");


--
-- TOC entry 5031 (class 2606 OID 30617)
-- Name: AbpUsers PK_AbpUsers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUsers"
    ADD CONSTRAINT "PK_AbpUsers" PRIMARY KEY ("Id");


--
-- TOC entry 5034 (class 2606 OID 30630)
-- Name: OpenIddictApplications PK_OpenIddictApplications; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictApplications"
    ADD CONSTRAINT "PK_OpenIddictApplications" PRIMARY KEY ("Id");


--
-- TOC entry 5072 (class 2606 OID 30814)
-- Name: OpenIddictAuthorizations PK_OpenIddictAuthorizations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictAuthorizations"
    ADD CONSTRAINT "PK_OpenIddictAuthorizations" PRIMARY KEY ("Id");


--
-- TOC entry 5037 (class 2606 OID 30643)
-- Name: OpenIddictScopes PK_OpenIddictScopes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictScopes"
    ADD CONSTRAINT "PK_OpenIddictScopes" PRIMARY KEY ("Id");


--
-- TOC entry 5080 (class 2606 OID 30845)
-- Name: OpenIddictTokens PK_OpenIddictTokens; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictTokens"
    ADD CONSTRAINT "PK_OpenIddictTokens" PRIMARY KEY ("Id");


--
-- TOC entry 4962 (class 2606 OID 30354)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 5038 (class 1259 OID 30856)
-- Name: IX_AbpAuditLogActions_AuditLogId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogActions_AuditLogId" ON public."AbpAuditLogActions" USING btree ("AuditLogId");


--
-- TOC entry 5039 (class 1259 OID 30857)
-- Name: IX_AbpAuditLogActions_TenantId_ServiceName_MethodName_Executio~; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogActions_TenantId_ServiceName_MethodName_Executio~" ON public."AbpAuditLogActions" USING btree ("TenantId", "ServiceName", "MethodName", "ExecutionTime");


--
-- TOC entry 4965 (class 1259 OID 30858)
-- Name: IX_AbpAuditLogs_TenantId_ExecutionTime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogs_TenantId_ExecutionTime" ON public."AbpAuditLogs" USING btree ("TenantId", "ExecutionTime");


--
-- TOC entry 4966 (class 1259 OID 30859)
-- Name: IX_AbpAuditLogs_TenantId_UserId_ExecutionTime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpAuditLogs_TenantId_UserId_ExecutionTime" ON public."AbpAuditLogs" USING btree ("TenantId", "UserId", "ExecutionTime");


--
-- TOC entry 4969 (class 1259 OID 30860)
-- Name: IX_AbpBackgroundJobs_IsAbandoned_NextTryTime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpBackgroundJobs_IsAbandoned_NextTryTime" ON public."AbpBackgroundJobs" USING btree ("IsAbandoned", "NextTryTime");


--
-- TOC entry 4972 (class 1259 OID 30861)
-- Name: IX_AbpBlobContainers_TenantId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpBlobContainers_TenantId_Name" ON public."AbpBlobContainers" USING btree ("TenantId", "Name");


--
-- TOC entry 5046 (class 1259 OID 30862)
-- Name: IX_AbpBlobs_ContainerId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpBlobs_ContainerId" ON public."AbpBlobs" USING btree ("ContainerId");


--
-- TOC entry 5047 (class 1259 OID 30863)
-- Name: IX_AbpBlobs_TenantId_ContainerId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpBlobs_TenantId_ContainerId_Name" ON public."AbpBlobs" USING btree ("TenantId", "ContainerId", "Name");


--
-- TOC entry 5042 (class 1259 OID 30864)
-- Name: IX_AbpEntityChanges_AuditLogId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpEntityChanges_AuditLogId" ON public."AbpEntityChanges" USING btree ("AuditLogId");


--
-- TOC entry 5043 (class 1259 OID 30865)
-- Name: IX_AbpEntityChanges_TenantId_EntityTypeFullName_EntityId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpEntityChanges_TenantId_EntityTypeFullName_EntityId" ON public."AbpEntityChanges" USING btree ("TenantId", "EntityTypeFullName", "EntityId");


--
-- TOC entry 5073 (class 1259 OID 30866)
-- Name: IX_AbpEntityPropertyChanges_EntityChangeId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpEntityPropertyChanges_EntityChangeId" ON public."AbpEntityPropertyChanges" USING btree ("EntityChangeId");


--
-- TOC entry 4977 (class 1259 OID 30867)
-- Name: IX_AbpFeatureGroups_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatureGroups_Name" ON public."AbpFeatureGroups" USING btree ("Name");


--
-- TOC entry 4984 (class 1259 OID 30870)
-- Name: IX_AbpFeatureValues_Name_ProviderName_ProviderKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatureValues_Name_ProviderName_ProviderKey" ON public."AbpFeatureValues" USING btree ("Name", "ProviderName", "ProviderKey");


--
-- TOC entry 4980 (class 1259 OID 30868)
-- Name: IX_AbpFeatures_GroupName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpFeatures_GroupName" ON public."AbpFeatures" USING btree ("GroupName");


--
-- TOC entry 4981 (class 1259 OID 30869)
-- Name: IX_AbpFeatures_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpFeatures_Name" ON public."AbpFeatures" USING btree ("Name");


--
-- TOC entry 4987 (class 1259 OID 30871)
-- Name: IX_AbpLinkUsers_SourceUserId_SourceTenantId_TargetUserId_Targe~; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpLinkUsers_SourceUserId_SourceTenantId_TargetUserId_Targe~" ON public."AbpLinkUsers" USING btree ("SourceUserId", "SourceTenantId", "TargetUserId", "TargetTenantId");


--
-- TOC entry 5050 (class 1259 OID 30872)
-- Name: IX_AbpOrganizationUnitRoles_RoleId_OrganizationUnitId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnitRoles_RoleId_OrganizationUnitId" ON public."AbpOrganizationUnitRoles" USING btree ("RoleId", "OrganizationUnitId");


--
-- TOC entry 4990 (class 1259 OID 30873)
-- Name: IX_AbpOrganizationUnits_Code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnits_Code" ON public."AbpOrganizationUnits" USING btree ("Code");


--
-- TOC entry 4991 (class 1259 OID 30874)
-- Name: IX_AbpOrganizationUnits_ParentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpOrganizationUnits_ParentId" ON public."AbpOrganizationUnits" USING btree ("ParentId");


--
-- TOC entry 4994 (class 1259 OID 30875)
-- Name: IX_AbpPermissionGrants_TenantId_Name_ProviderName_ProviderKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissionGrants_TenantId_Name_ProviderName_ProviderKey" ON public."AbpPermissionGrants" USING btree ("TenantId", "Name", "ProviderName", "ProviderKey");


--
-- TOC entry 4997 (class 1259 OID 30876)
-- Name: IX_AbpPermissionGroups_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissionGroups_Name" ON public."AbpPermissionGroups" USING btree ("Name");


--
-- TOC entry 5000 (class 1259 OID 30877)
-- Name: IX_AbpPermissions_GroupName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpPermissions_GroupName" ON public."AbpPermissions" USING btree ("GroupName");


--
-- TOC entry 5001 (class 1259 OID 30878)
-- Name: IX_AbpPermissions_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpPermissions_Name" ON public."AbpPermissions" USING btree ("Name");


--
-- TOC entry 5053 (class 1259 OID 30879)
-- Name: IX_AbpRoleClaims_RoleId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpRoleClaims_RoleId" ON public."AbpRoleClaims" USING btree ("RoleId");


--
-- TOC entry 5004 (class 1259 OID 30880)
-- Name: IX_AbpRoles_NormalizedName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpRoles_NormalizedName" ON public."AbpRoles" USING btree ("NormalizedName");


--
-- TOC entry 5007 (class 1259 OID 30881)
-- Name: IX_AbpSecurityLogs_TenantId_Action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_Action" ON public."AbpSecurityLogs" USING btree ("TenantId", "Action");


--
-- TOC entry 5008 (class 1259 OID 30882)
-- Name: IX_AbpSecurityLogs_TenantId_ApplicationName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_ApplicationName" ON public."AbpSecurityLogs" USING btree ("TenantId", "ApplicationName");


--
-- TOC entry 5009 (class 1259 OID 30883)
-- Name: IX_AbpSecurityLogs_TenantId_Identity; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_Identity" ON public."AbpSecurityLogs" USING btree ("TenantId", "Identity");


--
-- TOC entry 5010 (class 1259 OID 30884)
-- Name: IX_AbpSecurityLogs_TenantId_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSecurityLogs_TenantId_UserId" ON public."AbpSecurityLogs" USING btree ("TenantId", "UserId");


--
-- TOC entry 5013 (class 1259 OID 30885)
-- Name: IX_AbpSessions_Device; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_Device" ON public."AbpSessions" USING btree ("Device");


--
-- TOC entry 5014 (class 1259 OID 30886)
-- Name: IX_AbpSessions_SessionId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_SessionId" ON public."AbpSessions" USING btree ("SessionId");


--
-- TOC entry 5015 (class 1259 OID 30887)
-- Name: IX_AbpSessions_TenantId_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpSessions_TenantId_UserId" ON public."AbpSessions" USING btree ("TenantId", "UserId");


--
-- TOC entry 5018 (class 1259 OID 30888)
-- Name: IX_AbpSettingDefinitions_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpSettingDefinitions_Name" ON public."AbpSettingDefinitions" USING btree ("Name");


--
-- TOC entry 5021 (class 1259 OID 30889)
-- Name: IX_AbpSettings_Name_ProviderName_ProviderKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_AbpSettings_Name_ProviderName_ProviderKey" ON public."AbpSettings" USING btree ("Name", "ProviderName", "ProviderKey");


--
-- TOC entry 5056 (class 1259 OID 30890)
-- Name: IX_AbpUserClaims_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUserClaims_UserId" ON public."AbpUserClaims" USING btree ("UserId");


--
-- TOC entry 5059 (class 1259 OID 30891)
-- Name: IX_AbpUserLogins_LoginProvider_ProviderKey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUserLogins_LoginProvider_ProviderKey" ON public."AbpUserLogins" USING btree ("LoginProvider", "ProviderKey");


--
-- TOC entry 5062 (class 1259 OID 30892)
-- Name: IX_AbpUserOrganizationUnits_UserId_OrganizationUnitId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUserOrganizationUnits_UserId_OrganizationUnitId" ON public."AbpUserOrganizationUnits" USING btree ("UserId", "OrganizationUnitId");


--
-- TOC entry 5065 (class 1259 OID 30893)
-- Name: IX_AbpUserRoles_RoleId_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUserRoles_RoleId_UserId" ON public."AbpUserRoles" USING btree ("RoleId", "UserId");


--
-- TOC entry 5026 (class 1259 OID 30894)
-- Name: IX_AbpUsers_Email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_Email" ON public."AbpUsers" USING btree ("Email");


--
-- TOC entry 5027 (class 1259 OID 30895)
-- Name: IX_AbpUsers_NormalizedEmail; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_NormalizedEmail" ON public."AbpUsers" USING btree ("NormalizedEmail");


--
-- TOC entry 5028 (class 1259 OID 30896)
-- Name: IX_AbpUsers_NormalizedUserName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_NormalizedUserName" ON public."AbpUsers" USING btree ("NormalizedUserName");


--
-- TOC entry 5029 (class 1259 OID 30897)
-- Name: IX_AbpUsers_UserName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_AbpUsers_UserName" ON public."AbpUsers" USING btree ("UserName");


--
-- TOC entry 5032 (class 1259 OID 30898)
-- Name: IX_OpenIddictApplications_ClientId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictApplications_ClientId" ON public."OpenIddictApplications" USING btree ("ClientId");


--
-- TOC entry 5070 (class 1259 OID 30899)
-- Name: IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictAuthorizations_ApplicationId_Status_Subject_Type" ON public."OpenIddictAuthorizations" USING btree ("ApplicationId", "Status", "Subject", "Type");


--
-- TOC entry 5035 (class 1259 OID 30900)
-- Name: IX_OpenIddictScopes_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictScopes_Name" ON public."OpenIddictScopes" USING btree ("Name");


--
-- TOC entry 5076 (class 1259 OID 30901)
-- Name: IX_OpenIddictTokens_ApplicationId_Status_Subject_Type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_ApplicationId_Status_Subject_Type" ON public."OpenIddictTokens" USING btree ("ApplicationId", "Status", "Subject", "Type");


--
-- TOC entry 5077 (class 1259 OID 30902)
-- Name: IX_OpenIddictTokens_AuthorizationId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_AuthorizationId" ON public."OpenIddictTokens" USING btree ("AuthorizationId");


--
-- TOC entry 5078 (class 1259 OID 30903)
-- Name: IX_OpenIddictTokens_ReferenceId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_OpenIddictTokens_ReferenceId" ON public."OpenIddictTokens" USING btree ("ReferenceId");


--
-- TOC entry 5082 (class 2606 OID 30655)
-- Name: AbpAuditLogActions FK_AbpAuditLogActions_AbpAuditLogs_AuditLogId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpAuditLogActions"
    ADD CONSTRAINT "FK_AbpAuditLogActions_AbpAuditLogs_AuditLogId" FOREIGN KEY ("AuditLogId") REFERENCES public."AbpAuditLogs"("Id") ON DELETE CASCADE;


--
-- TOC entry 5084 (class 2606 OID 30689)
-- Name: AbpBlobs FK_AbpBlobs_AbpBlobContainers_ContainerId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpBlobs"
    ADD CONSTRAINT "FK_AbpBlobs_AbpBlobContainers_ContainerId" FOREIGN KEY ("ContainerId") REFERENCES public."AbpBlobContainers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5083 (class 2606 OID 30672)
-- Name: AbpEntityChanges FK_AbpEntityChanges_AbpAuditLogs_AuditLogId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpEntityChanges"
    ADD CONSTRAINT "FK_AbpEntityChanges_AbpAuditLogs_AuditLogId" FOREIGN KEY ("AuditLogId") REFERENCES public."AbpAuditLogs"("Id") ON DELETE CASCADE;


--
-- TOC entry 5096 (class 2606 OID 30831)
-- Name: AbpEntityPropertyChanges FK_AbpEntityPropertyChanges_AbpEntityChanges_EntityChangeId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpEntityPropertyChanges"
    ADD CONSTRAINT "FK_AbpEntityPropertyChanges_AbpEntityChanges_EntityChangeId" FOREIGN KEY ("EntityChangeId") REFERENCES public."AbpEntityChanges"("Id") ON DELETE CASCADE;


--
-- TOC entry 5085 (class 2606 OID 30702)
-- Name: AbpOrganizationUnitRoles FK_AbpOrganizationUnitRoles_AbpOrganizationUnits_OrganizationU~; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "FK_AbpOrganizationUnitRoles_AbpOrganizationUnits_OrganizationU~" FOREIGN KEY ("OrganizationUnitId") REFERENCES public."AbpOrganizationUnits"("Id") ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 30707)
-- Name: AbpOrganizationUnitRoles FK_AbpOrganizationUnitRoles_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpOrganizationUnitRoles"
    ADD CONSTRAINT "FK_AbpOrganizationUnitRoles_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5081 (class 2606 OID 30475)
-- Name: AbpOrganizationUnits FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpOrganizationUnits"
    ADD CONSTRAINT "FK_AbpOrganizationUnits_AbpOrganizationUnits_ParentId" FOREIGN KEY ("ParentId") REFERENCES public."AbpOrganizationUnits"("Id");


--
-- TOC entry 5087 (class 2606 OID 30722)
-- Name: AbpRoleClaims FK_AbpRoleClaims_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpRoleClaims"
    ADD CONSTRAINT "FK_AbpRoleClaims_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5088 (class 2606 OID 30737)
-- Name: AbpUserClaims FK_AbpUserClaims_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserClaims"
    ADD CONSTRAINT "FK_AbpUserClaims_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5089 (class 2606 OID 30750)
-- Name: AbpUserLogins FK_AbpUserLogins_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserLogins"
    ADD CONSTRAINT "FK_AbpUserLogins_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5090 (class 2606 OID 30763)
-- Name: AbpUserOrganizationUnits FK_AbpUserOrganizationUnits_AbpOrganizationUnits_OrganizationU~; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserOrganizationUnits"
    ADD CONSTRAINT "FK_AbpUserOrganizationUnits_AbpOrganizationUnits_OrganizationU~" FOREIGN KEY ("OrganizationUnitId") REFERENCES public."AbpOrganizationUnits"("Id") ON DELETE CASCADE;


--
-- TOC entry 5091 (class 2606 OID 30768)
-- Name: AbpUserOrganizationUnits FK_AbpUserOrganizationUnits_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserOrganizationUnits"
    ADD CONSTRAINT "FK_AbpUserOrganizationUnits_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5092 (class 2606 OID 30780)
-- Name: AbpUserRoles FK_AbpUserRoles_AbpRoles_RoleId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserRoles"
    ADD CONSTRAINT "FK_AbpUserRoles_AbpRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES public."AbpRoles"("Id") ON DELETE CASCADE;


--
-- TOC entry 5093 (class 2606 OID 30785)
-- Name: AbpUserRoles FK_AbpUserRoles_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserRoles"
    ADD CONSTRAINT "FK_AbpUserRoles_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5094 (class 2606 OID 30800)
-- Name: AbpUserTokens FK_AbpUserTokens_AbpUsers_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AbpUserTokens"
    ADD CONSTRAINT "FK_AbpUserTokens_AbpUsers_UserId" FOREIGN KEY ("UserId") REFERENCES public."AbpUsers"("Id") ON DELETE CASCADE;


--
-- TOC entry 5095 (class 2606 OID 30815)
-- Name: OpenIddictAuthorizations FK_OpenIddictAuthorizations_OpenIddictApplications_Application~; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictAuthorizations"
    ADD CONSTRAINT "FK_OpenIddictAuthorizations_OpenIddictApplications_Application~" FOREIGN KEY ("ApplicationId") REFERENCES public."OpenIddictApplications"("Id");


--
-- TOC entry 5097 (class 2606 OID 30846)
-- Name: OpenIddictTokens FK_OpenIddictTokens_OpenIddictApplications_ApplicationId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictTokens"
    ADD CONSTRAINT "FK_OpenIddictTokens_OpenIddictApplications_ApplicationId" FOREIGN KEY ("ApplicationId") REFERENCES public."OpenIddictApplications"("Id");


--
-- TOC entry 5098 (class 2606 OID 30851)
-- Name: OpenIddictTokens FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OpenIddictTokens"
    ADD CONSTRAINT "FK_OpenIddictTokens_OpenIddictAuthorizations_AuthorizationId" FOREIGN KEY ("AuthorizationId") REFERENCES public."OpenIddictAuthorizations"("Id");


-- Completed on 2025-12-30 23:30:53

--
-- PostgreSQL database dump complete
--

\unrestrict cbWmz1oMyc5chiP2AvKGsHfWthwUwbDG8qPMWS10SWpzg6Zj1glfoIHTVIqi7dK

