
## Window Functions

#Rank
use world;
select * from Country;

select rank() over(order by GNP desc) as Ranking,
Country_name, continent, GNP 
from country;

select rank() over(order by GNP/Population desc) as Ranking,
Country_name, continent, GNP 
from country;

select rank() over(partition by Continent order by GNP/Population desc) as Ranking,
Country_name, continent, GNP 
from country;

select rank() over(order by GNP/population desc) as Ranking,
Country_name, continent, GNP, round(GNP*1000/Population,2) as GNP_Per_Cap
from country
limit 20;

#Denserank -> [Doesnt skip ranking value given to equal data, Rank skip the rank]
select dense_rank() over(partition by Continent,Region order by GNP/population desc,GNP desc) as Dense_Ranking,
Country_name, Region, continent, GNP, round(GNP*1000/Population,2) as GNP_Per_Cap
from country;

# LEarn Denserank vs Rank
#Rank : 1,2,3,3,5,6,6,8
#Denserank: 1,2,3,3,4,5,5,6


#Ntile - Breaks data into cluster i.e ntile(4) = 4 cluster [ SQL NTILE() function is a window function that distributes rows of an ordered partition into a pre-defined number of roughly equal groups.]

select country_name,continent,region,LifeExpectancy,
ntile(4) over(order by LifeExpectancy desc) as Clusters
from country;

# Sum Over
use world;
# Order by GNP and after that sum the GNP
select Country_name,Continent,GNP, sum(GNP) over(order by GNP desc) as Cum_GNP from Country;

#Avg Over
select Country_name,Continent,GNP, avg(GNP) over(order by GNP desc) as Cum_GNP from Country;

#Lag and Lead Function
	#lag- (Compare current quarter with previous quarter)
select Country_name,Continent,GNP, lag(GNP) over(order by GNP desc) as Prev_GNP from Country;
	#lead
select Country_name,Continent,GNP, lead(GNP) over(order by GNP desc) as Prev_GNP from Country;

##### Data for Joint
create database ineuron;
use ineuron;
create Table Demographic (Id Varchar(20), age int, gender char(1), salary int, city varchar(20));
create Table Professional (Id Varchar(20), Name Varchar(20), Dept varchar(10), Manager varchar(20));

Insert into Demographic 
values (201,25,"M",20000,"Beng"),(202,32,"F",25000,"Mum"),(203,40,"F",20000,"Mum"),(204,23,"M",22000,"Che");

Insert into Professional 
values (202,"Shree","Mar","Ram"), (204,"Ram","Fin","Atul"),(211,"Priya","HR","Raj"),(212,"Ritu","Ops","Amar");

##Joint
	#Inner
    #Full
    #Left
    #Right
    #Self

#Inner
select * from demographic;

select demographic.id,Age,Gender,Dept,Manager
from demographic 
inner join Professional
on demographic.id = Professional.id;   

select d.id,Age,Gender,Dept,Manager
from demographic as d
inner join Professional as p
on d.id = P.id; 

  #Full
select * from demographic;
select * from professional;
# Check the syntex
select d.id,Age,Gender,Dept,Manager
from demographic as d
FULL OUTER JOIN Professional as p
on d.id = P.id; 



#Left (joining right table to left table)

select d.id,Age,Gender,Dept,Manager
from demographic as d
left join Professional as p
on d.id = P.id; 

select p.id,Age,Gender,Dept,Manager
from Professional as p
left join demographic as d
on d.id = P.id; 

#Right

select p.id,Age,Dept,Manager,Salary
from demographic d
right join professional p
on d.id = P.id;    

# Full Outer Join

select d.id,Age,Gender,Dept,Salary from demographic d
left join 
professional p
on d.id = p.id

union

select p.id,age,Gender,Dept,Salary
from demographic d
right join professional p
on d.id = p.id;

#Joining Three table
 



## SubQuery
create database hr_emp;

	## Use case of Subqueries(nested) query
    
    use hr_emp;
    
    select * from employees
    where department_id = 73;

	select department_id from employees
    where manager_id = 186;
    
    select distinct department_id from employees
    where manager_id = 186;
   #Combined above two query in one 
   select * from employees
    where department_id = (
    select distinct department_id from employees
    where manager_id = 186
    );
	
    ## Fetch the data of all employee where manager_id are either 60,80,186
    select * from employees
    where department_id in (select distinct department_id from employees
    where manager_id in (60,80,186)
    )
    
    ## Provide the details of all employee earning equal to Purv.
select * from employees 
where salary = (select salary from employees where first_name = "Purv");
	
    ## fetch data of all employee where salary > Overall avg salary
    
    select * from employees
    where salary > (select avg(salary) from employees);

	## Fetch data of all employee who are earning more than average in their respective departments.
    

#### Database object
	#Tables
    #Views - [table which is reflected when called upon but not stored ]
    #Stored Procedures
    #Function
    
    # Views
use world;
select * from country;
select * from city;
select * from countrylanguage;

# This gets stored as a view [Creating table requires space, view is virtual table, its store query output]
create view GistOfCountries as
select Country_name, Continent, Region, SurfaceArea, IndepYear, LifeExpectancy, GNP
from Country;

select * from GistOfCountries; # query fro view


use hr_emp;

create view emp_more_than_avg_salary as
select * from employees
where salary > (select avg(salary) from employees);

select employee_id, first_name, last_name from emp_more_than_avg_salary;

use ineuron;

create view Common_Data as
select d.id, Name, Age, Gender, Salary, city, Dept, Manager 
from demographic d
join professional p 
on d.id = p.id;

select * from Common_data;

create or replace view Common_Data as
select d.id, Name, Age, Gender, Salary, city, Dept, Manager 
from demographic d, professional p 
where d.id = p.id;

# Stored Procedure -  A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
#Note: View is virtual table, View is storing table itslef virtually, Stored Procedure  stores command

/*

create storedPropertyName()
Begin
   Query
End

*/
use world;


Delimiter //
create procedure AllCityData()
begin
select * from city;
end //
Delimiter ;

call AllCityData;

#
Delimiter //
create procedure Continent_LE()
begin
select Continent, round(Avg(LifeExpectancy),2) as AVG_LE
from country
group by Continent
order by AVG_LE desc;
end //
Delimiter ;

call Continent_LE()
###################

select City,Country_name, ci.Population,
rank() over(Partition by Country_name order by Population) as Rank_no
from city ci
left join country co
on ci.CountryCode = co.code
where co.country_name = 'India';

# Write as query to pass input in it 
###################

delimiter //
create procedure City_Population_Data(In name_of_country varchar(20))
Begin
select City,Country_name, ci.Population,
rank() over(Partition by Country_name order by Population) as Rank_no
from city ci
left join country co
on ci.CountryCode = co.code
where co.country_name = name_of_country;
end //
delimiter ;

call City_Population_Data("India")

delimiter //
create procedure City_Population_DataMultile_country(In First_Country varchar(20), Second_Country varchar(20))
Begin
select City,Country_name, ci.Population,
rank() over(Partition by Country_name order by Population) as Rank_no
from city ci
left join country co
on ci.CountryCode = co.code
where co.country_name IN(First_Country,Second_Country);
end //
delimiter ;

call City_Population_DataMultile_country("India",'Itly')

### CTE - Common table expression
/*
A Common Table Expression (CTE) is the result set of a query which exists temporarily and for use only within the context of a larger query. Much like a derived table, 
the result of a CTE is not stored and exists only for the duration of the query. This article will focus on non-recurrsive CTEs.

In CTE it dose not store anything

Uses:


*/

use hr_emp;


with Departmentwiseavgsalary as(
select department_id,count(manager_id) as No_of_Managers,round(avg(salary),0) as Avg_Salary  
from employees
group by department_id
order by Avg_salary desc)
select * from Departmentwiseavgsalary;
# Use of CTE
with Deptavgsalary as(
select department_id,avg(salary) as Avg_Salary 
from employees
group by department_id)
select first_name,last_name,e.department_id,salary
from employees e
left join
Deptavgsalary das
on e.department_id = das.department_id
where e.salary > das.Avg_salary;

/*
Normalisation - Normalization is the process to eliminate data redundancy and enhance data integrity in the table. Normalization also helps to organize the data in the database. It is a multi-step process that sets the data into tabular form and removes the duplicated data from the relational tables.
1) 1NF - value in each column has to be independent
2) 2NF - All the column dependencies are on primark key i.e All column dependency are on one column only
2) 3NF - One 
*/