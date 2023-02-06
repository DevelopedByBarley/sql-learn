-- SELECT
--     select_expr [, select_expr] ...
--     [FROM table_references
--     [WHERE where_condition]
--     [GROUP BY]
--     [HAVING]
--     [ORDER BY {col_name | expr | position}
--       [ASC | DESC]
--     [LIMIT {[offset,] row_count | row_count OFFSET offset}]

--1.

SELECT name, licenseNumber FROM `cars`; -- Explicit rákereshetünk oszlopokra, nem kell mindent lekérdezni

SELECT name AS nev, licenseNumber AS rendszam FROM `cars` WHERE 1, --aliasolhatjuk is az oszlopokat ha így szeretnénk hogy megjelenjen.

--2. Az összes olyan járat , ami egy óránál tovább tartott (TRIPS táblára filterezés).

SELECT * FROM `trips` WHERE `numberOfMinutes` > 60


--3. Cars name ből való keresés LIKE%...% segítségével, leszűri az összes olyan oszlopra, amelyben a % közti érték megtalálható

SELECT * FROM `cars` WHERE `name` LIKE '%de%' -- %-ok előtt és után lehet bármi, a result setben benne lesz minden olyan autó neve, amelyben a "de" szerepel;

SELECT * FROM `cars` WHERE `name` LIKE 'Me%'; -- Ha csak a keresett tartalom után szúrunk be százalék jelet akkor csak azokat az oszlopokat dobja vissza amelyeknek úgy kezdődnek ahogy rákerestünk

--4. hourlyRate 2000 és 4000 között van

SELECT * FROM `cars` WHERE `hourlyRate` BETWEEN 2000 AND 4000

--5 Legrégebbi járat:

SELECT * FROM trips ORDER BY date ASC LIMIT 1 OFFSET 1; --ASC növekvő DESC csökkenő, limitálás 1., OFFSET = ELTOLJUK 1-EL

--6 A 2-es id-jü kocsi összes menetideje aggregálva

SELECT carId, SUM(numberOfMinutes) from trips GROUP BY carId HAVING carId = 2; -- Vegyük ki az összes carId, SUM(numberOfMinutes) = aggregálva a numberOfMinutes-t, mayd grouppoljuk carId alapján és csak azokat amiknél a carId = 2-vel. A heving olyan mint a where de itt a query végére kell tenni. 


------- MYSQL JOIN MÜVELET-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- Csak azok a járatok , amelyek 3000-nél nagyobb óradíjú kocsihoz tart

SELECT * FROM `trips` JOIN cars ON trips.carId = cars.id WHERE cars.hourlyRate > 3000 

--1 mindent kiválasztunk a trips táblából a carshoz joinolva
--2 trips.carId és cars.id-n át
--3 ahol cars.hourlyRate > 3000

-- A LEFT JOIN result set-ébe megtalálható a NULL érték is , viszont a sima JOIN-ba nem