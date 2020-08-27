
CREATE   Proc [Test].[usp_Get_Date] (@MinDate date = '1980/01/01', @MaxDate date = '2020/01/01', @MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
[Date] Date
)
;


Declare @Date Date,
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec SingleValue.usp_Get_Date @MinDate = @MinDate, @MaxDate = @MaxDate, @Date = @Date out
	;

	insert #test
	values(@Date)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	[Date],
			count(*)
	from	#test
	group by [Date]
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop Table #test