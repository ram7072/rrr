create or replace TABLE CRDB.ccbdata (
	PERID VARCHAR(10),
	ACCTID VARCHAR(10),
	SAID VARCHAR(10),
	SPID VARCHAR(10),
	PREMID VARCHAR(10),
	BANNERCUSTCODE VARCHAR(9),
	BANNERACCTNUM VARCHAR(40),
	BANNERPREMCODE VARCHAR(50),
	BANNERPODID NUMBER(19,0),
	FULLNAME VARCHAR(254),
	FIRSTNAME VARCHAR(100),
	MIDDLENAME VARCHAR(40),
	LASTNAME VARCHAR(100),
	HIGHLVLBUSNAME VARCHAR(255),
	ACCTESTABLISHEDDATE VARCHAR(10),
	AVGBILLAMT12MO NUMBER(15,2),
	AVGBILLAMTSUMMER NUMBER(15,2),
	AVGBILLAMTWINTER NUMBER(15,2),
	AVGKWH12MO NUMBER(10,0),
	AVGKWHSUMMER NUMBER(10,0),
	AVGKWHWINTER NUMBER(10,0),
	BILLINGCYCLE VARCHAR(4),
	BILLINGMETH VARCHAR(8),
	BILLINGMETHDESC VARCHAR(60),
	BUSTYPE VARCHAR(50),
	COAPPNAME VARCHAR(254),
	CREDITRATINGACCT NUMBER(10,0),
	CREDITRATINGPERAVG NUMBER(10,0),
	CREDITRATINGPERNBR NUMBER(10,0),
	CREDITRATINGPERMAX NUMBER(10,0),
	CREDITRATINGPERMIN NUMBER(10,0),
	CASHPOINTSPERAVG NUMBER(10,0),
	CASHPOINTSPERMAX NUMBER(10,0),
	CASHPOINTSPERMIN NUMBER(10,0),
	DMCISMAILADDRLABEL VARCHAR(800),
	DMCISMAILADDRLABELCOMMERCIAL VARCHAR(800),
	DMCISMAILADDRLABELSERVICE VARCHAR(800),
	DMCISMAILADDRLABELSERVICELANDLORD VARCHAR(800),
	DNPDISCONNECTS12MOACCT NUMBER(10,0),
	DNPDISCONNECTS12MOCUST NUMBER(10,0),
	DNPLASTDISCONNECTDATEACCT VARCHAR(10),
	DNPLASTDISCONNECTDATECUST VARCHAR(10),
	DWELLINGTYPECODE VARCHAR(3),
	DWELLINGTYPEDESC VARCHAR(60),
	EMAILPRIMARY VARCHAR(254),
	EMAILPRIMARYPROMO VARCHAR(254),
	FEEDERNAME VARCHAR(60),
	FFBCCREDIT12MOACCT NUMBER(10,0),
	FFBCCREDIT12MOPER NUMBER(10,0),
	FFBCDEBIT12MOACCT NUMBER(10,0),
	FFBCDEBIT12MOPER NUMBER(10,0),
	FIFTEENDAYNOTICES12MOACCT NUMBER(10,0),
	FIVEDAYNOTICES12MOACCT NUMBER(10,0),
	GEOLAT FLOAT,
	GEOLONG FLOAT,
	GEOXY VARCHAR(25),
	GOVLVL VARCHAR(60),
	HASAIRCONDITIONING BOOLEAN,
	HASEMAIL BOOLEAN,
	HASEVCHARGING BOOLEAN,
	HASHEATPUMP BOOLEAN,
	HASKEYCUSTMGR BOOLEAN,
	HASMEDCERT BOOLEAN,
	HASREFRIGERATOR BOOLEAN,
	HASSMARTTHERMOSTAT BOOLEAN,
	HEATPUMPTYPE VARCHAR(25),
	INCITYLIMIT BOOLEAN,
	ISAUTOPAY BOOLEAN,
	ISBUS BOOLEAN,
	ISCASHMOCARDONLY BOOLEAN,
	ISCASHONLY BOOLEAN,
	ISCCBOPTOUT BOOLEAN,
	ISCOMSA BOOLEAN,
	ISCONSOLIDATEDBILLING BOOLEAN,
	ISELIGIBLEAUTOPAY BOOLEAN,
	ISELIGIBLECLEANWIND BOOLEAN,
	ISELIGIBLECLEANWINDCI BOOLEAN,
	ISELIGIBLEEECOMMERCIAL BOOLEAN,
	ISELIGIBLEEERESIDENTIAL BOOLEAN,
	ISELIGIBLEEQUALPAY BOOLEAN,
	ISELIGIBLEGREENFUTURESOLAR BOOLEAN,
	ISELIGIBLEGREENSOURCE BOOLEAN,
	ISELIGIBLEHABITAT BOOLEAN,
	ISELIGIBLEPEAKTIMEREBATE BOOLEAN,
	ISELIGIBLEHEATPUMPCOMMERCIAL BOOLEAN,
	ISELIGIBLEHEATPUMPRESIDENTIAL BOOLEAN,
	ISELIGIBLEPAPERLESSBILL BOOLEAN,
	ISENVELOPEOPTOUT BOOLEAN,
	ISEQUALPAYACCT BOOLEAN,
	ISEQUALPAYSA BOOLEAN,
	ISMDBOPTOUT BOOLEAN,
	ISOVERHEAD BOOLEAN,
	ISOWNEROCCUPIED BOOLEAN,
	ISPAPERLESS BOOLEAN,
	ISPEAKTIMEREBATE BOOLEAN,
	ISPER BOOLEAN,
	ISPREFERREDDUEDATE BOOLEAN,
	ISRENEWABLE BOOLEAN,
	ISRENEWCLEANWIND BOOLEAN,
	ISRENEWCLEANWINDCI BOOLEAN,
	ISRENEWGREENFUTURESOLAR BOOLEAN,
	ISRENEWGREENSOURCE BOOLEAN,
	ISRENEWHABITAT BOOLEAN,
	ISRENEWSOLARFEEDIN BOOLEAN,
	ISRENEWSOLARNETMETER BOOLEAN,
	ISRENTEROCCUPIED BOOLEAN,
	ISRESSA BOOLEAN,
	ISSMARTTHERMOSTATENROLLED BOOLEAN,
	ISTOU BOOLEAN,
	ISTPA BOOLEAN,
	ISUNDERGROUND BOOLEAN,
	ISWEBREGISTERED BOOLEAN,
	IVRCALLS12MOACCT NUMBER(10,0),
	IVRCALLS12MOPER NUMBER(10,0),
	KEYCUSTMGR VARCHAR(60),
	KEYCUSTMGRBACKUP VARCHAR(60),
	LANDLORDNAME VARCHAR(60),
	LIGHTINGCODE VARCHAR(60),
	LIGHTINGDESC VARCHAR(60),
	MAILADDR1 VARCHAR(254),
	MAILADDR2 VARCHAR(254),
	MAILADDR3 VARCHAR(254),
	MAILCITY VARCHAR(90),
	MAILINGPREMID VARCHAR(10),
	MAILSTATE VARCHAR(6),
	MAILZIP4 VARCHAR(4),
	MAILZIP5 VARCHAR(5),
	MAINPERID VARCHAR(10),
	METERVOLTAGELVL VARCHAR(25),
	NATUREOFBUS VARCHAR(255),
	NICKNAME VARCHAR(254),
	OWNERPERID VARCHAR(10),
	OWNRENT VARCHAR(1),
	PAYMENTAGENCYASSISTANCE12MOACCT NUMBER(10,0),
	PAYMENTAGENCYASSISTANCE12MOCUST NUMBER(10,0),
	PAYMENTAGENCYASSISTANCEDOLLARS12MOACCT NUMBER(15,2),
	PAYMENTAGENCYASSISTANCEDOLLARS12MOCUST NUMBER(15,2),
	PAYMENTLASTCHANNELCODE VARCHAR(30),
	PAYMENTLASTCHANNELDESC VARCHAR(80),
	PAYMENTLASTCHANNELSUMMARY VARCHAR(30),
	PAYMENTLASTCHANNELSUMMARYHL VARCHAR(30),
	PEAKTIMEREBATESTATUS VARCHAR(25),
	PGEACCOUNTMONTHS NUMBER(10,0),
	PGECUSTOMERMONTHS NUMBER(10,0),
	POLELIGHTMAINTENANCE VARCHAR(60),
	POLELIGHTOWNER VARCHAR(60),
	PREFERREDDUEDATE VARCHAR(2),
	PREMISETYPECODE VARCHAR(8),
	PREMISETYPEDESC VARCHAR(60),
	PRIMARYLANGUAGE VARCHAR(3),
	RATESCHEDCODE VARCHAR(20),
	RATESCHEDDESC VARCHAR(60),
	RENEWENROLLMENTS VARCHAR(20),
	REVCLASSCODE VARCHAR(1),
	REVCLASSDESC VARCHAR(12),
	REVCLASSGRANULARCODE NUMBER(10,0),
	REVCLASSGRANULARDESC VARCHAR(12),
	SAENDDATE VARCHAR(10),
	SASTARTDATE VARCHAR(10),
	SASTATUS VARCHAR(60),
	SASTATUSFLAG VARCHAR(13),
	SATYPECODE VARCHAR(8),
	SATYPEDESC VARCHAR(60),
	SEGMENTCODERES VARCHAR(10),
	SEGMENTCODEBUS VARCHAR(10),
	SEGMENTDESCBUS VARCHAR(60),
	SEGMENTDESCRES VARCHAR(60),
	SEGMENTDESCSICBUS VARCHAR(60),
	SERVADDR1 VARCHAR(254),
	SERVADDR2 VARCHAR(254),
	SERVCITY VARCHAR(90),
	SERVCOUNTY VARCHAR(90),
	SERVSTATE VARCHAR(6),
	SERVTYPECODE VARCHAR(2),
	SERVTYPEDESC VARCHAR(60),
	SERVZIPCODE4 VARCHAR(4),
	SERVZIPCODE5 VARCHAR(5),
	SICCODE VARCHAR(8),
	SMARTTHERMOSTATPROGRAM VARCHAR(15),
	SMARTTHERMOSTATSTATUS VARCHAR(200),
	SPABOLISHDATE VARCHAR(10),
	SPINSTALLDATE VARCHAR(10),
	SPSOURCESTATUS VARCHAR(60),
	SPTYPECODE VARCHAR(8),
	SPTYPEDESC VARCHAR(60),
	SUBSTATIONNAME VARCHAR(60),
	TARIFFCODE VARCHAR(20),
	TAXCITY VARCHAR(90),
	TAXCOUNTY VARCHAR(90),
	TRANSFORMERBANK VARCHAR(60),
	TRANSFORMERNBR VARCHAR(60),
	TRANSFORMERSIZE VARCHAR(60),
	TRANSLOSSFACTORCODE VARCHAR(60),
	UNITSCLEANWIND NUMBER(18,6),
	UNITSGREENFUTURESOLAR NUMBER(18,6),
	WATERHEATTYPE VARCHAR(50),
	ETLLOADDTM TIMESTAMP_NTZ(9),
	ETLJOBID NUMBER(10,0)
);