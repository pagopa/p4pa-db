-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.debt_position_type_org_operators_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.debt_position_type_org_operators (
    debt_position_type_org_operator_id bigint NOT NULL default nextval('debt_positions.debt_position_type_org_operators_seq'),
    operator_external_user_id varchar(256) NOT NULL,
    debt_position_type_org_id bigint NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint debt_position_type_org_operator_id_pkey PRIMARY KEY (debt_position_type_org_operator_id),
    CONSTRAINT debt_position_type_org_id_fkey FOREIGN KEY (debt_position_type_org_id) REFERENCES debt_positions.debt_position_type_org(debt_position_type_org_id)
);

CREATE INDEX IF NOT EXISTS idx_debt_position_type_org_operator_ext_user_id ON debt_positions.debt_position_type_org_operators (operator_external_user_id);
CREATE INDEX IF NOT EXISTS idx_debt_position_type_org_operators_debt_pos ON debt_positions.debt_position_type_org_operators (debt_position_type_org_id);
CREATE unique INDEX IF NOT EXISTS uq_debt_position_type_org_operators_ext_user_id_debt_pos_type_org ON debt_positions.debt_position_type_org_operators (operator_external_user_id, debt_position_type_org_id);

-- final commit
COMMIT;