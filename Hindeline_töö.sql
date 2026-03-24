---Left join

select FirstName, lastname, salesterritorycountry
from DimEmployee
left join DimSalesTerritory
on  DimEmployee.Salesterritorykey= dimsalesterritory.salesterritorykey

--kuvab DimEmployee tabelist FirstName ja Lastname
--Kasutades left joini sai lõppu lisatud SalesterritoryCountry

--right join

select city, salesterritorycountry
from DimGeography
right join DimSalesTerritory
on DimGeography.SalesTerritoryKey = dimsalesterritory.salesterritorykey

--Kasutades right joini saab ühendada City ja SalesTerritorycountry kui mõlemal on salesterritorykey sama
--Oli vaja teada saada mis riigis linnad asuvad

--inner join

select Firstname, Lastname, Phone, PostalCode
from DimCustomer
inner join DimGeography
on DimCustomer.GeographyKey = DimGeography.GeographyKey

--kuvab neid, kellel on PostalCode all olemas väärtus
--Oli vaja teada saada inimese telefoni numbrit ja tema posti indeksi

--outer join

select  organizationname, currencyname
from DimOrganization
full outer join DimCurrency
on DimOrganization.CurrencyKey = DimCurrency.CurrencyKey

--Sama nagu ennem inner join, aga kui Currenyname'il pole vastet, siis näitab nulli
--Oli vaja näha millist rahaühikud erinevad organisatsioonid kasutavad

--cross join

select Firstname, gender, emergencycontactname, salesamountquota, Date 
from DimEmployee
cross join FactSalesQuota

--kuvab kõik read mõlemast tabelist, aga ei võta aluseks mingit veergu,
--vaid lihtsalt kombineerib kõik read omavahel
--Oli vaja näha inimesi ja Salesamountquota kuupäeva


--Tabeli loomine

create table shops
(
Shopskey int not null primary key,
Name nvarchar(40),
Workers nvarchar(1000),
OpeningHour nvarchar(24),
ClosingHour nvarchar(24),
Geographykey int
)

insert into shops (Shopskey, Name, Workers, OpeningHour, ClosingHour, Geographykey)
values (1, 'Rimi', 50, '07:00', '20:00', 1),
(2, 'Maxima', 45, '08:00', '21:00', 100),
(3, 'Selver', 55, '09:00', '22:00', 3),
(4, 'Jaagumägi', 34, '10:00', '19:00', 138),
(5, 'Gross', 51, '9:30', '20:30', 62),
(6, 'Market 1000', 49, '8:30', '21:30', 127),
(7, 'Lidl', 67, '9:00', '22:00', 185),
(8, 'Coop', 45, '7:30', '23:00', 187),
(9, 'K-Rauta', 66, '8:30', '21:00', 102),
(10, 'Prisma', 56, '9:30', '22:30', 67)

select * from Shops

--Sai loodud tabel poodide kohta


