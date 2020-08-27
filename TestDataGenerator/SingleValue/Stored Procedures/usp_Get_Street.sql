
Create   Proc [SingleValue].[usp_Get_Street] (@Street varchar(50) out)
as
/*
Declare @Street varchar(50)
exec	SingleValue.usp_Get_Street @Street out
Select	@Street
*/

	Select @Street = [SingleValue].[ufn_Get_Street]()