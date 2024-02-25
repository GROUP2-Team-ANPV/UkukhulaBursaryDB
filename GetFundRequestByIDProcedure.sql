CREATE PROCEDURE GetFundRequestByID
    @FundRequestID int
AS
BEGIN
    SELECT 
        StudentFundRequest.ID AS FundRequestID,
        StudentFundRequest.Grade,
        StudentFundRequest.Amount,
        StudentFundRequest.Motivation,
        StudentFundRequest.ApplicationDate,
        [Status].[Type] AS Status,
        StudentFundRequest.Comment,
        Student.ID AS StudentID,
        Student.IDNumber,
        Student.BirthDate,
        [User].FirstName,
        [User].LastName,
        ContactDetails.Email,
        ContactDetails.PhoneNumber,
        Gender.GenderName AS Gender,
        Race.RaceName AS Race,
        University.Name AS University,
        Department.Name AS Department,
        CASE 
            WHEN (
                SELECT COUNT(*) 
                FROM dbo.Document 
                WHERE dbo.Document.RequestID = dbo.StudentFundRequest.ID
            ) = 3 THEN 'Received'
            WHEN (
                SELECT COUNT(*) 
                FROM dbo.Document 
                WHERE dbo.Document.RequestID = dbo.StudentFundRequest.ID
            ) > 0 THEN 'Partially Received'
            ELSE 'Not Received'
        END AS DocumentStatus
    FROM
        StudentFundRequest
    INNER JOIN 
        [Status] ON StudentFundRequest.StatusID = [Status].ID
    INNER JOIN 
        Student ON StudentFundRequest.StudentID = Student.ID
    INNER JOIN 
        [User] ON Student.UserID = [User].ID
    INNER JOIN 
        Gender ON Student.GenderID = Gender.ID
    INNER JOIN 
        Race ON Student.RaceID = Race.ID
    INNER JOIN 
        UniversityStudentInformation ON Student.ID = UniversityStudentInformation.StudentID
    INNER JOIN 
        University ON UniversityStudentInformation.UniversityID = University.ID
    INNER JOIN 
        Department ON StudentFundRequest.DepartmentID = Department.ID
    INNER JOIN 
        ContactDetails ON [User].ContactID = ContactDetails.ID
    WHERE
        StudentFundRequest.ID = @FundRequestID
END
