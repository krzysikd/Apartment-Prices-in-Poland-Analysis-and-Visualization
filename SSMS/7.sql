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
