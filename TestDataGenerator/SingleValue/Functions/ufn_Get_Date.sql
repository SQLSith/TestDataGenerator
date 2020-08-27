

CREATE function [SingleValue].[ufn_Get_Date]
(
	@MinDate date, @MaxDate date
)
RETURNS date
AS
BEGIN
	Declare	@NDate date

	Declare @RangeDays bigint = datediff(day, @MinDate, @MaxDate)

	Select	@NDate = dateadd(day, round(@RangeDays * RandomNumber,0), @MinDate)
	from	SingleValue.[vw_RandomNumber]

	RETURN @NDate

END