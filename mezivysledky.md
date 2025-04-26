# Mezivýsledky projektu

## Vytvoření tabulek

### t_patrik_pitner_project_SQL_primary_final
- Vytvořena spojením průměrných ročních mezd (ze `czechia_payroll`) a průměrných ročních cen potravin (z `czechia_price`).
- Data sjednocena na období 2006–2018.
- Obsahuje: rok, průměrnou měsíční mzdu, kód kategorie potravin, průměrnou cenu potraviny.

### t_patrik_pitner_project_SQL_secondary_final
- Vytvořena výběrem evropských států z tabulek `economies` a `countries`.
- Obsahuje: rok, stát, HDP, GINI index a populaci.
- Filtrovány pouze státy s dostupnými údaji o HDP a populaci v letech 2006–2018.

---

## Odpovědi na výzkumné otázky

### 1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?
- Zkoumány průměrné mzdy po odvětvích a rocích.
- Výsledkem je seznam případů, kde mzda v některém odvětví poklesla oproti předchozímu roku.

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za průměrnou mzdu?
- Vypočítán počet litrů mléka a kilogramů chleba zakoupitelných za průměrnou mzdu v prvním a posledním dostupném roce.

### 3. Která kategorie potravin zdražuje nejpomaleji?
- Porovnán průměrný meziroční růst cen jednotlivých kategorií.
- Určena kategorie s nejnižším průměrným růstem cen.

### 4. Existuje rok, kdy byl růst cen potravin výrazně vyšší než růst mezd (>10 %) ?
- Porovnán meziroční růst cen potravin a mezd.
- Vyhledány roky, kdy byl rozdíl růstu vyšší než 10 procentních bodů.

### 5. Má růst HDP vliv na změny mezd a cen potravin?
- Porovnáno tempo růstu HDP, mezd a cen potravin v jednotlivých letech.
- Vyhodnoceno, zda existuje souvislost mezi rychlým růstem HDP a změnami ve mzdách a cenách.
