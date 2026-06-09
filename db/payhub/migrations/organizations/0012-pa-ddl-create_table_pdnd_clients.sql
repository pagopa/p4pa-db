-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE TABLE IF NOT EXISTS organizations.pdnd_clients (
    client_id varchar(255) NOT NULL,
    organization_id bigint NOT NULL,
    sub_unit_code varchar(60) NULL,
    client_name varchar(255) NOT NULL,
    kid varchar(255) NOT NULL,
    private_key_cipher bytea NOT NULL,
    public_key varchar(255) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT pdnd_clients_pk PRIMARY KEY (client_id),
    CONSTRAINT pdnd_clients_org_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations.organization(organization_id),
    CONSTRAINT pdnd_clients_org_sub_unit_fkey FOREIGN KEY (organization_id, sub_unit_code) REFERENCES organizations.org_sub_unit(organization_id, sub_unit_code)
);

-- final commit
COMMIT;