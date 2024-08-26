--How much has the selling price of apartments changed over time for properties with at least five price reductions?

WITH RankedSales AS (
    SELECT 
        City,
        Id,
        Price,
        Year,
        Month,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Year, Month) AS Ranking
    FROM 
        ApartmentsSales
),
PriceChanges AS (
    SELECT 
        A.City,
        A.Id,
        FORMAT(A.Price, '# ### ###') + ' PLN' AS InitialPrice,
        FORMAT(B.Price, '# ### ###') + ' PLN' AS NewPrice,
        A.Price - B.Price AS PriceDifference,
        COUNT(*) OVER (PARTITION BY A.Id) AS ChangeCount
    FROM 
        RankedSales A
    JOIN 
        RankedSales B 
    ON 
        A.Id = B.Id 
        AND A.Ranking = B.Ranking - 1
    WHERE 
        B.Price < A.Price
)
SELECT 
    City,
    Id,
    InitialPrice,
    NewPrice,
    FORMAT(PriceDifference, '# ### ###') + ' PLN' AS PriceReduction
FROM 
    PriceChanges
WHERE 
    ChangeCount >= 5
ORDER BY 
    Id
