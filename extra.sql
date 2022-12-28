/*
	Добри практики:

	String query = "SELECT * FROM Users WHERE username = username AND password = password"

	Login Form:

	Username: Pesho
	Password: parola1

	=> SELECT * FROM Users WHERE username = 'Pesho' AND password = 'parola1'

	Атака: SQL Injection

	... OR '1' = 1 => ALWAYS TRUE !!!
	SELECT * FROM Users WHERE username = 'Pesho' AND password = '' OR '1' = 1

	Решение: Escape на символите от потребителя

	Атака: Cross-site scripting

	Решение: <    <=>   &lt;

	Паролите в базата се съхраняват в хеш
*/