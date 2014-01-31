update fincfg.servicemaps set 
 exitpoint = 'Q=SEPA.ToConnector;QM={queue_mananger_name};CH=FromConnectors/TCP/{hostname}(1414);MQT=WMQ' 
where serviceid = 11;


update fincfg.servicemaps set 
  exitpoint = 'Q=BOSEPA.ToConnector;QM={queue_mananger_name};CH=FromConnectors/TCP/{hostname}(1414);MQT=WMQ' 
where serviceid = 12;

commit;

