--What is the average price and number of rental offers according to the distance from the city center? (Cracow, Warsaw, Wroclaw)

WITH DistanceCategories AS (
    SELECT 
        City,
        CASE 
            WHEN CentreDistance <= 2 THEN '0-2 km'
            WHEN CentreDistance > 2 AND CentreDistance <= 5 THEN '2-5 km'
            WHEN CentreDistance > 5 AND CentreDistance <= 10 THEN '5-10 km'
            ELSE '10+ km'
        END AS DistanceCategory,
		CASE 
            WHEN CentreDistance <= 2 THEN 1
            WHEN CentreDistance > 2 AND CentreDistance <= 5 THEN 2
            WHEN CentreDistance > 5 AND CentreDistance <= 10 THEN 3
            ELSE 4
        END AS SortOrder,
        ROUND(AVG(Price), 2) AS AvgPrice,
        COUNT(Id) AS OfferCount
    FROM 
        ApartmentsRentals
    WHERE 
        City IN ('warszawa', 'wroclaw', 'krakow')
    GROUP BY 
        City, 
        CASE 
            WHEN CentreDistance <= 2 THEN '0-2 km'
            WHEN CentreDistance > 2 AND CentreDistance <= 5 THEN '2-5 km'
            WHEN CentreDistance > 5 AND CentreDistance <= 10 THEN '5-10 km'
            ELSE '10+ km'
        END,
		CASE 
            WHEN CentreDistance <= 2 THEN 1
            WHEN CentreDistance > 2 AND CentreDistance <= 5 THEN 2
            WHEN CentreDistance > 5 AND CentreDistance <= 10 THEN 3
            ELSE 4
        END
)

SELECT 
    City,
    DistanceCategory,
    FORMAT(AvgPrice, '# ###') + ' PLN' AS AvgPrice,
    OfferCount
FROM 
    DistanceCategories
ORDER BY 
    City
	,SortOrder