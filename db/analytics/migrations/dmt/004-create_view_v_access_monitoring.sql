CREATE OR REPLACE VIEW dmt.v_access_monitoring as (
WITH base_view AS (
    SELECT
        f.username,
        f.event_type,
        o.organization_id,
        o.organization_name,
        d.calendar_date as access_date,
        d.year_month as access_date_year_month,
        d.year as access_date_year
    FROM dwh.fct_access f
    LEFT JOIN aux.dim_date d ON f.receipt_date_pk = d.date_pk
    LEFT JOIN aux.dim_organization o ON f.organization_pk = o.organization_pk
)

SELECT *
FROM base_view
);