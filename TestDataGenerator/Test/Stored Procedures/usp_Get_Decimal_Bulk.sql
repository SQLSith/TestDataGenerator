
CREATE   Proc [Test].[usp_Get_Decimal_Bulk] (@MinValue decimal(18,10) = 0.01, @MaxValue decimal(18,10) = 99.99, @decimalPlaces tinyint = 2, @QuantityRequired smallint = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
Number decimal(18,10)
)
;


Declare @Iteration int = 1,
		@ValuesGenerated int = 0
		
insert #test
exec BulkValue.usp_Get_Decimal @MinValue, @MaxValue, @decimalPlaces, @QuantityRequired
;


Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Number,
			count(*)
	from	#test
	group by Number
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop Table #test