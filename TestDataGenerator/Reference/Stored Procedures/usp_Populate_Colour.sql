
CREATE proc [Reference].[usp_Populate_Colour]
as
	Truncate Table Reference.Colour
	;


	insert Reference.Colour values ('White')
	insert Reference.Colour values ('Yellow')
	insert Reference.Colour values ('Blue')
	insert Reference.Colour values ('Red')
	insert Reference.Colour values ('Green')
	insert Reference.Colour values ('Black')
	insert Reference.Colour values ('Brown')
	insert Reference.Colour values ('Azure')
	insert Reference.Colour values ('Ivory')
	insert Reference.Colour values ('Teal')
	insert Reference.Colour values ('Silver')
	insert Reference.Colour values ('Purple')
	insert Reference.Colour values ('Navy blue')
	insert Reference.Colour values ('Pea green')
	insert Reference.Colour values ('Gray')
	insert Reference.Colour values ('Orange')
	insert Reference.Colour values ('Maroon')
	insert Reference.Colour values ('Charcoal')
	insert Reference.Colour values ('Aquamarine')
	insert Reference.Colour values ('Coral')
	insert Reference.Colour values ('Fuchsia')
	insert Reference.Colour values ('Wheat')
	insert Reference.Colour values ('Lime')
	insert Reference.Colour values ('Crimson')
	insert Reference.Colour values ('Khaki')
	insert Reference.Colour values ('Hot pink')
	insert Reference.Colour values ('Magenta')
	insert Reference.Colour values ('Olden')
	insert Reference.Colour values ('Plum')
	insert Reference.Colour values ('Olive')
	insert Reference.Colour values ('Cyan')


	if not exists (Select * from SystemControl.ReferenceControl where ReferenceTableName = 'Colour')
	begin
		insert	SystemControl.ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
		Select	'Colour', max(ColourSK), 1
		from	Reference.Colour
	end
	else 
	begin
		Update	SystemControl.ReferenceControl
		set		[MaxReferenceSK] = (Select max(ColourSK) from Reference.Colour)
		where	ReferenceTableName = 'Colour'
	end