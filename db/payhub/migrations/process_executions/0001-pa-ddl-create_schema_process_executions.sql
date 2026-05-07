-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SCHEMA IF NOT EXISTS process_executions;

-- final commit
COMMIT;