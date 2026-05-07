-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.transfer_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.transfer (
    transfer_id bigint NOT NULL default nextval('debt_positions.transfer_seq'),
    installment_id bigint NOT NULL,
    org_fiscal_code varchar(11) NOT NULL,
    org_name varchar(256),
    amount_cents bigint NOT NULL,
    remittance_information text NOT NULL,
    stamp_type text,
    stamp_hash_document text,
    stamp_provincial_residence text,
    iban varchar(35),
    postal_iban varchar(35),
    category varchar(35) NOT NULL,
    transfer_index int NOT NULL default 1,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    mbd_attachment text,
    flag_owner bool,
    constraint transfer_id_pkey PRIMARY KEY (transfer_id),
    CONSTRAINT transfer_installment_fkey FOREIGN KEY (installment_id) REFERENCES debt_positions.installment(installment_id)
);

CREATE INDEX IF NOT EXISTS idx_transfer_installment_id ON debt_positions.transfer (installment_id);

-- final commit
COMMIT;