-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE SEQUENCE IF NOT EXISTS raw.auth_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS raw.auth (
  auth_pk bigint default nextval('raw.auth_seq'),
  auth_payload text NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT auth_pkey PRIMARY KEY (auth_pk)
);

CREATE INDEX IF NOT EXISTS auth_processed_time_idx ON raw.auth (processed_time);

-- final commit
COMMIT;