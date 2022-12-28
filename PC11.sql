USE pc;
SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

/*
1. —ъздайте изглед, който показва кодовете, моделите и цените на всички лаптопи, PC-та и принтери. 
   Ќе премахвайте повторени€та.
*/

GO
CREATE VIEW code_model_price AS SELECT code, model, price FROM pc UNION ALL
SELECT code, model, price FROM laptop UNION ALL SELECT code, model, price FROM printer
GO

SELECT * FROM code_model_price;

-- 2. ѕроменете изгледа, като добавите и колона type (PC, Laptop, Printer)
-- 3. ѕроменете изгледа, като добавите и колона speed, ко€то е NULL за принтерите

GO
ALTER VIEW code_model_price AS SELECT code, model, price, speed, 'PC' AS type FROM pc UNION ALL 
SELECT code, model, price, speed, 'Laptop' AS type FROM laptop UNION ALL 
SELECT code, model, price, NULL, 'Printer' AS type FROM printer;
GO

SELECT * FROM code_model_price;
