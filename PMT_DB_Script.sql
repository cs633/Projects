
/****** Object:  Table [dbo].[Department]    Script Date: 04/07/2013 12:00:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Department](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Project]    Script Date: 04/07/2013 12:00:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Project](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[WorkCategory]    Script Date: 04/07/2013 12:00:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[WorkCategory](
	[ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_WorkCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[Employee]    Script Date: 04/07/2013 12:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Phone] [varchar](15) NULL,
	[Email] [varchar](100) NOT NULL,
	[ManagerID] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([ID])
GO

ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO

ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Employee] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employee] ([ID])
GO

ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Employee]
GO



/****** Object:  Table [dbo].[EmployeeProject]    Script Date: 04/07/2013 12:00:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[EmployeeProject](
	[ID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeProject] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO

ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_Employee]
GO

ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ID])
GO

ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_Project]
GO


/****** Object:  Table [dbo].[TimeSheet]    Script Date: 04/07/2013 12:01:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TimeSheet](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[DateTimeEntry] [datetime] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[WorkCategoryId] [int] NULL,
	[BillableHrs] [numeric](5, 2) NULL,
	[TrainingHrs] [numeric](5, 2) NULL,
	[MeetingHrs] [numeric](5, 2) NULL,
	[LeaveHrs] [numeric](5, 2) NULL,
	[IndirectHrs] [numeric](5, 2) NULL,
	[OtherHrs] [numeric](5, 2) NULL,
	[PersonalHrs] [numeric](5, 2) NULL,
 CONSTRAINT [PK_TimeSheet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ID])
GO

ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_Project]
GO

ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_TimeSheet] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO

ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_TimeSheet]
GO

ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_WorkCategory] FOREIGN KEY([WorkCategoryId])
REFERENCES [dbo].[WorkCategory] ([ID])
GO

ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_WorkCategory]
GO


USE [C:\USERS\RAMALIND\SKYDRIVE\DOCUMENTS\BOSTONUNIVERSITY\CS663\PROJECTS\PMT.WEBSITE\APP_DATA\PMT.MDF]
GO

/****** Object:  StoredProcedure [dbo].[usr_sp_GetPerformanceReport]    Script Date: 04/07/2013 12:02:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[usr_sp_GetPerformanceReport]
(
@date_start datetime,
@date_finish datetime,
@total_time int
)
/*
exec usr_sp_GetPerformanceReport '4-1-2013', '4-5-2013', 40
*/
as
begin
set nocount on

	select t.employeeid
	, e.firstname + ' ' + e.lastname full_name
	, sum(billablehrs) total_billable_hrs
	, (sum(billablehrs)/@total_time) * 100 billable_hrs_percentage
	, sum(traininghrs) total_training_hrs
	, (sum(traininghrs)/@total_time) * 100 training_hrs_percentage
	, sum(meetinghrs) total_meeting_hrs
	, (sum(meetinghrs)/@total_time) * 100 meeting_hrs_percentage
	, sum(leavehrs) total_leave_hrs
	, (sum(leavehrs)/@total_time) * 100 leave_hrs_percentage
	, sum(indirecthrs) total_indirect_hrs
	, (sum(indirecthrs)/@total_time) * 100 indirect_hrs_percentage
	, sum(otherhrs) total_other_hrs
	, (sum(otherhrs)/@total_time) * 100 other_hrs_percentage
	from timesheet t
	inner join employee e on e.id = t.employeeid
	where t.datetimeentry between @date_start and @date_finish
	group by t.employeeid, e.firstname + ' ' + e.lastname

end

GO





