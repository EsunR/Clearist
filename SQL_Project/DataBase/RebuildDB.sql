USE [Clearist]
GO
DROP TABLE account
GO
DROP TABLE mission
GO
DROP TABLE subtasks
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
Create Trigger delete_mission 
On mission
For delete
As
Begin
    Delete From subtasks Where mission_id = (Select mission_id From deleted)
End