-- start transaction
BEGIN;

------------------- business logic -------------------
CREATE TABLE IF NOT EXISTS dwh.fct_flow_file (
  fct_flow_file_pk text NOT NULL,
  event_type varchar(256) NOT NULL,
  flow_type varchar(256) NOT NULL,
  status varchar(256) NOT NULL,
  organization_id bigint NOT NULL,
  row_count bigint NOT NULL,
  processed_rows bigint NOT NULL,
  file_size bigint NOT NULL,
  operator_external_user_id varchar(256) NOT NULL,
  operator_type varchar(256) NOT NULL,
  event_date_pk text,
  processed_time timestamp with time zone,

  CONSTRAINT flow_file_pk PRIMARY KEY (fct_flow_file_pk),
  CONSTRAINT fk_fct_event_date_pk FOREIGN KEY (event_date_pk) REFERENCES aux.dim_date(date_pk)
);

-- final commit
COMMIT;