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
