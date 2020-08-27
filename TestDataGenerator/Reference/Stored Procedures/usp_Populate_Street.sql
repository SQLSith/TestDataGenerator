


Create proc Reference.[usp_Populate_Street] 
as

	Set Nocount on
	;

	Truncate Table Reference.Street
	;

	insert	Reference.Street (Street) values ('Albert Road')
	insert	Reference.Street (Street) values ('Albert Road')
	insert	Reference.Street (Street) values ('Alexander Road')
	insert	Reference.Street (Street) values ('Broadway')
	insert	Reference.Street (Street) values ('Chester Road')
	insert	Reference.Street (Street) values ('Church Lane')
	insert	Reference.Street (Street) values ('Church Road')
	insert	Reference.Street (Street) values ('Church Street')
	insert	Reference.Street (Street) values ('George Street')
	insert	Reference.Street (Street) values ('Grange Road')
	insert	Reference.Street (Street) values ('Green Lane')
	insert	Reference.Street (Street) values ('Grove Road')
	insert	Reference.Street (Street) values ('High Street')
	insert	Reference.Street (Street) values ('Highfield Road')
	insert	Reference.Street (Street) values ('King Street')
	insert	Reference.Street (Street) values ('Kings Road')
	insert	Reference.Street (Street) values ('Kingsway')
	insert	Reference.Street (Street) values ('London Road')
	insert	Reference.Street (Street) values ('Main Road')
	insert	Reference.Street (Street) values ('Main Street')
	insert	Reference.Street (Street) values ('Manchester Road')
	insert	Reference.Street (Street) values ('Manor Road')
	insert	Reference.Street (Street) values ('Mill Lane')
	insert	Reference.Street (Street) values ('Mill Road')
	insert	Reference.Street (Street) values ('New Road')
	insert	Reference.Street (Street) values ('New Street')
	insert	Reference.Street (Street) values ('North Road')
	insert	Reference.Street (Street) values ('North Street')
	insert	Reference.Street (Street) values ('Park Avenue')
	insert	Reference.Street (Street) values ('Park Lane')
	insert	Reference.Street (Street) values ('Park Road')
	insert	Reference.Street (Street) values ('Queen Street')
	insert	Reference.Street (Street) values ('Queens Road')
	insert	Reference.Street (Street) values ('Queensway')
	insert	Reference.Street (Street) values ('Richmond Road')
	insert	Reference.Street (Street) values ('School Lane')
	insert	Reference.Street (Street) values ('South Street')
	insert	Reference.Street (Street) values ('Springfield Road')
	insert	Reference.Street (Street) values ('St. John’s Road')
	insert	Reference.Street (Street) values ('Stanley Road')
	insert	Reference.Street (Street) values ('Station Road')
	insert	Reference.Street (Street) values ('The Avenue')
	insert	Reference.Street (Street) values ('The Crescent')
	insert	Reference.Street (Street) values ('The Drive')
	insert	Reference.Street (Street) values ('The Green')
	insert	Reference.Street (Street) values ('The Grove')
	insert	Reference.Street (Street) values ('Victoria Road')
	insert	Reference.Street (Street) values ('Victoria Street')
	insert	Reference.Street (Street) values ('West Street')
	insert	Reference.Street (Street) values ('Windsor Road')
	insert	Reference.Street (Street) values ('York Road')
	;


	if not exists (Select * from SystemControl.ReferenceControl where ReferenceTableName = 'Street')
	begin
		insert	SystemControl.ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
		Select	'Street', max(StreetSK), 1
		from	Reference.Street
	end
	else 
	begin
		Update	SystemControl.ReferenceControl
		set		[MaxReferenceSK] = (Select max(StreetSK) from Reference.Street)
		where	ReferenceTableName = 'Street'
	end