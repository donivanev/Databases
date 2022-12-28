SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

--3.1 Напишете заявка, която извежда страните, чиито класове кораби са с най-голям брой оръдия.

SELECT DISTINCT country FROM classes WHERE numguns >= ALL(SELECT numguns FROM classes);

--3.2 Напишете заявка, която извежда имената на корабите с 16-инчови оръдия (bore).

SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE bore = 16;

--3.3 Напишете заявка, която извежда имената на битките, в които са участвали кораби от клас ‘Kongo’.

SELECT battle FROM outcomes JOIN ships ON outcomes.ship = ships.name 
JOIN classes ON ships.class = classes.class WHERE classes.class = 'Kongo';

/*
3.4 Напишете заявка, която извежда имената на корабите, чиито брой оръдия е най-голям в сравнение с
	корабите със същия калибър оръдия (bore).
*/

SELECT name FROM ships JOIN classes c ON ships.class = c.class 
WHERE numguns >= ALL(SELECT numguns FROM classes WHERE bore = c.bore);