



Create   Proc usp_Get_Street (@Street varchar(50) out)
as
/*
Declare @Street varchar(50)
exec usp_Get_Street @Street out
Select	@Street
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Street'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Street'
;

Select @Street = Street from Street where StreetSK = @NextSK