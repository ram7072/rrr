create or replace TABLE CRIS.RELATIONSHIP (
	"object_id" VARCHAR(36),
	"object_class_id" VARCHAR(36),
	"security_id" VARCHAR(36),
	"epoch_id" NUMBER(10,0),
	"home_id" VARCHAR(36),
	"creator" VARCHAR(80),
	"create_date" TIMESTAMP_NTZ(9),
	"modify_user" VARCHAR(80),
	"modify_date" TIMESTAMP_NTZ(9),
	"head_id" VARCHAR(36),
	"head_id_class" VARCHAR(36),
	"tail_id" VARCHAR(36),
	"version_series_id" VARCHAR(36),
	"propagate_security" NUMBER(3,0),
	"name" VARCHAR(255),
	"replication_group_id" VARCHAR(36),
	"recovery_item_id" VARCHAR(36)
);