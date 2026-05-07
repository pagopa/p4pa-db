-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.receipt_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.receipt (
    receipt_id bigint NOT NULL default nextval('debt_positions.receipt_seq'),
    ingestion_flow_file_id bigint,
    receipt_origin text NOT NULL,
    rt_file_path text,
    payment_receipt_id varchar(35) NOT NULL,
    notice_number varchar(18) NOT NULL,
    payment_note text,
    org_fiscal_code varchar(19) NOT NULL,
    outcome varchar(2) NOT NULL,
    creditor_reference_id varchar(35) NOT NULL,
    payment_amount_cents bigint NOT NULL,
    description text NOT NULL,
    company_name text NOT NULL,
    office_name text NULL,
    id_psp varchar(35) NOT NULL,
    psp_fiscal_code text,
    psp_partita_iva text,
    psp_company_name text NOT NULL,
    id_channel text,
    channel_description text,
    payment_method text,
    fee_cents bigint,
    payment_date_time timestamp with time zone,
    application_date timestamp with time zone,
    transfer_date timestamp with time zone,
    standin bool NOT NULL default false,
    debtor_entity_type character(1) NOT NULL,
    personal_data_id bigint NOT NULL,
    debtor_fiscal_code_hash bytea NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint receipt_id_pkey PRIMARY KEY (receipt_id)
);

CREATE UNIQUE INDEX IF NOT EXISTS receipt_payment_receipt_id_idx
    ON debt_positions.receipt (payment_receipt_id);

-- final commit
COMMIT;