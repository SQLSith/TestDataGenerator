
Use [TestDataGenerator]
go

Set nocount ON
go



/*
Generation by Function
The project includes a number of functions for generating single data values within a select statement:
*/


Declare		@DateOfBirth datetime

Select @DateOfBirth = [SingleValue].[ufn_Get_Date]('1960-01-01','1990-01-01')

Select	[SingleValue].[ufn_Get_Forename]() + ' ' +
		[SingleValue].[ufn_Get_Surname]() + ' was born on ' + 
		convert(varchar(20), @DateOfBirth, 103) + ' which makes him '+
		cast(datediff(day, @DateOfBirth, getdate()) / 365 as varchar(3)) + ' years old'













/*

Single Value by Procedure
This collection of procedures will randomly generate a single value, which can be captured in a variable or passed to a calling application. These procedures exist in the schema SingleValue.

*/


Declare	@Number varchar(2),
		@Street	varchar(50)

exec SingleValue.usp_Get_Number @MinValue = 1, @MaxValue= 99, @Number = @Number out
exec SingleValue.usp_Get_Street @Street = @Street out

Select	@Number + ' ' + @Street AddressLine












/*

A second set of procedures, under the schema Fountain, generate similar data items, but in a predefined order. Whilst only as random as the source table, they ensure that values are generated evenly over time.

*/


Declare @Forename varchar(50)

exec [Fountain].[usp_Get_Forename] @Forename= @Forename out

Select	* 
from	[Reference].[Forename]
where	[Forename] = @Forename
go 3













/*
Bulk Values by Procedure 
This collection of procedures will randomly generate  up to 10000 data values which can be captured in a table or passed to a calling application. These procedures exist in the schema BulkValue.
*/


exec [BulkValue].[usp_Get_PhoneNumber] 10














/*
A second set of procedures, under the schema BulkFountain, generate similar data items, but in a predefined order. Whilst only as random as the source table, they ensure that values are generated evenly over time.
*/


exec [BulkFountain].[usp_Get_Size] 10