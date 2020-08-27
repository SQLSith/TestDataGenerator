

CREATE     proc [BulkValue].[usp_Get_Surname]( @QuantityRequired smallint)
as
begin
/*
exec	[BulkValue].[usp_Get_Surname] 100

*/

	Declare	@MaxSK int,
			@ChosenSK int,
			@Surname varchar(50)

	Select	@MaxSK = [MaxReferenceSK]
	from	SystemControl.ReferenceControl
	where	[ReferenceTableName] = 'Surname'
	;

	if object_id('tempdb..#Selection') is not null
	begin
		Drop Table #Selection
	end
	;

	Select	ceiling(rand(checksum(NewID())) * @MaxSK) [SurnameSK]
	into	#Selection
	from	[Reference].[Number] n
	where	n.Number <= @QuantityRequired
	;

	SELECT	s.Surname
	from	#Selection n
	join	[Reference].Surname s	on	n.[SurnameSK] = s.[SurnameSK]
	order by NewID()
	
	Drop Table #Selection
	;


end