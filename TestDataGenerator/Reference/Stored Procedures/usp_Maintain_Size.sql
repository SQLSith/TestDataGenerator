

Create Procedure [Reference].[usp_Maintain_Size]
as

	if object_id('tempdb..#Size') is not null
	begin
		Drop Table #Size
	end
	;

	CREATE TABLE #Size
	(
		[SizeSK_old] [int] NOT NULL,
		[Size] [varchar](50) NOT NULL,
		[SizeSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Size ([SizeSK_old], [Size], [SizeSK_new])
	Select [SizeSK], 
			[Size],
			row_number() over (order by [SizeSK]) [SizeSK_new]
	from	[Reference].[Size]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Size]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Size] on
	;

	insert	[Reference].[Size] ([SizeSK], [Size])
	Select	c.SizeSK_new,
			c.[Size]
	from	#Size c
	order by c.[SizeSK_old]
	;

	Set Identity_Insert [Reference].[Size] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(SizeSK) from Reference.Size)
	where	ReferenceTableName = 'Size'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [SizeSK_new]
	from	SystemControl.ReferenceControl r
	join	#Size m	on	r.LastAllocatedReferenceSK = m.SizeSK_old
	where	ReferenceTableName = 'Size'
	;