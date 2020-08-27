
CREATE function [SingleValue].[ufn_Get_Decimal]
(
	@MinValue decimal(18,10), @MaxValue decimal(18,10), @decimalPlaces tinyint
)
RETURNS decimal(18,10)
AS
BEGIN
	Declare	@Number decimal(18,10)

	Select	@Number = (@MinValue) + round(RandomNumber * (@MaxValue - @MinValue), @decimalPlaces)
	from	SingleValue.[vw_RandomNumber]

	RETURN @Number

END