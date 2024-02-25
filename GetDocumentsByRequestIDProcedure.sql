CREATE PROCEDURE GetDocumentsByRequestID
    @RequestID INT
AS
BEGIN
    SELECT
        [dbo].[Document].[Document] AS DocumentPath,
        [dbo].[DocumentType].[Type] AS DocumentType
    FROM
        [dbo].[Document]
    INNER JOIN 
        [dbo].[DocumentType] ON [dbo].[Document].[TypeID] = [dbo].[DocumentType].[ID]
    WHERE
        [dbo].[Document].[RequestID] = @RequestID
END