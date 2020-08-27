

Create   Proc [Test].[usp_Get_Surname_BulkFountain] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
Surname varchar(50)
)
;


Declare @Surname varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0

insert #test
exec	[BulkFountain].[usp_Get_Surname] @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	Surname,
			count(*)
	from	#test
	group by Surname
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test