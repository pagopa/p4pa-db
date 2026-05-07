-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS classification.classification_id_seq;

CREATE TABLE IF NOT EXISTS classification.classification
(   classification_id bigint NOT NULL DEFAULT nextval('classification.classification_id_seq'),
    organization_id bigint NOT NULL,
    transfer_id bigint,
    payment_notification_id character varying(255),
    payments_reporting_id character varying(255) ,
    treasury_id character varying(255) ,
    iuf character varying(35),
    iud character varying(35),
    iuv character varying(35),
    iur character varying(35),
    transfer_index int,
    label character varying(100)  NOT NULL,
    last_classification_date date,
    pay_date date,
    payment_date_time timestamp with time zone,
    regulation_date date,
    bill_date date,
    region_value_date date,
    regulation_unique_identifier varchar(35),
    account_registry_code character(50),
    bill_amount_cents bigint,
    remittance_information text,
    psp_company_name text,
    psp_last_name text,
    debt_position_type_org_code varchar(256),
    debt_position_type_org_description text,
    installment_ingestion_flow_file_name text,
    receipt_org_fiscal_code text,
    receipt_payment_receipt_id text,
    receipt_payment_date_time timestamp with time zone,
    receipt_payment_request_id text,
    receipt_id_psp text,
    receipt_psp_company_name text,
    organization_entity_type text,
    organization_name text,
    receipt_personal_data_id bigint,
    receipt_payment_outcome_code text,
    receipt_payment_amount bigint,
    receipt_creditor_reference_id text,
    transfer_amount bigint,
    transfer_category text,
    receipt_creation_date timestamp with time zone,
    installment_balance text,
    provisional_ae character(4) ,
    provisional_code character(6) ,
    document_year character(4) ,
    document_code character(7) ,
    bill_year character varying(4),
    bill_code character varying(7),
    debtor_fiscal_code_hash bytea,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    debt_position_origin character varying(100),
    receipt_origin character varying(100),
	CONSTRAINT classification_pkey PRIMARY KEY (classification_id),
    CONSTRAINT classification_uk UNIQUE (organization_Id,iuf,iud,iuv,iur,transfer_Index,label)
);

CREATE INDEX IF NOT EXISTS classification_organization_id_iuv_idx ON classification.classification USING btree (organization_id, iuv);
CREATE INDEX IF NOT EXISTS classification_org_id_debt_position_type_org_code_idx ON classification.classification USING btree(organization_id, debt_position_type_org_code);

-- final commit
COMMIT;