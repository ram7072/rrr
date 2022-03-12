create or replace view DM_CUSTOMER.ACCT_V as select * from CRDB.ACCT;

create or replace view DM_CUSTOMER.CCBDATA_V as select * from CRDB.CCBDATA;

create or replace view DM_CUSTOMER.PERSON_V as select * from CRDB.PERSON;

create or replace view DM_CUSTOMER.PREMISE_V as select * from CRDB.PREMISE;

create or replace view DM_CUSTOMER.PREMISEHEATACSOURCE_V as select * from CRDB.PREMISEHEATACSOURCE;

create or replace view DM_CUSTOMER.THIRDPARTY_ETO_V as select * from CRDB.THIRDPARTY_ETO;

create or replace view DM_CUSTOMER.ACCOUNT_PREMISE_V as select * from DM_CUSTOMER.ACCOUNT_PREMISE;
