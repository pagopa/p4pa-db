-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS organizations.organization_keys (
    organization_key_id varchar(255) NOT NULL,
    organization_id bigint NOT NULL,
    sub_unit_code varchar(60) NULL,
    key_type varchar(60) NOT NULL,
	key_cipher bytea NOT NULL,
	creation_date timestamp with time zone NOT NULL default now(),
	update_date timestamp with time zone NOT NULL default now(),
	update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
    constraint organization_keys_pkey PRIMARY KEY (organization_key_id),
    CONSTRAINT organization_keys_org_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
    CONSTRAINT organization_keys_org_sub_unit_fkey FOREIGN KEY (organization_id, sub_unit_code) REFERENCES organizations.org_sub_unit(organization_id, sub_unit_code)
);

-- final commit
COMMIT;