USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

BEGIN TRANSACTION;

GO
CREATE TRIGGER displacement35000 ON classes INSTEAD OF INSERT AS INSERT INTO classes SELECT class, type, country, numguns, bore, 35000 FROM inserted 
WHERE displacement > 35000
GO

INSERT INTO classes VALUES ('asd', 'bb', 'Amerika', 7, 15, 50000)

DROP TRIGGER displacement35000

GO
CREATE VIEW classShips AS SELECT classes.class, COUNT(name) as Count FROM classes JOIN ships ON classes.class = ships.class GROUP BY classes.class;
GO

SELECT * FROM classShips;

GO
CREATE TRIGGER deleteShipAndClass ON classShips INSTEAD OF DELETE AS
BEGIN
	DELETE FROM ships WHERE class IN (SELECT class FROM deleted);
	DELETE FROM classes WHERE class IN (SELECT class FROM deleted);
END
GO

DELETE FROM classShips WHERE class LIKE 'Iowa';
DROP TRIGGER deleteShipAndClass;

GO
CREATE TRIGGER noClassWithMoreThan2Ships ON classes AFTER INSERT AS
IF EXISTS (SELECT class FROM ships GROUP BY class HAVING COUNT(*) > 2)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER noClassWithMoreThan2Ships;

GO
CREATE TRIGGER noMoreThan9Guns ON outcomes AFTER INSERT, UPDATE AS 
IF EXISTS (SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE numguns > 9)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER noMoreThan9Guns;

GO
CREATE TRIGGER cantBattleAfterSunk ON outcomes AFTER INSERT, UPDATE AS
IF EXISTS (SELECT * FROM outcomes JOIN battles b1 ON outcomes.battle = b1.name JOIN outcomes o2 ON outcomes.ship = o2.ship JOIN battles b2 ON o2.battle = b2.name 
   WHERE outcomes.result = 'sunk' AND b1.date < b2.date)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER cantBattleAfterSunk;

ROLLBACK TRANSACTION;
