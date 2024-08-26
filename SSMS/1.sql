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

