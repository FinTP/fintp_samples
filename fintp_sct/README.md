Release Notes 24.01.2014

# 1. Useful Information

Requirements

- CentOS
- Postgres 9.1
- ActiveMQ  5.9.0/WebSphereMQ 7.1
- Tomcat 

# 2. Installation and configuration

Follow the following steps to setup an environment that implements the requirements detailed in the [outgoing sepa credit transfer scenario](http://www.fintp.org/releases/fintp-usage-scenarios/scenario-outgoing-sepa-credit-transfer/)

## Steps on ActiveMQ/WebSphereMQ server

1. If you use WebSphereMQ server, create a queue manager called `FINTPQM.MainHub` and a server connection type channel called `FromConnectors`.
2. Create the following queues:

- BOSAAtoFINTP
- BOSAAtoFINTP.bck`
- BOSEPA.ToConnector`
- SEPA.ToConnector
- Events
- FINTPtoBOSAA
- FromConnectors
- MQHA.ToApp
- MQHA.FromApp
- MQHA.FromApp.bck`

## Steps on FinTP server

1. Create a folder **fintp** in the desired location with the following structure:

    - fintp
      - fintp/lib
      - fintp/logs
      - fintp/connectors
      - fintp/core

2. In the fintp folder copy the sample scripts

- fintpSetEnv.sh
- fintpUtil.sh
- fintpMon.sh
- fintpStart.sh
- fintpStop.sh 

3. In the fintp/lib folder copy all the libraries 

4. In the fintp/core folder copy the following files:

- RoutingEngine binary
- EventsWatcher binary
- RoutingEngine.config example. Depending on your environment (if you use ActiveMQ or WebsphereMQ),  copy one of the files RoutingEngine.config_MQ or RoutingEngine.config_AMQ under the name RoutingEngine.config)
- EventsWatcher.config example. Depending on your environment (if you use ActiveMQ or WebsphereMQ),  copy one of the files EventsWatcher.config_MQ or EventsWatcher.config_AMQ under the name EventsWatcher.config)
- FINToSepa.xslt
- SepaHeader.xslt
- SepaToFIN.xslt

5. In the fintp/connectors folder copy the following files:

- FinTPDBConnector binary
- FinTPNODBConnector binary
- BOSEPAConnector.config example. Depending on your environment (if you use ActiveMQ or WebsphereMQ),  copy one of the files BOSEPAConnector.config_MQ or BOSEPAConnector.config_AMQ under the name BOSEPAConnector.config)
- DBConnector.config example. Depending on your environment (if you use ActiveMQ or WebsphereMQ),  copy one of the files DBConnector.config_MQ or DBConnector.config_AMQ under the name DBConnector.config)
- SEPAConnector.config example. Depending on your environment (if you use ActiveMQ or WebsphereMQ),  copy one of the files SEPAConnector.config_MQ or SEPAConnector.config_AMQ under the name SEPAConnector.config)
- Cleanup.xslt
- getGroupElement.SEPA.EBA.xslt 
- ParamFileGen.xslt
- putGroupElement.SEPA.EBA.xslt
- SEPA2FINTP.xslt
- SWIFT2FINTP.xslt

6. Create the following links in fintp/connectors folder (this will create the necessary connectors)

- ln -s FinTPDBConnector DBConnector
- ln -s FinTPNODBConnector BOSEPAConnector
- ln -s FinTPNODBConnector SEPAConnector

7. Customize fintp/fintpSetEnv.sh file according to your environment

Set the variable `FINTPHOME` to your fintp folder

8. Customize .config files for connectors in connectors folder

- BOSEPAConnector - the connector that receives data from BackOffice application in an AMQ or WMQ queue (MT 103 messages)  and send them to FinTP server
Edit BOSEPAConnector.config - customize it according to your environment. 
Pay attention to location of .xslt and .xml files and data about your AMQ/WMQ connection

- DBConnector - the connector that receives data from all other connectors and send them in FinTP internal database 
Edit DBConnector.config - customize it according to your environment. 
Pay attention to data about your AMQ/WMQ connection

- SEPAConnector - the conector that sends batches  (pacs.008 xml messages) to external application
Pay attention to location of .xslt and .xml files and data about your AMQ/ WMQ connection

9. Customize .config files for Routing Engine and EventsWatcher in core folder

- RoutingEngine - the core of FinTP solution
Edit RoutingEngine.config - customize it according to your environment. 
Pay attention to data about your AMQ/WMQ connection

- EventsWatcher - the connector that receives events from all other components 
Edit EventsWatcher.config - customize it according to your environment. 
Pay attention to data about your AMQ/WMQ connection

10. Create and configure the  fintp database:

Follow the steps in Installation section in the [fintp_db project](https://github.com/FinTP/fintp_db/README.md)

Run configs.sql script file

    psql -f configs.sql -d <database_name> -U postgres

If you choose to use AMQ config, edit the EPconfigsAMQ.sql file and change the values in brakets according to your environment; then run the script file.

    psql -f EPconfigsAMQ.sql -d <database_name> -U postgres

If you choose to use WMQ config, edit the EPconfigsWMQ.sql file and change the values in brakets according to your environment; then run the script file

    psql -f EPconfigsWMQ.sql -d <database_name> -U postgres

11. Install the FinTP interface
12. The initial users are user1, user2, user3 with passwords admin.
