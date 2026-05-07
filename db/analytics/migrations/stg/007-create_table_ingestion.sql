-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS stg.ingestion (
    ingestion_pk text NOT NULL,
    event_id text NOT NULL,
    trace_id varchar(255),
    event_type varchar(255) NOT NULL,
    event_date date NOT NULL,
    organization_id bigint NOT NULL,
    ingestion_flow_file_id bigint NOT NULL,
    total_rows bigint NOT NULL,
    processed_rows bigint NOT NULL,
    status varchar(256) NOT NULL,
    file_size bigint NOT NULL,
    ingestion_flow_file_type varchar(255) NOT NULL,
    operator_external_user_id varchar(255) NOT NULL,
    event_description text NOT NULL,
    -- DWH technical fields
    processed_time timestamp with time zone,
    CONSTRAINT ingestion_pkey PRIMARY KEY (ingestion_pk)
);

CREATE INDEX IF NOT EXISTS ingestion_processed_time_idx ON stg.ingestion (processed_time);

-- final commit
COMMIT;