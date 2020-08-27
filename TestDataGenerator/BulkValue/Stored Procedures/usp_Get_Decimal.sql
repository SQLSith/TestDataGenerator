CREATE       proc [BulkValue].[usp_Get_Decimal]( @MinValue decimal(18,10) = 0.01, @MaxValue decimal(18,10) = 99.99, @decimalPlaces tinyint = 2, @QuantityRequired smallint = 100)
as
begin
/*
exec [usp_Get_Decimal_Bulk] 0.01, 99.99, 2, 1000

*/

	SELECT	Round(rand(checksum(NewID())) * (@MaxValue - @MinValue), @decimalPlaces) Number
	from	[Reference].[Number] 
	where	Number <= @QuantityRequired
end