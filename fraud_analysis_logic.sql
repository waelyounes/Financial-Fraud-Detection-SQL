/* Project: Financial Fraud Detection & Transaction Analytics
   Author: Dr. Wael Alhajyounes
   Language: PostgreSQL 15
   Description: This script implements statistical anomaly detection logic 
                to identify potential banking fraud and high-risk behaviors.
*/

---------------------------------------------------------
-- SECTION 1: DATABASE STRUCTURE (SCHEMA)
---------------------------------------------------------

-- Drop existing table for a clean environment setup
DROP TABLE IF EXISTS BankTransactions;

-- Create the core transaction table with financial-grade precision
CREATE TABLE BankTransactions (
    TransactionID SERIAL PRIMARY KEY,
    CustomerID INT NOT NULL,
    Amount DECIMAL(12, 2) NOT NULL, -- Precision-based decimal for financial accuracy
    TransactionDate TIMESTAMP NOT NULL,
    Location VARCHAR(100)
);

---------------------------------------------------------
-- SECTION 2: DATA INGESTION (SAMPLE DATASETS)
---------------------------------------------------------

-- Inserting a mix of legitimate and suspicious transaction patterns
INSERT INTO BankTransactions (CustomerID, Amount, TransactionDate, Location) VALUES
-- Customer 101: Baseline normal behavior
(101, 50.00,   '2026-03-01 10:00:00', 'Tampa, FL'),
(101, 75.00,   '2026-03-02 12:00:00', 'Tampa, FL'),
-- FRAUD SIGNAL: Statistical Outlier (Significantly higher than average)
(101, 2000.00, '2026-03-03 14:00:00', 'Miami, FL'), 

-- Customer 102: Baseline normal behavior
(102, 20.00,   '2026-03-04 09:00:00', 'Orlando, FL'),
-- FRAUD SIGNAL: Velocity Attack (Multiple transactions within a 1-minute window)
(102, 25.00,   '2026-03-04 09:01:05', 'Orlando, FL'),
(102, 30.00,   '2026-03-04 09:01:25', 'Orlando, FL'),
(102, 40.00,   '2026-03-04 09:01:50', 'Orlando, FL');

---------------------------------------------------------
-- SECTION 3: ANALYTICAL ENGINE (FRAUD DETECTION LOGIC)
---------------------------------------------------------

-- ANALYSIS A: Comprehensive Data Audit
-- Verifying successful data ingestion and initial transaction overview.
SELECT * FROM BankTransactions ORDER BY TransactionDate;

-- ANALYSIS B: Statistical Outlier Detection (Z-Score Logic)
-- Identifies transactions exceeding 3 times the customer's historical average.
-- This flags anomalies based on individual spending DNA.
SELECT TransactionID, CustomerID, Amount, Location, 'OUTLIER FLAG' as Risk_Status
FROM BankTransactions t1
WHERE Amount > (
    SELECT AVG(Amount) * 3 
    FROM BankTransactions t2 
    WHERE t1.CustomerID = t2.CustomerID
);

-- ANALYSIS C: Transaction Velocity Analysis (High-Frequency Detection)
-- Detects customers with more than 1 transaction within the same minute.
-- Critical for spotting automated bot scripts or skimming devices.
SELECT CustomerID, 
       date_trunc('minute', TransactionDate) as Transaction_Window, 
       COUNT(*) as Transaction_Volume
FROM BankTransactions
GROUP BY CustomerID, Transaction_Window
HAVING COUNT(*) > 1;
