USE [master]
GO
/****** Object:  Database [Tixplorer]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE DATABASE [Tixplorer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tixplorer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Tixplorer.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tixplorer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Tixplorer_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Tixplorer] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tixplorer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tixplorer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tixplorer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tixplorer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tixplorer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tixplorer] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tixplorer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tixplorer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tixplorer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tixplorer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tixplorer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tixplorer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tixplorer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tixplorer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tixplorer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tixplorer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Tixplorer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tixplorer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tixplorer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tixplorer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tixplorer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tixplorer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tixplorer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tixplorer] SET RECOVERY FULL 
GO
ALTER DATABASE [Tixplorer] SET  MULTI_USER 
GO
ALTER DATABASE [Tixplorer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tixplorer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tixplorer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tixplorer] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tixplorer] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Tixplorer] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Tixplorer', N'ON'
GO
ALTER DATABASE [Tixplorer] SET QUERY_STORE = OFF
GO
USE [Tixplorer]
GO
/****** Object:  User [VisualStudio]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [VisualStudio] FOR LOGIN [VisualStudio] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [regulus3754]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [regulus3754] FOR LOGIN [regulus3754] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [kgll000000]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [kgll000000] FOR LOGIN [kgll000000] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [jimmychinhtc]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [jimmychinhtc] FOR LOGIN [jimmychinhtc] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [danny0965185633]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [danny0965185633] FOR LOGIN [danny0965185633] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [coweiwei83223]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [coweiwei83223] FOR LOGIN [coweiwei83223] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [a6563612]    Script Date: 2023/7/21 下午 01:47:23 ******/
CREATE USER [a6563612] FOR LOGIN [a6563612] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [VisualStudio]
GO
ALTER ROLE [db_owner] ADD MEMBER [kgll000000]
GO
ALTER ROLE [db_owner] ADD MEMBER [jimmychinhtc]
GO
ALTER ROLE [db_owner] ADD MEMBER [coweiwei83223]
GO
ALTER ROLE [db_owner] ADD MEMBER [a6563612]
GO
/****** Object:  UserDefinedFunction [dbo].[getCartDetailID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getCartID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getCouponID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getDestID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getMemberID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getOrderID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getProductID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getStaffID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getSupplierID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  UserDefinedFunction [dbo].[getTicketID]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Bonus_Point_Record]    Script Date: 2023/7/21 下午 01:47:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonus_Point_Record](
	[serial_id] [int] IDENTITY(1,1) NOT NULL,
	[operate_type] [int] NOT NULL,
	[bonus_point] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[m_id] [nvarchar](20) NULL,
	[order_id] [nvarchar](20) NULL,
 CONSTRAINT [PK_Bonus_Point_Record] PRIMARY KEY CLUSTERED 
(
	[serial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Cart_Detail]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[ComboGroup]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[ComboGroup_Detail]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Coupon]    Script Date: 2023/7/21 下午 01:47:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupon](
	[coupon_id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
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
/****** Object:  Table [dbo].[Coupon_Use_Record]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[CouponList]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Dest_Comment]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Destination]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
	[longitude] [decimal](18, 10) NOT NULL,
	[latitude] [decimal](18, 10) NOT NULL,
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
/****** Object:  Table [dbo].[Member]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Order_Detail]    Script Date: 2023/7/21 下午 01:47:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Detail](
	[od_id] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Product]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Product_Comment]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Supplier]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
/****** Object:  Table [dbo].[Ticket]    Script Date: 2023/7/21 下午 01:47:23 ******/
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
SET IDENTITY_INSERT [dbo].[Bonus_Point_Record] ON 

INSERT [dbo].[Bonus_Point_Record] ([serial_id], [operate_type], [bonus_point], [date], [m_id], [order_id]) VALUES (1, 0, 20, CAST(N'2023-05-05T00:00:00.000' AS DateTime), N'M23060001', N'O23051111')
INSERT [dbo].[Bonus_Point_Record] ([serial_id], [operate_type], [bonus_point], [date], [m_id], [order_id]) VALUES (3, 1, 10, CAST(N'2023-05-05T00:00:00.000' AS DateTime), N'M23060001', N'O23051111')
INSERT [dbo].[Bonus_Point_Record] ([serial_id], [operate_type], [bonus_point], [date], [m_id], [order_id]) VALUES (4, 0, 5, CAST(N'2023-05-31T00:00:00.000' AS DateTime), N'M23060002', N'O23052222')
SET IDENTITY_INSERT [dbo].[Bonus_Point_Record] OFF
GO
INSERT [dbo].[ComboGroup] ([group_id], [name], [build_date]) VALUES (1, N'水世界套組', CAST(N'2023-06-16T00:00:00.000' AS DateTime))
INSERT [dbo].[ComboGroup] ([group_id], [name], [build_date]) VALUES (2, N'種族文化套票', CAST(N'2023-06-13T00:00:00.000' AS DateTime))
INSERT [dbo].[ComboGroup] ([group_id], [name], [build_date]) VALUES (3, N'小籠包套票', CAST(N'2023-06-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Coupon] ([coupon_id], [name], [p_id], [discount_type], [discount], [usable_day], [expiration_date]) VALUES (N'CP23060001', N'全站100元優惠券', N'全站商品', 0, 100, 0, CAST(N'2023-08-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Coupon] ([coupon_id], [name], [p_id], [discount_type], [discount], [usable_day], [expiration_date]) VALUES (N'CP23060002', N'全站75折優惠券', N'全站商品', 1, 75, 100, NULL)
GO
SET IDENTITY_INSERT [dbo].[Coupon_Use_Record] ON 

INSERT [dbo].[Coupon_Use_Record] ([serial_id], [use_date], [m_id], [order_id]) VALUES (1, CAST(N'2023-05-05T00:00:00.000' AS DateTime), N'M23060001', N'O23051111')
INSERT [dbo].[Coupon_Use_Record] ([serial_id], [use_date], [m_id], [order_id]) VALUES (2, CAST(N'2023-05-31T00:00:00.000' AS DateTime), N'M23060002', N'O23052222')
SET IDENTITY_INSERT [dbo].[Coupon_Use_Record] OFF
GO
INSERT [dbo].[Destination] ([dest_id], [name], [type], [county], [phone], [address], [longitude], [latitude], [desc], [image], [on_shelf], [off_shelf], [url]) VALUES (N'D23060001', N'高雄油桐花協會場地', 1, N'高雄市', N'07-749-4545', N'高雄市苓雅區', CAST(3.0000000000 AS Decimal(18, 10)), CAST(23.0000000000 AS Decimal(18, 10)), NULL, N'e30d2265-02ca-4adc-9191-9397073a5812.jpg', CAST(N'2023-06-15T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Destination] ([dest_id], [name], [type], [county], [phone], [address], [longitude], [latitude], [desc], [image], [on_shelf], [off_shelf], [url]) VALUES (N'D23060002', N'陽明山國家公園', 1, N'台北市', N'02-4568-6543', N'台北市陽明山', CAST(24.0000000000 AS Decimal(18, 10)), CAST(23.0000000000 AS Decimal(18, 10)), NULL, N'b03f0209-295f-41cf-9293-5fabaf0defba.jpg', CAST(N'2023-06-18T00:00:00.000' AS DateTime), NULL, N'https://www.ymsnp.gov.tw/main_ch/index.aspx')
GO
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M20010001', N'mkd@gmail.com', N'0987654321', N'123456', N'Tom', 1, CAST(N'1997-01-01' AS Date), N'高雄市苓雅區', N'9151-1591-1591', NULL, 100, CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(N'2023-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M20020002', N'qwe@gmail.com', N'09123456789', N'654321', N'John', 0, CAST(N'1996-12-11' AS Date), N'台北市信義區', N'91541-49894', NULL, 150, CAST(N'2022-01-01T00:00:00.000' AS DateTime), CAST(N'2023-05-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M20020003', N'asd@gmail.com', N'0965423214', N'123567', N'tomm', 1, CAST(N'1996-01-01' AS Date), N'桃園市天堂區', N'9847-1594', NULL, 200, CAST(N'2021-01-01T00:00:00.000' AS DateTime), CAST(N'2023-04-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M23060001', N'HsuMan@gmailc.om', N'0955-666-777', N'1234', N'許先生', 0, CAST(N'1986-07-16' AS Date), N'台北市信義區', NULL, NULL, 0, CAST(N'2023-06-18T14:19:29.730' AS DateTime), NULL)
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M23060002', N'ShiaBueaty@gmail.com', N'0955-888-777', N'1234', N'薛美麗', 1, CAST(N'1996-02-18' AS Date), N'新竹市南區', NULL, NULL, 0, CAST(N'2023-06-18T14:22:17.660' AS DateTime), NULL)
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M23070001', N'coweiwei83223@gmail.com', N'0935666555', N'a123456789', N'陳添', 0, CAST(N'1985-01-01' AS Date), N'台北市信義區', NULL, NULL, 0, CAST(N'2023-07-21T13:43:09.407' AS DateTime), NULL)
INSERT [dbo].[Member] ([m_id], [email], [phone], [password], [name], [sex], [birthday], [address], [credit], [favorite], [bonus_point], [register_date], [last_login_date]) VALUES (N'M23070002', N'coweiwei83223@gmail.com', N'0935666777', N'a123456789', N'陳添', 0, CAST(N'1989-01-01' AS Date), N'台北市信義區', NULL, NULL, 0, CAST(N'2023-07-21T13:43:52.373' AS DateTime), NULL)
GO
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23051111', N'M23060001', CAST(1000 AS Decimal(18, 0)), CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(N'2023-05-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23052222', N'M23060002', CAST(2000 AS Decimal(18, 0)), CAST(N'2023-05-31T00:00:00.000' AS DateTime), CAST(N'2023-05-31T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060003', N'M20010001', CAST(100 AS Decimal(18, 0)), CAST(N'2023-05-30T12:37:00.000' AS DateTime), CAST(N'2023-05-31T12:37:00.000' AS DateTime), 0)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060004', N'M20010001', CAST(100 AS Decimal(18, 0)), CAST(N'2023-06-01T12:40:00.000' AS DateTime), CAST(N'2023-06-03T12:40:00.000' AS DateTime), 2)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060005', N'M20010001', CAST(1000 AS Decimal(18, 0)), CAST(N'2023-06-03T13:20:00.000' AS DateTime), CAST(N'2023-05-17T13:20:00.000' AS DateTime), 0)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060006', N'M20010001', CAST(10002 AS Decimal(18, 0)), CAST(N'2023-05-31T13:29:00.000' AS DateTime), CAST(N'2023-06-12T13:29:00.000' AS DateTime), 1)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060007', N'M20010001', CAST(1000 AS Decimal(18, 0)), CAST(N'2023-06-02T13:35:00.000' AS DateTime), CAST(N'2023-06-07T13:35:00.000' AS DateTime), 0)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060008', N'M20010001', CAST(10002 AS Decimal(18, 0)), CAST(N'2023-06-03T13:36:00.000' AS DateTime), CAST(N'2023-06-12T13:36:00.000' AS DateTime), 1)
INSERT [dbo].[Order] ([order_id], [m_id], [totalprice], [orderdate], [orderdate_end], [state]) VALUES (N'O23060009', N'M20010001', CAST(100 AS Decimal(18, 0)), CAST(N'2023-06-02T14:19:00.000' AS DateTime), CAST(N'2023-06-01T14:19:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[Order_Detail] ON 

INSERT [dbo].[Order_Detail] ([od_id], [order_id], [type], [group_id], [p_id], [ticket_id], [count], [totalprice]) VALUES (1, N'O23060005', 1, NULL, NULL, N'T23060001', 10, CAST(2000 AS Decimal(18, 0)))
INSERT [dbo].[Order_Detail] ([od_id], [order_id], [type], [group_id], [p_id], [ticket_id], [count], [totalprice]) VALUES (2, N'O23060004', 0, NULL, NULL, N'T23060001', 20, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[Order_Detail] ([od_id], [order_id], [type], [group_id], [p_id], [ticket_id], [count], [totalprice]) VALUES (3, N'O23060006', 1, NULL, NULL, N'T23060001', 15, CAST(1500 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Order_Detail] OFF
GO
INSERT [dbo].[Product] ([p_id], [name], [ticket_id], [group_id], [price], [discount_price], [desc], [image], [stock_number], [on_shelf], [off_shelf], [state]) VALUES (N'23060001', N'六仙水上樂園', N'T23060008', 1, CAST(10000 AS Decimal(18, 0)), CAST(8000 AS Decimal(18, 0)), N'很多水的地方', N'1', 100, CAST(N'2023-05-15T00:00:00.000' AS DateTime), CAST(N'2023-07-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([p_id], [name], [ticket_id], [group_id], [price], [discount_price], [desc], [image], [stock_number], [on_shelf], [off_shelf], [state]) VALUES (N'23060002', N'十族文化村', N'T23060009', 2, CAST(20000 AS Decimal(18, 0)), CAST(10000 AS Decimal(18, 0)), N'很多種族可以參觀', N'2', 200, CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(N'2023-07-31T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([p_id], [name], [ticket_id], [group_id], [price], [discount_price], [desc], [image], [stock_number], [on_shelf], [off_shelf], [state]) VALUES (N'23060003', N'鼎泰王', N'T23060010', 3, CAST(30000 AS Decimal(18, 0)), CAST(6000 AS Decimal(18, 0)), N'小籠包', N'3', 400, CAST(N'2023-05-20T00:00:00.000' AS DateTime), CAST(N'2023-07-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([p_id], [name], [ticket_id], [group_id], [price], [discount_price], [desc], [image], [stock_number], [on_shelf], [off_shelf], [state]) VALUES (N'23060004', N'鼎泰王', N'T23060010', 3, CAST(30000 AS Decimal(18, 0)), CAST(6000 AS Decimal(18, 0)), N'小籠包', N'3', 400, CAST(N'2023-05-20T00:00:00.000' AS DateTime), CAST(N'2023-07-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Product] ([p_id], [name], [ticket_id], [group_id], [price], [discount_price], [desc], [image], [stock_number], [on_shelf], [off_shelf], [state]) VALUES (N'23060005', N'鼎泰王', N'T23060010', 3, CAST(30000 AS Decimal(18, 0)), CAST(6000 AS Decimal(18, 0)), N'小籠包', N'3', 400, CAST(N'2023-05-20T00:00:00.000' AS DateTime), CAST(N'2023-07-10T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Staff] ([s_id], [account], [password], [name], [sex], [id_number], [phone], [email], [birthday], [address], [image], [department], [job_position], [line_manager], [salary], [date_of_employment], [termination_date], [state]) VALUES (N'S23060001', N'staff01', N'1234', N'許社畜', 0, N'A123456785', N'0988-888-885', N'staff01@gmail.com', CAST(N'1994-01-01' AS Date), N'高雄市苓雅區', N'07613624-c29e-4898-8d0c-75c25bc1c00c.jpg', 102, 0, NULL, CAST(39000 AS Decimal(18, 0)), CAST(N'2023-06-15' AS Date), NULL, 0)
INSERT [dbo].[Staff] ([s_id], [account], [password], [name], [sex], [id_number], [phone], [email], [birthday], [address], [image], [department], [job_position], [line_manager], [salary], [date_of_employment], [termination_date], [state]) VALUES (N'S23060002', N'staff02', N'1234', N'趙小姐', 0, N'A987654321', N'0977-556-665', N'staff02@gmail.com', CAST(N'1992-06-03' AS Date), N'高雄市左營區', NULL, 101, 0, NULL, CAST(34000 AS Decimal(18, 0)), CAST(N'2023-06-16' AS Date), NULL, 0)
INSERT [dbo].[Staff] ([s_id], [account], [password], [name], [sex], [id_number], [phone], [email], [birthday], [address], [image], [department], [job_position], [line_manager], [salary], [date_of_employment], [termination_date], [state]) VALUES (N'S23060003', N'staff03', N'1234', N'曾小姐', 0, N'A123789456', N'  0955-556-998', N'staff03@gmail.com', CAST(N'1994-01-04' AS Date), N'高雄市小港區', NULL, 101, 0, NULL, CAST(33000 AS Decimal(18, 0)), CAST(N'2023-06-19' AS Date), NULL, 3)
INSERT [dbo].[Staff] ([s_id], [account], [password], [name], [sex], [id_number], [phone], [email], [birthday], [address], [image], [department], [job_position], [line_manager], [salary], [date_of_employment], [termination_date], [state]) VALUES (N'S23060004', N'staff04', N'1234', N'鄭小弟', 0, N'A147258369', N'0933222111', N'Chien@gmail.com', CAST(N'0001-01-01' AS Date), N'高雄市小港區', N'NoImage.png', 102, 0, NULL, CAST(38000 AS Decimal(18, 0)), CAST(N'2023-06-18' AS Date), NULL, 0)
GO
INSERT [dbo].[Supplier] ([supplier_id], [name], [phone], [email], [county], [address]) VALUES (N'SP23060001', N'高雄油桐花協會', N'07-749-4545', N'flowerKSH@gmail.com', N'高雄市', N'高雄市苓雅區')
INSERT [dbo].[Supplier] ([supplier_id], [name], [phone], [email], [county], [address]) VALUES (N'SP23060002', N'美麗島協會', N'0987654321', N'kqe@gmail.com', N'台北市', N'新光區連市路')
INSERT [dbo].[Supplier] ([supplier_id], [name], [phone], [email], [county], [address]) VALUES (N'SP23060003', N'六仙', N'0966666666', N'a666666@gmail.com', N'高雄市', N'苓雅區')
INSERT [dbo].[Supplier] ([supplier_id], [name], [phone], [email], [county], [address]) VALUES (N'SP23060004', N'十族', N'0910101010', N'a10101010', N'花蓮市', N'阿美部落')
INSERT [dbo].[Supplier] ([supplier_id], [name], [phone], [email], [county], [address]) VALUES (N'SP23060005', N'鼎泰王', N'09123456789', N'a21212121', N'屏東市', N'荒地區')
GO
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060001', N'D23060001', N'高雄油桐賞花單人票', 1, 1, CAST(200 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2023-12-31T23:59:59.000' AS DateTime), N'高雄油桐花賞花入場門票', 100, CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(N'2023-12-31T23:59:59.000' AS DateTime), N'SP23060001', 0)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060002', NULL, N'衛武營國家文化藝術中新單人票券', 1, 1, CAST(200 AS Decimal(18, 0)), CAST(160 AS Decimal(18, 0)), NULL, N'衛武營文化藝術中心單人入場票券', 100, CAST(N'2023-06-18T00:00:00.000' AS DateTime), NULL, N'SP23060001', 0)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060003', N'D23060001', N'高雄油桐賞花單人票', 3, 1, CAST(200 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2023-12-31T23:59:59.000' AS DateTime), N'高雄油桐花賞花入場門票', 100, CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(N'2023-12-31T23:59:59.000' AS DateTime), N'SP23060001', 2)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060004', N'D23060001', N'測試', 3, 2, CAST(123 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), CAST(N'2023-06-29T01:28:00.000' AS DateTime), N'test', 12, CAST(N'2023-06-28T01:28:00.000' AS DateTime), CAST(N'2025-10-18T01:28:00.000' AS DateTime), N'SP23060001', 1)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060005', N'D23060001', N'測試2', 2, 87, CAST(888 AS Decimal(18, 0)), CAST(12 AS Decimal(18, 0)), CAST(N'2023-07-07T14:59:00.000' AS DateTime), N'123', 123, CAST(N'2023-06-29T14:59:00.000' AS DateTime), CAST(N'2023-07-13T14:59:00.000' AS DateTime), N'SP23060001', 1)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060006', N'D23060001', N'測試', 2, 123, CAST(12 AS Decimal(18, 0)), CAST(21 AS Decimal(18, 0)), CAST(N'2023-06-15T15:07:00.000' AS DateTime), N'123', 123, CAST(N'2023-06-06T15:07:00.000' AS DateTime), CAST(N'2023-06-22T15:07:00.000' AS DateTime), N'SP23060001', 2)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060007', NULL, N'8 8 8 8 ', 2, 123, CAST(123 AS Decimal(18, 0)), CAST(123 AS Decimal(18, 0)), CAST(N'2023-06-27T15:07:00.000' AS DateTime), N'y04
', 5656, CAST(N'2023-06-15T15:07:00.000' AS DateTime), CAST(N'2023-06-24T15:07:00.000' AS DateTime), NULL, 2)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060008', NULL, N'六仙水上樂園', 0, 3, CAST(1000 AS Decimal(18, 0)), CAST(800 AS Decimal(18, 0)), CAST(N'2023-10-10T00:00:00.000' AS DateTime), N'很多水的地方', 100, CAST(N'2023-06-06T00:00:00.000' AS DateTime), CAST(N'2023-12-31T00:00:00.000' AS DateTime), N'SP23060003', 1)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060009', NULL, N'十族文化村', 0, 4, CAST(900 AS Decimal(18, 0)), CAST(600 AS Decimal(18, 0)), CAST(N'2023-11-13T00:00:00.000' AS DateTime), N'有十個種族', 300, CAST(N'2023-06-20T00:00:00.000' AS DateTime), CAST(N'2023-12-31T00:00:00.000' AS DateTime), N'SP23060004', 1)
INSERT [dbo].[Ticket] ([ticket_id], [dest_id], [name], [type], [capacity], [price], [discount_price], [deadline], [desc], [stock_number], [on_shelf], [off_shelf], [supplier_id], [state]) VALUES (N'T23060010', NULL, N'鼎泰王', 3, 3, CAST(200 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(N'2023-10-12T00:00:00.000' AS DateTime), N'小籠包', 200, CAST(N'2023-06-10T00:00:00.000' AS DateTime), CAST(N'2023-12-31T00:00:00.000' AS DateTime), N'SP23060005', 0)
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
USE [master]
GO
ALTER DATABASE [Tixplorer] SET  READ_WRITE 
GO
