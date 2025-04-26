--question_3.sql

WITH yearly_prices AS (
  SELECT
    category_code,
    year,
    AVG(avg_price) AS avg_price
  FROM t_patrik_pitner_project_SQL_primary_final
  GROUP BY category_code, year
),
price_growth AS (
  SELECT
    p1.category_code,
    p1.year,
    p1.avg_price,
    p0.avg_price AS prev_price,
    ROUND(((p1.avg_price - p0.avg_price) / p0.avg_price * 100)::NUMERIC, 2) AS price_growth_pct
  FROM yearly_prices p1
  JOIN yearly_prices p0 ON p1.category_code = p0.category_code AND p1.year = p0.year + 1
),
avg_growth AS (
  SELECT
    category_code,
    ROUND(AVG(price_growth_pct)::NUMERIC, 2) AS avg_growth_percent
  FROM price_growth
  GROUP BY category_code
)
SELECT
  cpc.name AS food_name,
  ag.avg_growth_percent
FROM avg_growth ag
JOIN czechia_price_category cpc ON ag.category_code = cpc.code
ORDER BY ag.avg_growth_percent ASC
LIMIT 1;
