use newdatabase;
create table branch(branchname varchar(30),branchcity varchar(30) ,assessts real,primary key(branchname));
desc branch;
create table bankaccount(accno integer,branchname varchar(30),balance real,primary key(accno),foreign key(branchname) references branch(branchname));
desc bankaccount;
create table bankcustomer(customername varchar(30),customersteer varchar(30),customercity varchar(30),primary key(customername));
desc bankcustomer;
create table depositer(customername varchar(30),accno integer,primary key(customername,accno),foreign key(customername) references bankcustomer(customername),foreign key(accno) references bankaccount(accno));
desc depositer;
create table loan(loannumber int,branchname varchar(30),amount real,primary key(loannumber),foreign key(branchname)references branch(branchname));
desc loan;

select*  from branch;
select* from loan;
select* from bankaccount;
insert into branch values('SBI_Chamrajpet','bangalore',50000);
insert into branch values('SBI_ResidencyRoad','bangalore',10000);
insert into branch values('SBI_ShivajiRoad','Bombay',20000);
insert into branch values('SBI_ParliamnetRoad','Delhi',10000);
insert into branch values('SBI_Jantarmantar','Delhi',20000);

insert into loan values(1,'SBI_Chamrajpet',1000);
insert into loan values(2,'SBI_ResidencyRoad',2000);
insert into loan values(3,'SBI_ShivajiRoad',3000);
insert into loan values(4,'SBI_ParliamnetRoad',4000);
insert into loan values(5,'SBI_Jantarmantar',5000);


insert into bankaccount values(1,'SBI_Chamrajpet',2000);
insert into bankaccount values(2,'SBI_ResidencyRoad',5000);
insert into bankaccount values(3,'SBI_ShivajiRoad',6000);
insert into bankaccount values(4,'SBI_ParliamnetRoad',9000);
insert into bankaccount values(5,'SBI_Jantarmantar',8000);

insert into depositer values('Avinash',1);
insert into depositer values('Dinesh',2);
insert into depositer values('Nikhil',4);
insert into depositer values('Ravi',5);
insert into depositer values('Avinash',8);

insert into bankcustomer values('Avinash','Bull_Temple_Road','Bangalore');
insert into bankcustomer values('Dinesh','Bannergatta_Road','Bangalore');
insert into bankcustomer values('Mohan','National_College_Road','Bangalore');
insert into bankcustomer values('Nikhil','Akbar_Road','Delhi');
insert into bankcustomer values('Ravi','Prithviraj_Road','Delhi');
