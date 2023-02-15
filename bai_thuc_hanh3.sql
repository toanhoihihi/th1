use MarkManagement
create table students
(
	studentID Nvarchar(12)  primary key ,
	studentName Nvarchar(25) not null,
	dateofbirth datetime not null,
	email nvarchar(40),
	phone nvarchar(12),
	class nvarchar(10)
)
create table Subjects
(
	subjectID nvarchar(10) primary key,
	subjectName nvarchar(25) not null
)
create table Mark
(
	studentID nvarchar(12),
	subjectID nvarchar(10),
	date datetime not null,
	theory tinyint,
	Parctical tinyint,
	PRIMARY KEY (studentID, subjectID)
)


INSERT INTO students
    (studentID, studentName, dateofbirth,email, phone, class)
VALUES
    ('AV0807005', 'Mai Trung Hiếu', '11/10/1989', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
	('AV0807006', 'Nguyễn Quý Hùng', '2/12/1988', 'quyhung@yahoo.com', '0955667787', 'AV2'),
	('AV0807007', 'Đỗ Đắc Huỳnh', '2/1/1990', 'dachuynh@yahoo.com', '0988574747', 'AV2'),
	('AV0807009', 'An Đăng Khuê', '6/3/1986', 'dackhue@yahoo.com', '0986757463', 'AV1'),
	('AV0807010', 'Nguyễn T.Tuyết Lan', '12/7/1989', 'tuyetlan@yahoo.com', '0983310342', 'AV2'),
	('AV0807011','Đinh Phụng Long', '2/12/1990', 'tuananh@yahoo.com', '', 'AV3'),
	('AV0807012','Nguyễn Tuấn Nam', '2/3/1990', 'tuannam@yahoo.com', '', 'AV1');
	 
INSERT INTO Subjects
	 (subjectID,subjectName)
VALUES
	('S001','SQL'),
	('S002','Java Simplefiled'),
	('S003','Active Server Page');


INSERT INTO Mark 
	(studentID,subjectID,date,theory,Parctical)
VALUES 
	('AV0807005', 'S001','2008/05/06', 8, 25),
	('AV0807006', 'S002','2008/05/06',16, 30),
	('AV0807007', 'S001','2008/05/06', 10, 25 ),
	('AV0807009', 'S003','2008/05/06', 7, 13 ),
	('AV0807010', 'S003', '2008/05/06',9, 16 ),
	('AV0807011', 'S002', '2008/05/06',8, 30),
	('AV0807012', 'S001', '2008/05/06',7, 31 ),
	('AV0807005', 'S002', '2008/06/06',12, 11 ),
	('AV0807009', 'S003','2008/06/06', 11, 20 ),
	('AV0807010', 'S001', '2008/06/06',7, 6 );
--1
select* from students
--2
Select *
From Students
Where Class='AV1';

--3
UPDATE students
set Class = 'AV2'
where studentID='AVAV0807012' ;


--4
	SELECT  Class, COUNT(StudentID) AS 'Tổng số sinh viên'
FROM Students
GROUP BY  Class;
--5
SELECT * FROM students
Where class = 'AV2'
ORDER BY studentName;

 -- 6 
SELECT studentName 
FROM students S INNER JOIN Mark M 
ON S.studentID = M.studentID 
WHERE M.subjectID = 'S001' AND  M.theory < 10 AND M.date = '2008/5/6'
ORDER BY StudentName ASC;
-- câu 7 Hiển thị tổng số sinh viên không đạt lý thuyết môn S001. (theory <10)
SELECT COUNT(*) 
FROM students S INNER JOIN Mark M
ON S.studentID = M.studentID
WHERE M.subjectID = 'S001' AND  M.theory < 10 
-- câu 8 
SELECT * 
FROM students 
WHERE class = 'AV1' AND dateofbirth > '1980/1/1';
-- câu 9
DELETE 
FROM students 
WHERE studentID = 'AV0807011';
--câu 10
SELECT students.studentID, studentName, subjectName, theory, Parctical, date 
FROM Mark 
INNER JOIN subjects ON Mark.subjectID = subjects.subjectID 
INNER JOIN students ON Mark.studentID = students.studentID 
WHERE subjects.subjectID = 'S001' AND date = '2008/05/06';
