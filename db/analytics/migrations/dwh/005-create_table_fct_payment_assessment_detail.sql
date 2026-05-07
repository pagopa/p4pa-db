-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS dwh.fct_payment_assessment_detail (
  assessment_detail_pk text NOT NULL,
  assessment_detail_id bigint NOT NULL,
  assessment_id bigint NOT NULL,
  organization_id bigint NOT NULL,
  -- foreign keys
  debt_position_type_org_pk text NOT NULL,
  office_pk text NOT NULL,
  section_pk text NOT NULL,
  assessment_pk text NOT NULL,
  payment_date_pk text,
  date_receipt_pk text,
  date_reporting_pk text,
  date_treasury_pk text,
  -- measures and attributes
  iuv varchar(256) NOT NULL,
  iud varchar(35) NOT NULL,
  iur text,
  debtor_fiscal_code_hash varchar(100),
  assessment_name varchar(256),
  amount_cents bigint,
  amount_submitted boolean,
  receipt_id bigint,
  classification_label varchar(50),
  -- DWH technical fields
  processed_time timestamp with time zone,
  is_active boolean,

  CONSTRAINT assessment_detail_uk UNIQUE (assessment_detail_id),

  CONSTRAINT assessment_detail_pk PRIMARY KEY (assessment_detail_pk),
  CONSTRAINT fk_fct_debt_position_type_org FOREIGN KEY (debt_position_type_org_pk) REFERENCES aux.dim_debt_position_type_org(debt_position_type_org_pk),
  CONSTRAINT fk_fct_office FOREIGN KEY (office_pk) REFERENCES dwh.dim_office(office_pk),
  CONSTRAINT fk_fct_section FOREIGN KEY (section_pk) REFERENCES dwh.dim_section(section_pk),
  CONSTRAINT fk_fct_assessment FOREIGN KEY (assessment_pk) REFERENCES dwh.dim_assessment(assessment_pk),
  CONSTRAINT fk_fct_payment_date FOREIGN KEY (payment_date_pk) REFERENCES aux.dim_date(date_pk),
  CONSTRAINT fk_fct_date_receipt FOREIGN KEY (date_receipt_pk) REFERENCES aux.dim_date(date_pk),
  CONSTRAINT fk_fct_date_reporting FOREIGN KEY (date_reporting_pk) REFERENCES aux.dim_date(date_pk),
  CONSTRAINT fk_fct_date_treasury FOREIGN KEY (date_treasury_pk) REFERENCES aux.dim_date(date_pk)
);

-- final commit
COMMIT;