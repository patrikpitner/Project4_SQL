# SQL Projekt – Analýza dostupnosti potravin

Tento projekt zkoumá vývoj kupní síly obyvatel České republiky z pohledu průměrné mzdy a cen základních potravin (mléko, chléb) v období 2006–2018.  
Zároveň porovnává ekonomické ukazatele evropských států (HDP, GINI index, populace) ve stejném období.

## Struktura projektu

- `create_primary_table.sql` – Skript pro vytvoření primární tabulky `t_patrik_pitner_project_SQL_primary_final`.
- `create_secondary_table.sql` – Skript pro vytvoření sekundární tabulky `t_patrik_pitner_project_SQL_secondary_final`.
- `question_1.sql` až `question_5.sql` – Samostatné SQL skripty odpovídající na jednotlivé výzkumné otázky.
- `mezivysledky.md` – Průvodní listina popisující postup tvorby tabulek a mezivýsledků.
- `vystupni_data_info.md` – Dokumentace o dostupnosti a kvalitě výstupních dat.

## Výsledné tabulky

### t_patrik_pitner_project_SQL_primary_final
- Úroveň: Česká republika
- Obsahuje: Rok, průměrnou měsíční mzdu, kód kategorie potravin, průměrnou cenu potraviny
- Typ tabulky: Dočasná (`TEMP`), lze změnit na trvalou odstraněním klauzule TEMP

### t_patrik_pitner_project_SQL_secondary_final
- Úroveň: Evropské státy
- Obsahuje: Rok, stát, HDP, GINI index, populace
- Filtr: Pouze státy z Evropy s dostupnými daty pro roky 2006–2018

## Datové zdroje

- `czechia_payroll`, `czechia_price` – otevřená data České republiky
- `economies`, `countries` – globální socioekonomická data

## Rozsah dat

- Roky 2006–2018 (na základě dostupnosti kompletních údajů o mzdách, cenách a ekonomických ukazatelích)

## Poznámky

- Data nejsou upravována přímo v původních tabulkách – veškeré transformace probíhají v nově vytvořených výstupních tabulkách.
- U sekundární tabulky je ponechán GINI index jako `NULL`, pokud nebyla data dostupná.
- Dotazy na výzkumné otázky pracují pouze s výstupními tabulkami.

## Výsledky výzkumných otázek

### 1. Rostou v průběhu let mzdy ve všech odvětvích?
- V některých odvětvích došlo v jednotlivých letech k poklesu průměrné mzdy oproti předchozímu roku.

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
- 2006: cca 1432 litrů mléka / 1282 kg chleba
- 2018: cca 1639 litrů mléka / 1340 kg chleba
- Kupní síla obyvatel v ČR v tomto období rostla.

### 3. Která kategorie potravin zdražuje nejpomaleji?
- Cukr krystal – měl nejnižší průměrný meziroční růst ceny (dlouhodobě se dokonce cena mírně snižovala).

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než 10 %)?
- V roce 2008 a 2011 byl růst cen potravin výrazně vyšší než růst mezd (rozdíl přes 10 procentních bodů).

### 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
- Vyšší růst HDP (např. v letech 2007 a 2017) byl zpravidla spojen s růstem mezd.
- Růst cen potravin však nebyl přímo úměrný růstu HDP.
