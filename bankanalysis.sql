----------------------------------Demographic Analysis-------------------------------------------
--What is the distribution of customers by age and gender?

-- distribution (18-35) - youth, (35 - 50) - matured, (50+) - Retired
create view "age distribution"  as 
select age, gender,
(case
	when age > 35 then 'matured'
	when age >= 50 then 'retired' 
	else 'youth'
end) as "age distribution"
from public.bankdata b 

select count("age distribution"),gender, "age distribution"  from public."age distribution" ad
group by "age distribution" , gender 


--Which cities have the highest number of customers?
select distinct (city), count ("Customer ID") as "Number of Customers" from bankdata b 
group by city 
order by 2 desc

-------------------------------------Account Analysis-------------------------------------

--What are the different types of accounts and their respective counts?
select "Account Type" , count("Account Type")  from bankdata b 
group by "Account Type" 

--What is the average account balance for different account types?
select avg("Account Balance"), "Account Type"  from bankdata b 
group by "Account Type" 


--How does the account balance vary across different branches?
select distinct("Branch ID") , sum("Account Balance")  from bankdata b 
group by "Branch ID" 
order by 2 desc 

-------------------------Credit Analysis-----------------------------------

--How many customers are currently holding a credit card?
select  "Card Type", count("Customer ID") as "Number of Customers"  from bankdata b 
group by 1

--What is the distribution of credit card balances among customers?
select "Card Type" , sum("Credit Card Balance") as "Balances" from bankdata b
group by 1
order by 2 desc

-------------------------------Loan Analysis-------------------------------------------

-- What is the average loan amount and interest rate for different loan types?
select "Loan Type", round(avg("Loan Amount"), 2) as "Avg Loan Amt", round(avg("Interest Rate"), 2) as "Avg Interest Rate" from bankdata b 
group by 1
order by  2, 3 desc

-- How does the loan status (active, closed) vary with the loan amount and interest rate?
select "Loan Status", "Loan Amount" , "Interest Rate"  from bankdata b 
where "Loan Status" in ('Closed', 'Approved')

---------------------------------Feedback and Resolution Analysis-------------------------------------------

--What are the common types of feedback received from customers?
select "Feedback Type" , count("Feedback Type") as "Number of Feedback"  from bankdata b 
group by 1
order by 2 desc

--How long does it typically take to resolve customer feedback?
SELECT AVG(EXTRACT(EPOCH FROM AGE("Resolution Date", "Feedback Date")) / 86400) AS average_resolution_time_days
FROM bankdata
WHERE "Resolution Date" IS NOT NULL;

