

Create   Proc [Fountain].[usp_Get_Street] (@Street varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @Street varchar(50)
	exec	Fountain.usp_Get_Street @Street out
	Select @Street
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'Street'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'Street'
		;
	Commit Tran

	Select @Street = Street from Reference.Street where StreetSK = @NextSK