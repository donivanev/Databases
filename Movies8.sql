USE movies;
SELECT * FROM movie;
SELECT * FROM movieexec;
SELECT * FROM moviestar;
SELECT * FROM starsin;
SELECT * FROM studio;

BEGIN TRANSACTION;

/*
1. Да се добави информация за актрисата Nicole Kidman. За нея знаем само, че е родена на 20-и юни 1967.
*/

INSERT INTO moviestar VALUES ('Nicole Kidman', NULL, 'F', '1967-06-20');
SELECT * FROM moviestar;


-- 2. Да се изтрият всички продуценти с печалба (networth) под 10 милиона.

DELETE FROM movieexec WHERE networth < 10000000;
SELECT * FROM movieexec;

-- 3. Да се изтрие информацията за всички филмови звезди, за които не се знае адресът.

DELETE FROM moviestar WHERE address IS NULL;
SELECT * FROM moviestar;

-- 4. Да се добави титлата "Pres." пред името на всеки продуцент, който е и президент на студио. 

UPDATE movieexec SET name = 'Pres.' + name WHERE cert# IN (SELECT presc# FROM studio);
SELECT * FROM movieexec;

ROLLBACK TRANSACTION;
