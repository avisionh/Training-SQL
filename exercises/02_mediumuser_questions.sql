/* Training: SQL - Exercises */
-- DESCRIPTION: The purpose of this script is to provide exercises for the trainee to practice what 
--				was covered in the accompanying `training_sql_mediumuser.ipynb` notebook.

USE [AdventureWorks];

/* Question 1: Subquerying vs. temporary tables */
-- Q.		Can you rewrite the query below in (2.) to use subquerying instead?
WITH table_cte AS
(
    SELECT [ProductID]
        ,[Name]
        ,[ProductNumber]
        ,[Color]
        ,[StandardCost]
        ,[ListPrice]
        ,[DaysToManufacture]
        ,[DailyCostOfManufacture] = CASE 
            WHEN [DaysToManufacture] = 0 THEN 0
            ELSE [StandardCost]/[DaysToManufacture]
            END
        ,[SellStartDate]
        ,[SellEndDate]
        ,[DailyUnitRevenue] = CASE
            WHEN [SellStartDate] = [SellEndDate] THEN 0
            ELSE [ListPrice]/CAST(([SellEndDate] - [SellStartDate]) AS FLOAT)
            END
        ,[DiscontinuedDate]
    FROM [Production].[Product]
)

SELECT [ProductID]
    ,[Name]
    ,[ProductNumber]
    ,[Color]
    ,[StandardCost]
    ,[ListPrice]
    ,[DaysToManufacture]
    ,[DailyCostOfManufacture]
    ,[DailyUnitProfit] = [DailyUnitRevenue] - [DailyCostOfManufacture]
    ,[SellStartDate]
    ,[SellEndDate]
    ,[DiscontinuedDate]
FROM table_cte
WHERE [DailyCostOfManufacture] > 0
    AND [DailyUnitRevenue] > 0;
-- A.		Please write your query below here.


/* Question 2: Ranking groups of variables by a counter with subquerying */
-- Q.		Can you rewrite the above query below in (4.) using either a local temporary table 
--			or CTE instead of subquerying?
SELECT [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[VacationHours_Female] = [F]
      ,[VacationHours_Male] = [M]
FROM
(
	SELECT [BusinessEntityID]
            ,[NationalIDNumber]
            ,[LoginID]
            ,[JobTitle]
            ,[BirthDate]
            ,[MaritalStatus]
            ,[Gender]
            ,[VacationHours]
	FROM [HumanResources].[Employee]
) AS table_intermediate
PIVOT
(
	AVG([VacationHours]) 
	FOR [Gender] IN ([F], [M])
) AS table_end;
-- A.		Please write your query below here.


/* Question 3: Pivoting */
-- Q.		In the [HumanResources].[Employee], pivot across `[MaritalStatus]` on `[VacationHours]`.
-- A.		Please write your query below.


/* Question 4: Tidy data principles */
-- Q.		Is the [Sales].[SpecialOffer] table in a tidy data format? 
--			If it is not in tidy data format, how can you manipulate the dataset so that it is? 
-- A.		Please write your query below.