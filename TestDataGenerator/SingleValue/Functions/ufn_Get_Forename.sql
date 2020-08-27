CREATE function [SingleValue].[ufn_Get_Forename]
(
)
RETURNS varchar(50)
AS
BEGIN
	Declare	@MaxSK int,
			@ChosenSK int,
			@Forename varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Forename'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@Forename = [Forename]
	from	[Reference].[Forename]
	where	[ForenameSK] = @ChosenSK

	Return @Forename
END