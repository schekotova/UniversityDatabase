use uni;


CREATE TABLE subject (
  id INT IDENTITY,
  name NVARCHAR(50) NOT NULL,
  lectures INT NOT NULL
  CONSTRAINT PK_subject_id PRIMARY KEY(id),
  CONSTRAINT UQ_subject_name UNIQUE(name) 
)

INSERT INTO subject (name, lectures)
VALUES 
-- FAMCS
('Algorithms and Data Structures', 40),
('Discrete Mathematics', 35),
('Numerical Methods', 30),
('Computer Graphics', 45),
('Operating Systems', 50),
('Database Systems', 55),
('Machine Learning', 60),
('Artificial Intelligence', 65),
('Network Security', 70),
('Software Engineering', 75),
--MechMat
('Real Analysis', 30),
('Differential Equations', 45),
('Topology', 40),
('Linear Algebra', 35),
('Complex Analysis', 50),
-- Radiophysics
('Quantum Electronics', 50),
('Radio Wave Propagation', 60),
('Magnetic Resonance', 70),
('Electromagnetic Theory', 40),
('Radio Astronomy', 55),
-- Chemical 
('Organic Chemistry', 70),
('Inorganic Chemistry', 45),
('Physical Chemistry', 50),
('Analytical Chemistry', 55),
('Polymer Science', 60),
-- Physics
('Theoretical Mechanics', 60),
('Thermodynamics and Statistical Physics', 45),
('Experimental Physics', 50),
('Optics', 40),
('Nuclear Physics', 55);

SELECT * FROM subject;





CREATE TABLE faculty (
  id INT IDENTITY,
  name NVARCHAR(50) NOT NULL,
  foundation_date DATE,
  dean_id INT NOT NULL, 
  CONSTRAINT PK_faculty_id PRIMARY KEY(id),
  CONSTRAINT UQ_faculty_dean UNIQUE(dean_id)
)

INSERT INTO faculty (name, foundation_date, dean_id)
VALUES 
('Faculty of Applied Math and Computer Sciencce', '1970-04-01', 1),
('Faculty of Mechanics and Mathematics', '1954-06-11', 2),
('Faculty of Radiophysics', '1976-09-14', 3),
('Chemical Faculty', '1941-03-23', 4),
('Physics Faculty', '1956-10-31', 5);

SELECT * FROM faculty;





CREATE TABLE department (
  id INT IDENTITY,
  name NVARCHAR(50) NOT NULL,
  awards NVARCHAR(500),
  head_id INT NOT NULL,
  faculty_id INT,
  CONSTRAINT PK_department_id PRIMARY KEY(id),
  CONSTRAINT FK_department_faculty FOREIGN KEY(faculty_id) REFERENCES faculty(id),
  CONSTRAINT UQ_department_head UNIQUE(head_id)
)

INSERT INTO department (name, awards, head_id, faculty_id)
VALUES 
('Department of Computational Mathematics', 'Outstanding Academic Contributions 2025', 1, 1),
('Department of Theoretical Computer Science', 'Innovative Teaching Methods 2024', 2, 1),
('Department of Algebra and Number Theory', 'Excellence in Research 2019', 6, 2),
('Department of Dynamical Systems', 'Best Student Engagement 2023', 5, 2),
('Department of Radio Spectroscopy', 'Leading Innovator in Radio Spectroscopy 2020', 7, 3),
('Department of Wave Propagation', 'Best Graduate Thesis Award 2024', 8, 3),
('Department of Organic Chemistry', 'Best Research Output 2019', 9, 4),
('Department of Analytical Chemistry', 'Top Safety Standards Award 2023', 10, 4),
('Department of Quantum Physics', 'Cutting Edge Research Facility 2020', 11, 5),
('Department of Particle Physics', 'Outstanding Scientific Contributions 2022', 12, 5);

SELECT * FROM department;





CREATE TABLE professor (
  id INT IDENTITY,
  name NVARCHAR(50) NOT NULL,
  surname NVARCHAR(50) NOT NULL,
  email VARCHAR(30),
  department_id INT,
  CONSTRAINT PK_professor_id PRIMARY KEY(id),
  CONSTRAINT FK_professor_department FOREIGN KEY(department_id) REFERENCES department(id),
  CONSTRAINT UQ_professor_email UNIQUE(email),
  CONSTRAINT CK_professor_email CHECK (email LIKE '%_@__%.%'),
)

INSERT INTO professor (name, surname, email, department_id)
VALUES 
('Sergey', 'Ageev', 'ageev228@mail.ru', 1),
('Elena', 'Sobolevskaya', 'leno4ka@gmail.com', 1),
('Konstantin', 'Zubovich', 'yzhasyzhas@gmail.com', 1),
('Anastasia', 'Tanigina', 'persdacha@mail.ru', 1),
('Chris', 'Davis', 'chrisdavis@example.com', 2),
('Patricia', 'Miller', 'patriciamiller@example.com', 2),
('Jennifer', 'Wilson', 'jenniferwilson@example.com', 3),
('James', 'Taylor', 'jamestaylor@example.com', 3),
('Linda', 'Anderson', 'lindaanderson@example.com', 4),
('Robert', 'Thomas', 'robertthomas@example.com', 4),
('Leonid', 'Kanevskiy', 'lenya@mail.ru', 5),
('Severus', 'Snape', 'AfterAllThisTime@always.com', 5);

SELECT * FROM professor;





CREATE TABLE subject_department (
  department INT,
  subject INT,
  CONSTRAINT FK_subject FOREIGN KEY(subject) REFERENCES subject(id),
  CONSTRAINT FK_department FOREIGN KEY(department) REFERENCES department(id)
)

INSERT INTO subject_department(department, subject) 
VALUES 
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(3, 11),
	(3, 12),
	(4, 13),
	(4, 14),
	(4, 15),
	(5, 16),
	(5, 17),
	(5, 18),
	(6, 19),
	(6, 20),
	(7, 21),
	(7, 22),
	(7, 23),
	(8, 24),
	(8, 25),
	(9, 26),
	(9, 27),
	(9, 28),
	(10, 29),
	(10, 30);

SELECT * FROM subject_department;





CREATE TABLE student(
  id INT IDENTITY(1, 1),
  name NVARCHAR(50) NOT NULL,
  surname NVARCHAR(50) NOT NULL,
  course INT,
  email VARCHAR(30),
  telephone VARCHAR(30),
  department_id INT,
  CONSTRAINT PK_student_id PRIMARY KEY(id),
  CONSTRAINT FK_student_department FOREIGN KEY(department_id) REFERENCES department(id),
  CONSTRAINT CK_student_course CHECK(course > 0 AND course < 5),
  CONSTRAINT UQ_student_email UNIQUE(email),
  CONSTRAINT UQ_student_telephone UNIQUE(telephone),
  CONSTRAINT CK_student_email CHECK (email LIKE '%_@%.%'),
  CONSTRAINT CK_student_telephone CHECK (telephone LIKE '+375 (__) ___-__-__')
)

INSERT INTO student (name, surname, course, email, telephone, department_id)
VALUES 
('Varvara', 'Schekotova', 2, 'shchcekotovavarya@mail.ru', '+375 (33) 389-89-43', 1),
('Vladimir', 'Gorbach', 3, 'vov4ik@gmail.com', '+375 (33) 381-20-55', 2),
('Denis', 'Lebedev', 3, 'pskdeniska@mail.ru', '+375 (29) 575-99-09', 1),
('Sofia', 'Orda', 2, 'zaorda@gmail.com', '+375 (44) 555-62-78', 2),
('Alice', 'Johnson', 2, 'alicejohnson@example.com', '+375 (29) 123-45-67', 3),
('Bob', 'Lee', 3, 'boblee@example.com', '+375 (44) 234-56-78', 3),
('Charlie', 'Kim', 1, 'charliekim@example.com', '+375 (33) 345-67-89', 4),
('Denise', 'Liu', 4, 'deniseliu@example.com', '+375 (25) 456-78-90', 4),
('Ethan', 'Moore', 2, 'ethanmoore@example.com', '+375 (29) 567-89-01', 5),
('Fiona', 'White', 3, 'fionawhite@example.com', '+375 (44) 678-90-12', 5),
('George', 'Harris', 1, 'georgeharris@example.com', '+375 (33) 789-01-23', 6),
('Hannah', 'Martin', 4, 'hannahmartin@example.com', '+375 (25) 890-12-34', 6),
('Harry', 'Potter', 2, 'harrypotter@mail.ru', '+375 (33) 355-55-55', 7),
('Mariya', 'Spivak', 4, 'masha@gmail.com', '+375 (21) 111-11-11', 7),
('Rita', 'Skiter', 1, 'ritoto@mail.ru', '+375 (88) 888-88-88', 8),
('Tom', 'Reddle', 1, 'volandemort@gmail.com', '+375 (99) 999-99-99', 8),
('Ian', 'Thompson', 2, 'ianthompson@example.com', '+375 (29) 901-23-45', 9),
('Julia', 'Garcia', 3, 'juliagarcia@example.com', '+375 (44) 012-34-56', 10);

SELECT * FROM student;





CREATE TABLE lesson(
  id INT IDENTITY,
  year INT DEFAULT YEAR(GETDATE()),
  term INT,
  day_of_week VARCHAR(10),
  time TIME,
  professor_id INT,
  subject_id INT,
  CONSTRAINT PK_lesson_id PRIMARY KEY(id),
  CONSTRAINT FK_lesson_professor FOREIGN KEY(professor_id) REFERENCES professor(id),
  CONSTRAINT FK_lesson_subject FOREIGN KEY(subject_id) REFERENCES subject(id),
  CONSTRAINT CK_lesson_term CHECK(term > 0 AND term < 11)
)

INSERT INTO lesson (term, day_of_week, time, professor_id, subject_id)
VALUES 
(1, 'monday', '08:00:00', 2, 1), -- Algorithms and Data Structures by Professor 1
(2, 'Monday', '09:30:00', 1, 2), -- Discrete Mathematics by Professor 1
(1, 'Monday', '11:00:00', 1, 3), -- Numerical Methods by Professor 1
(1, 'Monday', '12:30:00', 2, 4), -- Computer Graphics by Professor 1
(1, 'Tuesday', '08:00:00', 2, 5), -- Operating Systems by Professor 2
(5, 'Tuesday', '09:30:00', 3, 6), -- Database Systems by Professor 2
(6, 'Tuesday', '11:00:00', 3, 7), -- Machine Learning by Professor 2
(1, 'Tuesday', '12:30:00', 4, 8), -- Artificial Intelligence by Professor 2
(2, 'Wednesday', '08:00:00', 4, 9), -- Network Security by Professor 3
(2, 'Wednesday', '09:30:00', 4, 10), -- Software Engineering by Professor 3
(3, 'Wednesday', '11:00:00', 5, 11), -- Real Analysis by Professor 3
(2, 'Wednesday', '12:30:00', 5, 12), -- Differential Equations by Professor 3
(2, 'Thursday', '08:00:00', 6, 13), -- Topology by Professor 4
(2, 'Thursday', '09:30:00', 6, 14), -- Linear Algebra by Professor 4
(6, 'Thursday', '11:00:00', 6, 15), -- Complex Analysis by Professor 4
(10, 'Thursday', '12:30:00', 7, 16), -- Quantum Electronics by Professor 4
(3, 'Friday', '08:00:00', 7, 17), -- Radio Wave Propagation by Professor 5
(8, 'Friday', '09:30:00', 7, 18), -- Magnetic Resonance by Professor 5
(9, 'Friday', '11:00:00', 8, 19), -- Electromagnetic Theory by Professor 5
(3, 'Friday', '12:30:00', 8, 20), -- Radio Astronomy by Professor 5
(4, 'Monday', '08:00:00', 9, 21), -- Organic Chemistry by Professor 1
(3, 'Monday', '09:30:00', 9, 22), -- Inorganic Chemistry by Professor 1
(2, 'Monday', '11:00:00', 9, 23), -- Physical Chemistry by Professor 1
(1, 'Monday', '12:30:00', 10, 24), -- Analytical Chemistry by Professor 1
(4, 'Tuesday', '08:00:00', 10, 25), -- Polymer Science by Professor 2
(4, 'Tuesday', '09:30:00', 11, 26), -- Theoretical Mechanics by Professor 2
(5, 'Tuesday', '11:00:00', 11, 27), -- Thermodynamics and Statistical Physics by Professor 2
(6, 'Tuesday', '12:30:00', 12, 28), -- Experimental Physics by Professor 2
(4, 'Wednesday', '08:00:00', 12, 29), -- Optics by Professor 3
(8, 'Wednesday', '09:30:00', 12, 30); -- Nuclear Physics by Professor 3

SELECT * FROM lesson;





CREATE TABLE lesson_student(
  student INT,
  lesson INT,
  CONSTRAINT FK_student FOREIGN KEY(student) REFERENCES student(id),
  CONSTRAINT FK_lesson FOREIGN KEY(lesson) REFERENCES lesson(id)
)


INSERT INTO lesson_student (student, lesson)
VALUES 
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(3, 11),
	(3, 12),
	(3, 13),
	(4, 14),
	(4, 15),
	(4, 13),
	(5, 11),
	(5, 12),
	(5, 13),
	(6, 14),
	(6, 15),
	(6, 11),
	(7, 12),
	(7, 13),
	(7, 14),
	(8, 15),
	(8, 12),
	(9, 16),
	(9, 17),
	(9, 18),
	(10, 19),
	(10, 16),
	(10, 17),
	(11, 18),
	(11, 19),
	(11, 20),
	(12, 20),
	(12, 16),
	(12, 17),
	(13, 21),
	(13, 22),
	(13, 23),
	(14, 24),
	(14, 25),
	(14, 21),
	(15, 22),
	(15, 23),
	(15, 24),
	(16, 25),
	(16, 21),
	(16, 22),
	(17, 26),
	(17, 27),
	(17, 28),
	(18, 29),
	(18, 30);

SELECT * FROM lesson_student




CREATE TABLE grade (
  id INT IDENTITY,
  year INT DEFAULT YEAR(GETDATE()),
  term INT,
  grade INT,
  professor_id INT,
  subject_id INT,
  student_id INT,
  CONSTRAINT PK_grade_id PRIMARY KEY(ID),
  CONSTRAINT FK_grade_professor FOREIGN KEY(professor_id) REFERENCES professor(id),
  CONSTRAINT FK_grade_subject FOREIGN KEY(subject_id) REFERENCES subject(id),
  CONSTRAINT FK_grade_student FOREIGN KEY(student_id) REFERENCES student(id),
  CONSTRAINT CK_grade_term CHECK(term > 0 AND term < 11),
  CONSTRAINT CK_grade_grade CHECK(grade > 0 AND grade < 11)
)

INSERT INTO grade (year, term, grade, professor_id, subject_id, student_id)
VALUES
(2024, 3, 4, 1, 1, 1),
(2024, 5, 6, 2, 2, 2),
(2024, 5, 10, 3, 3, 3),
(2024, 3, 5, 4, 4, 4),
(2024, 3, 7, 5, 5, 5),
(2024, 5, 8, 6, 5, 6),
(2024, 1, 7, 6, 7, 7),
(2024, 7, 8, 7, 8, 8),
(2024, 3, 8, 7, 8, 9),
(2024, 5, 6, 8, 10, 10),
(2024, 1, 8, 8, 11, 11),
(2024, 7, 9, 9, 12, 12),
(2024, 3, 7, 9, 13, 13),
(2024, 7, 6, 10, 14, 14),
(2024, 1, 8, 10, 15, 15),
(2024, 1, 9, 11, 16, 16),
(2024, 1, 6, 11, 17, 17),
(2024, 3, 7, 12, 18, 18);

SELECT * FROM grade;



