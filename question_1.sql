--question_1.sql

WITH industry_wages AS (
  SELECT 
    industry_branch_code,
    payroll_year AS year,
    AVG(value) AS avg_wage
  FROM czechia_payroll
  WHERE value_type_code = 5958
  GROUP BY industry_branch_code, payroll_year
),
wage_change AS (
  SELECT
    iw.industry_branch_code,
    iw.year,
    iw.avg_wage,
    LAG(iw.avg_wage) OVER (PARTITION BY iw.industry_branch_code ORDER BY iw.year) AS prev_wage
  FROM industry_wages iw
)
SELECT
  iw.industry_branch_code,
  cb.name AS industry_name,
  iw.year,
  iw.avg_wage,
  iw.prev_wage,
  iw.avg_wage - iw.prev_wage AS wage_difference
FROM wage_change iw
JOIN czechia_payroll_industry_branch cb ON iw.industry_branch_code = cb.code
WHERE iw.prev_wage IS NOT NULL
  AND iw.avg_wage < iw.prev_wage
ORDER BY iw.industry_branch_code, iw.year;
