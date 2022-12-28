SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;

/*
2.1 Напишете заявка, която извежда производителя и честотата на процесора на лаптопите с размер на 
	харддиска поне 9 GB
*/
SELECT maker, speed FROM laptop JOIN product ON laptop.model = product.model WHERE hd >= 9;

/*
2.2 Напишете заявка, която извежда номер на модел и цена на всички продукти, произведени от 
производител с име ‘B’. Сортирайте резултата така, че първо да се изведат най-скъпите продукти.
*/

SELECT p.model, price FROM product p JOIN laptop ON p.model = laptop.model WHERE maker = 'B'
UNION
SELECT p.model, price FROM product p JOIN pc ON p.model = pc.model WHERE maker = 'B'
UNION
SELECT p.model, price FROM product p JOIN printer ON p.model = printer.model WHERE maker = 'B'

/*
2.3 Напишете заявка, която извежда размерите на тези харддискове, които се предлагат в поне 
	два компютъра.
*/

SELECT DISTINCT p1.hd FROM pc p1 JOIN pc p2 ON p1.hd = p2.hd AND p1.code <> p2.code;

/*
2.4 Напишете заявка, която извежда всички двойки модели на компютри, които имат еднаква честота 
	на процесора и памет. Двойките трябва да се показват само по веднъж, например ако вече е изведена 
	двойката (i, j), не трябва да се извежда (j, i)
*/

SELECT DISTINCT p1.model, p2.model FROM pc p1 JOIN pc p2 ON p1.speed = p2.speed AND p1.ram = p2.ram
WHERE p1.model < p2.model;


/*
2.5 Напишете заявка, която извежда производителите на поне два различни компютъра с честота на 
	процесора поне 1000 MHz
*/

SELECT maker FROM product JOIN pc ON product.model = pc.model JOIN pc p2 ON pc.code = p2.code 
WHERE pc.speed > 1000;
