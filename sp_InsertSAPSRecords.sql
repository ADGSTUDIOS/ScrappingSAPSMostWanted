USE [YourDBName]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertSAPSRecords]    Script Date: 2021/09/21 23:53:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Ashlin Darius Govindasamy>
-- Create date: <2021/09/21>
-- Description:	<Inserting Fields to SAPS Dataset>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertSAPSRecords] @CriminalName varchar(max),@Comment varchar(max),@Gender varchar(max), @CrimeDate varchar(max), @CaseNumber varchar(max)
AS
BEGIN
	BEGIN TRY
    BEGIN TRANSACTION
	INSERT INTO tblSAPS (CriminalName,Comment,Gender,CrimeDate,CaseNumber) VALUES (@CriminalName,@Comment,@Gender,@CrimeDate,@CaseNumber)
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


