
CREATE function [SingleValue].[ufn_Get_Size]
(
)
RETURNS varchar(50)
AS
BEGIN
	Declare	@MaxSK int,
			@ChosenSK int,
			@Size varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Size'
	;

	Select	@ChosenSK = ceiling(RandomNumber * @MaxSK)
	from	SingleValue.[vw_RandomNumber]

	Select	@Size = Size
	from	[Reference].Size
	where	[SizeSK] = @ChosenSK

	Return @Size
END