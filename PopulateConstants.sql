INSERT INTO
    [dbo].[Provinces] ([ProvinceName])
VALUES
    ('Eastern Cape'),
    ('Free State'),
    ('Gauteng'),
    ('KwaZulu-Natal'),
    ('Limpopo'),
    ('Mpumalanga'),
    ('North West'),
    ('Northern Cape'),
    ('Western Cape');

INSERT INTO
    [dbo].[Role] ([RoleType])
VALUES
    ('BBD Admin'),
    ('University Admin'),
    ('Student');
GO

INSERT INTO
    [dbo].[Race] ([RaceName])
VALUES
    ('Black'),
    ('Coloured'),
    ('Indian');
GO

INSERT INTO
    [dbo].[Status] ([Type])
VALUES
    ('Approved'),
    ('Rejected'),
    ('Review');
GO

INSERT INTO
    [dbo].[Gender] ([GenderName])
VALUES
    ('Male'),
    ('Female'),
    ('Other');
GO

INSERT INTO
    [dbo].[DocumentType] ([Type])
VALUES
    ('CV'),
    ('Transcript'),
    ('ID');
GO


INSERT INTO [dbo].[Department] ([Name]) 
VALUES 
    ('Computer Science'),
    ('Computer Engineering'),
    ('Computer Game Design'),
    ('Software Engineering'),
    ('Data Science'),
    ('Artificial Intelligence'),
    ('Cybersecurity'),
    ('Information Systems');
