-- Create tables Students, Courses, Enrollments with keys and relationships
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(10)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- Insert sample data into Students, Courses, and Enrollments
INSERT INTO Students (student_id, first_name, last_name, email) VALUES
(1, 'John', 'Doe', 'johndoe@gmail.com'),
(2, 'Jane', 'Smith', 'janesmith@gmail.com'),
(3, 'Michael', 'Johnson', 'michaeljohnson@gmail.com');

INSERT INTO Courses (course_id, course_name, course_code) VALUES
(1, 'Introduction to Computer Science', 'CS101'),
(2, 'Data Structures and Algorithms', 'CS102'),
(3, 'Database Systems', 'CS103');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2024-01-15'),
(2, 1, 2, '2024-01-16'),
(3, 2, 1, '2024-01-17'),
(4, 3, 3, '2024-01-18');
-- Query to retrieve all courses enrolled by a student (e.g., student_id = 1)
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.student_id = 1;
-- Query to count the number of students in each course
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
