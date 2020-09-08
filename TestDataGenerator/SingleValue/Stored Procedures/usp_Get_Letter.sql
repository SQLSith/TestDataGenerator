
CREATE   proc [SingleValue].[usp_Get_Letter] (@Letter char(1) out)
as
begin
/*
Declare	@Letter char(1)
exec	[SingleValue].[usp_Get_Letter] @Letter out
Select	@Letter
*/

	Select @Letter = [SingleValue].[ufn_Get_Letter]()
	;

end