

Create   Proc [Fountain].[usp_Get_Forename] (@Forename varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @Forename varchar(50)
	exec	Fountain.usp_Get_Forename @Forename out
	Select @Forename
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Forename'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'Forename'
		;
	Commit Tran

	Select @Forename = Forename from Reference.Forename where ForenameSK = @NextSK