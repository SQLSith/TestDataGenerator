
CREATE     proc [dbo].[usp_Get_Number_Bulk]( @MinValue int = 1, @MaxValue int = 9, @QuantityRequired smallint)
as
begin
/*
exec usp_Get_Number_Bulk 95, 100, 1000

*/

SELECT --round(rand(checksum(NewID())) * @MaxValue,0) Number
		(@MinValue - 1) + ceiling(rand(checksum(NewID())) * (@MaxValue - @MinValue + 1)) Number
from	Number 
where	Number <= @QuantityRequired
end