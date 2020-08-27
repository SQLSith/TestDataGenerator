

Create   Proc [Fountain].[usp_Get_Surname] (@Surname varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @Surname varchar(50)
	exec	Fountain.usp_Get_Surname @Surname out
	Select @Surname
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Surname'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'Surname'
		;
	Commit Tran

	Select @Surname = Surname from Reference.Surname where SurnameSK = @NextSK