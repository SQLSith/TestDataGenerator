

Create Procedure [Reference].[usp_Maintain_Surname]
as

	if object_id('tempdb..#Surname') is not null
	begin
		Drop Table #Surname
	end
	;

	CREATE TABLE #Surname
	(
		[SurnameSK_old] [int] NOT NULL,
		[Surname] [varchar](50) NOT NULL,
		[SurnameSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Surname ([SurnameSK_old], [Surname], [SurnameSK_new])
	Select [SurnameSK], 
			[Surname],
			row_number() over (order by [SurnameSK]) [SurnameSK_new]
	from	[Reference].[Surname]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Surname]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Surname] on
	;

	insert	[Reference].[Surname] ([SurnameSK], [Surname])
	Select	c.SurnameSK_new,
			c.[Surname]
	from	#Surname c
	order by c.[SurnameSK_old]
	;

	Set Identity_Insert [Reference].[Surname] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(SurnameSK) from Reference.Surname)
	where	ReferenceTableName = 'Surname'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [SurnameSK_new]
	from	SystemControl.ReferenceControl r
	join	#Surname m	on	r.LastAllocatedReferenceSK = m.SurnameSK_old
	where	ReferenceTableName = 'Surname'
	;