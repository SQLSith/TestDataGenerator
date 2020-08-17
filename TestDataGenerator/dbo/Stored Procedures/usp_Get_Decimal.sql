

Create     proc [dbo].[usp_Get_Decimal](@MinValue decimal(9,2) = 0.01, @MaxValue decimal(9,2) = 99.99, @decimalPlaces tinyint = 2, @Number decimal(9,2) out)
as
begin
/*
Declare @Number decimal(9,2)
exec [usp_Get_Decimal] @Number = @Number out
Select @Number


Declare @Number decimal(9,2)
exec [usp_Get_Decimal] @MinValue = 95, @MaxValue = 100, @decimalPlaces = 2, @Number = @Number out
Select @Number
*/

sELECT @Number = round(rand() * (@MaxValue - @MinValue), @decimalPlaces)

end