USE pc;
SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

/*
1. �������� ������, ����� ������� ��������, �������� � ������ �� ������ �������, PC-�� � ��������. 
   �� ����������� ������������.
*/

GO
CREATE VIEW code_model_price AS SELECT code, model, price FROM pc UNION ALL
SELECT code, model, price FROM laptop UNION ALL SELECT code, model, price FROM printer
GO

SELECT * FROM code_model_price;

-- 2. ��������� �������, ���� �������� � ������ type (PC, Laptop, Printer)
-- 3. ��������� �������, ���� �������� � ������ speed, ����� � NULL �� ����������

GO
ALTER VIEW code_model_price AS SELECT code, model, price, speed, 'PC' AS type FROM pc UNION ALL 
SELECT code, model, price, speed, 'Laptop' AS type FROM laptop UNION ALL 
SELECT code, model, price, NULL, 'Printer' AS type FROM printer;
GO

SELECT * FROM code_model_price;
