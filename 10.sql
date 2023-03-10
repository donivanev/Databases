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
