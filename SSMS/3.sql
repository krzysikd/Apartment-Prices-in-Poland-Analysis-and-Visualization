--What are the monthly trends in apartment sales and rentals in Warsaw, Cracow and Wroclaw from August 2023 to June 2024?

WITH Sales AS (
    SELECT
        City,
        [08/2023],
        [09/2023],
        [10/2023],
        [11/2023],
        [12/2023],
        [01/2024],
        [02/2024],
        [03/2024],
        [04/2024],
        [05/2024],
        [06/2024]
    FROM
        (
            SELECT
                City,
                CONCAT(FORMAT(Month, '00'), '/', Year) AS Date,
                Id
            FROM
                ApartmentsSales
            WHERE
                City IN ('warszawa', 'krakow', 'wroclaw')
        ) AS SourceTable
    PIVOT (
        COUNT(Id)
        FOR Date IN (
            [08/2023],
            [09/2023],
            [10/2023],
            [11/2023],
            [12/2023],
            [01/2024],
            [02/2024],
            [03/2024],
            [04/2024],
            [05/2024],
            [06/2024]
        )
    ) AS PivotTable
), Rentals AS (
    SELECT
        City,
        [08/2023],
        [09/2023],
        [10/2023],
        [11/2023],
        [12/2023],
        [01/2024],
        [02/2024],
        [03/2024],
        [04/2024],
        [05/2024],
        [06/2024]
    FROM
        (
            SELECT
                City,
                CONCAT(FORMAT(Month, '00'), '/', Year) AS Date,
                Id 
            FROM
                ApartmentsRentals
            WHERE
                City IN ('warszawa', 'krakow', 'wroclaw')
        ) AS SourceTable
    PIVOT (
        COUNT(Id)
        FOR Date IN (
            [08/2023],
            [09/2023],
            [10/2023],
            [11/2023],
            [12/2023],
            [01/2024],
            [02/2024],
            [03/2024],
            [04/2024],
            [05/2024],
            [06/2024]
        )
    ) AS PivotTable
)

SELECT 
    'Sales' AS Type,
    City,
    CASE WHEN [08/2023] = 0 THEN 'N/A' ELSE FORMAT([08/2023], '# ###') END AS [08/2023],
    CASE WHEN [09/2023] = 0 THEN 'N/A' ELSE FORMAT([09/2023], '# ###') END AS [09/2023],
    CASE WHEN [10/2023] = 0 THEN 'N/A' ELSE FORMAT([10/2023], '# ###') END AS [10/2023],
    CASE WHEN [11/2023] = 0 THEN 'N/A' ELSE FORMAT([11/2023], '# ###') END AS [11/2023],
    CASE WHEN [12/2023] = 0 THEN 'N/A' ELSE FORMAT([12/2023], '# ###') END AS [12/2023],
    CASE WHEN [01/2024] = 0 THEN 'N/A' ELSE FORMAT([01/2024], '# ###') END AS [01/2024],
    CASE WHEN [02/2024] = 0 THEN 'N/A' ELSE FORMAT([02/2024], '# ###') END AS [02/2024],
    CASE WHEN [03/2024] = 0 THEN 'N/A' ELSE FORMAT([03/2024], '# ###') END AS [03/2024],
    CASE WHEN [04/2024] = 0 THEN 'N/A' ELSE FORMAT([04/2024], '# ###') END AS [04/2024],
    CASE WHEN [05/2024] = 0 THEN 'N/A' ELSE FORMAT([05/2024], '# ###') END AS [05/2024],
    CASE WHEN [06/2024] = 0 THEN 'N/A' ELSE FORMAT([06/2024], '# ###') END AS [06/2024]
FROM 															 
    Sales														 
																 
UNION ALL														 
																 
SELECT 															 
    'Rentals' AS Type,											 
    City,														 
    CASE WHEN [08/2023] = 0 THEN 'N/A' ELSE FORMAT([08/2023], '# ###') END AS [08/2023],
    CASE WHEN [09/2023] = 0 THEN 'N/A' ELSE FORMAT([09/2023], '# ###') END AS [09/2023],
    CASE WHEN [10/2023] = 0 THEN 'N/A' ELSE FORMAT([10/2023], '# ###') END AS [10/2023],
    CASE WHEN [11/2023] = 0 THEN 'N/A' ELSE FORMAT([11/2023], '# ###') END AS [11/2023],
    CASE WHEN [12/2023] = 0 THEN 'N/A' ELSE FORMAT([12/2023], '# ###') END AS [12/2023],
    CASE WHEN [01/2024] = 0 THEN 'N/A' ELSE FORMAT([01/2024], '# ###') END AS [01/2024],
    CASE WHEN [02/2024] = 0 THEN 'N/A' ELSE FORMAT([02/2024], '# ###') END AS [02/2024],
    CASE WHEN [03/2024] = 0 THEN 'N/A' ELSE FORMAT([03/2024], '# ###') END AS [03/2024],
    CASE WHEN [04/2024] = 0 THEN 'N/A' ELSE FORMAT([04/2024], '# ###') END AS [04/2024],
    CASE WHEN [05/2024] = 0 THEN 'N/A' ELSE FORMAT([05/2024], '# ###') END AS [05/2024],
    CASE WHEN [06/2024] = 0 THEN 'N/A' ELSE FORMAT([06/2024], '# ###') END AS [06/2024]
FROM 
    Rentals
ORDER BY 
    City,
	Type
