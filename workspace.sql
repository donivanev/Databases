--������ �� ��������� = ����� �� ���������
--SELECT * FROM printer where price >= ALL(SELECT price FROM printer);

--SELECT TOP 1 * FROM printer ORDER BY price DESC;
--in MySQL, TOP = LIMIT

USE ships; --����� �������� ��� ����������� �������

SELECT DISTINCT class FROM outcomes JOIN ships on ship = name WHERE result = 'sunk';
--NO -> SELECT DISTINCT class FROM outcomes JOIN ships on ship = name WHERE result != 'sunk'

--INSTEAD
SELECT class FROM classes WHERE class NOT IN 
(SELECT DISTINCT class FROM outcomes JOIN ships ON ship = name WHERE result = 'sunk');

SELECT * FROM classes WHERE EXISTS (SELECT * FROM ships);

/*
SELECT * FROM database;

AS - ������ ���������
DISTINCT - �������� ������������

UNION - ��������� 2 ������ ���� �������� ������������
UNION ALL - ��� ������ �� ������� ������������
UNION, INTERSECT, EXCEPT

s IN (list) -> ����� TRUE, ��� s � ���� ���������� �� ������� list
s NOT IN (list) -> ����� TRUE, ��� s �� � ���� ���������� �� ������� list
s > ALL(list) -> ����� TRUE, ��� s � ��-����� �� ������ �������� �� ������� list
s > ANY(list) -> ����� TRUE, ��� s � ��-����� �� ���� ���� �� ���������� �� ������� 

��� ��������� ��� FROM �������� ������������ ������ �� ������ ��� �� ���������, ���� � �� �� �� ��������
SELECT movietitle, starname, birthdate FROM starsin, (SELECT name, birthdate FROM moviestar
WHERE gender = 'F') Actresses WHERE starname = name;

����������� ��������� - ���������, ����� �������� ��������� �� �������� ������
SELECT DISTINCT title FROM movie m WHERE year < ANY (SELECT year FROM movie WHERE title = m.title);

CROSS JOIN - ��������� ������������
(INNER) JOIN - ������� �� �������
NATURAL JOIN - ���������� �� ������� ��� ������ ������ �������� // �� �� �������� � MSSQL
LEFT (OUTER) JOIN - ���� �������, INNER JOIN + ������ ������ �� ������ �������, ����� �� ����� 
���������� �� ������ �������
RIGHT (OUTER) JOIN - ����� �������, INNER JOIN + ������ ������ �� ������� �������, ����� �� ����� 
���������� �� ������� �������
FULL (OUTER) JOIN - ��������� ������ ������ �� ����� �������, UNION

COALESCE(...) - �������� ��������� � ����� ������� ����� � �������� �� NULL
			  - �������� NULL �����������

������ ��� �������� ���� �� ���� �� ��� NULL

!!!
������ � ���� ������ ��� ������ �� ���� �������� JOIN � ���� ���� �� ��� � OUTER JOIN, 
����� �� ����������� �� ��� ��������. ��� �� ���� INNER JOIN � ����
!!!

!!!
��� LEFT JOIN ��������
	� ON, ��� ����� ������� �� ������� �������
	� WHERE, ��� ����� ������� �� ������, ����. �������, ��������� � "X"
!!!

WHERE - ��������� �������� ��������

��� INNER JOIN ���� �������� ��� �� ����� ������ � ���� � ���� ����� �� ������

AVG, COUNT (���� � *), MAX, MIN, GROUP BY, HAVING
COUNT(*) - ���� ������ ������
COUNT(DISTINCT column) - ���� �������� � �������� ����������� ��

�� ����� �� ���������� ��������� ������� � WHERE

��� GROUP BY � ORDER BY ����� �� ���������� ���� �������� �� ����� ��������� � ��������� �������

� SELECT ����� ������ �� ����� ��� JOIN-����

The (INNER) JOIN keyword selects records that have matching values in both tables.

The LEFT JOIN keyword returns all records from the left table (table1), and the matching records 
from the right table (table2). 
The result is 0 records from the right side, if there is no match.

The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records 
from the left table (table1). 
The result is 0 records from the left side, if there is no match.

The FULL (OUTER) JOIN keyword returns all records when there is a match in left (table1) or 
right (table2) table records.

��� �� ���������� �� ���������:

FROM ...
... JOIN ... ON ...
WHERE ...
GROUP BY ...
HAVING ...
SELECT ...
ORDER BY ...

��������� ������ ���������:

���������� �� ��� ���� X ������ -> GROUP BY ... HAVING(*) >= X
��� �� � � ���������� ��� �� ������������� ��������� �� �� ������ 0 -> LEFT JOIN + ON ... AND ...
���������� � JOIN JOIN ... RIGHT JOIN, �.�. ���� ��������� �� � ����� �� �� ������ �������� ���������
� ��-������ �� ... �� ����� � �� � ... -> > ALL()
�� �����/����� -> GROUP BY

UNION - ��������� 2 ������ ���� �������� ������������
UNION ALL - ��� ������ �� ������� ������������

��� ��������� ��� FROM �������� ������������ ������ �� ������ ��� �� ���������, ���� � �� �� �� ��������
SELECT movietitle FROM starsin, (SELECT name, birthdate FROM moviestar WHERE gender = 'F') Actresses;

����������� ��������� - ���������, ����� �������� ��������� �� �������� ������
SELECT DISTINCT title FROM movie m WHERE year < ANY (SELECT year FROM movie WHERE title = m.title);

������ � ���� ������ ��� ������ �� ���� �������� JOIN � ���� ���� �� ��� � OUTER JOIN, 
����� �� ����������� �� ��� ��������. ��� �� ���� INNER JOIN � ����

��� LEFT JOIN ��������
	� ON, ��� ����� ������� �� ������� �������
	� WHERE, ��� ����� ������� �� ������, ����. �������, ��������� � "X"

��� INNER JOIN ���� �������� ��� �� ����� ������ � ���� � ���� ����� �� ������
�� ����� �� ���������� ��������� ������� � WHERE
��� GROUP BY � ORDER BY ����� �� ���������� ���� �������� �� ����� ��������� � ��������� �������
� SELECT ����� ������ �� ����� ��� JOIN-����

!!! ��������� ������ ���������:

���������� �� ��� ���� X ������ -> GROUP BY ... HAVING(*) >= X
��� �� � � ���������� ��� �� ������������� ��������� �� �� ������ 0 -> LEFT JOIN + ON ... AND ...
���������� � JOIN JOIN ... RIGHT JOIN, �.�. ���� ��������� �� � ����� �� �� ������ �������� ���������
� ��-������ �� ... �� ����� � �� � ... -> > ALL()
�� �����/����� -> GROUP BY
*/