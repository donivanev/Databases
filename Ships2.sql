SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

--3.1 �������� ������, ����� ������� ����� �� ��������, ��-����� (displacement) �� 35000.

SELECT name FROM ships JOIN classes ON classes.class = ships.class WHERE displacement > 35000;

/*
3.2 �������� ������, ����� ������� �������, ����������������� � ���� ������ �� ������ ������, 
	��������� � ������� ��� Guadalcanal
*/
SELECT name, bore, numguns FROM outcomes JOIN ships ON ship = name 
JOIN classes ON ships.class = classes.class WHERE name = 'Guadalcanal';

/*
3.3 �������� ������, ����� ������� ������� �� ���� �������, ����� ���� ������� ������ �� ��� 
	�bb� � �bc� ������������.
*/
SELECT country FROM classes JOIN ships ON classes.class = ships. class WHERE type = 'bb'
INTERSECT
SELECT country FROM classes JOIN ships ON classes.class = ships. class WHERE type = 'bc'

/*
3.4 �������� ������, ����� ������� ������� �� ���� ������, ����� �� ���� ��������� � ���� �����, 
	�� ��-����� �� ��������� � ����� �����
*/
SELECT DISTINCT o1.ship FROM outcomes o1 
JOIN battles b1 ON o1.battle = b1.name
JOIN outcomes o2 ON o1.ship = o2.ship
JOIN battles b2 ON o2.battle = b2.name
WHERE o1.result = 'damaged' AND b1.date < b2.date;