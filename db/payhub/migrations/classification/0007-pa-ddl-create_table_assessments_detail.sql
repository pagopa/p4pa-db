-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SEQUENCE IF NOT EXISTS classification.assessment_detail_id_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS classification.assessments_detail
(
    assessment_detail_id bigint NOT NULL DEFAULT nextval('classification.assessment_detail_id_seq'),
    assessment_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    debt_position_type_org_id bigint NOT NULL,
    debt_position_type_org_code varchar(256) NOT NULL,
    iuv varchar(35) NOT NULL,
    iud varchar(35) NOT NULL,
    iur text NOT NULL,
    payment_date_time timestamp with time zone,
    debtor_fiscal_code_hash bytea NOT NULL,
    office_code varchar(64),
    office_description varchar(512),
    section_code varchar(64) NOT NULL,
    section_description varchar(512),
    assessment_code varchar(64),
    assessment_description varchar(512),
    amount_cents bigint NOT NULL,
    amount_submitted boolean NOT NULL DEFAULT true,
    creation_date timestamp with time zone NOT NULL default now(),
    update_date timestamp with time zone NOT NULL default now(),
    update_operator_external_id text NOT NULL,
    update_trace_id text NOT NULL default '-',
    receipt_id bigint,
    classification_label varchar(20),
    date_receipt timestamp with time zone,
    date_reporting timestamp with time zone,
    date_treasury timestamp with time zone,
    CONSTRAINT assessments_detail_pkey PRIMARY KEY (assessment_detail_id),
    CONSTRAINT fk_assessment_detail_assessment_id FOREIGN KEY (assessment_id) REFERENCES classification.assessments(assessment_id),
    CONSTRAINT assessment_detail_uk UNIQUE (iuv, iud, office_code, section_code, assessment_code, debt_position_type_org_code)
);

Create INDEX IF NOT EXISTS assessments_detail_assessment_id_idx
    ON classification.assessments_detail (assessment_id);

CREATE INDEX IF NOT EXISTS assessments_detail_org_id_debt_position_type_org_code_idx
    ON classification.assessments_detail (organization_id, debt_position_type_org_code);

CREATE INDEX IF NOT EXISTS assessments_detail_org_id_debt_position_type_org_id_idx
    ON classification.assessments_detail (organization_id, debt_position_type_org_id);

CREATE INDEX IF NOT EXISTS assessments_detail_organization_id_iuv_iud_idx
    ON classification.assessments_detail (organization_id, iuv, iud);

CREATE UNIQUE INDEX IF NOT EXISTS assessments_detail_assessment_id_iud_idx
    ON classification.assessments_detail (assessment_id, iud);

-- final commit
COMMIT;