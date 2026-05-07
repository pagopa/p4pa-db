-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS stg.payment_assessment_detail_tmp (
  assessment_detail_pk bigint NOT NULL,
  assessment_detail_id bigint NOT NULL,
  assessment_id bigint NOT NULL,
  organization_id bigint NOT NULL,
  debt_position_type_org_code varchar(256) NOT NULL,
  debt_position_type_org_id bigint NOT NULL,
  iuv varchar(256) NOT NULL,
  iud varchar(35) NOT NULL,
  iur text NOT NULL,
  debtor_fiscal_code_hash varchar(100), --BYTEA
  payment_date_time timestamp,
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
  processed_time timestamp with time zone
);

-- final commit
COMMIT;