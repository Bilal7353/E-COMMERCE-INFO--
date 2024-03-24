Use [SQL_Project_1]

Select * from Customer
Select * from Transactions
Select * from prod_cat_info

-- To Check the tables. 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                           SQL_Project_1
                              ** Data Preparation and Understanding **

**Q1. What is the total number of rows in each of the 3 tables in the database?
          
*Query.           SELECT COUNT(*) as Customers FROM Customer
                  SELECT COUNT(*) as Transactions FROM Transactions
                  SELECT COUNT(*) as Product_Cat_info FROM prod_cat_info

*Methods Used.    "SELECT" STATEMENT
                  "COUNT"  FUNCTION

*Explanation.     The SQL query consists of three separate "SELECT" statements.
                  Each "SELECT" statement retrieves data from a different table: "Customer", "Transactions", and "prod_cat_info".
                  "COUNT(*)" is an aggregate function used to count the number of rows in each table.
                  The "AS" is a keyword which is used to assign aliases to the count results, making them more readable.
                  By placing multiple "SELECT" statements in the same script and separating them with semicolons, the SQL engine executes each statement sequentially and returns the results as separate result sets.
                  This allows you to retrieve counts of rows from multiple tables in a single database round-trip, making the query more efficient compared to executing each "SELECT" statement separately.



**Q2. What is the total number of transactions that have a return?
          
*Query.		      SELECT COUNT(*) as No_of_transactions FROM Transactions
                  WHERE total_amt < 0

*Methods Used.    "SELECT" STATEMENT
                  "COUNT" FUNCTION
				  "WHERE" CLAUSE

*Explanation.     The "SELECT" statement is used to retrieve data from the database.
                  "COUNT(*)" is an aggregate function that counts the number of rows returned by the query.
                  "FROM" Transactions specifies the table from which to retrieve the data, in this case, the "Transactions" table.
                  "WHERE" total_amt < 0 is a condition that filters the rows to include only those where the total_amt column has a value less than 0. This condition checks for transactions with negative total amounts, which typically indicates returns or refunds.



**Q3. What is the time range of the transaction data available for analysis? Show the output in number of days, months and years simultaneously in different columns.

*Query.	       	 SELECT
                 DATEDIFF(DAY, MIN(tran_date), MAX(tran_date)) AS total_days,
                 DATEDIFF(MONTH, MIN(tran_date), MAX(tran_date)) AS total_months,
                 DATEDIFF(YEAR, MIN(tran_date), MAX(tran_date)) AS total_years
                 FROM Transactions

*Methods Used.   "SELECT" STATEMENT
                 "DATEDIFF" FUNCTION
				 "MIN" FUNCTION
				 "MAX" FUNCTION

*Explanation.    The "DATEDIFF" function is used three times to calculate the difference between the minimum (MIN(tran_date)) and maximum (MAX(tran_date)) transaction dates.
                 The first "DATEDIFF" calculates the difference in days (DAY).
                 The second "DATEDIFF" calculates the difference in months (MONTH).
                 The third "DATEDIFF" calculates the difference in years (YEAR).
                 The result of each "DATEDIFF" function call is stored in its respective alias: total_days, total_months, and total_years.
				 This Query calculates the total number of days, months, and years between the earliest and latest transaction dates in the "Transactions" table, providing insight into the time range covered by the transaction data.



**Q4. Which product category does the sub- category "DIY" belong to?
          
*Query.		     SELECT * FROM prod_cat_info
		         WHERE prod_subcat = 'DIY'

*Methods Used.   "SELECT" STATEMENT
                 "WHERE" CLAUSE

*Explanation.    The "SELECT" statement retrieves all columns from the specified table.
                 The "WHERE" clause filters the rows returned by the query based on a specified condition. In this query, the condition is prod_subcat = 'DIY', which filters the rows to include only those where the value in the "prod_subcat" column is equal to 'DIY'.




                                        ** Data Analysis **

**Q1. Which channel is most frequently used for transactions?
          
*Query.		     SELECT TOP 1 Count(*) AS Most_Used, Store_type FROM Transactions
                 GROUP BY Store_type
	             ORDER BY Most_Used desc

*Methods Used.   "SELECT" STATEMENT
                 "COUNT" FUNCTION
				 "GROUP BY" CLAUSE
				 "ORDER BY" CLAUSE

*Schema.         2 vairables and 1 row

*Explanation.    The "SELECT TOP 1" statement is used to retrieve only the top 1 row from the result set.
                 "COUNT(*)" is an aggregate function that counts the number of rows for each group.
                 "GROUP BY" is a Clause which groups the rows of the "Transactions" table by the values in the "Store_type" column.
                 "ORDER BY" is a Clause which orders the groups based on the count of rows within each group.
				 "DESC" is a keyword used in the ORDER BY clause to specify the sort order as descending.
                 "TOP 1" selects only the first row from the ordered result set, which represents the store type with the highest count of transactions.



**Q2. What is the count of Male and Female customers in the database?
          
*Query.		     SELECT Gender, COUNT(*) AS Count FROM Customer
	             WHERE Gender IS NOT NULL
		         GROUP BY Gender

*Methods Used.   "SELECT" STATEMENT
                 "COUNT" FUNCTION
				 "WHERE" CLAUSE
				 "GROUP BY" CLAUSE

*Schema.         2 variables and 2 rows

*Explanation.    The "SELECT" statement retrieves data from the specified columns in the "Customer" table.
                 "COUNT(*)" is an aggregate function that counts the number of rows for each group.
                 "WHERE" is a Clause which filters the rows to include only those where the value in the "Gender" column is not null. This ensures that only customers with a known gender are considered.
                 "GROUP BY" clause groups the rows of the "Customer" table by the values in the "Gender" column.
                 Therefore, the query calculates the count of customers for each gender category, grouping the data by gender.



**Q3. From which city do we have the maximum number of customers and how many?
      
*Query.	         SELECT TOP 1 city_code, COUNT(*) AS Customer_count
                 FROM Customer
                 GROUP BY city_code
                 ORDER BY Customer_count DESC

*Methods Used.   "SELECT" STATEMENT
                 "COUNT" FUNCTION
				 "GROUP BY" CLAUSE
				 "ORDER BY" CLAUSE

*Schema.         2 variables and 1 row

*Explanation.    The SELECT TOP 1 statement is used to retrieve only the top 1 row from the result set.
                 COUNT(*) AS Customer_count is an aggregate function that counts the number of rows for each group.
                 The GROUP BY city_code clause groups the rows of the "Customer" table by the values in the "city_code" column.
                 The ORDER BY Customer_count DESC clause orders the groups in descending order based on the count of customers (Customer_count), with the city code having the highest count appearing first in the result set.
                 Therefore, the query calculates the count of customers for each city code, grouping the data by city code, and retrieves only the city code with the highest count of customers.



**Q4. How many sub-categories are there under the Books category?
       
*Query. 	     SELECT COUNT(Distinct prod_subcat) AS sub_cat_count
                 FROM prod_cat_info
                 WHERE prod_cat = 'Books'
		         GROUP BY prod_cat

*Methods Used.   "SELECT" STATEMENT
                 "COUNT" FUNCTION
				 "DISTINCT"
				 "WHERE" CLAUSE
				 "GROUP BY" CLAUSE

*Schema.         2 variables and 1 row

*Explanation.    The "SELECT" statement retrieves data from the specified columns in the "prod_cat_info" table.
                 "COUNT" is an aggregate function that counts the number of distinct values in the "prod_subcat" column.
				 "DISTINCT" is a keyword which is used within the COUNT() function to ensure that only unique values of the prod_subcat column are counted.
                 "WHERE" clause filters the rows to include only those where the value in the "prod_cat" column is equal to 'Books'. This restricts the count of distinct product subcategories to only those belonging to the "Books" category.
                 "GROUP BY" clause groups the rows of the "prod_cat_info" table by the values in the "prod_cat" column. Although it's not strictly necessary since there is only one category specified in the WHERE clause, it's included for clarity.
                 Therefore, the query calculates the count of distinct product subcategories for the "Books" category, grouping the data by the "Books" category.



**Q5. What is the maximum quantity of products ever ordered?
	  
*Query. 	     SELECT MAX(Qty) AS Maximum_Quantity FROM Transactions

*Methods Used.   "SELECT" STATEMENT
                 "MAX" FUNCTION

*Schema.         1 variable and 1 row

*Explanation.    "SELECT" statement retrieves data from the specified columns in the "Transactions" table.
                 "MAX" is an aggregate function that calculates the maximum value of the Qty column.
                 Therefore, the query calculates the maximum value of the Qty column in the "Transactions" table, returning it as "Maximum_Quantity".



**Q6. What is the net total revenue generated in categories Electronics and Books?
         
*Query. 		  SELECT SUM(total_amt) AS Total_Revenue, prod_cat FROM Transactions t 
                  Inner Join prod_cat_info p 
                  on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
	              Group by p.prod_cat
	              Having p.prod_cat IN ('Electronics', 'Books')

*Methods Used.    "SELECT" STATEMENT
                  "SUM" FUNCTION
                  "JOINS"
				  "GROUP BY" CLAUSE
				  "HAVING" CLAUSE

*Schema.          2 variables and 2 rows

*Explanation.     "SELECT" statement retrieves data from the specified columns in the "Transactions" table.
                  "SUM" is an aggregate function used to calculate the total sum of values in the total_amt column of a table.
                  "Join" used to combine rows from two or more tables based on related columns between them.
                  "GROUP BY" clause groups the results by the prod_cat column from the "prod_cat_info" table.
                  "HAVING" clause filters the grouped results to only include rows where the product category is either 'Electronics' or 'Books'.



**Q7. How many customers have >10 transactions with us, excluding returns?
      
*Query.	          SELECT cust_id, COUNT(transaction_id) AS transaction_count FROM Transactions
                  WHERE total_amt > 0
                  GROUP BY cust_id
                  HAVING COUNT(transaction_id) > 10

*Methods Used.    "SELECT" STATEMENT
                  "COUNT" FUNCTION
				  "WHERE"CLAUSE
				  "GROUP BY" CLAUSE
				  "HAVING" CLAUSE

*Schema.          2 variables and 6 rows

*Explaination.    "SELECT" statement retrieves data from the specified columns in the "Transactions" table.
                  "COUNT" is an aggregate function that counts the number of non-null values in the transaction_id column for each group.
                  "WHERE" clause filters the rows to include only those where the value in the total_amt column is greater than 0. This ensures that only transactions with positive total amounts are considered.
                  "GROUP BY" clause groups the rows of the "Transactions" table by the values in the cust_id column.
                  "HAVING" clause filters the grouped results to only include rows where the count of transactions for each customer (transaction_id) is greater than 10. This ensures that only customers with more than 10 transactions are included in the result set.
	       


**Q8. What is the combined revenue earned from the "Electronics " & "Clothing" categories, from "Flagship stores"?

*Query.	          Select round(Sum(total_amt), 2) as combined_revenue, Store_type from Transactions t
	              Inner join prod_cat_info p
	              on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
                  Where p.prod_cat IN ('Electronics', 'Clothing')
	              Group by store_type
	              Having store_type = 'Flagship store'

*Methods Used.    "SELECT" STATEMENT
                  "ROUND" FUNCTION
                  "SUM" AGGREGATE FUNCTION
				  "JOINS"
				  "WHERE" CLAUSE
				  "GROUP BY" CLAUSE
				  "HAVING" CLAUSE

*Schema.          2 variables and 1 row

*Explanation.     "SELECT" statement retrieves data from the specified columns in the "Transactions" table.
                  "ROUND" is a function used to round a numeric value to a specified number of decimal places.
                  "SUM" is an aggregate function used to calculate the total sum of values in the total_amt column of a table.
                  "INNER JOIN" used to combine rows from two or more tables based on related columns between them.
                  "WHERE" clause filters the joined result to include only rows where the prod_cat in the "prod_cat_info" table is either 'Electronics' or 'Clothing'.
                  "GROUP BY" clause groups the rows of the result set by the store_type column from the "Transactions" table.
                  "HAVING" clause filters the grouped results to only include rows where the store_type is 'Flagship store'.
                  Therefore, the query calculates the combined revenue for 'Electronics' and 'Clothing' products sold at 'Flagship store' locations, grouping the results by store type.



**Q9. What is the total revenue generated from "Male" customers in "Electronics" category? Output should display total revenue by prod sub-cat.

*Query.           SELECT prod_cat, prod_subcat, SUM(total_amt) AS total_revenue FROM Customer c
                  JOIN Transactions t ON c.customer_Id = t.cust_id
                  JOIN prod_cat_info p ON t.prod_cat_code = p.prod_cat_code AND t.prod_subcat_code = p.prod_sub_cat_code
                  WHERE total_amt > 0 and Gender = 'M'
		          GROUP BY prod_cat, prod_subcat
		          Having prod_cat = 'Electronics'

*Methods Used.    "SELECT" STATEMENT
                  "SUM" FUNCTION
				  "JOINS"
				  "WHERE" CLAUSE
				  "GROUP BY" CLAUSE
				  "HAVING" CLAUSE

*Schema.          3 variables and 5 rows

*Explanation.     "SELECT" statement retrieves data from the specified columns in the "Transactions" table.
                  "SUM" is an aggregate function used to calculate the total sum of values in the total_amt column of a table.
                  "JOIN" used to combine rows from two or more tables based on related columns between them.
                  "WHERE" clause filters the rows to include only those where total_amt is greater than 0 and Gender is 'M' (for male customers).
                  "GROUP BY" clause groups the result set by prod_cat and prod_subcat, meaning that the sum of total_amt will be calculated for each unique combination of product category and subcategory.
                  "HAVING" clause filters the grouped results to include only rows where prod_cat is 'Electronics'.

		 

**Q10. What is percentage of sales and returns by product sub catgory; display only top 5 sub categories in terms of sales?

*Query.           Select Top 5 (prod_subcat), Sum(total_amt) as Sales from Transactions t
		          Inner join prod_cat_info p
		          on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
		          where t.total_amt > 0
		          group by prod_subcat
		          Order by Sales Desc
		 
		          WITH perABS
		          as(SELECT TOP 5 (prod_subcat),
		              ABS(SUM(CASE WHEN total_amt < 0 THEN total_amt ELSE 0 END)) as Returns,
			          SUM(CASE WHEN total_amt > 0 THEN total_amt ELSE 0 END) as Sales
			          FROM Transactions t
			          INNER JOIN prod_cat_info p
			          on t.prod_cat_code = p.prod_cat_code and t.prod_subcat_code = p.prod_sub_cat_code
			          GROUP BY prod_subcat
			          ORDER BY Sales DESC)
					  SELECT prod_subcat, ROUND((((Returns + Sales)/ Returns)*100), 2) AS Return_percent,
					  ROUND((((Returns + Sales)/ Sales)*100), 2) AS Sales_percent FROM perABS
					 

*Methods Used.    "SELECT" STATEMENT
                  "SUM" FUNCTION
				  "JOINS"
				  "WHERE" CLAUSE
				  "GROUP BY" CLAUSE
				  "ORDER BY" CLAUSE
				  "CTE's"

*Schema.          2 variables and 5 rows, 3 Variables and 5 rows

*Explanation.     "Main Query"
                  "SELECT" statement selects the top 5 prod_subcat values and calculates the sum of total_amt as Sales.
                  "JOIN" are used to join these tables based on their related columns: prod_cat_code and prod_subcat_code.
                  "WHERE" clause filters the rows to include only those where total_amt is greater than 0.
                  "GROUP BY" clause groups the result set by prod_subcat, allowing the calculation of the sum of total_amt for each product subcategory.
                  "ORDER BY" clause sorts the grouped results by Sales in descending order.
                  
				  "Common Table Expression (CTE)": The query defines a CTE named perABS.
                  "SELECT" statement within CTE: It selects the top 5 prod_subcat values.
                  "ABS" and "SUM" :It calculates the absolute sum of quantities for returns and the sum of quantities for sales for each product subcategory.
                  The "JOIN" are used to join these tables based on their related columns: prod_cat_code and prod_subcat_code.
                  "GROUP BY" clause within CTE: It groups the result set by prod_subcat, allowing the calculation of returns and sales for each product subcategory.
                  "ORDER BY" clause within CTE: It sorts the grouped results by Sales in descending order.
                  The CTE is first evaluated to obtain the returns and sales for the top 5 product subcategories.
                  Then, the main query selects data from the CTE and calculates the percentages.
                  The percentages are calculated using the formula: (Returns or Sales / (Returns + Sales)) * 100.
                  The ROUND function is applied to round the calculated percentages to two decimal places.


  
**Q11. For all customers aged between 25 to 35 years find what is the net total revenue generated by these consumers in last 30 days of transactions from max transaction date available in the data?

*Query.            SELECT TOP 30 (tran_date) FROM Transactions
			       GROUP BY tran_date
			       ORDER BY tran_date DESC

			       WITH ABC
			       AS(SELECT TOP 30 (tran_date), SUM(total_amt) AS Total_amount FROM Customer c
			       INNER JOIN Transactions t
			       ON t.cust_id = c.customer_id
			       WHERE DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN 25 AND 35
			       GROUP BY tran_date
			       ORDER BY tran_date DESC)
			       SELECT SUM(Total_amount) AS Final_revenue FROM ABC

*Methods Used.     "SELECT" STATEMENT
                   "SUM" FUNCTION
				   "WHERE" CLAUSE
				   "GETDATE" FUNCTION
				   "GROUP BY" CLAUSE
				   "ORDER BY" CLAUSE
				   "DATEDIFF" FUNCTION
				   "MAX" FUNCTION

*Schema.           1 variable and 30 rows, 1 variable and 1 row

*Explanation.      "Main Query":
                   It selects the top 30 distinct tran_date values from the "Transactions" table.
                   The GROUP BY clause ensures that only distinct tran_date values are returned.
                   The ORDER BY clause orders the results by tran_date in descending order.
                   
				   "Common Table Expression (CTE)":
                   The query defines a CTE named ABC.
                   The CTE calculates the total amount for each of the top 30 tran_date values.
                   It selects the top 30 distinct tran_date values from the "Transactions" table.
                   It joins the "Customer" and "Transactions" tables based on the customer ID (cust_id) to obtain the total amount for each transaction date.
                   It filters the customers based on their age, selecting only those aged between 25 and 35 years.
                   The GROUP BY clause groups the results by tran_date, aggregating the total amount for each transaction date.
                   The ORDER BY clause orders the results by tran_date in descending order.
                   
				   "Final Query":
                   It calculates the sum of the Total_amount column from the CTE ABC.
                   This gives the final revenue generated from transactions corresponding to the top 30 transaction dates involving customers aged between 25 and 35 years.



**Q12. Which product category has seen the max value of returns in the last 3 months of transactions?
        
*Query. 		   SELECT prod_cat, COUNT(Qty) AS No_of_returns FROM Transactions t
                   INNER JOIN prod_cat_info p 
		           ON t.prod_cat_code = p.prod_cat_code
		           WHERE total_amt < 0 AND DATEDIFF(month, '2014-09-01',tran_date)=3
		           GROUP BY prod_cat

		           -- product category having maximum vaku of returns in last three months

		           WITH ABC
		           AS(SELECT prod_cat, transaction_id, total_amt
		           FROM Transactions t
		           INNER JOIN prod_cat_info p
		           ON t.prod_cat_code = p.prod_cat_code
		           WHERE total_amt < 0 AND DATEDIFF(MONTH, '2014-09-01',tran_date)=3)
		           SELECT ABS(SUM(total_amt)) AS Return_amount_cat FROM ABC

*Methods Used.     "SELECT" STATEMENT
                   "COUNT" FUNCTION
				   "JOIN"
				   "WHERE" CLAUSE
				   "GROUP BY" CLAUSE
				   "DATEDIFF" FUNCTION
				   "SUM" FUNCTION

*Schema.           2 variable and 1 row, 1 variable and 1 row

*Explanation.      "Main Query":
                   "SELECT" AND "COUNT" selects the product category (prod_cat) and counts the quantity (Qty) of returns for each product category.
                   "JOIN" - Joins the "Transactions" and "prod_cat_info" tables based on the product category code (prod_cat_code).
                   "WHERE" Clause filters the rows to include only those where the total_amt is less than 0.
                   It further filters the rows based on the transaction date (tran_date) being exactly 3 months after September 1, 2014.
                   "GROUP BY" Clause groups the product category.
                   
				   "Common Table Expression (CTE)":
                   The query defines a CTE named ABC.
                   The CTE selects the product category, transaction ID, and total amount for returns.
                   It joins the "Transactions" and "prod_cat_info" tables similar to the main query.
                   It filters the rows to include only those where the total_amt is less than 0 (indicating returns) and the transaction date is exactly 3 months after September 1, 2014.
                   
				   "Final Query":
                   It selects the absolute sum of total return amount (total_amt) from the CTE ABC.
                   The ABS() function ensures that the return amount is treated as a positive value.
                   This gives the total return amount for all product categories exactly 3 months after September 1, 2014.



**Q13. Which store-type sells the maximum products; by value of sales amount and by quantity sold?

*Query.            SELECT Top 1 store_type, ROUND(SUM(total_amt), 2) AS total_sales FROM Transactions
                   GROUP BY store_type
                   ORDER BY total_sales DESC

	               WITH SalesByAmount AS (
                   SELECT store_type, ROUND(SUM(total_amt), 2) AS total_sales FROM Transactions
                   GROUP BY store_type
                   ),
                   SalesByQuantity AS (
                   SELECT store_type, SUM(Qty) AS total_quantity_sold FROM Transactions
                   GROUP BY store_type
                   )
                   SELECT 'By Amount' AS sales_criteria, sba.store_type, sba.total_sales FROM SalesByAmount sba
                   WHERE sba.total_sales = (SELECT MAX(total_sales) FROM SalesByAmount)
                   UNION ALL
                   SELECT 'By Qty' AS sales_criteria, sbq.store_type, sbq.total_quantity_sold FROM SalesByQuantity sbq
                   WHERE sbq.total_quantity_sold = (SELECT MAX(total_quantity_sold) FROM SalesByQuantity)

*Methods Used.     "SELECT" STATEMENT
                   "SUM" FUNCTION
				   "GROUP BY" CLAUSE
				   "ORDER BY" CLAUSE
				   "WHERE" CLAUSE
				   "MAX" FUNCTION

*Schema.           2 variables and 1 row, 3 variables and 2 rows

*Explanation.      "Main Query":
                   It selects the top 1 store_type and the rounded sum of total_amt as total_sales from the "Transactions" table.
                   The results are grouped by store_type.
                   The results are ordered by total_sales in descending order.
                   
				   "Common Table Expressions (CTEs)":
                   Two CTEs are defined: SalesByAmount and SalesByQuantity.
                   SalesByAmount calculates the total sales amount for each store_type by summing the total_amt column.
                   SalesByQuantity calculates the total quantity sold for each store_type by summing the Qty column.
                   
				   "Final Query":
                   It selects data from the two CTEs.
                   For SalesByAmount, it selects the store_type and total_sales.
                   It filters the results to only include the row where the total_sales is equal to the maximum total_sales among all store_type values.
                   For SalesByQuantity, it selects the store_type and total_quantity_sold.
                   It filters the results to only include the row where the total_quantity_sold is equal to the maximum total_quantity_sold among all store_type values.
                   "UNION ALL":
                   The results from the two CTEs are combined using the UNION ALL operator.
                   This combines the results vertically, creating one result set that includes data from both CTEs.



**Q14. What are the categories for which average revenue is above the overall average.
          
*Query.	           WITH CategoryAverage AS (
                   SELECT p.prod_cat, ROUND(AVG(total_amt), 2) AS average_revenue, (SELECT ROUND(AVG(total_amt), 2) FROM Transactions) AS overall_average_revenue FROM Transactions t
                   JOIN prod_cat_info p ON t.prod_cat_code = p.prod_cat_code
                   GROUP BY p.prod_cat
                   )
                   SELECT prod_cat, average_revenue FROM CategoryAverage
                   WHERE average_revenue > overall_average_revenue

*Methods Used.     "SELECT" STATEMENT
                   "ROUND" FUNCTION
				   "SUM" FUNCTION
				   "AVERAGE" FUNCTION
				   "JOIN"
				   "GROUP BY" CLAUSE
				   "WHERE"CLAUSE

*Schema.           2 variables and 3 rows

*Explanation.      "Common Table Expression (CTE)":
                   The query defines a CTE named CategoryAverage.
                   It calculates the average revenue for each product category (prod_cat) by rounding the average of the total_amt column to two decimal places.
                   It calculates the overall average revenue across all transactions using a subquery within the SELECT clause. This subquery retrieves the average of the total_amt column from the entire "Transactions" table and also rounds it to two decimal places.
                   The results are grouped by prod_cat.

                   "Final Query":
                   The main query selects prod_cat and average_revenue from the CategoryAverage CTE.
                   It filters the results using a WHERE clause to include only those rows where the average_revenue for a product category is greater than the overall_average_revenue across all transactions.
                   This comparison allows identifying product categories whose average revenue is above the overall average revenue.



**Q15. Find the average and total revenue by each subcategory for the categories which are among top 5 categories in terms of quantity sold.

*Query.            SELECT TOP 5(prod_cat), COUNT(Qty) AS Quantity_Sold FROM Transactions t
                   INNER JOIN prod_cat_info p
                   ON t.prod_cat_code = t.prod_cat_code
                   WHERE total_amt > 0
                   GROUP BY prod_cat
                   ORDER BY Quantity_Sold DESC
                   SELECT prod_cat, prod_subcat, ROUND(SUM(total_amt), 3) AS Total_amount, ROUND(AVG(total_amt), 3) AS Avg_amount FROM Transactions t
                   INNER JOIN prod_cat_info p
                   ON t.prod_cat_code = p.prod_cat_code
                   WHERE total_amt > 0 AND prod_cat IN ('Books', 'Electronics', 'Home and kitchen', 'Footwear', 'Clothing')
                   GROUP BY prod_cat, prod_subcat
                   ORDER BY CASE WHEN prod_cat = 'Books' THEN 1
                                 WHEN prod_cat = 'Electronics' THEN 2
			                     WHEN prod_cat = 'Home and kitchen' THEN 3
			                     WHEN prod_cat = 'Footwear' THEN 4
			                     ELSE 5
			                     END
								 
*Methods Used.     "SELECT" STATEMENT
                   "COUNT" FUNCTION
				   "JOIN"
				   "WHERE" CLAUSE
				   "GROUP BY" CLAUSE
				   "ORDER BY" CLAUSE
				   "ROUND" FUNCTION
				   "SUM" FUNCTION
				   "AVERAGE" FUNCTION

*Schema.           2 variables and 5 rows, 4 variables and 21 rows

*Explanation.      First Query (Top 5 Product Categories by Quantity Sold):
                   It selects the top 5 product categories (prod_cat) based on the count of quantities sold (Qty) from the "Transactions" table.
                   Joins the "Transactions" and "prod_cat_info" tables based on the product category code.
                   Filters the rows to include only those with positive total_amt values (indicating sales).
                   Groups the results by product category.
                   Orders the results by Quantity_Sold in descending order.
                   
				   Second Query (Total and Average Amount by Product Subcategory):
                   It selects the product category (prod_cat), product subcategory (prod_subcat), total amount (total_amt), and average amount (total_amt) from the "Transactions" table.
                   Joins the "Transactions" and "prod_cat_info" tables based on the product category code.
                   Filters the rows to include only those with positive total_amt values and where the product category is one of ('Books', 'Electronics', 'Home and kitchen', 'Footwear', 'Clothing').
                   Groups the results by product category and product subcategory.
                   Orders the results using a CASE statement to sort the product categories in a specific order ('Books', 'Electronics', 'Home and kitchen', 'Footwear', 'Clothing').

