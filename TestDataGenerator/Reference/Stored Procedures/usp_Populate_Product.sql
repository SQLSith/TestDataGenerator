
CREATE proc Reference.[usp_Populate_Product]
as
	Set Nocount on 
	;

	Truncate Table Reference.Product
	;

	insert Reference.Product (Product) Values	('Bicycle')
	insert Reference.Product (Product) Values	('Tablet')
	insert Reference.Product (Product) Values	('Toy Car')
	insert Reference.Product (Product) Values	('Radio Controlled Car')
	insert Reference.Product (Product) Values	('Radio Controlled Helicopter')
	insert Reference.Product (Product) Values	('Briefcase')
	insert Reference.Product (Product) Values	('Shot Glass')
	insert Reference.Product (Product) Values	('Headphones')
	insert Reference.Product (Product) Values	('Cup')
	insert Reference.Product (Product) Values	('Bowl')
	insert Reference.Product (Product) Values	('Jigsaw')
	insert Reference.Product (Product) Values	('T-Shirt')
	insert Reference.Product (Product) Values	('Tote Bag')
	insert Reference.Product (Product) Values	('Photo Frame')

	if not exists (Select * from SystemControl.ReferenceControl where ReferenceTableName = 'Product')
	begin
		insert	SystemControl.ReferenceControl ([ReferenceTableName], [MaxReferenceSK], [LastAllocatedReferenceSK])
		Select	'Product', max(ProductSK), 1
		from	Reference.Product
	end
	else 
	begin
		Update	SystemControl.ReferenceControl
		set		[MaxReferenceSK] = (Select max(ProductSK) from Reference.Product)
		where	ReferenceTableName = 'Product'
	end