/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.crm_cust_info','U') IS NOT NULL
DROP TABLE silver.crm_cust_info;
GO
create TABLE silver.crm_cust_info(
cst_id INT ,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_prd_info','U') IS NOT NULL
DROP TABLE silver.crm_prd_info;
GO
CREATE TABLE silver.crm_prd_info(
prd_id INT ,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(255),
prd_cost FLOAT,
prd_line NVARCHAR(50),
prd_start_dt DATE,
prd_end_dt DATE,
dwh_create_date DATETIME2 DEFAULT GETDATE()

);

IF OBJECT_ID('silver.crm_sales_details','U') IS NOT NULL
DROP TABLE silver.crm_sales_details;
GO
CREATE TABLE silver.crm_sales_details(
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt DATE ,
sls_ship_dt DATE ,
sls_due_dt DATE ,
sls_sales FLOAT,
sls_quantity INT,
sls_price FLOAT,
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.erp_CUST_AZ12','U') IS NOT NULL
DROP TABLE silver.erp_CUST_AZ12;
GO
CREATE TABLE silver.erp_CUST_AZ12(
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.erp_LOC_A101','U') IS NOT NULL
DROP TABLE silver.erp_LOC_A101;
GO
CREATE TABLE silver.erp_LOC_A101(
CID NVARCHAR(50),
CNTRY NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.erp_PX_CAT_G1V2','U') IS NOT NULL
DROP TABLE silver.erp_PX_CAT_G1V2;
GO
CREATE TABLE silver.erp_PX_CAT_G1V2(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
