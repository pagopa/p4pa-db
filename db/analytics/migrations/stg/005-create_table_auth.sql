-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS stg.auth (
  auth_pk text NOT NULL,
  version varchar(10) NOT NULL,
  vendor varchar(255) NOT NULL,
  product varchar(255) NOT NULL,
  event_type varchar(255),
  description text,
  receipt_time timestamp,
  trace_id varchar(255),
  source_user_name varchar(255),
  grant_type varchar(255),
  organization_id bigInt,
  organization_name varchar(255),
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT auth_pkey PRIMARY KEY (auth_pk)
);

CREATE INDEX IF NOT EXISTS auth_processed_time_idx ON stg.auth (processed_time);

-- final commit
COMMIT;