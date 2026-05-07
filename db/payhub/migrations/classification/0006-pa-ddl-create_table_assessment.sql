-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS classification.assessment_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS classification.assessments
(
    assessment_id bigint NOT NULL default nextval('classification.assessment_id_seq'),
    organization_id bigint NOT NULL,
    debt_position_type_org_id bigint NOT NULL, 
    debt_position_type_org_code varchar(256) NOT NULL,
    status varchar(50) NOT NULL,
    assessment_name text NOT NULL,
    printed boolean NOT NULL default false,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text not null,
    update_trace_id text NOT NULL default '-',
    flag_manual_generation boolean NOT NULL default false,
    operator_external_user_id text NOT NULL,
    CONSTRAINT assessments_pkey PRIMARY KEY (assessment_id),
    CONSTRAINT assessments_uk UNIQUE (assessment_name, debt_position_type_org_code, organization_id)
);

CREATE INDEX IF NOT EXISTS assessments_organization_id_status_idx
    ON classification.assessments (organization_id, status);

CREATE INDEX IF NOT EXISTS assessments_org_id_debt_position_type_org_code_idx
    ON classification.assessments (organization_id, debt_position_type_org_code);

CREATE INDEX IF NOT EXISTS assessments_org_id_debt_position_type_org_id_idx
    ON classification.assessments (organization_id, debt_position_type_org_id);

-- final commit
COMMIT;