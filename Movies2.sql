SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;

--1.1 Напишете заявка, която извежда имената на актрисите, участвали в Terms of Endearment.
SELECT name FROM moviestar JOIN starsin ON starname = name WHERE gender = 'F' AND 
movietitle = 'Terms of Endearment';

/*
1.2 Напишете заявка, която извежда имената на филмовите звезди, участвали във филми на студио 
	MGM през 1995 г
*/
SELECT starname FROM starsin JOIN movie ON movietitle = title WHERE studioname = 'MGM' AND year = 1995;



