/*
	����� ��������:

	String query = "SELECT * FROM Users WHERE username = username AND password = password"

	Login Form:

	Username: Pesho
	Password: parola1

	=> SELECT * FROM Users WHERE username = 'Pesho' AND password = 'parola1'

	�����: SQL Injection

	... OR '1' = 1 => ALWAYS TRUE !!!
	SELECT * FROM Users WHERE username = 'Pesho' AND password = '' OR '1' = 1

	�������: Escape �� ��������� �� �����������

	�����: Cross-site scripting

	�������: <    <=>   &lt;

	�������� � ������ �� ���������� � ���
*/