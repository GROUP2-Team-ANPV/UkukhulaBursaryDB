CREATE TRIGGER UpdateRemainingBudgetTrigger
ON [dbo].[UniversityFundAllocation]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE BBD
    SET BBD.RemainingBudget = dbo.CalculateRemainingBudget(BBD.ID)
    FROM dbo.BBDAllocation AS BBD
    INNER JOIN inserted AS i ON BBD.ID = i.BBDAllocationID
    WHERE EXISTS (SELECT 1 FROM deleted AS d WHERE d.BBDAllocationID = i.BBDAllocationID)
       OR EXISTS (SELECT 1 FROM inserted AS i2 WHERE i2.BBDAllocationID = BBD.ID);
END;