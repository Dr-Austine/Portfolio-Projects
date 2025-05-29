SELECT * FROM Financial_Loan_Data

-- Total Loan Application received 
SELECT COUNT(id) AS Total_Loan_Applications FROM Financial_Loan_Data

-- Month To Date Loan Application
SELECT COUNT(id) AS Total_Applications FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMonth To Date Loan Application
SELECT COUNT(id) AS Total_Applications FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11




-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11




-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



-- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM Financial_Loan_Data

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11
