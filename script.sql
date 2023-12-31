USE [master]
GO
/****** Object:  Database [StokTakip]    Script Date: 25.08.2023 16:08:50 ******/
CREATE DATABASE [StokTakip]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StokTakip', FILENAME = N'D:\Yeni klasör (4)\MSSQL16.MSSQLSERVER\MSSQL\DATA\StokTakip.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StokTakip_log', FILENAME = N'D:\Yeni klasör (4)\MSSQL16.MSSQLSERVER\MSSQL\DATA\StokTakip_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StokTakip] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StokTakip].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StokTakip] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StokTakip] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StokTakip] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StokTakip] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StokTakip] SET ARITHABORT OFF 
GO
ALTER DATABASE [StokTakip] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StokTakip] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StokTakip] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StokTakip] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StokTakip] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StokTakip] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StokTakip] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StokTakip] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StokTakip] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StokTakip] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StokTakip] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StokTakip] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StokTakip] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StokTakip] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StokTakip] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StokTakip] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StokTakip] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StokTakip] SET RECOVERY FULL 
GO
ALTER DATABASE [StokTakip] SET  MULTI_USER 
GO
ALTER DATABASE [StokTakip] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StokTakip] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StokTakip] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StokTakip] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StokTakip] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StokTakip] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'StokTakip', N'ON'
GO
ALTER DATABASE [StokTakip] SET QUERY_STORE = ON
GO
ALTER DATABASE [StokTakip] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StokTakip]
GO
/****** Object:  Table [dbo].[Kategori]    Script Date: 25.08.2023 16:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategori](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Aciklama] [nvarchar](50) NULL,
	[Durum] [bit] NULL,
 CONSTRAINT [PK_Kategori] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanici]    Script Date: 25.08.2023 16:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanici](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[KullaniciAd] [nvarchar](50) NULL,
	[Sifre] [nvarchar](50) NULL,
	[SifreTekrar] [nvarchar](50) NULL,
	[Rol] [nvarchar](10) NULL,
 CONSTRAINT [PK_Kullanici] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Satislar]    Script Date: 25.08.2023 16:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Satislar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UrunId] [int] NULL,
	[Adet] [int] NULL,
	[Fiyat] [decimal](18, 2) NULL,
	[Tarih] [datetime] NULL,
	[Resim] [nvarchar](50) NULL,
	[KullaniciId] [int] NULL,
 CONSTRAINT [PK_Satislar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sepet]    Script Date: 25.08.2023 16:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sepet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UrunId] [int] NULL,
	[Adet] [int] NULL,
	[Fiyat] [decimal](18, 2) NULL,
	[Tarih] [datetime] NULL,
	[Resim] [nvarchar](50) NULL,
	[KullaniciId] [int] NULL,
 CONSTRAINT [PK_Sepet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Urun]    Script Date: 25.08.2023 16:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Urun](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Aciklama] [nvarchar](50) NULL,
	[Fiyat] [decimal](18, 2) NULL,
	[Stok] [int] NULL,
	[Populer] [bit] NULL,
	[Resim] [nvarchar](50) NULL,
	[KategoriId] [int] NULL,
 CONSTRAINT [PK_Urun] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Kategori] ON 

INSERT [dbo].[Kategori] ([Id], [Ad], [Aciklama], [Durum]) VALUES (1, N'Bilgisayar', N'Bilgisayar Ürünleri', 1)
INSERT [dbo].[Kategori] ([Id], [Ad], [Aciklama], [Durum]) VALUES (2, N'Kulaklık', N'Kulaklık Ürünleri', 1)
INSERT [dbo].[Kategori] ([Id], [Ad], [Aciklama], [Durum]) VALUES (3, N'Telefon', N'Telefon Ürünleri', 1)
INSERT [dbo].[Kategori] ([Id], [Ad], [Aciklama], [Durum]) VALUES (4, N'Tablet', N'Tablet Ürünleri', 1)
SET IDENTITY_INSERT [dbo].[Kategori] OFF
GO
SET IDENTITY_INSERT [dbo].[Kullanici] ON 

INSERT [dbo].[Kullanici] ([Id], [Ad], [Soyad], [Email], [KullaniciAd], [Sifre], [SifreTekrar], [Rol]) VALUES (1, N'Samet', N'Fındık', N'smtfndk@gmail.com', N'SametFindik', N'123456', N'123456', N'A')
INSERT [dbo].[Kullanici] ([Id], [Ad], [Soyad], [Email], [KullaniciAd], [Sifre], [SifreTekrar], [Rol]) VALUES (3, N'Selin', N'Fındık', N'slnfndk@gmail.com', N'SelinFndk', N'123456789', N'123456789', N'U')
SET IDENTITY_INSERT [dbo].[Kullanici] OFF
GO
SET IDENTITY_INSERT [dbo].[Satislar] ON 

INSERT [dbo].[Satislar] ([Id], [UrunId], [Adet], [Fiyat], [Tarih], [Resim], [KullaniciId]) VALUES (1, 1, 2, CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-08-25T12:30:55.453' AS DateTime), NULL, 3)
INSERT [dbo].[Satislar] ([Id], [UrunId], [Adet], [Fiyat], [Tarih], [Resim], [KullaniciId]) VALUES (2, 1, 1, CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-08-25T12:50:44.080' AS DateTime), NULL, 3)
INSERT [dbo].[Satislar] ([Id], [UrunId], [Adet], [Fiyat], [Tarih], [Resim], [KullaniciId]) VALUES (3, 1, 2, CAST(3000.00 AS Decimal(18, 2)), CAST(N'2023-08-25T12:56:01.150' AS DateTime), NULL, 3)
INSERT [dbo].[Satislar] ([Id], [UrunId], [Adet], [Fiyat], [Tarih], [Resim], [KullaniciId]) VALUES (4, 1, 1, CAST(1500.00 AS Decimal(18, 2)), CAST(N'2023-08-25T14:20:55.767' AS DateTime), NULL, 3)
INSERT [dbo].[Satislar] ([Id], [UrunId], [Adet], [Fiyat], [Tarih], [Resim], [KullaniciId]) VALUES (5, 11, 3, CAST(22200.00 AS Decimal(18, 2)), CAST(N'2023-08-25T14:25:22.693' AS DateTime), NULL, 3)
SET IDENTITY_INSERT [dbo].[Satislar] OFF
GO
SET IDENTITY_INSERT [dbo].[Urun] ON 

INSERT [dbo].[Urun] ([Id], [Ad], [Aciklama], [Fiyat], [Stok], [Populer], [Resim], [KategoriId]) VALUES (1, N'JBL', N'Kulaklık Ürünleri', CAST(1500.00 AS Decimal(18, 2)), 250, 1, N'61qLnX8fNNL._AC_UF1000,1000_QL80_.jpg', 2)
INSERT [dbo].[Urun] ([Id], [Ad], [Aciklama], [Fiyat], [Stok], [Populer], [Resim], [KategoriId]) VALUES (3, N'iPhone 14 Pro Max ', N'Telefon Ürünleri', CAST(63500.00 AS Decimal(18, 2)), 50, 1, N'Apple-iPhone-14-Pro.jpg', 3)
INSERT [dbo].[Urun] ([Id], [Ad], [Aciklama], [Fiyat], [Stok], [Populer], [Resim], [KategoriId]) VALUES (10, N'Abra A5 V17.3 15,6', N'Bilgisayar Ürünleri', CAST(25000.00 AS Decimal(18, 2)), 40, 1, N'Abra_A5_v17_-_NH58_TR_-_rtx3050ti_medium.png', 1)
INSERT [dbo].[Urun] ([Id], [Ad], [Aciklama], [Fiyat], [Stok], [Populer], [Resim], [KategoriId]) VALUES (11, N'Samsung Galaxy Tab A8', N'Tablet Ürünleri', CAST(3700.00 AS Decimal(18, 2)), 150, 0, N'61fE7Z9Lb2L.jpg', 4)
SET IDENTITY_INSERT [dbo].[Urun] OFF
GO
ALTER TABLE [dbo].[Satislar]  WITH CHECK ADD  CONSTRAINT [FK_Satislar_Kullanici] FOREIGN KEY([KullaniciId])
REFERENCES [dbo].[Kullanici] ([Id])
GO
ALTER TABLE [dbo].[Satislar] CHECK CONSTRAINT [FK_Satislar_Kullanici]
GO
ALTER TABLE [dbo].[Satislar]  WITH CHECK ADD  CONSTRAINT [FK_Satislar_Urun] FOREIGN KEY([UrunId])
REFERENCES [dbo].[Urun] ([Id])
GO
ALTER TABLE [dbo].[Satislar] CHECK CONSTRAINT [FK_Satislar_Urun]
GO
ALTER TABLE [dbo].[Sepet]  WITH CHECK ADD  CONSTRAINT [FK_Sepet_Kullanici] FOREIGN KEY([KullaniciId])
REFERENCES [dbo].[Kullanici] ([Id])
GO
ALTER TABLE [dbo].[Sepet] CHECK CONSTRAINT [FK_Sepet_Kullanici]
GO
ALTER TABLE [dbo].[Sepet]  WITH CHECK ADD  CONSTRAINT [FK_Sepet_Urun] FOREIGN KEY([UrunId])
REFERENCES [dbo].[Urun] ([Id])
GO
ALTER TABLE [dbo].[Sepet] CHECK CONSTRAINT [FK_Sepet_Urun]
GO
ALTER TABLE [dbo].[Urun]  WITH CHECK ADD  CONSTRAINT [FK_Urun_Kategori] FOREIGN KEY([KategoriId])
REFERENCES [dbo].[Kategori] ([Id])
GO
ALTER TABLE [dbo].[Urun] CHECK CONSTRAINT [FK_Urun_Kategori]
GO
USE [master]
GO
ALTER DATABASE [StokTakip] SET  READ_WRITE 
GO
