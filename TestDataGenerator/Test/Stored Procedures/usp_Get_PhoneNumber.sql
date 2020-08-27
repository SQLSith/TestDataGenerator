
CREATE   Proc [Test].[usp_Get_PhoneNumber] (@MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
PhoneNumber varchar(15)
)
;


Declare @PhoneNumber varchar(15),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec SingleValue.usp_Get_PhoneNumber @PhoneNumber = @PhoneNumber out
	;

	insert #test
	values(@PhoneNumber)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	PhoneNumber,
			count(*)
	from	#test
	group by PhoneNumber
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop Table #test