SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

/*
2.1 �� ����� ����� �������� �� �� ������� ������ �� ���������� ������������ �� ���� �����. 
	��� ���� ������������ �� ����� �����, �� �� ������ NULL. ���������� �� ��� ��� ������: model � price.
*/

SELECT DISTINCT product.model, price FROM product LEFT JOIN pc ON product.model = pc.model
WHERE product.type = 'PC';

/*
2.2 �������� ������, ����� ������� ������������, ����� � ��� �� ������� �� ���� �������������, �� ����� 
	����������� ������� �� �� ������� (���� �� � ��������� PC, Laptop ��� Printer).
*/

SELECT maker, model, type FROM product WHERE model NOT IN 
((SELECT model FROM pc) UNION (SELECT model FROM laptop) UNION (SELECT model FROM printer));
--(SELECT model FROM pc) AND model NOT IN (SELECT model FROM laptop)
--AND model NOT IN (SELECT model FROM printer);
