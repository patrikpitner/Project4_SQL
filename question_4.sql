--question_4.sql

WITH yearly_summary AS (
  SELECT
    year,
    MAX(avg_monthly_wage) AS avg_wage,
    AVG(avg_price) AS avg_food_price
  FROM t_patrik_pitner_project_SQL_primary_final
  GROUP BY year
),
growth_data AS (
  SELECT
    year,
    avg_wage,
    avg_food_price,
    LAG(avg_wage) OVER (ORDER BY year) AS prev_wage,
    LAG(avg_food_price) OVER (ORDER BY year) AS prev_food_price
  FROM yearly_summary
)
SELECT
  year,
  ROUND(((avg_food_price - prev_food_price) / prev_food_price * 100)::NUMERIC, 2) AS food_price_growth_pct,
  ROUND(((avg_wage - prev_wage) / prev_wage * 100)::NUMERIC, 2) AS wage_growth_pct,
  ROUND((((avg_food_price - prev_food_price) / prev_food_price - (avg_wage - prev_wage) / prev_wage) * 100)::NUMERIC, 2) AS difference_pct
FROM growth_data
WHERE prev_wage IS NOT NULL AND prev_food_price IS NOT NULL
  AND (((avg_food_price - prev_food_price) / prev_food_price * 100) - ((avg_wage - prev_wage) / prev_wage * 100)) > 10
ORDER BY year;
