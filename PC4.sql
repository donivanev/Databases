SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

SELECT DISTINCT product.model, price FROM product LEFT JOIN pc ON product.model = pc.model WHERE product.type = 'PC';

SELECT maker, model, type FROM product WHERE model NOT IN ((SELECT model FROM pc) UNION (SELECT model FROM laptop) UNION (SELECT model FROM printer));
--(SELECT model FROM pc) AND model NOT IN (SELECT model FROM laptop)
--AND model NOT IN (SELECT model FROM printer);
