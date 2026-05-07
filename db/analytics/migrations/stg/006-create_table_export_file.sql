-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS stg.export_file (
    export_file_pk text NOT NULL,
    event_id text NOT NULL,
    trace_id varchar(256),
    event_type varchar(256) NOT NULL,
    event_date date NOT NULL,
    organization_id bigint NOT NULL,
    export_file_id bigint NOT NULL,
    exported_rows bigint NOT NULL,
    file_size bigint NOT NULL,
    export_file_type varchar(256) NOT NULL,
    event_description text NOT NULL,
    operator_external_user_id varchar(256) NOT NULL,
    -- DWH technical fields
    processed_time timestamp with time zone,
    CONSTRAINT export_file_pkey PRIMARY KEY (export_file_pk)
);

CREATE INDEX IF NOT EXISTS export_file_processed_time_idx ON stg.export_file (processed_time);

-- final commit
COMMIT;