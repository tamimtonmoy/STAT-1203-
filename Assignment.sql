create database assignment;
use assignment;

CREATE TABLE Student_Programs (
    STUDENT_REF_ID INT PRIMARY KEY,
    PROGRAM_NAME VARCHAR(100) NOT NULL,
    PROGRAM_START_DATE DATETIME NOT NULL
);


INSERT INTO Student_Programs (STUDENT_REF_ID, PROGRAM_NAME, PROGRAM_START_DATE)
VALUES
(201, 'Computer Science', '2021-09-01 00:00:00'),
(202, 'Mathematics', '2021-09-01 00:00:00'),
(208, 'Mathematics', '2021-09-01 00:00:00'),
(205, 'Physics', '2021-09-01 00:00:00'),
(204, 'Chemistry', '2021-09-01 00:00:00'),
(207, 'Psychology', '2021-09-01 00:00:00'),
(206, 'History', '2021-09-01 00:00:00'),
(203, 'Biology', '2021-09-01 00:00:00');

CREATE TABLE Student (
    STUDENT_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    GPA DECIMAL(4,2) NOT NULL,
    ENROLLMENT_DATE DATETIME NOT NULL,
    MAJOR VARCHAR(100) NOT NULL
);

INSERT INTO Student (STUDENT_ID, FIRST_NAME, LAST_NAME, GPA, ENROLLMENT_DATE, MAJOR)
VALUES
(201, 'Shivansh', 'Mahajan', 8.79, '2021-09-01 09:30:00', 'Computer Science'),
(202, 'Umesh', 'Sharma', 8.44, '2021-09-01 08:30:00', 'Mathematics'),
(203, 'Rakesh', 'Kumar', 5.60, '2021-09-01 10:00:00', 'Biology'),
(204, 'Radha', 'Sharma', 9.20, '2021-09-01 12:45:00', 'Chemistry'),
(205, 'Kush', 'Kumar', 7.85, '2021-09-01 08:30:00', 'Physics'),
(206, 'Prem', 'Chopra', 9.56, '2021-09-01 09:24:00', 'History'),
(207, 'Pankaj', 'Vats', 9.78, '2021-09-01 02:30:00', 'English'),
(208, 'Navleen', 'Kaur', 7.00, '2021-09-01 06:30:00', 'Mathematics');

use assignment;
CREATE TABLE Scholarship (
    Student_Ref_ID INT PRIMARY KEY,
    Scholarship_Amount DECIMAL(10,2),
    Scholarship_Date DATETIME
);

INSERT INTO Scholarship (Student_Ref_ID, Scholarship_Amount, Scholarship_Date) VALUES
(201, 5000, '2021-10-15'),
(202, 4500, '2022-08-18'),
(203, 3000, '2022-01-25'),
(204, 4000, '2021-10-15');
use assignment;
CREATE VIEW uppercase_names AS
SELECT UPPER(FIRST_NAME) AS STUDENT_NAME
FROM student;

CREATE VIEW unique_majors AS
SELECT DISTINCT PROGRAM_NAME
FROM student_programs;

CREATE VIEW first3_characters  AS
SELECT SUBSTRING(FIRST_NAME, 1, 3) AS FIRST3_CHARACTERS
FROM student;

CREATE VIEW position_of_a AS
SELECT INSTR(LOWER(FIRST_NAME), 'a') AS POSITION_OF_A
FROM student
WHERE FIRST_NAME = 'Shivansh';

CREATE VIEW unique_Majors_with_length as select distinct major, length (major) from student ;

CREATE VIEW First_Name_Replaced as select replace(FIRST_NAME, 'a','A') FROM student;

CREATE VIEW Student_complete_Names as select concat(FIRST_NAME,'', LAST_NAME) AS COMPLETE_NAME FROM student;
 
CREATE VIEW student_ordertable as select * from student order by FIRST_NAME ASC , MAJOR DESC ;
 
 CREATE VIEW Prem_And_Shivansh_Students AS
SELECT * 
FROM Student 
WHERE FIRST_NAME IN ('Prem', 'Shivansh');
 
 CREATE VIEW Students_Excluding_Prem_Shivansh AS
SELECT * 
FROM Student 
WHERE FIRST_NAME NOT IN ('Prem', 'Shivansh');
 

CREATE VIEW Students_With_Name_Ending_A AS
SELECT * FROM Student WHERE FIRST_NAME LIKE '%a';
 
 CREATE VIEW Students_With_5Letter_Name_Ending_A AS
SELECT * FROM Student WHERE FIRST_NAME LIKE '__a';

CREATE VIEW HighGPAStudents AS
SELECT * FROM Student WHERE GPA BETWEEN 9.00 AND 9.99;
 
 CREATE VIEW ComputerScienceCount AS
SELECT Major, COUNT(*) as TOTAL_COUNT FROM Student WHERE MAJOR = 'Computer Science';
 
 CREATE VIEW HighAchievers AS
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME FROM Student WHERE GPA BETWEEN 8.5 AND 9.5;
 
 CREATE VIEW MajorDistribution AS
SELECT MAJOR, COUNT(MAJOR) as STUDENT_COUNT FROM Student GROUP BY MAJOR ORDER BY COUNT(MAJOR) DESC;
 
CREATE VIEW ScholarshipRecipients AS
SELECT
    Student.FIRST_NAME,
    Student.LAST_NAME,
    Scholarship.SCHOLARSHIP_AMOUNT,
    Scholarship.SCHOLARSHIP_DATE
FROM
    Student
INNER JOIN
    Scholarship ON Student.STUDENT_ID = Scholarship.STUDENT_REF_ID;
    
    CREATE VIEW OddRowStudents AS
SELECT * FROM Student WHERE student_id % 2 != 0;
 
 CREATE VIEW EvenRowStudents AS
SELECT * FROM Student WHERE student_id % 2 = 0;


CREATE VIEW StudentScholarships AS
SELECT 
    Student.FIRST_NAME, 
    Student.LAST_NAME, 
    Scholarship.SCHOLARSHIP_AMOUNT, 
    Scholarship.SCHOLARSHIP_DATE 
FROM 
    Student 
LEFT JOIN 
    Scholarship ON Student.STUDENT_ID = Scholarship.STUDENT_REF_ID;
    
CREATE VIEW Top5Students AS
SELECT * FROM Student ORDER BY GPA DESC LIMIT 5;
    
    CREATE VIEW NthHighestGPA AS
SELECT * FROM Student ORDER BY GPA DESC LIMIT 4, 1;
    
    CREATE VIEW FifthHighestGPA AS
SELECT * FROM Student s1 
WHERE 4 = (
    SELECT COUNT(DISTINCT(s2.GPA)) 
    FROM Student s2 
    WHERE s2.GPA >= s1.GPA
);

CREATE VIEW StudentsWithSameGPA AS
SELECT s1.* 
FROM Student s1, Student s2 
WHERE s1.GPA = s2.GPA AND s1.STUDENT_ID != s2.STUDENT_ID;

CREATE VIEW SecondHighestGPA AS
SELECT MAX(GPA) FROM Student 
WHERE GPA NOT IN (SELECT MAX(GPA) FROM Student);
CREATE VIEW show_one_row_twice AS
SELECT * FROM Student
UNION ALL
SELECT * FROM Student
ORDER BY STUDENT_ID;

CREATE VIEW no_scholarship AS
SELECT STUDENT_ID 
FROM Student 
WHERE STUDENT_ID NOT IN (
    SELECT STUDENT_REF_ID 
    FROM Scholarship
);

CREATE VIEW first_50_percent AS
SELECT FLOOR(COUNT(*) / 2) AS half_count
FROM Student;

CREATE VIEW major_less_than_4 AS
SELECT MAJOR, COUNT(MAJOR) AS MAJOR_COUNT 
FROM Student 
GROUP BY MAJOR 
HAVING COUNT(MAJOR) < 4;

CREATE VIEW major_count AS
SELECT MAJOR, COUNT(MAJOR) AS ALL_MAJOR 
FROM Student 
GROUP BY MAJOR;

CREATE VIEW first_row AS
SELECT * 
FROM Student 
WHERE STUDENT_ID = (
    SELECT MIN(STUDENT_ID) 
    FROM Student
);


CREATE VIEW last_five_records AS
SELECT * 
FROM (
    SELECT * 
    FROM Student 
    ORDER BY STUDENT_ID DESC 
    LIMIT 5
) AS subquery
ORDER BY STUDENT_ID;

CREATE VIEW three_max_gpa AS
SELECT DISTINCT GPA
FROM Student S1
WHERE 3 >= (
    SELECT COUNT(DISTINCT GPA)
    FROM Student S2
    WHERE S1.GPA <= S2.GPA
)
ORDER BY GPA DESC;

CREATE VIEW three_min_gpa AS
SELECT DISTINCT GPA
FROM Student S1
WHERE 3 >= (
    SELECT COUNT(DISTINCT GPA)
    FROM Student S2
    WHERE S1.GPA >= S2.GPA
)
ORDER BY GPA ASC;

CREATE VIEW nth_max_gpa AS
SELECT DISTINCT GPA
FROM Student S1
WHERE 2 = (
    SELECT COUNT(DISTINCT GPA)
    FROM Student S2
    WHERE S1.GPA < S2.GPA
)
ORDER BY GPA DESC;

CREATE VIEW Max_GPA_By_Major AS
SELECT MAJOR, MAX(GPA) AS MaxGPA
FROM Student
GROUP BY MAJOR;

CREATE VIEW Highest_GPA_Student AS
SELECT FIRST_NAME, GPA
FROM Student
WHERE GPA = (SELECT MAX(GPA) FROM Student);

CREATE VIEW Current_Date_And_Time AS
SELECT CURDATE() AS CurrentDate, NOW() AS CurrentDateTime;

CREATE VIEW clone_student_table AS
SELECT * FROM Student;

CREATE VIEW ComputerScienceUpdatedGPA AS
SELECT *, 7.5 AS UpdatedGPA
FROM Student
WHERE MAJOR = 'Computer Science';

CREATE VIEW Avg_GPA_for_each_Major AS
SELECT MAJOR, AVG(GPA) AS AVERAGE_GPA
FROM Student
GROUP BY MAJOR;

CREATE VIEW Top_3_Students_Highest_GPA AS
SELECT * 
FROM Student
ORDER BY GPA DESC
LIMIT 3;

CREATE VIEW number_of_student_GPA_Count_By_Major AS
SELECT MAJOR, COUNT(STUDENT_ID) AS HIGH_GPA_COUNT
FROM Student
WHERE GPA > 7.5
GROUP BY MAJOR;

