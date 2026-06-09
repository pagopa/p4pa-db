-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE TABLE IF NOT EXISTS organizations.broker_keys (
    broker_key_id varchar(255) NOT NULL,
    broker_id bigint NOT NULL,
    key_type varchar(60) NOT NULL,
    key_cipher bytea NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint broker_keys_pkey PRIMARY KEY (broker_key_id),
    CONSTRAINT broker_keys_broker_id_fkey FOREIGN KEY (broker_id) REFERENCES organizations.broker(broker_id)
);

-- final commit
COMMIT;