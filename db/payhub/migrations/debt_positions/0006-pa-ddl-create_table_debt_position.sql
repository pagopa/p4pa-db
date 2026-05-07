-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.debt_position_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.debt_position (
    debt_position_id bigint NOT NULL default nextval('debt_positions.debt_position_seq'),
    iupd_org varchar(50) NOT NULL,
    description text,
    status varchar(256) NOT NULL,
    organization_id bigint NOT NULL,
    debt_position_type_org_id bigint NOT NULL,
    validity_date date,
    debt_position_origin varchar(256) NOT NULL,
    multi_debtor bool NOT NULL default false,
    flag_pu_pago_pa_payment bool NOT NULL default false,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint debt_position_id_pkey PRIMARY KEY (debt_position_id),
    CONSTRAINT debt_position_type_org_id_fkey FOREIGN KEY (debt_position_type_org_id) REFERENCES debt_positions.debt_position_type_org(debt_position_type_org_id)
);

CREATE INDEX IF NOT EXISTS idx_debt_position_org_id ON debt_positions.debt_position (organization_id);
CREATE INDEX IF NOT EXISTS idx_debt_position_status ON debt_positions.debt_position (status);
CREATE INDEX IF NOT EXISTS idx_debt_position_debt_type_org_id ON debt_positions.debt_position (debt_position_type_org_id);
CREATE INDEX IF NOT EXISTS idx_debt_position_iupd_org_id ON debt_positions.debt_position (iupd_org, organization_id);

-- final commit
COMMIT;