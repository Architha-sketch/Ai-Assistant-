#TASK-1
-- Create tables Students, Courses, Enrollments with keys and relationships
drop table if exists Enrollments;
drop table if exists Students;
drop table if exists Courses;

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






#TASK-2
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;

-- Create tables for Doctors, Patients, Appointments
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Insert sample data into Doctors, Patients, Appointments tables
INSERT INTO Doctors (doctor_id, first_name, last_name, specialty) VALUES
(1, 'Dr. Smith', 'Johnson', 'Cardiology'),
(2, 'Dr. Sarah', 'Davis', 'Pediatrics'),
(3, 'Dr. Michael', 'Brown', 'Orthopedics');

INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth) VALUES
(1, 'John', 'Doe', '1985-05-15'),
(2, 'Jane', 'Smith', '1990-08-22'),
(3, 'Michael', 'Williams', '1975-12-10');

INSERT INTO Appointments (appointment_id, doctor_id, patient_id, appointment_date) VALUES
(1, 1, 1, '2023-06-01'),
(2, 2, 2, '2023-06-02'),
(3, 3, 3, '2023-06-03');

-- Get all appointments for a specific doctor
SELECT d.first_name, d.last_name, p.first_name, p.last_name, a.appointment_date
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
WHERE d.doctor_id = 1;

-- List patient history by patient ID
SELECT p.first_name, p.last_name, a.appointment_date, d.first_name, d.last_name, d.specialty
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE p.patient_id = 2;

-- Count total patients treated by each doctor
SELECT d.first_name, d.last_name, COUNT(a.patient_id) AS patient_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;





#TASK-3
--SELECT d.first_name, d.last_name, COUNT(a.patient_id) AS patient_count
--FROM Doctors d
--LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
--GROUP BY d.doctor_id;

-- create tables books, members, loans
CREATE TABLE Books (
    BookID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Author TEXT NOT NULL,
    PublishedYear INTEGER NOT NULL
);

-- Create Members table
CREATE TABLE Members (
    MemberID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    MembershipDate TEXT NOT NULL
);

-- Create Loans table
CREATE TABLE Loans (
    LoanID INTEGER PRIMARY KEY AUTOINCREMENT,
    BookID INTEGER,
    MemberID INTEGER,
    LoanDate TEXT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert data
INSERT INTO Books (Title, Author, PublishedYear)
VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', 1925);

INSERT INTO Members (FirstName, LastName, MembershipDate)
VALUES ('Alice', 'Smith', '2020-01-01');

INSERT INTO Loans (BookID, MemberID, LoanDate)
VALUES (1, 1, '2024-06-01');

-- Retrieve all books currently issued
SELECT b.Title, m.FirstName, m.LastName, l.LoanDate
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Members m ON l.MemberID = m.MemberID;

-- Find overdue books (Loan date > 30 days)
SELECT b.Title, m.FirstName, m.LastName, l.LoanDate
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Members m ON l.MemberID = m.MemberID
WHERE DATE(l.LoanDate) < DATE('now', '-30 days');

-- Count number of books loaned by each member
SELECT m.FirstName, m.LastName, COUNT(l.BookID) AS TotalBooks
FROM Members m
LEFT JOIN Loans l ON m.MemberID = l.MemberID
GROUP BY m.MemberID;







#TASK-4
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Users;

-- create tables Users, Products, Orders, OrderDetails
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT NOT NULL,
    Price REAL NOT NULL
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER,
    OrderDate TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data
INSERT INTO Users (FirstName, LastName, Email) VALUES
('John', 'Doe', 'johndoe@gmail.com'),
('Jane', 'Smith', 'janesmith@gmail.com');

INSERT INTO Products (ProductName, Price) VALUES
('Laptop', 999.99),
('Smartphone', 499.99);

INSERT INTO Orders (UserID, OrderDate) VALUES
(1, '2024-06-01'),
(2, '2024-06-02');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 2, 1);

-- retrieve all orders by a user
SELECT u.FirstName, u.LastName, o.OrderDate, p.ProductName, od.Quantity
FROM Users u
JOIN Orders o ON u.UserID = o.UserID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE u.UserID = 1;

-- Find the most purchased product
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID
ORDER BY TotalQuantity DESC
LIMIT 1;

-- calculate total revenue in a given month
SELECT strftime('%Y-%m', o.OrderDate) AS OrderMonth, SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY OrderMonth
ORDER BY OrderMonth;







#TASK-5
-- Create tables: Student, Subjects, Exams, Results with primary keys, foreign keys, and constraints
CREATE TABLE Student (
    StudentID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    DateOfBirth DATE NOT NULL
);

CREATE TABLE Subjects (
    SubjectID INTEGER PRIMARY KEY AUTOINCREMENT,
    SubjectName TEXT NOT NULL
);

CREATE TABLE Exams (
    ExamID INTEGER PRIMARY KEY AUTOINCREMENT,
    SubjectID INTEGER,
    ExamDate DATE NOT NULL,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

CREATE TABLE Results (
    ResultID INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentID INTEGER,
    ExamID INTEGER,
    Score INTEGER NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
);

-- Insert sample data into Student, Subjects, Exams, Results tables
INSERT INTO Student (FirstName, LastName, DateOfBirth) VALUES
('John', 'Doe', '2005-05-15'),
('Jane', 'Smith', '2006-02-20');

INSERT INTO Subjects (SubjectName) VALUES
('Mathematics'),
('Science');

INSERT INTO Exams (SubjectID, ExamDate) VALUES
(1, '2024-06-01'),
(2, '2024-06-01');

INSERT INTO Results (StudentID, ExamID, Score) VALUES
(1, 1, 85),
(1, 2, 90),
(2, 1, 75),
(2, 2, 88);

-- Select individual result for a student
-- Including subject name and marks for a student
SELECT s.FirstName, s.LastName, sub.SubjectName, r.Score
FROM Student s
JOIN Results r ON s.StudentID = r.StudentID
JOIN Exams e ON r.ExamID = e.ExamID
JOIN Subjects sub ON e.SubjectID = sub.SubjectID
WHERE s.StudentID = 1;

-- Calculate average marks for each subject
SELECT sub.SubjectName, AVG(r.Score) AS AverageScore
FROM Subjects sub
JOIN Exams e ON sub.SubjectID = e.SubjectID
JOIN Results r ON e.ExamID = r.ExamID
GROUP BY sub.SubjectID;