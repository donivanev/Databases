SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

--3.1 Напишете заявка, която извежда името на корабите, по-тежки (displacement) от 35000.

SELECT name FROM ships JOIN classes ON classes.class = ships.class WHERE displacement > 35000;

/*
3.2 Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на всички кораби, 
	участвали в битката при Guadalcanal
*/
SELECT name, bore, numguns FROM outcomes JOIN ships ON ship = name 
JOIN classes ON ships.class = classes.class WHERE name = 'Guadalcanal';

/*
3.3 Напишете заявка, която извежда имената на тези държави, които имат класове кораби от тип 
	‘bb’ и ‘bc’ едновременно.
*/
SELECT country FROM classes JOIN ships ON classes.class = ships. class WHERE type = 'bb'
INTERSECT
SELECT country FROM classes JOIN ships ON classes.class = ships. class WHERE type = 'bc'

/*
3.4 Напишете заявка, която извежда имената на тези кораби, които са били повредени в една битка, 
	но по-късно са участвали в друга битка
*/
SELECT DISTINCT o1.ship FROM outcomes o1 
JOIN battles b1 ON o1.battle = b1.name
JOIN outcomes o2 ON o1.ship = o2.ship
JOIN battles b2 ON o2.battle = b2.name
WHERE o1.result = 'damaged' AND b1.date < b2.date;