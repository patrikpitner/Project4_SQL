-- ====================================================================================
-- SQL Projekt: Analýza dostupnosti potravin v ČR a ekonomické ukazatele evropských států
-- Autor: Patrik Pitner
-- Roky analýzy: 2006–2018
-- ====================================================================================

-- ================================================================================
-- 1. VYTVOŘENÍ PRIMÁRNÍ TABULKY (ČR – MZDY, CENY POTRAVIN, KUPNÍ SÍLA)
-- ================================================================================

DROP TABLE IF EXISTS t_patrik_pitner_project_SQL_primary_final;

CREATE TEMP TABLE t_patrik_pitner_project_SQL_primary_final AS
WITH avg_wage_per_year AS (
  SELECT
    payroll_year AS year,
    AVG(value) AS avg_monthly_wage
  FROM czechia_payroll
  WHERE value_type_code = 5958  -- Průměrná hrubá mzda na zaměstnance
  GROUP BY payroll_year
),
avg_price_per_year AS (
  SELECT
    EXTRACT(YEAR FROM date_from) AS year,
    AVG(CASE WHEN category_code = '114201' THEN value END) AS avg_milk_price,  -- Mléko
    AVG(CASE WHEN category_code = '111301' THEN value END) AS avg_bread_price  -- Chléb
  FROM czechia_price
  WHERE category_code IN ('114201', '111301')
  GROUP BY EXTRACT(YEAR FROM date_from)
),
combined AS (
  SELECT
    w.year,
    w.avg_monthly_wage,
    p.avg_milk_price,
    p.avg_bread_price,
    ROUND((w.avg_monthly_wage / p.avg_milk_price)::NUMERIC, 2) AS milk_liters_affordable,
    ROUND((w.avg_monthly_wage / p.avg_bread_price)::NUMERIC, 2) AS bread_kgs_affordable
  FROM avg_wage_per_year w
  JOIN avg_price_per_year p ON w.year = p.year
)
SELECT *
FROM combined;

-- ================================================================================
-- 2. VÝZKUMNÁ OTÁZKA – KOLIK LZE KOUPIT V PRVNÍM A POSLEDNÍM ROCE?
-- ================================================================================

SELECT *
FROM t_patrik_pitner_project_SQL_primary_final
WHERE year = (
    SELECT MIN(year) FROM t_patrik_pitner_project_SQL_primary_final
)
   OR year = (
    SELECT MAX(year) FROM t_patrik_pitner_project_SQL_primary_final
)
ORDER BY year;

-- ================================================================================
-- 3. VÝZKUMNÁ OTÁZKA – KTERÁ POTRAVINA ZDRAŽUJE NEJPOMALEJI?
-- ================================================================================

WITH yearly_avg_prices AS (
  SELECT
    category_code,
    EXTRACT(YEAR FROM date_from) AS year,
    AVG(value) AS avg_price
  FROM czechia_price
  GROUP BY category_code, EXTRACT(YEAR FROM date_from)
),
with_previous_year AS (
  SELECT
    p1.category_code,
    p1.year,
    p1.avg_price,
    p0.avg_price AS prev_year_price,
    ROUND((((p1.avg_price - p0.avg_price) / p0.avg_price) * 100)::NUMERIC, 2) AS price_growth_pct
  FROM yearly_avg_prices p1
  JOIN yearly_avg_prices p0 
    ON p1.category_code = p0.category_code AND p1.year = p0.year + 1
),
avg_growth_per_category AS (
  SELECT
    category_code,
    ROUND(AVG(price_growth_pct)::NUMERIC, 2) AS avg_growth_percent
  FROM with_previous_year
  GROUP BY category_code
)
SELECT 
  cpc.name AS food_name,
  ag.avg_growth_percent
FROM avg_growth_per_category ag
JOIN czechia_price_category cpc ON ag.category_code = cpc.code
ORDER BY ag.avg_growth_percent ASC
LIMIT 1;

-- ================================================================================
-- 4. VÝZKUMNÁ OTÁZKA – ROKY, KDY CENY ROSTLY O VÍC NEŽ 10 % RYCHLEJI NEŽ MZDY
-- ================================================================================

WITH avg_data_per_year AS (
  SELECT
    year,
    AVG(avg_monthly_wage) AS avg_wage,
    AVG((avg_milk_price + avg_bread_price) / 2) AS avg_price
  FROM t_patrik_pitner_project_SQL_primary_final
  GROUP BY year
),
yearly_growth AS (
  SELECT
    a.year,
    a.avg_wage,
    a.avg_price,
    LAG(a.avg_wage) OVER (ORDER BY a.year) AS prev_wage,
    LAG(a.avg_price) OVER (ORDER BY a.year) AS prev_price
  FROM avg_data_per_year a
),
growth_comparison AS (
  SELECT
    year,
    ROUND(((avg_wage - prev_wage) / prev_wage * 100)::NUMERIC, 2) AS wage_growth_pct,
    ROUND(((avg_price - prev_price) / prev_price * 100)::NUMERIC, 2) AS price_growth_pct,
    ROUND((((avg_price - prev_price) / prev_price * 100) - ((avg_wage - prev_wage) / prev_wage * 100))::NUMERIC, 2) AS difference_pct
  FROM yearly_growth
  WHERE prev_wage IS NOT NULL AND prev_price IS NOT NULL
)
SELECT *
FROM growth_comparison
WHERE difference_pct > 10
ORDER BY year;

-- ================================================================================
-- 5. VÝZKUMNÁ OTÁZKA – VLIV HDP NA MZDY A CENY POTRAVIN
-- ================================================================================

WITH cz_economy AS (
  SELECT
    year,
    gdp
  FROM economies
  WHERE country = 'Czech Republic'
),
wage_price AS (
  SELECT
    year,
    avg_monthly_wage,
    (avg_milk_price + avg_bread_price) / 2 AS avg_food_price
  FROM t_patrik_pitner_project_SQL_primary_final
),
combined AS (
  SELECT
    e.year,
    e.gdp,
    w.avg_monthly_wage,
    w.avg_food_price,
    LAG(e.gdp) OVER (ORDER BY e.year) AS prev_gdp,
    LAG(w.avg_monthly_wage) OVER (ORDER BY w.year) AS prev_wage,
    LAG(w.avg_food_price) OVER (ORDER BY w.year) AS prev_price
  FROM cz_economy e
  JOIN wage_price w ON e.year = w.year
),
growth_comparison AS (
  SELECT
    year,
    ROUND(((gdp - prev_gdp) / prev_gdp * 100)::NUMERIC, 2) AS gdp_growth_pct,
    ROUND(((avg_monthly_wage - prev_wage) / prev_wage * 100)::NUMERIC, 2) AS wage_growth_pct,
    ROUND(((avg_food_price - prev_price) / prev_price * 100)::NUMERIC, 2) AS food_price_growth_pct
  FROM combined
  WHERE prev_gdp IS NOT NULL AND prev_wage IS NOT NULL AND prev_price IS NOT NULL
)
SELECT *
FROM growth_comparison
ORDER BY year;

-- ================================================================================
-- VYTVOŘENÍ SEKUNDÁRNÍ TABULKY – EVROPSKÉ STÁTY (HDP, GINI, POPULACE)
-- ================================================================================

DROP TABLE IF EXISTS t_patrik_pitner_project_SQL_secondary_final;

CREATE TEMP TABLE t_patrik_pitner_project_SQL_secondary_final AS
SELECT
  e.year,
  c.country,
  e.gdp,
  e.gini,
  e.population
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018
  AND e.gdp IS NOT NULL
  AND e.population IS NOT NULL
ORDER BY e.year, c.country;

-- ================================================================================
-- PŘEHLED DOSTUPNOSTI DAT V SEKUNDÁRNÍ TABULCE
-- ================================================================================

SELECT year, COUNT(*) AS country_count
FROM t_patrik_pitner_project_SQL_secondary_final
GROUP BY year
ORDER BY year;