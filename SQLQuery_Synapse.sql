CREATE VIEW vw_loan_default_data AS 
SELECT *
FROM
    OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]




/* ---------Aggregated Summary View------------------- */

CREATE VIEW overall_summary AS
SELECT
    AVG(CAST(rate_of_interest AS float)) AS rate_of_interest,
    AVG(CAST(interest_rate_spread AS float)) AS avg_interest_rate_spread,
    AVG(CAST(upfront_charges AS float)) AS avg_upfront_charges,
    AVG(CAST(property_value AS float)) AS avg_property_value,
    AVG(CAST(ltv AS float)) AS ltv,
    AVG(CAST(dtir1 AS float)) AS dtir1,
    AVG(CAST(income AS float)) AS income,
    AVG(CAST(loan_amount AS float)) AS loan_amount,
    AVG(CAST(term AS float)) AS term
FROM 
    OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result];






    /* ---------Default Rate by Term View------------------- */

CREATE VIEW default_rate_wrt_term AS
SELECT 
    term, 
    COUNT(*) AS total_loans,
    SUM(CASE WHEN status = '1' THEN 1 ELSE 0 END) AS defaults,
    (SUM(CASE WHEN status = '1' THEN 1.0 ELSE 0 END) / COUNT(*)) * 100 AS default_rate_percentage
FROM 
    OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
GROUP BY 
    term;


/* ---------Income vs. Default Status View------------------- */
CREATE VIEW default_rate_vs_income AS
SELECT 
    income,
    SUM(CASE WHEN status = '1' THEN 1 ELSE 0 END) AS defaults,
    COUNT(*) AS total_cases,
    (SUM(CASE WHEN status = '1' THEN 1.0 ELSE 0 END) / COUNT(*)) * 100 AS default_rate_percentage
FROM OPENROWSET(
    BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY income;

/* ---------Income vs. loan value View------------------- */
CREATE VIEW loan_value_given_by_income AS
SELECT 
    income,
    AVG(CAST(loan_amount AS float)) AS avg_loan_amount, -- Cast to float to prevent overflow
    AVG(CASE WHEN income > 0 THEN CAST(loan_amount AS float) / CAST(income AS float) ELSE NULL END) AS avg_loan_to_income_ratio -- Handle divide by zero and prevent overflow
FROM 
    OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
GROUP BY income;





/* ---------Default Status Count View------------------- */
CREATE VIEW default_status_count AS
SELECT 
    status,
    COUNT(*) AS total_count
FROM 
        OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
GROUP BY 
    status;



/* ---------Aggregate Sum of Defaulted Money------------------- */

CREATE VIEW sum_defaulted_money AS
SELECT
    SUM(CASE WHEN status = '1' THEN CAST(loan_amount AS float) ELSE 0 END) AS total_defaulted_value,
    SUM(CASE WHEN status <> '1' THEN CAST(loan_amount AS float) ELSE 0 END) AS total_non_defaulted_value
FROM
    OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result];




/* --------Demographics and Loan Type Analysis------------------ */
CREATE VIEW demographics_loan_type AS
SELECT
    age,
    region,
    
    COUNT(*) AS total_loans,
    SUM(CASE WHEN status = '1' THEN 1 ELSE 0 END) AS defaults,
    (SUM(CASE WHEN status = '1' THEN 1.0 ELSE 0 END) / COUNT(*)) * 100 AS default_rate_percentage
FROM
        OPENROWSET(
        BULK 'https://datalake0012anee.dfs.core.windows.net/cleaned-data/part-00000-tid-7697308539041981515-27aaa0f5-4431-4951-a4f1-808c894fcc6e-185-1.c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
GROUP BY
    age, region;