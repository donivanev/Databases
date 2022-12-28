SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;

/*
3.1 Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетна стойност, 
	по-голяма от 10 милиона.
*/
SELECT name FROM moviestar WHERE gender = 'F' AND name IN 
(SELECT name FROM movieexec WHERE networth > 10000000);

--3.2 Напишете заявка, която извежда имената на тези филмови звезди, които не са продуценти.

SELECT name FROM moviestar WHERE name NOT IN (SELECT name FROM movieexec);
