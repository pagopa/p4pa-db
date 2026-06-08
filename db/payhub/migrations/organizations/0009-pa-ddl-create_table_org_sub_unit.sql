-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS organizations.org_sub_unit (
	organization_id bigint NOT NULL,
	sub_unit_code varchar(60) NOT NULL,
    sub_unit_type varchar(60) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
	constraint org_sub_unit_pkey PRIMARY KEY (organization_id, sub_unit_code),
	CONSTRAINT org_sub_unit_org_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id)
);

-- final commit
COMMIT;