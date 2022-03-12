create or replace TABLE DM_CUSTOMER.CRAFT3_ON_BILL_FIN_MONTHLY
 (
  LOAD_TIMESTAMP 			 TIMESTAMP_NTZ(9) 	 ,
  FISCAL_YEAR                VARCHAR(20)         ,
  ACCOUNTING_PERIOD          VARCHAR(20)         ,
  ROW_NUMB	                 NUMBER(9,0)         ,
  SA_ID                      VARCHAR(20)         ,
  ACCT_ID                    VARCHAR(20)         ,
  STATUS                     VARCHAR(20)         ,
  BANK_LOAN_ID               VARCHAR(200)        ,
  BANK_CTRL_DIGIT            VARCHAR(200)        ,
  CURR_BILL_DUE_DT           VARCHAR(20)         ,
  BANNER_PREM_ID             VARCHAR(200)        ,
  BILL_ID                    VARCHAR(20)         ,
  ARREARS_DATE               VARCHAR(20)         ,
  CYCLE_MNTH_AMT_BILLED      NUMBER(27,2)        ,
  CYCLE_MNTH_AMT_PAID        NUMBER(27,2)        ,
  LOAN_BALANCE               NUMBER(27,2)        ,
  FINANCE_BALANCE            NUMBER(27,2)        ,
  ADJUSTMENT_DESCR           VARCHAR(500)        ,
  CHARGE_DATE_AGE            NUMBER(27,2)        ,
  DISCONNECT_DATE            DATE                ,
  CYCLE_MNTH_ADJUSTMENT_AMT  NUMBER(27,2)        ,
  CYCLE_MNTH_ADJUSTMENT_DATE VARCHAR(20)         ,
  PAY_CANCEL_DESCR           VARCHAR(500)        ,
  ETL_CREATE_TIMESTAMP       TIMESTAMP_NTZ(9)    ,
  ETL_UPDATE_TIMESTAMP       TIMESTAMP_NTZ(9)    ,
  LOADED_BY 				 VARCHAR(100)        ,
  PRIMARY KEY (FISCAL_YEAR,ACCOUNTING_PERIOD,SA_ID,ACCT_ID,BANK_LOAN_ID,BANK_CTRL_DIGIT,BILL_ID,ADJUSTMENT_DESCR,PAY_CANCEL_DESCR)
 );
 

 