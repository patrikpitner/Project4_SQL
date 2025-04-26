-- 01_create_primary_table.sql

DROP TABLE IF EXISTS t_patrik_pitner_project_SQL_primary_final;

CREATE TEMP TABLE t_patrik_pitner_project_SQL_primary_final AS
WITH avg_wage_per_year AS (
  SELECT
    payroll_year AS year,
    AVG(value) AS avg_monthly_wage
  FROM czechia_payroll
  WHERE value_type_code = 5958
  GROUP BY payroll_year
),
avg_price_per_year AS (
  SELECT
    EXTRACT(YEAR FROM date_from) AS year,
    category_code,
    AVG(value) AS avg_price
  FROM czechia_price
  GROUP BY EXTRACT(YEAR FROM date_from), category_code
)
SELECT
  w.year,
  w.avg_monthly_wage,
  p.category_code,
  p.avg_price
FROM avg_wage_per_year w
JOIN avg_price_per_year p ON w.year = p.year
WHERE w.year BETWEEN 2006 AND 2018;