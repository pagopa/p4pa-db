-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE TABLE IF NOT EXISTS cfg.flow_status (
  flow_name varchar(100),
  status varchar(50),
  -- DWH technical fields
  watermark timestamp with time zone,
  info text,
  CONSTRAINT flow_name_pkey PRIMARY KEY (flow_name)
);

-- final commit
COMMIT;