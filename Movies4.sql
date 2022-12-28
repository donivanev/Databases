SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;

SELECT title, year, name, address FROM movie JOIN studio ON studioname = name WHERE length > 120;

SELECT studioname, starname FROM starsin JOIN movie ON movietitle = title WHERE movietitle = studioname ORDER BY studioname;

SELECT DISTINCT producerc# FROM movie JOIN starsin ON title = movietitle AND year = movieyear WHERE starname = 'Harrison Ford';

SELECT DISTINCT starname FROM movie JOIN starsin ON title = movietitle AND year = movieyear JOIN moviestar ON starname = name WHERE studioname = 'MGM' AND gender = 'F';

SELECT producerc#, title FROM movie WHERE producerc# = (SELECT producerc# FROM movie WHERE title = 'Star Wars');

SELECT NAME FROM moviestar LEFT JOIN starsin ON name = starname WHERE starname IS NULL;
--SELECT NAME FROM moviestar WHERE name NOT IN (SELECT starname FROM starsin);
