-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS migration.upload_id_seq;

CREATE TABLE IF NOT EXISTS migration.uploads (
    upload_id bigint NOT NULL default nextval('migration.upload_id_seq'),
    organization_id bigint NOT NULL,
    file_path_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_size bigint NOT NULL,
    file_type text NOT NULL,
    status character varying(50) NOT NULL,
    error_description text COLLATE pg_catalog."default",
    num_total_files int,
    num_correctly_processed_files int,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT uploads_pkey PRIMARY KEY (upload_id)
);

CREATE INDEX IF NOT EXISTS idx_uploads_organization_id_status
    ON migration.uploads USING btree
    (organization_id, status );

-- final commit
COMMIT;

