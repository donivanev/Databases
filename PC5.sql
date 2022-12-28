SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

-- 1.1 Напишете заявка, която извежда средната честота на процесорите на компютрите.

SELECT AVG(speed) AS Avg FROM pc;

/*
1.2 Напишете заявка, която за всеки производител извежда средния размер на екраните на неговите 
	лаптопи
*/

SELECT maker, AVG(screen) FROM laptop JOIN product ON laptop.model = product.model GROUP BY maker;

-- 1.3 Напишете заявка, която извежда средната честота на лаптопите с цена над 1000

SELECT AVG(speed) FROM laptop WHERE price > 1000;

-- 1.4 Напишете заявка, която извежда средната цена на компютрите, произведени от производител ‘A’

SELECT AVG(price) FROM pc JOIN product ON pc.model = product.model WHERE maker = 'A';

/*
1.5 Напишете заявка, която извежда средната цена на компютрите и лаптопите на производител ‘B’ 
	(едно число)
*/

SELECT AVG(price)
FROM
(
	SELECT price FROM product p JOIN pc ON p.model = pc.model WHERE maker = 'B'
	UNION ALL
	SELECT price FROM product p JOIN laptop l ON p.model = l.model WHERE maker = 'B'
) AllPrices;

/*
1.6 Напишете заявка, която извежда средната цена на компютрите според различните им честоти на 
	процесорите
*/

SELECT AVG(price) AS Avg FROM pc GROUP BY speed;

/*
1.7 Напишете заявка, която извежда производителите, които са произвели поне по 3 различни модела 
	компютъра
*/

SELECT maker FROM product WHERE type = 'PC' GROUP BY maker HAVING COUNT(*) >= 3;

-- 1.8 Напишете заявка, която извежда производителите на компютрите с най-висока цена

SELECT maker, MAX(PRICE) AS Max FROM product JOIN pc ON product.model = pc.model GROUP BY maker;

-- 1.9 Напишете заявка, която извежда средната цена на компютрите за всяка честота > 800 MHz

SELECT AVG(price) AS Avg FROM pc WHERE speed > 800; 

/*
1.10 Напишете заявка, която извежда средния размер на диска на тези компютри, произведени от 
	производители, които произвеждат и принтери
*/

SELECT AVG(hd) FROM (SELECT hd FROM pc JOIN product ON pc.model = product.model 
WHERE maker IN (SELECT maker FROM product WHERE type = 'Printer')) AllDisks;

/*
1.11 Напишете заявка, която за всеки размер на лаптоп намира разликата в цената на най-скъпия 
	и най-евтиния лаптоп със същия размер
*/

SELECT screen, MAX(price) - MIN(price) FROM laptop GROUP BY screen;
