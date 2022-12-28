USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

BEGIN TRANSACTION;

/*
1. Два британски бойни кораба (type = 'bb') от класа Nelson - Nelson и Rodney - са били пуснати на 
вода едновременно през 1927 г. Имали са девет 16-инчови оръдия (bore) и водоизместимост от 34 000 тона 
(displacement). Добавете тези факти към базата от данни.
*/

INSERT INTO classes VALUES ('Nelson', 'bb', 'Gr. Britain', 9, 16, 34000);
INSERT INTO ships VALUES ('Nelson', 'Nelson', 1927);
INSERT INTO ships VALUES ('Rodney', 'Nelson', 1927);
--SELECT * FROM ships;

-- 2. Изтрийте от Ships всички кораби, които са потънали в битка.

DELETE FROM ships WHERE name IN (SELECT ship FROM outcomes WHERE result = 'sunk');
SELECT * FROM ships;

/*
3. Променете данните в релацията Classes така, че калибърът (bore) да се измерва в сантиметри 
(в момента е в инчове, 1 инч ~ 2.54 см) и водоизместимостта да се измерва в метрични тонове 
(1 м.т. = 1.1 т.)
*/

UPDATE classes SET bore *= 2.54, displacement *= 1.1;
SELECT * FROM classes;

-- 4. Изтрийте всички класове, от които има по-малко от три кораба.

DELETE FROM classes WHERE class NOT IN (SELECT class FROM ships GROUP BY class HAVING COUNT(*) >= 3);
SELECT * FROM classes;

/*
5. Променете калибъра на оръдията и водоизместимостта на класа Iowa, така че да са същите като тези 
на класа Bismarck.
*/

UPDATE classes SET bore = (SELECT bore FROM classes WHERE class = 'Bismarck'), 
displacement = (SELECT displacement FROM classes WHERE class = 'Bismarck');
SELECT * FROM classes;

ROLLBACK TRANSACTION;