
CREATE   Proc SingleValue.[usp_Get_Size] (@Size varchar(50) out)
as
/*
Declare @Size varchar(50)
exec	SingleValue.usp_Get_Size @Size out
Select	@Size
*/

	Select @Size = [SingleValue].[ufn_Get_Size]()