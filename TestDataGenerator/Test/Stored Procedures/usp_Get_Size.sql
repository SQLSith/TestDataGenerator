

Create   Proc [Test].[usp_Get_Size] (@MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
		

while @Iteration <= @MaxIteration
begin
	exec [SingleValue].[usp_Get_Size] @Size = @Size out
	;

	insert #test
	values(@Size)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	Size,
			count(*)
	from	#test
	group by Size
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop table if exists #test