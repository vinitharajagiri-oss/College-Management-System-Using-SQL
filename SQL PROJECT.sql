--- CREATING DATABASE ---
create database college;  

--- CRUD OPERATIONS ---
--- CREATE ----
--- CREATING STUDENTS TABLE ---
use college;
CREATE TABLE students (
    student_id   INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age          INT CHECK (age > 0),
    department   VARCHAR(100),
    marks        DECIMAL(5, 2) CHECK (marks BETWEEN 0 AND 100));
    
--- CREATING COURSE TABLE ---
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id));
    
--- CREATING ENROLLMENTS TABLE ---
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id));
    
--- INSERING STUDENT TABLE ---
INSERT INTO students (student_id, student_name, age, department, marks)
VALUES
(1, 'Vinitha', 21, 'Computer Science', 85.50),
(2, 'Rahul', 22, 'Mathematics', 90.00),
(3, 'Priya', 20, 'Commerce', 78.50),
(4, 'Arun', 21, 'Computer Science', 88.00),
(5, 'Sneha', 22, 'Statistics', 92.50),
(6, 'Kiran', 19, 'Information Technology', 76.00),
(7, 'Anjali', 20, 'Computer Science', 95.00),
(8, 'Vijay', 23, 'Commerce', 81.50),
(9, 'Meena', 21, 'Information Technology', 87.00),
(10, 'Rohit', 22, 'Mathematics', 89.50);

--- INSERING COURSE TABLE ---
INSERT INTO courses (course_id, course_name, student_id)
VALUES
(101, 'Python', 1),
(102, 'SQL', 2),
(103, 'Data Analytics', 3),
(104, 'Power BI', 10),
(105, 'Machine Learning', 4),
(106, 'Excel', 5),
(107, 'Tableau', 6),
(108, 'Statistics', 7),
(109, 'Data Visualization', 8),
(110, 'Deep Learning', 9);

--- INSERING ENROLLMENTS TABLE ---
INSERT INTO enrollments(enrollment_id, student_id, course_id, enrollment_date)
VALUES
(1, 1, 101, '2026-01-10'),
(2, 2, 102, '2026-01-11'),
(3, 3, 103, '2026-01-12'),
(4, 4, 105, '2026-01-13'),
(5, 5, 106, '2026-01-14'),
(6, 6, 107, '2026-01-15'),
(7, 7, 108, '2026-01-16'),
(8, 8, 109, '2026-01-17'),
(9, 9, 110, '2026-01-18'),
(10, 1, 104, '2026-01-19');

--- READ(DISPLAYING/RETRIVING) ---
select * from  students;
select * from courses;
select * from enrollments;

--- UPDATE ---
set sql_safe_updates = 0;
update courses set course_name = "Data science" where student_id = 5;
select * from courses;

--- DELETE ---
delete from enrollments where course_id = 104;
delete from courses where course_id = 104;
delete from students where student_id = 10;

--- AGGREGATE FUNCTIONS USING GROUP BY ---
--- Calculate the average marks for each department ---
SELECT
    department,
    AVG(marks) AS average_marks
FROM students
GROUP BY department;

--- Count the number of students in each department ---
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;

--- Find the earliest and latest enrollment dates---
SELECT
    MIN(enrollment_date) AS first_enrollment,
    MAX(enrollment_date) AS latest_enrollment
FROM enrollments;

--- Apply all five aggregate functions together ---
SELECT
    COUNT(*) AS total_students,
    SUM(marks) AS total_marks,
    AVG(marks) AS average_marks,
    MAX(marks) AS highest_marks,
    MIN(marks) AS lowest_marks
FROM students;

--- OPERATORS ---
--- ARITHMETIC OPERATORS ---
--- Addition — Add 5 bonus marks
SELECT
    student_id,
    student_name,
    marks,
    marks + 5 AS bonus_marks
FROM students;

--- Subtraction — Deduct 5 marks ---
SELECT
    student_name,
    marks,
    marks - 5 AS reduced_marks
FROM students;

--- Multiplication — Double the marks ---
SELECT
    student_name,
    marks,
    marks * 2 AS doubled_marks
FROM students;

--- Division — Calculate half the marks ---
SELECT
    student_name,
    marks,
    marks / 2 AS half_marks
FROM students;

--- Calculate percentage from marks out of 100 ---
SELECT
    student_name,
    marks,
    (marks / 500.0) * 100 AS percentage
FROM students;

--- Arithmetic operators with UPDATE ---
UPDATE students
SET marks = marks + 5;
select * from students;

--- COMPARISION OPERATORS ---
--- Equal to (=) ===
SELECT *
FROM students
WHERE marks = 90.50;

--- Not equal to (<>) ---
SELECT *
FROM students
WHERE department <> 'Computer Science';

--- Greater than (>) ---
SELECT *
FROM students
WHERE marks > 90;

--- Less than (<) ---
SELECT *
FROM students
WHERE age < 21;

--- LOGICAL OPERATORS ---
--- AND OPERATOR ---
--- Find students who belong to the Computer Science department and scored more than 85 marks ---
 
SELECT *
FROM students
WHERE department = 'Computer Science'
  AND marks > 85;

--- OR operator ---
--- Find students who scored more than 90 marks or are elder than 22 ---
SELECT *
FROM students
WHERE marks > 90
   OR age > 22;
   
--- NOT operator ---
--- Find students who do not belong to the Commerce department ---
SELECT *
FROM students
WHERE NOT department = 'Commerce'; 

--- FILTER OPERATORS ---
--- WHERE — Filter students by marks ---
--- Find students who scored more than 80 marks ---
SELECT *
FROM students
WHERE marks > 80;

--- BETWEEN — Filter marks within a range ---
--- Find students whose marks are between 75 and 90, inclusive ---
SELECT *
FROM students
WHERE marks BETWEEN 75 AND 90;

--- IN — Filter specific departments ---
--- Find students who belong to either Computer Science or Commerce ---
SELECT *
FROM students
WHERE department IN ('Computer Science', 'Commerce');

--- LIKE — Search student names ---
--- Find students whose names start with the letter A ---
SELECT *
FROM students
WHERE student_name LIKE 'A%';

--- IS NULL — Find missing values
--- Find students whose department has no value ---
SELECT *
FROM students
WHERE department IS NULL;

--- IS NOT NULL — Find available values ---
--- Find students whose marks are not missing ---
SELECT *
FROM students
WHERE marks IS NOT NULL;

--- ORDER BY ---
--- ORDER BY — Ascending order (ASC) ---
--- Display students by marks from lowest to highest ---
SELECT *
FROM students
ORDER BY marks ASC;

--- ORDER BY — Descending order (DESC) ---
--- Display students from highest marks to lowest marks ---
SELECT student_id, student_name, marks
FROM students
ORDER BY marks DESC;

--- ORDER BY with LIMIT ---
--- Display the top 3 students based on marks ---
SELECT student_name, marks
FROM students
ORDER BY marks DESC
LIMIT 3;

--- DISTINCT ---
--- Display unique departments ---
SELECT DISTINCT department
FROM students;

--- JOINS ---
--- INNER JOIN ---
--- Display student names with their assigned courses ---
--- Returns only the records that match in both tables ---
SELECT
    s.student_id,
    s.student_name,
    c.course_name
FROM students s
INNER JOIN courses c
ON s.student_id = c.student_id;

--- LEFT JOIN ---
--- Returns all students, including students who have no matching course record ---
SELECT
    s.student_id,
    s.student_name,
    c.course_name
FROM students s
LEFT JOIN courses c
ON s.student_id = c.student_id;

--- RIGHT JOIN ---
--- Returns all courses, including courses that have no matching student record ---
SELECT
    s.student_name,
    c.course_id,
    c.course_name
FROM students s
RIGHT JOIN courses c
ON s.student_id = c.student_id;
    
--- CROSS JOIN ---
--- Returns every possible combination of students and courses ---
SELECT
    s.student_name,
    c.course_name
FROM students s
CROSS JOIN courses c;    
    
--- MULTIPLE JOINS ---    
SELECT
    s.student_id,
    s.student_name,
    s.department,
    c.course_name,
    e.enrollment_date
FROM students s
INNER JOIN enrollments e
ON s.student_id = e.student_id
INNER JOIN courses c
ON e.course_id = c.course_id;

--- VIEWS ---
--- CREATING A VIEW  ---
CREATE VIEW student_view AS
SELECT student_id, student_name, department
FROM students;

CREATE VIEW course_view AS
SELECT course_id, course_name
FROM courses;

--- DISPLAYING A VIEW ---
SELECT * FROM student_view;
SELECT * FROM course_view;

--- UPDATING A VIEW --
set sql_safe_updates = 0;
UPDATE student_view
SET student_name = "vanitha"
WHERE student_id = 1;

--- DELETING A VIEW ---
DROP VIEW course_view;

--- INDEX ---
--- Create an index ---
CREATE INDEX idx_student_name
ON students(student_name);

--- Search using the indexed column ---
SELECT *
FROM student_view
WHERE student_name = 'Vanitha';

CREATE INDEX idx_course_name
ON courses(course_name);

--- Create an index on multiple columns ---
CREATE INDEX idx_department_marks
ON students(department, marks);

--- filter by department, or by both department and marks ---
SELECT *
FROM students
WHERE department = 'Computer Science'
  AND marks > 85;
  
--- VIEW AN INDEX ---
  SHOW INDEX FROM students;
  
--- DELETING AN INDEX ---
  DROP INDEX idx_course_name ON courses;
  
--- TRANSACTIONS ---
--- Start a transaction ---
--- Using students table:
START TRANSACTION;

UPDATE students
SET marks = 100.00
WHERE student_id = 2;

SELECT * FROM students
WHERE student_id = 2;

COMMIT;

--- ROLL BACK ---
START TRANSACTION;

UPDATE students
SET marks = 50.00
WHERE student_id = 1;

SELECT * FROM students
WHERE student_id = 1;

ROLLBACK;

--- SAVEPOINT ---
START TRANSACTION;

UPDATE students
SET marks = 90.00
WHERE student_id = 3;

SELECT * FROM students
WHERE student_id = 3;

SAVEPOINT sp1;

UPDATE students
SET marks = 80.00
WHERE student_id = 2;

ROLLBACK TO SAVEPOINT sp1;

COMMIT;