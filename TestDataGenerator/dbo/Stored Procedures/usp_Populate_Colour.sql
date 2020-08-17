CREATE proc [dbo].[usp_Populate_Colour]
as
Truncate Table Colour
;


insert Colour values 
('White')
,('Yellow')
,('Blue')
,('Red')
,('Green')
,('Black')
,('Brown')
,('Azure')
,('Ivory')
,('Teal')
,('Silver')
,('Purple')
,('Navy blue')
,('Pea green')
,('Gray')
,('Orange')
,('Maroon')
,('Charcoal')
,('Aquamarine')
,('Coral')
,('Fuchsia')
,('Wheat')
,('Lime')
,('Crimson')
,('Khaki')
,('Hot pink')
,('Magenta')
,('Olden')
,('Plum')
,('Olive')
,('Cyan')


if not exists (Select * from ReferenceControl where ReferenceTableName = 'Colour')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Colour', max(ColourSK), 1
	from Colour
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(ColourSK) from Colour)
	where	ReferenceTableName = 'Colour'
end