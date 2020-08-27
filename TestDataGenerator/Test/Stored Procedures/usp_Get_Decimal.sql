
CREATE   Proc [Test].[usp_Get_Decimal] (@MinValue decimal(18,10) = 0.01, @MaxValue decimal(18,10) = 99.99, @decimalPlaces tinyint = 2, @MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as

Set nocount on
;

Drop table if exists #test
;

Create Table #test
(
Number decimal(18,10)
)
;


Declare @Number decimal(18,10),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec [SingleValue].[usp_Get_Decimal] @MinValue = @MinValue, @MaxValue = @MaxValue, @decimalPlaces = @decimalPlaces, @Number = @Number out
	;

	insert #test
	values(@Number)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	Number,
			count(*)
	from	#test
	group by Number
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop table if exists #test