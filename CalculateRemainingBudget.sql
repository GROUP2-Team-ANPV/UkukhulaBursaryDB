CREATE FUNCTION dbo.CalculateRemainingBudget(@BBDAllocationID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @RemainingBudget MONEY;

    SELECT @RemainingBudget = BBD.Budget - ISNULL(SUM(UFA.Budget), 0)
    FROM dbo.BBDAllocation AS BBD
    LEFT JOIN dbo.UniversityFundAllocation AS UFA ON BBD.ID = UFA.BBDAllocationID
    WHERE BBD.ID = @BBDAllocationID
    GROUP BY BBD.Budget;

    RETURN @RemainingBudget;
END;