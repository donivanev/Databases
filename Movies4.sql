SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;

/*
1.1 �������� ������, ����� �� ����� ����, ��-����� �� 120 ������, ������� ��������, ������, ��� 
	� ����� �� ������.
*/

SELECT title, year, name, address FROM movie JOIN studio ON studioname = name WHERE length > 120;

/*
1.2 �������� ������, ����� ������� ����� �� �������� � ������� �� ���������, ��������� ��� �����, 
	����������� �� ���� ������, ��������� �� ��� �� ������.
*/

SELECT studioname, starname FROM starsin JOIN movie ON movietitle = title
WHERE movietitle = studioname ORDER BY studioname;

-- 1.3 �������� ������, ����� ������� ������� �� ������������ �� �������, � ����� � ����� Harrison Ford.

SELECT DISTINCT producerc# FROM movie JOIN starsin ON title = movietitle AND year = movieyear 
WHERE starname = 'Harrison Ford';

-- 1.4 �������� ������, ����� ������� ������� �� ���������, ������ ��� ����� �� MGM.

SELECT DISTINCT starname FROM movie 
JOIN starsin ON title = movietitle AND year = movieyear 
JOIN moviestar ON starname = name
WHERE studioname = 'MGM' AND gender = 'F';

/*
1.5 �������� ������, ����� ������� ����� �� ���������� � ������� �� �������, ����������� �� ���������� 
	�� �Star Wars�.
*/

SELECT producerc#, title FROM movie
WHERE producerc# = (SELECT producerc# FROM movie WHERE title = 'Star Wars');

-- 1.6 �������� ������, ����� ������� ������� �� ���������, ����� �� �� ��������� � ���� ���� ����. 

SELECT NAME FROM moviestar LEFT JOIN starsin ON name = starname WHERE starname IS NULL;
--SELECT NAME FROM moviestar WHERE name NOT IN (SELECT starname FROM starsin);