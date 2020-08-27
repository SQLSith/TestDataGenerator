

CREATE   Proc [Test].[usp_Get_Letter_Bulk] (@MinValue int = 1, @MaxValue int = 9, @QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
Letter char(1)
)
;


Declare @Letter char(1),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		
insert #test
exec	[BulkValue].[usp_Get_Letter] @QuantityRequired
;


Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Letter,
			count(*)
	from	#test
	group by Letter
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test