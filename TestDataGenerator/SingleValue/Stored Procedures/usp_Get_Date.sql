
Create    Proc [SingleValue].[usp_Get_Date] (@MinDate date, @MaxDate date, @Date date out)
as
/*
Declare @MinDate date, @MaxDate date, @NewDate date
Select	@MinDate = '1980-01-01',
		@MaxDate = getdate()

exec [SingleValue].usp_Get_Date @MinDate, @MaxDate, @NewDate out

Select @NewDate
*/

	Select  @Date = [SingleValue].[ufn_Get_Date](@MinDate, @MaxDate)