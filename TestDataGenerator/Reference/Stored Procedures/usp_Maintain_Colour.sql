Create Procedure [Reference].[usp_Maintain_Colour]
as

	if object_id('tempdb..#Colour') is not null
	begin
		Drop Table #Colour
	end
	;

	CREATE TABLE #Colour
	(
		[ColourSK_old] [int] NOT NULL,
		[Colour] [varchar](50) NOT NULL,
		[ColourSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Colour ([ColourSK_old], [Colour], [ColourSK_new])
	Select [ColourSK], 
			[Colour],
			row_number() over (order by [ColourSK]) [ColourSK_new]
	from	[Reference].[Colour]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Colour]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Colour] on
	;

	insert	[Reference].[Colour] ([ColourSK], [Colour])
	Select	c.ColourSK_new,
			c.[Colour]
	from	#Colour c
	order by c.[ColourSK_old]
	;

	Set Identity_Insert [Reference].[Colour] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(ColourSK) from Reference.Colour)
	where	ReferenceTableName = 'Colour'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [ColourSK_new]
	from	SystemControl.ReferenceControl r
	join	#Colour m	on	r.LastAllocatedReferenceSK = m.ColourSK_old
	where	ReferenceTableName = 'Colour'
	;