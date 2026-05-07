-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS raw.debt_position_type_orgs_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS raw.debt_position_type_orgs (
  debt_position_type_org_pk bigint default nextval('raw.debt_position_type_orgs_seq'),
  debt_position_type_org_id bigint NOT NULL,
  debt_position_type_id bigint NOT NULL,
  organization_id bigint NOT NULL,
  balance text,
  code varchar(256) NOT NULL,
  description text NOT NULL,
  iban varchar(35),
  postal_iban varchar(35),
  postal_account_code text,
  holder_postal_cc text,
  org_sector text,
  xsd_definition_ref text,
  amount_cents bigint,
  external_payment_url text,
  flag_anonymous_fiscal_code boolean NOT NULL default false,
  flag_mandatory_due_date boolean NOT NULL default false,
  flag_spontaneous boolean NOT NULL default false,
  flag_notify_io boolean NOT NULL default false,
  service_id text,
  io_template_subject text,
  io_template_message text,
  flag_active boolean NOT NULL default false,
  flag_notify_outcome_push boolean NOT NULL default false,
  notify_outcome_push_org_sil_service_id bigint,
  flag_amount_actualization boolean NOT NULL default false,
  amount_actualization_org_sil_service_id bigint,
  flag_external boolean NOT NULL default false,
  spontaneous_form_id bigint,
  creation_date timestamp with time zone NOT NULL default now(),
  update_date timestamp with time zone NOT NULL default now(),
  update_operator_external_id text NOT NULL,
  update_trace_id text NOT NULL default '-',
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT debt_position_type_org_pkey PRIMARY KEY (debt_position_type_org_pk)
  );

CREATE INDEX IF NOT EXISTS debt_position_type_orgs_processed_time_idx ON raw.debt_position_type_orgs (processed_time);

-- final commit
COMMIT;