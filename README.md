# University Database

## Overview

> The objective was to design and implement a comprehensive database system for a university. This system is intended to manage extensive data involving departments, faculties, professors, students, and their associated academic activities such as lessons and grades.

## Database Schema and Implementation Details
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/diagram.jpg)
### **`Faculty`**

This table is critical for representing different faculties within the university. Each faculty is uniquely identified by an `id` and has a `name`, `foundation_date`, and a `dean_id` which links to a professor acting as the dean. The uniqueness of the dean is ensured, meaning no dean can oversee more than one faculty.

### **`Department`**

Nested within faculties, each department is also uniquely identified by an `id` and has attributes like `name` and `awards`. It is tied to a faculty via `faculty_id` and has a head represented by `head_id`. Each head can only lead one department, ensuring clear leadership.

### **`Professor`**

Professors are cataloged with details such as `id`, `name`, `surname`, `email`, and `department_id`, which links them to their respective departments. Email addresses are unique across the table and must adhere to a basic format.

### **`Student`**

This table tracks students with fields including `id`, `name`, `surname`, `course`, `email`, `telephone`, and `department_id`. Each student is ensured a unique email and phone number, both of which must follow specific formats. The course field is restricted to values between 1 and 4, indicating their year in the curriculum.

### **`Subject`**

Subjects are described with an `id`, `name`, and `lectures` indicating the number of lecture hours. Each subject is unique by its name within the table.

### **`Lesson`**

Lessons are scheduled with an `id`, `year`, `term`, `day_of_week`, `time`, `professor_id`, and `subject_id`. The lesson is linked to both a professor and a subject, ensuring that all lessons are properly assigned.

### **`Grade`**

Grades are recorded with `id`, `year`, `term`, `grade`, `professor_id`, `subject_id`, and `student_id`, linking each grade to its respective professor, subject, and student. The grade value itself is checked to be within the valid range of 1 to 10.

## **Views**

### `View_SubjectDetails`
Consolidates subjects with their respective faculties and lecture hours for easy access.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/SubjectDetails.png)
### `View_ProfessorDetails`
Aggregates professor information along with their department and faculty affiliations.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/ProfessorDetails.png)
### `View_StudentEnrollment`
Displays students, the courses they are enrolled in, and their department and subject details.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/StudentEnrollment.png)
### `View_LessonSchedule`
Provides a weekly schedule of lessons, including the day, time, term, and involved professor and subject details.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/LessonShedule.png)
### `View_StudentContacts`
Lists student contact information along with their department.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/StudentContacts.png)
### `View_DetailedLessonPlans`
Combines lesson schedules with detailed subject and faculty information.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/DetailedLessonPlan.png)
### `View_SubjectProficiency`
Calculates and displays the average grades for subjects, providing insights into student performance.
![alt](https://github.com/schekotova/UniversityDatabase/blob/master/pictures/SubjectProficiency.png)
## **Triggers**

-   `trg_professor_audit`
    Monitors changes in `professor` records (`name`, `surname`, `email`) and logs these changes for auditing purposes. It uses SQL triggers to automatically capture changes when updates occur.

-   `LogDepartmentAwardUpdates`
    Operates within a university database to ensure that any changes made to the `awards` column of the `department` table are meticulously recorded. It is activated after an update is performed on the table. If the trigger detects a change in the `awards` column—specifically, if the old and new values differ—it logs this modification in the `department_audit` table. The recorded information includes the `department_id` (identifying the department where the change occurred), the `old_awards` (showing the awards before the update), the `new_awards` (showing the awards after the update), and the `update_date` (capturing the exact moment the change was made). This mechanism is crucial for maintaining a transparent and accountable record of all changes to department awards, providing a valuable tool for administrative review and compliance monitoring.

-   `PreventSubjectDeletionIfUsed`
    Meticulously designed to maintain the integrity of educational data within a university's database. It activates when there's an attempt to delete subjects from the `subject` table. The trigger operates by first checking whether the subject scheduled for deletion is actively used in lessons, referenced in the `lesson` table. If it finds the subject in use, it prevents the deletion by issuing an error message, thus safeguarding scheduled classes from disruption. Additionally, it checks if the subject is part of any departmental curriculums by referencing the `subject_department` table
