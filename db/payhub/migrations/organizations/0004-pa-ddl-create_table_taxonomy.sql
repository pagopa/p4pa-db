-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS organizations.taxonomy_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS organizations.taxonomy (
  taxonomy_id bigint NOT NULL default nextval('organizations.taxonomy_seq'),
  organization_type varchar(35) NOT NULL,
  organization_type_description text NOT NULL,
  macro_area_code varchar(2) NOT NULL,
  macro_area_name text NOT NULL,
  macro_area_description text NOT NULL,
  service_type_code varchar(35) NOT NULL,
  service_type text NOT NULL,
  service_type_description text NOT NULL,
  collection_reason varchar(35) NOT NULL,
  start_date_validity timestamp with time zone,
  end_date_of_validity timestamp with time zone,
  taxonomy_code varchar(35) NOT NULL,
  creation_date timestamp with time zone NOT NULL default now(),
  update_date timestamp with time zone NOT NULL default now(),
  update_operator_external_id text NOT NULL,
  update_trace_id text NOT NULL default '-',
  CONSTRAINT taxonomy_pkey PRIMARY KEY (taxonomy_id)
);

CREATE INDEX IF NOT EXISTS organization_type
    ON organizations.taxonomy USING btree
    (organization_type);

CREATE INDEX IF NOT EXISTS organization_type_macro_area_code
    ON organizations.taxonomy USING btree
    (organization_type, macro_area_code);

-- final commit
COMMIT;