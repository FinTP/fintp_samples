update fincfg.servicemaps set 
 exitpoint = 'Q=BOA.ToConnector;QM={host};CH=tcp://{host}:61616;MO=MO_INSERTBATCH+MO_GENERATEID;MQT=AMQ;' 
where serviceid = 17;

update fincfg.servicemaps set 
  exitpoint = 'Q=ACH.ToConnector;QM={host};CH=tcp://{host}:61616;RO=MQRO_NAN+MQRO_PAN+MQRO_COPY_MSG_ID_TO_CORREL_ID;S=cblrct.xsd;NS=urn:swift:xsd:CoreBlkLrgRmtCdtTrf;MQT=AMQ;' 
where serviceid = 18;

update fincfg.servicemaps set 
  exitpoint = 'Q=ACH.ToConnector;QM={host};CH=tcp://{host}:61616;RO=MQRO_NAN+MQRO_PAN+MQRO_COPY_MSG_ID_TO_CORREL_ID;S=cblrct.xsd;NS=urn:swift:xsd:CoreBlkLrgRmtCdtTrf;MQT=AMQ;' 
where serviceid = 15;

update fincfg.servicemaps set 
  exitpoint = 'Q=BOA.ToConnector;QM={host};CH=tcp://{host}:61616;MO=MO_INSERTBATCH+MO_GENERATEID;MQT=AMQ;' 
where serviceid = 16;
commit;

