# Test Data Generator

This project is a SQL only test data generator, which I originally built to support my own work, but decided to make available for others. This build is compatible with SQL 2012 onwards.

<br><br>
## Types of Test Data

Test data can be generated in several ways, and covers both individual value and bulk data generation. Different methods of generation are identifiable based on the following schemas:

| Schema | Description |
| --- | --- |
| SingleValue | This collection of procedures and scalar value functions will randomly generate a single value. |
| BulkValue | This collection of procedures can be used to generate a record set of up to 10000 values. |
| Fountain | This collection of procedures can be used to return the next available value from a list of possible values. This is useful when an even spread of values, as opposed to strictly random values, is required. |
| BulkFountain | This collection of procedures can be used to return a record set of up to 10000 values, starting the next available value from a list of possible values. This is useful when an even spread of values, as opposed to strictly random values, is required. If the number of values required exceeds the number of available values, then values are recycled. |
| Composite | This collection of procedures is based on combinations of individual test data procedures which I have found useful, and are included mainly for demonstrative purposes. |

<br><br>
## Data Items

The following data items are included in the current build:

| Data Item | Description |
| --- | --- |
| Colour | Generates colour values based on the table `[Reference].[Colour]`. |
| Date | Generates date values generated within a range specified through the `@MinDate` and `@MaxDate` parameters.|
| Decimal | Generates decimal values generated within a range specified through the `@MinValue` and `@MaxValue` parameters, and with up to 10 decimal places as specified through the `@decimalPlaces` parameters.|
| Forename | Generates forename values based on the table `[Reference].[Forename]`. |
| Letter | Generates uppercase letters. |
| Number | Generates integer values within a range specified through the `@MinValue` and `@MaxValue` parameters. |
| Phone Number | Generates UK type phone numbers in a number of common formats. |
| Post Area | Generates values for UK post area and post area names, and are intended for constructing postcode and address data. An example of this can be found in `[Composite].[usp_Get_Address]` |
| Product | Generates product name values based on table `[Reference].[Product]` |
| Size | Generates product size values based on the table `[Reference].[Size]` |
| Street | Generates a street name value based on the table `[Reference].[Street]` |
| Surname | Generates a surname value based on the table `[Reference].[Surname]` |

<br><br>
## Reference Data Maintenance

A number of the data items are generated based on reference tables. It is possible to customise the values in these tables as long as the following requirements are met:

* There each reference table contains an identity value which is used to within the allocation processes. It is critical that this field is maintained such that there are no missing values.
* Each reference table has a corresponding value in `[SystemControl].[ReferenceControl]`. The value of `[MaxReferenceSK]` must be maintained to match the number of records in the reference table. 
