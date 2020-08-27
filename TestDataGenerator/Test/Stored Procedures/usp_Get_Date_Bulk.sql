
CREATE   Proc [Test].[usp_Get_Date_Bulk] (@MinDate date = '1980/01/01', @MaxDate date = '2020/01/01', @QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
[Date] Date
)
;

Declare @Date Date,
		@Iteration int = 1,
		@ValuesGenerated int = 0
		
insert #test
exec BulkValue.usp_Get_Date @MinDate, @MaxDate, @QuantityRequired
;


Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	[Date],
			count(*)
	from	#test
	group by [Date]
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test