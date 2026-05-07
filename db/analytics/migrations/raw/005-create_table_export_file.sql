-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS raw.export_file_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS raw.export_file (
  export_file_pk bigint default nextval('raw.export_file_seq'),
  export_file_payload jsonb NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT export_file_pkey PRIMARY KEY (export_file_pk)
);

CREATE INDEX IF NOT EXISTS export_file_processed_time_idx ON raw.export_file (processed_time);

-- final commit
COMMIT;