-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS classification.assessment_registry_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS classification.assessments_registry
(
    assessment_registry_id bigint NOT NULL default nextval('classification.assessment_registry_id_seq'),
    organization_id bigint NOT NULL,
    debt_position_type_org_code varchar(256) NOT NULL,
    section_code varchar(64) NOT NULL,
    section_description varchar(512),
    office_code varchar(64),
    office_description varchar(512),
    assessment_code varchar(64),
    assessment_description varchar(512),
    operating_year varchar(4) NOT NULL,
    status varchar(50) NOT NULL,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    CONSTRAINT assessments_registry_pkey PRIMARY KEY (assessment_registry_id)
);


CREATE INDEX IF NOT EXISTS assessments_registry_org_id_debt_position_type_org_code_idx
    ON classification.assessments_registry (organization_id, debt_position_type_org_code);

CREATE INDEX IF NOT EXISTS assessments_registry_org_id_section_office_assessment_operating_year_idx
    ON classification.assessments_registry (organization_id, section_code, office_code, assessment_code, operating_year);

CREATE UNIQUE INDEX IF NOT EXISTS uq_active_registry_triplet
    ON classification.assessments_registry (organization_id, debt_position_type_org_code, operating_year)
    WHERE status = 'ACTIVE';

-- final commit
COMMIT;