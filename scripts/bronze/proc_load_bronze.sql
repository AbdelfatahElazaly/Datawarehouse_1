
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
	DECLARE @start_time DATETIME , @end_time DATETIME ;

	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>THE DURATION TIME = ' +CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'  SECOND'


	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);


	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);



	TRUNCATE TABLE bronze.erp_CUST_AZ12;
	BULK INSERT bronze.erp_CUST_AZ12
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);


	TRUNCATE TABLE bronze.erp_LOC_A101;
	BULK INSERT bronze.erp_LOC_A101
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);


	TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
	BULK INSERT bronze.erp_PX_CAT_G1V2
	FROM 'E:\Datebase2\data warehouse\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);

END