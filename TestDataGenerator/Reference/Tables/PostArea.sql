CREATE TABLE [Reference].[PostArea] (
    [PostAreaSK]   INT          IDENTITY (1, 1) NOT NULL,
    [PostArea]     VARCHAR (2)  NULL,
    [PostAreaName] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([PostAreaSK] ASC)
);

