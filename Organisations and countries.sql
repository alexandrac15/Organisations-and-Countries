------DATABSE CREATION
create database world
go

create table Continents (continent_name varchar(30) primary key)
create table Countries (country_code varchar(2)primary key ,country_name varchar(50), capital varchar(50), area float, population int, continent_name varchar(30) foreign key references Continents)
create table Organizations (organization_code int primary key, organization_name varchar(50), headquarter varchar(50), foundation_date date )
create table OrganizationCountry (organization_code int foreign key references Organizations , country_code varchar(2) foreign key references Countries, primary key(organization_code, country_code))     

----DATABASE POPULATION
Use world;
go
select * from Continents
select * from Countries
select * from Organizations
select * from OrganizationCountry


insert into Countries values ('CA','Canada', 'Ottawa', 10000000, 38000000, 'North America')
insert into Countries values ('BG','Belgium', 'Brussels', 38000, 11000000, 'Europe')
insert into Countries values ('GE','Germany', 'Berlin', 340000, 83000000, 'Europe')
insert into Countries values ('RO','Romania', 'Bucharest', 240000, 1900000,  'Europe')
insert into Countries values ('CO','Croatia', 'Zagreb', 56000, 4000000, 'Europe')
insert into Countries values ('US','USA', 'Washington DC', 9800000, 327000000, 'North America')
--toate de aici NATO
--un
insert into Countries values ('AG','Argentina', 'Buenos Aires', 2700000, 45000000,  'South America')
insert into Countries values ('AU','Australia','Canberra', 7000000, 26000000, 'Australia')
insert into Countries values ('AL','Algeria', 'Alger', 2000000, 40000000, 'Africa')
insert into Countries values ('BL','Belarus', 'Minsk', 207000, 12000000, 'Europe')
insert into Countries values ('JP','Japan', 'Tokyo', 400000, 130000, 'Asia')
insert into Countries values ('CH','China', 'Beijing', 9000000, 1000000000, 'Asia')
insert into Countries values ('RU','Rusia', 'Moskow', 18000000, 150000000, 'Europe')
insert into Countries values ('UG','Uruguay', 'Montevideo', 200000,4000000, 'South America')

insert into Organizations  values (1,'International Monetary Fund','Washington DC','1945/01/01');
insert into Organizations  values (2,'United Nations Organization','New York','1945/01/01');
insert into Organizations  values (3,'United Nations Children’s Fund','New York','1946/12/11');
insert into Organizations  values (4,'United Nations Conference on Trade & Development','Geneva','1964/12/30');
insert into Organizations  values (6,'Organization for Economic Cooperation & Development','Paris','1960/01/01');
insert into Organizations  values (7,'International Olympic Committee','Laussane','1894/06/23');
insert into Organizations  values (8,'World Wide Fund for Nature','Vaud','1960/01/01');
insert into Organizations  values (9,'Nato','Brussels','1949/01/01');

insert into OrganizationCountry values(9,'CA')
insert into OrganizationCountry values(9,'BG')
insert into OrganizationCountry values(9,'GE')
insert into OrganizationCountry values(9,'RO')
insert into OrganizationCountry values(9,'CO')
insert into OrganizationCountry values(9,'US')
insert into OrganizationCountry values(2,'US')
insert into OrganizationCountry values(2,'GE')
insert into OrganizationCountry values(2,'JP')
insert into OrganizationCountry values(2,'UG')
insert into OrganizationCountry values(2,'RU')
insert into OrganizationCountry values(4,'BL')
insert into OrganizationCountry values(4,'JP')
insert into OrganizationCountry values(4,'CH')
insert into OrganizationCountry values(8,'CH')
insert into OrganizationCountry values(8,'AL')

------QUERIES:


Use world 
go 

--List all the countries which are members of NATO
Select c.country_name from Countries c JOIN OrganizationCountry og  on c.country_code=og.country_code JOIN  Organizations o on o.organization_code=og.organization_code 
where o.organization_name='NATO'    

--List all the countries which are members of organizations founded before 1980
Select c.country_name from Countries c JOIN OrganizationCountry og  on c.country_code=og.country_code JOIN  Organizations o on o.organization_code=og.organization_code 
where o.foundation_date< '1980'   

--List all the countries which are members of only one organization
SELECT  c.country_name  
FROM OrganizationCountry og JOIN Countries c on c.country_code=og.country_code
GROUP BY c.country_name
HAVING COUNT(og.organization_code)=1  

--List all the capitals which are headquarter of no organization
Select c.capital
FROM Countries c 
EXCEPT 
Select c.capital
from Organizations o join Countries c on c.capital=o.headquarter --e ok 

--List the population of each continent
SELECT co.continent_name, SUM(c.population)
FROM Countries c JOIN Continents co on c.continent_name=co.continent_name
Group by co.continent_name
SELECT * FROM Countries

--Count the countries of each continent
SELECT co.continent_name, Count(c.country_code)
FROM Countries c JOIN Continents co on c.continent_name=co.continent_name
Group by co.continent_name
SELECT * FROM Countries








