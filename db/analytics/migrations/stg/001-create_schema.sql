-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SCHEMA IF NOT EXISTS stg;

-- final commit
COMMIT;