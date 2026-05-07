-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS stg.payment_assessment_detail (
  assessment_detail_pk text NOT NULL,
  assessment_detail_id bigint NOT NULL,
  assessment_id bigint NOT NULL,
  organization_id bigint NOT NULL,
  debt_position_type_org_code varchar(256) NOT NULL,
  debt_position_type_org_id bigint NOT NULL,
  iuv varchar(256) NOT NULL,
  iud varchar(35) NOT NULL,
  iur text NOT NULL,
  debtor_fiscal_code_hash varchar(100), --BYTEA
  payment_date_time timestamp with time zone,
  office_code varchar(64),
  office_description varchar(512),
  section_code varchar(64),
  section_description varchar(512),
  assessment_code varchar(64),
  assessment_name text NOT NULL,
  assessment_description varchar(512),
  amount_cents bigint NOT NULL,
  amount_submitted boolean NOT NULL DEFAULT true,
  receipt_id bigint,
  classification_label varchar(20),
  date_receipt date,
  date_reporting date,
  date_treasury date,
  creation_date timestamp with time zone NOT NULL default now(),
  update_date timestamp with time zone NOT NULL default now(),
  update_operator_external_id text NOT NULL,
  update_trace_id text NOT NULL default '-',
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT assessment_detail_pkey PRIMARY KEY (assessment_detail_pk),
  CONSTRAINT assessment_detail_id_uk UNIQUE (assessment_detail_id)
);

CREATE INDEX IF NOT EXISTS payment_assessment_detail_organization_id_iud_idx ON stg.payment_assessment_detail (organization_id, iud);
CREATE INDEX IF NOT EXISTS payment_assessment_detail_processed_time_idx ON stg.payment_assessment_detail (processed_time);

-- final commit
COMMIT;