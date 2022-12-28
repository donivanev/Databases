SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

--3.1 �������� ������, ����� ������� ��������, ����� ������� ������ �� � ���-����� ���� ������.

SELECT DISTINCT country FROM classes WHERE numguns >= ALL(SELECT numguns FROM classes);

--3.2 �������� ������, ����� ������� ������� �� �������� � 16-������ ������ (bore).

SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE bore = 16;

--3.3 �������� ������, ����� ������� ������� �� �������, � ����� �� ��������� ������ �� ���� �Kongo�.

SELECT battle FROM outcomes JOIN ships ON outcomes.ship = ships.name 
JOIN classes ON ships.class = classes.class WHERE classes.class = 'Kongo';

/*
3.4 �������� ������, ����� ������� ������� �� ��������, ����� ���� ������ � ���-����� � ��������� �
	�������� ��� ����� ������� ������ (bore).
*/

SELECT name FROM ships JOIN classes c ON ships.class = c.class 
WHERE numguns >= ALL(SELECT numguns FROM classes WHERE bore = c.bore);