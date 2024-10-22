-- Active: 1729157050578@@127.0.0.1@5432@university_db


--  Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(150) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(80) NOT NULL,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);


-- Create courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    credits INT NOT NULL
);


-- Create enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

-- Insert data into students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- Insert data into courses table
INSERT INTO courses (course_name, credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);


-- Insert data into enrollment table
INSERT INTO enrollment (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);


-- Query 1: Insert a new student record
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Fahim', 22, 'fahim@example.com', 56, 60, NULL);


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'
SELECT student_name
FROM students
JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses ON enrollment.course_id = courses.course_id
WHERE courses.course_name = 'Next.js';


-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (SELECT MAX(frontend_mark + backend_mark) FROM students);


-- Query 4: Delete all courses that have no students enrolled
DELETE from courses
WHERE courses.course_id NOT IN (SELECT course_id FROM enrollment);


-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student
SELECT student_name 
FROM students
LIMIT 2 OFFSET 2;


-- Query 6: Retrieve the course names and the number of students enrolled in each course
SELECT course_name, COUNT(enrollment.student_id) AS student_enrolled FROM courses
JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY course_name;


-- Query 7: Calculate and display the average age of all students.
SELECT ROUND(AVG(age),2) AS average_age 
FROM students;


-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'
SELECT student_name
FROM students
WHERE email LIKE '%example.com';

