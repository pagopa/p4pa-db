-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS aux.dim_date (
  date_pk text,
  calendar_date date NOT NULL,
  year int NOT NULL,
  quarter int NOT NULL,
  month int NOT NULL,
  year_month varchar(7) NOT NULL,
  month_name varchar(20) NOT NULL,
  day int NOT NULL,
  is_weekend boolean NOT NULL,
  -- DWH technical fields
  processed_time timestamp with time zone,
  CONSTRAINT date_pkey PRIMARY KEY (date_pk)
);

CREATE INDEX IF NOT EXISTS dim_date_calendar_date_idx ON aux.dim_date (calendar_date);
CREATE INDEX IF NOT EXISTS dim_date_processed_time_idx ON aux.dim_date (processed_time);

-- final commit
COMMIT;