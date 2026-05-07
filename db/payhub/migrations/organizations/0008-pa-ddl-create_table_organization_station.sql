-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE SEQUENCE IF NOT EXISTS organizations.organization_station_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS organizations.organization_station (
    organization_station_id bigint NOT NULL default nextval('organizations.organization_station_seq'),
    organization_id bigint NOT NULL,
    station_id varchar(256) NOT NULL,
    segregation_code varchar(2),
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT organization_station_pkey PRIMARY KEY (organization_station_id),
    CONSTRAINT organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
    CONSTRAINT station_id_fkey FOREIGN KEY (station_id) REFERENCES organizations.station(station_id),
    CONSTRAINT organization_id_station_id_ukey UNIQUE (organization_id, station_id)
    );

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_name = 'default_organization_station_id_fkey'
            AND table_name = 'organization'
            AND constraint_schema = 'organizations'
    ) THEN
        ALTER TABLE organizations.organization
        ADD CONSTRAINT default_organization_station_id_fkey
        FOREIGN KEY (default_organization_station_id) REFERENCES organizations.organization_station(organization_station_id);
    END IF;
END $$;

-- final commit
COMMIT;