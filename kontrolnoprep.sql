--USE movies;
--SELECT * FROM movie;
--SELECT * FROM starsin;
--SELECT * FROM moviestar;
--SELECT * FROM movieexec;
--SELECT * FROM studio;
--USE pc;
--SELECT * FROM product;
--SELECT * FROM laptop;
--SELECT * FROM pc;
--SELECT * FROM printer;
--USE ships;
--SELECT * FROM classes;
--SELECT * FROM ships;
--SELECT * FROM outcomes;
--SELECT * FROM battles;

/*
�� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����. 
�������� � ����, �� ����� ���� ���������� � ��� ����� �� ������
*/

USE movies;
SELECT DISTINCT starname, COUNT(DISTINCT studioname) FROM starsin 
LEFT JOIN movie ON movietitle = title AND movieyear = year GROUP BY starname; 

-- �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year
WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3;

/*
�� �� ������� ���������� ������ ��������, ��������� �� ���� �� ���-������ ��������� �������� 
�� ����� �����
*/

USE pc;
SELECT DISTINCT model, price FROM pc p WHERE price = (SELECT MAX(price) FROM pc WHERE model = p.model) 
ORDER BY price DESC;

/*
�������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ���� ������� 
����������� �����
*/

USE ships;

SELECT battle, COUNT(ship) FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class WHERE country = 'USA' AND result = 'sunk' GROUP BY battle 
HAVING COUNT(ship) >= 1;

-- �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������

SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class GROUP BY battle, country HAVING COUNT(ship) >= 3;

/*
������� �� ���������, �� ����� ���� �����, ������ �� ���� ���� 1921 �., �� ���� ������ ���� 
���� �����
*/

SELECT class FROM ships GROUP BY class HAVING MAX(launched) <= 1921;

/*
(*) �� ����� ����� ���� �� �������, � ����� � ��� ������� (result = �damaged�). 
��� ������� �� � �������� � ����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0
*/

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged' 
GROUP BY name;

/*
(*) �������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, ����� �� �������� 
� ����� (result = 'ok')
*/

SELECT classes.class, COUNT(name) FROM classes JOIN ships ON classes.class = ships.class 
WHERE classes.class IN (SELECT class FROM ships JOIN outcomes ON name = ship WHERE result = 'ok' 
GROUP BY class HAVING COUNT(*) >= 3) GROUP BY classes.class; 

/*
�� ����� ����� �� �� ������ ����� �� �������, �������� �� ������� � ����� �� ���������� ������, 
����� �� ����������� ������ � ����� �� �������� ��� �������
*/

SELECT name, year(date), (SELECT COUNT(ship) FROM outcomes WHERE result = 'sunk'),
(SELECT COUNT(ship) FROM outcomes WHERE result = 'damaged'),
(SELECT COUNT(ship) FROM outcomes WHERE result = 'ok')
FROM battles;

/*
(*) �������� ������� �� �������, � ����� �� ��������� ���� 3 ������ � ��� 9 ������ � �� ��� ���� 
��� �� � �������� �ok�
*/

SELECT battle, COUNT(ship) FROM outcomes JOIN ships ON ship = name 
JOIN classes ON ships.class = classes.class WHERE numguns <= 9 GROUP BY battle HAVING COUNT(*) >= 3
AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2;




-----------------------------------------------------------------------------------------




--USE movies;
--SELECT * FROM movie;
--SELECT * FROM starsin;
--SELECT * FROM moviestar;
--SELECT * FROM movieexec;
--SELECT * FROM studio;
--USE pc;
--SELECT * FROM product;
--SELECT * FROM laptop;
--SELECT * FROM pc;
--SELECT * FROM printer;
USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
��� ���������� ���������� � �������� �� ������ �����, ������� ����� 1982, � ����� � ����� ���� 
���� ������ (�������), ����� ��� �� ������� ���� ������� 'k', ���� 'b'. 
����� �� �� ������� ���-������� �����
*/

USE movies;
SELECT DISTINCT title, year FROM movie JOIN starsin ON title = movietitle AND year = movieyear
WHERE year = 1982 AND starname NOT LIKE '%k%' AND starname NOT LIKE '%b%' ORDER BY year;

/*
���������� � ��������� � ������ (length � � ������) �� ������ �����, ����� �� �� ������ ������, 
�� ����� � � ������ Terms of Endearment, �� ��������� �� � ��-����� ��� ����������
*/

SELECT title, length / 60 AS MovieLen FROM movie 
WHERE year = (SELECT year FROM movie WHERE title = 'Terms of Endearment') 
AND (length < (SELECT length FROM movie WHERE title = 'Terms of Endearment') OR length IS NULL);


/*
������� �� ������ ����������, ����� �� � ������� ������ � �� ������ � ���� ���� ���� ����� 1980 �. 
� ���� ���� ���� 1985 �
*/

SELECT name FROM movieexec JOIN movie ON cert# = producerc# 
WHERE name IN (SELECT starname FROM starsin) AND 
name IN (SELECT starname FROM starsin WHERE movieyear < 1980) AND
name IN (SELECT starname FROM starsin WHERE movieyear > 1985);

-- ������ �����-���� �����, �������� ����� ���-������ ������ ���� (InColor='y'/'n') �� ������ ������

SELECT title FROM movie WHERE year < (SELECT MIN(year) FROM movie 
WHERE studioname = studioname AND incolor = 'y') AND incolor = 'n';

/*
������� � �������� �� ��������, ����� �� �������� � ��-����� �� 5 �������� ������� ������(1).
������, �� ����� ���� �������� ����� ��� ���, �� �� �� ���� ��� ������� �� ������ � ���, ����
�� ����� ��������. ����� �� �� ������� ��������, �������� � ���-����� ������

(1) -> ����. ��� �������� ��� ��� �����, ���� � ������ �� ������ A, B � C, � ��� ������ - C, D � �,
�� �������� � �������� � 5 ������ ����
*/

-- �� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����

SELECT starname, COUNT(DISTINCT studioname) FROM starsin JOIN movie 
ON movietitle = title AND movieyear = year GROUP BY starname; 


/*
�� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����, ����������� 
� �� ����, �� ����� ������ ���������� � ����� ����� �� ������
*/

SELECT name, COUNT(DISTINCT studioname) FROM moviestar 
JOIN starsin ON name = starname JOIN movie ON movietitle = title AND movieyear = year GROUP BY name;

-- �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year
WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3; 

/*
�� �� ������� ���������� ������ ��������, ��������� �� ���� �� ���-������ ��������� �������� 
�� ����� �����
*/

USE pc;
SELECT model, MAX(price) FROM pc GROUP BY model;

/*
�� ����� �����, ����� � �� ���� � ���, ����������� ������� i � k, �� �� ������ ����� �� ������ � 
���� ��� ������ � ������ �� ���� (launched). ���������� �� ���� �������� ����, �� ����� �� �� 
�������� ���-����� ��������� ������
*/

USE ships;

-- �� �� ������� ������� �� ������ �����, � ����� � �������� (damaged) ���� ���� ������� �����

SELECT battle FROM outcomes WHERE ship IN 
(SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'Japan') 
AND result = 'damaged';


/*
�� �� ������� ������� � ��������� �� ������ ������, ������� �� ���� ���� ������ ���� ������ 'Rodney'
� ����� �� �������� �� � ��-����� �� ������� ���� ������ �� ���������, ������������ �� ������� ������
*/

SELECT name, classes.class FROM ships JOIN classes ON ships.class = classes.class 
WHERE launched >= (SELECT launched FROM ships WHERE name = 'Rodney') + 1
AND numguns > (SELECT AVG(numguns) FROM classes);

/*
�� �� ������� ������������� �������, �� ����� ������ ����� ������ �� ������� �� ���� � ������� �� 
���� 10 ������ (�������� ������ �� ���� North Carolina �� ������� � ������� �� 1911 �� 1941, ����� 
� ������ �� 10 ������, ������ ������ �� ���� Tennessee �� ������� ���� ���� 1920 � 1921 �.)
*/



/*
�� ����� ����� �� �� ������ �������� ���� ������ �� ���� � ���� ������� (�������� � ������� ��� 
Guadalcanal �� ��������� 3 ����������� � ���� ������� �����, �.�. �������� ���� � 2)
*/

SELECT battle, COUNT(ship) FROM outcomes GROUP BY battle;

/*
�� ����� ������� �� �� ������: ����� �� �������� �� ���� �������; ���� �� �������, � ����� � ���������;
���� �� �������, � ����� ���� ����� � ������� ('sunk') (��� ����� ���������� � 0 � �� �� ������� 0)
*/

SELECT country, (SELECT COUNT(name) FROM ships), SUM(CASE result WHEN 'sunk' THEN 1 ELSE 0 END)
FROM classes JOIN ships ON classes.class = ships.class JOIN outcomes ON name = ship GROUP BY country;

/*
�������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ���� ������� 
����������� �����
*/

SELECT battle, COUNT(ship) FROM outcomes WHERE result = 'sunk' AND ship IN 
(SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'USA')
GROUP BY battle;

-- �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������

SELECT battle FROM outcomes JOIN ships ON ship = name GROUP BY battle HAVING COUNT(*) >= 3; 

/*
������� �� ���������, �� ����� ���� �����, ������ �� ���� ���� 1921 �., �� ���� ������ ���� ���� �����
*/

SELECT class FROM ships GROUP BY class HAVING MAX(launched) < 1921; 

/*
(*) �� ����� ����� �������� ���� �� �������, � ����� � ��� �������. ��� ������� �� � �������� � 
����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0
*/

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged'
GROUP BY name;

-- (*) �������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, ����� �� �������� � �����

SELECT classes.class, COUNT(name) FROM classes JOIN ships ON classes.class = ships.class 
JOIN outcomes ON name = ship WHERE result = 'ok' AND classes.class IN 
(SELECT classes.class FROM classes JOIN ships ON classes.class = ships.class 
GROUP BY classes.class HAVING COUNT(*) >= 3) GROUP BY classes.class;