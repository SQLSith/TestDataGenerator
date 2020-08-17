
CREATE proc [dbo].[usp_Populate_Product]
as
Truncate Table Product
;

insert Product (Product)
Values	('Bicycle'),
		('Tablet'),
		('Toy Car'),
		('Radio Controlled Car'),
		('Radio Controlled Helicopter'),
		('Briefcase'),
		('Shot Glass'),
		('Headphones'),
		('Cup'),
		('Bowl'),
		('Jigsaw'),
		('T-Shirt'),
		('Tote Bag'),
		('Photo Frame')

if not exists (Select * from ReferenceControl where ReferenceTableName = 'Product')
begin
	insert	ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
	Select	'Product', max(ProductSK), 1
	from Product
end
else 
begin
	Update	ReferenceControl
	set		[MaxReferenceSK] = (Select max(ProductSK) from Product)
	where	ReferenceTableName = 'Product'
end