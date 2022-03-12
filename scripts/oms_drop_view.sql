drop view if exists outagemanagement.ALIAS_MAPPING ;
drop view if exists outagemanagement.ATT_METER;
drop view if exists outagemanagement.CES_CUSTOMERS_A;
drop view if exists outagemanagement.PGE_ACTIVE_ARM_METER_WO;
drop view if exists outagemanagement.PGE_ATT_TABLE_MV;
drop view if exists outagemanagement.PICKLIST_INFO_UPD_TR;
drop view if exists outagemanagement.SUPPLY_NODES;
drop view if exists outagemanagement.SUPPLY_NODE_LOG;
drop view if exists outagemanagement.ERT_CHANGE_LOG;

drop table if exists outagemanagement.EXT_ALIAS_MAPPING;
drop table if exists outagemanagement.EXT_ATT_METER;
drop table if exists outagemanagement.EXT_CES_CUSTOMERS_A;
drop table if exists outagemanagement.EXT_PGE_ACTIVE_ARM_METER_WO;
drop table if exists outagemanagement.EXT_PGE_ATT_TABLE_MV;
drop table if exists outagemanagement.EXT_PICKLIST_INFO_UPD_TR;
drop table if exists outagemanagement.EXT_SUPPLY_NODES;
drop table if exists outagemanagement.EXT_SUPPLY_NODE_LOG;
drop table if exists outagemanagement.EXT_ERT_CHANGE_LOG;

delete from warehouse.dl_task_ctrl_info
where TARGET_TBNAME='PGE_ATT_TABLE_MV';

insert into warehouse.dl_task_ctrl_info(TARGET_TBNAME,WAREHOUSE_NAME,SCHEDULE,TARGET_SCHNAME,LANDING_SCHNAME,UNIQUE_KEY,DEL_FLAG)
values('PGE_ATT_TABLE_MV','DATA_INGESTION','USING CRON 0 0 * * * America/Los_Angeles','OUTAGEMANAGEMENT','LANDINGTEMP','H_CLS,H_IDX','Y');

delete from warehouse.dl_task_ctrl_info
where TARGET_TBNAME='PGE_ACTIVE_ARM_METER_WO';

insert into warehouse.dl_task_ctrl_info(TARGET_TBNAME,WAREHOUSE_NAME,SCHEDULE,TARGET_SCHNAME,LANDING_SCHNAME,UNIQUE_KEY,DEL_FLAG)
values('PGE_ACTIVE_ARM_METER_WO','DATA_INGESTION','USING CRON 0 0 * * * America/Los_Angeles','OUTAGEMANAGEMENT','LANDINGTEMP','ORDERNUM,METERID','Y');