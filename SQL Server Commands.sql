create database sample_db --To create db

use sample_db --to use any db

alter database sample_db --to rename db name
modify name = new_db;

alter database sample_db -- changing database mode
set readonly

drop database sample_db --to drop database

alter database sample_db --to drop that db which is in use
set single_user
with rollback immediate;
drop database sample_db

create table newtable -- to create table
(
	Id int,
	Name varchar(100),
	Department varchar(30)
);

insert into newtable --to insert single data
values(1,'Mayank','IT');

insert into newtable --to insert multiple data
values(2,'Om','Nontech') , (3,'Roy','CSE');

select * from identitytbl --to view data from table

update newtable set Department='Foodlab' where Id=3 --toupdate in db'

delete from newtable where id=2 -- to delete from db

delete from newtable --to delete all from db

drop table newtable -- to delete that table permanently

alter table newtable --to add new column
add salary int

alter table newtable --to add remove column
drop column salary


exec sp_rename 'newtable.salary','empsalary' , 'Column' --to rename column name

create table defaultvaluetable --to create some kind of column with some kind of default value
(
	ID int,
	Name varchar(50),
	Status varchar(50) default 'active'
);

insert into defaultvaluetable(Id , Name) --to insert data into specific columns and default value will automatically insert into rest column
values(1,'Car Engine')

alter table defaultvaluetable
add constraint roy
default value for name

CREATE TABLE Departments
(
    DepartmentId INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees
(
    EmployeeId INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentId INT
    FOREIGN KEY REFERENCES Departments(DepartmentId) --to create cascading refrential integrity
    ON DELETE CASCADE
);

INSERT INTO Departments (DepartmentId, DepartmentName)
VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employees (EmployeeId, Name, DepartmentId)
VALUES
(101, 'Mayank', 2),
(102, 'Rahul', 1),
(103, 'Sneha', 3),
(104, 'Aman', 2),
(105, 'Priya', 4),
(106, 'Karan', 1);

DELETE FROM Departments
WHERE DepartmentId = 1;

--FOREIGN key references departments(DepartmentId)
--on updated cascade

CREATE TABLE empdata --to add contsrint for a column which means there are some kind of condition on which base data is going to enter
(
    Id INT,
    Name VARCHAR(100),
    Age INT CHECK (Age >= 18)
);

INSERT INTO Employees
VALUES (2, 'Rahul', 15);

CREATE TABLE identitytbl1 --to add indentity for some kind of specific column in which values got increment automatically by some no which we write over there
(
    Id INT IDENTITY(1,1),
    Name VARCHAR(100)
);

INSERT INTO identitytbl1(Name)
VALUES ('non'),
('abc');

set identity_insert identitytbl ON --this means that now we can insert our custom value into that column by themself 
set identity_insert identitytbl OFF --this means that now we can't insert our custom value into that column by themself 

select SCOPE_IDENTITY() --it will give last generated value in a that session or ssope

select @@IDENTITY()

select IDENT_CURRENT('identitytbl') :- --it can give u of any session or any table

CREATE TABLE uniquetbl --to add unique constraint for a column in a table
(
    Id INT,
    Email VARCHAR(100) UNIQUE
);

INSERT INTO uniquetbl
VALUES (1, 'mayank@gmail.com');

INSERT INTO uniquetbl
VALUES (1, 'mayank@gmail.com');

create table groupingtable
(
    Id int,
    Username varchar(max),
    designation varchar(max)
);

insert into join1
values(5,'danny' , 'unknown'),(6,'dj','actor')

select * from groupingtable

select username , count(*) from groupingtable group by Username --to gorup stuffs based on somethinng

select username , count(*) from groupingtable group by Username having count(*) <3 --having with group by

create table join2
(
    Id int,
    Username varchar(max),
   
);

select join1.designation , join2.Username from join1 -- inner join only return matching records from both table
inner join join2
on join1.id = join2.Id

/*
    left join :-
    
    -> Return all rows from left table matching all rows from right table
    -> If no match return null
    -> table which is using with from that's a left table
*/

select join1.designation , join2.Username from join1
left join join2
on join1.id = join2.Id

/*
    right join :-
    
    -> Return all rows from right table matching all rows from left table
    -> If no match return null
    -> table which is using with from that's a right table
*/


select join1.designation , join2.Username from join1
right join join2
on join1.id = join2.Id

/*
    full join :-
    
    -> Return all rows from both table , which are matched those will get combines & if something is unmatched also then it will show data of that table which have data and forn column of those table which do not have data for them it will give NULL
    -> table which is using with from that's a right table
*/

SELECT join1.designation,
       join2.Username
FROM join1
FULL JOIN join2
ON join1.id = join2.Id;

/*
    Why alisa is used

    -> basically for shorted queries
    -> readibility
    -> easier joins
*/

SELECT j1.designation,
       j2.Username
FROM join1 j1
inner join join2 j2
ON j1.id = j2.Id;

/*
    Self Join :-

    -> When table join with itself
*/

SELECT j1.designation,
       j1.Username
FROM join1 j1
left join join1 j2
ON j1.id = j2.Id;

/*
    Cross Join :-
    
    -> Cartesian product every row with every row
*/

select * from join1
cross join join2






















