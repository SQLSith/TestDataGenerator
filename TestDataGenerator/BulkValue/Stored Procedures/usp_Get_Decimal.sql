CREATE       proc [BulkValue].[usp_Get_Decimal]( @MinValue decimal(18,10) = 0.01, @MaxValue decimal(18,10) = 99.99, @decimalPlaces tinyint = 2, @QuantityRequired smallint = 100)
as
begin
/*
exec [BulkValue].[usp_Get_Decimal] 0.01, 99.99, 2, 1000

*/

	SELECT	cast(Round(rand(checksum(NewID())) * (@MaxValue - @MinValue), @decimalPlaces) as decimal(18,10)) Number
	from	[Reference].[Number] 
	where	Number <= @QuantityRequired
end