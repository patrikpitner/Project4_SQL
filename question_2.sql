-- question_2.sql

WITH milk_bread_prices AS (
  SELECT
    year,
    MAX(CASE WHEN category_code = '114201' THEN avg_price END) AS avg_milk_price,
    MAX(CASE WHEN category_code = '111301' THEN avg_price END) AS avg_bread_price,
    MAX(avg_monthly_wage) AS avg_monthly_wage
  FROM t_patrik_pitner_project_SQL_primary_final
  GROUP BY year
)
SELECT
  year,
  avg_monthly_wage,
  avg_milk_price,
  avg_bread_price,
  ROUND((avg_monthly_wage / avg_milk_price)::NUMERIC, 2) AS milk_liters_affordable,
  ROUND((avg_monthly_wage / avg_bread_price)::NUMERIC, 2) AS bread_kgs_affordable
FROM milk_bread_prices
WHERE year IN (
  (SELECT MIN(year) FROM milk_bread_prices),
  (SELECT MAX(year) FROM milk_bread_prices)
)
ORDER BY year;
