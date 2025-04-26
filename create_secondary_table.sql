-- create_secondary_table.sql

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
  AND e.population IS NOT NULL;
