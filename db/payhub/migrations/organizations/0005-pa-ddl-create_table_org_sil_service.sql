-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS organizations.org_sil_service_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS organizations.org_sil_service (
	org_sil_service_id bigint NOT NULL default nextval('organizations.org_sil_service_seq'),
	organization_id bigint NOT NULL,
	application_name text NOT NULL,
	service_url text NOT NULL,
	service_type text NOT NULL,
	flag_legacy bool NOT NULL default false,
	auth_config jsonb,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
	constraint org_sil_service_pkey PRIMARY KEY (org_sil_service_id),
	CONSTRAINT org_sil_service_org_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
	CONSTRAINT application_name_ukey UNIQUE (organization_id, application_name)
);

-- final commit
COMMIT;