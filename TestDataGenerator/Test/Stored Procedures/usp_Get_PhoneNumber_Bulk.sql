

CREATE   Proc [Test].[usp_Get_PhoneNumber_Bulk] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
PhoneNumber varchar(15)
)
;

Declare @ValuesGenerated int = 0
		
insert #test
exec	[BulkValue].[usp_Get_PhoneNumber] @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	PhoneNumber,
			count(*)
	from	#test
	group by PhoneNumber
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test