
CREATE   Proc [Test].[usp_Get_Number] (@MinValue int = 1, @MaxValue int = 9, @MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
Number int
)
;


Declare @Number int,
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec SingleValue.usp_Get_Number @MinValue = @MinValue, @MaxValue = @MaxValue, @Number = @Number out
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

Drop Table #test