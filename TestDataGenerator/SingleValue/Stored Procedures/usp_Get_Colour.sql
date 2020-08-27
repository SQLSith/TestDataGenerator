

Create   Proc SingleValue.[usp_Get_Colour] (@Colour varchar(50) out)
as
/*
Declare @Colour varchar(50)
exec	SingleValue.usp_Get_Colour @Colour out
Select	@Colour
*/

	Select @Colour = [SingleValue].[ufn_Get_Colour]()