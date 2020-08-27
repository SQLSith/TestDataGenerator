

Create   Proc [Fountain].[usp_Get_Product] (@Product varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @Product varchar(50)
	exec	Fountain.usp_Get_Product @Product out
	Select @Product
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Product'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'Product'
		;
	Commit Tran

	Select @Product = Product from Reference.Product where ProductSK = @NextSK