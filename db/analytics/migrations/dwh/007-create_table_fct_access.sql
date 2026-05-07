-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS dwh.fct_access (
  access_pk text NOT NULL,
  username varchar(255) NOT NULL,
  -- foreign keys
  receipt_date_pk text,
  organization_pk text,
  -- measures and attributes
  event_type varchar(255) NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,

  CONSTRAINT access_pk PRIMARY KEY (access_pk),
  CONSTRAINT fk_fct_organization FOREIGN KEY (organization_pk) REFERENCES aux.dim_organization(organization_pk),
  CONSTRAINT fk_fct_date_receipt FOREIGN KEY (receipt_date_pk) REFERENCES aux.dim_date(date_pk)
);

-- final commit
COMMIT;