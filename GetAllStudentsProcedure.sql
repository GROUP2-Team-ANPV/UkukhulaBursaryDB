CREATE PROCEDURE GetAllStudents
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        [dbo].[Student].[ID] AS StudentID,
		[dbo].[User].[FirstName],
		[dbo].[User].[LastName],
        [dbo].[Student].[IDNumber],
        [dbo].[Student].[BirthDate],
        CONVERT(tinyint, DATEDIFF(DAY, [BirthDate], GETDATE()) / 365.25) AS Age,
        [dbo].[Gender].[GenderName] AS Gender,
        [dbo].[Race].[RaceName] AS Race,
        [dbo].[ContactDetails].[Email],
        [dbo].[ContactDetails].[PhoneNumber],
        [dbo].[University].[Name] AS University
    FROM 
        [dbo].[Student]
    INNER JOIN 
        [dbo].[Gender] ON [dbo].[Student].[GenderID] = [dbo].[Gender].[ID]
    INNER JOIN 
        [dbo].[Race] ON [dbo].[Student].[RaceID] = [dbo].[Race].[ID]
    INNER JOIN 
        [dbo].[User] ON [dbo].[Student].[UserID] = [dbo].[User].[ID]
    INNER JOIN 
        [dbo].[ContactDetails] ON [dbo].[User].[ContactID] = [dbo].[ContactDetails].[ID]
    INNER JOIN 
        [dbo].[UniversityStudentInformation] ON [dbo].[Student].[ID] = [dbo].[UniversityStudentInformation].[StudentID]
    INNER JOIN 
        [dbo].[University] ON [dbo].[UniversityStudentInformation].[UniversityID] = [dbo].[University].[ID]
END
