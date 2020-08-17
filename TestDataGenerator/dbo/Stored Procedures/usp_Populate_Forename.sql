
Create   Proc usp_Populate_Forename
as

/*
Drop table if exists Forename
;

Create table Forename
(
ForenameSK int identity(1,1) primary Key,
Forename	varchar(50)
)
;
*/

Truncate table Forename
;

With Person as 
(
Select distinct [FirstName]
from	[AdventureWorks2017].[Person].[Person]
)
insert	Forename (Forename)
Select [FirstName]
from	Person
order by newID()
;

if not exists (Select * from ReferenceControl where ReferenceTableName = 'Forename')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Forename', max(ForenameSK), 1
	from Forename
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(ForenameSK) from Forename)
	where	ReferenceTableName = 'Forename'
end