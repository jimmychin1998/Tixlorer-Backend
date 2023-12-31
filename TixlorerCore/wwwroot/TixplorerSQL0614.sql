USE [Tixplorer]
GO
/****** Object:  UserDefinedFunction [dbo].[getCartDetailID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getCartDetailID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @cd_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @cd_id = 'CD' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Cart_Detail.cd_id, 4) AS int)), 0) + 1), 4)
      FROM Cart_Detail
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Cart_Detail.cd_id, 6 ) = 'CD' + @date
	  
	  --回傳s_id
      RETURN @cd_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getCartID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getCartID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @c_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @c_id = 'C' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Cart.c_id, 4) AS int)), 0) + 1), 4)
      FROM Cart
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Cart.c_id, 5 ) = 'C' + @date
	  
	  --回傳s_id
      RETURN @c_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getCouponID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getCouponID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @coupon_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @coupon_id = 'CP' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Coupon.coupon_id, 4) AS int)), 0) + 1), 4)
      FROM Coupon
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Coupon.coupon_id, 6 ) = 'CP' + @date
	  
	  --回傳s_id
      RETURN @coupon_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getDestID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getDestID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @dest_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = RIGHT(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @dest_id = 'D' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Destination.dest_id, 4) AS int)), 0) + 1), 4)
      FROM Destination
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Destination.dest_id, 5 ) =  'D' + @date
	  
	  --回傳s_id
      RETURN @dest_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getMemberID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION  [dbo].[getMemberID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數s_id，宣告型別為nvarchar，長度20
      DECLARE @m_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = RIGHT(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @m_id = 'M' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Member.m_id, 4) AS int)), 0) + 1), 4)
      FROM Member
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Member.m_id, 5 ) = 'M' + @date
	  
	  --回傳s_id
      RETURN @m_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getOrderID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getOrderID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @order_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @order_id = 'O' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT([Order].order_id, 4) AS int)), 0) + 1), 4)
      FROM [Order]
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( [Order].order_id, 5 ) = 'O' + @date
	  
	  --回傳s_id
      RETURN @order_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getProductID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getProductID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數p_id，宣告型別為nvarchar，長度20
      DECLARE @p_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = RIGHT(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @p_id = 'P' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Product.p_id, 4) AS int)), 0) + 1), 4)
      FROM Product
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT(Product.p_id, 5 ) = 'P' + @date
	  
	  --回傳s_id
      RETURN @p_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getStaffID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getStaffID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數s_id，宣告型別為nvarchar，長度20
      DECLARE @s_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = RIGHT(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @s_id = 'S' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Staff.s_id, 4) AS int)), 0) + 1), 4)
      FROM Staff
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Staff.s_id, 5 ) = 'S' + @date
	  
	  --回傳s_id
      RETURN @s_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getSupplierID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getSupplierID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數dest_id，宣告型別為nvarchar，長度20
      DECLARE @supplier_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @supplier_id = 'SP' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Supplier.supplier_id, 4) AS int)), 0) + 1), 4)
      FROM Supplier
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT( Supplier.supplier_id, 6 ) = 'SP' + @date
	  
	  --回傳s_id
      RETURN @supplier_id

END
GO
/****** Object:  UserDefinedFunction [dbo].[getTicketID]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[getTicketID]()
RETURNS nvarchar(20)
AS
BEGIN
      --宣告變數ticket_id，宣告型別為nvarchar，長度20
      DECLARE @ticket_id nvarchar(20)
	  --宣告變數date，宣告型別為nvarchar，長度20
      DECLARE @date nvarchar(20)

	  --下列程式碼為取得現在的日期，格式為202306，只取到月份
	  --Convert：Convert(型別,變數或字串,[日期格式])→轉換資料為指定型別，日期格式可填可不填，只有填入日期型別時需要用到，詳細填的值需參考MS官網
      SELECT @date = Right(CONVERT(nvarchar(6), GETDATE(), 112),4)

	  --下程式碼為定義欲自定義編號的格式，範例格式為：S202306000001
      --Right：Right(文字或變數,保留長度)→保留字串由右算起N位數文字
	  --Cast：Cast(變數 as 型別)→功能同Convert，為轉換資料型別
	  --MAX：MAX(欄位))→取得該欄位最大值
	  --isNULL：isNULL(欄位,0)→判斷欄位是否沒有資料(null)，如果是，則回傳0
	  --RTRIM：RTRIM()→移除字串尾端的空白內容(此處僅預防用)
	  SELECT @ticket_id = 'T' + @date + RIGHT('000' + RTRIM(ISNULL(MAX(CAST(RIGHT(Ticket.ticket_id, 4) AS int)), 0) + 1), 4)
      FROM Ticket
	  --Left(文字或變數,保留長度)→保留字串由左算起N位數文字
      WHERE LEFT(Ticket.ticket_id, 5 ) = 'T' + @date
	  
	  --回傳s_id
      RETURN @ticket_id

END
GO
/****** Object:  Table [dbo].[Bonus_Point_Record]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus_Point_Record](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[operate_type] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[m_id] [nvarchar](20) NULL,
	[order_id] [nvarchar](20) NULL,
 CONSTRAINT [PK_Bonus_Point_Record] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[c_id] [nvarchar](20) NOT NULL,
	[m_id] [nvarchar](20) NULL,
	[type] [int] NOT NULL,
	[p_id] [nvarchar](20) NULL,
	[count] [int] NOT NULL,
	[totalprice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart_Detail]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Detail](
	[cd_id] [nvarchar](20) NOT NULL,
	[c_id] [nvarchar](20) NULL,
	[ticket_id] [nvarchar](20) NULL,
	[group_id] [int] NULL,
	[count] [int] NOT NULL,
	[totalprice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Cart_Detail] PRIMARY KEY CLUSTERED 
(
	[cd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComboGroup]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComboGroup](
	[group_id] [int] NOT NULL,
	[name] [nvarchar](100) NULL,
	[build_date] [datetime] NOT NULL,
 CONSTRAINT [PK_ComboGroup_1] PRIMARY KEY CLUSTERED 
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComboGroup_Detail]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComboGroup_Detail](
	[serial_id] [nvarchar](20) NOT NULL,
	[group_id] [int] NULL,
	[ticket_id] [nvarchar](20) NULL,
 CONSTRAINT [PK_ComboGroup_detail] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupon]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupon](
	[coupon_id] [nvarchar](20) NOT NULL,
	[name] [nchar](80) NOT NULL,
	[p_id] [nvarchar](20) NOT NULL,
	[discount_type] [int] NOT NULL,
	[discount] [int] NOT NULL,
	[usable_day] [int] NOT NULL,
	[expiration_date] [datetime] NULL,
 CONSTRAINT [PK_Coupon] PRIMARY KEY CLUSTERED 
(
	[coupon_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupon_Use_Record]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupon_Use_Record](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[use_date] [datetime] NOT NULL,
	[m_id] [nvarchar](20) NULL,
	[order_id] [nvarchar](20) NULL,
 CONSTRAINT [PK_Coupon_Use_Record] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CouponList]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CouponList](
	[couponlist_id] [int] NOT NULL,
	[coupon_id] [nvarchar](20) NOT NULL,
	[m_id] [nvarchar](20) NOT NULL,
	[get_date] [datetime] NOT NULL,
 CONSTRAINT [PK_CouponList] PRIMARY KEY CLUSTERED 
(
	[couponlist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dest_Comment]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dest_Comment](
	[cmt_id] [int] NOT NULL,
	[dest_id] [nvarchar](20) NULL,
	[m_id] [nvarchar](20) NULL,
	[content] [nvarchar](800) NOT NULL,
	[comment_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Dest_Comment] PRIMARY KEY CLUSTERED 
(
	[cmt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destination]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination](
	[dest_id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[type] [int] NOT NULL,
	[county] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](16) NOT NULL,
	[address] [nvarchar](200) NOT NULL,
	[longitude] [decimal](18, 0) NOT NULL,
	[latitude] [decimal](18, 0) NOT NULL,
	[desc] [nvarchar](300) NULL,
	[image] [nvarchar](200) NULL,
	[on_shelf] [datetime] NULL,
	[off_shelf] [datetime] NULL,
	[url] [nvarchar](300) NULL,
 CONSTRAINT [PK_Destination] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[m_id] [nvarchar](20) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[phone] [nvarchar](16) NOT NULL,
	[password] [nvarchar](20) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[sex] [int] NOT NULL,
	[id_number] [nvarchar](20) NOT NULL,
	[birthday] [date] NOT NULL,
	[address] [nvarchar](200) NOT NULL,
	[credit] [nvarchar](30) NULL,
	[favorite] [nvarchar](900) NULL,
	[bonus_point] [int] NOT NULL,
	[register_date] [datetime] NOT NULL,
	[last_login_date] [datetime] NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[m_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[order_id] [nvarchar](20) NOT NULL,
	[m_id] [nvarchar](20) NULL,
	[totalprice] [decimal](18, 0) NOT NULL,
	[orderdate] [datetime] NOT NULL,
	[orderdate_end] [datetime] NULL,
	[state] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Detail]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Detail](
	[od_id] [int] NOT NULL,
	[order_id] [nvarchar](20) NULL,
	[type] [int] NOT NULL,
	[group_id] [int] NULL,
	[p_id] [nvarchar](20) NULL,
	[ticket_id] [nvarchar](20) NULL,
	[count] [int] NOT NULL,
	[totalprice] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Order_Detail] PRIMARY KEY CLUSTERED 
(
	[od_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[p_id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[ticket_id] [nvarchar](20) NULL,
	[group_id] [int] NULL,
	[price] [decimal](18, 0) NOT NULL,
	[discount_price] [decimal](18, 0) NULL,
	[desc] [nvarchar](300) NULL,
	[image] [nvarchar](200) NULL,
	[stock_number] [int] NOT NULL,
	[on_shelf] [datetime] NULL,
	[off_shelf] [datetime] NULL,
	[state] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Comment]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Comment](
	[cmt_id] [int] NOT NULL,
	[p_id] [nvarchar](20) NULL,
	[m_id] [nvarchar](20) NULL,
	[content] [nvarchar](800) NOT NULL,
	[rating] [int] NOT NULL,
	[comment_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Product_Comment] PRIMARY KEY CLUSTERED 
(
	[cmt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[s_id] [nvarchar](20) NOT NULL,
	[account] [nvarchar](40) NOT NULL,
	[password] [nvarchar](20) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[sex] [int] NOT NULL,
	[id_number] [nvarchar](20) NOT NULL,
	[phone] [nvarchar](16) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[birthday] [date] NOT NULL,
	[address] [nvarchar](200) NOT NULL,
	[image] [nvarchar](200) NULL,
	[department] [int] NOT NULL,
	[job_position] [int] NOT NULL,
	[line_manager] [nvarchar](20) NULL,
	[salary] [decimal](18, 0) NOT NULL,
	[date_of_employment] [date] NOT NULL,
	[termination_date] [date] NULL,
	[state] [int] NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[s_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[supplier_id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[phone] [nvarchar](16) NOT NULL,
	[email] [nvarchar](80) NOT NULL,
	[county] [nvarchar](20) NOT NULL,
	[address] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 2023/6/14 下午 08:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[ticket_id] [nvarchar](20) NOT NULL,
	[dest_id] [nvarchar](20) NULL,
	[name] [nvarchar](100) NOT NULL,
	[type] [int] NOT NULL,
	[capacity] [int] NOT NULL,
	[price] [decimal](18, 0) NOT NULL,
	[discount_price] [decimal](18, 0) NULL,
	[deadline] [datetime] NULL,
	[desc] [nvarchar](300) NULL,
	[stock_number] [int] NOT NULL,
	[on_shelf] [datetime] NULL,
	[off_shelf] [datetime] NULL,
	[supplier_id] [nvarchar](20) NULL,
	[state] [int] NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[ticket_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_c_id]  DEFAULT ([dbo].[getCartID]()) FOR [c_id]
GO
ALTER TABLE [dbo].[Cart_Detail] ADD  CONSTRAINT [DF_Cart_Detail_cd_id]  DEFAULT ([dbo].[getCartDetailID]()) FOR [cd_id]
GO
ALTER TABLE [dbo].[Coupon] ADD  CONSTRAINT [DF_Coupon_coupon_id]  DEFAULT ([dbo].[getCouponID]()) FOR [coupon_id]
GO
ALTER TABLE [dbo].[Destination] ADD  CONSTRAINT [DF_Destination_dest_id]  DEFAULT ([dbo].[getDestID]()) FOR [dest_id]
GO
ALTER TABLE [dbo].[Member] ADD  CONSTRAINT [DF_Member_m_id]  DEFAULT ([dbo].[getMemberID]()) FOR [m_id]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_order_id]  DEFAULT ([dbo].[getOrderID]()) FOR [order_id]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_p_id]  DEFAULT ([dbo].[getProductID]()) FOR [p_id]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_Staff_s_id]  DEFAULT ([dbo].[getStaffID]()) FOR [s_id]
GO
ALTER TABLE [dbo].[Supplier] ADD  CONSTRAINT [DF_Supplier_supplier_id]  DEFAULT ([dbo].[getSupplierID]()) FOR [supplier_id]
GO
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [DF_Ticket_ticket_id]  DEFAULT ([dbo].[getTicketID]()) FOR [ticket_id]
GO
ALTER TABLE [dbo].[Bonus_Point_Record]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Point_Record_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Bonus_Point_Record] CHECK CONSTRAINT [FK_Bonus_Point_Record_Member]
GO
ALTER TABLE [dbo].[Bonus_Point_Record]  WITH CHECK ADD  CONSTRAINT [FK_Bonus_Point_Record_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([order_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Bonus_Point_Record] CHECK CONSTRAINT [FK_Bonus_Point_Record_Order]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Member]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([p_id])
REFERENCES [dbo].[Product] ([p_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Detail_Cart] FOREIGN KEY([c_id])
REFERENCES [dbo].[Cart] ([c_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart_Detail] CHECK CONSTRAINT [FK_Cart_Detail_Cart]
GO
ALTER TABLE [dbo].[Cart_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Detail_ComboGroup] FOREIGN KEY([group_id])
REFERENCES [dbo].[ComboGroup] ([group_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart_Detail] CHECK CONSTRAINT [FK_Cart_Detail_ComboGroup]
GO
ALTER TABLE [dbo].[Cart_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Detail_Ticket] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Cart_Detail] CHECK CONSTRAINT [FK_Cart_Detail_Ticket]
GO
ALTER TABLE [dbo].[ComboGroup_Detail]  WITH CHECK ADD  CONSTRAINT [FK_ComboGroup_detail_ComboGroup_detail] FOREIGN KEY([group_id])
REFERENCES [dbo].[ComboGroup] ([group_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ComboGroup_Detail] CHECK CONSTRAINT [FK_ComboGroup_detail_ComboGroup_detail]
GO
ALTER TABLE [dbo].[ComboGroup_Detail]  WITH CHECK ADD  CONSTRAINT [FK_ComboGroup_Detail_Ticket] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ComboGroup_Detail] CHECK CONSTRAINT [FK_ComboGroup_Detail_Ticket]
GO
ALTER TABLE [dbo].[Coupon]  WITH NOCHECK ADD  CONSTRAINT [FK_Ticket_Coupon] FOREIGN KEY([p_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
GO
ALTER TABLE [dbo].[Coupon] NOCHECK CONSTRAINT [FK_Ticket_Coupon]
GO
ALTER TABLE [dbo].[Coupon_Use_Record]  WITH CHECK ADD  CONSTRAINT [FK_Coupon_Use_Record_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Coupon_Use_Record] CHECK CONSTRAINT [FK_Coupon_Use_Record_Member]
GO
ALTER TABLE [dbo].[Coupon_Use_Record]  WITH CHECK ADD  CONSTRAINT [FK_Coupon_Use_Record_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([order_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Coupon_Use_Record] CHECK CONSTRAINT [FK_Coupon_Use_Record_Order]
GO
ALTER TABLE [dbo].[CouponList]  WITH CHECK ADD  CONSTRAINT [FK_CouponList_Coupon] FOREIGN KEY([coupon_id])
REFERENCES [dbo].[Coupon] ([coupon_id])
GO
ALTER TABLE [dbo].[CouponList] CHECK CONSTRAINT [FK_CouponList_Coupon]
GO
ALTER TABLE [dbo].[CouponList]  WITH CHECK ADD  CONSTRAINT [FK_CouponList_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
GO
ALTER TABLE [dbo].[CouponList] CHECK CONSTRAINT [FK_CouponList_Member]
GO
ALTER TABLE [dbo].[Dest_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Dest_Comment_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Dest_Comment] CHECK CONSTRAINT [FK_Dest_Comment_Destination]
GO
ALTER TABLE [dbo].[Dest_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Dest_Comment_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Dest_Comment] CHECK CONSTRAINT [FK_Dest_Comment_Member]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Member]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_ComboGroup] FOREIGN KEY([group_id])
REFERENCES [dbo].[ComboGroup] ([group_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_ComboGroup]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([order_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_Order]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_Product] FOREIGN KEY([p_id])
REFERENCES [dbo].[Product] ([p_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_Product]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_Ticket] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_Ticket]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ComboGroup] FOREIGN KEY([group_id])
REFERENCES [dbo].[ComboGroup] ([group_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ComboGroup]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Ticket] FOREIGN KEY([ticket_id])
REFERENCES [dbo].[Ticket] ([ticket_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Ticket]
GO
ALTER TABLE [dbo].[Product_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Product_Comment_Member] FOREIGN KEY([m_id])
REFERENCES [dbo].[Member] ([m_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product_Comment] CHECK CONSTRAINT [FK_Product_Comment_Member]
GO
ALTER TABLE [dbo].[Product_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Product_Comment_Product] FOREIGN KEY([p_id])
REFERENCES [dbo].[Product] ([p_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product_Comment] CHECK CONSTRAINT [FK_Product_Comment_Product]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Destination]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Supplier] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Supplier] ([supplier_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Supplier]
GO
