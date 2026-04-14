
-- ======================================================
-- 
--                    Dataset: PC Sales
                   
-- ======================================================

                --Exploratory Data Analysis--


-- The first thing is to check if the query runs and shows all table Columns. 

      select * from  [P-C Data].[dbo].[1772542271737_pc_data];

 -- 1. Count the total number of sales records.

      select count (*)AS total_sales_records
      from  [P-C Data].[dbo].[1772542271737_pc_data];

 -- 2. Count the number of sales per Continent.

       select Continent,
       count(*)AS sales_per_continent
       from  [P-C Data].[dbo].[1772542271737_pc_data]
       GROUP BY Continent;


-- 3. Count the number of sales per Country or State.

      select Country_or_State,
      count(*)AS sales_per_country
      from [P-C Data].[dbo].[1772542271737_pc_data]
      GROUP BY Country_or_state;

-- 4. List all distinct Shop Name values.

      SELECT DISTINCT Shop_Name
      FROM [P-C Data].[dbo].[1772542271737_pc_data];

-- 5. Find the average Sale Price.

      select AVG(Sale_Price)AS average_sales_price
      from [P-C Data].[dbo].[1772542271737_pc_data];


-- 6. Find the highest and lowest Sale Price.

      SELECT MAX(Sale_Price) AS highest_sale_price,
       MIN(Sale_Price) AS lowest_sale_price
       FROM [P-C Data].[dbo].[1772542271737_pc_data];

-- 7. Count the number of sales by Payment Method.

     SELECT Payment_Method, COUNT(*) AS total_sales
     FROM [P-C Data].[dbo].[1772542271737_pc_data]
     GROUP BY Payment_Method;

-- 8. Count the number of sales by Channel (Online vs Offline).

     SELECT Channel, COUNT(*) AS total_sales
     FROM [P-C Data].[dbo].[1772542271737_pc_data]
     GROUP BY Channel;

-- 9. Count the number of sales by Priority level.

     select Priority,
     Count(*)AS priority_leve
     from[P-C Data].[dbo].[1772542271737_pc_data]
     Group BY Priority;

-- 10. Count the number of distinct PC Make values.
      
       select Distinct PC_Model
       from[P-C Data].[dbo].[1772542271737_pc_data];
       
-- THIS SECTION HAS INTERMEDIATE QUESTIONS

-- 11. Calculate total revenue (SUM of Sale Price).

       select SUM(Sale_Price)as total_revenue
       from [P-C Data].[dbo].[1772542271737_pc_data];


-- 12. Calculate total profit (SUM of Sale Price - Cost Price).
       select SUM(Sale_Price -Cost_Price)as total_revenue
       from [P-C Data].[dbo].[1772542271737_pc_data];

-- 13. Find the average Discount Amount.

        select AVG(Discount_Amount) AS discount_amount
       from [P-C Data].[dbo].[1772542271737_pc_data];

-- 14. Calculate total Finance Amount issued.

       select SUM (CAST(Finance_Amount AS Decimal(10,2)))AS total_finance_amount_issued
       from [P-C Data].[dbo].[1772542271737_pc_data];

-- 15. Find total revenue per PC Make.

       select PC_Make, SUM(Sale_Price) AS revenue
       from [P-C Data].[dbo].[1772542271737_pc_data]
       GROUP BY PC_Make
       ORDER BY revenue DESC;
      
      

-- 16. Find average Sale Price per Storage Type.

        SELECT Storage_Capacity, AVG(Sale_Price) AS sales_price_per_storage_type
        from[P-C Data].[dbo].[1772542271737_pc_data]
        GROUP BY Storage_Capacity
        ORDER BY sales_price_per_storage_type DESC;
    
-- 17. Calculate total revenue per Shop Name.
       
        SELECT Shop_Name, SUM(Sale_Price) AS total_revenue
        from[P-C Data].[dbo].[1772542271737_pc_data]
        GROUP BY Shop_Name
        ORDER BY total_revenue DESC;


-- 18. Calculate total revenue per Sales Person Name.
 
        SELECT Customer_Name,SUM(Sale_Price) AS total_revenue
        from[P-C Data].[dbo].[1772542271737_pc_data]
        GROUP BY Customer_Name
        ORDER BY total_revenue DESC;

-- 19. Find average Credit Score per Payment Method.
         
         select Payment_Method, AVG(Credit_Score) AS average_credit
         from [P-C Data].[dbo].[1772542271737_pc_data]
         GROUP BY Payment_Method
         ORDER BY average_credit DESC;


-- 20. Calculate total Cost of Repairs per Sales Person Department.

        SELECT Sales_Person_Department, SUM(CAST(cost_of_repairs AS DECIMAL(18,2))) AS total_repair_cost
        from[P-C Data].[dbo].[1772542271737_pc_data]
        GROUP BY Sales_Person_Department
        ORDER BY total_repair_cost;
        

-- ADVANCED QUESTIONS

-- 21. Calculate profit per Shop Name.

        SELECT Shop_Name,SUM(CAST(Sale_Price-Cost_Price AS DECIMAL(18,2))) AS profit_per_shop
        from[P-C Data].[dbo].[1772542271737_pc_data]
        GROUP BY Shop_Name
        ORDER BY profit_per_shop;

   
-- 22. Calculate profit margin per sale ((Sale Price - Cost Price) / Sale Price).

  SELECT 
    Sales_Person_Name,
    Sale_Price,
    Cost_Price,
    CONCAT(
        ROUND(
            ((TRY_CAST(Sale_Price AS DECIMAL(18,2)) - TRY_CAST(Cost_Price AS DECIMAL(18,2))) 
            / NULLIF(TRY_CAST(Sale_Price AS DECIMAL(18,2)), 0)) * 100, 2
        ), '%'
    ) AS profit_margin_percentage
FROM [P-C Data].[dbo].[1772542271737_pc_data]
ORDER BY profit_margin_percentage DESC;

-- 23. Determine which Continent has the highest total revenue.
  
  SELECT 
    Continent,
    SUM(TRY_CAST(Sale_Price AS DECIMAL(18,2))) AS total_revenue
FROM [P-C Data].[dbo].[1772542271737_pc_data]
GROUP BY Continent
ORDER BY total_revenue DESC;
       

-- 24. Calculate average Sale Price per RAM size.
      SELECT 
    RAM,
    ROUND(AVG(TRY_CAST(Sale_Price AS DECIMAL(18,2))), 2) AS avg_sale_price
      FROM [P-C Data].[dbo].[1772542271737_pc_data]
      GROUP BY RAM
      ORDER BY avg_sale_price DESC;

-- 25. Find the PC Model with the highest Sale Price.

 SELECT TOP 1
    PC_Model,
    TRY_CAST(Sale_Price AS DECIMAL(18,2)) AS sale_price
FROM [P-C Data].[dbo].[1772542271737_pc_data]
ORDER BY TRY_CAST(Sale_Price AS DECIMAL(18,2)) DESC;


-- 26. Calculate the average number of days between Purchase Date and Ship Date.

  SELECT 
    ROUND(AVG(CAST(DATEDIFF(DAY, 
        TRY_CAST(Purchase_Date AS DATE), 
        TRY_CAST(Ship_Date AS DATE)
    ) AS DECIMAL(18,2))), 2) AS avg_days_to_ship
FROM [P-C Data].[dbo].[1772542271737_pc_data]
WHERE TRY_CAST(Purchase_Date AS DATE) IS NOT NULL 
  AND TRY_CAST(Ship_Date AS DATE) IS NOT NULL;

-- 27. Determine which Sales Person Department generates the highest revenue.

SELECT 
    Sales_Person_Department,
    SUM(TRY_CAST(Sale_Price AS DECIMAL(18,2))) AS total_revenue
FROM [P-C Data].[dbo].[1772542271737_pc_data]
GROUP BY Sales_Person_Department
ORDER BY total_revenue DESC;


-- 28. Calculate total revenue per Storage Capacity.
 
 SELECT 
    Storage_Capacity,
    SUM(TRY_CAST(Sale_Price AS DECIMAL(18,2))) AS total_revenue
FROM [P-C Data].[dbo].[1772542271737_pc_data]
GROUP BY Storage_Capacity
ORDER BY total_revenue DESC;


-- 29. Identify sales where Sale Price is lower than PC Market Price.

SELECT 
    CASE 
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) < TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'Below Market Price'
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) = TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'At Market Price'
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) > TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'Above Market Price'
    END AS price_status,
    COUNT(*) AS number_of_sales,
    ROUND(SUM(TRY_CAST(Sale_Price AS DECIMAL(18,2))), 2) AS total_revenue
FROM [P-C Data].[dbo].[1772542271737_pc_data]
GROUP BY 
    CASE 
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) < TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'Below Market Price'
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) = TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'At Market Price'
        WHEN TRY_CAST(Sale_Price AS DECIMAL(18,2)) > TRY_CAST(PC_Market_Price AS DECIMAL(18,2)) 
            THEN 'Above Market Price'
    END
ORDER BY number_of_sales DESC;

-- 30. Rank Sales Person Name by Total Sales per Employee using a window function.

    SELECT 
        Sales_Person_Name,
        SUM(Total_Sales_per_Employee) AS total_sales
    FROM  [P-C Data].[dbo].[1772542271737_pc_data]
    GROUP BY Sales_Person_Name
    ORDER BY total_sales DESC;

    
    