-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS process_executions.ingestion_flow_file_id_seq;

CREATE TABLE IF NOT EXISTS process_executions.ingestion_flow_file
(
    ingestion_flow_file_id bigint NOT NULL DEFAULT nextval('process_executions.ingestion_flow_file_id_seq'),
    organization_id bigint NOT NULL,
    operator_external_id text NOT NULL,
    file_path_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_name character varying(256) COLLATE pg_catalog."default" NOT NULL,
    file_size bigint NOT NULL,
    ingestion_flow_file_type text NOT NULL,
    status character varying(50) NOT NULL,
    error_description text COLLATE pg_catalog."default",
    discard_file_name character varying(256) COLLATE pg_catalog."default",
    num_total_rows int,
    num_correctly_imported_rows int,
    pdf_generated int,
    pdf_generated_id text,
    psp_identifier character varying(35) COLLATE pg_catalog."default",
    flow_date_time timestamp with time zone,
    file_origin character varying(10) COLLATE pg_catalog."default" NOT NULL,
    file_version text,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT ingestion_flow_file_pkey PRIMARY KEY (ingestion_flow_file_id)
);


CREATE INDEX IF NOT EXISTS ingestion_flow_file_type_status_idx
    ON process_executions.ingestion_flow_file USING btree
    (organization_id, ingestion_flow_file_type, status );

-- final commit
COMMIT;