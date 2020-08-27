
CREATE     proc [SingleValue].[usp_Get_Decimal](@MinValue decimal(18,10) = 0.01, @MaxValue decimal(18,10) = 99.99, @decimalPlaces tinyint = 2, @Number decimal(18,10) out)
as
begin
/*
Declare @Number decimal(9,2)
exec	[SingleValue].[usp_Get_Decimal] @Number = @Number out
Select	@Number


Declare @Number decimal(9,2)
exec	[SingleValue].[usp_Get_Decimal] @MinValue = 95, @MaxValue = 100, @decimalPlaces = 2, @Number = @Number out
Select	@Number
*/

	Select  @Number = [SingleValue].[ufn_Get_Decimal] (@MinValue, @MaxValue, @decimalPlaces)

end