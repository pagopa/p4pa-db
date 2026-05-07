-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS classification.payments_reporting (
    payments_reporting_id character varying(255)  NOT NULL,
    ingestion_flow_file_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    iuv varchar(35) NOT NULL,
    iur varchar(35) NOT NULL,
    transfer_index int NOT NULL,
    psp_identifier varchar(35) NOT NULL,
    iuf varchar(35) NOT NULL,
    flow_date_time timestamp with time zone NOT NULL,
    regulation_unique_identifier varchar(35) NOT NULL,
    regulation_date date NOT NULL,
    sender_psp_type char(1) NOT NULL,
    sender_psp_code varchar(35) NOT NULL,
    sender_psp_name varchar(70) NULL,
    receiver_organization_type char(1) NULL,
    receiver_organization_code varchar(35) NULL,
    receiver_organization_name varchar(70) NULL,
    total_payments int NOT NULL,
    total_amount_cents bigint NOT NULL,
    amount_paid_cents bigint NOT NULL,
    payment_outcome_code varchar(1) NOT NULL,
    pay_date date NOT NULL,
    acquiring_date date NOT NULL,
    bic_code_pouring_bank varchar(35),
    revision int NOT NULL default 0,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT payments_reporting_pkey PRIMARY KEY (payments_reporting_id),
    CONSTRAINT payments_reporting_org_iuv_iur_idsp_uk UNIQUE (organization_id, iuv, iuf, transfer_index)
);


CREATE INDEX IF NOT EXISTS payments_reporting_ingestion_flow_file_id_idx
    ON classification.payments_reporting USING btree
    (ingestion_flow_file_id)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS payments_reporting_organization_id_iuv_idx
    ON classification.payments_reporting USING btree
    (organization_id,iuv)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS payments_reporting_organization_id_iuf_idx
    ON classification.payments_reporting USING btree
    (organization_id,iuf);


-- final commit
COMMIT;

