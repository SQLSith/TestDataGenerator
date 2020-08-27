
Create   Proc [SingleValue].[usp_Get_Forename] (@Forename varchar(50) out)
as
/*
Declare @Forename varchar(50)
exec	SingleValue.usp_Get_Forename @Forename out
Select	@Forename
*/

	Select @Forename = [SingleValue].[ufn_Get_Forename]()