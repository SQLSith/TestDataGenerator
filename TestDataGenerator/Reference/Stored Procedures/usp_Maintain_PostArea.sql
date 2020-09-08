
CREATE Procedure [Reference].[usp_Maintain_PostArea]
as

	if object_id('tempdb..#PostArea') is not null
	begin
		Drop Table #PostArea
	end
	;

	CREATE TABLE #PostArea
	(
		[PostAreaSK_old] [int] NOT NULL,
		[PostArea] [varchar](2) NOT NULL,
		[PostAreaName] [varchar](50) NOT NULL,
		[PostAreaSK_new] int NOT NULL
	)
	;

	

-- Capture existing data and order
	insert	#PostArea ([PostAreaSK_old], [PostArea], [PostAreaName], [PostAreaSK_new])
	Select [PostAreaSK], 
			[PostArea],
			[PostAreaName],
			row_number() over (order by [PostAreaSK]) [PostAreaSK_new]
	from	[Reference].[PostArea]
	;

-- Truncate existing Data
	Truncate Table [Reference].[PostArea]
	;

-- insert data with new identity values, but capturing the link between old and new SK Values
	Set Identity_Insert [Reference].[PostArea] on
	;

	insert	[Reference].[PostArea] ([PostAreaSK], [PostArea], [PostAreaName])
	Select	c.PostAreaSK_new,
			c.[PostArea],
			c.[PostAreaName]
	from	#PostArea c
	order by c.[PostAreaSK_old]
	;

	Set Identity_Insert [Reference].[PostArea] off
	;

-- Update [SystemControl].[ReferenceControl] with the new maximum reference sk, and the last allocated value

	Update	SystemControl.ReferenceControl
	set		[MaxReferenceSK] = (Select max(PostAreaSK) from Reference.PostArea)
	where	ReferenceTableName = 'PostArea'
	;

	Update	r
	set		[LastAllocatedReferenceSK] = [PostAreaSK_new]
	from	SystemControl.ReferenceControl r
	join	#PostArea m	on	r.LastAllocatedReferenceSK = m.PostAreaSK_old
	where	ReferenceTableName = 'PostArea'
	;