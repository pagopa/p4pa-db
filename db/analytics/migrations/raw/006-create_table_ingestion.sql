-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS raw.ingestion_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS raw.ingestion (
  ingestion_pk bigint default nextval('raw.ingestion_seq'),
  ingestion_payload jsonb NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT ingestion_pkey PRIMARY KEY (ingestion_pk)
);

CREATE INDEX IF NOT EXISTS ingestion_processed_time_idx ON raw.ingestion (processed_time);

-- final commit
COMMIT;