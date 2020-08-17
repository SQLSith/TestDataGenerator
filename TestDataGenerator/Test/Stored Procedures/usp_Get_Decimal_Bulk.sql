
Create   Proc Test.usp_Get_Decimal_Bulk (@MinValue decimal(9,2) = 0.01, @MaxValue decimal(9,2) = 99.99, @decimalPlaces tinyint = 2, @QuantityRequired smallint = 100)
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


Declare @Iteration int = 1
		
insert #test
exec usp_Get_Decimal_Bulk @MinValue, @MaxValue, @decimalPlaces, @QuantityRequired
;

Select Number,
		count(*)
from	#test
group by Number
order by 1


Drop table if exists #test