USE [master]
GO
/****** Object:  Database [Twitter]    Script Date: 11.12.2021 г. 2:00:48 ******/
CREATE DATABASE [Twitter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Twitter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Twitter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Twitter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Twitter_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Twitter] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Twitter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Twitter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Twitter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Twitter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Twitter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Twitter] SET ARITHABORT OFF 
GO
ALTER DATABASE [Twitter] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Twitter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Twitter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Twitter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Twitter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Twitter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Twitter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Twitter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Twitter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Twitter] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Twitter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Twitter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Twitter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Twitter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Twitter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Twitter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Twitter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Twitter] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Twitter] SET  MULTI_USER 
GO
ALTER DATABASE [Twitter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Twitter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Twitter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Twitter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Twitter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Twitter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Twitter] SET QUERY_STORE = OFF
GO
USE [Twitter]
GO
/****** Object:  Table [dbo].[BasicRoles]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BasicRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookmarks]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookmarks](
	[user_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[added_at] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Communities]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Communities](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](160) NULL,
	[admin_id] [int] NOT NULL,
	[created_on] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommunitiesUsers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommunitiesUsers](
	[community_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimAuthor]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAuthor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NOT NULL,
	[username] [varchar](15) NOT NULL,
	[display_name] [varchar](50) NOT NULL,
	[date_of_birth] [datetime] NOT NULL,
	[gender] [varchar](10) NULL,
	[country] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBirthDate]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBirthDate](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[calendar_year] [int] NOT NULL,
	[calendar_quarter] [int] NOT NULL,
	[month_of_year] [int] NOT NULL,
	[month_name] [nvarchar](10) NOT NULL,
	[day_of_month] [int] NOT NULL,
	[day_of_week] [int] NOT NULL,
	[day_name] [nvarchar](15) NOT NULL,
	[age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCountry]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCountry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimGender]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimGender](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimLastSignIn]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimLastSignIn](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[calendar_year] [int] NOT NULL,
	[calendar_quarter] [int] NOT NULL,
	[month_of_year] [int] NOT NULL,
	[month_name] [nvarchar](10) NOT NULL,
	[day_of_month] [int] NOT NULL,
	[day_of_week] [int] NOT NULL,
	[day_name] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimMessage]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMessage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[message] [varchar](280) NOT NULL,
	[language] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSignUp]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSignUp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[calendar_year] [int] NOT NULL,
	[calendar_quarter] [int] NOT NULL,
	[month_of_year] [int] NOT NULL,
	[month_name] [nvarchar](10) NOT NULL,
	[day_of_month] [int] NOT NULL,
	[day_of_week] [int] NOT NULL,
	[day_name] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSource]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NULL,
	[name] [varchar](50) NULL,
	[references_count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTime]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTime](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[calendar_year] [int] NOT NULL,
	[calendar_quarter] [int] NOT NULL,
	[month_of_year] [int] NOT NULL,
	[month_name] [nvarchar](10) NOT NULL,
	[day_of_month] [int] NOT NULL,
	[day_of_week] [int] NOT NULL,
	[day_name] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTopic]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTopic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NULL,
	[name] [varchar](30) NULL,
	[references_count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectMessages]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectMessages](
	[sender_id] [int] NOT NULL,
	[receiver_id] [int] NOT NULL,
	[message] [varchar](8000) NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactStatuses]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactStatuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[author_id] [int] NOT NULL,
	[message_id] [int] NOT NULL,
	[topic_id] [int] NULL,
	[source_id] [int] NULL,
	[time_id] [int] NULL,
	[impressions_count] [int] NOT NULL,
	[likes_count] [int] NOT NULL,
	[retweets_count] [int] NOT NULL,
	[quote_tweets_count] [int] NOT NULL,
	[replies_count] [int] NOT NULL,
	[lists_count] [int] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[operation] [char](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactUsers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alt_id] [int] NOT NULL,
	[country_id] [int] NOT NULL,
	[gender_id] [int] NULL,
	[sign_up_id] [int] NULL,
	[last_sign_in_id] [int] NULL,
	[birth_date_id] [int] NULL,
	[followers_count] [int] NOT NULL,
	[following_count] [int] NOT NULL,
	[bookmarks_count] [int] NOT NULL,
	[lists_count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[user_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lists]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lists](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[owner_id] [int] NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](160) NULL,
	[is_private] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListsStatuses]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListsStatuses](
	[list_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[added_at] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListsUsers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListsUsers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[list_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Retweets]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Retweets](
	[user_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sources]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sources](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Spaces]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spaces](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[host_id] [int] NOT NULL,
	[start_time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpacesRoles]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpacesRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpacesUsers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpacesUsers](
	[space_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[author_id] [int] NOT NULL,
	[message] [varchar](280) NOT NULL,
	[source_id] [int] NULL,
	[topic_id] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[community_id] [int] NULL,
	[quoted_status_id] [int] NULL,
	[replied_status_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topics]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TopicsFollowers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicsFollowers](
	[topic_id] [int] NOT NULL,
	[user_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](15) NOT NULL,
	[display_name] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[date_of_birth] [date] NOT NULL,
	[email] [varchar](100) NULL,
	[phone] [int] NULL,
	[gender_id] [int] NULL,
	[country_id] [int] NULL,
	[is_protected] [bit] NOT NULL,
	[bio] [varchar](160) NULL,
	[website] [varchar](100) NULL,
	[sign_up] [date] NOT NULL,
	[last_sign_in] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersFollowers]    Script Date: 11.12.2021 г. 2:00:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersFollowers](
	[follower_id] [int] NOT NULL,
	[followee_id] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BasicRoles] ON 

INSERT [dbo].[BasicRoles] ([id], [name]) VALUES (1, N'Member')
INSERT [dbo].[BasicRoles] ([id], [name]) VALUES (2, N'Moderator')
SET IDENTITY_INSERT [dbo].[BasicRoles] OFF
GO
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (3, 6, CAST(N'2021-11-28T00:32:15.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (3, 7, CAST(N'2021-10-02T23:36:10.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (4, 8, CAST(N'2020-06-27T16:07:20.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (4, 13, CAST(N'2021-06-29T04:38:22.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (5, 2, CAST(N'2021-05-30T16:02:29.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (5, 4, CAST(N'2017-07-11T03:22:01.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (5, 7, CAST(N'2016-09-20T13:00:04.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (7, 11, CAST(N'2021-10-12T12:04:18.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (7, 6, CAST(N'2014-06-29T13:10:46.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (7, 8, CAST(N'2020-07-19T00:59:10.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (8, 2, CAST(N'2021-02-28T00:05:58.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (8, 5, CAST(N'2020-06-14T17:36:33.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (9, 6, CAST(N'2018-02-20T06:48:52.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (12, 7, CAST(N'2021-02-13T22:32:33.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (12, 14, CAST(N'2019-12-22T04:07:00.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (13, 2, CAST(N'2021-06-10T22:30:07.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (13, 4, CAST(N'2018-06-20T16:55:56.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (14, 4, CAST(N'2015-06-26T19:00:17.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (14, 13, CAST(N'2021-08-27T14:32:09.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (15, 7, CAST(N'2020-03-25T19:48:07.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (15, 8, CAST(N'2021-04-05T15:46:17.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (15, 9, CAST(N'2020-04-03T10:16:24.000' AS DateTime))
INSERT [dbo].[Bookmarks] ([user_id], [status_id], [added_at]) VALUES (15, 15, CAST(N'2017-12-23T08:09:28.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Communities] ON 

INSERT [dbo].[Communities] ([id], [name], [description], [admin_id], [created_on]) VALUES (1, N'Netflix and chill', N'Discusing Netflix series and movies', 2, CAST(N'2015-01-22' AS Date))
INSERT [dbo].[Communities] ([id], [name], [description], [admin_id], [created_on]) VALUES (2, N'Football', N'The place for football fans', 6, CAST(N'2013-07-23' AS Date))
INSERT [dbo].[Communities] ([id], [name], [description], [admin_id], [created_on]) VALUES (3, N'Pokemon', N'Pokemon enthusiasts', 8, CAST(N'2018-07-13' AS Date))
INSERT [dbo].[Communities] ([id], [name], [description], [admin_id], [created_on]) VALUES (4, N'Chefs', N'Chefs only', 12, CAST(N'2019-07-03' AS Date))
SET IDENTITY_INSERT [dbo].[Communities] OFF
GO
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (1, 1, 2)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (1, 3, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (1, 4, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (2, 2, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (2, 7, 2)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (2, 8, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (2, 13, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (3, 12, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (3, 15, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (4, 5, 2)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (4, 13, 1)
INSERT [dbo].[CommunitiesUsers] ([community_id], [user_id], [role_id]) VALUES (4, 14, 1)
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([id], [name]) VALUES (1, N'Bulgaria')
INSERT [dbo].[Countries] ([id], [name]) VALUES (2, N'United States')
INSERT [dbo].[Countries] ([id], [name]) VALUES (3, N'Germany')
INSERT [dbo].[Countries] ([id], [name]) VALUES (4, N'Japan')
INSERT [dbo].[Countries] ([id], [name]) VALUES (5, N'United Kingdom')
INSERT [dbo].[Countries] ([id], [name]) VALUES (6, N'Spain')
INSERT [dbo].[Countries] ([id], [name]) VALUES (7, N'Brazil')
INSERT [dbo].[Countries] ([id], [name]) VALUES (8, N'France')
INSERT [dbo].[Countries] ([id], [name]) VALUES (9, N'China')
INSERT [dbo].[Countries] ([id], [name]) VALUES (10, N'Italy')
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (1, 2, N'There is no substitute for hard work.', CAST(N'2014-05-11T14:33:06.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (1, 7, N'What consumes your mind controls your life', CAST(N'2014-12-09T09:56:58.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (1, 7, N'Strive for greatness.', CAST(N'2018-06-20T09:39:56.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (2, 5, N'Wanting to be someone else is a waste of who you are.', CAST(N'2018-07-27T03:36:26.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (2, 9, N'And still, I rise.', CAST(N'2017-11-05T00:41:51.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (4, 5, N'The time is always right to do what is right.', CAST(N'2017-02-28T22:42:32.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (4, 5, N'Let the beauty of what you love be what you do.', CAST(N'2021-10-23T11:10:31.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (8, 4, N'May your choices reflect your hopes, not your fears.', CAST(N'2018-07-08T18:21:05.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (8, 5, N'A happy soul is the best shield for a cruel world.', CAST(N'2016-10-25T10:42:58.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (9, 8, N'White is not always light and black is not always dark.', CAST(N'2013-04-03T15:06:39.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (13, 11, N'Life becomes easier when you learn to accept the apology you never got.', CAST(N'2020-01-30T19:48:02.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (13, 12, N'Happiness depends upon ourselves.', CAST(N'2019-01-22T16:32:43.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (13, 14, N'Turn your wounds into wisdom.', CAST(N'2021-05-03T23:11:25.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 4, N'Change the game, don’t let the game change you.', CAST(N'2015-02-08T09:16:49.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 4, N'It hurt because it mattered.', CAST(N'2021-11-16T22:23:41.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 10, N'If the world was blind how many people would you impress?', CAST(N'2018-01-13T11:03:22.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 13, N'I will remember and recover, not forgive and forget.', CAST(N'2020-12-24T02:32:59.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 13, N'The meaning of life is to give life meaning.', CAST(N'2015-05-29T19:44:53.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (14, 13, N'The true meaning of life is to plant trees, under whose shade you do not expect to sit.', CAST(N'2021-05-12T03:39:40.000' AS DateTime))
INSERT [dbo].[DirectMessages] ([sender_id], [receiver_id], [message], [timestamp]) VALUES (15, 14, N'When words fail, music speaks.', CAST(N'2019-12-10T07:34:15.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Genders] ON 

INSERT [dbo].[Genders] ([id], [name]) VALUES (1, N'Male')
INSERT [dbo].[Genders] ([id], [name]) VALUES (2, N'Female')
INSERT [dbo].[Genders] ([id], [name]) VALUES (3, N'Custom')
SET IDENTITY_INSERT [dbo].[Genders] OFF
GO
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (1, 2, CAST(N'2021-07-06T15:35:24.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (1, 4, CAST(N'2014-05-20T20:32:37.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (1, 6, CAST(N'2020-03-29T16:16:15.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (1, 7, CAST(N'2016-09-29T08:07:26.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (2, 1, CAST(N'2021-08-27T22:48:56.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (2, 2, CAST(N'2021-05-30T15:54:47.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (2, 9, CAST(N'2018-03-27T20:30:02.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (2, 10, CAST(N'2019-04-07T18:51:51.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (3, 5, CAST(N'2021-07-21T05:27:18.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (3, 6, CAST(N'2016-01-01T16:25:06.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (3, 7, CAST(N'2021-04-16T10:22:25.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (4, 8, CAST(N'2018-11-18T20:16:02.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (4, 9, CAST(N'2017-08-03T23:07:45.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 2, CAST(N'2021-03-18T13:32:25.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 4, CAST(N'2014-10-17T06:17:14.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 7, CAST(N'2015-02-25T08:07:22.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 8, CAST(N'2019-11-27T03:42:55.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 9, CAST(N'2020-02-19T09:54:02.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (5, 10, CAST(N'2019-07-04T07:22:48.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (6, 5, CAST(N'2021-08-26T03:54:09.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (7, 1, CAST(N'2020-11-20T12:07:32.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (7, 6, CAST(N'2016-06-14T06:32:14.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (7, 8, CAST(N'2021-07-05T19:35:43.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (8, 2, CAST(N'2021-12-08T16:21:13.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (8, 5, CAST(N'2020-06-27T22:51:50.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (9, 6, CAST(N'2014-11-12T15:12:09.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (10, 1, CAST(N'2019-01-26T00:12:51.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (10, 7, CAST(N'2017-08-14T10:26:21.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (10, 9, CAST(N'2019-11-04T14:12:02.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (10, 13, CAST(N'2022-12-15T07:45:51.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (11, 6, CAST(N'2019-06-06T08:00:17.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (11, 7, CAST(N'2017-11-13T20:55:47.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (12, 1, CAST(N'2018-09-24T15:41:41.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (12, 4, CAST(N'2014-07-28T15:25:49.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (12, 7, CAST(N'2021-04-18T13:01:52.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (12, 9, CAST(N'2018-08-04T13:46:42.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (13, 2, CAST(N'2021-01-25T00:50:07.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (13, 4, CAST(N'2018-06-26T00:04:02.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (14, 15, CAST(N'2019-03-16T08:39:19.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (14, 6, CAST(N'2018-11-17T04:51:18.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (15, 7, CAST(N'2020-03-23T10:54:38.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (15, 8, CAST(N'2018-07-05T15:11:10.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (15, 9, CAST(N'2019-01-10T22:56:51.000' AS DateTime))
INSERT [dbo].[Likes] ([user_id], [status_id], [timestamp]) VALUES (15, 10, CAST(N'2020-12-02T22:37:17.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Lists] ON 

INSERT [dbo].[Lists] ([id], [owner_id], [name], [description], [is_private]) VALUES (1, 1, N'My List', N'My favourite tweets', 1)
INSERT [dbo].[Lists] ([id], [owner_id], [name], [description], [is_private]) VALUES (2, 4, N'Best Tweets', N'All the best tweets', 0)
INSERT [dbo].[Lists] ([id], [owner_id], [name], [description], [is_private]) VALUES (3, 5, N'Funny', N'Only funny tweets', 0)
INSERT [dbo].[Lists] ([id], [owner_id], [name], [description], [is_private]) VALUES (4, 9, N'Cool', N'Cool or nah', 0)
INSERT [dbo].[Lists] ([id], [owner_id], [name], [description], [is_private]) VALUES (5, 14, N'Yes', N'Yes', 0)
SET IDENTITY_INSERT [dbo].[Lists] OFF
GO
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (1, 1, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (1, 3, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (1, 4, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (1, 7, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (1, 8, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 1, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 2, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 3, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 4, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 7, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 9, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (2, 10, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 2, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 4, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 7, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 8, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 9, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (3, 10, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 1, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 4, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 5, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 6, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 7, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (4, 10, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 2, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 3, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 5, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 6, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 8, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
INSERT [dbo].[ListsStatuses] ([list_id], [status_id], [added_at]) VALUES (5, 9, CAST(N'2021-12-10T22:19:15.270' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ListsUsers] ON 

INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (1, 2, 1, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (2, 4, 1, 2)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (3, 3, 2, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (4, 9, 2, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (5, 11, 2, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (6, 14, 3, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (7, 6, 4, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (8, 10, 4, 2)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (9, 6, 5, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (10, 9, 5, 1)
INSERT [dbo].[ListsUsers] ([id], [user_id], [list_id], [role_id]) VALUES (11, 12, 5, 2)
SET IDENTITY_INSERT [dbo].[ListsUsers] OFF
GO
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (1, 2, CAST(N'2021-11-09T07:02:59.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (1, 7, CAST(N'2017-01-19T07:04:51.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (2, 1, CAST(N'2020-07-20T21:49:24.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (2, 2, CAST(N'2021-02-26T00:50:45.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (2, 9, CAST(N'2019-11-13T08:16:05.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (4, 9, CAST(N'2018-03-14T06:46:17.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 2, CAST(N'2021-01-26T23:38:37.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 4, CAST(N'2018-11-18T10:07:26.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 7, CAST(N'2021-04-19T17:08:01.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 8, CAST(N'2019-07-05T01:45:16.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 9, CAST(N'2021-10-25T22:55:24.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (5, 10, CAST(N'2019-12-04T10:28:44.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (6, 5, CAST(N'2021-04-03T06:07:20.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (7, 1, CAST(N'2021-12-07T20:41:13.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (7, 6, CAST(N'2019-07-16T06:58:16.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (7, 8, CAST(N'2021-09-04T06:05:56.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (9, 6, CAST(N'2020-11-20T21:44:26.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (10, 1, CAST(N'2020-06-06T00:00:19.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (10, 7, CAST(N'2019-11-22T20:27:22.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (10, 12, CAST(N'2021-09-16T11:58:14.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (10, 3, CAST(N'2019-11-27T00:27:58.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (11, 6, CAST(N'2019-10-15T00:03:04.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (11, 7, CAST(N'2016-07-15T01:31:10.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (12, 11, CAST(N'2024-02-27T05:07:38.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (12, 4, CAST(N'2019-02-25T03:46:36.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (12, 7, CAST(N'2019-09-26T09:11:52.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (12, 9, CAST(N'2017-06-11T20:33:12.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (13, 2, CAST(N'2021-08-03T13:39:56.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (15, 8, CAST(N'2021-08-08T14:21:22.000' AS DateTime))
INSERT [dbo].[Retweets] ([user_id], [status_id], [timestamp]) VALUES (15, 9, CAST(N'2021-10-07T08:29:40.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Sources] ON 

INSERT [dbo].[Sources] ([id], [name]) VALUES (2, N'Twitter for Android')
INSERT [dbo].[Sources] ([id], [name]) VALUES (3, N'Twitter for iPhone')
INSERT [dbo].[Sources] ([id], [name]) VALUES (1, N'Twitter Web App')
SET IDENTITY_INSERT [dbo].[Sources] OFF
GO
SET IDENTITY_INSERT [dbo].[Spaces] ON 

INSERT [dbo].[Spaces] ([id], [name], [host_id], [start_time]) VALUES (1, N'Let''s talk about Music', 1, CAST(N'2020-03-05T04:59:12.000' AS DateTime))
INSERT [dbo].[Spaces] ([id], [name], [host_id], [start_time]) VALUES (2, N'Come and chill', 5, CAST(N'2020-09-21T16:09:47.000' AS DateTime))
INSERT [dbo].[Spaces] ([id], [name], [host_id], [start_time]) VALUES (3, N'Favourite movies of 2021', 10, CAST(N'2016-01-02T19:32:50.000' AS DateTime))
INSERT [dbo].[Spaces] ([id], [name], [host_id], [start_time]) VALUES (4, N'Superbowl', 15, CAST(N'2020-05-08T07:07:19.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Spaces] OFF
GO
SET IDENTITY_INSERT [dbo].[SpacesRoles] ON 

INSERT [dbo].[SpacesRoles] ([id], [name]) VALUES (1, N'Listener')
INSERT [dbo].[SpacesRoles] ([id], [name]) VALUES (2, N'Speaker')
INSERT [dbo].[SpacesRoles] ([id], [name]) VALUES (3, N'Co-Host')
SET IDENTITY_INSERT [dbo].[SpacesRoles] OFF
GO
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (1, 2, 3)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (1, 3, 1)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (1, 4, 1)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (2, 6, 2)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (2, 7, 2)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (3, 8, 1)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (3, 9, 1)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (3, 11, 3)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (4, 12, 2)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (4, 13, 1)
INSERT [dbo].[SpacesUsers] ([space_id], [user_id], [role_id]) VALUES (4, 14, 2)
GO
SET IDENTITY_INSERT [dbo].[Statuses] ON 

INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (1, 1, N'This is my first tweet!', 1, 7, CAST(N'2018-07-28T06:03:42.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (2, 1, N'What do you prefer - cats or dogs?', 1, 9, CAST(N'2020-12-11T08:47:53.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (3, 4, N'Any mutuals wanna hang out?', 2, 4, CAST(N'2018-08-02T17:28:45.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (4, 4, N'This might be an unpopular opinion, but I like eating pineapple pizza', 2, 11, CAST(N'2014-05-09T00:37:51.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (5, 4, N'Have an exam in 30 mins, wish me luck!!!', 3, 8, CAST(N'2020-04-17T21:46:58.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (6, 6, N'When nothing goes right, go left.', 2, 3, CAST(N'2014-04-30T05:08:54.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (7, 6, N'Take the risk or lose the chance.', 1, 5, CAST(N'2014-11-19T00:22:25.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (8, 8, N'The past does not equal the future.', 2, 3, CAST(N'2018-06-06T02:27:30.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (9, 10, N'Dream without fear. Love without limits.', 3, 1, CAST(N'2017-02-28T12:03:56.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (10, 14, N'If you’re going through hell, keep going.', 2, 2, CAST(N'2019-03-31T19:41:50.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (11, 1, N'Tough times never last but tough people do.', 1, NULL, CAST(N'2021-10-04T09:13:40.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (12, 2, N'Problems are not stop signs, they are guidelines.', 3, NULL, CAST(N'2019-09-18T06:11:39.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (13, 2, N'One day the people that don’t even believe in you will tell everyone how they met you. – Johnny Depp', 2, NULL, CAST(N'2020-12-11T11:13:17.000' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (14, 3, N'If I’m gonna tell a real story, I’m gonna start with my name.', 2, NULL, CAST(N'2014-05-09T01:01:09.000' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (15, 3, N'If you tell the truth you don’t have to remember anything.', 2, NULL, CAST(N'2016-07-31T08:33:37.000' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (16, 5, N'Have enough courage to start and enough heart to finish.', 2, NULL, CAST(N'2014-09-04T15:16:08.000' AS DateTime), NULL, NULL, 4)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (17, 6, N'Hate comes from intimidation, love comes from appreciation.', 2, NULL, CAST(N'2021-05-09T03:35:48.000' AS DateTime), NULL, NULL, 7)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (18, 7, N'I could agree with you but then we’d both be wrong.', 3, NULL, CAST(N'2021-09-20T01:35:57.000' AS DateTime), NULL, NULL, 10)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (19, 11, N'Oh, the things you can find, if you don’t stay behind.', 2, NULL, CAST(N'2020-02-07T00:35:17.000' AS DateTime), NULL, NULL, 9)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (20, 12, N'Determine your priorities and focus on them.', 1, NULL, CAST(N'2021-01-12T04:14:12.000' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (21, 3, N'Change the world by being yourself.', 3, NULL, CAST(N'2019-01-20T02:43:07.000' AS DateTime), NULL, 3, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (22, 4, N'Every moment is a fresh beginning.', 1, NULL, CAST(N'2020-10-28T06:16:37.000' AS DateTime), NULL, 12, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (23, 7, N'Never regret anything that made you smile.', 2, NULL, CAST(N'2019-07-06T21:06:03.000' AS DateTime), NULL, 15, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (24, 7, N'Die with memories, not dreams.', 2, NULL, CAST(N'2015-07-08T01:12:13.000' AS DateTime), NULL, 14, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (25, 8, N'Aspire to inspire before we expire.', 2, NULL, CAST(N'2021-05-19T03:16:30.000' AS DateTime), NULL, 8, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (26, 8, N'Everything you can imagine is real.', 3, NULL, CAST(N'2021-06-14T13:38:08.000' AS DateTime), NULL, 4, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (27, 10, N'Simplicity is the ultimate sophistication.', 2, NULL, CAST(N'2021-07-04T17:36:46.000' AS DateTime), NULL, 13, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (28, 10, N'Whatever you do, do it well.', 2, NULL, CAST(N'2021-12-05T14:29:55.000' AS DateTime), NULL, 11, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (29, 13, N'What we think, we become.', 2, NULL, CAST(N'2020-07-03T07:57:22.000' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (30, 15, N'All limitations are self-imposed.', 3, NULL, CAST(N'2016-08-20T03:16:36.000' AS DateTime), NULL, 16, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (31, 2, N'Be so good they can’t ignore you.', 2, NULL, CAST(N'2018-03-19T23:19:00.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (32, 3, N'Dream as if you’ll live forever, live as if you’ll die today.', 1, NULL, CAST(N'2017-07-29T09:46:52.000' AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (33, 6, N'Yesterday you said tomorrow. Just do it.', 2, NULL, CAST(N'2019-03-13T01:55:23.000' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (34, 2, N'I don’t need it to be easy, I need it to be worth it.', 1, NULL, CAST(N'2016-04-01T18:35:35.000' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (35, 13, N'Never let your emotions overpower your intelligence.', 3, NULL, CAST(N'2015-06-06T11:02:02.000' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (36, 12, N'Nothing lasts forever but at least we got these memories.', 3, NULL, CAST(N'2020-12-08T13:27:51.000' AS DateTime), 3, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (37, 15, N'Don’t you know your imperfections is a blessing?', 3, NULL, CAST(N'2018-12-07T05:04:28.000' AS DateTime), 3, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (38, 8, N'Reality is wrong, dreams are for real.', 1, NULL, CAST(N'2021-03-17T23:30:25.000' AS DateTime), 3, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (39, 13, N'To live will be an awfully big adventure.', 2, NULL, CAST(N'2021-05-27T17:25:13.000' AS DateTime), 4, NULL, NULL)
INSERT [dbo].[Statuses] ([id], [author_id], [message], [source_id], [topic_id], [created_at], [community_id], [quoted_status_id], [replied_status_id]) VALUES (40, 14, N'Try to be a rainbow in someone’s cloud.', 1, NULL, CAST(N'2021-12-09T19:46:52.000' AS DateTime), 4, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Statuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([id], [name]) VALUES (9, N'Animals')
INSERT [dbo].[Topics] ([id], [name]) VALUES (7, N'Anime')
INSERT [dbo].[Topics] ([id], [name]) VALUES (5, N'corona')
INSERT [dbo].[Topics] ([id], [name]) VALUES (11, N'food')
INSERT [dbo].[Topics] ([id], [name]) VALUES (3, N'Football')
INSERT [dbo].[Topics] ([id], [name]) VALUES (10, N'Freddie Mercury')
INSERT [dbo].[Topics] ([id], [name]) VALUES (4, N'justin bieber')
INSERT [dbo].[Topics] ([id], [name]) VALUES (2, N'minecraft')
INSERT [dbo].[Topics] ([id], [name]) VALUES (6, N'nature')
INSERT [dbo].[Topics] ([id], [name]) VALUES (1, N'photography')
INSERT [dbo].[Topics] ([id], [name]) VALUES (8, N'Spotify')
SET IDENTITY_INSERT [dbo].[Topics] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (1, N'mitko', N'mitko123', N'mitko123', CAST(N'1964-08-13' AS Date), NULL, NULL, 1, 6, 0, N'My name is Mitko', NULL, CAST(N'2012-10-15' AS Date), CAST(N'2021-12-08' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (2, N'elena', N'elena321', N'elena321', CAST(N'1982-02-23' AS Date), NULL, NULL, 2, 3, 0, N'My name is Elena', NULL, CAST(N'2014-11-08' AS Date), CAST(N'2021-12-03' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (3, N'ali', N'aliraza', N'ali0', CAST(N'1987-08-09' AS Date), NULL, NULL, 3, 5, 0, N'I like action movies!', NULL, CAST(N'2014-08-28' AS Date), CAST(N'2021-12-02' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (4, N'elon_musk', N'Elon Musk', N'tesla420', CAST(N'1965-02-21' AS Date), NULL, NULL, 1, 10, 0, N'Now is the best time to invest in Doge coin!', NULL, CAST(N'2014-05-09' AS Date), CAST(N'2021-12-03' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (5, N'joe_biden', N'Joe Biden', N'usa', CAST(N'1952-11-03' AS Date), NULL, NULL, 1, 9, 0, N'President of The United States of America', NULL, CAST(N'2011-10-04' AS Date), CAST(N'2021-12-04' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (6, N'bob', N'bob101', N'bob bobobov', CAST(N'1957-08-03' AS Date), NULL, NULL, 1, 6, 1, N'Bob', NULL, CAST(N'2011-11-30' AS Date), CAST(N'2021-12-09' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (7, N'Jack_op', N'adssad8989', N'adadasd999', CAST(N'1974-12-01' AS Date), NULL, NULL, 2, 3, 0, N'Yo, my name is Jack and I love fishing.', NULL, CAST(N'2018-08-29' AS Date), CAST(N'2021-12-09' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (8, N'Mia', N'Mia - Japan', N'tokyo100', CAST(N'1996-11-01' AS Date), NULL, NULL, 2, 4, 0, N'Greetings from Japan!', NULL, CAST(N'2016-08-07' AS Date), CAST(N'2021-12-06' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (9, N'Sali', N'Barbie girl', N'elena321', CAST(N'1969-12-25' AS Date), NULL, NULL, 2, 3, 0, N'hello hello hello', NULL, CAST(N'2010-07-25' AS Date), CAST(N'2021-12-04' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (10, N'Maria', N'Maria Natasha', N'opaoda00', CAST(N'1974-12-02' AS Date), NULL, NULL, 2, 1, 1, N'My name is Elena', NULL, CAST(N'2013-01-17' AS Date), CAST(N'2021-12-04' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (11, N'nikiathome', N'Just some guy', N'323sdasda', CAST(N'1973-01-31' AS Date), NULL, NULL, 1, 5, 0, N'Just some guy', NULL, CAST(N'2011-12-16' AS Date), CAST(N'2021-12-03' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (12, N'Austin', N'Asutin', N'aust456', CAST(N'1988-01-24' AS Date), NULL, NULL, 1, 6, 0, N'I make videos where I play games', NULL, CAST(N'2013-09-04' AS Date), CAST(N'2021-12-01' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (13, N'Hasan01', N'Hasan', N'opaoda00', CAST(N'1963-03-06' AS Date), NULL, NULL, 1, 7, 1, N'My name is Hasan', NULL, CAST(N'2018-07-06' AS Date), CAST(N'2021-12-04' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (14, N'steve', N'Steve Jobs', N'apple134', CAST(N'2004-08-05' AS Date), NULL, NULL, 1, 8, 1, N'My name is Steve', NULL, CAST(N'2013-07-29' AS Date), CAST(N'2021-12-04' AS Date))
INSERT [dbo].[Users] ([id], [username], [display_name], [password], [date_of_birth], [email], [phone], [gender_id], [country_id], [is_protected], [bio], [website], [sign_up], [last_sign_in]) VALUES (15, N'jake_0', N'Jake', N'00jake', CAST(N'1983-10-18' AS Date), NULL, NULL, 1, 2, 0, N'My name is Jake', NULL, CAST(N'2011-01-09' AS Date), CAST(N'2021-12-07' AS Date))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (1, 2, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (1, 3, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (1, 7, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (1, 9, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (2, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (2, 3, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (2, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (2, 9, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (3, 2, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (3, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (4, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (4, 4, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (4, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (4, 6, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (4, 7, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (5, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (5, 2, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (6, 8, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (6, 10, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (7, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (7, 10, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (8, 4, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (8, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (9, 7, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (9, 8, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (10, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (10, 2, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (10, 4, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (11, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (11, 6, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (11, 7, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (11, 8, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (11, 9, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (12, 10, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (12, 9, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (13, 11, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (13, 12, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (13, 14, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 1, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 2, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 3, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 4, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 5, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 8, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 10, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (14, 13, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
INSERT [dbo].[UsersFollowers] ([follower_id], [followee_id], [timestamp]) VALUES (15, 14, CAST(N'2021-12-10T22:19:15.260' AS DateTime))
GO
/****** Object:  Index [uq_Bookmarks]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [uq_Bookmarks] ON [dbo].[Bookmarks]
(
	[user_id] ASC,
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uq_Likes]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [uq_Likes] ON [dbo].[Likes]
(
	[user_id] ASC,
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uq_Retweets]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [uq_Retweets] ON [dbo].[Retweets]
(
	[user_id] ASC,
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Sources__72E12F1BB65A5C24]    Script Date: 11.12.2021 г. 2:00:49 ******/
ALTER TABLE [dbo].[Sources] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Topics__72E12F1BF246CE26]    Script Date: 11.12.2021 г. 2:00:49 ******/
ALTER TABLE [dbo].[Topics] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uq_TopicsFollowers]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [uq_TopicsFollowers] ON [dbo].[TopicsFollowers]
(
	[topic_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572648EDDB2]    Script Date: 11.12.2021 г. 2:00:49 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unique_email]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_email] ON [dbo].[Users]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [unique_phone]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_phone] ON [dbo].[Users]
(
	[phone] ASC
)
WHERE ([phone] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uq_UsersFollowers]    Script Date: 11.12.2021 г. 2:00:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [uq_UsersFollowers] ON [dbo].[UsersFollowers]
(
	[follower_id] ASC,
	[followee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[Statuses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Communities]  WITH CHECK ADD FOREIGN KEY([admin_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommunitiesUsers]  WITH CHECK ADD FOREIGN KEY([community_id])
REFERENCES [dbo].[Communities] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommunitiesUsers]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[BasicRoles] ([id])
GO
ALTER TABLE [dbo].[CommunitiesUsers]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[DimAuthor]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[DimCountry]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Countries] ([id])
GO
ALTER TABLE [dbo].[DimGender]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Genders] ([id])
GO
ALTER TABLE [dbo].[DimSource]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Sources] ([id])
GO
ALTER TABLE [dbo].[DimTopic]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Topics] ([id])
GO
ALTER TABLE [dbo].[DirectMessages]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[DirectMessages]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactStatuses]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[DimAuthor] ([id])
GO
ALTER TABLE [dbo].[FactStatuses]  WITH CHECK ADD FOREIGN KEY([message_id])
REFERENCES [dbo].[DimMessage] ([id])
GO
ALTER TABLE [dbo].[FactStatuses]  WITH CHECK ADD FOREIGN KEY([source_id])
REFERENCES [dbo].[DimSource] ([id])
GO
ALTER TABLE [dbo].[FactStatuses]  WITH CHECK ADD FOREIGN KEY([time_id])
REFERENCES [dbo].[DimTime] ([id])
GO
ALTER TABLE [dbo].[FactStatuses]  WITH CHECK ADD FOREIGN KEY([topic_id])
REFERENCES [dbo].[DimTopic] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([alt_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([birth_date_id])
REFERENCES [dbo].[DimBirthDate] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[DimCountry] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([gender_id])
REFERENCES [dbo].[DimGender] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([last_sign_in_id])
REFERENCES [dbo].[DimLastSignIn] ([id])
GO
ALTER TABLE [dbo].[FactUsers]  WITH CHECK ADD FOREIGN KEY([sign_up_id])
REFERENCES [dbo].[DimSignUp] ([id])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[Statuses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Lists]  WITH CHECK ADD FOREIGN KEY([owner_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[ListsStatuses]  WITH CHECK ADD FOREIGN KEY([list_id])
REFERENCES [dbo].[Lists] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ListsStatuses]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[Statuses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ListsUsers]  WITH CHECK ADD FOREIGN KEY([list_id])
REFERENCES [dbo].[Lists] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ListsUsers]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[BasicRoles] ([id])
GO
ALTER TABLE [dbo].[ListsUsers]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Retweets]  WITH CHECK ADD FOREIGN KEY([status_id])
REFERENCES [dbo].[Statuses] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Retweets]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Spaces]  WITH CHECK ADD FOREIGN KEY([host_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SpacesUsers]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[SpacesRoles] ([id])
GO
ALTER TABLE [dbo].[SpacesUsers]  WITH CHECK ADD FOREIGN KEY([space_id])
REFERENCES [dbo].[Spaces] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SpacesUsers]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([author_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([community_id])
REFERENCES [dbo].[Communities] ([id])
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([quoted_status_id])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([replied_status_id])
REFERENCES [dbo].[Statuses] ([id])
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([source_id])
REFERENCES [dbo].[Sources] ([id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Statuses]  WITH CHECK ADD FOREIGN KEY([topic_id])
REFERENCES [dbo].[Topics] ([id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TopicsFollowers]  WITH CHECK ADD FOREIGN KEY([topic_id])
REFERENCES [dbo].[Topics] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TopicsFollowers]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[Countries] ([id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([gender_id])
REFERENCES [dbo].[Genders] ([id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[UsersFollowers]  WITH CHECK ADD FOREIGN KEY([follower_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[UsersFollowers]  WITH CHECK ADD FOREIGN KEY([followee_id])
REFERENCES [dbo].[Users] ([id])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[getCommunitiesByUsers]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getCommunitiesByUsers]
as
begin
	set nocount on
	select c.name as 'Community', count(cu.user_id) + 1  as 'Number of Members'
	from CommunitiesUsers cu join Communities c on c.id = cu.community_id
	group by c.name
	order by 'Number of Members' desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getListsByEntries]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getListsByEntries]
as
begin
	set nocount on
	set nocount on
	select l.name as 'List', count(ls.status_id) + 1  as 'Number of Entries'
	from ListsStatuses ls join Lists l on l.id = ls.list_id
	group by l.name
	order by 'Number of Entries' desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getTop5MostLikedTweets]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getTop5MostLikedTweets]
as
begin
	set nocount on
	select top 5 s.message as Tweet, count(l.status_id) as Likes, u.display_name as Author, s.created_at as 'Tweeted at'
	from Statuses s join Users u on s.author_id = u.id
	join Likes l on l.status_id = s.id
	group by s.message, u.display_name, s.created_at
	order by Likes desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getTop5MostRetweetedTweets]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getTop5MostRetweetedTweets]
as
begin
	set nocount on
	select top 5 s.message as Tweet, count(r.status_id) as Retweets, s.created_at as 'Tweeted at'
	from Retweets r join Statuses s on s.id = r.status_id
	group by s.message, s.created_at
	order by Retweets desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getTop5UsersWithMostTweets]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getTop5UsersWithMostTweets]
as
begin
	set nocount on
	select top(5) u.display_name as 'User', u.username as Hashtag, count(s.id) as 'Number of Tweets'
	from Statuses s join Users u on s.author_id = u.id
	group by u.display_name, u.username
	order by 'Number of Tweets' desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getUsersCountriesRatio]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getUsersCountriesRatio]
as
begin
	set nocount on
	select c.name as Country, count(u.country_id) as Users
	from Users u join Countries c on c.id = u.country_id
	group by c.name
	order by Users desc
end;

GO
/****** Object:  StoredProcedure [dbo].[getUsersFollowingAndFollowers]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* procedures */
create procedure [dbo].[getUsersFollowingAndFollowers]
as
begin
	set nocount on
	select u.display_name as [User], u.username as Hashtag,
		(
          select count(*)
          from UsersFollowers f
          where f.follower_id = u.id
		) as [Following],
		(
          select count(*)
          from UsersFollowers f
          where f.followee_id = u.id
		) as Followers
	from Users u
end

GO
/****** Object:  StoredProcedure [dbo].[getUsersGendersRatio]    Script Date: 11.12.2021 г. 2:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getUsersGendersRatio]
as
begin
	set nocount on
	select g.name as Gender, count(u.gender_id) as Users
	from Users u join Genders g on g.id = u.gender_id
	group by g.name
	order by Users desc
end;

GO
USE [master]
GO
ALTER DATABASE [Twitter] SET  READ_WRITE 
GO
