-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS organizations.broker_configuration (
    broker_id bigint NOT NULL,
    personalisation_fe jsonb,
    arpu_config jsonb,
    mail_sender_address varchar(256) NOT NULL,
    receipt_footer text,
    legal_facts_expiration_days bigint,
    send_files_expiration_days bigint,
    email_server_config bytea,
    favicon text,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT broker_configuration_pkey PRIMARY KEY (broker_id),
    CONSTRAINT broker_id_fkey FOREIGN KEY (broker_id) REFERENCES organizations.broker(broker_id)
);

-- final commit
COMMIT;