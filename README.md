# SQL Projekt – Analýza dostupnosti potravin

Tento projekt zkoumá vývoj kupní síly obyvatel České republiky z pohledu průměrné mzdy a cen základních potravin (mléko, chléb) v období 2006–2018.  
Zároveň porovnává ekonomické ukazatele evropských států (HDP, GINI, populace) ve stejném období.

## Struktura projektu

- `patrik_pitner_project.sql` – Jeden kompletní SQL skript, který:
  - vytvoří primární tabulku `t_patrik_pitner_project_SQL_primary_final`
  - vytvoří sekundární tabulku `t_patrik_pitner_project_SQL_secondary_final`
  - obsahuje odpovědi na všech 5 výzkumných otázek pomocí samostatných dotazů

## Výsledné tabulky

### t_patrik_pitner_project_SQL_primary_final
- **Úroveň**: Česká republika
- **Obsahuje**: Rok, průměrnou mzdu, průměrnou cenu mléka a chleba, počet litrů mléka a kilogramů chleba, které si lze koupit za průměrnou mzdu
- **Typ tabulky**: Dočasná (TEMP) – lze změnit na trvalou odstraněním klauzule `TEMP`

### t_patrik_pitner_project_SQL_secondary_final
- **Úroveň**: Evropské státy
- **Obsahuje**: Rok, stát, HDP, GINI, populace
- **Filtr**: Pouze státy v Evropě a roky 2006–2018 s dostupnými daty

## Datové zdroje

- `czechia_payroll`, `czechia_price` – otevřená data ČR
- `economies`, `countries` – globální socioekonomická data

## Rozsah dat

- Roky 2006–2018 (na základě dostupnosti kompletních údajů pro mzdy i ceny)

## Poznámky

- Data nejsou upravována v původních tabulkách – veškeré transformace probíhají až v nově vytvořených výstupních tabulkách
- Pro maximální počet dostupných států byla sekundární tabulka vytvořena tak, že GINI index může být `NULL`, pokud chybí
- Dotazy na výzkumné otázky jsou navrženy tak, aby fungovaly pouze na základě výstupních tabulek

## Výsledky výzkumných otázek

### 1. Rostou v průběhu let mzdy ve všech odvětvích?
Průměrná mzda v ČR mezi lety 2006–2018 rostla každoročně. Pokles nebyl zaznamenán, i když v některých letech byl růst pomalejší.

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?
- **2006**: cca 1432 litrů mléka / 1282 kg chleba
- **2018**: cca 1639 litrů mléka / 1340 kg chleba
  = Kupní síla obyvatel tedy rostla.

### 3. Která kategorie potravin zdražuje nejpomaleji?
- **Cukr krystal** – průměrný meziroční růst ceny: **–1.92 %** (cena se dlouhodobě snižovala)

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než 10 %)?
- **2008**: rozdíl +10.64 %
- **2011**: rozdíl +11.78 %
  = V těchto letech rostly ceny rychleji než mzdy, což znamená pokles kupní síly.

### 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?
- V letech s růstem HDP (např. 2007, 2017) se obvykle zvyšovaly i mzdy
- Růst cen potravin ale nebyl vždy přímo úměrný změně HDP = existuje vliv
