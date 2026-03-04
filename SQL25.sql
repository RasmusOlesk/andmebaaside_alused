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
