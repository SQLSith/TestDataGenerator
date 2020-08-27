
CREATE   Proc [Fountain].[usp_Get_PostArea] (@PostArea varchar(2) out, @PostAreaName varchar(50) out)
as
	Set Xact_Abort on
	Set Nocount on
/*
	Declare @PostArea varchar(2),
			@PostAreaName varchar(50)
	exec	Fountain.usp_Get_PostArea @PostArea out, @PostAreaName out
	Select	@PostArea,
			@PostAreaName
*/

	Declare	@NextSK int

	Begin Tran
		Select  @NextSK = case when [LastAllocatedReferenceSK] = [MaxReferenceSK] then 1 else [LastAllocatedReferenceSK] + 1 end
		from	SystemControl.ReferenceControl
		where	[ReferenceTableName] = 'PostArea'
		;

		Update	SystemControl.ReferenceControl
		Set		[LastAllocatedReferenceSK] = @NextSK
		where	[ReferenceTableName] = 'PostArea'
		;
	Commit Tran

	Select @PostArea = PostArea from Reference.PostArea where PostAreaSK = @NextSK