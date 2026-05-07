-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS migration.upload_detail_id_seq;

CREATE TABLE IF NOT EXISTS migration.upload_details (
    upload_detail_id bigint NOT NULL default nextval('migration.upload_detail_id_seq'),
    upload_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    ingestion_flow_file_id bigint NOT NULL,
    ingestion_flow_file_type text NOT NULL,
    file_path_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_size bigint NOT NULL,
    status character varying(50) NOT NULL,
    error_description text COLLATE pg_catalog."default",
    discard_file_name text COLLATE pg_catalog."default",
    num_total_rows int,
    num_correctly_imported_rows int,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT upload_details_pkey PRIMARY KEY (upload_detail_id),
    CONSTRAINT upload_id_fkey FOREIGN KEY (upload_id) REFERENCES migration.uploads(upload_id)
);

CREATE INDEX IF NOT EXISTS idx_upload_details_upload_id
    ON migration.upload_details USING btree (upload_id);

-- final commit
COMMIT;

