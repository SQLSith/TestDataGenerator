
CREATE proc Reference.[usp_Populate_Number]
as
	Truncate Table Reference.Number
	;

	insert	Reference.Number
	Select	row_number() over (order by n1.n)
	from	(values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) n1(n)
	cross join (values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) n2(n)
	cross join (values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) n3(n)
	cross join (values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) n4(n)