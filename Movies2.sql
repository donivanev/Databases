SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;

SELECT name FROM moviestar JOIN starsin ON starname = name WHERE gender = 'F' AND movietitle = 'Terms of Endearment';

SELECT starname FROM starsin JOIN movie ON movietitle = title WHERE studioname = 'MGM' AND year = 1995;
