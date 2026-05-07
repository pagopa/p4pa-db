-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS classification.treasury
(
    treasury_id  character varying(255)  NOT NULL,
    bill_year character varying(4)  NOT NULL,
    bill_code character varying(7)  NOT NULL,
    ingestion_flow_file_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    org_bt_code character varying(10) NOT NULL default '0000000000',
    org_istat_code character varying(10) NOT NULL default '0000000000',
    iuf character varying(35) ,
    iuv character varying(35) ,
    account_code text ,
    domain_id_code character(7) ,
    transaction_type_code character(3) ,
    remittance_code text ,
    remittance_description text ,
    bill_amount_cents bigint NOT NULL,
    bill_date date NOT NULL,
    reception_date timestamp with time zone,
    document_year character(4) ,
    document_code character(7) ,
    seal_code character(6) ,
    psp_last_name text NOT NULL,
    psp_first_name character(30),
    psp_address character(50),
    psp_postal_code character(5),
    psp_city character(40),
    psp_fiscal_code character(16),
    psp_vat_number character(12),
    abi_code character(5) ,
    cab_code character(5) ,
    iban_code character varying(34) ,
    account_registry_code character(50) ,
    provisional_ae character(4) ,
    provisional_code character(6) ,
    account_type_code character(1) ,
    process_code character(10) ,
    execution_pg_code character(4) ,
    transfer_pg_code character(4) ,
    process_pg_number numeric(17,0),
    region_value_date date,
    is_regularized boolean NOT NULL DEFAULT false,
    actual_suspension_date date,
    management_provisional_code character varying(10) ,
    end_to_end_id character varying(35),
    treasury_origin character varying(255) NOT NULL,
    check_number character varying(50),
    client_reference character varying(50),
    bank_reference character varying(50),
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT treasury_id_pkey PRIMARY KEY (treasury_id),
    CONSTRAINT treasury_id_uk UNIQUE (organization_id, bill_year, bill_code, org_bt_code, org_istat_code)
);


CREATE INDEX IF NOT EXISTS treasury_organization_id_iuf_idx
    ON classification.treasury USING btree
    (organization_id, iuf);

CREATE INDEX IF NOT EXISTS treasury_ingestion_flow_file_id_idx
    ON classification.treasury USING btree
    (ingestion_flow_file_id);

CREATE INDEX IF NOT EXISTS treasury_bill_date_idx
    ON classification.treasury USING btree
    (organization_id, bill_date);

-- final commit
COMMIT;