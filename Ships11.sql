USE ships;
SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

/*
1. Дефинирайте изглед BritishShips, който извежда за всеки британски кораб неговия клас, тип, брой оръдия, калибър, водоизместимост и годината, в която е пуснат на вода.
*/

GO
CREATE VIEW BritishShips AS SELECT name, ships.class, type, numguns, bore, displacement, launched FROM ships JOIN classes ON ships.class = classes.class 
WHERE country = 'Gt.Britain'
GO

SELECT * FROM BritishShips;

/*
2. Напишете заявка, която използва изгледа от предната задача, за да покаже броя оръдия и водоизместимост на британските бойни кораби (type = 'BB'), 
   пуснати на вода преди 1919.
*/

SELECT numguns, displacement FROM BritishShips WHERE type = 'bb' AND launched < 1919;

-- 3. Напишете съответната SQL заявка, реализираща задача 2, но без да използвате изглед
