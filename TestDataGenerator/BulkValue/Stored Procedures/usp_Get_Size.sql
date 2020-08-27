
CREATE     proc [BulkValue].[usp_Get_Size]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Size] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Size varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Size'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;

	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [SizeSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Size
	from	#Selection n
	join	[Reference].Size s	on	n.[SizeSK] = s.[SizeSK]
	order by NewID()

	Drop Table #Selection
	;	

end