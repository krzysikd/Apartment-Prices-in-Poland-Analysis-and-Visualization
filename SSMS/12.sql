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
