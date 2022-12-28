--списък от стойности = стълб от таблицата
--SELECT * FROM printer where price >= ALL(SELECT price FROM printer);

--SELECT TOP 1 * FROM printer ORDER BY price DESC;
--in MySQL, TOP = LIMIT

USE ships; --сменя контрола над съответната таблица

SELECT DISTINCT class FROM outcomes JOIN ships on ship = name WHERE result = 'sunk';
--NO -> SELECT DISTINCT class FROM outcomes JOIN ships on ship = name WHERE result != 'sunk'

--INSTEAD
SELECT class FROM classes WHERE class NOT IN 
(SELECT DISTINCT class FROM outcomes JOIN ships ON ship = name WHERE result = 'sunk');

SELECT * FROM classes WHERE EXISTS (SELECT * FROM ships);

/*
SELECT * FROM database;

AS - задава псевдоним
DISTINCT - премахва повторенията

UNION - обединява 2 заявки като премахва повторенията
UNION ALL - ако искаме да запазим повторенията
UNION, INTERSECT, EXCEPT

s IN (list) -> Връща TRUE, ако s е сред елементите на списъка list
s NOT IN (list) -> Връща TRUE, ако s не е сред елементите на списъка list
s > ALL(list) -> Връща TRUE, ако s е по-голям от всички елементи на списъка list
s > ANY(list) -> Връща TRUE, ако s е по-голям от поне един от елементите на списъка 

При подзаявки във FROM клаузата задължително трябва да укажем име на таблицата, дори и да не го ползваме
SELECT movietitle, starname, birthdate FROM starsin, (SELECT name, birthdate FROM moviestar
WHERE gender = 'F') Actresses WHERE starname = name;

Корелативна подзаявка - подзаявка, която използва стойности от външната заявка
SELECT DISTINCT title FROM movie m WHERE year < ANY (SELECT year FROM movie WHERE title = m.title);

CROSS JOIN - декартово произведение
(INNER) JOIN - сечение на таблици
NATURAL JOIN - съединение на таблици ако дадени редове съвпадат // не се поддържа в MSSQL
LEFT (OUTER) JOIN - лява разлика, INNER JOIN + всички редове от лявата таблица, тоест не губим 
информация от лявата таблица
RIGHT (OUTER) JOIN - дясна разлика, INNER JOIN + всички редове от дясната таблица, тоест не губим 
информация от дясната таблица
FULL (OUTER) JOIN - запазваме всички редове от двете таблици, UNION

COALESCE(...) - получава параметри и връща първият който е различен от NULL
			  - премахва NULL стойностите

Където има първичен ключ не може да има NULL

!!!
Когато в една заявка има повече от един оператор JOIN и поне един от тях е OUTER JOIN, 
редът на прилагането им има значение. Ако са само INNER JOIN – няма
!!!

!!!
При LEFT JOIN ползваме
	– ON, ако имаме условие за дясната таблица
	– WHERE, ако имаме условие за лявата, напр. класове, започващи с "X"
!!!

WHERE - драстично намалява редовете

При INNER JOIN няма значение коя от двете колони с едни и същи имена ще вземем

AVG, COUNT (може и *), MAX, MIN, GROUP BY, HAVING
COUNT(*) - брой всички колони
COUNT(DISTINCT column) - брой колоните и премахва повтарящите се

Не можем да използваме агрегатни функции в WHERE

При GROUP BY и ORDER BY можем да използваме само колоните по които групираме и агрегатни функции

в SELECT пишем същото по което сме JOIN-нали

The (INNER) JOIN keyword selects records that have matching values in both tables.

The LEFT JOIN keyword returns all records from the left table (table1), and the matching records 
from the right table (table2). 
The result is 0 records from the right side, if there is no match.

The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records 
from the left table (table1). 
The result is 0 records from the left side, if there is no match.

The FULL (OUTER) JOIN keyword returns all records when there is a match in left (table1) or 
right (table2) table records.

Ред на изпълнение на функциите:

FROM ...
... JOIN ... ON ...
WHERE ...
GROUP BY ...
HAVING ...
SELECT ...
ORDER BY ...

Подсказки според условието:

Колекцията да има поне X записа -> GROUP BY ... HAVING(*) >= X
Ако не е в колекцията или не удовлетворява условието да се вписва 0 -> LEFT JOIN + ON ... AND ...
достатъчно е JOIN JOIN ... RIGHT JOIN, т.е. само последния да е десен за да покаже нулевите стойности
е по-голяма от ... на който и да е ... -> > ALL()
за всеки/всяка -> GROUP BY

UNION - обединява 2 заявки като премахва повторенията
UNION ALL - ако искаме да запазим повторенията

При подзаявки във FROM клаузата задължително трябва да укажем име на таблицата, дори и да не го ползваме
SELECT movietitle FROM starsin, (SELECT name, birthdate FROM moviestar WHERE gender = 'F') Actresses;

Корелативна подзаявка - подзаявка, която използва стойности от външната заявка
SELECT DISTINCT title FROM movie m WHERE year < ANY (SELECT year FROM movie WHERE title = m.title);

Когато в една заявка има повече от един оператор JOIN и поне един от тях е OUTER JOIN, 
редът на прилагането им има значение. Ако са само INNER JOIN – няма

При LEFT JOIN ползваме
	– ON, ако имаме условие за дясната таблица
	– WHERE, ако имаме условие за лявата, напр. класове, започващи с "X"

При INNER JOIN няма значение коя от двете колони с едни и същи имена ще вземем
Не можем да използваме агрегатни функции в WHERE
При GROUP BY и ORDER BY можем да използваме само колоните по които групираме и агрегатни функции
в SELECT пишем същото по което сме JOIN-нали

!!! Подсказки според условието:

Колекцията да има поне X записа -> GROUP BY ... HAVING(*) >= X
Ако не е в колекцията или не удовлетворява условието да се вписва 0 -> LEFT JOIN + ON ... AND ...
достатъчно е JOIN JOIN ... RIGHT JOIN, т.е. само последния да е десен за да покаже нулевите стойности
е по-голяма от ... на който и да е ... -> > ALL()
за всеки/всяка -> GROUP BY
*/