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

CREATE TABLE [dbo].[Employee_Project](
	[ID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ProjectID] [int] NOT NULL,
 CONSTRAINT [PK_Employee_Project_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Employee_Project]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Project_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO

ALTER TABLE [dbo].[Employee_Project] CHECK CONSTRAINT [FK_Employee_Project_Employee]
GO

ALTER TABLE [dbo].[Employee_Project]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Project_Project] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Project] ([ID])
GO

ALTER TABLE [dbo].[Employee_Project] CHECK CONSTRAINT [FK_Employee_Project_Project]
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


CREATE TABLE [dbo].[TimeSheet](
	[ID] [bigint] NOT NULL,
	[EmpoyeeID] [int] NOT NULL,
	[DateTimeEntry] [datetime] NOT NULL,
	[ProjectID] [int] NOT NULL,
	[WorkCategoryId] [int] NULL,
	[BillableHrs] [numeric](5, 2) NULL,
	[TrainingHrs] [numeric](5, 2) NULL,
	[MeetingHrs] [numeric](5, 2) NULL,
	[LeaveHrs] [numeric](5, 2) NULL,
	[IndirectHrs] [numeric](5, 2) NULL,
	[OtherHrs] [numeric](5, 2) NULL,
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

ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_TimeSheet] FOREIGN KEY([EmpoyeeID])
REFERENCES [dbo].[Employee] ([ID])
GO

ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_TimeSheet]
GO

ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_WorkCategory] FOREIGN KEY([WorkCategoryId])
REFERENCES [dbo].[WorkCategory] ([ID])
GO

ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_WorkCategory]
GO


SET ANSI_PADDING OFF
GO

