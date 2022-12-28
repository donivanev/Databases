SELECT * FROM dbo.MOVIE;
SELECT * FROM dbo.MOVIEEXEC;
SELECT * FROM dbo.MOVIESTAR;
SELECT * FROM dbo.STARSIN;
SELECT * FROM dbo.STUDIO;

-- 1.1 �������� ������, ����� ������� ������ �� ������ �MGM�

SELECT address FROM dbo.STUDIO WHERE name = 'MGM';

-- 1.2 �������� ������, ����� ������� ��������� ���� �� ��������� Sandra Bullock

SELECT birthdate FROM dbo.MOVIESTAR WHERE name = 'Sandra Bullock';

/*
1.3 �������� ������, ����� ������� ������� �� ������ ������� ������, ����� �� ��������� ��� ���� 
      ���� 1980, � ���������� �� ����� ��� ������ �Empire� 
*/

SELECT starname FROM dbo.STARSIN WHERE movieyear = 1980 AND movietitle LIKE 'Empire%';

/*
1.4 �������� ������, ����� ������� ������� �� ������ ����������� �� ����� � ����� �������� ��� 
10 000 000 ������
*/

SELECT * FROM dbo.MOVIEEXEC WHERE networth > 10000000;

-- 1.5 �������� ������, ����� ������� ������� �� ������ �������, ����� �� ���� ��� ������ � Malibu

SELECT name FROM dbo.MOVIESTAR WHERE gender = 'M' OR address = '%Malibu%';