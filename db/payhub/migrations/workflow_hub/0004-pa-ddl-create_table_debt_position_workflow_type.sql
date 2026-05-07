-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS workflow_hub.debt_position_workflow_type
(
    debt_position_id bigint NOT NULL,
    workflow_type_org_id bigint,
    execution_config bytea NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT debt_position_workflow_type_pkey PRIMARY KEY (debt_position_id),
	CONSTRAINT workflow_type_org_id_fkey FOREIGN KEY (workflow_type_org_id) REFERENCES workflow_hub.workflow_type_org(debt_position_type_org_id)
);

-- final commit
COMMIT;