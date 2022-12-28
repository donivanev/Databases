SELECT * FROM dbo.BATTLES;
SELECT * FROM dbo.CLASSES;
SELECT * FROM dbo.OUTCOMES;
SELECT * FROM dbo.SHIPS;

/*
3.1 �������� ������, ����� ������� ����� �� ����� � ��������� �� ������ ������� � ���� �� ��������, 
	��-����� �� 10
*/

SELECT class, country FROM dbo.CLASSES WHERE numguns < 10;

/*
3.2 �������� ������, ����� ������� ������� �� ������ ������, ������� �� ���� ����� 1918. 
	������� ��������� �� �������� shipName
*/

SELECT name as shipname FROM dbo.SHIPS WHERE launched < 1918;

/*
3.3 �������� ������, ����� ������� ������� �� ��������, �������� � �����, � ������� �� �������, 
	� ����� �� ��������
*/

SELECT ship, battle FROM dbo.OUTCOMES WHERE result = 'sunk';

--3.4 �������� ������, ����� ������� ������� �� �������� � ���, ��������� � ����� �� ������ ����

SELECT name FROM dbo.SHIPS WHERE name = class;

--3.5 �������� ������, ����� ������� ������� �� ������ ������, ��������� � ������� R

SELECT name FROM dbo.SHIPS WHERE name LIKE 'R%';

--3.6 �������� ������, ����� ������� ������� �� ������ ������, ����� ��� � ��������� �� ����� ��� ����
SELECT name FROM dbo.SHIPS WHERE name LIKE '% %' AND name NOT LIKE '% % %';
