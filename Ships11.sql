USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
1. ����������� ������ BritishShips, ����� ������� �� ����� ��������� ����� ������� ����, ���, 
   ���� ������, �������, ��������������� � ��������, � ����� � ������ �� ����.
*/

GO
CREATE VIEW BritishShips AS SELECT name, ships.class, type, numguns, bore, displacement, launched 
FROM ships JOIN classes ON ships.class = classes.class WHERE country = 'Gt.Britain'
GO

SELECT * FROM BritishShips;

/*
2. �������� ������, ����� �������� ������� �� �������� ������, �� �� ������ ���� ������ � 
   ��������������� �� ����������� ����� ������ (type = 'BB'), ������� �� ���� ����� 1919.
*/

SELECT numguns, displacement FROM BritishShips WHERE type = 'bb' AND launched < 1919;

-- 3. �������� ����������� SQL ������, ����������� ������ 2, �� ��� �� ���������� ������
