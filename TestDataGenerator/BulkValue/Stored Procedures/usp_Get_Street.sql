

CREATE     proc [BulkValue].[usp_Get_Street]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Street] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Street varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Street'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;


	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [StreetSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Street
	from	#Selection n
	join	[Reference].Street s	on	n.[StreetSK] = s.[StreetSK]
	order by NewID()
	
	Drop Table #Selection
	;
end