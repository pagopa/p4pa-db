-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS debt_positions.payment_option_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS debt_positions.payment_option (
    payment_option_id bigint NOT NULL default nextval('debt_positions.payment_option_seq'),
    debt_position_id bigint NOT NULL,
    total_amount_cents bigint NOT NULL,
    status varchar(256) NOT NULL,
    description text,
    payment_option_type varchar(30) NOT NULL,
    payment_option_index int NOT NULL default 1,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    constraint payment_option_id_pkey PRIMARY KEY (payment_option_id),
    CONSTRAINT payment_option_debt_position_fkey FOREIGN KEY (debt_position_id) REFERENCES debt_positions.debt_position(debt_position_id)
);

CREATE INDEX IF NOT EXISTS idx_payment_option_debt_position_id ON debt_positions.payment_option (debt_position_id);

-- final commit
COMMIT;