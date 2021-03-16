USE [SSIS_PDS]
GO

CREATE TABLE [dbo].[Package](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[PackageGUID] [uniqueidentifier] NOT NULL,
	[PackageName] [varchar](255) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](255) NOT NULL,
	[EnteredDateTime] [datetime] NOT NULL DEFAULT getdate(),
 CONSTRAINT [PK_Package] PRIMARY KEY CLUSTERED (
	[PackageID] ASC
))
GO

CREATE TABLE [dbo].[PackageVersion](
	[PackageVersionID] [int] IDENTITY(1,1) NOT NULL,
	[PackageVersionGUID] [uniqueidentifier] NOT NULL,
	[PackageID] [int] NOT NULL,
	[VersionMajor] [int] NOT NULL,
	[VersionMinor] [int] NOT NULL,
	[VersionBuild] [int] NOT NULL,
	[VersionComment] [varchar](1000) NOT NULL,
	[EnteredDateTime] [datetime] NOT NULL DEFAULT getdate(),
 CONSTRAINT [PK_PackageVersion] PRIMARY KEY CLUSTERED (
	[PackageVersionID] ASC
))
GO
ALTER TABLE [dbo].[PackageVersion]  WITH CHECK ADD  CONSTRAINT [FK_PackageVersion_Package] FOREIGN KEY([PackageID])
REFERENCES [dbo].[Package] ([PackageID])
GO
ALTER TABLE [dbo].[PackageVersion] CHECK CONSTRAINT [FK_PackageVersion_Package]
GO

CREATE TABLE [dbo].[BatchLog](
	[BatchLogID] [int] IDENTITY(1,1) NOT NULL,
	[StartDateTime] [datetime] NOT NULL DEFAULT getdate(),
	[EndDateTime] [datetime] NULL,
	[Status] [char](1) NOT NULL,
 CONSTRAINT [PK_BatchLog] PRIMARY KEY CLUSTERED (
	[BatchLogID] ASC
))
GO

CREATE TABLE [dbo].[PackageLog](
	[PackageLogID] [int] IDENTITY(1,1) NOT NULL,
	[BatchLogID] [int] NOT NULL,
	[PackageVersionID] [int] NOT NULL,
	[ExecutionInstanceID] [uniqueidentifier] NOT NULL,
	[MachineName] [varchar](64) NOT NULL,
	[UserName] [varchar](64) NOT NULL,
	[StartDateTime] [datetime] NOT NULL DEFAULT getdate(),
	[EndDateTime] [datetime] NULL,
	[Status] [char](1) NOT NULL,
 CONSTRAINT [PK_PackageLog] PRIMARY KEY CLUSTERED (
	[PackageLogID] ASC
))
GO
ALTER TABLE [dbo].[PackageLog]  WITH CHECK ADD  CONSTRAINT [FK_PackageLog_BatchLog] FOREIGN KEY([BatchLogID])
REFERENCES [dbo].[BatchLog] ([BatchLogID])
GO
ALTER TABLE [dbo].[PackageLog] CHECK CONSTRAINT [FK_PackageLog_BatchLog]
GO
ALTER TABLE [dbo].[PackageLog]  WITH CHECK ADD  CONSTRAINT [FK_PackageLog_PackageVersion] FOREIGN KEY([PackageVersionID])
REFERENCES [dbo].[PackageVersion] ([PackageVersionID])
GO
ALTER TABLE [dbo].[PackageLog] CHECK CONSTRAINT [FK_PackageLog_PackageVersion]
GO

CREATE TABLE [dbo].[PackageErrorLog](
	[PackageErrorLogID] [int] IDENTITY(1,1) NOT NULL,
	[PackageLogID] [int] NOT NULL,
	[SourceName] [varchar](64) NOT NULL,
	[SourceID] [uniqueidentifier] NOT NULL,
	[ErrorCode] [int] NULL,
	[ErrorDescription] [varchar](2000) NULL,
	[LogDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_PackageErrorLog] PRIMARY KEY CLUSTERED (
	[PackageErrorLogID] ASC
))
GO
ALTER TABLE [dbo].[PackageErrorLog]  WITH CHECK ADD  CONSTRAINT [FK_PackageErrorLog_PackageLog] FOREIGN KEY([PackageLogID])
REFERENCES [dbo].[PackageLog] ([PackageLogID])
GO
ALTER TABLE [dbo].[PackageErrorLog] CHECK CONSTRAINT [FK_PackageErrorLog_PackageLog]
GO

CREATE TABLE [dbo].[PackageTaskLog](
	[PackageTaskLogID] [int] IDENTITY(1,1) NOT NULL,
	[PackageLogID] [int] NOT NULL,
	[SourceName] [varchar](255) NOT NULL,
	[SourceID] [uniqueidentifier] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NULL,
 CONSTRAINT [PK_PackageTaskLog] PRIMARY KEY CLUSTERED (
	[PackageTaskLogID] ASC
))
GO
ALTER TABLE [dbo].[PackageTaskLog]  WITH CHECK ADD  CONSTRAINT [FK_PackageTaskLog_PackageLog] FOREIGN KEY([PackageLogID])
REFERENCES [dbo].[PackageLog] ([PackageLogID])
GO
ALTER TABLE [dbo].[PackageTaskLog] CHECK CONSTRAINT [FK_PackageTaskLog_PackageLog]
GO

CREATE TABLE [dbo].[PackageVariableLog](
	[PackageVariableLogID] [int] IDENTITY(1,1) NOT NULL,
	[PackageLogID] [int] NOT NULL,
	[VariableName] [varchar](255) NOT NULL,
	[VariableValue] [varchar](max) NOT NULL,
	[LogDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_PackageVariableLog] PRIMARY KEY CLUSTERED (
	[PackageVariableLogID] ASC
))
GO
ALTER TABLE [dbo].[PackageVariableLog]  WITH CHECK ADD  CONSTRAINT [FK_PackageVariableLog_PackageLog] FOREIGN KEY([PackageLogID])
REFERENCES [dbo].[PackageLog] ([PackageLogID])
GO
ALTER TABLE [dbo].[PackageVariableLog] CHECK CONSTRAINT [FK_PackageVariableLog_PackageLog]
GO



USE [SSIS_PDS]
GO

/****** Object:  Table [adm].[SSIS Configurations]    Script Date: 11/3/2019 9:46:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SSIS Configurations](
	[ConfigurationFilter] [nvarchar](255) NOT NULL,
	[ConfiguredValue] [nvarchar](1000) NULL,
	[PackagePath] [nvarchar](1000) NOT NULL,
	[ConfiguredValueType] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO


