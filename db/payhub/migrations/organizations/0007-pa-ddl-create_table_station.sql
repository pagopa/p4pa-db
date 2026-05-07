-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE TABLE IF NOT EXISTS organizations.station (
    station_id varchar(256) NOT NULL,
    broker_id bigint NOT NULL,
    pago_pa_interaction_model varchar(25) DEFAULT 'ASYNC_GPD'::character varying NOT NULL,
    broadcast_station_id varchar(256),
    enabled bool NOT NULL default true,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT station_pkey PRIMARY KEY (station_id),
    CONSTRAINT broker_id_fkey FOREIGN KEY (broker_id) REFERENCES organizations.broker(broker_id)
    );

CREATE INDEX IF NOT EXISTS idx_station_broker_id
    ON organizations.station USING btree
    (broker_id);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_name = 'default_station_id_fkey'
            AND table_name = 'broker'
            AND constraint_schema = 'organizations'
    ) THEN
        ALTER TABLE organizations.broker
        ADD CONSTRAINT default_station_id_fkey
        FOREIGN KEY (default_station_id) REFERENCES organizations.station(station_id);
    END IF;
END $$;

-- final commit
COMMIT;