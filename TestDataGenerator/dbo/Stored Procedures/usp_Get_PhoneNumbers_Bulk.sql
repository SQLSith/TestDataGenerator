
CREATE   Proc [dbo].[usp_Get_PhoneNumbers_Bulk] (@QuantityRequired smallint)
as
/*
exec [dbo].[usp_Get_PhoneNumbers_Bulk] 1000
*/


Declare @Prefix table (rw tinyint identity(1,1), Prefix varchar(3))
Declare @PhoneType table (rw tinyint identity(1,1), PhoneType varchar(3))
Declare @Number1 Table ( rw int identity(1,1), Number smallint)
Declare @Number2 Table ( rw int identity(1,1), Number smallint)
Declare @Number3 Table ( rw int identity(1,1), Number smallint)

Declare	@PhoneNumberElements table ( rw int identity(1,1), Number varchar(50), PrefixRw tinyint, PhoneTypeRw tinyint)



insert	@Prefix (Prefix) Values ('0'), ('44'), ('+44')
insert	@PhoneType (PhoneType) Values ('1'), ('2'), ('7')
insert @Number1 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 999, @QuantityRequired = @QuantityRequired
insert @Number2 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 999, @QuantityRequired = @QuantityRequired
insert @Number3 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 999, @QuantityRequired = @QuantityRequired

insert	@PhoneNumberElements
Select 	format(n1.Number, '0##') + ' ' + format(n2.Number, '0##') + format(n3.Number, '0##') Number, 
		ceiling(rand(checksum(NewID())) * 3) PrefixRw, 
		ceiling(rand(checksum(NewID())) * 3) PhoneTypeRw
from	@Number1 n1
join	@Number2 n2	on	n1.rw = n2.rw
join	@Number3 n3	on	n1.rw = n3.rw


Select	p.Prefix + t.PhoneType + e.Number PhoneNumber
from	@PhoneNumberElements e
join	@Prefix p	on	e.PrefixRw = p.rw
join	@PhoneType t	on	e.PhoneTypeRw = t.rw