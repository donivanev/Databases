SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

-- 2.1 Напишете заявка, която извежда броя на класовете кораби

SELECT COUNT(class) FROM classes;

/*
2.2 Напишете заявка, която извежда средния брой на оръдията (numguns) за всички кораби, 
	пуснати на вода (т.е. изброени са в таблицата Ships)
*/

SELECT AVG(numguns) FROM ships JOIN classes ON ships.class = ships.class; 

/*
2.3 Напишете заявка, която извежда за всеки клас първата и последната година, в която кораб от 
	съответния клас е пуснат на вода
*/

SELECT class, MIN(launched) AS FirstYear, MAX(launched) AS LastYear FROM ships GROUP BY class;

-- 2.4 Напишете заявка, която за всеки клас извежда броя на корабите, потънали в битка

SELECT class, COUNT(name) as Count FROM ships JOIN outcomes ON ships.name = outcomes.ship 
WHERE result = 'sunk' GROUP BY class;

/*
2.5 Напишете заявка, която за всеки клас с над 4 пуснати на вода кораба извежда броя на корабите, 
	потънали в битка
*/

SELECT class, COUNT(name) FROM ships JOIN outcomes ON ships.name = outcomes.ship
where result = 'sunk' AND class IN (SELECT class FROM ships GROUP BY class HAVING count(*) > 4)
GROUP BY class;


-- 2.6 Напишете заявка, която извежда средното тегло на корабите (displacement) за всяка страна

SELECT AVG(DISPLACEMENT) as Avg FROM classes GROUP BY Country;
