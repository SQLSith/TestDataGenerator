CREATE     proc [BulkValue].[usp_Get_Number]( @MinValue int = 1, @MaxValue int = 9, @QuantityRequired smallint)
as
begin
/*
exec [BulkValue].[usp_Get_Number] 95, 100, 1000

*/

	SELECT	(@MinValue - 1) + ceiling(rand(checksum(NewID())) * (@MaxValue - @MinValue + 1)) Number
	from	 [Reference].[Number]
	where	Number <= @QuantityRequired
end