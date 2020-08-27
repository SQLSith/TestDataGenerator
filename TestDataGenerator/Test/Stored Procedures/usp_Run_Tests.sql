Create procedure Test.usp_Run_Tests
as

	Declare		@Results table ( TestedProcedure varchar(255), Result tinyint)

	Declare	@Result tinyint


-- Colour
	exec [Test].[usp_Get_Colour] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Colour]',@Result)
	;

	exec [Test].[usp_Get_Colour_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Colour]',@Result)
	;

	exec [Test].[usp_Get_Colour_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Colour]',@Result)
	;

	exec [Test].[usp_Get_Colour_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Colour]',@Result)
	;

-- Date

	exec [Test].[usp_Get_Date] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Date]',@Result)
	;

	exec [Test].[usp_Get_Date_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Date]',@Result)
	;


-- Decimal

	exec [Test].[usp_Get_Decimal] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Decimal]',@Result)
	;

	exec [Test].[usp_Get_Decimal_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Decimal]',@Result)
	;


-- Letter

	exec [Test].[usp_Get_Letter] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Letter]',@Result)
	;

	exec [Test].[usp_Get_Letter_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Letter]',@Result)
	;


-- Number

	exec [Test].[usp_Get_Number] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Number]',@Result)
	;

	exec [Test].[usp_Get_Number_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Number]',@Result)
	;


-- Phone Number

	exec [Test].[usp_Get_PhoneNumber] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_PhoneNumber]',@Result)
	;

	exec [Test].[usp_Get_PhoneNumber_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_PhoneNumber]',@Result)
	;


-- forename

	exec [Test].[usp_Get_Forename] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Forename]',@Result)
	;

	exec [Test].[usp_Get_Forename_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Forename]',@Result)
	;

	exec [Test].[usp_Get_Forename_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Forename]',@Result)
	;

	exec [Test].[usp_Get_Forename_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Forename]',@Result)
	;


-- Post Area

	exec [Test].[usp_Get_PostArea] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_PostArea]',@Result)
	;

	exec [Test].[usp_Get_PostArea_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_PostArea]',@Result)
	;

	exec [Test].[usp_Get_PostArea_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_PostArea]',@Result)
	;

	exec [Test].[usp_Get_PostArea_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_PostArea]',@Result)
	;


-- Product

	exec [Test].[usp_Get_Product] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Product]',@Result)
	;

	exec [Test].[usp_Get_Product_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Product]',@Result)
	;

	exec [Test].[usp_Get_Product_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Product]',@Result)
	;

	exec [Test].[usp_Get_Product_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Product]',@Result)
	;


-- Size


	exec [Test].[usp_Get_Size] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Size]',@Result)
	;

	exec [Test].[usp_Get_Size_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Size]',@Result)
	;

	exec [Test].[usp_Get_Size_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Size]',@Result)
	;

	exec [Test].[usp_Get_Size_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Size]',@Result)
	;


-- Street

	exec [Test].[usp_Get_Street] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Street]',@Result)
	;

	exec [Test].[usp_Get_Street_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Street]',@Result)
	;

	exec [Test].[usp_Get_Street_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Street]',@Result)
	;

	exec [Test].[usp_Get_Street_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Street]',@Result)
	;



-- Surname

	exec [Test].[usp_Get_Surname] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[SingleValue].[usp_Get_Surname]',@Result)
	;

	exec [Test].[usp_Get_Surname_Fountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[Fountain].[usp_Get_Surname]',@Result)
	;

	exec [Test].[usp_Get_Surname_Bulk] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkValue].[usp_Get_Surname]',@Result)
	;

	exec [Test].[usp_Get_Surname_BulkFountain] @ResultOnly = 1, @Result = @Result out
	insert	@Results (TestedProcedure, Result) values ('[BulkFountain].[usp_Get_Surname]',@Result)
	;






	Select	parsename(TestedProcedure, 1) ProcedureName,  
			parsename(TestedProcedure, 2) SchemaName,
			Result
	from	@Results
	order by parsename(TestedProcedure, 1),
			parsename(TestedProcedure, 2)