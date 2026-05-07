-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS organizations.organization_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS organizations.organization (
	organization_id bigint NOT NULL default nextval('organizations.organization_seq'),
	external_organization_id varchar(256),
    broker_id bigint,
	ipa_code varchar(256) NOT NULL,
	org_fiscal_code varchar(11) NOT NULL,
	org_name varchar(256) NOT NULL,
	org_type_code varchar(35),
	org_email text,
	iban varchar(35),
	postal_iban varchar(35),
	password bytea,
	segregation_code varchar(2),
	default_organization_station_id bigint,
	cbill_inter_bank_code varchar(5),
	org_logo text,
	status varchar(256) NOT NULL,
	additional_language varchar(2),
	start_date timestamp with time zone,
	io_api_key bytea,
	send_api_key bytea,
	generate_notice_api_key bytea,
	pdnd_enabled bool NOT NULL default false,
	flag_notify_io bool NOT NULL default false,
	flag_notify_outcome_push bool NOT NULL default false,
	flag_payment_notification bool NOT NULL default false,
	flag_treasury bool NOT NULL default false,
	flag_payments_reporting bool NOT NULL default true,
	flag_classification bool NOT NULL default true,
	address varchar(256),
	zip_code varchar(10),
	city varchar(100),
	creation_date timestamp with time zone NOT NULL default now(),
	update_date timestamp with time zone NOT NULL default now(),
	update_operator_external_id text NOT NULL,
	update_trace_id text NOT NULL default '-',
	CONSTRAINT organization_pkey PRIMARY KEY (organization_id),
    CONSTRAINT ipa_code_ukey UNIQUE (ipa_code),
    CONSTRAINT org_fiscal_code_ukey_cf UNIQUE (org_fiscal_code),
    CONSTRAINT external_organization_id_ukey UNIQUE (external_organization_id)
);

INSERT INTO organizations.organization
    (organization_id,  ipa_code, org_fiscal_code, org_name, status  , flag_payments_reporting, flag_classification, update_operator_external_id)
SELECT
     -1             , 'UNKNOWN', 'UNKNOWN'      , ''      , 'ACTIVE', false                  , false              , 'SYSTEM'
WHERE NOT EXISTS(SELECT * FROM organizations.organization WHERE organization_id=-1);

-- final commit
COMMIT;