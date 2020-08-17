

Create proc usp_Populate_Street 
as

Truncate Table Street
;

insert	Street (Street)
Select	Street
from	(values
('Albert Road'),
('Alexander Road'),
('Broadway'),
('Chester Road'),
('Church Lane'),
('Church Road'),
('Church Street'),
('George Street'),
('Grange Road'),
('Green Lane'),
('Grove Road'),
('High Street'),
('Highfield Road'),
('King Street'),
('Kings Road'),
('Kingsway'),
('London Road'),
('Main Road'),
('Main Street'),
('Manchester Road'),
('Manor Road'),
('Mill Lane'),
('Mill Road'),
('New Road'),
('New Street'),
('North Road'),
('North Street'),
('Park Avenue'),
('Park Lane'),
('Park Road'),
('Queen Street'),
('Queens Road'),
('Queensway'),
('Richmond Road'),
('School Lane'),
('South Street'),
('Springfield Road'),
('St. John’s Road'),
('Stanley Road'),
('Station Road'),
('The Avenue'),
('The Crescent'),
('The Drive'),
('The Green'),
('The Grove'),
('Victoria Road'),
('Victoria Street'),
('West Street'),
('Windsor Road'),
('York Road')) Street (Street)
;


if not exists (Select * from ReferenceControl where ReferenceTableName = 'Street')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Street', max(StreetSK), 1
	from Street
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(StreetSK) from Street)
	where	ReferenceTableName = 'Street'
end