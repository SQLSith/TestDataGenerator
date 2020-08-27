
CREATE   Proc BulkValue.[usp_Get_PhoneNumber] (@QuantityRequired smallint)
as
/*
exec [BulkValue].[usp_Get_PhoneNumber] 1000
*/


	Declare @Prefix table (rw tinyint identity(1,1), Prefix varchar(3))
	Declare @PhoneType table (rw tinyint identity(1,1), PhoneType varchar(3))
	Declare @Number1 Table ( rw int identity(1,1), Number smallint)
	Declare @Number2 Table ( rw int identity(1,1), Number smallint)
	Declare @Number3 Table ( rw int identity(1,1), Number smallint)

	Declare	@PhoneNumberElements table ( rw int identity(1,1), Number varchar(50), PrefixRw tinyint, PhoneTypeRw tinyint)



	insert	@Prefix (Prefix) Values ('0'), ('44'), ('+44')
	insert	@PhoneType (PhoneType) Values ('1'), ('2'), ('7')
	
	insert	@Number1 (Number) 
	SELECT	ceiling(rand(checksum(NewID())) * 999) Number
	from	[Reference].[Number]
	where	Number <= @QuantityRequired


	insert	@Number2 (Number) 
	SELECT	ceiling(rand(checksum(NewID())) * 999) Number
	from	[Reference].[Number]
	where	Number <= @QuantityRequired

	insert	@Number3 (Number) 
	SELECT	ceiling(rand(checksum(NewID())) * 999) Number
	from	[Reference].[Number]
	where	Number <= @QuantityRequired


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