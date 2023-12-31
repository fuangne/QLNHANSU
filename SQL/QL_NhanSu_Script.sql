USE [master]
GO
/****** Object:  Database [QL_NHANSU]    Script Date: 12/16/2023 10:33:44 PM ******/
CREATE DATABASE [QL_NHANSU]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_NHANSU', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.FUANG\MSSQL\DATA\QL_NHANSU.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QL_NHANSU_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.FUANG\MSSQL\DATA\QL_NHANSU_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QL_NHANSU] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_NHANSU].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_NHANSU] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_NHANSU] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_NHANSU] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_NHANSU] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_NHANSU] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_NHANSU] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_NHANSU] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_NHANSU] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_NHANSU] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_NHANSU] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_NHANSU] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_NHANSU] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_NHANSU] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_NHANSU] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_NHANSU] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QL_NHANSU] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_NHANSU] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_NHANSU] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_NHANSU] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_NHANSU] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_NHANSU] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_NHANSU] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_NHANSU] SET RECOVERY FULL 
GO
ALTER DATABASE [QL_NHANSU] SET  MULTI_USER 
GO
ALTER DATABASE [QL_NHANSU] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_NHANSU] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_NHANSU] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_NHANSU] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QL_NHANSU] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QL_NHANSU] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QL_NHANSU', N'ON'
GO
ALTER DATABASE [QL_NHANSU] SET QUERY_STORE = ON
GO
ALTER DATABASE [QL_NHANSU] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QL_NHANSU]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TongTienThuongPhat]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_TongTienThuongPhat] (@MaNV varchar(10), @Thang int, @Nam int)
RETURNS money
AS
BEGIN
  DECLARE @Tong money
  SELECT @Tong = SUM(CASE WHEN TP.Loai LIKE N'%Thưởng%' THEN CT.Tien ELSE -CT.Tien END)
  FROM CHITIETTHUONGPHAT AS CT 
  INNER JOIN THUONGPHAT AS TP ON CT.MaTP = TP.MaTP
  WHERE CT.MaNV = @MaNV 
    AND MONTH(CT.Ngay) = @Thang 
    AND YEAR(CT.Ngay) = @Nam
  RETURN @Tong
END
GO
/****** Object:  Table [dbo].[CHITIETTHUONGPHAT]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETTHUONGPHAT](
	[MaCTTP] [char](10) NOT NULL,
	[MaNV] [char](10) NULL,
	[MaTP] [char](10) NULL,
	[Tien] [float] NULL,
	[LyDo] [nvarchar](max) NULL,
	[Ngay] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCTTP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CHUCVU]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHUCVU](
	[MaCV] [char](10) NOT NULL,
	[TenCV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOPDONGLAODONG]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOPDONGLAODONG](
	[MaHD] [char](10) NOT NULL,
	[MaNV] [char](10) NOT NULL,
	[LoaiHD] [nvarchar](max) NULL,
	[TuNgay] [date] NULL,
	[DenNgay] [date] NULL,
	[TinhTrang] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LUONG]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LUONG](
	[MucLuong] [char](10) NOT NULL,
	[LuongCB] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MucLuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NGHIPHEP]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NGHIPHEP](
	[MANP] [char](10) NOT NULL,
	[MaNV] [char](10) NULL,
	[TuNgay] [date] NULL,
	[DenNgay] [date] NULL,
	[LyDo] [nvarchar](255) NULL,
	[TinhTrang] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[MANP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MaNV] [char](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nvarchar](6) NULL,
	[CMND] [char](15) NULL,
	[SoDienThoai] [char](15) NULL,
	[QueQuan] [nvarchar](50) NULL,
	[DanToc] [nvarchar](20) NULL,
	[MucLuong] [char](10) NULL,
	[MaPB] [char](10) NULL,
	[MaCV] [char](10) NULL,
	[MaTDHV] [char](10) NULL,
	[MaNQL] [char](10) NULL,
	[TTHN] [nvarchar](30) NULL,
	[HINH] [image] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHONGBAN]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHONGBAN](
	[MaPB] [char](10) NOT NULL,
	[TenPB] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDTPB] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QUYEN]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QUYEN](
	[MANV] [char](10) NULL,
	[TENDN] [varchar](20) NOT NULL,
	[MATKHAU] [varchar](20) NULL,
	[VAITRO] [nvarchar](30) NULL,
 CONSTRAINT [PK_QUYEN] PRIMARY KEY CLUSTERED 
(
	[TENDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THONGTINNHANTHAN]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THONGTINNHANTHAN](
	[MaNT] [char](10) NOT NULL,
	[MaNV] [char](10) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[QuanHe] [nvarchar](20) NULL,
	[NgaySinh] [date] NULL,
	[SoDienThoai] [char](15) NULL,
	[NgheNghiep] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNT] ASC,
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THUONGPHAT]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THUONGPHAT](
	[MATP] [char](10) NOT NULL,
	[Loai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MATP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TINHLUONG]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TINHLUONG](
	[MaNV] [char](10) NOT NULL,
	[Thang] [int] NOT NULL,
	[Nam] [int] NOT NULL,
	[SoNgayCong] [int] NULL,
	[TienThuongPhat] [float] NULL,
	[TongLuong] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC,
	[Thang] ASC,
	[Nam] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRINHDOHOCVAN]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRINHDOHOCVAN](
	[MaTDHV] [char](10) NOT NULL,
	[TTDHV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTDHV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH101     ', N'NV102     ', N'PH        ', 10000, N'Quên tắt đèn', CAST(N'2023-11-05' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH102     ', N'NV101     ', N'PH        ', 100000, N'Không quản lý được nv', CAST(N'2023-12-05' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH104     ', N'NV102     ', N'PH        ', 10000, N'Quên tắt đèn', CAST(N'2023-11-05' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH107     ', N'NV102     ', N'PH        ', 10000, N'Quên tắt đèn', CAST(N'2023-11-05' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH201     ', N'NV102     ', N'PH        ', 50000, N'Đi trễ', CAST(N'2023-01-15' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH202     ', N'NV105     ', N'PH        ', 20000, N'Làm hỏng tài sản', CAST(N'2023-03-10' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH203     ', N'NV108     ', N'PH        ', 30000, N'Gây mất đoàn kết', CAST(N'2023-05-29' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH204     ', N'NV112     ', N'PH        ', 40000, N'Không hoàn thành công việc', CAST(N'2023-07-12' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'PH205     ', N'NV116     ', N'PH        ', 60000, N'Thiếu trách nhiệm', CAST(N'2023-09-07' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH101     ', N'NV101     ', N'TH        ', 120000, N'Đi sự kiện', CAST(N'2023-02-12' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH105     ', N'NV101     ', N'TH        ', 120000, N'Đi sự kiện', CAST(N'2023-02-12' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH201     ', N'NV103     ', N'TH        ', 100000, N'Hoàn thành tốt công việc', CAST(N'2023-02-23' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH202     ', N'NV106     ', N'TH        ', 150000, N'Đề xuất sáng kiến', CAST(N'2023-04-17' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH203     ', N'NV110     ', N'TH        ', 80000, N'Chủ động học hỏi', CAST(N'2023-06-08' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH204     ', N'NV114     ', N'TH        ', 200000, N'Hoàn thành dự án trước hạn', CAST(N'2023-08-25' AS Date))
INSERT [dbo].[CHITIETTHUONGPHAT] ([MaCTTP], [MaNV], [MaTP], [Tien], [LyDo], [Ngay]) VALUES (N'TH205     ', N'NV101     ', N'TH        ', 120000, N'Xuất sắc trong công việc', CAST(N'2023-10-19' AS Date))
GO
INSERT [dbo].[CHUCVU] ([MaCV], [TenCV]) VALUES (N'CV1       ', N'Giám đốc')
INSERT [dbo].[CHUCVU] ([MaCV], [TenCV]) VALUES (N'CV2       ', N'Trưởng phòng')
INSERT [dbo].[CHUCVU] ([MaCV], [TenCV]) VALUES (N'CV3       ', N'Nhân Viên')
GO
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD1       ', N'NV101     ', N'Hợp đồng thử việc 3 tháng', CAST(N'2022-01-01' AS Date), CAST(N'2022-03-01' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD10      ', N'NV109     ', N'Hợp đồng thử việc', CAST(N'2023-03-01' AS Date), CAST(N'2023-05-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD11      ', N'NV110     ', N'Hợp đồng 1 năm', CAST(N'2023-03-01' AS Date), CAST(N'2024-02-28' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD12      ', N'NV111     ', N'Hợp đồng 3 năm', CAST(N'2023-03-01' AS Date), CAST(N'2026-02-28' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD13      ', N'NV112     ', N'Hợp đồng thử việc', CAST(N'2023-04-01' AS Date), CAST(N'2023-06-30' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD14      ', N'NV113     ', N'Hợp đồng 1 năm', CAST(N'2023-04-01' AS Date), CAST(N'2024-03-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD15      ', N'NV114     ', N'Hợp đồng 3 năm', CAST(N'2023-04-01' AS Date), CAST(N'2026-03-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD16      ', N'NV115     ', N'Hợp đồng 1 năm', CAST(N'2023-05-01' AS Date), CAST(N'2024-04-30' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD17      ', N'NV116     ', N'Hợp đồng thử việc', CAST(N'2023-06-01' AS Date), CAST(N'2023-08-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD2       ', N'NV101     ', N'Hợp đồng nhân viên chính thức', CAST(N'2022-03-02' AS Date), CAST(N'2025-03-02' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD3       ', N'NV102     ', N'Hợp đồng thử việc 3 tháng', CAST(N'2022-02-01' AS Date), CAST(N'2022-04-01' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD4       ', N'NV103     ', N'Hợp đồng thử việc', CAST(N'2023-01-01' AS Date), CAST(N'2023-03-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD5       ', N'NV104     ', N'Hợp đồng 1 năm', CAST(N'2023-01-01' AS Date), CAST(N'2023-12-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD6       ', N'NV105     ', N'Hợp đồng 3 năm', CAST(N'2023-01-01' AS Date), CAST(N'2025-12-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD7       ', N'NV106     ', N'Hợp đồng thử việc', CAST(N'2023-02-01' AS Date), CAST(N'2023-04-30' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD8       ', N'NV107     ', N'Hợp đồng 1 năm', CAST(N'2023-02-01' AS Date), CAST(N'2024-01-31' AS Date), NULL)
INSERT [dbo].[HOPDONGLAODONG] ([MaHD], [MaNV], [LoaiHD], [TuNgay], [DenNgay], [TinhTrang]) VALUES (N'HD9       ', N'NV108     ', N'Hợp đồng 3 năm', CAST(N'2023-02-01' AS Date), CAST(N'2026-01-31' AS Date), NULL)
GO
INSERT [dbo].[LUONG] ([MucLuong], [LuongCB]) VALUES (N'M1        ', 8000000)
INSERT [dbo].[LUONG] ([MucLuong], [LuongCB]) VALUES (N'M2        ', 6000000)
INSERT [dbo].[LUONG] ([MucLuong], [LuongCB]) VALUES (N'M3        ', 4000000)
GO
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP101     ', N'NV102     ', CAST(N'2023-06-10' AS Date), CAST(N'2023-06-12' AS Date), N'Công tác', N'Đã duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP102     ', N'NV101     ', CAST(N'2023-06-10' AS Date), CAST(N'2023-06-12' AS Date), N'Công tác', N'Đã duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP103     ', N'NV101     ', CAST(N'2023-12-02' AS Date), CAST(N'2023-12-04' AS Date), N'Công tác', N'Đã duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP104     ', N'NV102     ', CAST(N'2023-12-05' AS Date), CAST(N'2023-12-06' AS Date), N'Công tác', N'Đã duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP105     ', N'NV103     ', CAST(N'2023-12-25' AS Date), CAST(N'2023-12-30' AS Date), N'Du lịch nghỉ dưỡng', N'Chưa duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP106     ', N'NV107     ', CAST(N'2024-01-20' AS Date), CAST(N'2024-01-25' AS Date), N'Về quê ăn Tết', N'Chưa duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP107     ', N'NV112     ', CAST(N'2024-02-10' AS Date), CAST(N'2024-02-15' AS Date), N'Đám cưới em gái', N'Chưa duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP108     ', N'NV116     ', CAST(N'2024-03-05' AS Date), CAST(N'2024-03-10' AS Date), N'Khám sức khỏe định kỳ', N'Chưa duyệt')
INSERT [dbo].[NGHIPHEP] ([MANP], [MaNV], [TuNgay], [DenNgay], [LyDo], [TinhTrang]) VALUES (N'NP109     ', N'NV105     ', CAST(N'2024-04-01' AS Date), CAST(N'2024-04-03' AS Date), N'Dự họp phụ huynh', N'Chưa duyệt')
GO
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV101     ', N'Nguyễn Văn A', CAST(N'1990-01-15' AS Date), N'Nam', N'111111111111   ', N'0123456789     ', N'Hà Nội', N'Kinh', N'M1        ', N'PH110     ', N'CV1       ', N'TDHV1     ', NULL, N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV102     ', N'Trần Thị B', CAST(N'1985-03-20' AS Date), N'Nữ', N'2222222222     ', N'0234567890     ', N'Hải Phòng', N'Kinh', N'M2        ', N'PH102     ', N'CV2       ', N'TDHV2     ', N'NV101     ', N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV103     ', N'Lê Văn C', CAST(N'1992-06-05' AS Date), N'Nam', N'3333333333     ', N'0345678901     ', N'Đà Nẵng', N'Kinh', N'M1        ', N'PH101     ', N'CV1       ', N'TDHV3     ', NULL, N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV104     ', N'Phạm Thị D', CAST(N'1988-11-12' AS Date), N'Nữ', N'4444444444     ', N'0456789012     ', N'Quảng Ninh', N'Kinh', N'M2        ', N'PH102     ', N'CV2       ', N'TDHV1     ', N'NV101     ', N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV105     ', N'Hoàng Văn E', CAST(N'1995-02-25' AS Date), N'Nam', N'555555555      ', N'0567890123     ', N'Cần Thơ', N'Kinh', N'M3        ', N'PH103     ', N'CV3       ', N'TDHV2     ', N'NV104     ', N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV106     ', N'Vũ Thị F', CAST(N'1986-07-10' AS Date), N'Nữ', N'6666666666     ', N'0678901234     ', N'Đồng Nai', N'Kinh', N'M1        ', N'PH101     ', N'CV1       ', N'TDHV1     ', NULL, N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV107     ', N'Đặng Văn G', CAST(N'1993-09-18' AS Date), N'Nam', N'7777777777     ', N'0789012345     ', N'Hưng Yên', N'Kinh', N'M2        ', N'PH103     ', N'CV2       ', N'TDHV2     ', N'NV101     ', N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV108     ', N'Ngô Thị H', CAST(N'1984-04-30' AS Date), N'Nữ', N'8888888888     ', N'0890123456     ', N'Hà Tĩnh', N'Kinh', N'M3        ', N'PH101     ', N'CV3       ', N'TDHV3     ', N'NV104     ', N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV109     ', N'Lý Văn I', CAST(N'1991-08-22' AS Date), N'Nam', N'9999999999     ', N'0901234567     ', N'Hòa Bình', N'Kinh', N'M1        ', N'PH104     ', N'CV1       ', N'TDHV1     ', NULL, N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV110     ', N'Chu Thị K', CAST(N'1987-12-05' AS Date), N'Nữ', N'1010101010     ', N'0987654321     ', N'Quảng Trị', N'Kinh', N'M2        ', N'PH104     ', N'CV2       ', N'TDHV2     ', N'NV101     ', N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV111     ', N'Phan Văn L', CAST(N'1993-03-15' AS Date), N'Nam', N'1212121212     ', N'0123456789     ', N'Quảng Ngãi', N'Kinh', N'M3        ', N'PH105     ', N'CV3       ', N'TDHV1     ', N'NV104     ', N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV112     ', N'Bùi Thị M', CAST(N'1988-05-28' AS Date), N'Nữ', N'1313131313     ', N'0234567890     ', N'Kiên Giang', N'Kinh', N'M1        ', N'PH106     ', N'CV1       ', N'TDHV2     ', NULL, N'Độc thân', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV113     ', N'Trần Văn N', CAST(N'1990-09-10' AS Date), N'Nam', N'1414141414     ', N'0345678901     ', N'Bình Phước', N'Kinh', N'M2        ', N'PH105     ', N'CV2       ', N'TDHV3     ', N'NV101     ', N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV114     ', N'Hoàng Thị O', CAST(N'1987-11-22' AS Date), N'Nữ', N'1515151515     ', N'0456789012     ', N'Lâm Đồng', N'Kinh', N'M3        ', N'PH106     ', N'CV3       ', N'TDHV1     ', N'NV104     ', N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV115     ', N'Đinh Văn P', CAST(N'1996-01-18' AS Date), N'Nam', N'1616161616     ', N'0567890123     ', N'Bạc Liêu', N'Kinh', N'M1        ', N'PH107     ', N'CV1       ', N'TDHV2     ', NULL, N'Kết hôn', NULL)
INSERT [dbo].[NHANVIEN] ([MaNV], [HoTen], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [QueQuan], [DanToc], [MucLuong], [MaPB], [MaCV], [MaTDHV], [MaNQL], [TTHN], [HINH]) VALUES (N'NV116     ', N'Võ Thị Q', CAST(N'1986-06-05' AS Date), N'Nữ', N'1717171717     ', N'0678901234     ', N'Cà Mau', N'Kinh', N'M2        ', N'PH107     ', N'CV2       ', N'TDHV3     ', N'NV101     ', N'Độc thân', NULL)
GO
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH101     ', N'Phòng Kế Toán', N'123 Đường A, Quận 1, TP.HCM', N'0123456789     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH102     ', N'Phòng Kinh Doanh', N'456 Đường B, Quận 2, TP.HCM', N'0987654321     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH103     ', N'Phòng Nhân Sự', N'789 Đường C, Quận 3, TP.HCM', N'0123123456     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH104     ', N'Phòng Hành Chính', N'101 Đường D, Quận 4, TP.HCM', N'0345789123     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH105     ', N'Phòng Công Nghệ', N'202 Đường E, Quận 5, TP.HCM', N'0789456123     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH106     ', N'Phòng Marketing', N'303 Đường F, Quận 6, TP.HCM', N'0912345678     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH107     ', N'Phòng Kỹ Thuật', N'404 Đường G, Quận 7, TP.HCM', N'0898765432     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH108     ', N'Phòng Tài Chính', N'505 Đường H, Quận 8, TP.HCM', N'0341234567     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH109     ', N'Phòng Hỗ Trợ', N'606 Đường I, Quận 9, TP.HCM', N'0777123456     ')
INSERT [dbo].[PHONGBAN] ([MaPB], [TenPB], [DiaChi], [SDTPB]) VALUES (N'PH110     ', N'Phòng Quản Lý', N'707 Đường J, Quận 10, TP.HCM', N'0981234567     ')
GO
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV112     ', N'BuiTM', N'pass12', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV110     ', N'ChuTK', N'pass10', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV107     ', N'DangVG', N'pass7', N'Nhân sự')
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV115     ', N'DinhVP', N'pass15', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV114     ', N'HoangTO', N'pass14', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV105     ', N'HoangVE', N'pass5', N'Nhân sự')
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV103     ', N'LeVC', N'pass3', N'Kế toán')
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV109     ', N'LyVI', N'pass9', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV108     ', N'NgoTH', N'pass8', N'Kế toán')
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV101     ', N'NguyenVA', N'pass1', N'Quản lý')
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV104     ', N'PhamTD', N'pass4', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV111     ', N'PhanVL', N'pass11', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV102     ', N'TranTB', N'pass2', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV113     ', N'TranVN', N'pass13', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV116     ', N'VoTQ', N'pass16', NULL)
INSERT [dbo].[QUYEN] ([MANV], [TENDN], [MATKHAU], [VAITRO]) VALUES (N'NV106     ', N'VuTF', N'pass6', N'Kế toán')
GO
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT1       ', N'NV101     ', N'Huỳnh Thanh A', N'Vợ', CAST(N'1995-04-23' AS Date), N'04123652098    ', N'Chủ tịch')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT10      ', N'NV107     ', N'Vũ Văn K', N'Bạn', CAST(N'1992-04-16' AS Date), N'0954231256     ', N'Kế toán')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT11      ', N'NV108     ', N'Lý Thị L', N'Bạn', CAST(N'1985-12-31' AS Date), N'0659743128     ', N'Giám đốc')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT12      ', N'NV109     ', N'Hoàng Văn M', N'Anh rể', CAST(N'1988-10-25' AS Date), N'0314206587     ', N'Bác sĩ')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT13      ', N'NV110     ', N'Trương Thị N', N'Chị dâu', CAST(N'1989-08-30' AS Date), N'0287649351     ', N'Giáo viên')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT2       ', N'NV101     ', N'Nguyễn Thanh B', N'Con', CAST(N'2020-10-05' AS Date), NULL, NULL)
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT3       ', N'NV101     ', N'Nguyễn Thị C', N'Con gái', CAST(N'2020-01-01' AS Date), N'0123456789     ', N'Học sinh')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT4       ', N'NV101     ', N'Nguyễn Văn D', N'Con trai', CAST(N'2018-03-15' AS Date), N'0987654321     ', N'Học sinh')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT5       ', N'NV102     ', N'Lê Thị E', N'Mẹ', CAST(N'1960-05-06' AS Date), N'0246813579     ', N'Nội trợ')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT6       ', N'NV103     ', N'Trần Văn F', N'Bố', CAST(N'1958-02-14' AS Date), N'0546218709     ', N'Kỹ sư')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT7       ', N'NV104     ', N'Ngô Thị G', N'Chị', CAST(N'1987-06-29' AS Date), N'0963142587     ', N'Giáo viên')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT8       ', N'NV105     ', N'Phạm Văn H', N'Anh', CAST(N'1993-11-07' AS Date), N'0325879641     ', N'Bác sĩ')
INSERT [dbo].[THONGTINNHANTHAN] ([MaNT], [MaNV], [Ten], [QuanHe], [NgaySinh], [SoDienThoai], [NgheNghiep]) VALUES (N'NT9       ', N'NV106     ', N'Nguyễn Thị I', N'Cháu', CAST(N'2015-09-20' AS Date), NULL, NULL)
GO
INSERT [dbo].[THUONGPHAT] ([MATP], [Loai]) VALUES (N'PH        ', N'Phạt')
INSERT [dbo].[THUONGPHAT] ([MATP], [Loai]) VALUES (N'TH        ', N'Thưởng')
GO
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV101     ', 12, 2023, 23, -100000, 7900000)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV102     ', 11, 2023, 26, -30000, 5970000)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV102     ', 12, 2023, 24, NULL, 0)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV103     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV104     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV105     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV106     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV107     ', 12, 2023, 24, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV108     ', 12, 2023, 28, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV109     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV110     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV111     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV112     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV113     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV114     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV115     ', 12, 2023, 26, NULL, NULL)
INSERT [dbo].[TINHLUONG] ([MaNV], [Thang], [Nam], [SoNgayCong], [TienThuongPhat], [TongLuong]) VALUES (N'NV116     ', 12, 2023, 26, NULL, NULL)
GO
INSERT [dbo].[TRINHDOHOCVAN] ([MaTDHV], [TTDHV]) VALUES (N'TDHV1     ', N'Trên Đại học')
INSERT [dbo].[TRINHDOHOCVAN] ([MaTDHV], [TTDHV]) VALUES (N'TDHV2     ', N'Đại học')
INSERT [dbo].[TRINHDOHOCVAN] ([MaTDHV], [TTDHV]) VALUES (N'TDHV3     ', N'Cao đẳng')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NHANVIEN__F67C8D0B01E2CC7F]    Script Date: 12/16/2023 10:33:44 PM ******/
ALTER TABLE [dbo].[NHANVIEN] ADD UNIQUE NONCLUSTERED 
(
	[CMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHITIETTHUONGPHAT]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[CHITIETTHUONGPHAT]  WITH CHECK ADD FOREIGN KEY([MaTP])
REFERENCES [dbo].[THUONGPHAT] ([MATP])
GO
ALTER TABLE [dbo].[CHITIETTHUONGPHAT]  WITH CHECK ADD  CONSTRAINT [FK_Delete_NhanVien_TP] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CHITIETTHUONGPHAT] CHECK CONSTRAINT [FK_Delete_NhanVien_TP]
GO
ALTER TABLE [dbo].[HOPDONGLAODONG]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[HOPDONGLAODONG]  WITH CHECK ADD  CONSTRAINT [FK_Delete_NhanVien_HDDL] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HOPDONGLAODONG] CHECK CONSTRAINT [FK_Delete_NhanVien_HDDL]
GO
ALTER TABLE [dbo].[NGHIPHEP]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[NGHIPHEP]  WITH CHECK ADD  CONSTRAINT [FK_Delete_NhanVien_NP] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NGHIPHEP] CHECK CONSTRAINT [FK_Delete_NhanVien_NP]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD FOREIGN KEY([MaCV])
REFERENCES [dbo].[CHUCVU] ([MaCV])
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD FOREIGN KEY([MaNQL])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD FOREIGN KEY([MaPB])
REFERENCES [dbo].[PHONGBAN] ([MaPB])
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD FOREIGN KEY([MaTDHV])
REFERENCES [dbo].[TRINHDOHOCVAN] ([MaTDHV])
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD FOREIGN KEY([MucLuong])
REFERENCES [dbo].[LUONG] ([MucLuong])
GO
ALTER TABLE [dbo].[QUYEN]  WITH CHECK ADD  CONSTRAINT [FK_QUYEN_NHANVIEN] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[QUYEN] CHECK CONSTRAINT [FK_QUYEN_NHANVIEN]
GO
ALTER TABLE [dbo].[THONGTINNHANTHAN]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[THONGTINNHANTHAN]  WITH CHECK ADD  CONSTRAINT [FK_Delete_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[THONGTINNHANTHAN] CHECK CONSTRAINT [FK_Delete_NhanVien]
GO
ALTER TABLE [dbo].[TINHLUONG]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
GO
ALTER TABLE [dbo].[TINHLUONG]  WITH CHECK ADD  CONSTRAINT [FK_Delete_NhanVien_TL] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NHANVIEN] ([MaNV])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TINHLUONG] CHECK CONSTRAINT [FK_Delete_NhanVien_TL]
GO
ALTER TABLE [dbo].[NGHIPHEP]  WITH CHECK ADD  CONSTRAINT [CHK_MANP] CHECK  ((left([MANP],(2))='NP'))
GO
ALTER TABLE [dbo].[NGHIPHEP] CHECK CONSTRAINT [CHK_MANP]
GO
ALTER TABLE [dbo].[NGHIPHEP]  WITH CHECK ADD  CONSTRAINT [CHK_NghiPhep] CHECK  (([TinhTrang]=N'Đã duyệt' OR [TinhTrang]=N'Chưa duyệt'))
GO
ALTER TABLE [dbo].[NGHIPHEP] CHECK CONSTRAINT [CHK_NghiPhep]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [CHK_MaNV] CHECK  ((left([MaNV],(2))='NV'))
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [CHK_MaNV]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [CHK_TTHN] CHECK  (([TTHN]=N'Kết hôn' OR [TTHN]=N'Độc thân'))
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [CHK_TTHN]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [CHK_Tuoi] CHECK  ((datediff(year,[NgaySinh],getdate())>=(18) AND datediff(year,[NgaySinh],getdate())<=(65)))
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [CHK_Tuoi]
GO
ALTER TABLE [dbo].[PHONGBAN]  WITH CHECK ADD  CONSTRAINT [CHK_MaPB] CHECK  ((left([MaPB],(2))='PH'))
GO
ALTER TABLE [dbo].[PHONGBAN] CHECK CONSTRAINT [CHK_MaPB]
GO
ALTER TABLE [dbo].[THUONGPHAT]  WITH CHECK ADD  CONSTRAINT [CHK_Loai] CHECK  (([Loai]=N'Không có' OR [Loai]=N'Phạt' OR [Loai]=N'Thưởng'))
GO
ALTER TABLE [dbo].[THUONGPHAT] CHECK CONSTRAINT [CHK_Loai]
GO
/****** Object:  StoredProcedure [dbo].[TinhNgayCong]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TinhNgayCong] 
@MaNV char(10),
@Thang int,
@Nam int
AS
BEGIN
  DECLARE @SoNgayCong int
  SELECT @SoNgayCong = 26
  SELECT @SoNgayCong = @SoNgayCong - ISNULL(SUM(DATEDIFF(DAY, TuNgay, DenNgay)+1), 0)
  FROM NGHIPHEP
  WHERE MaNV = @MaNV
    AND MONTH(TuNgay) = @Thang
    AND YEAR(TuNgay) = @Nam
    AND TinhTrang = N'Đã duyệt'  
  UPDATE TINHLUONG 
  SET SoNgayCong = @SoNgayCong
  WHERE MaNV = @MaNV 
    AND Thang = @Thang
    AND Nam = @Nam
END
GO
/****** Object:  StoredProcedure [dbo].[TinhTongLuong]    Script Date: 12/16/2023 10:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TinhTongLuong]
@MaNV char(10),  
@Thang int,
@Nam int
AS
BEGIN
  DECLARE @LuongCB float
  DECLARE @SoNgayCong int 
  DECLARE @TongTienTP money
  DECLARE @TongLuong float
  SELECT @LuongCB = L.LuongCB, @SoNgayCong = T.SoNgayCong
  FROM LUONG L JOIN NHANVIEN NV ON L.MucLuong = NV.MucLuong
               JOIN TINHLUONG T ON NV.MaNV = T.MaNV
  WHERE NV.MaNV = @MaNV AND T.Thang = @Thang AND T.Nam = @Nam
  SELECT @TongTienTP = dbo.fn_TongTienThuongPhat(@MaNV, @Thang, @Nam)
  SELECT @TongLuong = @LuongCB/26*@SoNgayCong + @TongTienTP
  IF EXISTS(SELECT * FROM TINHLUONG 
            WHERE MaNV = @MaNV AND Thang = @Thang AND Nam = @Nam)
  BEGIN
     UPDATE TINHLUONG  
     SET TongLuong = @TongLuong
     WHERE MaNV = @MaNV AND Thang = @Thang AND Nam = @Nam
  END
  ELSE
  BEGIN
     INSERT INTO TINHLUONG (MaNV, Thang, Nam, SoNgayCong,TienThuongPhat, TongLuong)  
     VALUES (@MaNV, @Thang, @Nam, @SoNgayCong, @TongTienTP, @TongLuong)
  END
END
GO
USE [master]
GO
ALTER DATABASE [QL_NHANSU] SET  READ_WRITE 
GO
