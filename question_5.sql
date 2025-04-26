--question_5.sql

WITH cz_economy AS (
  SELECT
    year,
    gdp
  FROM economies
  WHERE country = 'Czech Republic'
),
wages_prices AS (
  SELECT
    year,
    MAX(avg_monthly_wage) AS avg_wage,
    AVG(avg_price) AS avg_food_price
  FROM t_patrik_pitner_project_SQL_primary_final
  GROUP BY year
),
combined AS (
  SELECT
    e.year,
    e.gdp,
    w.avg_wage,
    w.avg_food_price,
    LAG(e.gdp) OVER (ORDER BY e.year) AS prev_gdp,
    LAG(w.avg_wage) OVER (ORDER BY w.year) AS prev_wage,
    LAG(w.avg_food_price) OVER (ORDER BY w.year) AS prev_price
  FROM cz_economy e
  JOIN wages_prices w ON e.year = w.year
)
SELECT
  year,
  ROUND(((gdp - prev_gdp) / prev_gdp * 100)::NUMERIC, 2) AS gdp_growth_pct,
  ROUND(((avg_wage - prev_wage) / prev_wage * 100)::NUMERIC, 2) AS wage_growth_pct,
  ROUND(((avg_food_price - prev_price) / prev_price * 100)::NUMERIC, 2) AS food_price_growth_pct
FROM combined
WHERE prev_gdp IS NOT NULL AND prev_wage IS NOT NULL AND prev_price IS NOT NULL
ORDER BY year;
