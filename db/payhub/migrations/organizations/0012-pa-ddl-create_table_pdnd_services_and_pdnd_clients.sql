-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS organizations.pdnd_services (
	purpose_id varchar(255) NOT NULL,
	service_name varchar(255) NOT NULL,
    service_type varchar(255) NOT NULL,
    client_id varchar(255) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
	constraint pdnd_services_pk PRIMARY KEY (purpose_id),
    CONSTRAINT client_id_ukey UNIQUE (client_id)
);

CREATE TABLE IF NOT EXISTS organizations.pdnd_clients (
    client_id varchar(255) NOT NULL,
    organization_id bigint NOT NULL,
    sub_unit_code varchar(60) NULL,
    client_name varchar(255) NOT NULL,
    kid varchar(255) NOT NULL,
    private_key_cipher bytea NOT_NULL,
    public_key varchar(255) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint pdnd_clients_pk PRIMARY KEY (client_id),
    CONSTRAINT pdnd_clients_pdnd_services_fkey FOREIGN KEY (client_id) REFERENCES organizations.pdnd_services(client_id),
    CONSTRAINT pdnd_clients_org_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
    CONSTRAINT pdnd_clients_org_sub_unit_fkey FOREIGN KEY (organization_id, sub_unit_code) REFERENCES organizations.org_sub_unit(organization_id, sub_unit_code)
);

-- final commit
COMMIT;