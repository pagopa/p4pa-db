-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS classification.payment_notification
(
    payment_notification_id character varying(255)  NOT NULL,
    organization_id bigint not null,
    ingestion_flow_file_id bigint not null,
    iud varchar(35) not null,
    iuv varchar(35) not null,
    payment_execution_date date not null,
    payment_type varchar(32) not null,
    amount_paid_cents bigint not null,
    pa_commission_cents bigint,
    remittance_information text not null,
    transfer_category text not null,
    debt_position_type_org_code varchar(256) not null,
    balance text,
    personal_data_id numeric,
    remittance_information_hash bytea,
    debtor_fiscal_code_hash bytea,
    creation_date timestamp with time zone not null default now(),
    update_date timestamp with time zone not null default now(),
    update_operator_external_id text not null,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT payment_notification_pkey PRIMARY KEY (payment_notification_id),
    CONSTRAINT payments_notification_org_iud_uk UNIQUE (organization_id, iud)
);

CREATE INDEX IF NOT EXISTS idx_payment_notification_ingestion_flow_file_id ON classification.payment_notification (ingestion_flow_file_id);

-- final commit
COMMIT;