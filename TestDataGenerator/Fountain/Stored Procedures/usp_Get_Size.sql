
Create   Proc Fountain.[usp_Get_Size] (@Size varchar(50) out)
as
/*
Declare @Size varchar(50)
exec	Fountain.usp_Get_Size @Size out
Select	@Size
*/

	Declare	@NextSK int

	Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Size'

	Update	SystemControl.ReferenceControl
	Set		[LastAllocatedReferenceSK] = @NextSK
	where	[ReferenceTableName] = 'Size'
	;

	Select @Size = Size from Reference.Size where SizeSK = @NextSK