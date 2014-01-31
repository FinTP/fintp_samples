update fincfg.servicemaps set 
 exitpoint = 'Q=SEPA.ToConnector;CH=tcp://{hostname}:61616;MQT=AMQ' 
where serviceid = 11;


update fincfg.servicemaps set 
  exitpoint = 'Q=BOSEPA.ToConnector;CH=tcp://{hostname}:61616;MQT=AMQ' 
where serviceid = 12;

commit;

