SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;

/*
2.1 �������� ������, ����� ������� ������������� � ��������� �� ��������� �� ��������� � ������ �� 
	��������� ���� 9 GB
*/
SELECT maker, speed FROM laptop JOIN product ON laptop.model = product.model WHERE hd >= 9;

/*
2.2 �������� ������, ����� ������� ����� �� ����� � ���� �� ������ ��������, ����������� �� 
������������ � ��� �B�. ���������� ��������� ����, �� ����� �� �� ������� ���-������� ��������.
*/

SELECT p.model, price FROM product p JOIN laptop ON p.model = laptop.model WHERE maker = 'B'
UNION
SELECT p.model, price FROM product p JOIN pc ON p.model = pc.model WHERE maker = 'B'
UNION
SELECT p.model, price FROM product p JOIN printer ON p.model = printer.model WHERE maker = 'B'

/*
2.3 �������� ������, ����� ������� ��������� �� ���� �����������, ����� �� ��������� � ���� 
	��� ���������.
*/

SELECT DISTINCT p1.hd FROM pc p1 JOIN pc p2 ON p1.hd = p2.hd AND p1.code <> p2.code;

/*
2.4 �������� ������, ����� ������� ������ ������ ������ �� ��������, ����� ���� ������� ������� 
	�� ��������� � �����. �������� ������ �� �� �������� ���� �� ������, �������� ��� ���� � �������� 
	�������� (i, j), �� ������ �� �� ������� (j, i)
*/

SELECT DISTINCT p1.model, p2.model FROM pc p1 JOIN pc p2 ON p1.speed = p2.speed AND p1.ram = p2.ram
WHERE p1.model < p2.model;


/*
2.5 �������� ������, ����� ������� ��������������� �� ���� ��� �������� ��������� � ������� �� 
	��������� ���� 1000 MHz
*/

SELECT maker FROM product JOIN pc ON product.model = pc.model JOIN pc p2 ON pc.code = p2.code 
WHERE pc.speed > 1000;
