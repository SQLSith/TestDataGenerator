
CREATE     proc [BulkValue].[usp_Get_Colour]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Colour] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Colour varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Colour'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;


	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [ColourSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Colour
	from	#Selection n
	join	[Reference].Colour s	on	n.[ColourSK] = s.[ColourSK]
	order by NewID()
	;

	Drop table #Selection
	;

end