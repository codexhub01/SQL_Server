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

create table newtable2 -- to create table
(
	Id int,
	Name varchar(100),
	Department varchar(30)
);

insert into newtable2 --to insert single data
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

/*
    What is null :-

    -> value missing
    -> unknown value
    -> no data availiable
    
    Most common replacement null methods :-
    -> ISNULL()
    -> COALESCE()
    -> CASE()
*/

/*
    ISNULL() :- replace null with specified values
*/

select Username , ISNULL(designation , 'Upper level') as Desg from join1

/*
    COALESCE() :- return first non-null value

    It can have any number of parameters

    Most aggregate functions ignore null
*/

select Username , coalesce(designation , 'Upper level') as Desg from join1


/*
    Union :-

    -> It's used to combine multiple select queries into single set result
    -> It removes duplicate automatically
    
    Why Required :-

    somtime data exist in multiple tables or multiple queries

*/

select id , username from join1
union
select id , username from join2

/*
    Union all :-

    -> It's used to combine multiple select queries into single set result
    -> It do not removes duplicate automatically
    
    Why Required :-

    somtime data exist in multiple tables or multiple queries

*/

select id , username from join1
union all
select id , username from join2

/*
    Stored Precoedure :- It's a precompiled collection of sql statemnts stored inside database

    Note :- Input vs Ouput Pending
*/

CREATE PROCEDURE sp_GetEmployees -- to create a procedure
AS
BEGIN
    SELECT *
    FROM Employees;
END

exec sp_GetEmployees --to execute

CREATE PROCEDURE sp_GetEmployeeById --to create stored procedure with parameter
    @Id INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE Id = @Id;
END

EXEC sp_GetEmployeeById 1; --to execute procedure when it requires some kind of parameter

/*
    String Functions :- In built sql server functions used to manipulate text/string data

*/

select len('Mayank') -- to check length

select UPPER('mayank') -- to convert into upper

select lower('Mayank') --to convert it into lower

select SUBSTRING('shivayee',1,4) -- to get substring

select LTRIM('           omkara') --to remove space from left side

select RTRIM('gaurav              ') --to remove space from right

select TRIM('                  trim            ') -- to remove space from both side

select REPLACE('shivayee roy ' , 'roy' , 'singh oberoi') -- to replace some kind of string with something

select CHARINDEX('@','mayankpal55@gmail.com') --to find index of given character

select CONCAT('Mayank' , '       ' , 'Pal') -- to concate strings

select LEFT('omkara',2) -- to get characters from left

select right('vinay','4') -- get characters from right

/*

    Cast & Convert :- Both funtioncs are used to change data type from one type to another

    but cast does not give option for styling , instead convert gives styling too
*/

select cast(1000 as varchar)

select cast('882' as int)

select cast(getdate() as date)

select convert(varchar , getdate() , 103) --to convert type but in take care of styling too


/*

    Mathematical functions :- Built in sql server functions used for some type of performing calculations
*/

select ABS(-100) -- to convert value into positive

select CEILING(10.77) -- menas it will give int next value

select FLOOR(21.99) --give value which is before point

select ROUND(100231.218932 , 2) --give round value upto particular given number after ,

select POWER(3,4) -- basically multiplies first no by the times second no given

select sqrt(25) --to find sqaureroot

select RAND() --to generate random no

select SIGN(-199) --check sign of a number


/*
    Scalar user defined functions & Inline table valued functions & Multi statement table valued functions ( Pending )

*/

/*
    Temporary Tables :- tables create to stored internmediate or temporary data

    Required :-

    -> Intermediate calculations
    -> Temporary Storage
    -> Staged data processing

    There are tqo type of temporary tables :-
    -> Local temporary table (#) :- accessible only within current session or connection
       automatically deleted when session cloees
    -> global temporary table (##) :- access multiple session or users

*/

create table #temptable2 -- to create temprorary table which is in local storage
(
    Id int,
    designation varchar(100)
);

INSERT INTO ##temptable3
VALUES (1, 'CTO');

create table ##temptable3 -- to create temprorary table which is in global storage
(
    Id int,
    designation varchar(100)
);

/*
    Indexes :- 
    
    1. It's a database object used to improve data retrieval/query performance
    2. Indexes improve select but impact on insert , delete , update & etc
    3. Basically its fasten up our searches

    Types Of Indexes :-
    -> Clustered Index :- 
    1. It means table data physically sorted hota hai
                          only one clustedred index allowed per table because table data can physically sort only one way
    2. Usually create on primary key & identity column                     
    3. Primary key automatically create clustered index by default

    -> Non-Clustered Index

*/

create table emp_data3
(
    id int,
    name varchar(max),
    address varchar(max)
);

create clustered index IX_emp_data_id
on emp_data(Id)

/*
    View :- 
    -> A virtual table created from one or more table using select query
    -> It does not have any paramter but stored procedure have
    -> mainly select logic but stored procedure support all operations
*/

CREATE VIEW vw_EmployeeDetails -- to create view
AS
SELECT e.Name,
       d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentId = d.DepartmentId;


/*
    
    Trigger :- 
    -> A trigger is a special type of store procedure that executes automatically when a specific database events occurs
    -> cannot call directly
    -> These triggers executes automatically when :-
    1. Insert
    2. Update
    3. Delete
    operations occur on a table

    Types of DML Triggers :-
    -> After Trigger ( after operation )
    -> Instead of trigger ( replaces operation )

*/

create trigger tr_aftertrigger --to create trigger which will get hit after data inserted into table
on newtable
after insert
as
begin
print 'Employee inserted successfully'
end

INSERT INTO newtable
VALUES (1, 'Mayank' , 'CTO');


create trigger tr_after_update_trigger --to create trigger which will get hit after data update into table
on newtable
after update
as
begin
print 'Employee inserted successfully'
end

create trigger tr_after_delete_trigger --to create trigger which will get hit after data something deleted from table
on newtable
after delete
as
begin
print 'Employee inserted successfully'
end

CREATE TRIGGER tr_PreventDelete --basically in place of some kind of operation , we perform some other operation
ON newtable
INSTEAD OF DELETE
AS
BEGIN

    PRINT 'Delete Not Allowed'

END

disable trigger tr_PreventDelete -- to disable trigger
on newtable 


enable trigger tr_PreventDelete -- to enable trigger
on newtable 


drop trigger tr_PreventDelete -- to drop trigger

/*

    Derived tables & CTE ( common table expression )

    Derived tables :-
    -> A temproray result set created inside from clause using a subquery

    CTE :-
    -> temporary named result set used within a query
    -> recursive cte is for hirerichal data

*/

select * -- this is something called derived table
from(
select * from newtable2) as newtable
where Name='Mayank'

with newtable_cte -- basically its create a temporary table but that need to be used immediately
as
(select * from newtable2)
select * from newtable_cte

/*
    Database normalization :- Its a process of organizing data into proper related tables 
    -> basically duplicate data ko reduce karke database ko properly structure karna
*/

/*
    Order by :- means ordering something based on something condition or just by using asec or dsec

*/

select * from newtable2
order by id desc

/*
    Offset Fetch :- 

    -> It's used for pagination , skipping rows & fetching limited rows
    -> basically speicific rows skip karke limited rows fetch karna

*/

select * from sales.orders

SELECT customer_id -- basically it will skips 2 rows here which are at the starting and fertch next 3 rows and order by is verey imp over here
FROM sales.orders
ORDER BY customer_id
OFFSET 2 ROWS
FETCH NEXT 3 ROWS only;

/*
    Select Top :- It's used to retrieve specific number of rows from a table

*/

select * from sales.customers

select top 1 first_name from sales.customers

select distinct first_name from sales.customers -- to get distinct values

select * from sales.customers where customer_id>8 --where condition to filter

select * from sales.customers where customer_id>2 and customer_id<=10 -- And operator means both needs to be true

select * from sales.customers where customer_id>2 or customer_id<=10 -- OR operator means any one needs to be true aleast

select * from sales.customers where customer_id in (10 , 20) -- In means values which are present from these

select * from sales.customers where customer_id between 10 and 20 -- Between gives data which are present between both of given values and both are also included

/*
    Like :- used to search for a specified pattern in a column

    -> We used wildcards with LIKE :-
        1. ( % ) :- zero or more character ( means from where % will start , from there can be any number of characters )
        2. ( _ ) :- exactly one character ( means exactly one character should be only there )
     
*/

select * from sales.customers where email like 'rob%' -- this means an email starts with rob

select * from sales.customers where email like '%yahoo.com' -- this means an email ends with yahoo

select * from sales.customers where first_name like 'B__' -- this only number of spaces defined

/*

    ANY :- compare a value with values returned by subquery
    -> basically it means result which we get rfom outside query which is written before any from it result going to compare from data which we get from subquery which is written inside ANY

*/

SELECT * -- but yeah over here if any condition true then ok
FROM sales.customers
WHERE customer_id > ANY
(
    SELECT customer_id
    FROM sales.customers
    WHERE zip_code>500
);

/*
  ALL :- in this case every condition should matched

*/

SELECT * -- but yeah over here if all condition need to be true
FROM sales.customers
WHERE customer_id > ALL
(
    SELECT customer_id
    FROM sales.customers
    WHERE zip_code>500
);

/*
    INTERSECT :- returns only common rows present in both query result
    -> Automatically removed duplicates
*/

SELECT *
FROM sales.customers

INTERSECT

SELECT *
FROM sales.customers;

/*
    EXCEPT :- means it will give result from first query only but except those whoch are in a result got from subquery 

*/

/*
    PIVOT ( Pending ) :- It's used to transform rolws into cloumns
*/

/*
    INSERT :- It's used to add rows into a table

    -> It's DML ( data manipulatin language ) command
    -> You can insert specific values too in specific columns , instead of inserting values into all columns
*/

/*
    Update :- 
    
    -> modify existing records into a table
    -> It's DML command too

*/

update sales.customers set first_name='Mayank' where customer_id=5

UPDATE sales.customers
SET first_name = 'heeji aap kaun'
OUTPUT inserted.*, deleted.*;

/*
    Merge :- to perform insert , update & delete operations in a single statement

*/

/*
    Transaction :- 
    
    -> a group of operations executed in a single unit of work
    -> In this all operations will get succesd or get fails
    -> Start Transaction :- Begin Transaction
    -> Commit Transaction :- Commit
    -> Rollback Transaction :- Rollback
    -> First it write longs then data ( WAL )

    ACID properties :-
    1. Atomicity :- Either complete success or complete failure
    2. Consistency :- Datbaase remains vaid before & after transaction
    3. Isolation :- Transaction should not interfere with each other
    4. Durability :- commited data survives during crash , restart & power failure

    After commit rollback is not possible

    Dirty Read :- let suppose transaction A updates salary but does not commit and transaction B reads that updated salary but now Transaction A have roll back that , so for now Transaction B reads invalid data
*/

CREATE TABLE Accounts
(
    Id INT PRIMARY KEY,
    AccountHolderName VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts (Id, AccountHolderName, Balance)
VALUES
(1, 'Mayank', 25000.00),
(2, 'Rahul', 15000.00),
(3, 'Aman', 30000.00),
(4, 'Neha', 12000.00);

SELECT * FROM Accounts;

BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE Id = 1;

UPDATE Accounts
SET Balance = Balance + 5000
WHERE Id = 2;

COMMIT;

BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE Id = 1;

ROLLBACK;


BEGIN TRANSACTION; -- here partial roll back done & we are saving data at some point

UPDATE sales.customers
SET customer_id = customer_id + 1000;

SAVE TRANSACTION BeforeDelete;

DELETE FROM sales.customers
WHERE customer_id = 5;

ROLLBACK TRANSACTION BeforeDelete;

/*
    CREATE SCHEMA :- This is something which we can create our custom to , if we are not creating something custom too then its use bydefault one which is dbo.something

    And in this case we run queries in simpler way without using schema name

    dbo :- database owner which is by default

    select * from employees

*/

/*
    Sequence :- 
    
    -> A database object used to generate sequential numeric values
    -> It automatically generates numbers and independently from tables
*/

CREATE SEQUENCE sample_sequence -- to create sequence
START WITH 1
INCREMENT BY 1;

select next value for sample_sequence -- getting next sequence value

/*
    Primary Key :- 

    -> uniquely identifies each row in a table
    -> does not allow null values
    -> automatically creates unique index
    -> one primary key per table

    Composite primary key :-
    -> primary key can contains multiple columns together

    Unique key :-
    -> multiple allowed
    -> one null aloowed
    -> ensure uniqueness

*/
CREATE TABLE OrderDetails
(
    OrderId INT,
    ProductId INT,

    PRIMARY KEY(OrderId, ProductId)
);

/*
    Row_number() :- It's used to assign a unique sequential number to each row


*/

select * from sales.order_items

SELECT product_id, -- Here rownumber() ovr gives unique sequential number to each row
       list_price,

       ROW_NUMBER() OVER
       (
           ORDER BY product_id DESC
       ) AS RowNum

FROM sales.order_items;