create or replace TABLE CRIS.CONTAINER_PGEP8OS03 (
	"object_id" VARCHAR(36),
	"object_class_id" VARCHAR(36),
	"security_id" VARCHAR(36),
	"epoch_id" NUMBER(10,0),
	"home_id" VARCHAR(36),
	"creator" VARCHAR(80),
	"create_date" TIMESTAMP_NTZ(9),
	"modify_user" VARCHAR(80),
	"modify_date" TIMESTAMP_NTZ(9),
	"parent_container_id" VARCHAR(36),
	"name" VARCHAR(255),
	"init_container_bool" NUMBER(3,0),
	"lock_token" VARCHAR(36),
	"lock_timeout" NUMBER(10,0),
	"lock_owner" VARCHAR(64),
	"lock_sid" VARCHAR(16777216),
	"security_policy_id" VARCHAR(36),
	"indexation_id" VARCHAR(36),
	"index_failure_code" NUMBER(10,0),
	"replication_group_id" VARCHAR(36),
	"retention_date" TIMESTAMP_NTZ(9),
	"uffc2_ishiddencontainer" NUMBER(3,0),
	"u2618_containertype" VARCHAR(64),
	"u3916_rmentitytype" NUMBER(10,0),
	"u8dd8_recordcategoryname" VARCHAR(100),
	"u3378_recordcategoryidentifier" VARCHAR(64),
	"u448f_rmentitydescription" VARCHAR(16777216),
	"uc1f8_emailsubject" VARCHAR(150),
	"ue833_dateopened" TIMESTAMP_NTZ(9),
	"u9502_ispermanentrecord" NUMBER(3,0),
	"u9e33_dateclosed" TIMESTAMP_NTZ(9),
	"u6c7f_reasonforclose" VARCHAR(16777216),
	"u18c8_closedby" VARCHAR(64),
	"u8093_reopeneddate" TIMESTAMP_NTZ(9),
	"uafd8_reopenedby" VARCHAR(64),
	"u9472_inactive" NUMBER(3,0),
	"ud1ef_reasonforinactivate" VARCHAR(16777216),
	"u4aaf_reasonforreclassificatio" VARCHAR(16777216),
	"ue793_lastretrievalofrecord" TIMESTAMP_NTZ(9),
	"u0323_externaleventoccurrenced" TIMESTAMP_NTZ(9),
	"ub8f3_datelastdeclaration" TIMESTAMP_NTZ(9),
	"u4253_dateoflastreview" TIMESTAMP_NTZ(9),
	"u0b98_lastreviewedby" VARCHAR(64),
	"u7437_disposalschedule" VARCHAR(36),
	"u2108_disposalauthorizedby" VARCHAR(64),
	"udfb3_disposalscheduleallocati" TIMESTAMP_NTZ(9),
	"u89a3_cutoffdate" TIMESTAMP_NTZ(9),
	"u36f3_currentphaseexecutiondat" TIMESTAMP_NTZ(9),
	"u9b52_isscreeningrequired" NUMBER(3,0),
	"u8d06_currentactiontype" NUMBER(10,0),
	"uacb3_disposaldate" TIMESTAMP_NTZ(9),
	"u9793_currentphasedecisiondate" TIMESTAMP_NTZ(9),
	"u6e07_currentphaseaction" VARCHAR(36),
	"u9d6f_currentphasereviewcommen" VARCHAR(16777216),
	"ud39f_currentphasereviewdecisi" VARCHAR(16777216),
	"u2657_currentphaseexportformat" VARCHAR(36),
	"u0c0f_currentphaseexportdestin" VARCHAR(16777216),
	"ueda3_phasedecisiondate" TIMESTAMP_NTZ(9),
	"u8e3f_reasonforoutcomeoflastre" VARCHAR(16777216),
	"ubec6_currentphaseexecutionsta" NUMBER(10,0),
	"u1c72_isfinalphasecompleted" NUMBER(3,0),
	"u7313_lastsweepdate" TIMESTAMP_NTZ(9),
	"uaf65_disposalscheduleinherite" VARCHAR(36),
	"u8f32_isvitalrecord" NUMBER(3,0),
	"u8603_vitalrecorddeclaredate" TIMESTAMP_NTZ(9),
	"u0858_vitalrecorddescription" VARCHAR(255),
	"u4ff7_vitalrecordreviewaction" VARCHAR(36),
	"u3e97_vitalrecorddisposaltrigg" VARCHAR(36),
	"uad73_vitalrecordnextreviewdat" TIMESTAMP_NTZ(9),
	"ue6c3_vitalrecordreviewdate" TIMESTAMP_NTZ(9),
	"udfaf_vitalrecordreviewcomment" VARCHAR(16777216),
	"uaff6_vitalworkflowstatus" NUMBER(10,0),
	"ufb73_vitalsweepdate" TIMESTAMP_NTZ(9),
	"u2228_reviewer" VARCHAR(64),
	"u3402_isdeleted" NUMBER(3,0),
	"u6d5f_reasonfordelete" VARCHAR(16777216),
	"udcf8_recordpattern" VARCHAR(150),
	"u6646_incrementedby" NUMBER(10,0),
	"ue857_location" VARCHAR(36),
	"u89d7_homelocation" VARCHAR(36),
	"uf3f5_currentphaseid" VARCHAR(36),
	"ue008_aggregation" VARCHAR(64),
	"u2bc2_onhold" NUMBER(3,0),
	"u07a8_authorisingstatute" VARCHAR(100),
	"ua9d5_cutoffinheritedfrom" VARCHAR(36),
	"u5638_preventrmentitydeletion" VARCHAR(64),
	"uf476_recalculatephaseretentio" NUMBER(10,0),
	"ud3b8_allowedrmcontainees" VARCHAR(150),
	"u1028_rmexternallymanagedby" VARCHAR(20),
	"u9ff8_volumename" VARCHAR(100),
	"u9bd8_chargeoutto" VARCHAR(64),
	"u5526_chargeoutstatus" NUMBER(10,0),
	"u6da8_methodofdestruction" VARCHAR(100),
	"ub348_recordfolderidentifier" VARCHAR(110),
	"ufa78_classificationschemename" VARCHAR(100),
	"u1357_pattern" VARCHAR(36),
	"u9e16_lastpatternindex" NUMBER(10,0),
	"u0706_retainmetadata" NUMBER(10,0),
	"u2188_recordfoldername" VARCHAR(100),
	"ud748_barcodeid" VARCHAR(150),
	"u3fb2_transferoraccessiontonar" NUMBER(3,0),
	"u7b68_officeofrecord" VARCHAR(128),
	"ubfe8_comments" VARCHAR(500),
	"u2018_retention" VARCHAR(64),
	"u47d8_clbteamspacename" VARCHAR(128),
	"ue0c8_description" VARCHAR(255),
	"u6a16_clbteamspacestate" NUMBER(10,0),
	"u4a91_clbjsondata" VARCHAR(16777216),
	"u5c47_clbsecurityadapter" VARCHAR(36),
	"recovery_item_id" VARCHAR(36),
	"uba98_clbcommunityid" VARCHAR(64),
	"u7838_rmretentionperiod" VARCHAR(14),
	"ube8f_rmretentiontriggerproper" VARCHAR(16777216),
	"u4876_rmsrmcid" NUMBER(10,0),
	"u0c98_pgeidentifier" VARCHAR(64),
	"u1b18_compliance" VARCHAR(64)
);