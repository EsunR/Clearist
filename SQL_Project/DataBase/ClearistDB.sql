USE [master]
GO
/****** Object:  Database [Clearist]    Script Date: 2018/6/17 14:41:14 ******/
CREATE DATABASE [Clearist]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sales_dat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Clearist_Realease_Version.mdf' , SIZE = 10240KB , MAXSIZE = 51200KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'Sales_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Clearist_Realease_Version.ldf' , SIZE = 5120KB , MAXSIZE = 25600KB , FILEGROWTH = 5120KB )
GO
ALTER DATABASE [Clearist] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Clearist].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Clearist] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Clearist] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Clearist] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Clearist] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Clearist] SET ARITHABORT OFF 
GO
ALTER DATABASE [Clearist] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Clearist] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Clearist] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Clearist] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Clearist] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Clearist] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Clearist] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Clearist] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Clearist] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Clearist] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Clearist] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Clearist] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Clearist] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Clearist] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Clearist] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Clearist] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Clearist] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Clearist] SET RECOVERY FULL 
GO
ALTER DATABASE [Clearist] SET  MULTI_USER 
GO
ALTER DATABASE [Clearist] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Clearist] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Clearist] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Clearist] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Clearist] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Clearist', N'ON'
GO
ALTER DATABASE [Clearist] SET QUERY_STORE = OFF
GO
USE [Clearist]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Clearist]
GO
/****** Object:  Table [dbo].[account]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[id] [varchar](50) NOT NULL,
	[psw] [varchar](50) NOT NULL,
	[uid] [int] IDENTITY(1000,1) NOT NULL,
 CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mission]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mission](
	[uid] [int] NOT NULL,
	[mission] [nvarchar](50) NOT NULL,
	[start_time] [smalldatetime] NOT NULL,
	[time_consuming] [time](7) NULL,
	[complete_time] [smalldatetime] NULL,
	[note] [nvarchar](max) NULL,
	[mark] [int] NOT NULL,
	[mission_id] [int] IDENTITY(1000,1) NOT NULL,
 CONSTRAINT [PK_mission] PRIMARY KEY CLUSTERED 
(
	[mission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subtasks]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subtasks](
	[mission_id] [int] NULL,
	[subtasks] [nvarchar](50) NULL,
	[subtasks_id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([id], [psw], [uid]) VALUES (N'Test', N'123456', 1000)
SET IDENTITY_INSERT [dbo].[account] OFF
SET IDENTITY_INSERT [dbo].[mission] ON 

INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'对项目进行最后的更改', CAST(N'2018-06-17T14:26:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'主要解决无法连接数据库的问题', 1, 1000)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'上传最终版本的源码到Github', CAST(N'2018-06-17T14:27:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'注意填写说明文档', 1, 1001)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'撰写数据库大作业报告', CAST(N'2018-06-17T14:28:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 1, 1002)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'买明天要用到的东西', CAST(N'2018-06-17T14:30:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 1, 1003)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已删除的任务1', CAST(N'2018-06-17T14:30:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 2, 1004)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已删除的任务2', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 2, 1005)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已删除的任务3', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 2, 1006)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已删除的任务4', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 2, 1007)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已删除的任务5', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 2, 1008)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已完成的任务1', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 0, 1009)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已完成的任务2', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 0, 1010)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已完成的任务3', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 0, 1011)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已完成的任务4', CAST(N'2018-06-17T14:31:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 0, 1012)
INSERT [dbo].[mission] ([uid], [mission], [start_time], [time_consuming], [complete_time], [note], [mark], [mission_id]) VALUES (1000, N'已完成的任务5', CAST(N'2018-06-17T14:32:00' AS SmallDateTime), CAST(N'00:00:00' AS Time), NULL, N'', 0, 1013)
SET IDENTITY_INSERT [dbo].[mission] OFF
SET IDENTITY_INSERT [dbo].[subtasks] ON 

INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'如何生成数据库脚本', 1)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'如何读取数据库脚本', 2)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'对子任务的建立进行测试', 3)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'子任务1', 4)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'子任务2', 5)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1000, N'子任务3', 6)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1003, N'胶水', 7)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1003, N'双面胶', 8)
INSERT [dbo].[subtasks] ([mission_id], [subtasks], [subtasks_id]) VALUES (1003, N'笔', 9)
SET IDENTITY_INSERT [dbo].[subtasks] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [un_id]    Script Date: 2018/6/17 14:41:15 ******/
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [un_id] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mission] ADD  CONSTRAINT [defalut_start_time]  DEFAULT (getdate()) FOR [start_time]
GO
ALTER TABLE [dbo].[mission] ADD  CONSTRAINT [defalut_time_consuming]  DEFAULT ('00:00:00') FOR [time_consuming]
GO
ALTER TABLE [dbo].[mission] ADD  CONSTRAINT [defalut_mark]  DEFAULT ((1)) FOR [mark]
GO
/****** Object:  StoredProcedure [dbo].[add_mission]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[add_mission] @uid int, @mission nvarchar(50), @note nvarchar(max)
As
Begin
	insert into mission (uid, mission, note)
	values (@uid, @mission, @note)
End
GO
/****** Object:  StoredProcedure [dbo].[add_subtasks]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[add_subtasks] @mission_id int, @subtasks nvarchar(50)
As
Begin
   insert into subtasks (mission_id, subtasks)
   values (@mission_id, @subtasks)
End
GO
/****** Object:  StoredProcedure [dbo].[alter_mission]    Script Date: 2018/6/17 14:41:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[alter_mission] @mission_id int, @mission nvarchar(50), @note nvarchar(max)
As
Begin
	update mission set mission = @mission where mission_id = @mission_id
	update mission set note = @note where mission_id = @mission_id
End
GO
Create Trigger delete_mission 
On mission
For delete
As
Begin
    Delete From subtasks Where mission_id = (Select mission_id From deleted)
End
GO
USE [master]
GO
ALTER DATABASE [Clearist] SET  READ_WRITE 
GO
