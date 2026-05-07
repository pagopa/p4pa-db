-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SCHEMA IF NOT EXISTS migration;

-- final commit
COMMIT;