-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.installment_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.installment (
    installment_id bigint NOT NULL default nextval('debt_positions.installment_seq'),
    payment_option_id bigint NOT NULL,
    status varchar(256) NOT NULL,
    generate_notice bool NOT NULL default false,
    iupd_pagopa text,
    iud varchar(35) NOT NULL,
    iuv varchar(35),
    iur varchar(256),
    iuf varchar(256),
    nav varchar(35),
    iun varchar(35),
    due_date date,
    switch_to_expired bool NOT NULL default false,
    amount_cents bigint NOT NULL,
    remittance_information text NOT NULL,
    balance text,
    legacy_payment_metadata varchar(256),
    personal_data_id bigint NOT NULL,
    debtor_entity_type character(1) NOT NULL,
    debtor_fiscal_code_hash bytea NOT NULL,
    sync_status_from varchar(256),
    sync_status_to varchar(256),
    sync_error text,
    notification_date timestamp with time zone,
    ingestion_flow_file_id bigint,
    ingestion_flow_file_line_number bigint,
    ingestion_flow_file_action text,
    receipt_id bigint,
    notification_fee_cents bigint,
    source_flow_name varchar(256) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint installment_id_pkey PRIMARY KEY (installment_id),
    CONSTRAINT installment_payment_option_id_fkey FOREIGN KEY (payment_option_id) REFERENCES debt_positions.payment_option(payment_option_id),
    CONSTRAINT installment_receipt_id_fkey FOREIGN KEY (receipt_id) REFERENCES debt_positions.receipt(receipt_id)
);

CREATE INDEX IF NOT EXISTS idx_installment_payment_option_id ON debt_positions.installment (payment_option_id);
CREATE INDEX IF NOT EXISTS idx_installment_ingestion_flow_file_id ON debt_positions.installment (ingestion_flow_file_id);
CREATE INDEX IF NOT EXISTS idx_installment_receipt_id ON debt_positions.installment (receipt_id);
CREATE INDEX IF NOT EXISTS idx_installment_status ON debt_positions.installment (status);
CREATE INDEX IF NOT EXISTS idx_installment_iud ON debt_positions.installment (iud);
CREATE INDEX IF NOT EXISTS idx_installment_iuv ON debt_positions.installment (iuv);
CREATE INDEX IF NOT EXISTS idx_installment_nav ON debt_positions.installment (nav);
CREATE INDEX IF NOT EXISTS idx_installment_iun ON debt_positions.installment (iun);

-- final commit
COMMIT;