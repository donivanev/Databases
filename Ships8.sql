USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

BEGIN TRANSACTION;

INSERT INTO classes VALUES ('Nelson', 'bb', 'Gr. Britain', 9, 16, 34000);
INSERT INTO ships VALUES ('Nelson', 'Nelson', 1927);
INSERT INTO ships VALUES ('Rodney', 'Nelson', 1927);
--SELECT * FROM ships;

DELETE FROM ships WHERE name IN (SELECT ship FROM outcomes WHERE result = 'sunk');
SELECT * FROM ships;

UPDATE classes SET bore *= 2.54, displacement *= 1.1;
SELECT * FROM classes;

DELETE FROM classes WHERE class NOT IN (SELECT class FROM ships GROUP BY class HAVING COUNT(*) >= 3);
SELECT * FROM classes;

UPDATE classes SET bore = (SELECT bore FROM classes WHERE class = 'Bismarck'), displacement = (SELECT displacement FROM classes WHERE class = 'Bismarck');
SELECT * FROM classes;

ROLLBACK TRANSACTION;
