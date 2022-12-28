USE pc;
SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

BEGIN TRANSACTION;

GO
CREATE TRIGGER deleteLaptopD ON laptop AFTER DELETE AS INSERT INTO pc SELECT code + 100, '1121', speed, ram, hd, '52x', price FROM deleted WHERE model IN 
(SELECT model FROM product WHERE maker = 'D');
GO

DELETE FROM laptop WHERE model IN (SELECT model FROM product WHERE maker = 'D');

DROP TRIGGER deleteLaptopD;

GO
CREATE TRIGGER changePrice ON pc AFTER UPDATE AS
	IF EXISTS (SELECT * FROM pc WHERE EXISTS (SELECT * FROM pc WHERE price < pc.price AND speed = pc.speed)) AND code IN 
	   (SELECT i.code FROM deleted d JOIN inserted i on d.code = i.code WHERE d.price != i.price)
	BEGIN
		RAISERROR('...', 16, 10);
		ROLLBACK;
	END;
GO

DROP TRIGGER changePrice;

GO
CREATE TRIGGER cantProducePrinters ON product AFTER INSERT, UPDATE AS
IF EXISTS (SELECT * FROM product p1 JOIN product p2 ON p1.maker = p2.maker WHERE p1.type = 'PC' AND p2.type = 'Printer')
BEGIN
		RAISERROR('Can\''\t produce printers.', 16, 10);
		ROLLBACK;
END
GO

DROP TRIGGER cantProducePrinters

GO
CREATE TRIGGER speedPCLaptop ON product AFTER INSERT, UPDATE AS
IF EXISTS (SELECT * FROM product JOIN product p ON product.model = p.model WHERE product.type = 'PC' AND p.type = 'Laptop') 
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

GO
CREATE TRIGGER minPrice200 ON laptop AFTER UPDATE AS
IF EXISTS (SELECT maker FROM product JOIN laptop ON product.model = laptop.model GROUP BY maker HAVING AVG(price) < 2000)
BEGIN 
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER minPrice200;

GO
CREATE TRIGGER moreExpensive ON laptop AFTER INSERT, UPDATE AS
IF EXISTS (SELECT * FROM laptop JOIN product ON laptop.model = product.model JOIN pc ON pc.model = product.model WHERE laptop.ram > pc.ram)
BEGIN
	RAISERROR('...', 16, 10);
	ROLLBACK;
END
GO

DROP TRIGGER moreExpensive;

GO
CREATE TRIGGER colorMatrixPrinters ON printer INSTEAD OF INSERT AS INSERT INTO printer SELECT * FROM inserted WHERE color != 'y' OR type != 'Matrix'
GO

DROP TRIGGER colorMatrixPrinters;

ROLLBACK TRANSACTION;
