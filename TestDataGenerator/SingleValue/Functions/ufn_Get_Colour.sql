CREATE function [SingleValue].[ufn_Get_Colour]
(
)
RETURNS varchar(50)
AS
BEGIN
	Declare	@MaxSK int,
			@ChosenSK int,
			@Colour varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Colour'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@Colour = [Colour]
	from	[Reference].[Colour]
	where	[ColourSK] = @ChosenSK

	Return @Colour
END