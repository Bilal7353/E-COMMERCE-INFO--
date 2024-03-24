Use [SQL_Project_1]

Select * from Customer
Select * from Transactions
Select * from prod_cat_info
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                           SQL_Project_1
                              ** Data Preparation and Understanding **

**Q1. What is the total number of rows in each of the 3 tables in the database?
          
*Query.           SELECT COUNT(*) as Customers FROM Customer
                  SELECT COUNT(*) as Transactions FROM Transactions
                  SELECT COUNT(*) as Product_Cat_info FROM prod_cat_info


**Q2. What is the total number of transactions that have a return?
          
*Query.		      SELECT COUNT(*) as No_of_transactions FROM Transactions
                  WHERE total_amt < 0

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

**Q4. Which product category does the sub- category "DIY" belong to?
          
*Query.		     SELECT * FROM prod_cat_info
		         WHERE prod_subcat = 'DIY'

*Methods Used.   "SELECT" STATEMENT
                 "WHERE" CLAUSE

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

**Q2. What is the count of Male and Female customers in the database?
          
*Query.		     SELECT Gender, COUNT(*) AS Count FROM Customer
	             WHERE Gender IS NOT NULL
		         GROUP BY Gender

*Methods Used.   "SELECT" STATEMENT
                 "COUNT" FUNCTION
				 "WHERE" CLAUSE
				 "GROUP BY" CLAUSE

*Schema.         2 variables and 2 rows

             grouping the data by gender.


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


**Q5. What is the maximum quantity of products ever ordered?
	  
*Query. 	     SELECT MAX(Qty) AS Maximum_Quantity FROM Transactions

*Methods Used.   "SELECT" STATEMENT
                 "MAX" FUNCTION

*Schema.         1 variable and 1 row



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

es involving customers aged between 25 and 35 years.



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

