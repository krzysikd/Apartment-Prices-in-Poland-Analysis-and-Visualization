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
