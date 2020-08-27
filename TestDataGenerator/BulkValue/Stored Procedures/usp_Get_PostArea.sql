
CREATE     proc [BulkValue].[usp_Get_PostArea]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_PostArea] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'PostArea'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;

	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [PostAreaSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.PostArea, s.[PostAreaName]
	from	#Selection n
	join	[Reference].PostArea s	on	n.[PostAreaSK] = s.[PostAreaSK]
	order by NewID()
	;

	Drop table #Selection
	;

end