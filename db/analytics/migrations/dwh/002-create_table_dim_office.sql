-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS dwh.dim_office (
  office_pk text NOT NULL,
  office_code varchar(64),
  debt_position_type_org_id bigint NOT NULL,
  operating_year int,
  office_description varchar(512),
  -- DWH technical fields
  processed_time timestamp with time zone,
  hash_checksum text,
  CONSTRAINT office_pkey PRIMARY KEY (office_pk)
);

CREATE INDEX IF NOT EXISTS dim_office_office_code_debt_position_type_org_id_operating_year_idx ON dwh.dim_office(office_code, debt_position_type_org_id, operating_year);
CREATE INDEX IF NOT EXISTS dim_office_processed_time_idx ON dwh.dim_office(processed_time);

-- final commit
COMMIT;