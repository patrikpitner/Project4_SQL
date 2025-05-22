# Mezivýsledky projektu

## Vytvoření tabulek

### `t_patrik_pitner_project_SQL_primary_final`

- Vytvořena spojením průměrných ročních mezd (z `czechia_payroll`) a průměrných ročních cen potravin (z `czechia_price`).
- Data sjednocena na období **2006–2018**.
- Obsahuje: rok, průměrnou měsíční mzdu, kód a název kategorie potravin, průměrnou cenu potraviny.

### `t_patrik_pitner_project_SQL_secondary_final`

- Vytvořena výběrem evropských států z tabulek `economies` a `countries`.
- Obsahuje: rok, stát, **HDP**, **GINI index** a **populaci**.
- Filtrovány pouze státy s dostupnými údaji o HDP a populaci v letech **2006–2018**.

---

## Odpovědi na výzkumné otázky

### 1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?

> **Ne**, mzdy v některých odvětvích **meziročně klesly**.
- Například v roce **2012** klesla průměrná mzda v odvětví **"Ubytování a stravování"** z **20 123 Kč** na **19 845 Kč**, tj. pokles o **1,38 %**.
- Podobný pokles byl zaznamenán i v několika dalších odvětvích v letech 2011 a 2013.

📎 Viz [question_1.sql](./question_1.sql)

---

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za průměrnou mzdu?

- V roce **2006** bylo možné za průměrnou měsíční mzdu (**20 211 Kč**) koupit:
  - cca **956 litrů mléka** (průměrná cena mléka: 21,14 Kč),
  - cca **629 kg chleba** (průměrná cena chleba: 32,10 Kč).
  
- V roce **2018** to bylo za průměrnou mzdu (**31 868 Kč**):
  - cca **1 241 litrů mléka** (cena: 25,67 Kč),
  - cca **803 kg chleba** (cena: 39,67 Kč).

📎 Viz [question_2.sql](./question_2.sql)

---

### 3. Která kategorie potravin zdražuje nejpomaleji?

- Nejpomalejší průměrný meziroční růst cen měla **mouka hladká pšeničná** – průměrný růst byl pouze **1,4 % ročně**.
- Naopak nejrychleji zdražovalo např. máslo – až **8,2 % ročně** v některých obdobích.

📎 Viz [question_3.sql](./question_3.sql)

---

### 4. Existuje rok, kdy byl růst cen potravin výrazně vyšší než růst mezd (>10 %)?

> **Ne**, v žádném sledovaném roce nebyl rozdíl mezi růstem cen a růstem mezd vyšší než **10 procentních bodů**.
- Například v roce **2008** byl meziroční růst cen **6,4 %** a růst mezd **4,9 %**, tedy rozdíl pouze **1,5 pp**.

📎 Viz [question_4.sql](./question_4.sql)

---

### 5. Má růst HDP vliv na změny mezd a cen potravin?

- Ve většině případů **růst HDP předcházel růstu mezd**, zejména v letech 2014–2017.
- Např. v roce **2015** vzrostl HDP o **4,5 %**, na což v roce **2016** navázal růst mezd o **4,3 %**.
- **Ceny potravin reagují pomaleji** a méně přímočaře – v některých případech zůstaly téměř beze změny i při růstu HDP.

📎 Viz [question_5.sql](./question_5.sql)

---

## Poznámky k datům

- Data byla omezena na období **2006–2018** kvůli dostupnosti u všech zapojených tabulek.
- V některých letech chybí hodnoty pro méně sledované potraviny nebo státy s nedostupným HDP.
- Chybějící hodnoty byly ošetřeny pomocí `WHERE` filtrů a `JOIN` pouze na dostupná data.

---
