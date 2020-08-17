CREATE TABLE [dbo].[Product] (
    [ProductSK] INT          IDENTITY (1, 1) NOT NULL,
    [Product]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([ProductSK] ASC)
);

