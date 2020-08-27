
CREATE function [SingleValue].[ufn_Get_Number]
(
	@MinValue int, @MaxValue int
)
RETURNS int
AS
BEGIN
	Declare	@Number int

	Select	@Number = (@MinValue - 1) + ceiling(RandomNumber * (@MaxValue - @MinValue + 1))
	from	SingleValue.[vw_RandomNumber]

	RETURN @Number

END