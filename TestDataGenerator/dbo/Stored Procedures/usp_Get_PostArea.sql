



Create   Proc usp_Get_PostArea (@PostArea varchar(2) out, @PostAreaName varchar(50) out)
as
/*
Declare @PostArea varchar(2),
		@PostAreaName varchar(50)
exec usp_Get_PostArea @PostArea out, @PostAreaName out
Select	@PostArea,
		@PostAreaName
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'PostArea'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'PostArea'
;

Select @PostArea = PostArea, @PostAreaName = PostAreaName from PostArea where PostAreaSK = @NextSK