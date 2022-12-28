SELECT * FROM dbo.BATTLES;
SELECT * FROM dbo.CLASSES;
SELECT * FROM dbo.OUTCOMES;
SELECT * FROM dbo.SHIPS;

/*
3.1 Напишете заявка, която извежда името на класа и държавата за всички класове с брой на оръдията, 
	по-малък от 10
*/

SELECT class, country FROM dbo.CLASSES WHERE numguns < 10;

/*
3.2 Напишете заявка, която извежда имената на всички кораби, пуснати на вода преди 1918. 
	Задайте псевдоним на колоната shipName
*/

SELECT name as shipname FROM dbo.SHIPS WHERE launched < 1918;

/*
3.3 Напишете заявка, която извежда имената на корабите, потънали в битка, и имената на битките, 
	в които са потънали
*/

SELECT ship, battle FROM dbo.OUTCOMES WHERE result = 'sunk';

--3.4 Напишете заявка, която извежда имената на корабите с име, съвпадащо с името на техния клас

SELECT name FROM dbo.SHIPS WHERE name = class;

--3.5 Напишете заявка, която извежда имената на всички кораби, започващи с буквата R

SELECT name FROM dbo.SHIPS WHERE name LIKE 'R%';

--3.6 Напишете заявка, която извежда имената на всички кораби, чието име е съставено от точно две думи
SELECT name FROM dbo.SHIPS WHERE name LIKE '% %' AND name NOT LIKE '% % %';
