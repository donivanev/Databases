SELECT * FROM movie;
SELECT * FROM starsin;
SELECT * FROM moviestar;

--1.1 �������� ������, ����� ������� ������� �� ���������, ��������� � Terms of Endearment.
SELECT name FROM moviestar JOIN starsin ON starname = name WHERE gender = 'F' AND 
movietitle = 'Terms of Endearment';

/*
1.2 �������� ������, ����� ������� ������� �� ��������� ������, ��������� ��� ����� �� ������ 
	MGM ���� 1995 �
*/
SELECT starname FROM starsin JOIN movie ON movietitle = title WHERE studioname = 'MGM' AND year = 1995;



