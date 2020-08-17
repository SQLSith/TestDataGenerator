

Create   Proc usp_Get_Surname (@Surname varchar(50) out)
as
/*
Declare @Surname varchar(50)
exec usp_Get_Surname @Surname out
Select @Surname
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Surname'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Surname'
;

Select @Surname = Surname from Surname where SurnameSK = @NextSK