---------------------------------------------------------------------------------------------------
-- What is the average selling price of an apartment depending on the city and the number of rooms?
-- How much does the price increase if we want to buy an apartment with one more room?

SELECT City,
       ISNULL(FORMAT([1], '# ### ###') + ' PLN', 'N/A') AS '1 Room',
       CASE
           WHEN [1] > 0
                AND [2] IS NOT NULL THEN
               FORMAT((([2] - [1]) / [1]) * 100, '#,0') + ' %'
           ELSE
               'N/A'
       END AS '1-2 Room Increase (%)',
       ISNULL(FORMAT([2], '# ### ###') + ' PLN', 'N/A') AS '2 Rooms',
       CASE
           WHEN [2] > 0
                AND [3] IS NOT NULL THEN
               FORMAT((([3] - [2]) / [2]) * 100, '#,0') + ' %'
           ELSE
               'N/A'
       END AS '2-3 Room Increase (%)',
       ISNULL(FORMAT([3], '# ### ###') + ' PLN', 'N/A') AS '3 Rooms',
       CASE
           WHEN [3] > 0
                AND [4] IS NOT NULL THEN
               FORMAT((([4] - [3]) / [3]) * 100, '#,0') + ' %'
           ELSE
               'N/A'
       END AS '3-4 Room Increase (%)',
       ISNULL(FORMAT([4], '# ### ###') + ' PLN', 'N/A') AS '4 Rooms',
       CASE
           WHEN [4] > 0
                AND [5] IS NOT NULL THEN
               FORMAT((([5] - [4]) / [4]) * 100, '#,0') + ' %'
           ELSE
               'N/A'
       END AS '4-5 Room Increase (%)',
       ISNULL(FORMAT([5], '# ### ###') + ' PLN', 'N/A') AS '5 Rooms',
       CASE
           WHEN [5] > 0
                AND [6] IS NOT NULL THEN
               FORMAT((([6] - [5]) / [5]) * 100, '#,0') + ' %'
           ELSE
               'N/A'
       END AS '5-6 Room Increase (%)',
       ISNULL(FORMAT([6], '# ### ###') + ' PLN', 'N/A') AS '6 Rooms'
FROM
(SELECT City, Price, Rooms FROM ApartmentsSales) AS SourceTable
PIVOT
(
    AVG(Price)
    FOR Rooms IN ([1], [2], [3], [4], [5], [6])
) AS PivotTable
ORDER BY City;

---------------------------------------------------------------------------------------------------
--What are the sales and rental prices of apartments in different cities?

WITH SalesPrices AS (
    SELECT 
        City,
        ROUND(AVG(Price), 2) AS AvgPrice,
        MIN(Price) AS MinPrice,
        MAX(Price) AS MaxPrice
    FROM 
        ApartmentsSales
    GROUP BY 
        City
),
RentalPrices AS (
    SELECT 
        City,
        ROUND(AVG(Price), 2) AS AvgPrice,
        MIN(Price) AS MinPrice,
        MAX(Price) AS MaxPrice
    FROM 
        ApartmentsRentals
    GROUP BY 
        City
)
SELECT 
    'Sales' AS Type,
    City,
    FORMAT(AvgPrice, '### ### ###') + ' PLN' AS AvgPrice,
    FORMAT(MinPrice, '### ### ###') + ' PLN' AS MinPrice,
    FORMAT(MaxPrice, '### ### ###') + ' PLN' AS MaxPrice
FROM 
    SalesPrices
UNION ALL
SELECT 
    'Rentals' AS Type,
    City,
    FORMAT(AvgPrice, '### ### ###') + ' PLN' AS AvgPrice,
    FORMAT(MinPrice, '### ### ###') + ' PLN' AS MinPrice,
    FORMAT(MaxPrice, '### ### ###') + ' PLN' AS MaxPrice
FROM 
    RentalPrices
ORDER BY 
    Type, City;

---------------------------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------------------------
/*What is the average selling price of apartments across different cities, and how do these cities rank in terms of their average apartment prices?

CityRank: ranking cities by average housing price.

Quartile: divides cities into four quartiles based on their average prices.

OverallMedianPrice: median price for all cities.

AvgPrice: average price of housing in each city.

OverallAvgPrice: overall average price of housing for all cities.

PriceDifferenceFromAvg: The difference between the average price in a city and the overall average price in all cities.

DifferenceFromMax: The difference between the average price and the maximum average price in all cities.

DifferenceFromMin: The difference between the average price and the minimum average price in all cities.

RelativeToAvg: How the average price in a city compares to the overall average price, expressed as a percentage.

PricePercentage: Shows what percentage of the total average price is the average price for each city.
*/

WITH Rnk AS (
    SELECT
        City,
        AVG(Price) AS AvgPrice
    FROM
        ApartmentsSales
    GROUP BY
        City
),
Stats AS (
    SELECT
        City,
        AvgPrice,
        RANK() OVER (ORDER BY AvgPrice DESC) AS CityRank,
        NTILE(4) OVER (ORDER BY AvgPrice DESC) AS Quartile, 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY AvgPrice) OVER () AS OverallMedianPrice,
        ROUND(AVG(AvgPrice) OVER (), 2) AS OverallAvgPrice,
        MAX(AvgPrice) OVER () AS MaxPrice,
        MIN(AvgPrice) OVER () AS MinPrice,
        FORMAT(AvgPrice / SUM(AvgPrice) OVER () * 100, '0.00') + '%' AS PricePercentage
    FROM
        Rnk
)

SELECT
    City,
    CityRank,
    Quartile,
    FORMAT(OverallMedianPrice, '# ### ###') + ' PLN' AS OverallMedianPrice,
	FORMAT(AvgPrice, '# ### ###') + ' PLN' AS AvgPrice,
    FORMAT(OverallAvgPrice, '# ### ###') + ' PLN' AS OverallAvgPrice,
    FORMAT(AvgPrice - OverallAvgPrice, '# ### ###') + ' PLN' AS PriceDifferenceFromAvg,
    FORMAT(AvgPrice - MaxPrice, '# ### ###') + ' PLN' AS DifferenceFromMax,
    FORMAT(AvgPrice - MinPrice, '# ### ###') + ' PLN' AS DifferenceFromMin,
    FORMAT((AvgPrice / OverallAvgPrice) * 100, '0.00') + '%' AS RelativeToAvg,
    PricePercentage
FROM
    Stats
ORDER BY
    CityRank;


---------------------------------------------------------------------------------------------------
--The impact of various amenities on housing prices for both sales and rentals (parking, balcony, elevator, and security)

WITH SalesPriceDiff AS (
    SELECT 
        'Parking' AS Amenity,
        AVG(CASE WHEN HasParkingSpace = 1 THEN Price END) - AVG(CASE WHEN HasParkingSpace = 0 THEN Price END) AS PriceDifference_Sales
    FROM 
        ApartmentsSales
    UNION ALL
    SELECT 
        'Balcony' AS Amenity,
        AVG(CASE WHEN HasBalcony = 1 THEN Price END) - AVG(CASE WHEN HasBalcony = 0 THEN Price END) AS PriceDifference_Sales
    FROM 
        ApartmentsSales
    UNION ALL
    SELECT 
        'Elevator' AS Amenity,
        AVG(CASE WHEN HasElevator = 1 THEN Price END) - AVG(CASE WHEN HasElevator = 0 THEN Price END) AS PriceDifference_Sales
    FROM 
        ApartmentsSales
    UNION ALL
    SELECT 
        'Security' AS Amenity,
        AVG(CASE WHEN HasSecurity = 1 THEN Price END) - AVG(CASE WHEN HasSecurity = 0 THEN Price END) AS PriceDifference_Sales
    FROM 
        ApartmentsSales
),
RentalsPriceDiff AS (
    SELECT 
        'Parking' AS Amenity,
        AVG(CASE WHEN HasParkingSpace = 1 THEN Price END) - AVG(CASE WHEN HasParkingSpace = 0 THEN Price END) AS PriceDifference_Rentals
    FROM 
        ApartmentsRentals
    UNION ALL
    SELECT 
        'Balcony' AS Amenity,
        AVG(CASE WHEN HasBalcony = 1 THEN Price END) - AVG(CASE WHEN HasBalcony = 0 THEN Price END) AS PriceDifference_Rentals
    FROM 
        ApartmentsRentals
    UNION ALL
    SELECT 
        'Elevator' AS Amenity,
        AVG(CASE WHEN HasElevator = 1 THEN Price END) - AVG(CASE WHEN HasElevator = 0 THEN Price END) AS PriceDifference_Rentals
    FROM 
        ApartmentsRentals
    UNION ALL
    SELECT 
        'Security' AS Amenity,
        AVG(CASE WHEN HasSecurity = 1 THEN Price END) - AVG(CASE WHEN HasSecurity = 0 THEN Price END) AS PriceDifference_Rentals
    FROM 
        ApartmentsRentals
)

SELECT 
    S.Amenity,
    FORMAT(S.PriceDifference_Sales, '# ### ###') + ' PLN' AS PriceDifference_Sales,
    FORMAT(R.PriceDifference_Rentals, '# ### ###') + ' PLN' AS PriceDifference_Rentals
FROM 
    SalesPriceDiff S
JOIN 
    RentalsPriceDiff R ON S.Amenity = R.Amenity;


---------------------------------------------------------------------------------------------------
--How the age of a building affects the average selling price of an apartment 

SELECT 
    CASE 
        WHEN BuildYear IS NULL THEN 'Unknown'
        WHEN BuildYear < 1950 THEN '< 1950'
        WHEN BuildYear BETWEEN 1950 AND 1959 THEN '1950-1959'
        WHEN BuildYear BETWEEN 1960 AND 1969 THEN '1960-1969'
        WHEN BuildYear BETWEEN 1970 AND 1979 THEN '1970-1979'
        WHEN BuildYear BETWEEN 1980 AND 1989 THEN '1980-1989'
        WHEN BuildYear BETWEEN 1990 AND 1999 THEN '1990-1999'
        WHEN BuildYear BETWEEN 2000 AND 2009 THEN '2000-2009'
        WHEN BuildYear BETWEEN 2010 AND 2019 THEN '2010-2019'
        ELSE '2020+'
    END AS BuildYearGroup,
    COUNT(Id) AS NumberOfSales,
    FORMAT(AVG(Price), '# ### ###') + ' PLN' AS AvgPrice
FROM 
    ApartmentsSales
GROUP BY 
    CASE 
        WHEN BuildYear IS NULL THEN 'Unknown'
        WHEN BuildYear < 1950 THEN '< 1950'
        WHEN BuildYear BETWEEN 1950 AND 1959 THEN '1950-1959'
        WHEN BuildYear BETWEEN 1960 AND 1969 THEN '1960-1969'
        WHEN BuildYear BETWEEN 1970 AND 1979 THEN '1970-1979'
        WHEN BuildYear BETWEEN 1980 AND 1989 THEN '1980-1989'
        WHEN BuildYear BETWEEN 1990 AND 1999 THEN '1990-1999'
        WHEN BuildYear BETWEEN 2000 AND 2009 THEN '2000-2009'
        WHEN BuildYear BETWEEN 2010 AND 2019 THEN '2010-2019'
        ELSE '2020+'
    END
ORDER BY 
    BuildYearGroup;


---------------------------------------------------------------------------------------------------
/* This query compares the profitability of buying versus renting an apartment over a 15-year period. It calculates two key ROI metrics: 
one that compares the long-term cost of renting versus buying, and another that estimates the return on investment if the purchased 
apartment is rented out, factoring in taxes, potential vacancies, and additional costs. */

WITH Sales AS (
    SELECT 
        City,
        AVG(Price) AS AvgSalesPrice
    FROM 
        ApartmentsSales
    GROUP BY 
        City
),
Rentals AS (
    SELECT 
        City,
        AVG(Price) AS AvgRentPrice
    FROM 
        ApartmentsRentals
    GROUP BY 
        City
)
SELECT 
    S.City,
    FORMAT(S.AvgSalesPrice, '# ### ###') + ' PLN' AS AvgSalesPrice,
    FORMAT(R.AvgRentPrice, '# ### ###') + ' PLN' AS AvgRentPrice,
    FORMAT((15 * R.AvgRentPrice * 12) / NULLIF(S.AvgSalesPrice + 70000, 0) * 100, '0.00') + '%' AS RentVsBuyROI,
    FORMAT((15 * R.AvgRentPrice * 11 * (1 - 0.085) - 20000) / NULLIF(S.AvgSalesPrice + 70000, 0) * 100, '0.00') + '%' AS RentalInvestmentROI
FROM 
    Sales S
JOIN 
    Rentals R ON S.City = R.City
ORDER BY 
    RentVsBuyROI DESC;


---------------------------------------------------------------------------------------------------
--What insights can be drawn from categorizing cities into different price tiers using a simplified K-Means approach based on the average selling price?

SELECT 
    CityData.City,
    IIF(CityData.AvgPrice < 400000, 'Low Price',
       IIF(CityData.AvgPrice BETWEEN 400000 AND 700000, 'Medium Price', 'High Price')) AS PriceCategory,
    FORMAT(CityData.AvgPrice, '# ### ###') + ' PLN' AS AvgPrice
FROM 
    (SELECT 
         City,
         AVG(Price) AS AvgPrice
     FROM 
         ApartmentsSales
     GROUP BY 
         City) AS CityData
ORDER BY 
    CityData.AvgPrice;


---------------------------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------------------------
-- What are the average apartment prices based on the number of rooms and cities, and how do these prices compare across different groupings?

SELECT 
    City,
    Rooms,
    FORMAT(AVG(Price), '# ### ###') + ' PLN' AS AvgPrice,
    COUNT(Id) AS NumberOfListings
FROM 
    ApartmentsSales
GROUP BY 
    GROUPING SETS (
        (City, Rooms),   
        (City),          
        ()               
    )
ORDER BY 
    City,
    Rooms;
