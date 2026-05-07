-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS workflow_hub.workflow_type_org
(
    debt_position_type_org_id bigint NOT NULL,
    workflow_type_id bigint NOT NULL,
    default_execution_config jsonb NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT workflow_type_org_pkey PRIMARY KEY (debt_position_type_org_id),
	CONSTRAINT workflow_type_id_fkey FOREIGN KEY (workflow_type_id) REFERENCES workflow_hub.workflow_type(workflow_type_id)
);

-- final commit
COMMIT;