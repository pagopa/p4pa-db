-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE TABLE IF NOT EXISTS debt_positions.debt_position_type_org_balance_cost (
    debt_position_type_org_id bigint NOT NULL,
    type varchar(256) NOT NULL,
    operating_year varchar(4) NOT NULL,
    office_code varchar(64),
    office_description varchar(512),
    section_code varchar(64) NOT NULL,
    section_description varchar(512),
    assessment_code varchar(64),
    assessment_description varchar(512),
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT debt_position_type_org_balance_cost_pkey PRIMARY KEY (debt_position_type_org_id, type, operating_year),
    CONSTRAINT debt_position_type_org_balance_cost_dptoid_fkey FOREIGN KEY (debt_position_type_org_id) REFERENCES debt_positions.debt_position_type_org(debt_position_type_org_id)
);

CREATE INDEX IF NOT EXISTS idx_debt_position_type_org_balance_cost_dptoid ON debt_positions.debt_position_type_org_balance_cost (debt_position_type_org_id);

-- final commit
COMMIT;