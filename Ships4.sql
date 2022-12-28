SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
3.1 �������� ������, ����� �� ����� ����� ������� ����� ��, ���������, ���� ������ � �������� 
	�� ������� (launched).
*/

SELECT name, country, bore, launched FROM ships JOIN classes ON ships.class = classes.class;

-- 3.2 �������� ������, ����� ������� ������� �� ��������, ��������� � ����� �� 1942 �. 

SELECT DISTINCT ship FROM outcomes JOIN battles ON battle = name WHERE year(date) = 1942;
