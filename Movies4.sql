SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;

/*
1.1 Напишете заявка, която за всеки филм, по-дълъг от 120 минути, извежда заглавие, година, име 
	и адрес на студио.
*/

SELECT title, year, name, address FROM movie JOIN studio ON studioname = name WHERE length > 120;

/*
1.2 Напишете заявка, която извежда името на студиото и имената на актьорите, участвали във филми, 
	произведени от това студио, подредени по име на студио.
*/

SELECT studioname, starname FROM starsin JOIN movie ON movietitle = title
WHERE movietitle = studioname ORDER BY studioname;

-- 1.3 Напишете заявка, която извежда имената на продуцентите на филмите, в които е играл Harrison Ford.

SELECT DISTINCT producerc# FROM movie JOIN starsin ON title = movietitle AND year = movieyear 
WHERE starname = 'Harrison Ford';

-- 1.4 Напишете заявка, която извежда имената на актрисите, играли във филми на MGM.

SELECT DISTINCT starname FROM movie 
JOIN starsin ON title = movietitle AND year = movieyear 
JOIN moviestar ON starname = name
WHERE studioname = 'MGM' AND gender = 'F';

/*
1.5 Напишете заявка, която извежда името на продуцента и имената на филмите, продуцирани от продуцента 
	на ‘Star Wars’.
*/

SELECT producerc#, title FROM movie
WHERE producerc# = (SELECT producerc# FROM movie WHERE title = 'Star Wars');

-- 1.6 Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм. 

SELECT NAME FROM moviestar LEFT JOIN starsin ON name = starname WHERE starname IS NULL;
--SELECT NAME FROM moviestar WHERE name NOT IN (SELECT starname FROM starsin);