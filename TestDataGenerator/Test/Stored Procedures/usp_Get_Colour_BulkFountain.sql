


CREATE   Proc [Test].[usp_Get_Colour_BulkFountain] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
Colour varchar(50)
)
;


Declare @Colour varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		
insert #test
exec	[BulkFountain].[usp_Get_Colour] @QuantityRequired
;


Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Colour,
			count(*)
	from	#test
	group by Colour
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test