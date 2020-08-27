
CREATE   proc [SingleValue].[usp_Get_Letter] (@Letter char(1) out)
as
begin
/*
Declare	@Letter char(1)
exec	usp_Get_Letter @Letter out
Select	@Letter
*/

	Select top 1 @Letter = [SingleValue].[ufn_Get_Letter]()
	;

end