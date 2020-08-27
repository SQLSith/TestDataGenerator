

CREATE     proc [BulkValue].[usp_Get_Product]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Product] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Product varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Product'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;

	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [ProductSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Product
	from	#Selection n
	join	[Reference].Product s	on	n.[ProductSK] = s.[ProductSK]
	order by NewID()
	;

	Drop Table #Selection
	;

end