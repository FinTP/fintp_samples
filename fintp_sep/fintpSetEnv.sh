# FinTP - Financial Transactions Processing Application
# Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
# or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
# phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.

FINTPHOME=/home/fintp/fintp
FINTPLIB=$FINTPHOME/lib
FINTPCOREPATH=$FINTPHOME/core
FINTPLOGDIR=$FINTPHOME/logs
FINTPCONNECTORSPATH=$FINTPHOME/connectors
FINTPCORESTART="EventsWatcher RoutingEngine"
FINTPCORESTOP="EventsWatcher RoutingEngine"
FINTPCONNECTORSSTART="DBConnector FTPBOSEPConnector FTPACHSTPConnector"
FINTPCONNECTORSSTOP="DBConnector FTPBOSEPConnector FTPACHSTPConnector"


set -a FINTPSERVICESCORE EventsWatcher RoutingEngine
set -a FINTPSERVICESCOREID EW RE 
set -a FINTPSERVICESCONN DBConnector FTPBOSEPConnector FTPACHSTPConnector
set -a FINTPSERVICESCONNID DB BOSEP ACHSTP

FINTPSTOPTIMEOUT=300
LD_LIBRARY_PATH=/opt/mqm/lib64:/usr/local:/usr/lib/oracle/11.2/client64/lib:/home/fintp/fintp/lib:/home/oracle/app/oracle/product/11.2.0/client_1:$FINTPLIB

PATH=$PATH:$FINTPHOME:$FINTPCONNECTORSPATH:$FINTPCOREPATH
export FINTPSERVICESCORE FINTPSERVICESCOREID FINTPCORESTART FINTPCORESTOP FINTPSERVICESCONN FINTPSERVICESCONNID FINTPSTOPTIMEOUT FINTPCONNECTORSSTART FINTPCONNECTORSSTOP FINTPHOME FINTPLIB FINTPLOGDIR FINTPCOREPATH FINTPCONNECTORSPATH LIBPPATH PATH
