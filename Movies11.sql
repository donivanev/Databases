USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

GO
CREATE VIEW names_and_birthdates AS SELECT name, birthdate FROM moviestar WHERE gender = 'F';
GO

SELECT * FROM names_and_birthdates;

GO
CREATE VIEW stars_and_movies AS SELECT starname, COUNT(title) AS MoviesCount FROM starsin JOIN movie ON movietitle = title AND movieyear = year GROUP BY starname; 
GO

SELECT * FROM stars_and_movies;
