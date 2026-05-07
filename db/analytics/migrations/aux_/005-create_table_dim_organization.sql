-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS aux.dim_organization (
  organization_pk text NOT NULL,
  organization_id bigint NOT NULL,
  organization_name varchar(256) NOT NULL,
  -- DWH technical fields
  hash_checksum text,
  processed_time timestamp with time zone,
  CONSTRAINT organization_pkey PRIMARY KEY (organization_pk)
);

CREATE INDEX IF NOT EXISTS dim_organization_organization_id_idx ON aux.dim_organization(organization_id);
CREATE INDEX IF NOT EXISTS dim_organization_processed_time_idx ON aux.dim_organization(processed_time);

-- final commit
COMMIT;