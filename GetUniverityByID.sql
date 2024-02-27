CREATE PROCEDURE GetUniverityByID
    @UniversityID int
AS
BEGIN
    BEGIN TRY
        SELECT [dbo].[University].[Name],
               [dbo].[Provinces].[ProvinceName],
               CONCAT([dbo].[User].[FirstName], ' ', [dbo].[User].[LastName]) AS ContactPerson,
               [dbo].[ContactDetails].[Email],
               [dbo].[ContactDetails].[PhoneNumber]
        FROM [dbo].[University]
        INNER JOIN [dbo].[Provinces] ON [dbo].[University].[ProvinceID] = [dbo].[Provinces].[ID]
        INNER JOIN [dbo].[User] ON [dbo].[University].[ContactPerson] = [dbo].[User].[ID]
        INNER JOIN [dbo].[ContactDetails] ON [dbo].[User].[ContactID] = [dbo].[ContactDetails].[ID]
        WHERE [dbo].[University].[ID] = @UniversityID;
    END TRY
    BEGIN CATCH
        RETURN ERROR_MESSAGE();
    END CATCH;
END;