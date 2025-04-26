# Výstupní data

## t_patrik_pitner_project_SQL_primary_final
- Tabulka obsahuje data o průměrných měsíčních mzdách a průměrných cenách potravin v České republice.
- Data jsou agregována na roční úroveň.
- Období: 2006–2018.
- Zdrojová data:
  - Průměrné mzdy: `czechia_payroll` (hodnota typu průměrná měsíční mzda - value_type_code 5958).
  - Průměrné ceny potravin: `czechia_price`.
- Transformace:
  - Výpočet průměrné roční ceny a průměrné roční mzdy.
  - Spojení dat podle roku.

## t_patrik_pitner_project_SQL_secondary_final
- Tabulka obsahuje ekonomické ukazatele evropských států.
- Data jsou převzata z tabulek `economies` a `countries`.
- Období: 2006–2018.
- Obsahuje:
  - Rok
  - Stát
  - Hrubý domácí produkt (HDP)
  - GINI index
  - Populaci
- Transformace:
  - Výběr pouze evropských států.
  - Odstranění záznamů s chybějícími hodnotami HDP nebo populace.

## Poznámky k výstupním datům

### Primární tabulka
- Ceny mléka a chleba nebyly dostupné pro roky před rokem 2006 → roky před 2006 vynechány.
- Roky po 2018 vynechány z důvodu nekompletních cenových údajů.

### Sekundární tabulka
- GINI index není dostupný ve všech státech každoročně (ponecháno jako NULL).
- Počet států s kompletními daty se pohybuje mezi 64 až 83 ročně.
