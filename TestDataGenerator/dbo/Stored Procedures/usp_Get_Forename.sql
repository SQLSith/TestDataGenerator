

Create   Proc usp_Get_Forename (@Forename varchar(50) out)
as
/*
Declare @Forename varchar(50)
exec usp_Get_Forename @Forename out
Select @Forename
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Forename'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Forename'
;

Select @Forename = Forename from Forename where ForenameSK = @NextSK