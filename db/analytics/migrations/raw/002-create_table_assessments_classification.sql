-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE SEQUENCE IF NOT EXISTS raw.assessments_classification_seq
    AS bigint
    START WITH 1
    INCREMENT BY 1 ;

CREATE TABLE IF NOT EXISTS raw.assessments_classification (
  assessment_classification_pk bigint default nextval('raw.assessments_classification_seq'),
  assessment_classification_payload jsonb NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT assessment_classification_pkey PRIMARY KEY (assessment_classification_pk)
);

CREATE INDEX IF NOT EXISTS assessments_classification_processed_time_idx ON raw.assessments_classification (processed_time);

-- final commit
COMMIT;