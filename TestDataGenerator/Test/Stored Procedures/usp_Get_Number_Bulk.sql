
CREATE   Proc [Test].[usp_Get_Number_Bulk] (@MinValue int = 1, @MaxValue int = 9, @QuantityRequired int = 100)
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
		
insert #test
exec usp_Get_Number_Bulk @MinValue, @MaxValue, @QuantityRequired
;

Select Number,
		count(*)
from	#test
group by Number
order by 1


Drop table if exists #test