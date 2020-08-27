
Create   Proc [SingleValue].[usp_Get_Product] (@Product varchar(50) out)
as
/*
Declare @Product varchar(50)
exec	SingleValue.usp_Get_Product @Product out
Select	@Product
*/

	Select @Product = [SingleValue].[ufn_Get_Product]()