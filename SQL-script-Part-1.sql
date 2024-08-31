use ineuron;
create database ineuron_dup;
use ineuron_dup;

create table Courses (Course_id char(5),Course_Title Varchar(30),Time_duration int,Students_intake int);

select * from Courses;
#drop table Courses;
set sql_safe_updates = 0;
Alter table Courses add column Mode_of_Delivery Varchar(40);
Alter table Courses add column Faculty Varchar(25);


Alter table Courses Change column Mode_of_delivery Delivery_Mode Varchar(20);
desc Courses;
#ALTER TABLE Courses
#DROP COLUMN Mode_of_delivery;
#(Course_id,Course_Title,Time_duration,Students_intake,Delivery_Mode,Faculty)

## DML
INSERT INTO Courses
VALUES ("DA101","Data Analytics",6,100,"Live Sessions","Saurabh");

select * from courses;


# Multiple rows insertion
Insert into Courses
values ("DA102","Data Analytics 2.0",6,100,"Live Sessions","Saurabh"),("DS101","Data Science",11,150,"Live Sessions","Mayank");

Insert into Courses (Course_id,Course_Title,Faculty)
values ("ML101","Machine Learing Fundamentals","Suraj");

Insert into Courses (Course_id,Course_Title,Time_duration,Faculty)
values ("ML101","Machine Learing 2.0","6","Bappi Sir");

DELETE FROM Courses WHERE Course_Title='Machine Learing 2.0';

Alter table Courses Change Column Course_ID Course_ID Varchar(10) Unique;
select * from courses;

Insert into Courses
values ("ML102","Machine Learing 2.0",12,150,"Live Classes","Bappi Sir");

#### Class 2
set sql_safe_updates = 0;

update Courses
set Time_duration = 9 where Course_Id = "ML101";

update Courses
set Students_intake = 160 where Course_id = "ML101";

# Default
Alter table courses change column Delivery_Mode Delivery_Mode Varchar(20) default "Live Session";
Insert into Courses(Course_id,Course_Title,Time_Duration,Students_intake,Faculty)
values ("ML102","Machine Learing 2.0",12,150,"Bappi Sir");

select * from courses;
# Add constraints

Alter table courses change column Students_intake Students_intake int check (Students_intake>=100);
Insert into Courses
values ("GA101","Generative AI",12,90,"Hybrid Mode","Sunny Sir");

Describe Courses;
select * from courses;
# Primary Key
Alter table courses change column Course_id Course_id varchar(30) Primary key;
Insert into Courses
values ("GA101","Generative AI",12,190,"Hybrid Mode","Sunny Sir");

## Creating database and importing data
Create Database world;
use world;

# Managing Data Output

select * from city;
select * from country;
describe country;
Alter table country change column Name Country char(52);
select * from countrylanguage;

# Limit

select * from city
limit 10; 

select * from city
limit 10
offset 5;

# Ordering the data output--------
# One Column

select * from city
Alter table city change column Name City char(35);

select * from city
order by City desc;

select * from city
order by Population desc;

## Multiple Columns
select * from country
order by continent, country desc;

select Country,Continent,Population from country
order by Population desc limit 1 offset 2;

select * from country order by continent, Region desc, IndepYear desc;

## DATA FILTERING ---------------------------------
# Where Operator

select * from country
where Continent = "Asia";

select * from country
where indepyear = 1991;

# Relational Operators (>,<,=,>=,<=,<>)
	# Numeric Values
select country,continent,GNP from country
where Indepyear <> 1947 #Indepyear is not equal to 1947
order by GNP desc;

 ## textual Values
select * from country
where country < "Japan";

select * from country
where country < "Bhutan";

# Condition Where
Describe country;

select * from country
where population = 8000;

select * from country
where population > 3401200 and LifeExpectancy < 60 and GNP > 8400;

select * from country
where population > 3401200 or LifeExpectancy < 60 or GNP > 8400; # Atleast any of one is satisfied


select * from country
where not population > 3401200;

# Write query to show all country from Asia, Africa and Europe
select * from country
where Continent = 'Asia' or  Continent = 'Africa' or  Continent = 'Europe'
order by Continent;

#Write short query for above

select * from country
where continent in ("Asia","Africa","Europe") order by Continent; # This will work for Numric data as well

select Country, Continent, Region from country
where LifeExpectancy in (45,9,74,75.1);

select Country, Continent, Region from country
where LifeExpectancy between 45 and 56;

select * from country
where LifeExpectancy between 45 and 56 order by LifeExpectancy;`Online_Customer`

select * from country
where LifeExpectancy not between 45 and 56 order by LifeExpectancy;

####
describe Online_Customer;
Select * from Shipper;
#####
create database orders;
use orders;

# Like
select * from address
where state like 'Delhi';

# All countries where the name starts with 'A'.
use world;

## Starting from 'A'
select * from country
where Country like 'A%';

## Having 'A'
select * from country
where Country like '%A%';

## Ending with 'A'
select * from country
where Country like '%A';

## Fixed Characters starting from A
select * from country
where country like 'A____';

select * from country 
where country like '__A__%';

use orders;
select * from product
where product_desc like '%Nokia%';

select * from product
where product_desc like '% Tab %' or product_desc like '% Tab';

## % ---> any number of characters
## _ ---> fixed number of charecters
## Space ----> Individualise the phrase.

## A would mean ending with a.
## __ - Exactly 2 charecters
## % - any number of charecters

## "%___A" ---> Means text ending with atleast 4 chatrecters ending with A
## "__A%" ---> Means text starting with atleast 3 charecters and 3rd letter being A
## "__A__%" ---> Means text starting with at least 5 charecters and 3rd letter to be A.

# Aliases
# Aliases for columns
use world;

select Country as C,continent as Con from country;

# Aliases for Expression

select Country, Continent, Population/1000000 as Pop_in_mn from country
order by pop_in_mn desc;

Select * from country
Order by continent, region desc,IndepYear desc;

Select * from country
where country like 'A____';

## SQL Build-In Function
	## Aggregate functions
    ## Sum/Avg/Max/min/count/ count distinct 
    
# Total No. of customers/ No. of Customer who placed prders/No. of Orders
use orders;
select * from online_customer;
select count(customer_id)  as Total_Customers from online_customer; #count
select count(distinct customer_id)  as Total_Customers from order_header; #distinct count

select count(distinct ORDER_ID) as Total_orders, count(PRODUCT_ID) as Products, sum(PRODUCT_QUANTITY) as Total_quantity from order_items;
select count(distinct ORDER_ID) as Total_orders, count(distinct PRODUCT_ID) as Products, sum(PRODUCT_QUANTITY) as Total_quantity from order_items; #distinct count

#Sum
use world;

alter table Country change column country Country_name text; # cahange column name
alter table Country drop column Code2; #drop column
Select * from country
#Avg
select Avg(LifeExpectancy) as Avg_LE from country;

## Country with heighest Life expectancy 
select min(LifeExpectancy) from country;
select max(LifeExpectancy) from country;

### Group by Operator [Group by]
#(Find continent wise LE, year wise LE)
Select Continent,SurfaceArea,Population,LifeExpectancy,GNP  from country
group by Continent; #It will not run , Go for agreeation as shown below

Select Continent,sum(SurfaceArea)/1000000 as Total_Surface_Area_million ,sum(Population) as Total_Population,round(avg(LifeExpectancy), 2) as Avg_LE,sum(GNP) as Total_GNP  from country
group by Continent;

Select Continent,sum(SurfaceArea)/1000000 as Total_Surface_Area_million ,sum(Population) as Total_Population,round(avg(LifeExpectancy), 2) as Avg_LE,sum(GNP) as Total_GNP  from country
group by Continent
order by Total_Population desc;

Select Continent,Country_name,sum(Population) from country
group by Continent; #Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'world.country.Country_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

Select Continent,count(Country_name) as no_of_country_in_continent,sum(Population) from country
group by Continent;

## Having (we cant use "Where" With of "group by" -> Hence having used)

Select Continent,
count(Country_name) as no_of_country_in_continent,
sum(SurfaceArea)/1000000 as Total_Surface_Area_million,
sum(Population) as Total_Population,
round(avg(LifeExpectancy), 2) as Avg_LE,sum(GNP) as Total_GNP  from country
group by Continent
order by Continent;
#Q) Now the requirement is to display data only for contient which name starts with "A"
# Note :- we cant use "Where" With of "group by"

Select Continent,
count(Country_name) as no_of_country_in_continent,
sum(SurfaceArea)/1000000 as Total_Surface_Area_million,
sum(Population) as Total_Population,
round(avg(LifeExpectancy), 2) as Avg_LE,sum(GNP) as Total_GNP  from country
group by Continent
having  Continent like 'A%';

Select Continent,
count(Country_name) as no_of_country_in_continent,
sum(SurfaceArea)/1000000 as Total_Surface_Area_million,
sum(Population) as Total_Population,
round(avg(LifeExpectancy), 2) as Avg_LE,sum(GNP) as Total_GNP  from country
group by Continent
having  Continent in('Asia','Europe')
order by Total_Population desc;

## In case of aggration use Group by and hence query won't work

############# String Function #####################
use orders;

# Concat - Joint two ar more string

select concat(ADDRESS_LINE1,", ",ADDRESS_LINE2,", ",CITY,", ",COUNTRY,", ",PINCODE) as Address from address;

# Upper/Lower 

select upper(City) from address;

#length -length of string

select ADDRESS_LINE1, length(ADDRESS_LINE1) as length from address;

#Substring

select * from online_customer;

select CUSTOMER_FNAME, substring(CUSTOMER_FNAME,1,3) from online_customer; # Starts from First character and gives three character

select CUSTOMER_FNAME, concat(substring(CUSTOMER_FNAME,1,3),"-",substring(CUSTOMER_LNAME,1,3)) from online_customer; # Starts from First character and gives three character
# Replace - 
select ADDRESS_LINE1,replace(ADDRESS_LINE1,","," ") from address;

#Left/Right (Select no if text from left)

select CUSTOMER_FNAME, right(CUSTOMER_FNAME,4) from online_customer;

#### Date and time Function
#current Data
select current_date();
select current_time();
select current_timestamp();

select date('2024-06-21 20:46:50') as Date;

select date('2024-06-21 20:46:50') as Time;

select year('2024-06-21 20:46:50') as Time;

select time('2024-06-21 20:46:50') as Time;

#Year
select year(CUSTOMER_CREATION_DATE) as Inception_Year,
 count(CUSTOMER_CREATION_DATE) as customer_Acqhure from online_customer
 group by Inception_Year
 order by customer_Acqhure desc; # How many customer created every Year

#Month
select Month(CUSTOMER_CREATION_DATE) as Month,
 count(CUSTOMER_CREATION_DATE) as customer_Acqhure from online_customer
 group by Month
 order by customer_Acqhure desc; # How many customer acqhire every month
#Month - Name
select monthname(CUSTOMER_CREATION_DATE) as Month,
 count(CUSTOMER_CREATION_DATE) as customer_Acqhure from online_customer
 group by Month
 order by customer_Acqhure desc; # How many customer acqhire every month

# Day

select day(CUSTOMER_CREATION_DATE) as Day from online_customer;

select dayname(CUSTOMER_CREATION_DATE) as weekday,
count(CUSTOMER_CREATION_DATE) as Customer_Acquire 
from online_customer
group by weekday
order by Customer_Acquire;

# Date add
select CUSTOMER_CREATION_DATE,
date_add(CUSTOMER_CREATION_DATE, interval 10 Day) as final_date
from Online_customer;

# Date Sub

select CUSTOMER_CREATION_DATE,
date_sub(CUSTOMER_CREATION_DATE, interval 10 Day) as final_date
from Online_customer;

# Date Difference
		# Learn sentex online

###################### Numeric Function #########
# Abs - Absolute value of a Number

select abs(-44) as Modu;

#Round

select round(-44.56) round_up_number;

#Celling/Floor

select ceiling(44.38);
select floor(44.38);
# Sqrt / Mod / sign / truncate / log / exp - Learn online

## Numeric Functions
    # Abs - Absolute value of a number
select abs(-44.38) as Modu;

    # Round
select round(-44.38,1) round_up_number;
    # Ceiling/Floor
select ceiling(44.38);
select floor(44.38);
    # Sqrt
select sqrt(100);
    # Power
select power(2,3);
    # Rand
select round(rand()*10000,0) as Random_num;
    # Mod

    # Sign
    # Truncate
Select truncate(48.936547, 2);
    # Log 

    # exp
select exp(2);

###################### Conditional Function #########
use world;
# IF
select Country_name,if(Population > 25434098, "Above Avg",'Below Avg') as population_category from country;

select 
if(Population > 25434098,"Above_Ave","Below_Ave") as Pop_Category,
count(country_name) as No_of_Countries
from country
group by Pop_Category

select avg(population) from country;

select avg(population/SurfaceArea) from country;



select 
if(Population/SurfaceArea > 650,"Denesly Pop",
if(Population/SurfaceArea > 450 and Population/SurfaceArea < 650,"Av_Pop","Low_Pop_Density")) as Pop_Den_Cat,
count(Country_name) as Num
from country
group by Pop_Den_Cat 
order by Pop_Den_Cat desc;

# Case When Operator

Select avg(Population) from Country;
select Country_name, Case 
when Population > 25434098 then "Above Average"
when Population < 25434098 then "Below Average"
else "Equal to Average"
end as Pop_Cat
from country;

select Country_name, Case 
when Population/SurfaceArea > 650 then "Densely Pop"
when Population/SurfaceArea < 650 and Population/SurfaceArea > 450 then "Average"
else "Below Average"
end as Pop_Cat
from country;

    # Coalesce [To replace null value to another value]
use orders;
SET SQL_SAFE_UPDATES = 0;

select * from order_header;
#TODO:- Not working
select ORDER_ID, PAYMENT_MODE, Coalesce(PAYMENT_MODE,"Not Available") new_payment_mode from order_header
where PAYMENT_MODE is null; #Coalesce -> Replace null value with suitable method

#Set IndepYear to 1990 where its zero
use world;
select * from Country;

update Country
set IndepYear = 1900
where IndepYear = 0;

	## Nullif (Ignpre if payment mode is Credit card)
Select Payment_mode,nullif(payment_mode,"Credit Card") from order_header; # Where payment mode is credit card it will show null
	## IfNull (if null replace with given value) # not working
select Order_date, ifnull(order_date,"NA") from order_header;
select payment_mode, ifnull(payment_mode,"NA") as NPM from order_header;
select Order_date, ifnull(Order_date,"NA") as NOD from order_header;
    
select order_id,Payment_mode,Coalesce(Payment_mode,"Not Available") new_payment_mode from order_header where Payment_mode is null;

## Window Functions
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
