SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;

SELECT name FROM moviestar WHERE gender = 'F' AND name IN (SELECT name FROM movieexec WHERE networth > 10000000);

SELECT name FROM moviestar WHERE name NOT IN (SELECT name FROM movieexec);
