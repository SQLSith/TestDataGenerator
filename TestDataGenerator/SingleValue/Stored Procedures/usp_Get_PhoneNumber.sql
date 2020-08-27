
CREATE   Proc [SingleValue].[usp_Get_PhoneNumber] (@PhoneNumber varchar(15) out)
as
/*
Declare @PhoneNumber varchar(15)
exec	SingleValue.usp_Get_PhoneNumber @PhoneNumber out
Select	@PhoneNumber
*/

	Select	@PhoneNumber = [SingleValue].[ufn_Get_PhoneNumber]()