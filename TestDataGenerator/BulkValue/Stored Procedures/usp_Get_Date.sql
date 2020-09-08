
CREATE    Proc [BulkValue].[usp_Get_Date] (@MinDate date, @MaxDate date, @QuantityRequired smallint)
as
/*
Declare @MinDate date, @MaxDate date, @QuantityRequired smallint
Select	@MinDate = '1980-01-01',
		@MaxDate = getdate(),
		@QuantityRequired = 1000

exec BulkValue.usp_Get_Date @MinDate, @MaxDate, @QuantityRequired

*/

	
Declare @RangeDays bigint
Select	@RangeDays = datediff(day, @MinDate, @MaxDate)

Select	dateadd(day, round(@RangeDays * rand(checksum(NewID())),0), @MinDate) DateValue
from	[Reference].[Number]
where	Number <= @QuantityRequired