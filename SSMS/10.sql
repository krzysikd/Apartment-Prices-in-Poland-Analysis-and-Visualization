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
