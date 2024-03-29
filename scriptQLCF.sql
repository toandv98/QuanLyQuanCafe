USE [master]
GO
/****** Object:  Database [QLCF]    Script Date: 10/26/2018 10:34:09 AM ******/
CREATE DATABASE [QLCF] ON  PRIMARY 
( NAME = N'QLCF', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QLCF.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLCF_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QLCF_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLCF].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLCF] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLCF] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLCF] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLCF] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLCF] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLCF] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLCF] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLCF] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLCF] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLCF] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLCF] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLCF] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLCF] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLCF] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLCF] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLCF] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLCF] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLCF] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLCF] SET RECOVERY FULL 
GO
ALTER DATABASE [QLCF] SET  MULTI_USER 
GO
ALTER DATABASE [QLCF] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLCF] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLCF', N'ON'
GO
USE [QLCF]
GO
/****** Object:  UserDefinedFunction [dbo].[f_ChuyenDoi]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_ChuyenDoi] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Ban]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ban](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenBan] [nvarchar](100) NOT NULL,
	[TrangThai] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietHD]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDHoaDon] [int] NOT NULL,
	[IDMon] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMuc]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMuc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NgayVao] [date] NOT NULL,
	[NgayRa] [date] NULL,
	[IDBan] [int] NOT NULL,
	[IDNhanVien] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
	[GiamGia] [int] NOT NULL,
	[TongTien] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mon]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenMon] [nvarchar](100) NOT NULL,
	[IDDanhMuc] [int] NOT NULL,
	[Gia] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](100) NOT NULL,
	[HoTen] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[NgaySinh] [date] NULL,
	[QueQuan] [nvarchar](100) NULL,
	[SoDienThoai] [nvarchar](20) NULL,
	[TrangThai] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [nvarchar](100) NOT NULL,
	[TenHienThi] [nvarchar](100) NOT NULL,
	[MatKhau] [nvarchar](1000) NOT NULL,
	[LoaiTaiKhoan] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Ban] ON 

INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (2, N'Bàn 1', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (4, N'Bàn 3', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (7, N'Bàn 6', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (8, N'Bàn 7', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (10, N'Bàn 9', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (12, N'Bàn 10', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (13, N'Bàn 11', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (14, N'Bàn 12', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (15, N'Bàn 13', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (16, N'Bàn 14', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (17, N'Bàn 15', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (18, N'Bàn 16', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (19, N'Bàn 17', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (20, N'Bàn 18', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (21, N'Bàn 19', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (22, N'Bàn 20', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (23, N'Bàn 21', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (24, N'Bàn 22', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (25, N'Bàn 23', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (26, N'Bàn 24', N'Trống')
INSERT [dbo].[Ban] ([ID], [TenBan], [TrangThai]) VALUES (27, N'Bàn 25', N'Trống')
SET IDENTITY_INSERT [dbo].[Ban] OFF
SET IDENTITY_INSERT [dbo].[ChiTietHD] ON 

INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (48, 35, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (49, 35, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (50, 35, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (51, 36, 20, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (52, 36, 10, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (53, 36, 12, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (54, 37, 3, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (55, 37, 41, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (56, 37, 44, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (57, 38, 42, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (58, 38, 23, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (59, 38, 29, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (60, 39, 46, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (61, 39, 48, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (62, 39, 21, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (63, 40, 50, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (64, 41, 52, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (65, 42, 6, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (66, 42, 9, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (67, 43, 33, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (68, 43, 19, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (69, 44, 22, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (70, 44, 23, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (71, 45, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (72, 45, 3, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (73, 46, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (74, 46, 5, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (75, 47, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (76, 48, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (77, 48, 3, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (78, 49, 3, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (79, 49, 29, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (80, 49, 33, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (81, 49, 34, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (82, 50, 34, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (83, 51, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (84, 51, 20, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (85, 52, 20, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (86, 52, 50, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (87, 52, 54, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (88, 52, 52, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (89, 52, 19, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (90, 52, 35, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (91, 52, 36, 1)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (92, 53, 26, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (93, 53, 24, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (94, 53, 28, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (95, 53, 56, 1)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (96, 54, 32, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (97, 54, 51, 7)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (98, 55, 37, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (99, 55, 38, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (100, 55, 22, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (101, 56, 22, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (102, 56, 49, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (103, 56, 48, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (104, 57, 29, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (105, 57, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (106, 57, 5, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (107, 58, 5, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (108, 59, 5, 4)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (109, 59, 49, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (110, 60, 49, 1)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (111, 60, 23, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (112, 60, 50, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (113, 60, 35, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (114, 61, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (115, 61, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (116, 62, 23, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (117, 62, 31, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (118, 63, 3, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (119, 63, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (120, 64, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (121, 65, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (123, 67, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (127, 71, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (128, 72, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (137, 76, 2, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (138, 77, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (139, 78, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (140, 79, 18, 3)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (141, 80, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (142, 78, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (143, 81, 4, 2)
INSERT [dbo].[ChiTietHD] ([ID], [IDHoaDon], [IDMon], [SoLuong]) VALUES (144, 82, 4, 2)
SET IDENTITY_INSERT [dbo].[ChiTietHD] OFF
SET IDENTITY_INSERT [dbo].[DanhMuc] ON 

INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (2, N'Cafe')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (3, N'Giải khát')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (4, N'Kem, sữa')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (5, N'Sinh tố')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (6, N'Hoa quả')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (7, N'Đồ ăn nhẹ')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (8, N'Soda')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (9, N'Siro đá bào')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (10, N'Trà')
INSERT [dbo].[DanhMuc] ([ID], [TenDanhMuc]) VALUES (11, N'Nước ép')
SET IDENTITY_INSERT [dbo].[DanhMuc] OFF
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (35, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 2, 2, 1, 0, 120000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (36, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 8, 2, 1, 15, 59500)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (37, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 4, 2, 1, 0, 188000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (38, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 10, 2, 1, 5, 161500)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (39, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 15, 2, 1, 0, 163000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (40, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 13, 2, 1, 29, 21300)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (41, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 16, 2, 1, 5, 25650)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (42, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 19, 2, 1, 15, 56100)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (43, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 27, 2, 1, 15, 88400)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (44, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 24, 2, 1, 7, 91140)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (45, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 3, 2, 1, 7, 209250)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (46, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 6, 2, 1, 7, 148800)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (47, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 16, 2, 1, 7, 139500)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (48, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 2, 13, 1, 0, 175000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (49, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 10, 13, 1, 0, 191000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (50, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 17, 13, 1, 0, 104000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (51, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 8, 13, 1, 0, 75000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (52, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 21, 13, 1, 0, 251000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (53, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 2, 14, 1, 0, 199000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (54, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 10, 14, 1, 0, 104000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (55, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 23, 14, 1, 0, 173000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (56, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 14, 14, 1, 0, 134000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (57, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 3, 15, 1, 0, 250000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (58, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 16, 15, 1, 0, 140000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (59, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 19, 15, 1, 0, 146000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (60, CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 14, 15, 1, 0, 157000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (61, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 9, 2, 1, 0, 305000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (62, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 5, 2, 1, 0, 90000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (63, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 2, 2, 1, 0, 80000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (64, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 2, 2, 1, 0, 90000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (65, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 5, 2, 1, 0, 30000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (67, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 16, 2, 1, 0, 30000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (71, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 4, 2, 1, 0, 30000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (72, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 12, 2, 1, 0, 30000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (76, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 8, 16, 1, 0, 50000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (77, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 15, 16, 1, 0, 15000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (78, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 21, 16, 1, 0, 75000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (79, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 13, 16, 1, 0, 15000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (80, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 27, 16, 1, 0, 60000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (81, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 19, 16, 1, 0, 60000)
INSERT [dbo].[HoaDon] ([ID], [NgayVao], [NgayRa], [IDBan], [IDNhanVien], [TrangThai], [GiamGia], [TongTien]) VALUES (82, CAST(N'2018-10-25' AS Date), CAST(N'2018-10-25' AS Date), 24, 16, 1, 0, 60000)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
SET IDENTITY_INSERT [dbo].[Mon] ON 

INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (2, N'Cafe đen', 2, 25000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (3, N'Cafe nâu', 2, 25000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (4, N'Cafe cacao', 2, 30000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (5, N'Cafe sữa', 2, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (6, N'Trà lipton', 10, 15000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (7, N'Trà sữa dâu', 10, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (8, N'Trà đá', 10, 5000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (9, N'Trà bí đao', 10, 7000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (10, N'Coca cola', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (11, N'Sting', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (12, N'Number 1', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (13, N'Redbull', 3, 15000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (14, N'Pepsi', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (15, N'Nước lọc', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (16, N'Revive', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (17, N'Mountain dew', 3, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (18, N'Snacks', 7, 5000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (19, N'Gà rán', 7, 30000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (20, N'Hướng dương', 7, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (21, N'Đậu phộng', 7, 3000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (22, N'Cream O', 7, 12000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (23, N'Kem ly', 4, 25000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (24, N'Kem hoa quả', 4, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (25, N'Sữa ngô', 4, 15000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (26, N'Sữa chua dâu', 4, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (27, N'Sữa chua bạc hà', 4, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (28, N'Sữa chua nha đam', 4, 23000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (29, N'Sinh tố dừa', 5, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (30, N'Sinh tố bơ', 5, 23000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (31, N'Sinh tố dâu', 5, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (32, N'Sinh tố cà chua', 5, 17000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (33, N'Sinh tố Kiwi mật ong', 5, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (34, N'Sinh tố mãng cầu', 5, 26000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (35, N'Nước ép cam', 11, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (36, N'Nước ép ổi', 11, 29000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (37, N'Nước ép chanh leo', 11, 25000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (38, N'Nước ép Táo', 11, 29000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (39, N'Nước ép cà rốt', 11, 27000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (40, N'Nước mía', 3, 12000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (41, N'Dứa', 6, 30000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (42, N'Xoài', 6, 20000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (43, N'Thanh long', 6, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (44, N'Ổi', 6, 23000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (45, N'Táo', 6, 27000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (46, N'Soda chanh dây', 8, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (47, N'Soda dâu', 8, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (48, N'Soda đào', 8, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (49, N'Soda vải', 8, 22000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (50, N'Siro nho', 9, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (51, N'Siro đào', 9, 10000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (52, N'Siro cam', 9, 9000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (53, N'Siro dâu', 9, 11000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (54, N'Siro kiwi', 9, 12000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (55, N'Nước dừa', 3, 25000)
INSERT [dbo].[Mon] ([ID], [TenMon], [IDDanhMuc], [Gia]) VALUES (56, N'Kem ốc', 4, 25000)
SET IDENTITY_INSERT [dbo].[Mon] OFF
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([ID], [TenDangNhap], [HoTen], [DiaChi], [GioiTinh], [NgaySinh], [QueQuan], [SoDienThoai], [TrangThai]) VALUES (2, N'toan', N'Đặng Văn Toản', N'Yên Bái', N'Nam', CAST(N'1998-01-08' AS Date), N'Yên Bái', N'0123456789', 0)
INSERT [dbo].[NhanVien] ([ID], [TenDangNhap], [HoTen], [DiaChi], [GioiTinh], [NgaySinh], [QueQuan], [SoDienThoai], [TrangThai]) VALUES (13, N'hao', N'Hoàng Văn Hào', N'Nghệ An', N'Nam', CAST(N'1997-11-11' AS Date), N'Nghệ An', N'0123456987', 0)
INSERT [dbo].[NhanVien] ([ID], [TenDangNhap], [HoTen], [DiaChi], [GioiTinh], [NgaySinh], [QueQuan], [SoDienThoai], [TrangThai]) VALUES (14, N'linh', N'Nguyễn Văn Linh', N'Hoà Bình', N'Nam', CAST(N'1998-02-09' AS Date), N'Hoà Bình', N'0123456123', 0)
INSERT [dbo].[NhanVien] ([ID], [TenDangNhap], [HoTen], [DiaChi], [GioiTinh], [NgaySinh], [QueQuan], [SoDienThoai], [TrangThai]) VALUES (15, N'toandn', N'Đinh Ngọc Toàn', N'Nam Định', N'Nam', CAST(N'1998-07-04' AS Date), N'Nam Định', N'0123456556', 0)
INSERT [dbo].[NhanVien] ([ID], [TenDangNhap], [HoTen], [DiaChi], [GioiTinh], [NgaySinh], [QueQuan], [SoDienThoai], [TrangThai]) VALUES (16, N'admin', N'ADMIN', N'--', N'Khác', CAST(N'2018-10-25' AS Date), N'--', N'--', 0)
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'admin', N'Admin', N'1982408718410113214846658453255177250147212', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'hao', N'Hoàng Văn Hào', N'1982408718410113214846658453255177250147212', 0)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'linh', N'Nguyễn Văn Linh', N'1982408718410113214846658453255177250147212', 0)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'toan', N'Đặng Văn Toản', N'1982408718410113214846658453255177250147212', 0)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [TenHienThi], [MatKhau], [LoaiTaiKhoan]) VALUES (N'toandn', N'Đinh Ngọc Toàn', N'1982408718410113214846658453255177250147212', 0)
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NhanVien__55F68FC0DF4F6BD6]    Script Date: 10/26/2018 10:34:10 AM ******/
ALTER TABLE [dbo].[NhanVien] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ban] ADD  DEFAULT (N'Bàn chưa có tên') FOR [TenBan]
GO
ALTER TABLE [dbo].[Ban] ADD  DEFAULT (N'Trống') FOR [TrangThai]
GO
ALTER TABLE [dbo].[ChiTietHD] ADD  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[DanhMuc] ADD  DEFAULT (N'Chưa đặt tên') FOR [TenDanhMuc]
GO
ALTER TABLE [dbo].[HoaDon] ADD  DEFAULT (getdate()) FOR [NgayVao]
GO
ALTER TABLE [dbo].[HoaDon] ADD  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[HoaDon] ADD  DEFAULT ((0)) FOR [GiamGia]
GO
ALTER TABLE [dbo].[HoaDon] ADD  DEFAULT ((0)) FOR [TongTien]
GO
ALTER TABLE [dbo].[Mon] ADD  DEFAULT (N'Chưa đặt tên') FOR [TenMon]
GO
ALTER TABLE [dbo].[Mon] ADD  DEFAULT ((0)) FOR [Gia]
GO
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [DF_NhanVien_TrangThai]  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (N'Tên hiển thị') FOR [TenHienThi]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [MatKhau]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [LoaiTaiKhoan]
GO
ALTER TABLE [dbo].[ChiTietHD]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHD__IDHoa__31B762FC] FOREIGN KEY([IDHoaDon])
REFERENCES [dbo].[HoaDon] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHD] CHECK CONSTRAINT [FK__ChiTietHD__IDHoa__31B762FC]
GO
ALTER TABLE [dbo].[ChiTietHD]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHD__IDMon__32AB8735] FOREIGN KEY([IDMon])
REFERENCES [dbo].[Mon] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHD] CHECK CONSTRAINT [FK__ChiTietHD__IDMon__32AB8735]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([IDBan])
REFERENCES [dbo].[Ban] ([ID])
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK__HoaDon__IDNhanVi__2DE6D218] FOREIGN KEY([IDNhanVien])
REFERENCES [dbo].[NhanVien] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK__HoaDon__IDNhanVi__2DE6D218]
GO
ALTER TABLE [dbo].[Mon]  WITH CHECK ADD  CONSTRAINT [FK__Mon__IDDanhMuc__44FF419A] FOREIGN KEY([IDDanhMuc])
REFERENCES [dbo].[DanhMuc] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Mon] CHECK CONSTRAINT [FK__Mon__IDDanhMuc__44FF419A]
GO
/****** Object:  StoredProcedure [dbo].[dangnhap]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[dangnhap]
    @tentk NVARCHAR(30),
    @tenmk NVARCHAR(30),
    @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @login NVARCHAR(MAX),
            @user NVARCHAR(MAX);
    SET @login = N'create login [' + @tentk + N'] with password =''' + @tenmk + N'''' + N', DEFAULT_DATABASE = [QLCF]';
    EXECUTE (@login);
    SET @user = N'USE QLCF exec sp_grantdbaccess ' + @tentk + N', ' + @tenuser;
    EXECUTE (@user);
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_CapNhatTaiKhoan]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_CapNhatTaiKhoan]
    @tenDangNhap NVARCHAR(100),
    @tenHienThi NVARCHAR(100),
    @matKhau NVARCHAR(100),
    @matKhauMoi NVARCHAR(100)
AS
BEGIN
    DECLARE @kiemTraMatKhau INT = 0;

    SELECT @kiemTraMatKhau = COUNT(*)
    FROM dbo.TaiKhoan
    WHERE TenDangNhap = @tenDangNhap
          AND MatKhau = @matKhau;

    IF (@kiemTraMatKhau = 1)
    BEGIN
        IF (@matKhauMoi = NULL OR @matKhauMoi = '')
        BEGIN
            UPDATE dbo.TaiKhoan
            SET TenHienThi = @tenHienThi
            WHERE TenDangNhap = @tenDangNhap;
        END;
        ELSE
            UPDATE dbo.TaiKhoan
            SET TenHienThi = @tenHienThi,
                MatKhau = @matKhauMoi
            WHERE TenDangNhap = @tenDangNhap;
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ChenChiTietHD]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_ChenChiTietHD]
    @IDHoaDon INT,
    @IDMon INT,
    @SoLuong INT
AS
BEGIN

    DECLARE @IDChiTietHD INT;
    DECLARE @SoMon INT = 1;

    SELECT @IDChiTietHD = ID,
           @SoMon = SoLuong
    FROM dbo.ChiTietHD
    WHERE IDHoaDon = @IDHoaDon
          AND IDMon = @IDMon;

    IF (@IDChiTietHD > 0)
    BEGIN
        DECLARE @SoLuongMoi INT = @SoMon + @SoLuong;
        IF (@SoLuongMoi > 0)
            UPDATE dbo.ChiTietHD
            SET SoLuong = @SoMon + @SoLuong
            WHERE IDMon = @IDMon;
        ELSE
            DELETE dbo.ChiTietHD
            WHERE IDHoaDon = @IDHoaDon
                  AND IDMon = @IDMon;
    END;
    ELSE
	IF (@SoLuong>0)
    BEGIN
        INSERT dbo.ChiTietHD
        (
            IDHoaDon,
            IDMon,
            SoLuong
        )
        VALUES
        (   @IDHoaDon, -- IDHoaDon - int
            @IDMon,    -- IDMon - int
            @SoLuong   -- SoLuong - int
            );
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ChenHoaDon]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_ChenHoaDon] @IDBan INT
AS
BEGIN
    INSERT INTO dbo.HoaDon
    (
        NgayVao,
        NgayRa,
        IDBan,
        TrangThai,
        GiamGia
    )
    VALUES
    (   GETDATE(), -- NgayVao - date
        NULL,      -- NgayRa - date
        @IDBan,    -- IDBan - int
        0,         -- TrangThai - int
        0          -- GiamGia - int
        );
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ChuyenBan]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_ChuyenBan] @IDBan1 INT,@IDBan2 INT
AS
BEGIN
    DECLARE @IDHoaDon1 INT;
    DECLARE @IDHoaDon2 INT;
	DECLARE @TrangThai1 NVARCHAR(100);
	DECLARE @TrangThai2 NVARCHAR(100);
    SELECT @IDHoaDon1=ID FROM dbo.HoaDon WHERE IDBan=@IDBan1 AND TrangThai=0;
	SELECT @IDHoaDon2=ID FROM dbo.HoaDon WHERE IDBan=@IDBan2 AND TrangThai=0;
	SELECT @TrangThai1=TrangThai FROM dbo.Ban WHERE ID=@IDBan1;
	SELECT @TrangThai2=TrangThai FROM dbo.Ban WHERE ID=@IDBan2;
	UPDATE dbo.Ban SET TrangThai=@TrangThai1 WHERE ID=@IDBan2;
	UPDATE dbo.Ban SET TrangThai=@TrangThai2 WHERE ID=@IDBan1;
	UPDATE dbo.HoaDon SET IDBan = @IDBan1 WHERE ID=@IDHoaDon2;
	UPDATE dbo.HoaDon SET IDBan=@IDBan2 WHERE ID =@IDHoaDon1;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_DangNhap]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_DangNhap]
    @TenDangNhap NVARCHAR(100),
    @MatKhau NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM dbo.TaiKhoan
    WHERE TenDangNhap = @TenDangNhap
          AND MatKhau = @MatKhau;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_Menu]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_Menu] @IDBan INT
AS
SELECT m.TenMon, ct.SoLuong, m.Gia, m.Gia * ct.SoLuong AS tongTien
FROM dbo.ChiTietHD ct
     INNER JOIN dbo.HoaDon hd ON hd.ID=ct.IDHoaDon
     INNER JOIN dbo.Mon m ON m.ID=ct.IDMon
WHERE hd.TrangThai=0 AND hd.IDBan=@IDBan;
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemTaiKhoan]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_ThemTaiKhoan] @TenDangNhap NVARCHAR(100), @TenHienThi NVARCHAR(100), @LoaiTaiKhoan INT
AS BEGIN
    DECLARE @SoLuongTaiKhoan INT;
    SELECT @SoLuongTaiKhoan=COUNT(*)
    FROM dbo.TaiKhoan
    WHERE TenDangNhap=@TenDangNhap;
    IF(@SoLuongTaiKhoan<1)
        INSERT dbo.TaiKhoan(TenDangNhap, TenHienThi, LoaiTaiKhoan, MatKhau)
        VALUES(@TenDangNhap, @TenHienThi, @LoaiTaiKhoan, N'1982408718410113214846658453255177250147212');
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ThongKeHoaDon]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_ThongKeHoaDon] @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT b.TenBan AS [Tên bàn],nv.HoTen AS [Nhân viên], hd.NgayVao AS [Ngày vào], hd.NgayRa AS [Ngày ra], hd.TongTien AS [Tổng tiền], hd.GiamGia AS [Giảm giá]
    FROM dbo.HoaDon hd
         INNER JOIN dbo.Ban b ON b.ID=hd.IDBan INNER JOIN dbo.NhanVien nv ON nv.ID = hd.IDNhanVien
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ThongKeTheoMon]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[proc_ThongKeTheoMon] @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT m.TenMon AS [Tên món], d.TenDanhMuc AS [Tên danh mục], m.Gia AS [Giá], SUM(ct.SoLuong) AS [Số lượng bán ra], SUM(ct.SoLuong)* m.Gia AS [Tổng thu]
    FROM dbo.ChiTietHD ct
         INNER JOIN dbo.Mon m ON m.ID=ct.IDMon
         INNER JOIN dbo.DanhMuc d ON d.ID=m.IDDanhMuc
         INNER JOIN dbo.HoaDon hd ON hd.ID=ct.IDHoaDon
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1
    GROUP BY m.TenMon, d.TenDanhMuc, m.Gia;
END;
GO
/****** Object:  StoredProcedure [dbo].[proc_ThongKeTheoNhanVien]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_ThongKeTheoNhanVien] @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT nv.ID AS [ID Nhân viên], nv.HoTen AS [Họ tên nhân viên], COUNT(*) AS [Số lượng hoá đơn], SUM(hd.TongTien) AS [Tổng thu]
    FROM dbo.NhanVien nv
         INNER JOIN dbo.HoaDon hd ON hd.IDNhanVien=nv.ID
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1
    GROUP BY nv.ID, nv.HoTen;
END;
GO
/****** Object:  StoredProcedure [dbo].[revoke_user]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[revoke_user] @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @thuhoi NVARCHAR(MAX);
    SET @thuhoi
        = N'revoke delete, insert,select on HoaDon to ' + @tenuser
          + N';
	revoke delete, insert, select on ChiTietHD to ' + @tenuser + N';';
    EXECUTE (@thuhoi);
END;
GO
/****** Object:  StoredProcedure [dbo].[vt_csdl]    Script Date: 10/26/2018 10:34:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[vt_csdl] @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @loaitaikhoan NVARCHAR(MAX),
            @vaitro NVARCHAR(MAX);
    SELECT @loaitaikhoan = LoaiTaiKhoan
    FROM TaiKhoan;
    IF (@loaitaikhoan = 1) EXEC sp_addrolemember 'Db_owner', @tenuser;
    IF (@loaitaikhoan = 0)
    BEGIN
        SET @vaitro
            = N'grant delete ,insert, select on HoaDon to ' + @tenuser
              + N'; 
			grant delete ,insert, select on ChiTietHD to ' + @tenuser + N';';
        EXECUTE (@vaitro);
    END;
END;
GO
USE [master]
GO
ALTER DATABASE [QLCF] SET  READ_WRITE 
GO
