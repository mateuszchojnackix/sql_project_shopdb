USE [ShopDB]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcuClientTotalOrderValue]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalcuClientTotalOrderValue](@ClientID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @Total_amount DECIMAL(10,2)
	SELECT @Total_amount = SUM(total_amount)
	FROM Orders
	WHERE Id_Client = @ClientID
	RETURN @Total_amount
END
GO
/****** Object:  Table [dbo].[Products]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id_Product] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Price] [decimal](10, 2) NULL,
	[Id_Category] [int] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id_Order] [int] NOT NULL,
	[Id_Client] [int] NOT NULL,
	[Invoice_Date] [date] NULL,
	[Id_Status] [int] NOT NULL,
	[total_amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Order]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Order](
	[Id_Detail] [int] NOT NULL,
	[Id_Product] [int] NOT NULL,
	[Id_Order] [int] NOT NULL,
	[unit] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrdersWithDetails]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[OrdersWithDetails]
AS
SELECT o.Id_Order, o.Id_Status, o.Total_amount, p.Name, d.unit
FROM Orders o
INNER JOIN Detail_Order d ON o.Id_Order = d.Id_Order
INNER JOIN Products p ON p.Id_Product = d.Id_Product
GO
/****** Object:  Table [dbo].[Client]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Id_Client] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Last_name] [varchar](50) NOT NULL,
	[Id_Country] [int] NOT NULL,
	[Id_City] [int] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[tel_number] [varchar](20) NOT NULL,
	[Street] [varchar](100) NOT NULL,
	[Number_of_building] [varchar](10) NOT NULL,
	[Number_of_apartament] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ClientOrders]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- widok zamowienia dokonane przez poszczegolnych klientow
CREATE VIEW [dbo].[ClientOrders]
AS
SELECT c.Name AS 'imię', c.Last_name as 'Nazwisko', p.Name as 'Nazwa produktu', d.unit as 'Ilość', o.Total_amount as 'suma całkowita'
FROM Client c
INNER JOIN Orders o ON o.Id_Client = c.Id_Client
INNER JOIN Detail_Order d ON d.Id_Order = o.Id_Order
INNER JOIN Products p ON p.Id_Product = d.Id_Product
GO
/****** Object:  View [dbo].[ProductStock]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductStock]
AS
SELECT p.Id_Product as 'id', p.Name as 'Nazwa produktu', p.Quantity as 'Ilość sztuk na magazynie'
FROM Products p
GO
/****** Object:  Table [dbo].[Category]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id_Category] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id_City] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Post_Code] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id_Country] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [varchar](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Country] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Id_Status] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_CLIENT_CITY] FOREIGN KEY([Id_City])
REFERENCES [dbo].[City] ([Id_City])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_CLIENT_CITY]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_CLIENTS_COUNTRY] FOREIGN KEY([Id_Country])
REFERENCES [dbo].[Country] ([Id_Country])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_CLIENTS_COUNTRY]
GO
ALTER TABLE [dbo].[Detail_Order]  WITH CHECK ADD FOREIGN KEY([Id_Product])
REFERENCES [dbo].[Products] ([Id_Product])
GO
ALTER TABLE [dbo].[Detail_Order]  WITH CHECK ADD  CONSTRAINT [FK_DETAIL_DETAIL_ORDERS] FOREIGN KEY([Id_Order])
REFERENCES [dbo].[Orders] ([Id_Order])
GO
ALTER TABLE [dbo].[Detail_Order] CHECK CONSTRAINT [FK_DETAIL_DETAIL_ORDERS]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_ORDERS_CLIENT] FOREIGN KEY([Id_Client])
REFERENCES [dbo].[Client] ([Id_Client])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_ORDERS_CLIENT]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_ORDERS_STATUS] FOREIGN KEY([Id_Status])
REFERENCES [dbo].[Status] ([Id_Status])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_ORDERS_STATUS]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([Id_Category])
REFERENCES [dbo].[Category] ([Id_Category])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
/****** Object:  StoredProcedure [dbo].[GetClientsByCategory]    Script Date: 29.05.2023 13:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientsByCategory]
    @CategoryId INT
AS
BEGIN
    SELECT c.Id_Client as 'id', c.name as 'Imię', c.Last_name as 'Nazwisko'
    FROM Client c
    INNER JOIN Orders o ON o.Id_Client = c.Id_Client
    INNER JOIN Detail_Order d ON d.Id_Order = o.Id_Order
    INNER JOIN Products p ON p.Id_Product = d.Id_Product
    WHERE p.Id_Category = @CategoryId
END
GO
