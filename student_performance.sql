CREATE DATABASE StudentPerformance;
USE StudentPerformance;

CREATE TABLE Students (
    studentid INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(20),
    year INT
);

CREATE TABLE Courses (
    courseid INT PRIMARY KEY,
    coursename VARCHAR(50),
    credits INT
);

CREATE TABLE Marks (
    markid INT PRIMARY KEY,
    studentid INT,
    courseid INT,
    marks INT,
    FOREIGN KEY (studentid) REFERENCES Students(studentid),
    FOREIGN KEY (courseid) REFERENCES Courses(courseid)
);

CREATE TABLE Attendance (
    attendanceid INT PRIMARY KEY,
    studentid INT,
    courseid INT,
    attendancepercentage INT,
    FOREIGN KEY (studentid) REFERENCES Students(studentid),
    FOREIGN KEY (courseid) REFERENCES Courses(courseid)
);

INSERT INTO Students VALUES
(1, 'Amit Sharma', 'CSE', 2),
(2, 'Priya Singh', 'CSE', 2),
(3, 'Ravi Das', 'ECE', 2),
(4, 'Anjali Mehta', 'ME', 3),
(5, 'Vikram Rao', 'CSE', 3),
(6, 'Sneha Patel', 'EEE', 2),
(7, 'Rohit Kumar', 'CSE', 2),
(8, 'Pooja Nair', 'ECE', 3),
(9, 'Karan Gill', 'ME', 3),
(10, 'Neha Joshi', 'CSE', 2),
(11, 'Deepak Verma', 'EEE', 3),
(12, 'Riya Gupta', 'CSE', 2);

INSERT INTO Courses VALUES
(101, 'Database Systems', 4),
(102, 'Data Structures', 3),
(103, 'Computer Networks', 3),
(104, 'Operating Systems', 4),
(105, 'Software Engineering', 3);

INSERT INTO Marks VALUES
(1, 1, 101, 88), (2, 1, 102, 76), (3, 1, 103, 85),
(4, 2, 101, 90), (5, 2, 102, 70), (6, 2, 103, 82),
(7, 3, 101, 65), (8, 3, 103, 78), (9, 3, 104, 72),
(10, 4, 101, 55), (11, 4, 102, 60), (12, 4, 104, 62),
(13, 5, 102, 89), (14, 5, 103, 93), (15, 5, 104, 88),
(16, 6, 101, 68), (17, 6, 105, 81),
(18, 7, 104, 74), (19, 7, 105, 78),
(20, 8, 103, 84), (21, 8, 104, 79),
(22, 9, 101, 57), (23, 9, 103, 64),
(24, 10, 104, 92), (25, 10, 105, 89),
(26, 11, 101, 66), (27, 11, 102, 71),
(28, 12, 101, 95), (29, 12, 102, 88);

INSERT INTO Attendance VALUES
(1, 1, 101, 87), (2, 1, 102, 91), (3, 1, 103, 89),
(4, 2, 101, 75), (5, 2, 102, 70), (6, 2, 103, 68),
(7, 3, 101, 73), (8, 3, 103, 82), (9, 3, 104, 64),
(10, 4, 101, 58), (11, 4, 102, 63), (12, 4, 104, 69),
(13, 5, 102, 90), (14, 5, 103, 93), (15, 5, 104, 88),
(16, 6, 101, 84), (17, 6, 105, 76),
(18, 7, 104, 70), (19, 7, 105, 73),
(20, 8, 103, 79), (21, 8, 104, 77),
(22, 9, 101, 50), (23, 9, 103, 59),
(24, 10, 104, 95), (25, 10, 105, 91),
(26, 11, 101, 72), (27, 11, 102, 81),
(28, 12, 101, 88), (29, 12, 102, 90);

-- Queries

SELECT s.name, AVG(m.marks) AS avgmarks
FROM Students s
JOIN Marks m ON s.studentid = m.studentid
GROUP BY s.studentid, s.name;

SELECT s.name, AVG(m.marks) AS avgmarks
FROM Students s
JOIN Marks m ON s.studentid = m.studentid
GROUP BY s.studentid, s.name
ORDER BY avgmarks DESC
LIMIT 3;

SELECT s.name, AVG(a.attendancepercentage) AS avgattendance
FROM Students s
JOIN Attendance a ON s.studentid = a.studentid
GROUP BY s.studentid, s.name
HAVING avgattendance < 75;

SELECT c.coursename, AVG(m.marks) AS avgmarks
FROM Courses c
JOIN Marks m ON c.courseid = m.courseid
GROUP BY c.courseid, c.coursename;

SELECT s.name, AVG(m.marks) AS avgmarks
FROM Students s
JOIN Marks m ON s.studentid = m.studentid
GROUP BY s.studentid, s.name
HAVING avgmarks > (SELECT AVG(marks) FROM Marks);

SELECT s.name,
       AVG(m.marks) AS avgmarks,
       AVG(a.attendancepercentage) AS avgattendance
FROM Students s
JOIN Marks m ON s.studentid = m.studentid
JOIN Attendance a ON s.studentid = a.studentid
GROUP BY s.studentid, s.name
HAVING avgmarks > 60 AND avgattendance > 75;