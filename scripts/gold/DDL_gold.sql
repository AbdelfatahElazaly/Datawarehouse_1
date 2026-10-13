/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customer
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customer AS
	(SELECT
		ROW_NUMBER() over(order by CI.cst_id) AS customer_key,
		CI.cst_id AS customer_id,
		CI.cst_key AS customer_number,
		CI.cst_firstname AS first_name,
		CI.cst_lastname AS last_name,
		CI.cst_marital_status AS marital_status,
		CASE 
			WHEN CI.cst_gndr != 'N/A' THEN LOWER(CI.cst_gndr)
			ELSE COALESCE(CBD.GEN,'n/a')
		END AS gender ,
		CI.cst_create_date AS create_date,
		CBD.BDATE AS birth_date,
		CL.CNTRY AS country
	FROM SILVER.crm_cust_info CI
	LEFT JOIN SILVER.erp_CUST_AZ12 CBD
	ON CI.cst_key = CBD.CID 
	LEFT JOIN SILVER.erp_LOC_A101 CL
	ON CL.CID = CI.cst_key )

	GO
-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key) AS product_key ,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id,
	pc.CAT AS category,
	pc.SUBCAT AS subcategory,
	pc.MAINTENANCE,
	pn.prd_cost AS cost,
	pn.prd_line AS product_line ,
	pn.prd_start_dt AS start_date
FROM SILVER.crm_prd_info pn
LEFT JOIN SILVER.erp_PX_CAT_G1V2 PC
ON PN.cat_id=PC.ID
WHERE prd_end_dt is null ;
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT 
	SD.sls_ord_num AS order_number,
	pr.product_key,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM silver.crm_sales_details SD
LEFT JOIN GOLD.dim_customers CU
ON SD.sls_cust_id = CU.customer_id
LEFT JOIN gold.dim_products PR
ON SD.sls_prd_key = PR.product_number
GO
