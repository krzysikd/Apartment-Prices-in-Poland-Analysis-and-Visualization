# Apartment-Prices-in-Poland-Analysis-and-Visualization

This project is focused on analyzing apartment prices in Poland, both for rentals and sales. The primary objective is to gain insights into the housing market in various Polish cities by cleaning, transforming, and visualizing the data to create a comprehensive dashboard. The data used in this project has been sourced from Kaggle, specifically from the dataset available at https://www.kaggle.com/datasets/krzysztofjamroz/apartment-prices-in-poland. This dataset contains detailed information about apartment rentals and sales across different cities in Poland.

## SSIS (SQL Server Integration Services)
* Loading and iterating over multiple CSV files - Implemented a loop to dynamically load and process all CSV files from specified folders.
* Data cleaning and transformation - Replaced incorrect delimiters, handled missing values by converting empty cells to NULL, and ensured proper data formatting.
* Data type conversion - Changed the data types from text to appropriate formats such as integers, decimals, and dates for accurate processing.
* Metadata extraction - Extracted month and year from file names to include time-related metadata in the dataset.
* Loading transformed data into SQL Server - Imported the cleaned and structured data into separate SQL Server tables for rentals and sales data.

## SSMS (SQL Server Management Studio)
* Table creation - Defined and created SQL Server tables for storing the cleaned and transformed data from SSIS, including appropriate data types and constraints.
* Data validation and integrity checks - Ran queries to validate the data integrity, ensuring no missing or incorrect entries were imported.
* Query development - Wrote SQL queries to analyze and extract insights from the rental and sales data, such as calculating average prices, identifying trends, and comparing different cities and property types.

## Power BI
* Data loading: Imported data from the SQL Server database into Power BI, including both the rentals and sales datasets.
* Data consolidation: Merged the rentals and sales data into a single table by adding a "Types" column to distinguish between the two categories and then performed a join operation to unify the datasets.
* Search Functionality: Developed an interactive search feature using a dynamic map, enabling users to filter and locate apartments based on criteria such as location, price range, and type (rentals or sales).
* Dashboard Creation: Developed a dashboard for analyzing apartment market data, enabling easy comparison of trends and prices across different locations.

## Overview of sales and rentals
![Overview of sales](PowerBi_screenshots/Overview%20of%20sales.JPG)

![Overview of sales](PowerBi_screenshots/Overview%20of%20rentals.JPG)

## Detailed market analysis
![Detailed market analysis](PowerBi_screenshots/Detailed%20market%20analysis.JPG)

## Conclusion
This project provides a comprehensive analysis of the apartment market in Poland, combining data transformation, SQL queries, and interactive visualizations. The final dashboard offers valuable insights into market trends, helping users to make informed decisions based on detailed comparisons of rental and sales prices across various cities.

