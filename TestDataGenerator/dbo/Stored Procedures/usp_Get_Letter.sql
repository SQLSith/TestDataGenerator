
CREATE   proc [dbo].[usp_Get_Letter] (@Letter char(1) out)
as
begin
/*
Declare @Letter char(1)
exec usp_Get_Letter @Letter out
Select @Letter
*/

	Select top 1 @Letter = char((rand(checksum(NewID())) * 26) + 65)
	;

end