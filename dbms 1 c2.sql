show databases;

create database IF NOT exists newdatabase;

use newdatabase;

create table Student
(
stdid INT(5), stdname varchar(20), dob date,doj date,fee INT(5),gender char
);
DESC STUDENT;
INSERT INTO STUDENT(stdid,stdname,dob,doj,fee,gender)
VALUES(1,'Manaswi','2006-10-17','2024-09-26',10000,'F');

INSERT INTO STUDENT(stdid,stdname,dob,doj,fee,gender)
VALUES(2,'Kirti','2006-08-07','2024-08-7',11000,'F');


ALTER TABLE STUDENT ADD PHONE_NO int;
ALTER TABLE STUDENT rename column phone_no to student_no;
ALTER TABLE STUDENT rename to STUDENT_INFO;
ALTER TABLE student_info drop column gender;
delete from student_info where stdid=2;

select * from STUDENT_INFO;

