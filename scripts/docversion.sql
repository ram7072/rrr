create or replace TABLE CRIS.DOCVERSION (
	"object_id" VARCHAR(36),
	"object_class_id" VARCHAR(36),
	"security_id" VARCHAR(36),
	"epoch_id" NUMBER(10,0),
	"home_id" VARCHAR(36),
	"creator" VARCHAR(80),
	"create_date" TIMESTAMP_NTZ(9),
	"modify_user" VARCHAR(80),
	"modify_date" TIMESTAMP_NTZ(9),
	"storage_class" VARCHAR(36),
	"is_reserved" NUMBER(3,0),
	"is_current" NUMBER(3,0),
	"is_frozen" NUMBER(3,0),
	"version_series_id" VARCHAR(36),
	"content_size" FLOAT,
	"lock_token" VARCHAR(36),
	"lock_timeout" NUMBER(10,0),
	"lock_owner" VARCHAR(64),
	"doc_lifecycle_policy" VARCHAR(36),
	"doc_state" VARCHAR(64),
	"is_in_exception_state" NUMBER(3,0),
	"storage_location" VARCHAR(1),
	"component_types" VARCHAR(200),
	"retrieval_names" VARCHAR(400),
	"component_types_2" VARCHAR(16777216),
	"retrieval_names_2" VARCHAR(16777216),
	"mime_type" VARCHAR(96),
	"content_info" VARCHAR(192),
	"content_info_2" VARCHAR(16777216),
	"next_content_unique_id" NUMBER(10,0),
	"vw_version" VARCHAR(255),
	"versioning_enabled" NUMBER(3,0),
	"xml_doc_type" VARCHAR(256),
	"xml_target_class" VARCHAR(36),
	"classification_state" NUMBER(10,0),
	"replication_group_id" VARCHAR(36),
	"lock_sid" VARCHAR(16777216),
	"major_version_number" NUMBER(10,0),
	"minor_version_number" NUMBER(10,0),
	"version_status" NUMBER(10,0),
	"security_policy_id" VARCHAR(36),
	"reservation_type" NUMBER(10,0),
	"reservation_owner_sid" VARCHAR(16777216),
	"content_last_accessed_date" TIMESTAMP_NTZ(9),
	"content_referral_blob" VARCHAR(16777216),
	"content_retention_date" TIMESTAMP_NTZ(9),
	"storage_area_id" VARCHAR(36),
	"indexation_id" VARCHAR(36),
	"index_failure_code" NUMBER(10,0),
	"compound_document_state" NUMBER(10,0),
	"dynamic_cr_update_status" NUMBER(10,0),
	"security_folder_id" VARCHAR(36),
	"checked_in_date" TIMESTAMP_NTZ(9),
	"u1708_documenttitle" VARCHAR(255),
	"u2e28_componentbindinglabel" VARCHAR(64),
	"u5ce8_entrytemplateobjectstore" VARCHAR(64),
	"u5948_entrytemplatelaunchedwor" VARCHAR(64),
	"u9855_entrytemplateid" VARCHAR(36),
	"u2918_entrytemplatedescription" VARCHAR(300),
	"u76f8_targetobjecttype" VARCHAR(64),
	"u3975_targetobjectclassid" VARCHAR(36),
	"u12a8_targetobjectstorename" VARCHAR(64),
	"ue148_targetsiteid" VARCHAR(64),
	"u1ce8_layoutid" VARCHAR(64),
	"u1b08_layoutversionseriesid" VARCHAR(64),
	"u8208_formpolicylaunchedworkfl" VARCHAR(64),
	"u8bb8_formpolicystepdescriptor" VARCHAR(64),
	"ue547_formpolicy" VARCHAR(36),
	"u1937_itxformtemplate" VARCHAR(36),
	"u9e58_formdescription" VARCHAR(64),
	"u0228_formpolicyworkflowobject" VARCHAR(64),
	"uc8d8_formpolicyworkflowid" VARCHAR(64),
	"u33c7_formtemplate" VARCHAR(36),
	"u0ed8_formtype" VARCHAR(64),
	"u33d8_formpolicydescription" VARCHAR(64),
	"uf558_scenariodescription" VARCHAR(256),
	"uf5b8_simulationdescription" VARCHAR(256),
	"uc0e8_simulationstatus" VARCHAR(256),
	"u6c92_publishingenabled" NUMBER(3,0),
	"u2d86_simulationlifespaninhour" NUMBER(10,0),
	"u6158_scenariodefinitiondocid" VARCHAR(64),
	"ub468_simulationguid" VARCHAR(64),
	"ue4b8_description" VARCHAR(255),
	"ube06_searchtype" NUMBER(10,0),
	"u8bd6_searchingobjecttype" NUMBER(10,0),
	"ub168_searchingobjectstores" VARCHAR(255),
	"ud818_applicationname" VARCHAR(64),
	"u2a76_cmsearchschemaversion" NUMBER(10,0),
	"u2297_sourcedocument" VARCHAR(36),
	"uc7b7_ownerdocument" VARCHAR(36),
	"u1821_publicationinfo" VARCHAR(16777216),
	"u82e7_publishingsubsidiaryfold" VARCHAR(36),
	"uc807_styletemplate" VARCHAR(36),
	"u1aa2_ignoreredirect" NUMBER(3,0),
	"u63a8_preferencetype" VARCHAR(64),
	"ua798_from" VARCHAR(255),
	"uc5e8_emailsubject" VARCHAR(255),
	"ud2b3_senton" TIMESTAMP_NTZ(9),
	"udd53_receivedon" TIMESTAMP_NTZ(9),
	"u6397_recordinformation" VARCHAR(36),
	"u6397_recordinformation_home" VARCHAR(36),
	"u3d06_rmentitytype" NUMBER(10,0),
	"ucab8_uniquerecordidentifier" VARCHAR(255),
	"u487f_rmentitydescription" VARCHAR(16777216),
	"u98f2_ispermanentrecord" NUMBER(3,0),
	"uec47_location" VARCHAR(36),
	"u3383_datedeclared" TIMESTAMP_NTZ(9),
	"uf918_mediatype" VARCHAR(255),
	"uf428_format" VARCHAR(255),
	"u2618_reviewer" VARCHAR(255),
	"u7b73_reviewdate" TIMESTAMP_NTZ(9),
	"u4a68_alias" VARCHAR(255),
	"u88b8_originatingorganization" VARCHAR(255),
	"u4e9f_reasonforreclassificatio" VARCHAR(16777216),
	"u0713_externaleventoccurrenced" TIMESTAMP_NTZ(9),
	"u4643_dateoflastreview" TIMESTAMP_NTZ(9),
	"u0f88_lastreviewedby" VARCHAR(255),
	"u24f8_disposalauthorizedby" VARCHAR(255),
	"u0b98_authorisingstatute" VARCHAR(255),
	"u8d93_cutoffdate" TIMESTAMP_NTZ(9),
	"u3ae3_currentphaseexecutiondat" TIMESTAMP_NTZ(9),
	"u9f42_isscreeningrequired" NUMBER(3,0),
	"u90f6_currentactiontype" NUMBER(10,0),
	"ub0a3_disposaldate" TIMESTAMP_NTZ(9),
	"u9b83_currentphasedecisiondate" TIMESTAMP_NTZ(9),
	"u71f7_currentphaseaction" VARCHAR(36),
	"ua15f_currentphasereviewcommen" VARCHAR(16777216),
	"ud78f_currentphasereviewdecisi" VARCHAR(16777216),
	"u2a47_currentphaseexportformat" VARCHAR(36),
	"u0fff_currentphaseexportdestin" VARCHAR(16777216),
	"uf193_phasedecisiondate" TIMESTAMP_NTZ(9),
	"u922f_reasonforoutcomeoflastre" VARCHAR(16777216),
	"uc2b6_currentphaseexecutionsta" NUMBER(10,0),
	"u2062_isfinalphasecompleted" NUMBER(3,0),
	"u7703_lastsweepdate" TIMESTAMP_NTZ(9),
	"ub355_disposalscheduleinherite" VARCHAR(36),
	"u834f_docuri" VARCHAR(16777216),
	"u9322_isvitalrecord" NUMBER(3,0),
	"u0c48_vitalrecorddescription" VARCHAR(255),
	"u89f3_vitalrecorddeclaredate" TIMESTAMP_NTZ(9),
	"u53e7_vitalrecordreviewaction" VARCHAR(36),
	"u4287_vitalrecorddisposaltrigg" VARCHAR(36),
	"ub163_vitalrecordnextreviewdat" TIMESTAMP_NTZ(9),
	"ueab3_vitalrecordreviewdate" TIMESTAMP_NTZ(9),
	"ue39f_vitalrecordreviewcomment" VARCHAR(16777216),
	"ub3e6_vitalworkflowstatus" NUMBER(10,0),
	"uff63_vitalsweepdate" TIMESTAMP_NTZ(9),
	"u37f2_isdeleted" NUMBER(3,0),
	"u714f_reasonfordelete" VARCHAR(16777216),
	"uf7e5_currentphaseid" VARCHAR(36),
	"ue3f8_aggregation" VARCHAR(255),
	"u20c7_associatedrecordtype" VARCHAR(36),
	"u2fb2_onhold" NUMBER(3,0),
	"uadc5_cutoffinheritedfrom" VARCHAR(36),
	"u3b57_supercededby" VARCHAR(36),
	"u5a28_preventrmentitydeletion" VARCHAR(64),
	"uf866_recalculatephaseretentio" NUMBER(10,0),
	"u42b3_supercededdate" TIMESTAMP_NTZ(9),
	"udb38_barcodeid" VARCHAR(255),
	"u9fc8_chargeoutto" VARCHAR(255),
	"u5916_chargeoutstatus" NUMBER(10,0),
	"u8dc7_homelocation" VARCHAR(36),
	"u7198_methodofdestruction" VARCHAR(255),
	"u63c8_dispositionid" VARCHAR(64),
	"u0e78_dispositionitemtype" VARCHAR(64),
	"uab78_keywords" VARCHAR(150),
	"u3a13_startdate" TIMESTAMP_NTZ(9),
	"u03d3_enddate" TIMESTAMP_NTZ(9),
	"u5d73_dispositionstartdate" TIMESTAMP_NTZ(9),
	"u46f8_comments" VARCHAR(500),
	"uf518_alternateid" VARCHAR(64),
	"uc6b8_crisrecordtype" VARCHAR(16),
	"u8dc8_transfernumber" VARCHAR(64),
	"u9c48_mainframecfp" VARCHAR(128),
	"u2e78_crisrecordstatus" VARCHAR(64),
	"u3628_rcnumber" VARCHAR(4),
	"uef58_pgepatterncode" VARCHAR(64),
	"u3428_fppatterncode" VARCHAR(32),
	"ubb08_checkoutnumber" VARCHAR(64),
	"u55f8_checkouttype" VARCHAR(64),
	"u9168_project" VARCHAR(100),
	"u0908_originalcreator" VARCHAR(80),
	"ueb33_originaldatecreated" TIMESTAMP_NTZ(9),
	"u8c63_originaldatelastmodified" TIMESTAMP_NTZ(9),
	"ub158_originallastmodifier" VARCHAR(80),
	"u4b72_pending" NUMBER(3,0),
	"uf568_contractnumber" VARCHAR(10),
	"u46f8_supplementnumber" VARCHAR(5),
	"uc408_landnumber" VARCHAR(64),
	"u3348_drawingnumber" VARCHAR(64),
	"u3ce8_platnumber" VARCHAR(16),
	"ud878_requester" VARCHAR(32),
	"u5618_medianumber" VARCHAR(64),
	"u08d8_beginningnumber" VARCHAR(64),
	"ub908_microtype" VARCHAR(64),
	"u50a8_rolename" VARCHAR(64),
	"uc988_rcname" VARCHAR(64),
	"uc518_employeenumber" VARCHAR(10),
	"u1c73_datecompleted" TIMESTAMP_NTZ(9),
	"ub638_completedby" VARCHAR(64),
	"u2a91_dispositionitemdata" VARCHAR(16777216),
	"u5df8_ruling" VARCHAR(64),
	"u8118_employeename" VARCHAR(64),
	"u5bb1_approvedsetdepartment" VARCHAR(16777216),
	"u62f1_approvedsetrecordcenter" VARCHAR(16777216),
	"ud241_disapprovedset" VARCHAR(16777216),
	"u3cd8_justificationfordisappro" VARCHAR(1300),
	"uf0d8_bindingid" VARCHAR(64),
	"u7776_recordcount" NUMBER(10,0),
	"u2d52_icnautorun" NUMBER(3,0),
	"ua0c2_icnshowintree" NUMBER(3,0),
	"recovery_item_id" VARCHAR(36),
	"u2558_rmreporttitle" VARCHAR(256),
	"u4ce2_contractnumberoverride" NUMBER(3,0),
	"u2e68_icnclassname" VARCHAR(255),
	"ub298_icnworkflowname" VARCHAR(255)
);