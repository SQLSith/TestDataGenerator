

Create   Proc [dbo].[usp_Get_Colour] (@Colour varchar(50) out)
as
/*
Declare @Colour varchar(50)
exec usp_Get_Colour @Colour out
Select @Colour
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Colour'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Colour'
;

Select @Colour = Colour from Colour where ColourSK = @NextSK