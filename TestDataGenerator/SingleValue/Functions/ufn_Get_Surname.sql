CREATE function [SingleValue].[ufn_Get_Surname]
(
)
RETURNS varchar(50)
AS
BEGIN
	Declare	@MaxSK int,
			@ChosenSK int,
			@Surname varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Surname'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@Surname = [Surname]
	from	[Reference].[Surname]
	where	[SurnameSK] = @ChosenSK

	Return @Surname
END