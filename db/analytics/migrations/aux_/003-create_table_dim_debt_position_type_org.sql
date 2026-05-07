-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS aux.dim_debt_position_type_org (
  debt_position_type_org_pk text NOT NULL,
  debt_position_type_org_id bigint NOT NULL,
  debt_position_type_id bigint NOT NULL,
  organization_id bigint NOT NULL,
  code varchar(256),
  description text NOT NULL,
  flag_spontaneous boolean NOT NULL default false,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT debt_position_type_org_pkey PRIMARY KEY (debt_position_type_org_pk),
  CONSTRAINT debt_position_type_org_id_uk UNIQUE (debt_position_type_org_id)
);

CREATE INDEX IF NOT EXISTS dim_debt_position_type_org_processed_time_idx ON aux.dim_debt_position_type_org (processed_time);


-- final commit
COMMIT;