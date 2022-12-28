SELECT * FROM classes;
SELECT * FROM ships;
SELECT * FROM outcomes;
SELECT * FROM battles;

SELECT name, country, bore, launched FROM ships JOIN classes ON ships.class = classes.class;

SELECT DISTINCT ship FROM outcomes JOIN battles ON battle = name WHERE year(date) = 1942;
