

Create   Proc [Test].[usp_Get_PostArea_Fountain] (@MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as


Set nocount on
;

Drop table if exists #test
;

Create Table #test
(
PostArea varchar(50),
PostAreaName varchar(50)
)
;


Declare @PostArea varchar(50),
		@PostAreaName varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec Fountain.[usp_Get_PostArea] @PostArea = @PostArea out, @PostAreaName = @PostAreaName out
	;

	insert #test
	values(@PostArea, @PostAreaName)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	PostArea,
			PostAreaName,
			count(*)
	from	#test
	group by PostArea,
			PostAreaName
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop table if exists #test