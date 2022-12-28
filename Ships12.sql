USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

BEGIN TRANSACTION;

/*
1. Ако бъде добавен нов клас с водоизместимост по-голяма от 35000, класът да бъде добавен в 
   таблицата, но да му се зададе водоизместимост 35000.
*/

GO
CREATE TRIGGER displacement35000 ON classes INSTEAD OF INSERT AS
INSERT INTO classes SELECT class, type, country, numguns, bore, 35000 FROM inserted 
WHERE displacement > 35000
GO

INSERT INTO classes VALUES ('asd', 'bb', 'Amerika', 7, 15, 50000)

DROP TRIGGER displacement35000

/*
2. Създайте изглед, който показва за всеки клас името му и броя кораби (евентуално 0). 
   Направете така, че при изтриване на ред да се изтрие класът и всички негови кораби.
*/

GO
CREATE VIEW classShips AS SELECT classes.class, COUNT(name) as Count FROM classes JOIN ships 
ON classes.class = ships.class GROUP BY classes.class;
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

-- 3. Никой клас не може да има повече от два кораба.

GO
CREATE TRIGGER noClassWithMoreThan2Ships ON classes AFTER INSERT AS
IF EXISTS (SELECT class FROM ships GROUP BY class HAVING COUNT(*) > 2)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER noClassWithMoreThan2Ships;

/*
4. Кораб с повече от 9 оръдия не може да участва в битка с кораб, който е с по-малко от 9 оръдия. 
   Напишете тригер за Outcomes.
*/

GO
CREATE TRIGGER noMoreThan9Guns ON outcomes AFTER INSERT, UPDATE AS 
IF EXISTS (SELECT name FROM ships JOIN classes ON ships.class = classes.class WHERE numguns > 9)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER noMoreThan9Guns;

/*
5. Кораб, който вече е потънал, не може да участва в битка, чиято дата е след датата на потъването му.
   Напишете тригери за всички таблици, за които е необходимо.
*/

GO
CREATE TRIGGER cantBattleAfterSunk ON outcomes AFTER INSERT, UPDATE AS
IF EXISTS (SELECT * FROM outcomes JOIN battles b1 ON outcomes.battle = b1.name JOIN outcomes o2
		   ON outcomes.ship = o2.ship JOIN battles b2 ON o2.battle = b2.name 
		   WHERE outcomes.result = 'sunk' AND b1.date < b2.date)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER cantBattleAfterSunk;

ROLLBACK TRANSACTION;