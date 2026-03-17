create database TARge25

--db valimine
use master

--db kustutamine
drop database TARge25

--tabeli tegemine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male'),
(1, 'Female'),
(3, 'Unknown')

--tabeli sisu vaatamine
select * from Gender

--tehke tabel nimega Person
--id int ja not null, primary key
--Name nvarchar 30 
--Email nvarchar 30
--GenderId int

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderID int
)

insert into Person (Id, Name, Email, GenderID)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'cat@cat.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)


select * from Person

--Võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_Gender_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud genderId alla väärtust, siis
--see automaatselt sisestab sellele reale väärtuse 3 e mis meil on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Person (Id, Name, Email, GenderID)
values (7, 'Flash','f@f.com', NULL)

insert into Person (Id, Name, Email)
values (9, 'Black Panther','p@p.com')

--kustutada DF_Persons_genderId piirang koodiga

alter table Person drop constraint DF_Persons_GenderId 

--lisame koodiga veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisesatmisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

select * from Person

--kui sa tead veergude järjekorda peast, siis ei pea neid sisestama
insert into Person 
values(10, 'Green Arrow', 'g@g.com', 2, 154)

--constrainti kustutamine
alter table Person
drop constraint CK_Person_Age

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 130)

--kustutame rea
delete from Person where Id = 3

--kuidas uuendada andmeid koodiga
--Id 3 uus vanus on 50
update Person
set Age = 50
where Id = 3

--lisame Person tabelisse veeru City ja Nvarchar 50

alter table Person
add City nvarchar(50)

update Person
set age = 23
where Id = 10


--kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'
select * from Person where not City = 'Gotham'

--näitab teatud vanusega inimesi
--35, 42, 23
select * from Person where Age = 35 or Age = 42 or Age = 23 
select * from Person where Age in (35, 42, 23)

--näitab teatud vanusevahemikus olevaid isikuid 22 kuni 39

select * from Person where Age > 22 and Age < 39
select * from Person where Age between 22 And 39

--wildcardi kasutamine
--näitab kõik g-tähega algavad linnad

select * from Person where city like 'G%'

--email, kus on @ märk sees

select * from Person where Email like '%@%'

--näitab, kellel on emailis ees ja peale @-märki ainult üks täht
--ja omakorda .com

select * from Person where Email like '_@_.com'

--kõik, kellel on nimes esimene täht w, a, s

select * from Person where Name like 'w%' or name like 'a%' or Name like 's%'
select * from Person where Name like '[was]%'

--kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')


--kes elavad Gothamis ja New Yorgis ja on vanemad kui = 29
select * from Person where City = 'Gotham' or City = 'New York'
and Age >= 30 

select * from Person 

--rida 124
-- 3 tnd

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
--kuvab vastupidises jäjestuses nimed
select * from Person order by Name desc

--võtab kolm esimest rida person tabelist
select top 3 * from Person order by Name 

--kolm esimest, aga tabeli järjestus on Age ja siis name
select from Person
select top 3 age, Name from Person order by cast(age as int)

--näita esimesed 50% tabelist
select top 50 PERCENT * from Person

--kõikide isikute koondvanus
select SUM(cast(age as int)) from person

--näitab kõige nooremat isikut

select min(cast(age as int)) from person

--kõige vanem isik
select MAX(cast(age as int)) from person

--muudame Age veeru int andmetüübiks
alter table person
alter column Age int;

--näeme konkreetsetes linnades olevate isikute koondvanust
select SUM(cast(age as int)) from Person where City = 'Gotham' or city = 'New York'
select city, SUM(age) as totalage from Person group by city

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age totalAge-ks
--järjestab City-s olevate nimede järgi ja siis genderId järgi
select city, genderId, SUM(age) as totalage from Person
group by city, GenderID order by city

--näitab, et mitu rida on selles tabelis
select * from person
select COUNT(*) from person

--näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku konkreetss linnas
select city, count(genderid) as TotalPerson(s) from Person group by city
select city, count(genderId) as TotalPersons, SUM(age) as totalage from Person
group by city, GenderID order by city

select GenderId, city, SUM(Age) as TotalAge, COUNT(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 aasta ja
--kui palju neid igas linnas elab
--eristab soo järgi
select genderid, city, SUM(age) as TotalAge,
COUNT(Id) as [Total Person(s)]
from Person 
group by GenderID, city having SUM(age)  > 41

--loome tabelid employees ja department
create table Department
(Id int not null primary key,
DepartmentName nvarchar(50) null,
Location nvarchar(50) null,
DepartmentHead nvarchar(50) null)

create table Employees
(Id int not null primary key,
Name nvarchar(50) null,
Gender nvarchar(50) null,
Salary nvarchar(50) null,
DepartmentId int null)


insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, null),
(10, 'Russell', 'Male', 8800, null)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from employees

--
select name, Gender, salary, departmentname
from employees
left join Department
on Employees.DepartmentId = Department.id

--arvutame kõikide palgad kokku

select SUM(cast(salary as int)) from employees
--min palga saaja
select MIN(cast(salary as int)) from employees

--4 tund 
--17.03.2026
--teeme left join päringu
select Location, SUM(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --ühe kuu palgafond lõikes

--teeme veeru nimega City Employees tabelisse
--nvarchar 30

alter table Employees
add City nvarchar(30)

select * from employees

--peale selecti tulevad veergude nimed
select city, Gender, SUM(cast(salary as int)) as TotalSalary
--tabelist nimega Employees ja mis on grupitatud City ja Gender järgi
from Employees group by City, Gender


--oleks vaja, et linnad oleksid tähestikulises järjekorras

select city, Gender, SUM(cast(salary as int)) as TotalSalary
from Employees group by City, Gender
order by city
--order by järjestab linnad tähestikuliselt,
--aga kui on nullid, siis need tulevad kõige ette

--loeb ära, mitu rida on tabelis Employees
--* asemel võib panna ka veeru nime, 
--aga siis loeb ainult selle veeru väärtused, mis ei ole nullid
select COUNT(*) from employees

--mitu töötajat on soo ja linna kaupa
select city, Gender, SUM(cast(salary as int)) as TotalSalary,
COUNT(Id) as [Total Employee(s)]
from Employees group by City, Gender

--kuvab ainult kõik mehed linnade kaupa
select city, Gender, SUM(cast(salary as int)) as TotalSalary,
COUNT(Id) as [Total male Employee(s)]
from Employees 
where Gender = 'Male'
group by City, Gender

--sama tulemus, aga kasutage having klauslit

select city, Gender, SUM(cast(salary as int)) as TotalSalary,
COUNT(Id) as [Total male Employee(s)]
from Employees 
group by City, Gender
having Gender = 'Male'

--näitab meile ainult need töötajad, kellel on palgad summa üle 4000

select name, city, Gender, SUM(cast(salary as int)) as TotalSalary,
COUNT(Id) as [Total Employee(s)]
from Employees group by City, Gender, name
having SUM(salary as int) > 4000

select * from Employees
where SUM(cast(salary as int)) > 4000

select City, SUM(cast(Salary as int)) as TotalSalary, Name,
COUNT(Id) as [Total Employee(s)]
from Employees 
group by Salary, City, Name
having  SUM(cast(Salary as int)) > 4000


--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1) primary key,
Value nvarchar(30)
)

insert into Test1 values('X')
select * from Test1

--- kustutame veeru nimega City Employees tbelist

alter table employees
drop column city

--inner join
--kuvab neid, kellel on DepartmentName all olemas väärtus
select name, Gender, Salary, departmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id 

--left join
--kuvab kõik read Employees tabelist,
--aga DepartmentName näitab ainult siis, kui on olemas
--kui DepartmentId on null, siis DepartmentName näitab nulli

select name, Gender, Salary, departmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id 

--right join
--kuvab kõik read Department tabelist
--aga Name näitab ainult siis, kui on olemas väärtus DepartmentId, mis on sama,
--Department tabeli Id-ga
select name, Gender, Salary, departmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id 

--full outer join ja full join on sama asi
--kuvab kõik read mõlemast tabelist,
--aga kui ei ole vastet, siis näitab nulli
select name, Gender, Salary, departmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id 

--cross join
--kuvab kõik read mõlemast tabelist, aga ei võta aluseks mingit veergu,
--vaid lihtsalt kombineerib kõik read omavahel
--kasutatakse harva, aga kui on vaja kombineerida kõiki
--võmalikke kombinatsioone kahe tabeli vahel, siis võib kasutada cross joini
select name, Gender, Salary, departmentName
from Employees
cross join Department

--päringu sisu
select ColumnListfro
from LeftTable
joinType RightTable
on JoinCondition

select name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Department.Id = Employees.DepartmentId

--kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
-- esimene variant
select name, Gender, Salary, departmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id 
where DepartmentName is NULL

--teine variant
select name, Gender, Salary, departmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id 
where Employees.DepartmentId is NULL

--kolmas variant
select name, Gender, Salary, departmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id 
where Department.Id is NULL

--kuidas saame department tabelis oleva rea, kus on NULL
select name, Gender, Salary, departmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id 
where Employees.DepartmentId is null

--full join
--kus on vaja kuvada kõik read mõlemast tabelist,
--millel ei ole vastet

select name, Gender, Salary, departmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id 
where Employees.DepartmentId is null
or Department.Id is null

--tabeli nimetuse muutmine koodiga
sp_rename 'Employees1', 'Employees'

--kasutame Employees tabeli asemel lühendit E ja M
--aga enne seda lisame uue veeru nimega ManagerId ja see on int
alter table Employees
add ManagerId int

--antud juhul E on Employees tabeli lühend ja M
--on samuti Employees tabeli lühend, aga me kasutame
--seda, et näidata, et see on manageri tabel
select E.Name as Employees, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--inner join ja kasutame lühendeid
select E.Name as Employees, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join ja kasutame lühendeid
select E.Name as Employees, M.Name as Manager
from Employees E
cross join Employees M

select FirstName, lastName, Phone, AddressID, AddressType
from SalesLT.CustomerAddress CA
left join SalesLT.Customer C
on CA.CustomerID = C.CustomerID

--teha päring, kus kasutate ProductModelit ja Product tabelit,
--et näha, millised tooted on millise mudeliga seotud

select PM.Name as ProductModel, PARSE.Name as Product 
from SalesLT.Product P
left join SalesLT.ProductModel PM
on PM.ProductModelId = P.ProductModelID



