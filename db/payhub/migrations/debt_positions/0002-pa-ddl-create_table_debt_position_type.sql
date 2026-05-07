-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.debt_position_type_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.debt_position_type (
    debt_position_type_id bigint NOT NULL default nextval('debt_positions.debt_position_type_seq'),
    broker_id bigint NOT NULL,
    code varchar(256) NOT NULL,
    description text NOT NULL,
    org_type varchar(4) NOT NULL,
    macro_area varchar(4) NOT NULL,
    service_type varchar(4) NOT NULL,
    collecting_reason varchar(4) NOT NULL,
    taxonomy_code varchar(256) NOT NULL,
    flag_anonymous_fiscal_code bool NOT NULL default false,
    flag_mandatory_due_date bool NOT NULL default false,
    flag_notify_io bool NOT NULL default false,
    io_template_subject text,
    io_template_message text,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint debt_position_type_id_pkey PRIMARY KEY (debt_position_type_id)
);

CREATE INDEX IF NOT EXISTS idx_debt_position_type_broker ON debt_positions.debt_position_type (broker_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_debt_position_type_broker_code ON debt_positions.debt_position_type (broker_id, code);

INSERT INTO debt_positions.debt_position_type(debt_position_type_id, broker_id,      code, description, org_type, macro_area, service_type, collecting_reason, taxonomy_code, update_operator_external_id)
SELECT                                                           -1,        -1, 'UNKNOWN',  'UNKNNOWN',       '',         '',           '',                '',            '',                    'SYSTEM'
WHERE NOT EXISTS(SELECT * FROM debt_positions.debt_position_type WHERE debt_position_type_id=-1);

INSERT INTO debt_positions.debt_position_type(debt_position_type_id, broker_id,    code, description, org_type, macro_area, service_type, collecting_reason, taxonomy_code, update_operator_external_id)
SELECT                                                           -2,        -2, 'MIXED',     'MIXED',       '',         '',           '',                '',            '',                    'SYSTEM'
WHERE NOT EXISTS(SELECT * FROM debt_positions.debt_position_type WHERE debt_position_type_id=-2);

-- final commit
COMMIT;