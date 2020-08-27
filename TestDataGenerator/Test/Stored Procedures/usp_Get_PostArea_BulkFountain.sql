


Create   Proc [Test].[usp_Get_PostArea_BulkFountain] (@QuantityRequired int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
as
Set nocount on
;


Drop table if exists #test
;

Create Table #test
(
PostArea varchar(50),
PostAreaName varchar(50)
)
;


Declare @PostArea varchar(50),
		@PostAreaName varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0

insert #test
exec	BulkFountain.[usp_Get_PostArea] @QuantityRequired
;

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@QuantityRequired Expected,
			@ValuesGenerated Actual

	Select	PostArea,
			PostAreaName,
			count(*)
	from	#test
	group by PostArea,
			PostAreaName
	order by 1
	;
end


Select @Result = case when @QuantityRequired = @ValuesGenerated then 1 else 0 end

Drop table if exists #test