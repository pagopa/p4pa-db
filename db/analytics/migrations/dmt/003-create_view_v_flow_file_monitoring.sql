CREATE OR REPLACE VIEW dmt.v_flow_file_monitoring AS
WITH base AS (
    SELECT
        f.fct_flow_file_pk,
        f.organization_id,
        f.row_count,
        f.processed_rows,
        f.file_size,
        f.event_date_pk,
        f.processed_time,
        f.event_type,
        f.flow_type,
        f.status,
        f.operator_external_user_id,
        f.operator_type,
        o.organization_name,
        d.calendar_date,
        d.year AS cal_year,
        d.month_name,
        d.year_month,
        d.day AS day_of_month,
        d.is_weekend,
        to_char(d.calendar_date::timestamp with time zone, 'Day'::text) AS day_name_it
    FROM dwh.fct_flow_file f
         LEFT JOIN aux.dim_date d ON f.event_date_pk = d.date_pk
         LEFT JOIN aux.dim_organization o ON f.organization_id = o.organization_id
)
SELECT
    *,
    -- 1. ANALISI ADOZIONE UTENTI
    CASE
        WHEN operator_type = 'SYSTEM_USER' THEN 'Automazione (API/System)'
        WHEN operator_type = 'SIL' THEN 'Integrazione SIL'
        ELSE 'Manuale (Operatore)'
    END AS operator_category,

    -- 2. FLAG PER CONTEGGIO OPERAZIONI
    CASE WHEN event_type = 'INGESTION' THEN 1 ELSE 0 END AS is_ingestion,
    CASE WHEN event_type = 'EXPORT' THEN 1 ELSE 0 END AS is_export,

    -- 3. METRICHE
    CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END AS is_success,
    (file_size::float / 1024 / 1024 ) AS file_size_mb

FROM base;