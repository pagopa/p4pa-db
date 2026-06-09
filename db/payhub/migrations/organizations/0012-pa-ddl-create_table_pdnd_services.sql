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
    CONSTRAINT pdnd_services_pk PRIMARY KEY (purpose_id),
    CONSTRAINT pdnd_services_ukey UNIQUE (service_type, client_id),
    CONSTRAINT pdnd_services_pdnd_clients_fkey FOREIGN KEY (client_id) REFERENCES organizations.pdnd_clients(client_id)
);

-- final commit
COMMIT;