﻿

Create   Proc [Test].[usp_Get_Product] (@MaxIteration int = 100, @ResultOnly bit = 0, @Result tinyint = 0 out)
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
Product varchar(50)
)
;


Declare @Product varchar(50),
		@Iteration int = 1,
		@ValuesGenerated int = 0
		

while @Iteration <= @MaxIteration
begin
	exec [SingleValue].[usp_Get_Product] @Product = @Product out
	;

	insert #test
	values(@Product)
	;

	Select @Iteration = @Iteration + 1
end

Select	@ValuesGenerated = count(*)
from	#test

if @ResultOnly = 0
begin
	Select	@MaxIteration Expected,
			@ValuesGenerated Actual

	Select	Product,
			count(*)
	from	#test
	group by Product
	order by 1
	;
end

Select @Result = case when @MaxIteration = @ValuesGenerated then 1 else 0 end

Drop Table #test