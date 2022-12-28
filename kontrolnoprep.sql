--USE movies;
--SELECT * FROM movie;
--SELECT * FROM starsin;
--SELECT * FROM moviestar;
--SELECT * FROM movieexec;
--SELECT * FROM studio;
--USE pc;
--SELECT * FROM product;
--SELECT * FROM laptop;
--SELECT * FROM pc;
--SELECT * FROM printer;
--USE ships;
--SELECT * FROM classes;
--SELECT * FROM ships;
--SELECT * FROM outcomes;
--SELECT * FROM battles;

-- За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми. Включете и тези, за които няма информация в кои филми са играли

USE movies;
SELECT DISTINCT starname, COUNT(DISTINCT studioname) FROM starsin LEFT JOIN movie ON movietitle = title AND movieyear = year GROUP BY starname; 

-- Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3;

-- Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен компютър от даден модел

USE pc;
SELECT DISTINCT model, price FROM pc p WHERE price = (SELECT MAX(price) FROM pc WHERE model = p.model) ORDER BY price DESC;

-- Намерете броя на потъналите американски кораби за всяка проведена битка с поне един потънал американски кораб

USE ships;

SELECT battle, COUNT(ship) FROM outcomes JOIN ships ON ship = name JOIN classes ON ships.class = classes.class WHERE country = 'USA' AND result = 'sunk' 
GROUP BY battle HAVING COUNT(ship) >= 1;

-- Битките, в които са участвали поне 3 кораба на една и съща страна

SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON ships.class = classes.class GROUP BY battle, country HAVING COUNT(ship) >= 3;

-- Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., но имат пуснат поне един кораб

SELECT class FROM ships GROUP BY class HAVING MAX(launched) <= 1921;

/*
(*) За всеки кораб броя на битките, в които е бил увреден (result = ‘damaged’). 
Ако корабът не е участвал в битки или пък никога не е бил увреждан, в резултата да се вписва 0
*/

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged' GROUP BY name;

-- (*) Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили в битка (result = 'ok')

SELECT classes.class, COUNT(name) FROM classes JOIN ships ON classes.class = ships.class WHERE classes.class IN (SELECT class FROM ships JOIN outcomes ON name = ship 
WHERE result = 'ok' GROUP BY class HAVING COUNT(*) >= 3) GROUP BY classes.class; 

-- За всяка битка да се изведе името на битката, годината на битката и броят на потъналите кораби, броят на повредените кораби и броят на корабите без промяна

SELECT name, year(date), (SELECT COUNT(ship) FROM outcomes WHERE result = 'sunk'), (SELECT COUNT(ship) FROM outcomes WHERE result = 'damaged'),
(SELECT COUNT(ship) FROM outcomes WHERE result = 'ok') FROM battles;

-- (*) Намерете имената на битките, в които са участвали поне 3 кораба с под 9 оръдия и от тях поне два са с резултат ‘ok’

SELECT battle, COUNT(ship) FROM outcomes JOIN ships ON ship = name JOIN classes ON ships.class = classes.class WHERE numguns <= 9 GROUP BY battle HAVING COUNT(*) >= 3
AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2;



-----------------------------------------------------------------------------------------



--USE movies;
--SELECT * FROM movie;
--SELECT * FROM starsin;
--SELECT * FROM moviestar;
--SELECT * FROM movieexec;
--SELECT * FROM studio;
--USE pc;
--SELECT * FROM product;
--SELECT * FROM laptop;
--SELECT * FROM pc;
--SELECT * FROM printer;
USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл поне един актьор (актриса), чието име не съдържа нито буквата 'k', нито 'b'. 
Първо да се изведат най-старите филми
*/

USE movies;
SELECT DISTINCT title, year FROM movie JOIN starsin ON title = movietitle AND year = movieyear WHERE year = 1982 AND starname NOT LIKE '%k%' AND starname 
NOT LIKE '%b%' ORDER BY year;

/*
Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата година, от която е и филмът Terms of Endearment, но дължината им е по-малка 
или неизвестна
*/

SELECT title, length / 60 AS MovieLen FROM movie WHERE year = (SELECT year FROM movie WHERE title = 'Terms of Endearment') 
AND (length < (SELECT length FROM movie WHERE title = 'Terms of Endearment') OR length IS NULL);

-- Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм преди 1980 г. и поне един след 1985 г

SELECT name FROM movieexec JOIN movie ON cert# = producerc# WHERE name IN (SELECT starname FROM starsin) AND name IN
(SELECT starname FROM starsin WHERE movieyear < 1980) AND name IN (SELECT starname FROM starsin WHERE movieyear > 1985);

-- Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото студио

SELECT title FROM movie WHERE year < (SELECT MIN(year) FROM movie WHERE studioname = studioname AND incolor = 'y') AND incolor = 'n';

/*
Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди(1). Студиа, за които няма посочени филми или има, 
но не се знае кои актьори са играли в тях, също да бъдат изведени. Първо да се изведат студиата, работили с най-много звезди
(1) -> напр. ако студиото има два филма, като в първия са играли A, B и C, а във втория - C, D и Е, то студиото е работило с 5 звезди общо
*/

-- За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми

SELECT starname, COUNT(DISTINCT studioname) FROM starsin JOIN movie ON movietitle = title AND movieyear = year GROUP BY starname; 

-- За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми, включително и за тези, за които нямаме информация в какви филми са играли

SELECT name, COUNT(DISTINCT studioname) FROM moviestar JOIN starsin ON name = starname JOIN movie ON movietitle = title AND movieyear = year GROUP BY name;

-- Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3; 

-- Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен компютър от даден модел

USE pc;
SELECT model, MAX(price) FROM pc GROUP BY model;

/*
За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името на кораба и през коя година е пуснат на вода (launched). 
Резултатът да бъде сортиран така, че първо да се извеждат най-скоро пуснатите кораби
*/

USE ships;

-- Да се изведат имената на всички битки, в които е повреден (damaged) поне един японски кораб

SELECT battle FROM outcomes WHERE ship IN (SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'Japan') AND result = 'damaged';

/*
Да се изведат имената и класовете на всички кораби, пуснати на вода една година след кораба 'Rodney' и броят на оръдията им е по-голям от средния брой оръдия на 
класовете, произвеждани от тяхната страна
*/

SELECT name, classes.class FROM ships JOIN classes ON ships.class = classes.class WHERE launched >= (SELECT launched FROM ships WHERE name = 'Rodney') + 1
AND numguns > (SELECT AVG(numguns) FROM classes);

/*
Да се изведат американските класове, за които всички техни кораби са пуснати на вода в рамките на поне 10 години (например кораби от клас North Carolina са 
пускани в периода от 1911 до 1941, което е повече от 10 години, докато кораби от клас Tennessee са пуснати само през 1920 и 1921 г.)
*/

/*
За всяка битка да се изведе средният брой кораби от една и съща държава (например в битката при Guadalcanal са участвали 3 американски и един японски кораб, 
т.е. средният брой е 2)
*/

SELECT battle, COUNT(ship) FROM outcomes GROUP BY battle;

/*
За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в които е участвала; броя на битките, в които неин кораб е потънал ('sunk') 
(ако някоя отбройките е 0 – да се извежда 0)
*/

SELECT country, (SELECT COUNT(name) FROM ships), SUM(CASE result WHEN 'sunk' THEN 1 ELSE 0 END) FROM classes JOIN ships ON classes.class = ships.class 
JOIN outcomes ON name = ship GROUP BY country;

-- Изведете броя на потъналите американски кораби за всяка проведена битка с поне един потънал американски кораб

SELECT battle, COUNT(ship) FROM outcomes WHERE result = 'sunk' AND ship IN (SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'USA')
GROUP BY battle;

-- Битките, в които са участвали поне 3 кораба на една и съща страна

SELECT battle FROM outcomes JOIN ships ON ship = name GROUP BY battle HAVING COUNT(*) >= 3; 

-- Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., но имат пуснат поне един кораб

SELECT class FROM ships GROUP BY class HAVING MAX(launched) < 1921; 

-- (*) За всеки кораб намерете броя на битките, в които е бил увреден. Ако корабът не е участвал в битки или пък никога не е бил увреждан, в резултата да се вписва 0

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged' GROUP BY name;

-- (*) Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили в битка

SELECT classes.class, COUNT(name) FROM classes JOIN ships ON classes.class = ships.class JOIN outcomes ON name = ship WHERE result = 'ok' AND classes.class IN 
(SELECT classes.class FROM classes JOIN ships ON classes.class = ships.class GROUP BY classes.class HAVING COUNT(*) >= 3) GROUP BY classes.class;
