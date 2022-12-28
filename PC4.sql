SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

/*
2.1 За всеки модел компютри да се изведат цените на различните конфигурации от този модел. 
	Ако няма конфигурации за даден модел, да се изведе NULL. Резултатът да има две колони: model и price.
*/

SELECT DISTINCT product.model, price FROM product LEFT JOIN pc ON product.model = pc.model
WHERE product.type = 'PC';

/*
2.2 Напишете заявка, която извежда производител, модел и тип на продукт за тези производители, за които 
	съответният продукт не се продава (няма го в таблиците PC, Laptop или Printer).
*/

SELECT maker, model, type FROM product WHERE model NOT IN 
((SELECT model FROM pc) UNION (SELECT model FROM laptop) UNION (SELECT model FROM printer));
--(SELECT model FROM pc) AND model NOT IN (SELECT model FROM laptop)
--AND model NOT IN (SELECT model FROM printer);
