-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS process_executions.export_file_id_seq;

CREATE TABLE IF NOT EXISTS process_executions.export_file
(
    export_file_id bigint NOT NULL DEFAULT nextval('process_executions.export_file_id_seq'::regclass),
    organization_id bigint NOT NULL,
    operator_external_id text NOT NULL,
    file_path_name text,
    file_name character varying(256),
    file_size bigint,
    export_file_type text NOT NULL,
    file_version text NOT NULL,
    filter_fields text,
    status character varying(50) NOT NULL,
    error_description text,
    num_total_rows integer,
    expiration_date timestamp with time zone,
    creation_date timestamp with time zone NOT NULL DEFAULT now(),
    update_date timestamp with time zone NOT NULL DEFAULT now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT export_file_pkey PRIMARY KEY (export_file_id)
);


CREATE INDEX IF NOT EXISTS export_file_status_idx
    ON process_executions.export_file USING btree
    (organization_id ASC NULLS LAST, export_file_type ASC NULLS LAST, status ASC NULLS LAST);

-- final commit
COMMIT;