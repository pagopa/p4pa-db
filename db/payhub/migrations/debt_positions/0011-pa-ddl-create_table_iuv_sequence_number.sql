-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.iuv_sequence_number_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.iuv_sequence_number (
    id bigint NOT NULL default nextval('debt_positions.iuv_sequence_number_seq'),
    organization_id bigint NOT NULL,
    sequence_number bigint NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint iuv_sequence_number_pkey PRIMARY KEY (id),
    CONSTRAINT organization_id_ukey UNIQUE (organization_id)
);

CREATE INDEX IF NOT EXISTS idx_iuv_sequence_number_org_id ON debt_positions.iuv_sequence_number (organization_id);

-- final commit
COMMIT;