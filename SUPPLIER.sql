USE NEWDATABASE;
CREATE TABLE SUPPLIER (SID INT,SNAME VARCHAR(30),CITY VARCHAR(20),PRIMARY KEY (SID));
CREATE TABLE PARTS (PID INT ,PNAME VARCHAR(30),COLOR VARCHAR(30) , PRIMARY KEY (PID));
CREATE TABLE CATALOG(SID INT,PID INT ,COST INT ,FOREIGN KEY (SID) REFERENCES SUPPLIER(SID),FOREIGN KEY (PID)REFERENCES PARTS(PID) ); 

INSERT INTO SUPPLIER VALUES(10001,'MANASWI','BLR');
INSERT INTO SUPPLIER VALUES(10002,'ANKITA','MUMBAI');
INSERT INTO SUPPLIER VALUES(10003,'ANVI','NAGPUR');
INSERT INTO SUPPLIER VALUES(10004,'KIRTI','DELHI');
INSERT INTO SUPPLIER VALUES(10005,'MAHAK','PUNE');

INSERT INTO PARTS VALUES(20001,'BOOK','RED');
INSERT INTO PARTS VALUES(20002,'PEN','BLUE');
INSERT INTO PARTS VALUES(20003,'PENCIL','GREEN');
INSERT INTO PARTS VALUES(20004,'SCALE','GREEN');
INSERT INTO PARTS VALUES(20005,'CHARGER','RED');

INSERT INTO CATALOG VALUES(10001,20001,10);
INSERT INTO CATALOG VALUES(10001,20002,10);
INSERT INTO CATALOG VALUES(10002,20003,10);
INSERT INTO CATALOG VALUES(10003,20004,10);
INSERT INTO CATALOG VALUES(10003,20004,10);
INSERT INTO CATALOG VALUES(10001,20003,100);
INSERT INTO CATALOG VALUES(10001,20004,120);
INSERT INTO CATALOG VALUES(10001,20005,90);

SELECT * FROM SUPPLIER;
SELECT * FROM PARTS;
SELECT * FROM CATALOG;

SELECT DISTINCT PNAME FROM PARTS P,SUPPLIER S,CATALOG C WHERE P.PID=C.PID AND C.SID=S.SID;
SELECT SNAME FROM SUPPLIER S WHERE NOT EXISTS(SELECT P.PID FROM PARTS P WHERE NOT EXISTS (SELECT C.PID FROM CATALOG C WHERE C.SID=S.SID AND C.PID=P.PID));

SELECT SNAME FROM SUPPLIER S WHERE NOT EXISTS(SELECT P.PID FROM PARTS P WHERE P.COLOR='RED' AND NOT EXISTS(SELECT * FROM CATALOG C WHERE C.SID=S.SID AND C.PID=P.PID));



SELECT C.SID FROM CATALOG C WHERE C.COST>(SELECT AVG(C2.COST) FROM CATALOG C2 WHERE C2.PID=C.PID);

SELECT P.PNAME FROM PARTS P JOIN CATALOG C ON P.PID=C.PID JOIN SUPPLIER S ON C.SID=S.SID WHERE S.SNAME='MANASWI' AND P.PID NOT IN (SELECT C2.PID FROM CATALOG C2 JOIN SUPPLIER S2 ON C2.SID=S2.SID WHERE S2.SNAME='MANASWI');

SELECT DISTINCT S.SNAME FROM SUPPLIER S,CATALOG C,PARTS P
 WHERE C.SID=S.SID AND P.PID=C.PID AND 
 C.COST=(SELECT MAX(C2.COST) FROM CATALOG C2
 WHERE C2.PID=P.PID);
 
 /*1. Find the most expensive part overall and the supplier who supplies
it.*/
select p.pname,c.cost,s.sname from catalog c,parts p,supplier s
 where c.sid=s.sid and p.pid=c.pid and c.cost=(select max(cost) from catalog);
 
 
/* 2. Find suppliers who do NOT supply any red parts.*/
 select s.sname from supplier s where exists (select p.pid from parts p 
 where p.color="red" and not exists(select * from catalog c 
 where c.sid=s.sid and c.pid=p.pid));
 
 
/* 3. Show each supplier and total value of all parts they supply.*/
 select s.sname,sum(c.cost) as totalvalue from supplier s,catalog c 
 where s.sid=c.sid  group by s.sname;
 
 /*4. Find suppliers who supply at least 2 parts cheaper than ₹20.*/
 select s.sname from supplier s,catalog c
 where c.sid=s.sid and c.cost<20 
 group by s.sname having count(c.pid)>=2 ;
 
/*5. List suppliers who offer the cheapest cost for each part.*/
select s.sname,p.pname from supplier s,catalog c,parts p 
where s.sid=c.sid and p.pid=c.pid and 
(c.cost)=(select min(c1.cost) from catalog c1 where c1.pid=p.pid);  

/*6. Create a view showing suppliers and the total number of parts they
supply.*/
create view s1 as select s.sid,s.sname,count(c.pid) as total_parts 
from supplier s,catalog c
 where c.sid=s.sid group by s.sid,s.sname;

 /*7. Create a view of the most expensive supplier for each part.*/
 create view s3 as select p.pname,c.cost,s.sname from catalog c,parts p,supplier s
 where c.sid=s.sid and p.pid=c.pid and c.cost=(select max(c1.cost) from catalog c1
 where c1.pid=c.pid);
 
 /*Create a Trigger to prevent inserting a Catalog cost below 1.*/
 DELIMITER //
 create trigger t before insert on catalog 
 for each row 
 begin 
 if (new.cost<1) then
 signal sqlstate '45000'
 set message_text= 'improper' ;
 end if;
 end;
 
// DELIMITER ;
 
 insert into catalog values(10001,20004,0);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 