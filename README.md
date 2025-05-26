# SQL Projekt – Analýza dostupnosti potravin

Tento projekt zkoumá vývoj kupní síly obyvatel České republiky z pohledu průměrné mzdy a cen základních potravin (mléko, chléb) v období 2006–2018.  
Zároveň porovnává ekonomické ukazatele evropských států (HDP, GINI index, populace) ve stejném období.

---

## Struktura projektu

- `create_primary_table.sql` – Skript pro vytvoření primární tabulky `t_patrik_pitner_project_SQL_primary_final`.
- `create_secondary_table.sql` – Skript pro vytvoření sekundární tabulky `t_patrik_pitner_project_SQL_secondary_final`.
- `question_1.sql` až `question_5.sql` – Samostatné SQL skripty odpovídající na jednotlivé výzkumné otázky.
- `mezivysledky.md` – Průvodní listina popisující postup tvorby tabulek a mezivýsledků.
- `vystupni_data_info.md` – Dokumentace o dostupnosti a kvalitě výstupních dat.

---

## Výsledné tabulky

### `t_patrik_pitner_project_SQL_primary_final`
- **Úroveň:** Česká republika  
- **Obsahuje:** Rok, průměrnou měsíční mzdu, kód kategorie potravin, průměrnou cenu potraviny  
- **Typ tabulky:** Dočasná (`TEMP`), lze změnit na trvalou odstraněním klauzule `TEMP`

### `t_patrik_pitner_project_SQL_secondary_final`
- **Úroveň:** Evropské státy  
- **Obsahuje:** Rok, stát, HDP, GINI index, populace  
- **Filtr:** Pouze státy z Evropy s dostupnými daty pro roky 2006–2018

---

## Datové zdroje

- `czechia_payroll`, `czechia_price` – otevřená data České republiky  
- `economies`, `countries` – globální socioekonomická data

---

## Rozsah dat

- **Roky:** 2006–2018  
  (na základě dostupnosti kompletních údajů o mzdách, cenách a ekonomických ukazatelích)

---

## Poznámky

- Data nejsou upravována přímo v původních tabulkách – veškeré transformace probíhají v nově vytvořených výstupních tabulkách.
- U sekundární tabulky je ponechán GINI index jako `NULL`, pokud nebyla data dostupná.
- Dotazy na výzkumné otázky pracují výhradně s výstupními tabulkami.

---

## Výsledky výzkumných otázek

### 1. Rostou v průběhu let mzdy ve všech odvětvích?

Ne, mzdy v některých odvětvích meziročně klesly.  
Například v roce 2012 klesla průměrná mzda v odvětví **"Ubytování a stravování"** z 20 123 Kč na 19 845 Kč, tj. pokles o **1,38 %**.

---

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?

- **Rok 2006** (mzda: 20 211 Kč):  
  cca **956 litrů mléka** (21,14 Kč/l),  
  cca **629 kg chleba** (32,10 Kč/kg)

- **Rok 2018** (mzda: 31 868 Kč):  
  cca **1 241 litrů mléka** (25,67 Kč/l),  
  cca **803 kg chleba** (39,67 Kč/kg)

Kupní síla obyvatel tedy v tomto období **rostla**.

---

### 3. Která kategorie potravin zdražuje nejpomaleji?

Nejpomalejší průměrný meziroční růst cen měla **mouka hladká pšeničná** – průměrně pouze **1,4 % ročně**.  
Naopak nejrychleji zdražovalo například **máslo** – až **8,2 % ročně** v některých obdobích.

---

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než 10 %)?

**Ne**, v žádném sledovaném roce nebyl rozdíl mezi meziročním růstem cen a růstem mezd vyšší než **10 procentních bodů**.  
Například v roce 2008 byl růst cen **6,4 %**, zatímco růst mezd **4,9 %** → rozdíl pouze **1,5 pp**.

---

### 5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

Ve většině případů **růst HDP předcházel růstu mezd** (např. v letech 2014–2017).  
Například v roce 2015 vzrostl HDP o **4,5 %**, a v roce 2016 následoval růst mezd o **4,3 %**.  
Ceny potravin reagovaly méně výrazně a v některých letech zůstaly stabilní.

---

