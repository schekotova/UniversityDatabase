use uni;

----------------------------VIEWS------------------------


GO
--View of Subject Details by Faculty
CREATE VIEW View_SubjectDetails AS
SELECT s.id AS SubjectID, s.name AS SubjectName, s.lectures AS LectureHours, f.name AS FacultyName
FROM subject s
JOIN department d ON s.id = d.id
JOIN faculty f ON d.faculty_id = f.id;
GO

SELECT * FROM View_SubjectDetails

GO
-- View of Professor Details with Department and Faculty
CREATE VIEW View_ProfessorDetails AS
SELECT p.id AS ProfessorID, p.name AS ProfessorName, p.surname AS ProfessorSurname, d.name AS DepartmentName, f.name AS FacultyName
FROM professor p
JOIN department d ON p.department_id = d.id
JOIN faculty f ON d.faculty_id = f.id;
GO

SELECT * FROM View_ProfessorDetails

GO
-- View of Student Enrollment Details
CREATE VIEW View_StudentEnrollment AS
SELECT st.id AS StudentID, st.name AS StudentName, st.surname AS StudentSurname, st.course AS Course, d.name AS DepartmentName, s.name AS SubjectName
FROM student st
JOIN department d ON st.department_id = d.id
JOIN subject_department sd ON d.id = sd.department
JOIN subject s ON sd.subject = s.id;
GO

SELECT * FROM View_StudentEnrollment

GO
-- View of Lesson Schedules
CREATE VIEW View_LessonSchedule AS
SELECT l.day_of_week AS Day, l.time AS Time, l.term AS Term, p.name AS ProfessorName, p.surname AS ProfessorSurname, s.name AS SubjectName
FROM lesson l
JOIN professor p ON l.professor_id = p.id
JOIN subject s ON l.subject_id = s.id;
GO

SELECT * FROM View_LessonSchedule

GO
-- View for Student Contact Information
CREATE VIEW View_StudentContacts AS
SELECT st.id AS StudentID, st.name AS StudentName, st.surname AS StudentSurname, 
       st.email AS Email, st.telephone AS Telephone, d.name AS DepartmentName
FROM student st
JOIN department d ON st.department_id = d.id;
GO

SELECT * FROM View_StudentContacts

GO
-- View for Detailed Lesson Plans
CREATE VIEW View_DetailedLessonPlans AS
SELECT l.day_of_week AS Day, l.time AS Time, l.term AS Term, 
       s.name AS SubjectName, p.name AS ProfessorName, p.surname AS ProfessorSurname, 
       d.name AS DepartmentName, f.name AS FacultyName
FROM lesson l
JOIN subject s ON l.subject_id = s.id
JOIN professor p ON l.professor_id = p.id
JOIN department d ON p.department_id = d.id
JOIN faculty f ON d.faculty_id = f.id;
GO

SELECT * FROM View_DetailedLessonPlans

GO
-- View for Subject Proficiency
CREATE VIEW View_SubjectProficiency AS
SELECT s.name AS SubjectName, AVG(g.grade) AS AverageGrade
FROM grade g
JOIN subject s ON g.subject_id = s.id
GROUP BY s.name;
GO

SELECT * FROM View_SubjectProficiency

GO
-- View for Faculty and Their Departments
CREATE VIEW View_FacultyDepartments AS
SELECT f.name AS FacultyName, d.name AS DepartmentName
FROM faculty f
JOIN department d ON f.id = d.faculty_id;
GO

SELECT * FROM View_FacultyDepartments



