delete from accelerator.table_list where TABLE_NAME in('PGE_ACTIVE_ARM_METER_WO','SUPPLY_NODE_LOG','ALIAS_MAPPING',
			'CES_CUSTOMERS_A','CES_CUSTOMERS','PICKLIST_INFO_UPD_TR','PGE_ATT_TABLE_MV','SUPPLY_NODES','ATT_METER','ERT_CHANGE_LOG');

insert into accelerator.table_list(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) 
 Values('OMS','PGE_NMS','OUTAGEMANAGEMENT','PGE_ACTIVE_ARM_METER_WO','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) 
 Values('OMS','PGE_NMS','OUTAGEMANAGEMENT','SUPPLY_NODE_LOG','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','ALIAS_MAPPING','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','CES_CUSTOMERS_A','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','CES_CUSTOMERS','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','PICKLIST_INFO_UPD_TR','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','PGE_ATT_TABLE_MV','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','SUPPLY_NODES','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','ATT_METER','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');

insert into accelerator.table_list
(SOURCE_DB, SOURCE_SCHEMA, TARGET_SCHEMA, TABLE_NAME, FILE_TYPE, RUN_FLAG, EXT_TABLE_FLAG, SEQ_FLAG,
 VIEW_FLAG, LOAD_COL_FLAG, TRANS_TABLE_FLAG, TRANS_SWAP_STAGE_FLAG, TRANS_PIPE_FLAG, TRANS_TASK_FLAG , DELETE_FLAG) Values
('OMS','PGE_NMS','OUTAGEMANAGEMENT','ERT_CHANGE_LOG','CSV','Y','N','Y','N','Y','Y','Y','Y','Y','N');
