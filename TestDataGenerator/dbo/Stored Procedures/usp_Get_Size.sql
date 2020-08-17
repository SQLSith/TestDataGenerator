

Create   Proc [dbo].[usp_Get_Size] (@Size varchar(50) out)
as
/*
Declare @Size varchar(50)
exec usp_Get_Size @Size out
Select @Size
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Size'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Size'
;

Select @Size = Size from Size where SizeSK = @NextSK