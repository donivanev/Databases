USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

BEGIN TRANSACTION;

/*
1. ��� ��������� ����� ������ (type = 'bb') �� ����� Nelson - Nelson � Rodney - �� ���� ������� �� 
���� ������������ ���� 1927 �. ����� �� ����� 16-������ ������ (bore) � ��������������� �� 34 000 ���� 
(displacement). �������� ���� ����� ��� ������ �� �����.
*/

INSERT INTO classes VALUES ('Nelson', 'bb', 'Gr. Britain', 9, 16, 34000);
INSERT INTO ships VALUES ('Nelson', 'Nelson', 1927);
INSERT INTO ships VALUES ('Rodney', 'Nelson', 1927);
--SELECT * FROM ships;

-- 2. �������� �� Ships ������ ������, ����� �� �������� � �����.

DELETE FROM ships WHERE name IN (SELECT ship FROM outcomes WHERE result = 'sunk');
SELECT * FROM ships;

/*
3. ��������� ������� � ��������� Classes ����, �� ��������� (bore) �� �� ������� � ���������� 
(� ������� � � ������, 1 ��� ~ 2.54 ��) � ����������������� �� �� ������� � �������� ������ 
(1 �.�. = 1.1 �.)
*/

UPDATE classes SET bore *= 2.54, displacement *= 1.1;
SELECT * FROM classes;

-- 4. �������� ������ �������, �� ����� ��� ��-����� �� ��� ������.

DELETE FROM classes WHERE class NOT IN (SELECT class FROM ships GROUP BY class HAVING COUNT(*) >= 3);
SELECT * FROM classes;

/*
5. ��������� �������� �� �������� � ����������������� �� ����� Iowa, ���� �� �� �� ������ ���� ���� 
�� ����� Bismarck.
*/

UPDATE classes SET bore = (SELECT bore FROM classes WHERE class = 'Bismarck'), 
displacement = (SELECT displacement FROM classes WHERE class = 'Bismarck');
SELECT * FROM classes;

ROLLBACK TRANSACTION;