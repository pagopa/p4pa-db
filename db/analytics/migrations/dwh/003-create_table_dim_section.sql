-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS dwh.dim_section (
  section_pk text NOT NULL,
  section_code varchar(64),
  debt_position_type_org_id bigint NOT NULL,
  operating_year int,
  section_description varchar(512),
  -- DWH technical fields
  processed_time timestamp with time zone,
  hash_checksum text,
  CONSTRAINT section_pkey PRIMARY KEY (section_pk)
);

CREATE INDEX IF NOT EXISTS dim_section_section_code_debt_position_type_org_id_operating_year_idx ON dwh.dim_section(section_code, debt_position_type_org_id, operating_year);
CREATE INDEX IF NOT EXISTS dim_section_processed_time_idx ON dwh.dim_section(processed_time);

-- final commit
COMMIT;