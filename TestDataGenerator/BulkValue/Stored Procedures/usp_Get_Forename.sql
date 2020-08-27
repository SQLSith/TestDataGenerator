

CREATE     proc [BulkValue].[usp_Get_Forename]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Forename] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Forename varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Forename'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;

	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [ForenameSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Forename
	from	#Selection n
	join	[Reference].Forename s	on	n.[ForenameSK] = s.[ForenameSK]
	order by NewID()
	;

	Drop table #Selection
	;

end