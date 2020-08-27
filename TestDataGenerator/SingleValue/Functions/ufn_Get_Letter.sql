
CREATE function [SingleValue].[ufn_Get_Letter]()
RETURNS char(1)
AS
BEGIN
	Declare	@Letter char(1)

	Select	@Letter = char((RandomNumber * 26) + 65)
	from	SingleValue.[vw_RandomNumber]

	RETURN @Letter

END