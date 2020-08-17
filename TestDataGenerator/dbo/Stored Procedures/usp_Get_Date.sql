Create    Proc usp_Get_Date (@MinDate date, @MaxDate date, @NewDate date out)
as
/*
Declare @MinDate date, @MaxDate date, @NewDate date
Select	@MinDate = '1980-01-01',
		@MaxDate = getdate()

exec dbo.usp_Get_Date @MinDate, @MaxDate, @NewDate out

Select @NewDate
*/

	
Declare @RangeDays bigint = datediff(day, @MinDate, @MaxDate)

Select  @NewDate = dateadd(day, round(@RangeDays * rand(),0), @MinDate)