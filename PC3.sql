SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

SELECT speed FROM pc JOIN product ON pc.model = product.model WHERE speed >= 500;

SELECT model FROM laptop WHERE speed < ALL(SELECT speed FROM pc);

SELECT DISTINCT model FROM (SELECT model, price FROM pc UNION ALL SELECT model, price FROM laptop UNION ALL SELECT model, price FROM printer) AllProducts 
WHERE price >= ALL (SELECT price FROM pc UNION ALL SELECT price FROM laptop UNION ALL SELECT price FROM printer);

SELECT DISTINCT maker FROM product JOIN printer ON product.model = printer.model WHERE color = 'y' AND price = (SELECT MIN(price) FROM printer WHERE color = 'y');

SELECT DISTINCT maker FROM product JOIN pc ON product.model = pc.model WHERE ram <= ALL(SELECT ram FROM pc) AND speed >= ALL(SELECT speed FROM pc);
