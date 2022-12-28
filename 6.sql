USE movies;
SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;
SELECT * FROM movieexec;
SELECT * FROM studio;
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
��� ���������� ���������� � �������� �� ������ �����, ������� ����� 1982, � ����� � ����� ���� 
���� ������ (�������), ����� ��� �� ������� ���� ������� 'k', ���� 'b'. 
����� �� �� ������� ���-������� �����
*/

USE movies;
SELECT DISTINCT title, year, starname FROM movie LEFT JOIN starsin ON title = movietitle 
AND year = movieyear WHERE year = 1983 AND starname NOT LIKE '%k%' AND starname NOT LIKE '%b%' 
ORDER BY year;

/*
���������� � ��������� � ������ (length � � ������) �� ������ �����, ����� �� �� ������ ������, 
�� ����� � � ������ Terms of Endearment, �� ��������� �� � ��-����� ��� ����������
*/

SELECT title, length / 60.0 FROM movie WHERE year = 
(SELECT year FROM movie WHERE title = 'Terms of Endearment') 
AND length <= (SELECT length FROM movie WHERE title = 'Terms of Endearment') OR length IS NULL;

/*
������� �� ������ ����������, ����� �� � ������� ������ � �� ������ � ���� ���� ���� ����� 1980 �. 
� ���� ���� ���� 1985 �
*/

SELECT name FROM moviestar JOIN starsin ON name = starname WHERE name IN (SELECT name FROM movieexec)
AND movieyear < 1980; 
--AND movieyear > 1985

-- ������ �����-���� �����, �������� ����� ���-������ ������ ���� (InColor='y'/'n') �� ������ ������

SELECT title FROM movie m1 WHERE year < (SELECT MIN(year) FROM movie m2 WHERE incolor = 'y' 
AND m1.studioname = m2.studioname) AND incolor = 'n';

/*
������� � �������� �� ��������, ����� �� �������� � ��-����� �� 5 �������� ������� ������(1).
������, �� ����� ���� �������� ����� ��� ���, �� �� �� ���� ��� ������� �� ������ � ���, ����
�� ����� ��������. ����� �� �� ������� ��������, �������� � ���-����� ������

(1) -> ����. ��� �������� ��� ��� �����, ���� � ������ �� ������ A, B � C, � ��� ������ - C, D � �,
�� �������� � �������� � 5 ������ ����
*/



/*
�� ����� �����, ����� � �� ���� � ���, ����������� ������� i � k, �� �� ������ ����� �� ������ � 
���� ��� ������ � ������ �� ���� (launched). ���������� �� ���� �������� ����, �� ����� �� �� 
�������� ���-����� ��������� ������
*/

USE ships;
SELECT name, launched FROM ships JOIN classes ON ships.class = classes.class 
WHERE classes.class NOT LIKE '%i%' AND classes.class NOT LIKE '%k%' ORDER BY launched DESC;

-- �� �� ������� ������� �� ������ �����, � ����� � �������� (damaged) ���� ���� ������� �����

SELECT name FROM battles JOIN outcomes ON name = battle WHERE result = 'damaged'
AND ship IN (SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'Japan'); 

/*
�� �� ������� ������� � ��������� �� ������ ������, ������� �� ���� ���� ������ ���� ������ 'Rodney'
� ����� �� �������� �� � ��-����� �� ������� ���� ������ �� ���������, ������������ �� ������� ������
*/

SELECT name, ships.class FROM ships JOIN classes c1 ON ships.class = c1.class
WHERE launched = (SELECT launched FROM ships WHERE name = 'Rodney') + 1
AND numguns > (SELECT AVG(numguns) FROM classes c2 WHERE c1.country = c2.country);

/*
�� �� ������� ������������� �������, �� ����� ������ ����� ������ �� ������� �� ���� � ������� �� 
���� 10 ������ (�������� ������ �� ���� North Carolina �� ������� � ������� �� 1911 �� 1941, ����� 
� ������ �� 10 ������, ������ ������ �� ���� Tennessee �� ������� ���� ���� 1920 � 1921 �.)
*/

SELECT DISTINCT classes.class FROM classes JOIN ships ON classes.class = ships.class;
--WHERE country = 'USA' AND launched >= ();

--SELECT name FROM ships WHERE launched ;

/*
�� ����� ����� �� �� ������ �������� ���� ������ �� ���� � ���� ������� (�������� � ������� ��� 
Guadalcanal �� ��������� 3 ����������� � ���� ������� �����, �.�. �������� ���� � 2)
*/

--SELECT AVG(name) FROM ships JOIN outcomes ON name = ship JOIN classes ON ships.class = classes.class
--WHERE country = 'USA' OR country = 'Japan' GROUP BY battle HAVING COUNT(name) = 3 OR COUNT(name) = 1;

/*
�� ����� ������� �� �� ������: ����� �� �������� �� ���� �������; ���� �� �������, � ����� � ���������;
���� �� �������, � ����� ���� ����� � ������� ('sunk') (��� ����� �� �������� � 0 � �� �� ������� 0)
*/

SELECT country, COUNT(name) AS ShipsCount FROM ships RIGHT JOIN classes ON ships.class = classes.class 
GROUP BY country; 

SELECT country, COUNT(battle) AS BattlesCount FROM outcomes JOIN ships ON ship = name 
RIGHT JOIN classes ON ships.class = classes.class GROUP BY country; 

SELECT country, COUNT(battle) FROM outcomes JOIN ships ON ship = name RIGHT JOIN classes ON
ships.class = classes.class AND result = 'sunk' GROUP BY country;

-- �� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����

USE movies;
SELECT starname, COUNT(DISTINCT studioname) FROM starsin JOIN movie ON movietitle = title AND
movieyear = year GROUP BY starname; 

/*
�� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����, ����������� 
� �� ����, �� ����� ������ ���������� � ����� ����� �� ������
*/

SELECT name, COUNT(DISTINCT studioname) FROM starsin LEFT JOIN movie ON movietitle = title AND
movieyear = year RIGHT JOIN moviestar ON starname = name GROUP BY name;

-- �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year
WHERE starname IN (SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year 
GROUP BY starname HAVING COUNT(*) >= 3) AND year > 1990 GROUP BY starname;

/*
�� �� ������� ���������� ������ ��������, ��������� �� ���� �� ���-������ ��������� �������� 
�� ����� �����
*/

USE pc;
SELECT pc.model, MAX(price) as Max FROM pc JOIN product ON pc.model = product.model 
GROUP BY pc.model ORDER BY Max DESC;

/*
�������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ���� ������� 
����������� �����
*/

USE ships;
SELECT battle, COUNT(ship) FROM outcomes WHERE result = 'sunk' AND ship IN 
(SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'USA')
GROUP BY battle;

-- �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������

SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON
ships.class = classes.class GROUP BY battle HAVING COUNT(*) >= 3;

/*
������� �� ���������, �� ����� ���� �����, ������ �� ���� ���� 1921 �., �� ���� ������ ���� ���� �����
*/

SELECT DISTINCT classes.class FROM classes JOIN ships ON classes.class = ships.class WHERE
launched <= 1921 AND classes.class IN
(SELECT classes.class FROM ships JOIN classes ON ships.class = classes.class);

/*
(*) �� ����� ����� �������� ���� �� �������, � ����� � ��� �������. ��� ������� �� � �������� � 
����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0
*/

SELECT name, COUNT(battle) FROM ships LEFT JOIN outcomes ON name = ship AND result = 'damaged' 
GROUP BY name;   

-- (*) �������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, ����� �� �������� � �����

SELECT classes.class, COUNT(name) FROM classes JOIN ships ON classes.class = ships.class
JOIN outcomes ON name = ship WHERE classes.class IN (SELECT DISTINCT classes.class FROM classes 
JOIN ships ON classes.class = ships.class GROUP BY classes.class HAVING COUNT(*) >= 3)
AND result = 'ok' GROUP BY classes.class;
