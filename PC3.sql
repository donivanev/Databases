SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

/*
2.1 Напишете заявка, която извежда производителите на персонални компютри с честота на процесора 
	поне 500 MHz
*/

SELECT speed FROM pc JOIN product ON pc.model = product.model WHERE speed >= 500;

/*
2.2 Напишете заявка, която извежда лаптопите, чиято честота на CPU е по-ниска от честотата на който 
	и да е персонален компютър.
*/
SELECT model FROM laptop WHERE speed < ALL(SELECT speed FROM pc);

-- 2.3 Напишете заявка, която извежда модела на продукта (PC, лаптоп или принтер) с най-висока цена

SELECT DISTINCT model FROM 

(SELECT model, price FROM pc UNION ALL SELECT model, price FROM laptop UNION 
ALL 
SELECT model, price FROM printer) AllProducts

WHERE price >= ALL (SELECT price FROM pc UNION ALL SELECT price FROM laptop UNION 
ALL SELECT price FROM printer);

-- 2.4 Напишете заявка, която извежда производителите на цветните принтери с най-ниска цена.

SELECT DISTINCT maker FROM product JOIN printer ON product.model = printer.model WHERE color = 'y' AND
price = (SELECT MIN(price) FROM printer WHERE color = 'y');

/*
2.5 Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, 
	които имат най-бързи процесори.
*/

SELECT DISTINCT maker FROM product JOIN pc ON product.model = pc.model 
WHERE ram <= ALL(SELECT ram FROM pc) AND speed >= ALL(SELECT speed FROM pc); 

-- <= ALL <=> = (SELECT MIN)