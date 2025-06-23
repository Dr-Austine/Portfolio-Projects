SELECT * FROM Financial_Loan_Data

-- KPI
--================================================---
-- Total Loan Application received 
--================================================--
SELECT COUNT(id) AS Total_Loan_Applications FROM Financial_Loan_Data

-- Month To Date Loan Application
SELECT COUNT(id) AS Total_Applications FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021

-- PMonth To Date Loan Application
SELECT COUNT(id) AS Total_Applications FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



--================================================---
-- Total Funded Amount
--================================================---
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



--================================================---
-- Total Amount Received
--================================================---
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



--================================================---
-- Average Interest Rate
--================================================---
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM Financial_Loan_Data

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



--================================================---
-- Avg DTI
--================================================---
SELECT AVG(dti)*100 AS Avg_DTI FROM Financial_Loan_Data

-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12

-- PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 11



--=====================================================---
--GOOD LOAN ISSUED
--=======================================================--
--- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM Financial_Loan_Data

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM Financial_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM Financial_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM Financial_Loan_Data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'



--=====================================================---
--BAD LOAN ISSUED
--=======================================================--
--- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM Financial_Loan_Data

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM Financial_Loan_Data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM Financial_Loan_Data
WHERE loan_status = 'Charged Off'

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM Financial_Loan_Data
WHERE loan_status = 'Charged Off'


--=====================================================---
--LOAN  STATUS
--=======================================================--
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        Financial_Loan_Data
    GROUP BY
        loan_status


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM Financial_Loan_Data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


--=====================================================---
--BANK LOAN REPORT | OVERVIEW
--=======================================================--

-- MONTHLY REPORT
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


-- STATE REPORT
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
GROUP BY address_state
ORDER BY address_state



-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
GROUP BY term
ORDER BY term


-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
GROUP BY emp_length
ORDER BY emp_length


-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data	
GROUP BY purpose
ORDER BY purpose


-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
GROUP BY home_ownership
ORDER BY home_ownership


-- To view the purpose of the loan, total loan application, funded amount and total received  where the loan was graded "A" in the data since 2021
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM Financial_Loan_Data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose





