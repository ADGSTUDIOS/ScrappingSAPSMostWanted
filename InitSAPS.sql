USE [YourDBName]
GO
/****** Object:  StoredProcedure [dbo].[InitSAPS]    Script Date: 2021/09/21 23:52:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	<Ashlin Darius Govindasamy - ADGSTUDIOS (c) 2021>
-- Create date: <2021/09/21>
-- Description:	<Used to Create tblSAPS or Reset DataContents Job Runs by Docker midnight each day in RahnDB>
-- =============================================
CREATE PROCEDURE [dbo].[InitSAPS] 
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSAPS]') AND type in (N'U'))
	BEGIN
	DROP TABLE [dbo].[tblSAPS]
	END
	CREATE TABLE [dbo].[tblSAPS](
		[CriminalName] [varchar](max) NULL,
		[Comment] [varchar](max) NULL,
		[Gender] [varchar](max) NULL,
		[CrimeDate] [varchar](max) NULL,
		[CaseNumber] [varchar](max) NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    COMMIT TRAN 
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN 
    DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
       @ErrorMessage = ERROR_MESSAGE(),  
       @ErrorSeverity = ERROR_SEVERITY(),  
       @ErrorState = ERROR_STATE();  

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  
    
END CATCH
END
GO


