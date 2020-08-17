
CREATE    Proc [dbo].[usp_Get_Date_Bulk] (@MinDate date, @MaxDate date, @QuantityRequired smallint)
as
/*
Declare @MinDate date, @MaxDate date, @QuantityRequired smallint
Select	@MinDate = '1980-01-01',
		@MaxDate = getdate(),
		@QuantityRequired = 1000

exec dbo.usp_Get_Date_Bulk @MinDate, @MaxDate, @QuantityRequired

*/

	
Declare @RangeDays bigint = datediff(day, @MinDate, @MaxDate)

Select	dateadd(day, round(@RangeDays * rand(checksum(NewID())),0), @MinDate)
from	Number
where Number <= @QuantityRequired