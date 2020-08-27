
CREATE   proc SingleValue.[usp_Get_Number](@MinValue int = 1, @MaxValue int = 9, @Number int out)
as
begin
/*
Declare	@Number int
exec	SingleValue.usp_Get_Number @Number = @Number out
Select	@Number


Declare @Number int
exec	SingleValue.usp_Get_Number @MinValue = 95, @MaxValue = 100, @Number = @Number out
Select	@Number
*/

	Select @Number = SingleValue.ufn_Get_Number(@MinValue, @MaxValue)

end