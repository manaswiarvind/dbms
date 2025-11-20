use newdatabase;
 
create table students(student_id int,name varchar(50),department varchar(50),year int,primary key (student_id));
create table books(book_id int,title varchar(100),author varchar(50),category varchar(30),primaRY KEY (BOOK_ID));

create table borrowedbooks(borrow_id int,student_id int,book_id int,borrow_date date,return_date date,primary key (borrow_id),foreign key (student_id) references students(student_id),foreign key (book_id) references books(book_id));

insert into students values(1,'alice johnson','computer science',2);
insert into students values(2,'bob smith','mechanical',3);
insert into students values(3,'carol white','computer science',1);
insert into students values(4,'david brown','electrical',4);

insert into books values(101,'database systems','navathe','cs');
insert into books values(102,'operating systems','silberschatz','cs');
insert into books values(103,'physics fundamentals','halliday','science');
insert into books values(104,'modern fiction','orwell','fiction');

insert into borrowedbooks values(1,1,101,'2024-01-10','2024-01-20');
insert into borrowedbooks values(2,2,103,'2024-02-01',null);
insert into borrowedbooks values(3,3,102,'2024-02-15','2024-03-01');
insert into borrowedbooks values(4,1,104,'2024-03-10',null);

/*Q1. Write an SQL query to list all students who belong to the Computer Science
department.*/
select * from students where department='computer science';

/*Q2. Write an SQL query to display the titles of all books currently not returned.*/
select title from books b,borrowedbooks bb
 where b.book_id=bb.book_id and return_date>'2024-02-10';
 
 /*Q3. Write an SQL query to find the names of students who borrowed books in
February 2024.*/
select s.name from students s,borrowedbooks bb
where bb.student_id=s.student_id and bb.borrow_date 
between '2024-02-01' and '2024-02-29';

/*Q4. Write an SQL query to show the total number of books borrowed by each
student.*/
select s.name,count(bb.book_id) from students s,borrowedbooks bb 
where s.student_id=bb.student_id group by s.name;

/*Q5. Write an SQL query to retrieve the title, author, and student name for each
borrowed book (include returned and not returned).*/
select b.title,b.author,s.name from students s,books b,borrowedbooks bb 
where bb.student_id=s.student_id and bb.book_id=b.book_id;

/*Q6. Write an SQL query to find the book(s) borrowed the most times.*/
select b.book_id from books b,borrowedbooks bb where b.book_id=bb.book_id 
group by b.book_id having 
count(*)=(SELECT MAX(borrow_count)
    FROM (
        SELECT COUNT(*) AS borrow_count
        FROM borrowedbooks
        GROUP BY book_id
    ) AS borrow_stats
);

/*Q7. Write an SQL query to list students who have never borrowed any book.*/
select s.name from students s where s.name not in 
(select s1.name from students s1,borrowedbooks bb1 
where s1.student_id=bb1.student_id);

/*Q8. Write an SQL query to count the number of books in each category.*/
select b.category,count(b.book_id) as no_of_books from books b group by b.category;
