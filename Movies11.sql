USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

-- 1.Създайте изглед, който извежда имената и рождените дати на всички актриси.

GO
CREATE VIEW names_and_birthdates AS SELECT name, birthdate FROM moviestar WHERE gender = 'F';
GO

SELECT * FROM names_and_birthdates;

/*
2. Създайте изглед, който за всяка филмова звезда извежда броя на филмите, в които се е снимала. 
   Ако за дадена звезда не знаем какви филми има, за нея да се изведе 0.
*/

GO
CREATE VIEW stars_and_movies AS SELECT starname, COUNT(title) AS MoviesCount FROM starsin JOIN movie ON 
movietitle = title AND movieyear = year GROUP BY starname; 
GO

SELECT * FROM stars_and_movies;

-- 3. Въпрос: горните изгледи позволяват ли модификации? - 