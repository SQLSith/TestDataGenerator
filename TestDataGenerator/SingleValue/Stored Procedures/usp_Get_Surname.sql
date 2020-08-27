
Create   Proc [SingleValue].[usp_Get_Surname] (@Surname varchar(50) out)
as
/*
Declare @Surname varchar(50)
exec	SingleValue.usp_Get_Surname @Surname out
Select	@Surname
*/

	Select @Surname = [SingleValue].[ufn_Get_Surname]()