-- start transaction
BEGIN;

------------------- business logic -------------------

CREATE SCHEMA IF NOT EXISTS debt_positions;

-- final commit
COMMIT;