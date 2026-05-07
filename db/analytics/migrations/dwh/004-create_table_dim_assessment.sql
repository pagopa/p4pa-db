-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS dwh.dim_assessment (
  assessment_pk text NOT NULL,
  assessment_code varchar(64),
  debt_position_type_org_id bigint NOT NULL,
  operating_year int,
  assessment_description varchar(512),
  -- DWH technical fields
  processed_time timestamp with time zone,
  hash_checksum text,
  CONSTRAINT assessment_pkey PRIMARY KEY (assessment_pk)
);

CREATE INDEX IF NOT EXISTS dim_assessment_assessment_code_debt_position_type_org_id_operating_year_idx ON dwh.dim_assessment(assessment_code, debt_position_type_org_id, operating_year);
CREATE INDEX IF NOT EXISTS dim_assessment_processed_time_idx ON dwh.dim_assessment(processed_time);


-- final commit
COMMIT;