SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
3.1 Напишете заявка, която за всеки кораб извежда името му, държавата, броя оръдия и годината 
	на пускане (launched).
*/

SELECT name, country, bore, launched FROM ships JOIN classes ON ships.class = classes.class;

-- 3.2 Напишете заявка, която извежда имената на корабите, участвали в битка от 1942 г. 

SELECT DISTINCT ship FROM outcomes JOIN battles ON battle = name WHERE year(date) = 1942;
