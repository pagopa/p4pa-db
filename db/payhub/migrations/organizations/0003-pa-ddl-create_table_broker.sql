-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS organizations.broker_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;
    
CREATE TABLE IF NOT EXISTS organizations.broker (
	broker_id bigint NOT NULL default nextval('organizations.broker_seq'),
	organization_id bigint NOT NULL,
	broker_fiscal_code varchar(11) NOT NULL,
	broker_name varchar(256) NOT NULL,
	default_station_id varchar(256),
	sync_payments_reporting_key bytea,
	sync_key bytea,
	gpd_key bytea,
	aca_key bytea,
    generate_notice_key bytea,
	flag_delegate bool NOT NULL default false,
	flag_payments_reporting bool NOT NULL default true,
	external_id varchar(100) NOT NULL,
	creation_date timestamp with time zone NOT NULL default now(),
	update_date timestamp with time zone NOT NULL default now(),
	update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
	constraint broker_pkey PRIMARY KEY (broker_id),
	CONSTRAINT broker_fiscal_code_ukey UNIQUE (broker_fiscal_code),
	CONSTRAINT default_station_id_ukey UNIQUE (default_station_id),
	CONSTRAINT organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
	CONSTRAINT external_id_ukey UNIQUE (external_id)
);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_name = 'organization_broker_id_fkey'
          AND table_name = 'organization'
          AND constraint_schema = 'organizations'
    ) THEN
        ALTER TABLE organizations.organization
        ADD CONSTRAINT organization_broker_id_fkey
        FOREIGN KEY (broker_id) REFERENCES organizations.broker(broker_id);
    END IF;
END $$;

-- final commit
COMMIT;