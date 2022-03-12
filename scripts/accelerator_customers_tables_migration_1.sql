Delete from accelerator.table_list
where target_schema = 'CUSTOMER'
and   TABLE_NAME in ('CI_ADJ_TYPE','CI_ADJ_TYPE_L','CI_PAY_CAN_RSN_L');

insert into accelerator.table_list (SOURCE_DB,	SOURCE_SCHEMA,	TARGET_SCHEMA,	TABLE_NAME,
                                    FILE_TYPE,	RUN_FLAG,	EXT_TABLE_FLAG,	SEQ_FLAG,	VIEW_FLAG,
                                    LOAD_COL_FLAG,	TRANS_TABLE_FLAG,	TRANS_SWAP_STAGE_FLAG,	TRANS_PIPE_FLAG,
                                    TRANS_TASK_FLAG)
Values
( 'CCB','CISADM','CUSTOMER','CI_ADJ_TYPE','PARQUET','Y','Y','Y','Y','Y','N','N','N','N');
          
insert into accelerator.table_list (SOURCE_DB,	SOURCE_SCHEMA,	TARGET_SCHEMA,	TABLE_NAME,
                                    FILE_TYPE,	RUN_FLAG,	EXT_TABLE_FLAG,	SEQ_FLAG,	VIEW_FLAG,
                                    LOAD_COL_FLAG,	TRANS_TABLE_FLAG,	TRANS_SWAP_STAGE_FLAG,	TRANS_PIPE_FLAG,
                                    TRANS_TASK_FLAG)
Values
( 'CCB','CISADM','CUSTOMER','CI_ADJ_TYPE_L','PARQUET','Y','Y','Y','Y','Y','N','N','N','N');

insert into accelerator.table_list (SOURCE_DB,	SOURCE_SCHEMA,	TARGET_SCHEMA,	TABLE_NAME,
									FILE_TYPE,	RUN_FLAG,	EXT_TABLE_FLAG,	SEQ_FLAG,	VIEW_FLAG,
                                    LOAD_COL_FLAG,	TRANS_TABLE_FLAG,	TRANS_SWAP_STAGE_FLAG,	TRANS_PIPE_FLAG,
                                    TRANS_TASK_FLAG)
Values
( 'CCB','CISADM','CUSTOMER','CI_PAY_CAN_RSN_L','PARQUET','Y','Y','Y','Y','Y','N','N','N','N');
