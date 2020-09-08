
Create Procedure [Reference].[usp_Maintain_Forename]
as

	if object_id('tempdb..#Forename') is not null
	begin
		Drop Table #Forename
	end
	;

	CREATE TABLE #Forename
	(
		[ForenameSK_old] [int] NOT NULL,
		[Forename] [varchar](50) NOT NULL,
		[ForenameSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#Forename ([ForenameSK_old], [Forename], [ForenameSK_new])
	Select [ForenameSK], 
			[Forename],
			row_number() over (order by [ForenameSK]) [ForenameSK_new]
	from	[Reference].[Forename]
	;

-- Truncate existing Data
	Truncate Table [Reference].[Forename]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[Forename] on
	;

	insert	[Reference].[Forename] ([ForenameSK], [Forename])
	Select	c.ForenameSK_new,
			c.[Forename]
	from	#Forename c
	order by c.[ForenameSK_old]
	;

	Set Identity_Insert [Reference].[Forename] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(ForenameSK) from Reference.Forename)
	where	ReferenceTableName = 'Forename'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [ForenameSK_new]
	from	SystemControl.ReferenceControl r
	join	#Forename m	on	r.LastAllocatedReferenceSK = m.ForenameSK_old
	where	ReferenceTableName = 'Forename'
	;