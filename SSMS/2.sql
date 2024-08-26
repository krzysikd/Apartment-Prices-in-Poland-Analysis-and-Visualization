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
