
CREATE   Proc [SingleValue].[usp_Get_PostArea] (@PostArea varchar(2) out, @PostAreaName varchar(50) out)
as
/*
Declare @PostArea varchar(2),
		@PostAreaName varchar(50)
exec	[SingleValue].usp_Get_PostArea @PostArea out, @PostAreaName out
Select	@PostArea,
		@PostAreaName
*/

	Declare	@MaxSK int,
			@ChosenSK int

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'PostArea'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@PostArea = [PostArea],
			@PostAreaName = [PostAreaName]
	from	[Reference].[PostArea]
	where	[PostAreaSK] = @ChosenSK