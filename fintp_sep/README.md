Release Notes 11.06.2014

# 1. Useful Information

Requirements

- CentOS
- Postgres 9.1
- ActiveMQ  5.9.0
- Tomcat 

# 2. Installation and configuration

Follow the next steps to setup an environment that help you implement a sample of SEP - ACH flow

## Steps on ActiveMQ/WebSphereMQ server

1. Create the following queues:

```
    - BOA.FromConnector
    - Events
    - FromConnectors
    - FTMtoFINTP
    - FTMtoFINTPBackup1
    - ACH.ToConnector
    - FINTPtoFTM

```

## Steps on FinTP server

####1. Create a folder **fintp** in the desired location with the following structure:

```
    <FINTP_HOME>
      - lib
      - logs
      - connectors
      - core
```

####2. In the **fintp** folder copy the sample scripts

```
    - fintpSetEnv.sh
    - fintpUtil.sh
    - fintpMon.sh
    - fintpStart.sh
    - fintpStop.sh 
```

####3. In the **fintp/lib** folder copy all the libraries 

####4. In the **fintp/core** folder copy the following files:

```
    - RoutingEngine binary
    - EventsWatcher binary
    - RoutingEngine.config example    
    - EventsWatcher.config example 
    - all .xslt files from /core
```

####5. In the **fintp/connectors** folder copy the following files:

```
    - FinTPDBConnector binary
    - FTPBOSEPConnector.config example
    - DBConnector.config example 
    - FTPACHSTPConnector.config example
    - all .xslt and .dad files from /connectors
```

####6. Create the following links in **fintp/connectors** folder (this will create the necessary connectors)

```
    - ln -s FinTPDBConnector DBConnector
    - ln -s FinTPDBConnector FTPACHSTPConnector
    - ln -s FinTPDBConnector FTPBOSEPConnector
````

####7. Customize `fintp/fintpSetEnv.sh` file according to your environment

Set the variable `FINTPHOME` to your fintp folder

####8. Customize .config files for connectors in connectors folder

- `FTPBOSEPConnector` - the connector that receives data from BackOffice application (postgresql database) in an AMQ queue (MT 103 messages)  and send them to FinTP server

Edit `FTPBOSEPConnector.config` - customize it according to your environment. 
Pay attention to your AMQ data connection

- `DBConnector` - the connector that receives data from all other connectors and send them in FinTP internal database

Edit `DBConnector.config` - customize it according to your environment. 
Pay attention to your AMQ data connection

- `FTPACHSTPConnector` - the conector that sends batches  (CoreBlkLrgRmtCdtTrf xml messages) to external application

Pay attention to your AMQ data connection


####9. Customize .config files for Routing Engine and EventsWatcher in core folder

- `RoutingEngine` - the core of FinTP solution

Edit `RoutingEngine.config` - customize it according to your environment. 
Pay attention to data about your AMQ connection

- `EventsWatcher` - the connector that receives events from all other components 

Edit `EventsWatcher.config` - customize it according to your environment. 
Pay attention to data about your AMQ connection

####10. Create and configure the fintp database:

Follow the steps in Installation section in the [fintp_db project](https://github.com/FinTP/fintp_db/README.md)

Run configs.sql script file

    psql -f configs.sql -d <database_name> -U postgres

If you choose to use AMQ config, edit the `EPconfigsAMQ.sql` file and change the values in brakets according to your environment; then run the script file.

    psql -f EPconfigsAMQ.sql -d <database_name> -U postgres

####11. Create and configure a BO app database:    

    psql -f BOstructure.sql -d <database_name> -U postgres

####12. Start FinTP
 
	./fintpStart.sh 

####13. Install the FinTP interface 
*the initial user is admin. 
