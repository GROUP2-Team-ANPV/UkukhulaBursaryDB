CREATE PROCEDURE GetUserByUniversityID
	@UniversityID INT
AS
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION;
		SELECT
			[User].[ID] AS UserID,
			[User].[FirstName],
			[User].[LastName],
			[ContactDetails].[Email],
			[ContactDetails].[PhoneNumber],
			[University].[Name] AS UniversityName,
			[Department].[Name] AS DepartmentName
		FROM
			[dbo].[User]
		LEFT JOIN
			[dbo].[ContactDetails] ON [User].[ContactID] = [ContactDetails].[ID]
		LEFT JOIN
			[dbo].[UniversityUser] ON [User].[ID] = [UniversityUser].[UserID]
		LEFT JOIN
			[dbo].[University] ON [UniversityUser].[UniversityID] = [University].[ID]
		LEFT JOIN
			[dbo].[Department] ON [UniversityUser].[DepartmentID] = [Department].[ID]
		WHERE
			[User].[RoleID] = 2 and [dbo].[University].[ID] = @UniversityID;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
		RETURN error_message();
    END CATCH;
END;