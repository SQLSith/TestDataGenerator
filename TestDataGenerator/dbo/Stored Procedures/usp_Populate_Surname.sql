


Create   Proc usp_Populate_Surname
as
/*
Drop table Surname
go

Create table Surname
(
SurnameSK int identity(1,1) primary Key,
Surname	varchar(50)
)
go
*/

Truncate table Surname
;


With Person as 
(
Select distinct [LastName]
from	[AdventureWorks2017].[Person].[Person]
)
insert	Surname (Surname)
Select [LastName]
from	Person
order by newID()
;

if not exists (Select * from ReferenceControl where ReferenceTableName = 'Surname')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Surname', max(SurnameSK), 1
	from Surname
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(SurnameSK) from Surname)
	where	ReferenceTableName = 'Surname'
end