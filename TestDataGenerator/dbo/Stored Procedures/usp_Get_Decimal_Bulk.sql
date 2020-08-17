
Create       proc [dbo].[usp_Get_Decimal_Bulk]( @MinValue decimal(9,2) = 0.01, @MaxValue decimal(9,2) = 99.99, @decimalPlaces tinyint = 2, @QuantityRequired smallint)
as
begin
/*
exec [usp_Get_Decimal_Bulk] 0.01, 99.99, 2, 1000

*/

SELECT --round(rand(checksum(NewID())) * @MaxValue,0) Number
		Round(rand(checksum(NewID())) * (@MaxValue - @MinValue), @decimalPlaces) Number
from	Number 
where	Number <= @QuantityRequired
end