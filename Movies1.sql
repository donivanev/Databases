SELECT * FROM dbo.MOVIE;
SELECT * FROM dbo.MOVIEEXEC;
SELECT * FROM dbo.MOVIESTAR;
SELECT * FROM dbo.STARSIN;
SELECT * FROM dbo.STUDIO;

-- 1.1 Напишете заявка, която извежда адреса на студио ‘MGM’

SELECT address FROM dbo.STUDIO WHERE name = 'MGM';

-- 1.2 Напишете заявка, която извежда рождената дата на актрисата Sandra Bullock

SELECT birthdate FROM dbo.MOVIESTAR WHERE name = 'Sandra Bullock';

/*
1.3 Напишете заявка, която извежда имената на всички филмови звезди, които са участвали във филм 
      през 1980, в заглавието на които има думата ‘Empire’ 
*/

SELECT starname FROM dbo.STARSIN WHERE movieyear = 1980 AND movietitle LIKE 'Empire%';

/*
1.4 Напишете заявка, която извежда имената на всички изпълнители на филми с нетна стойност над 
10 000 000 долара
*/

SELECT * FROM dbo.MOVIEEXEC WHERE networth > 10000000;

-- 1.5 Напишете заявка, която извежда имената на всички актьори, които са мъже или живеят в Malibu

SELECT name FROM dbo.MOVIESTAR WHERE gender = 'M' OR address = '%Malibu%';