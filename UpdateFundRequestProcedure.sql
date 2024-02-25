CREATE PROCEDURE UpdateFundRequest
    @FundRequestID int,
    @Grade tinyint,
    @Amount money,
    @Motivation text,
    @StudentID int,
    @DepartmentID int
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE StudentFundRequest
        SET Grade = @Grade,
            Amount = @Amount,
            Motivation = @Motivation,
            StudentID = @StudentID,
            DepartmentID = @DepartmentID
        WHERE ID = @FundRequestID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
