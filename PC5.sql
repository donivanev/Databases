SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

-- 1.1 �������� ������, ����� ������� �������� ������� �� ����������� �� ����������.

SELECT AVG(speed) AS Avg FROM pc;

/*
1.2 �������� ������, ����� �� ����� ������������ ������� ������� ������ �� �������� �� �������� 
	�������
*/

SELECT maker, AVG(screen) FROM laptop JOIN product ON laptop.model = product.model GROUP BY maker;

-- 1.3 �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000

SELECT AVG(speed) FROM laptop WHERE price > 1000;

-- 1.4 �������� ������, ����� ������� �������� ���� �� ����������, ����������� �� ������������ �A�

SELECT AVG(price) FROM pc JOIN product ON pc.model = product.model WHERE maker = 'A';

/*
1.5 �������� ������, ����� ������� �������� ���� �� ���������� � ��������� �� ������������ �B� 
	(���� �����)
*/

SELECT AVG(price)
FROM
(
	SELECT price FROM product p JOIN pc ON p.model = pc.model WHERE maker = 'B'
	UNION ALL
	SELECT price FROM product p JOIN laptop l ON p.model = l.model WHERE maker = 'B'
) AllPrices;

/*
1.6 �������� ������, ����� ������� �������� ���� �� ���������� ������ ���������� �� ������� �� 
	�����������
*/

SELECT AVG(price) AS Avg FROM pc GROUP BY speed;

/*
1.7 �������� ������, ����� ������� ���������������, ����� �� ��������� ���� �� 3 �������� ������ 
	���������
*/

SELECT maker FROM product WHERE type = 'PC' GROUP BY maker HAVING COUNT(*) >= 3;

-- 1.8 �������� ������, ����� ������� ��������������� �� ���������� � ���-������ ����

SELECT maker, MAX(PRICE) AS Max FROM product JOIN pc ON product.model = pc.model GROUP BY maker;

-- 1.9 �������� ������, ����� ������� �������� ���� �� ���������� �� ����� ������� > 800 MHz

SELECT AVG(price) AS Avg FROM pc WHERE speed > 800; 

/*
1.10 �������� ������, ����� ������� ������� ������ �� ����� �� ���� ��������, ����������� �� 
	�������������, ����� ����������� � ��������
*/

SELECT AVG(hd) FROM (SELECT hd FROM pc JOIN product ON pc.model = product.model 
WHERE maker IN (SELECT maker FROM product WHERE type = 'Printer')) AllDisks;

/*
1.11 �������� ������, ����� �� ����� ������ �� ������ ������ ��������� � ������ �� ���-������ 
	� ���-������� ������ ��� ����� ������
*/

SELECT screen, MAX(price) - MIN(price) FROM laptop GROUP BY screen;
