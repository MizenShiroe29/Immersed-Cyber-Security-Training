USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[Files_SelectAll]    Script Date: 11/18/2022 3:55:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER proc [dbo].[Files_SelectAll]
					@PageIndex int 
                   ,@PageSize int

AS
-- =============================================
-- Author: <Author,,Micheal White>
-- Create date: <10/20/2022,,>
-- Description: <SelectAll (Paginated),,>
-- Code Reviewer:  Miranda Merritt

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note:
-- =============================================

/*
Declare @PageIndex int = 0
		,@PageSize int = 8
Execute dbo.Files_SelectAll
					@PageIndex
                   ,@PageSize

*/

BEGIN


Declare @offset int = @PageIndex * @PageSize

					SELECT f.Id as Id
						  ,f.[Name]
						  ,f.[Url]
						  ,ft.Id as FileTypeId
						  ,ft.Name as FileTypeName						  					  
						  ,[CreatedBy]
						  ,[DateCreated]
						  ,[IsDeleted]
						  ,TotalCount = COUNT(1) OVER()


  FROM [dbo].[Files] as f inner join dbo.FileTypes as ft
						on f.FileTypeId = ft.Id
ORDER BY f.Id

OfFSET @offSet Rows
Fetch Next @PageSize Rows ONLY

END


