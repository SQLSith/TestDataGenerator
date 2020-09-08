
Create    proc BulkValue.[usp_Get_Letter] (@QuantityRequired smallint)
as
begin
/*
exec BulkValue.[usp_Get_Letter] 1000
*/
	
	Select	char((rand(checksum(NewID())) * 26) + 65) Letter 
	from	[Reference].[Number] n
	where	Number <= @QuantityRequired
	order by n.Number
	;

end