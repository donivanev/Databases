USE pc;
SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

BEGIN TRANSACTION;

/*
1. ����������� ��� INSERT ������, ��������� � ������ �� ����� �����, �� ���������� �������� ����� 
   1100 � �������� �� ������������� C, ��� �������� 2400 MHz, RAM 2048 MB, ����� ���� 500 GB, 52x DVD 
   ���������� � ������ $299. ���� ������ �������� ��� ��� 12. ���������: ������� � CD �� �� ��� ���.
   ��������: ������ �������� �� ����� � �������� ��� �� �����, ��������� � ����� ��� � ��-������� �� �� 
   ����� ������.
*/

-- !!!
INSERT INTO product VALUES ('C', '1100', 'PC');
INSERT INTO pc VALUES (12, '1100', 2400, 2048, 500, '52x', 299);
SELECT * FROM product;
SELECT * FROM pc;

-- 2. �� �� ������ �������� ������� ���������� �� �������� ����� 1100.

DELETE FROM pc WHERE model = 1100;
SELECT * FROM pc;

/*
3. �� ����� ���������� �������� �� ������� � 15-����� ������ ��� ������ ���������, �� � $500 ��-����. 
   ����� �� ����� ������ � ��� 100 ��-����� �� ���� �� ���������� ��������. �������� ���� ����������
*/

INSERT INTO laptop (code, model, speed, ram, hd, price, screen) 
SELECT code + 100, model, speed, ram, hd, price + 500, 15 FROM pc;
SELECT * FROM laptop;

-- 4. �� �� ������� ������ �������, ��������� �� ������������, ����� �� ���������� ��������

DELETE FROM laptop WHERE model IN (SELECT model FROM product WHERE type = 'Laptop' AND 
maker NOT IN (SELECT maker FROM product WHERE type = 'Printer'));
SELECT * FROM laptop;

-- 5. ������������ � ������ ������������ B. �� ������ �������� �� � ��������� ������������� �� ���� �.

UPDATE product SET maker = 'A' WHERE maker = 'B';
SELECT * FROM product;

/*
6. �� �� ������ ��� ���� ������ �� ����� �������� � �� �� ������� �� 20 GB ��� ����� ����� ����. 
   ��������: ���� ����� �� ��� ������� ������.
*/

UPDATE pc SET price = price / 2, hd = hd + 20;
SELECT * FROM pc;

-- 7. �� ����� ������ �� ������������ B �������� �� ���� ��� ��� ��������� �� ������.

UPDATE laptop SET screen = screen + 1 WHERE model IN (SELECT model FROM product WHERE maker = 'B'); 
SELECT * FROM laptop;

ROLLBACK TRANSACTION;
