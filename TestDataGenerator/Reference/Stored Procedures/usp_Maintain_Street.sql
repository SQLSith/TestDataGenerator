

Create Procedure [Reference].[usp_Maintain_Street]
as

	if object_id('tempdb..#Street') is not null
	begin
		Drop Table #Street
	end
	;

	CREATE TABLE #Street
	(
		[StreetSK_old] [int] NOT NULL,
		[Street] [varchar](50) NOT NULL,
		[StreetSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Street ([StreetSK_old], [Street], [StreetSK_new])
	Select [StreetSK], 
			[Street],
			row_number() over (order by [StreetSK]) [StreetSK_new]
	from	[Reference].[Street]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Street]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Street] on
	;

	insert	[Reference].[Street] ([StreetSK], [Street])
	Select	c.StreetSK_new,
			c.[Street]
	from	#Street c
	order by c.[StreetSK_old]
	;

	Set Identity_Insert [Reference].[Street] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(StreetSK) from Reference.Street)
	where	ReferenceTableName = 'Street'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [StreetSK_new]
	from	SystemControl.ReferenceControl r
	join	#Street m	on	r.LastAllocatedReferenceSK = m.StreetSK_old
	where	ReferenceTableName = 'Street'
	;