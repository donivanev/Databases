USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

-- 1.�������� ������, ����� ������� ������� � ��������� ���� �� ������ �������.

GO
CREATE VIEW names_and_birthdates AS SELECT name, birthdate FROM moviestar WHERE gender = 'F';
GO

SELECT * FROM names_and_birthdates;

/*
2. �������� ������, ����� �� ����� ������� ������ ������� ���� �� �������, � ����� �� � �������. 
   ��� �� ������ ������ �� ����� ����� ����� ���, �� ��� �� �� ������ 0.
*/

GO
CREATE VIEW stars_and_movies AS SELECT starname, COUNT(title) AS MoviesCount FROM starsin JOIN movie ON 
movietitle = title AND movieyear = year GROUP BY starname; 
GO

SELECT * FROM stars_and_movies;

-- 3. ������: ������� ������� ���������� �� �����������? - 