
Create   Proc Test.usp_Get_Number (@MinValue int = 1, @MaxValue int = 9, @MaxIteration int = 100)
as

Set nocount on
;

Drop table if exists #test
;

Create Table #test
(
Number int
)
;


Declare @Number int,
		@Iteration int = 1
		

while @Iteration <= @MaxIteration
begin
	exec usp_Get_Number @MinValue = @MinValue, @MaxValue = @MaxValue, @Number = @Number out
	;

	insert #test
	values(@Number)
	;

	Select @Iteration = @Iteration + 1
end


Select Number,
		count(*)
from	#test
group by Number
order by 1
;

Drop table if exists #test