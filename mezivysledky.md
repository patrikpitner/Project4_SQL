# Průvodní listina – Mezivýsledky a poznámky k výstupu

## Mezivýsledky a kontrola dat

### ✅ Primární tabulka (ČR)
- Roky s dostupnými mzdami: 2000–2021
- Roky, kdy byly dostupné zároveň ceny mléka i chleba: 2006–2018
- Výsledná primární tabulka tedy pokrývá období **2006–2018**

### ✅ Sekundární tabulka (EU státy)
- Roky: 2006–2018
- Pouze státy s dostupnými hodnotami `gdp` a `population`
- GINI index může být v některých případech `NULL`

## Transformace a přístup k datům
- Všechna data jsou transformována až v nových tabulkách (`t_patrik_pitner_...`)
- Primární datové tabulky zůstaly **nezměněny**, v souladu se zadáním
- Použity `TEMP TABLE`, lze přepsat na trvalé odstraněním `TEMP`

## Výstupní kontroly
- Počet záznamů v primární tabulce: 13 (odpovídá 2006–2018)
- Výsledky odpovídají zadání a ověřeným datům
