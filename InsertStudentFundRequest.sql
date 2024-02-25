
CREATE PROCEDURE InsertStudentFundRequest
    @FirstName varchar(120),
    @LastName varchar(120),
    @IDNumber char(13),
    @BirthDate date,
    @GenderID int,
    @RaceID int,
	@Email varchar(255),
	@PhoneNumber varchar(13),
    @Grade tinyint,
    @Amount money,
    @Motivation text,
    @DepartmentID int,
    @UniversityID int
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @ContactID int
        DECLARE @StudentID int		
        DECLARE @UserID int

        INSERT INTO ContactDetails (Email, PhoneNumber)
        VALUES (@Email, @PhoneNumber) 

        SET @ContactID = SCOPE_IDENTITY() 

        INSERT INTO [User] (FirstName, LastName, ContactID, RoleID)
        VALUES (@FirstName, @LastName, @ContactID, NULL)

        SET @UserID = SCOPE_IDENTITY() 

        INSERT INTO Student (IDNumber, BirthDate, GenderID, UserID, RaceID)
        VALUES (@IDNumber, @BirthDate, @GenderID, @UserID, @RaceID)

        SET @StudentID = SCOPE_IDENTITY() 

        INSERT INTO UniversityStudentInformation (UniversityID, StudentID)
        VALUES (@UniversityID, @StudentID)

        INSERT INTO StudentFundRequest (Grade, Amount, Motivation, StatusID, Comment, StudentID, DepartmentID)
        VALUES (@Grade, @Amount, @Motivation, 3 , '' , @StudentID, @DepartmentID)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RETURN ERROR_MESSAGE();
    END CATCH
END
