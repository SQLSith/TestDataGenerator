
Create   proc [dbo].[usp_Get_Letter_Bulk] (@QuantityRequired smallint)
as
begin
/*
exec [usp_Get_Letter_Bulk] 1000
*/
	
	Select	char((rand(checksum(NewID())) * 26) + 65) Letter 
	from	Number n
	where	Number <= @QuantityRequired
	order by n.Number
	;

end