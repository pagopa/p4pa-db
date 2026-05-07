-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.spontaneous_form_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.spontaneous_form (
    spontaneous_form_id bigint NOT NULL default nextval('debt_positions.spontaneous_form_seq'),
    organization_id bigint NOT NULL,
    code varchar(255) NOT NULL,
    structure jsonb NOT NULL,
    dictionary jsonb,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint spontaneous_form_id_pkey PRIMARY KEY (spontaneous_form_id)
);

CREATE unique INDEX IF NOT EXISTS idx_spontaneous_form_organization_id_code ON debt_positions.spontaneous_form (organization_id, code);

-- final commit
COMMIT;