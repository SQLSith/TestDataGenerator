
CREATE   Proc [Test].[usp_Get_Number_Bulk] (@MinValue int = 1, @MaxValue int = 9, @QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
Number int
)
;


Declare @Number int,
		@Iteration int = 1,
		@ValuesGenerated int = 0
		
insert #test
exec BulkValue.usp_Get_Number @MinValue, @MaxValue, @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Number,
			count(*)
	from	#test
	group by Number
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop Table #test