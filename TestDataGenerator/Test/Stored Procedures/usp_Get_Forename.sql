

Create   Proc [Test].[usp_Get_Forename] (@MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as


Set nocount on
;

Drop table if exists #test
;

Create Table #test
(
Forename varchar(50)
)
;


Declare @Forename varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec [SingleValue].[usp_Get_Forename] @Forename = @Forename out
	;

	insert #test
	values(@Forename)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	Forename,
			count(*)
	from	#test
	group by Forename
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop table if exists #test