

Create   Proc [Test].[usp_Get_Street_BulkFountain] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


if object_id('tempdb..#test') is not null
begin
	Drop Table #test
end
;

Create Table #test
(
Street varchar(50)
)
;


Declare @Street varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0

insert #test
exec	[BulkFountain].[usp_Get_Street] @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Street,
			count(*)
	from	#test
	group by Street
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop Table #test