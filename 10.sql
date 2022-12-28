/*
Зад. 3.
	 а) За всеки студент се съхранява следната информация:
			- факултетен номер - от 0 до 99999, първичен ключ;
			- име - до 100 символа;
			- ЕГН - точно 10 символа, уникално;
			- e-mail - до 100 символа, уникален;
			- рождена дата;
			- дата на приемане в университета - трябва да бъде поне 18 години след рождената;
		За всички атрибути задължително трябва да има зададена стойност (не може NULL)

	 б) добавете валидация за e-mail адреса - да бъде във формат <низ>@<низ>.<низ>

	 в) създайте таблица за университетски курсове - уникален номер и име.
	
	Всеки студент може да се запише в много курсове и във всеки курс може да има записани 
	много студенти.
	При изтриване на даден курс автоматично да се отписват всички студенти от него.
*/

GO
CREATE DATABASE University
GO

CREATE TABLE Students (
	FN INTEGER PRIMARY KEY CHECK (FN BETWEEN 0 AND 99999),
	Name VARCHAR(100) NOT NULL,
	SSN CHAR(10) UNIQUE NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL,
	Birthdate DATE NOT NULL,
	Adate DATE NOT NULL,
	CONSTRAINT at_least_18_years CHECK(DATEDIFF(year, Birthdate, Adate) >= 18)
);

ALTER TABLE Students ADD CONSTRAINT email_valid CHECK(Email LIKE '%_@%_.%_');

CREATE TABLE Courses (
	ID INT IDENTITY PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
);

SELECT * FROM Students;

CREATE TABLE StudentsIn (
	Student_FN INT REFERENCES Students(FN),
	Course_ID INT REFERENCES Courses(ID) ON DELETE CASCADE,
	PRIMARY KEY (Student_FN, Course_ID)
);

GO
DROP DATABASE University
GO