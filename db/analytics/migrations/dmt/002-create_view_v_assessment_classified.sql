CREATE OR REPLACE VIEW dmt.v_assessment_classified as (
WITH base_view AS (
    SELECT
      f.organization_id,
      dpto.debt_position_type_org_id AS debt_position_type_org_id,
      dpto.code AS debt_position_type_org_code,
      dpto.description AS debt_position_type_org_description,
      dr.calendar_date      AS date_receipt,
      drep.calendar_date    AS date_reporting,
      dt.calendar_date      AS date_treasury,

      CASE 
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'PAID'     THEN dr.calendar_date
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'REPORTED' THEN drep.calendar_date
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'CASHED'   THEN dt.calendar_date
      END AS reference_date,

      CASE 
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'PAID'     THEN dr.year
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'REPORTED' THEN drep.year
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'CASHED'   THEN dt.year
      END AS reference_date_year,

      CASE 
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'PAID'     THEN dr.year_month
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'REPORTED' THEN drep.year_month
          WHEN UPPER(COALESCE(f.classification_label, '')) = 'CASHED'   THEN dt.year_month
      END AS reference_date_year_month,

      off.office_description     AS office_description,
      sec.section_description    AS section_description,
      ass.assessment_description AS assessment_description,

      SUM(
        CASE WHEN UPPER(COALESCE(f.classification_label, '')) = 'PAID'
             THEN COALESCE(f.amount_cents, 0) ELSE 0 END
      ) / 100.0 AS amount_paid,

      SUM(
        CASE WHEN UPPER(COALESCE(f.classification_label, '')) = 'REPORTED'
             THEN COALESCE(f.amount_cents, 0) ELSE 0 END
      ) / 100.0 AS amount_reported,

      SUM(
        CASE WHEN UPPER(COALESCE(f.classification_label, '')) = 'CASHED'
             THEN COALESCE(f.amount_cents, 0) ELSE 0 END
      ) / 100.0 AS amount_cashed,
	f.classification_label AS classification_label
    FROM dwh.fct_payment_assessment_detail f
    LEFT JOIN aux.dim_debt_position_type_org dpto
      ON f.debt_position_type_org_pk = dpto.debt_position_type_org_pk
    LEFT JOIN dwh.dim_office off
      ON f.office_pk = off.office_pk
    LEFT JOIN dwh.dim_section sec
      ON f.section_pk = sec.section_pk
    LEFT JOIN dwh.dim_assessment ass
      ON f.assessment_pk = ass.assessment_pk
    LEFT JOIN aux.dim_date dr
      ON f.date_receipt_pk = dr.date_pk
    LEFT JOIN aux.dim_date drep
      ON f.date_reporting_pk = drep.date_pk
    LEFT JOIN aux.dim_date dt
      ON f.date_treasury_pk = dt.date_pk
    GROUP BY
      f.organization_id,
      dpto.debt_position_type_org_id,
      dpto.code,
      dpto.description,
      dr.calendar_date,
      drep.calendar_date,
      dt.calendar_date,
      dr.year,
      drep.year,
      dt.year,
      dr.year_month,
      drep.year_month,
      dt.year_month,
      f.classification_label,
      off.office_description,
      sec.section_description,
      ass.assessment_description
)

SELECT *
FROM base_view
);