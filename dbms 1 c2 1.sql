show databases;
create database IF NOT exists newdatabase;
use newdatabase;

create table person(driver_id varchar(10),name varchar(20),address varchar(30),primary key(driver_id));

desc person;
create table car(reg_num varchar(10),model varchar(10),year int,primary key(reg_num));
create table accident(report_num int,accident_date date,location varchar(20),primary key(report_num));
create table owns(driver_id varchar(10),reg_num varchar(10),primary key(driver_id,reg_num),foreign key(driver_id)references person(driver_id),foreign key(reg_num)references car(reg_num));

create table participated(driver_id varchar(10),reg_num varchar(10),report_num int,damage_amount int,primary key(driver_id,reg_num,report_num),foreign key(driver_id)references person(driver_id),foreign key(reg_num)references car(reg_num),foreign key(report_num)references accident(report_num));

insert into person values('A01','Richard','Srinivas nagar');
insert into person values('A02','pradeep','rajaji nagar');
insert into person values('A03','smith','ashok nagar');
insert into person values('A04','venu','n r colony');
insert into person values('A05','jhon','hanumanth nagar');

insert into car values('KA052250','INDICA',1990);
insert into car values('KA031181','LANCER',1957);
insert into car values('KA095477','TOYOTA',1998);
insert into car values('KA053408','HONDA',2008);
insert into car values('KA041702','AUDI',2005);

insert into accident values(11,'2003-01-01','Mysore Road');
insert into accident values(12,'2004-02-02','South end Circl');
insert into accident values(13,'2003-01-21','Bull temple road');
insert into accident values(14,'2008-02-08','mysore road');
insert into accident values(15,'2004-03-05','kanakpura road');
update accident set accident_date='2008-02-17' where report_num=14; 

insert into owns values('A01','KA052250');
insert into owns values('A02','KA053408');
insert into owns values('A03','KA031181');
insert into owns values('A04','KA095477');
insert into owns values('A05','KA041702');

insert into participated values('A01','KA052250',11,10000);
insert into participated values('A02','KA053408',12,50000);
insert into participated values('A03','KA095477',13,25000);
insert into participated values('A04','KA031181',14,3000);
insert into participated values('A05','KA041702',15,5000);

update participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;
select count(distinct driver_id)CNT from participated a,accident b where a.report_num=b.report_num and b.accident_date like '%08';
insert into accident values(16,'2008-03-08','Domlur');
select accident_date,location from accident;
select driver_id from participated where damage_amount>=25000;
select* from participated;
select* from accident;