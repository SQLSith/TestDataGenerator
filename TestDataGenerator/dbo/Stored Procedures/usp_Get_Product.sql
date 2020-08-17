

Create   Proc [dbo].[usp_Get_Product] (@Product varchar(50) out)
as
/*
Declare @Product varchar(50)
exec usp_Get_Product @Product out
Select @Product
*/

Declare	@NextSK int

Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
from	ReferenceControl
where	[ReferenceTableName] = 'Product'

Update	ReferenceControl
Set		[LastAllocatedReferenceSK] = @NextSK
where	[ReferenceTableName] = 'Product'
;

Select @Product = Product from Product where ProductSK = @NextSK