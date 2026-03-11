# 🏦 Financial Fraud Detection & Transaction Analytics (SQL)

## 📌 Project Overview
This project demonstrates the application of **Statistical Anomaly Detection** within a relational database environment (PostgreSQL). As a University Professor transitioning into Applied AI and Data Science, I designed this suite to showcase how mathematical logic can be integrated into SQL to identify high-risk financial activities.

The core objective is to move beyond basic data retrieval and implement **Risk Mitigation** rules that simulate real-world banking security protocols used by institutions like Citi.

---

## 🔬 Analytical Methodologies & Logic

### 1. Statistical Outlier Detection (Relative Mean Analysis)
Rather than using arbitrary fixed limits, this system evaluates transactions relative to a **Customer’s Historical Mean ($\mu$)**. 
* **Logic:** Any transaction exceeding $3 \times \mu$ for a specific user is flagged as an outlier.
* **Mathematical Impact:** This approach accounts for individual variance and reduces false positives in fraud detection.

### 2. Transaction Velocity Analysis (Time-Series Filtering)
To combat automated attacks or "Card Skimming," the system monitors the frequency of transactions within a short temporal window.
* **Logic:** Utilizing the `date_trunc` function to detect multiple transactions occurring within the same 60-second window for a single account.
* **Impact:** Identifies high-speed, automated fraud patterns that are often missed by standard reporting.

### 3. Aggregate Risk Profiling (KYC Analytics)
The suite generates a behavioral "DNA" for each user using statistical aggregate functions.
* **Metrics:** Average Ticket Size, Maximum Exposure, and Transaction Volume per customer.

---

## 🛠 Tech Stack
* **Database Engine:** PostgreSQL 15
* **Core Skills:** Advanced Subqueries, Aggregations, Window Functions, and Data Type Precision (`DECIMAL`).

---

## 📂 Repository Contents
* `fraud_analysis_logic.sql`: A single, production-ready script containing the Schema setup, Sample Data, and the Analytical Engine.

---

## 🚀 Execution Instructions
1. Copy the code from `fraud_analysis_logic.sql`.
2. Run it in any PostgreSQL-compliant environment (e.g., [DB-Fiddle](https://www.db-fiddle.com) or a local instance).
3. Review the **Results Panel** to see the detected flags for "Outliers" and "Velocity Attacks."

---

## 📧 Contact & Professional Inquiries
**Dr. Wael Alhajyounes** *PhD in Mathematics | University Professor | AI & Machine Learning Researcher* 📍 Based in Tampa, Florida  
[LinkedIn Profile] | [GitHub Portfolio]
