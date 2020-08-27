
CREATE proc Reference.[usp_Populate_Size]
as

	Truncate Table Reference.Size
	;

	insert	Reference.Size (Size) values ('Small')
	insert	Reference.Size (Size) values ('Medium')
	insert	Reference.Size (Size) values ('Large')



	if not exists (Select * from SystemControl.ReferenceControl where ReferenceTableName = 'Size')
	begin
		insert	SystemControl.ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
		Select	'Size', max(SizeSK), 1
		from Size
	end
	else 
	begin
		Update	SystemControl.ReferenceControl
		set		[MaxReferenceSK] = (Select max(SizeSK) from Size)
		where	ReferenceTableName = 'Size'
	end