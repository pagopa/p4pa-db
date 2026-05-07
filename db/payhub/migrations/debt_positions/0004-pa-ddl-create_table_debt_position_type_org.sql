-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.debt_position_type_org_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.debt_position_type_org (
    debt_position_type_org_id bigint NOT NULL default nextval('debt_positions.debt_position_type_org_seq'),
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
    amount_cents bigint,
    external_payment_url text,
    flag_anonymous_fiscal_code bool NOT NULL default false,
    flag_mandatory_due_date bool NOT NULL default false,
    flag_spontaneous bool NOT NULL default false,
    flag_notify_io bool NOT NULL default false,
    service_id text,
    io_template_subject text,
    io_template_message text,
    flag_active bool NOT NULL default false,
    flag_notify_outcome_push bool NOT NULL default false,
    notify_outcome_push_org_sil_service_id bigint,
    flag_amount_actualization bool NOT NULL default false,
    amount_actualization_org_sil_service_id bigint,
    flag_external bool NOT NULL default false,
    spontaneous_form_id bigint,
    allowed_entity_type character(1),
    description_i18n jsonb,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint debt_position_type_org_id_pkey PRIMARY KEY (debt_position_type_org_id),
    CONSTRAINT debt_position_type_id_fkey FOREIGN KEY (debt_position_type_id) REFERENCES debt_positions.debt_position_type(debt_position_type_id),
    CONSTRAINT spontaneous_form_id_fkey FOREIGN KEY (spontaneous_form_id) REFERENCES debt_positions.spontaneous_form(spontaneous_form_id)
);

CREATE INDEX IF NOT EXISTS idx_debt_position_type_org_id ON debt_positions.debt_position_type_org (organization_id);
CREATE INDEX IF NOT EXISTS idx_debt_position_type_id ON debt_positions.debt_position_type_org (debt_position_type_id);
CREATE unique INDEX IF NOT EXISTS idx_debt_position_type_org_organization_id_code ON debt_positions.debt_position_type_org (organization_id, code);
CREATE INDEX IF NOT EXISTS idx_update_date ON debt_positions.debt_position_type_org (update_date);

-- final commit
COMMIT;