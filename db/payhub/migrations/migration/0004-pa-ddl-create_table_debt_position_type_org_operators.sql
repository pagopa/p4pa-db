-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS migration.debt_position_type_org_operator_id_seq;

CREATE TABLE IF NOT EXISTS migration.debt_position_type_org_operators (
    debt_position_type_org_operator_id bigint NOT NULL default nextval('migration.debt_position_type_org_operator_id_seq'),
    organization_id bigint NOT NULL,
    cf_operator_hash bytea NOT NULL,
    debt_position_type_org_id bigint NOT NULL,
    debt_position_type_org_code varchar(255) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT debt_position_type_org_operators_pkey PRIMARY KEY (debt_position_type_org_operator_id)
);

-- final commit
COMMIT;

