/*
Stored Procedure: Load Bronze Layer (Source --> Bronze)

This stored procedure loads data into the 'bronze' schema from external CSV files. 
It performs:
- Truncate the bronze tables before loading data.
- Uses the 'Bulk Insert' command to load data from csv files to bronze tables.

Parameters: None
  This stored procedure does not accept any parameters or return any values.

Usage:
  Exec bronze.bronze_load;

*/


create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime; -- declare new variables
	begin try -- Debugging
	set @start_time = GETDATE();
		print '-----Loading Bronze Layer-----';
		print '-----CRM Tables-----';


		set @start_time = GETDATE();
		print '>>truncating table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '>>inserting data into table: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\Shishanth R\Documents\data project\source_crm\cust_info.csv'
		with(
			firstrow=2,
			fieldterminator = ',',
			tablock
		);
		select count(*) from bronze.crm_cust_info
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'

		set @start_time = GETDATE();
		print '>>truncating table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print '>>inserting data into table: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\Shishanth R\Documents\data project\source_crm\prd_info.csv'
		with(
			tablock,
			fieldterminator = ',',
			firstrow = 2
		);
		select count(*) from bronze.crm_prd_info
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'

		set @start_time = GETDATE();
		print '>>truncating table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print '>>inserting data into table: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\Shishanth R\Documents\data project\source_crm\sales_details.csv'
		with(
			firstrow=2,
			fieldterminator = ',',
			tablock
		);
		select count(*) from bronze.crm_sales_details
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'

		print '-----ERP Tables-----';


		set @start_time = GETDATE();
		print '>>truncating table: bronze.erp_CUST_AZ12';
		truncate table bronze.erp_CUST_AZ12;
		print '>>inserting data into table: bronze.erp_CUST_AZ12';
		bulk insert bronze.erp_CUST_AZ12
		from 'C:\Users\Shishanth R\Documents\data project\source_erp\CUST_AZ12.csv'
		with(
			tablock,
			fieldterminator = ',',
			firstrow = 2
		);
		select count(*) from bronze.erp_CUST_AZ12
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'

		set @start_time = GETDATE();
		print '>>truncating table: bronze.erp_LOC_A101';
		truncate table bronze.erp_LOC_A101;
		print '>>inserting data into table: bronze.erp_LOC_A101';
		bulk insert bronze.erp_LOC_A101
		from 'C:\Users\Shishanth R\Documents\data project\source_erp\LOC_A101.csv'
		with(
			firstrow=2,
			fieldterminator = ',',
			tablock
		);
		select count(*) from bronze.erp_LOC_A101
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'

		set @start_time = GETDATE();
		print '>>truncating table: bronze.erp_PX_CAT_G1V2';
		truncate table bronze.erp_PX_CAT_G1V2;
		print '>>inserting data into table: bronze.erp_PX_CAT_G1V2';
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'C:\Users\Shishanth R\Documents\data project\source_erp\PX_CAT_G1V2.csv'
		with(
			tablock,
			fieldterminator = ',',
			firstrow = 2
		);
		select count(*) from bronze.erp_PX_CAT_G1V2
		set @end_time = GETDATE();
		print '>>Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '-----'
	set @end_time = GETDATE();
	print '>> Bronze Layer Load duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	end try
	begin catch
		print '=====Error Occured During Loading Bronze Layer=====';
		print 'Error Message' + error_message();
		print 'Error Message' + cast(error_number() as nvarchar);
		print 'Error Message' + cast(error_state() as nvarchar);
		print '===================================================';
	end catch
end
