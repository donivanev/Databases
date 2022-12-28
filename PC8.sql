USE pc;
SELECT * FROM product;
SELECT * FROM laptop;
SELECT * FROM pc;
SELECT * FROM printer;

BEGIN TRANSACTION;

/*
1. Използвайки две INSERT заявки, съхранете в базата от данни факта, че персонален компютър модел 
   1100 е направен от производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB, 52x DVD 
   устройство и струва $299. Нека новият компютър има код 12. Забележка: моделът и CD са от тип низ.
   Упътване: самото вмъкване на данни е очевидно как ще стане, помислете в какъв ред е по-логично да са 
   двете заявки.
*/

-- !!!
INSERT INTO product VALUES ('C', '1100', 'PC');
INSERT INTO pc VALUES (12, '1100', 2400, 2048, 500, '52x', 299);
SELECT * FROM product;
SELECT * FROM pc;

-- 2. Да се изтрие всичката налична информация за компютри модел 1100.

DELETE FROM pc WHERE model = 1100;
SELECT * FROM pc;

/*
3. За всеки персонален компютър се продава и 15-инчов лаптоп със същите параметри, но с $500 по-скъп. 
   Кодът на такъв лаптоп е със 100 по-голям от кода на съответния компютър. Добавете тази информация
*/

INSERT INTO laptop (code, model, speed, ram, hd, price, screen) 
SELECT code + 100, model, speed, ram, hd, price + 500, 15 FROM pc;
SELECT * FROM laptop;

-- 4. Да се изтрият всички лаптопи, направени от производител, който не произвежда принтери

DELETE FROM laptop WHERE model IN (SELECT model FROM product WHERE type = 'Laptop' AND 
maker NOT IN (SELECT maker FROM product WHERE type = 'Printer'));
SELECT * FROM laptop;

-- 5. Производител А купува производител B. На всички продукти на В променете производителя да бъде А.

UPDATE product SET maker = 'A' WHERE maker = 'B';
SELECT * FROM product;

/*
6. Да се намали два пъти цената на всеки компютър и да се добавят по 20 GB към всеки твърд диск. 
   Упътване: няма нужда от две отделни заявки.
*/

UPDATE pc SET price = price / 2, hd = hd + 20;
SELECT * FROM pc;

-- 7. За всеки лаптоп от производител B добавете по един инч към диагонала на екрана.

UPDATE laptop SET screen = screen + 1 WHERE model IN (SELECT model FROM product WHERE maker = 'B'); 
SELECT * FROM laptop;

ROLLBACK TRANSACTION;
