USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

BEGIN TRANSACTION;

/*
1. �� �� ������ ���������� �� ��������� Nicole Kidman. �� ��� ����� ����, �� � ������ �� 20-� ��� 1967.
*/

INSERT INTO moviestar VALUES ('Nicole Kidman', NULL, 'F', '1967-06-20');
SELECT * FROM moviestar;


-- 2. �� �� ������� ������ ���������� � ������� (networth) ��� 10 �������.

DELETE FROM movieexec WHERE networth < 10000000;
SELECT * FROM movieexec;

-- 3. �� �� ������ ������������ �� ������ ������� ������, �� ����� �� �� ���� �������.

DELETE FROM moviestar WHERE address IS NULL;
SELECT * FROM moviestar;

-- 4. �� �� ������ ������� "Pres." ���� ����� �� ����� ���������, ����� � � ��������� �� ������. 

UPDATE movieexec SET name = 'Pres.' + name WHERE cert# IN (SELECT presc# FROM studio);
SELECT * FROM movieexec;

ROLLBACK TRANSACTION;
