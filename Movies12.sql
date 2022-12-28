USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

BEGIN TRANSACTION;

/*
1. �������� ���� ����� � ������. ��������� ����, �� ��� �������� �� ����, ����� �������� ������� 
   "save" ��� "world", ���� ����� ����������� �� ���� ������� ���� ������, ����� ��� �����.
*/

INSERT INTO moviestar VALUES('Bruce Willis', 'somewhere', 'M', '2020-01-01');

GO
CREATE TRIGGER bruce ON movie AFTER INSERT AS 
INSERT INTO starsin(movietitle, movieyear, starname) SELECT title, year, 'Bruce Willis'
FROM inserted WHERE title LIKE '%save%' OR title LIKE '%world%';
GO

INSERT INTO movie VALUES ('Save the world', 2022, 100, 'Y', 'Fox', 123);
 
SELECT * FROM movie;
SELECT * FROM starsin;

DROP TRIGGER bruce;

/*
2. �� �� ������� ����, �� �� �� � �������� �������� �������� �� Networth �� � ������� �� 500 000 
   (��� ��� ������� � ��������� MovieExec ���� �������� ����� ��-����� �� 500 000, ��������� �� ����� 
   ����������).
*/

-- ������ � ��������� �� ������ � AFTER ������� !!!
-- �������� �������� -> ��� ������� ���������, �� �������� � �������� �����

GO
CREATE TRIGGER declineNetworth ON movieexec AFTER INSERT, UPDATE, DELETE AS
IF(SELECT AVG(networth) FROM movieexec) < 500000
	BEGIN 
		RAISERROR('Error: Average networth cannot be < 500000', 16, 10);
		ROLLBACK;
	END;
GO

--UPDATE movieexec SET networth = 500 WHERE name LIKE '%Griffin%';
SELECT * FROM movieexec;
DROP TRIGGER declineNetworth;

-- 3. MS SQL �� �������� ON DELETE SET NULL. �� �� ��������� � ������ �� ������� ���� Movie.producerc#.

-- INSTEAD OF !!! �� ���� AFTER ������ FK
GO
CREATE TRIGGER onDeleteSetNull ON movieexec INSTEAD OF DELETE AS
BEGIN
	UPDATE movie SET producerc# = NULL WHERE producerc# IN (SELECT cert# FROM deleted);
	DELETE FROM movieexec WHERE cert# IN (SELECT cert# FROM deleted);
END;
GO

DELETE TRIGGER onDeleteSetNull;

/*
4. ��� �������� �� ��� ����� � StarsIn, ��� ������ ��� ������ ������������� ���� ��� ������, �� �� 
   ������� ���������� ����� � ����������� ������� (������������ ����� �� ����� NULL).
   ��������: ��� ������ �������!
*/

GO
CREATE TRIGGER addMovieStar ON starsin INSTEAD OF INSERT AS
BEGIN
	INSERT INTO moviestar(name) SELECT starname FROM inserted WHERE starname 
	NOT IN (SELECT name FROM moviestar);
	INSERT INTO movie(title, year) SELECT movietitle, movieyear FROM inserted WHERE
	NOT EXISTS (SELECT * FROM movie WHERE title = movietitle AND year = movieyear);
	INSERT INTO starsin SELECT * FROM inserted;
END
GO

INSERT INTO starsin(movietitle, movieyear, starname) VALUES ('Wohin gehst du?', 2022, 'Rammstein');

DROP TRIGGER addMovieStar;

ROLLBACK TRANSACTION;