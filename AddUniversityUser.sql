CREATE PROCEDURE AddUniversityUser
	@UniversityID INT,
	@FirstName VARCHAR(120),
    @LastName VARCHAR(120),
	@Email VARCHAR(255),
    @PhoneNumber VARCHAR(13),
    @DepartmentID INT

AS
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION;
		DECLARE @ContactID INT;
        DECLARE @UserID INT;

		INSERT INTO [dbo].[ContactDetails] ([Email], [PhoneNumber])
        VALUES (@Email, @PhoneNumber);

        SET @ContactID = SCOPE_IDENTITY();

		INSERT INTO [dbo].[User] ([FirstName], [LastName], [ContactID], [RoleID])
        VALUES (@FirstName, @LastName, @ContactID, 2);

        SET @UserID = SCOPE_IDENTITY(); 

		INSERT INTO [dbo].[UniversityUser] ([UniversityID], [UserID], [DepartmentID])
        VALUES (@UniversityID, @UserID, @DepartmentID);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
		RETURN error_message();
    END CATCH;
END;