-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS organizations.org_sub_unit_operators (
    org_sub_unit_operator_id bigint NOT NULL default nextval('organizations.org_sub_unit_operators_seq'),
    operator_external_user_id varchar(256) NOT NULL,
    organization_id bigint NOT NULL,
    sub_unit_code varchar(60) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint org_sub_unit_operator_pkey PRIMARY KEY (org_sub_unit_operator_id),
    constraint org_sub_unit_org_id_and_code_fkey
        FOREIGN KEY (organization_id, sub_unit_code)
        REFERENCES organizations.org_sub_unit (organization_id, sub_unit_code)
);

CREATE INDEX IF NOT EXISTS idx_org_sub_unit_operators_org_id_ext_user_id ON organizations.org_sub_unit_operators (organization_id, operator_external_user_id);
CREATE unique INDEX IF NOT EXISTS idx_org_sub_unit_operators_org_id_sub_code_ext_user_id ON organizations.org_sub_unit_operators (organization_id, sub_unit_code, operator_external_user_id);

-- final commit
COMMIT;