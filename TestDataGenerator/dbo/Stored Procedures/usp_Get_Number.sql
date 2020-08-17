
CREATE   proc [dbo].[usp_Get_Number](@MinValue int = 1, @MaxValue int = 9, @Number int out)
as
begin
/*
Declare @Number int
exec usp_Get_Number @Number = @Number out
Select @Number


Declare @Number int
exec usp_Get_Number @MinValue = 95, @MaxValue = 100, @Number = @Number out
Select @Number
*/

sELECT @Number = (@MinValue - 1) + ceiling(rand() * (@MaxValue - @MinValue + 1))

end