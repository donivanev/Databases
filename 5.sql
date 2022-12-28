--USE movies;
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
�� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����. 
�������� � ����, �� ����� ���� ���������� � ��� ����� �� ������
*/

USE movies;
SELECT starname, COUNT(name) as Count FROM studio JOIN movie ON name = studioname JOIN starsin ON 
title = movietitle AND year = movieyear GROUP BY starname;

-- �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

SELECT starname FROM starsin JOIN movie ON movietitle = title AND movieyear = year 
WHERE movieyear > 1990 GROUP BY starname HAVING COUNT(*) >= 3; 

/*
�� �� ������� ���������� ������ ��������, ��������� �� ���� �� ���-������ ��������� �������� 
�� ����� �����
*/

USE pc;
SELECT model, MAX(price) as Max FROM pc GROUP BY model ORDER BY Max DESC;

/*
�������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ���� ������� 
����������� �����
*/

USE ships;
SELECT battle, COUNT(name) FROM ships JOIN outcomes ON name = ship JOIN classes ON 
ships.class = classes.class WHERE country = 'USA' AND result = 'sunk' GROUP BY battle;

-- �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������

USE ships;
--��� ������ ���� ���� ����� - ����� �� �� ������ ���� �� ships
SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class GROUP BY battle HAVING COUNT(*) >= 3;

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

SELECT class, COUNT(name) as Count FROM ships JOIN outcomes ON name = ship WHERE class IN
(SELECT classes.class FROM classes JOIN ships ON classes.class = ships.class 
GROUP BY classes.class HAVING COUNT(*) >= 3) AND result = 'ok' GROUP BY class; 

SELECT class, COUNT(DISTINCT ship) -- ���������� ���, ��� ����� ����� � ��� ok � ������� �����
FROM ships
LEFT JOIN outcomes ON name = ship AND result = 'ok'
GROUP BY class
HAVING COUNT(DISTINCT name) >= 3; -- ���������� ���, ��� ����� ����� � ��� ok � ������� �����

/*
�� ����� ����� �� �� ������ ����� �� �������, �������� �� ������� � ����� �� ���������� ������, 
����� �� ����������� ������ � ����� �� �������� ��� �������
*/

SELECT DISTINCT name, year(date),
(SELECT COUNT(ship) FROM outcomes WHERE result = 'sunk') as Sunk,
(SELECT COUNT(ship) FROM outcomes WHERE result = 'damaged') as Damaged,
(SELECT COUNT(ship) FROM outcomes WHERE result = 'ok') as Ok
FROM battles JOIN outcomes ON name = battle GROUP BY name, date;

/*
(*) �������� ������� �� �������, � ����� �� ��������� ���� 3 ������ � ��� 9 ������ � �� ��� ���� 
��� �� � �������� �ok�
*/

USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;

SELECT DISTINCT battle FROM outcomes JOIN ships ON ship = name JOIN classes ON 
ships.class = classes.class WHERE numguns < 9 GROUP BY battle HAVING COUNT(ship) >= 3 
AND SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) >= 2; 
