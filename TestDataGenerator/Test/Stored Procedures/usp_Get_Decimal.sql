
Create   Proc Test.[usp_Get_Decimal] (@MinValue decimal(9,2) = 0.01, @MaxValue decimal(9,2) = 99.99, @decimalPlaces tinyint = 2, @MaxIteration int = 100)
as

Set nocount on
;

Drop table if exists #test
;

Create Table #test
(
Number decimal(9,2)
)
;


Declare @Number decimal(9,2),
		@Iteration int = 1
		

while @Iteration <= @MaxIteration
begin
	exec [usp_Get_Decimal] @MinValue = @MinValue, @MaxValue = @MaxValue, @decimalPlaces = @decimalPlaces, @Number = @Number out
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