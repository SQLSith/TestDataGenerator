CREATE proc [dbo].[usp_Populate_Size]
as
Truncate Table Size
;

insert	Size
values	('Small'),
		('Medium'),
		('Large')



if not exists (Select * from ReferenceControl where ReferenceTableName = 'Size')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Size', max(SizeSK), 1
	from Size
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(SizeSK) from Size)
	where	ReferenceTableName = 'Size'
end