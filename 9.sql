/*
1. �������� �� "test".
2. �������� �������� ������� � ���:
	�) Product(maker, model, type), ������ ������� � ��� �� ����� 4 �������, maker ���� ������, 
       � type - ��� �� 7 �������.
	�) Printer(code, model, color, price), ������ code � ���� �����, color � 'y' ��� 'n' � �� 
       ������������ � 'n', price - ���� � ������� �� ��� ����� ���� ����������� �������.
	�) Classes(class, type), ������ class � �� 50 �������, � type ���� �� ���� 'bb' ��� 'bc'.
3. �������� ������ � �������� ����� ��� ��������������� �������. 
�������� ���������� �� �������, �� ����� ����� ���� ���� � ������.
4. �������� ��� Classes ������ bore - ����� � ������� �������.
5. �������� ������, ����� �������� �������� price �� Printer.
6. �������� ������ ������� � ��, ����� ��� ������� � ���� ����������
*/

CREATE DATABASE test;
GO
USE test;
GO

CREATE TABLE Product (
	maker CHAR(1),
	model CHAR(4),
	type VARCHAR(7)
);

CREATE TABLE Printer (
	code INT,
	model CHAR(4),
	color CHAR(1) DEFAULT 'n',
	price DECIMAL(9, 2)
);

CREATE TABLE Classes (
	class VARCHAR(50),
	type CHAR(2)
);

SELECT * FROM Product;

INSERT INTO Printer (code, model) VALUES (1, '1111');

SELECT * FROM Printer;

ALTER TABLE Classes ADD bore DECIMAL(4);
SELECT * FROM Classes;
ALTER TABLE Printer DROP COLUMN price;
SELECT * FROM Printer;

DROP TABLE Product 
DROP TABLE Printer
DROP TABLE Classes
DROP DATABASE test;