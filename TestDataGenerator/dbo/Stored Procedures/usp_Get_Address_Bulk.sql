
Create   Proc [dbo].[usp_Get_Address_Bulk] (@QuantityRequired smallint)
as
/*
exec [dbo].[usp_Get_Address_Bulk] 1000
*/



Declare @PostArea Table ( rw int identity(1,1), PostArea varchar(2), PostAreaName varchar(50))
Declare @Number1 Table ( rw int identity(1,1), Number char(1))
Declare @Number2 Table ( rw int identity(1,1), Number char(2))
Declare @Number3 Table ( rw int identity(1,1), Number char(2))
Declare @Street Table ( rw int identity(1,1), Street varchar(50))
Declare @Letter1 Table ( rw int identity(1,1), Letter char(1))
Declare @Letter2 Table ( rw int identity(1,1), Letter char(1))

insert @PostArea (PostArea, PostAreaName) exec	[dbo].[usp_Get_PostArea_Bulk] @QuantityRequired = @QuantityRequired
insert @Number1 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 9, @QuantityRequired = @QuantityRequired
insert @Number2 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 99, @QuantityRequired = @QuantityRequired
insert @Number3 (Number) exec [dbo].[usp_Get_Number_Bulk] @MaxValue = 99, @QuantityRequired = @QuantityRequired
insert @Street (Street) exec [dbo].[usp_Get_Street_Bulk] @QuantityRequired = @QuantityRequired
insert @Letter1 (Letter) exec [dbo].[usp_Get_Letter_Bulk] @QuantityRequired = @QuantityRequired
insert @Letter2 (Letter) exec [dbo].[usp_Get_Letter_Bulk] @QuantityRequired = @QuantityRequired



Select	pa.PostArea + n2.Number + ' ' + n1.Number + l1.Letter + l2.Letter PostCode,
		n3.Number + ' ' + s.Street AddressLine1,
		pa.PostAreaName
from	@PostArea pa
join	@Number1 n1	on	pa.rw = n1.rw
join	@Number2 n2	on	pa.rw = n2.rw
join	@Number3 n3	on	pa.rw = n3.rw
join	@Street s	on	pa.rw = s.rw
join	@Letter1 l1	on	pa.rw = l1.rw
join	@Letter2 l2	on	pa.rw = l2.rw