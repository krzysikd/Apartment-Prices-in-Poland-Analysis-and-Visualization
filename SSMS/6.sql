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
