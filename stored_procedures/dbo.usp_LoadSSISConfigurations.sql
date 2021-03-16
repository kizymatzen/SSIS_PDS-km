USE [SSIS_PDS]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/
DROP PROCEDURE [dbo].[usp_LoadSSISConfigurations]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_LoadSSISConfigurations]
AS
    BEGIN

/*****************************************************************************************************************
NAME:    dbo.usp_LoadSSISConfigurations
PURPOSE: Load the SSIS Configurations table

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      02/07/2021  KMATZEN          1. Created this process for LDS BC IT243
1.1      02/07/2021  KMATZEN          1. Added DFNB3 connection configuration 
1.2      02/08/2021  KMATZEN          1. Added LoadDFNB3_km connection configuration
1.3      02/26/2021  KMATZEN          1. Added LoadEXM_km connection configuration
1.4      03/05/2021  KMATZEN          1. Added LoadNAICSCodeHierDim_km connection configuration



RUNTIME: 
approx 5 sec

NOTES:  
Load configured variable values for these levels...
1) System = CommonConfigurations
2) Solution
3) Package


Loads configuration managers for common configuration managers used in template package

Connect strings are loaded with passwords to allow for automation of SSIS ETL based packages
 

Example usage...

EXEC dbo.usp_LoadSSISConfigurations;

SELECT c.*
  FROM dbo.[SSIS Configurations] as c;
         
******************************************************************************************************************/

    TRUNCATE TABLE dbo.[SSIS Configurations];


    -- 1) Common Configurations

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'CommonConfigurations';


    -- 1.1) conn_EXM

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=localhost;Initial Catalog=EXM;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_EXM].Properties[Value]'
         , 'String'
          );


    -- 1.2) conn_DFNB

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=localhost;Initial Catalog=DFNB3;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_DFNB3].Properties[Value]'
         , 'String'
          );





    -- 2) Solution Level Configurations

	-- 2.1) LDSBC_IT243_km  
	
	DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LDSBC_IT243_km';
	

	-- 2.1.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LDSBC_IT243_km'
		 , 'C:\Users\kizy\Desktop\School\IT 243\Repositories\DFNB_src-km\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );




    -- 3) Package level configurations


    -- 3.1) SSIS_PDS_Template_km

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'SSIS_PDS_Template_km';
	

	-- 3.1.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'SSIS_PDS_Template_km'
		 , 'C:\Users\kizy\Desktop\School\IT 243\Repositories\DFNB_src-km\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );



    -- 3.2) LoadDFNB3_km

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadDFNB3_km';
	

	-- 3.2.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadDFNB3_km'
		 , 'C:\Users\kizy\Desktop\School\IT 243\Repositories\DFNB_src-km\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );



-- 3.3) LoadEXM_km

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadEXM_km';
	

	-- 3.3.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadEXM_km'
		 , 'C:\Users\kizy\Desktop\School\IT 243\Repositories\EXM_km\txt_files'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );

-- 3.4) LoadNAICSCodeHierDim_km

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadNAICSCodeHierDim_km';
	

	-- 3.4.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadNAICSCodeHierDim_km'
		 , 'C:\Users\kizy\Desktop\School\IT 243\Repositories\DFNB_dw-km\xls_files'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );


END;

GO


