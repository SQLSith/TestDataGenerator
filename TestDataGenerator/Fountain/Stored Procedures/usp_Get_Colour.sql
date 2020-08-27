
Create   Proc Fountain.[usp_Get_Colour] (@Colour varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @Colour varchar(50)
	exec	Fountain.usp_Get_Colour @Colour out
	Select @Colour
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Colour'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'Colour'
		;
	Commit Tran

	Select @Colour = Colour from Reference.Colour where ColourSK = @NextSK