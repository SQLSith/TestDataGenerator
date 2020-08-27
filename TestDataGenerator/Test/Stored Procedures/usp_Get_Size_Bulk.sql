

Create   Proc [Test].[usp_Get_Size_Bulk] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
Size varchar(50)
)
;


Declare @Size varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0

insert #test
exec	[BulkValue].[usp_Get_Size] @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Size,
			count(*)
	from	#test
	group by Size
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test