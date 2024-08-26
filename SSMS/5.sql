/*What is the distribution of apartment sales based on the number of nearby Points of Interest (POIs) in different cities 
(Czestochowa, Rzeszow, Lodz), and how does the proximity to POIs impact the average sale price?

This analysis categorizes apartments based on the number of POIs within a 500-meter range and examines both the percentage 
of offers in each category and the average sale price associated with different levels of POI density. */

WITH POIPercentage AS (
    SELECT 
        City,
        CASE 
            WHEN poiCount = 0 THEN '0 POIs'
            WHEN poiCount BETWEEN 1 AND 3 THEN '1-3 POIs'
            WHEN poiCount BETWEEN 4 AND 6 THEN '4-6 POIs'
            ELSE '7+ POIs'
        END AS POICategory,
        COUNT(Id) AS OfferCount,
		ROUND(AVG(Price), 2) AS AvgPrice
    FROM 
        ApartmentsSales
    WHERE 
        City IN ('czestochowa', 'rzeszow', 'lodz')
    GROUP BY 
        City, 
        CASE 
            WHEN poiCount = 0 THEN '0 POIs'
            WHEN poiCount BETWEEN 1 AND 3 THEN '1-3 POIs'
            WHEN poiCount BETWEEN 4 AND 6 THEN '4-6 POIs'
            ELSE '7+ POIs'
        END
)

SELECT 
    City,
    POICategory,
    OfferCount,
    FORMAT(CAST(OfferCount AS FLOAT) / SUM(OfferCount) OVER (PARTITION BY City) * 100, '#,0') + '%' AS Percentage,
	FORMAT(AvgPrice, '### ###') + ' PLN' AS AvgPrice
FROM 
    POIPercentage
ORDER BY 
    City,
    POICategory;
