--USE movies;
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
За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми. 
Включете и тези, за които няма информация в кои филми са играли
*/

USE movies;
SELECT starname, COUNT(name) as Count FROM studio JOIN movie ON name = studioname JOIN starsin ON 
title = movietitle AND year = movieyear GROUP BY starname;

-- Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year 
WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3; 

/*
Да се изведат различните модели компютри, подредени по цена на най-скъпия конкретен компютър 
от даден модел
*/

USE pc;
SELECT model, MAX(price) as Max FROM pc GROUP BY model ORDER BY Max DESC;

/*
Намерете броя на потъналите американски кораби за всяка проведена битка с поне един потънал 
американски кораб
*/

USE ships;
SELECT battle, COUNT(name) FROM ships JOIN outcomes ON name = ship JOIN classes ON 
ships.class = classes.class WHERE country = 'USA' AND result = 'sunk' GROUP BY battle;

-- Битките, в които са участвали поне 3 кораба на една и съща страна

USE ships;
--има пуснат поне един кораб - можем да го вземем само от ships
SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class GROUP BY battle HAVING COUNT(*) >= 3;

/*
Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., но имат пуснат поне 
един кораб
*/

SELECT class FROM ships GROUP BY class HAVING MAX(launched) <= 1921;

/*
(*) За всеки кораб броя на битките, в които е бил увреден (result = ‘damaged’). 
Ако корабът не е участвал в битки или пък никога не е бил увреждан, в резултата да се вписва 0
*/

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged' 
GROUP BY name;

/*
(*) Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили 
в битка (result = 'ok')
*/

SELECT class, COUNT(name) as Count FROM ships JOIN outcomes ON name = ship WHERE class IN
(SELECT classes.class FROM classes JOIN ships ON classes.class = ships.class 
GROUP BY classes.class HAVING COUNT(*) >= 3) AND result = 'ok' GROUP BY class; 

SELECT class, COUNT(DISTINCT ship) -- повторения има, ако даден кораб е бил ok в няколко битки
FROM ships
LEFT JOIN outcomes ON name = ship AND result = 'ok'
GROUP BY class
HAVING COUNT(DISTINCT name) >= 3; -- повторения има, ако даден кораб е бил ok в няколко битки

/*
За всяка битка да се изведе името на битката, годината на битката и броят на потъналите кораби, 
броят на повредените кораби и броят на корабите без промяна
*/

SELECT DISTINCT name, year(date),
(SELECT COUNT(ship) FROM outcomes WHERE result = 'sunk') as Sunk,
(SELECT COUNT(ship) FROM outcomes WHERE result = 'damaged') as Damaged,
(SELECT COUNT(ship) FROM outcomes WHERE result = 'ok') as Ok
FROM battles JOIN outcomes ON name = battle GROUP BY name, date;

/*
(*) Намерете имената на битките, в които са участвали поне 3 кораба с под 9 оръдия и от тях поне 
два са с резултат ‘ok’
*/

USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;

SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class WHERE numguns < 9 GROUP BY battle HAVING COUNT(ship) >= 3 
AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2; 
