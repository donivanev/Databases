SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

-- 2.1 �������� ������, ����� ������� ���� �� ��������� ������

SELECT COUNT(class) FROM classes;

/*
2.2 �������� ������, ����� ������� ������� ���� �� �������� (numguns) �� ������ ������, 
	������� �� ���� (�.�. �������� �� � ��������� Ships)
*/

SELECT AVG(numguns) FROM ships JOIN classes ON ships.class = ships.class; 

/*
2.3 �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������, � ����� ����� �� 
	���������� ���� � ������ �� ����
*/

SELECT class, MIN(launched) AS FirstYear, MAX(launched) AS LastYear FROM ships GROUP BY class;

-- 2.4 �������� ������, ����� �� ����� ���� ������� ���� �� ��������, �������� � �����

SELECT class, COUNT(name) as Count FROM ships JOIN outcomes ON ships.name = outcomes.ship 
WHERE result = 'sunk' GROUP BY class;

/*
2.5 �������� ������, ����� �� ����� ���� � ��� 4 ������� �� ���� ������ ������� ���� �� ��������, 
	�������� � �����
*/

SELECT class, COUNT(name) FROM ships JOIN outcomes ON ships.name = outcomes.ship
where result = 'sunk' AND class IN (SELECT class FROM ships GROUP BY class HAVING count(*) > 4)
GROUP BY class;


-- 2.6 �������� ������, ����� ������� �������� ����� �� �������� (displacement) �� ����� ������

SELECT AVG(DISPLACEMENT) as Avg FROM classes GROUP BY Country;
