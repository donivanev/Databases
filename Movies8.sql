USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

BEGIN TRANSACTION;

INSERT INTO moviestar VALUES ('Nicole Kidman', NULL, 'F', '1967-06-20');
SELECT * FROM moviestar;

DELETE FROM movieexec WHERE networth < 10000000;
SELECT * FROM movieexec;

DELETE FROM moviestar WHERE address IS NULL;
SELECT * FROM moviestar;

UPDATE movieexec SET name = 'Pres.' + name WHERE cert# IN (SELECT presc# FROM studio);
SELECT * FROM movieexec;

ROLLBACK TRANSACTION;
