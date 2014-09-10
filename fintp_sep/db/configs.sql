/*
* FinTP - Financial Transactions Processing Application
* Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>
* or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
* phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.
*/



INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (18, 'SEP Payments', 'n/a', 1);

INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('BORTNACHOut', 17, 1, 0, 50, '4/3/2014 6:33:32 PM', NULL, NULL, 1, 1, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('RTNACHIn', 18, 1, 0, 50, '4/3/2014 6:34:03 PM', NULL, NULL, 1, 0, '', '53427d7e-62fa5082-17be0004', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('ACHIn', 15, 3, 0, 50, '4/3/2014 6:32:50 PM', NULL, NULL, 1, 0, '', '538c2a69-975d5082-e6f00001', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('BOACHOut', 16, 1, 0, 50, '4/3/2014 6:32:47 PM', NULL, NULL, 1, 0, '', '53427d7e-62fa5082-17be0005', 1, 'ACHDupOutQueue', 'getHash.CdtOut.xslt', NULL, NULL);
COMMIT;


INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (19, 'ACHInQueue', 0, NULL, 101, 0, 'SEP:ACH incomings entry queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (22, 'BOACHOutQueue', 0, NULL, 101, 0, 'SEP:ACH outgoings entry queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (20, 'ACHOutQueue', 0, 15, 101, 1000, 'SEP:ACH authorization queue', 50, '');
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (21, 'BOACHInQueue', 0, 16, 101, 0, 'Intermediary queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (23, 'BORTNACHInQueue', 0, 17, 101, 0, 'Intermediary queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (24, 'BORTNACHOutQueue', 0, NULL, 101, 0, 'SEP:ACH outgoing returns entry queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (25, 'RTNACHOutQueue', 0, 18, 101, 1000, 'SEP:ACH returns authorization queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (39, 'ACHDupOutQueue', 0, NULL, 102, 0, 'SEP:ACH outgoings duplicate queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (13, 'InvestigOutQueue', 0, NULL, 103, 0, 'Investigation queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (12, 'InvestigInQueue', 0, NULL, 103, 0, 'Investigation queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (103, 'Complete', 0, NULL, 103, 0, 'Complete queue', 10, '');
COMMIT;



INSERT INTO fincfg.timelimits (guid, limitname, limittime) VALUES (2, 'Stop app', '12/9/2013 8:15:57 PM');
INSERT INTO fincfg.timelimits (guid, limitname, limittime) VALUES (1, 'Start app', '12/9/2013 8:45:52 AM');
COMMIT;

INSERT INTO fincfg.routingschemas (name, description, active, guid, startlimit, stoplimit, sessioncode, isvisible) VALUES ('SEP-ACH', 'SEP:ACH routing schema', 1, 5, 1, 2, 'ACH', '0');
INSERT INTO fincfg.routingschemas (name, description, active, guid, startlimit, stoplimit, sessioncode, isvisible) VALUES ('FTP', 'complete msgs schema', 1, 99, 1, 2, 'FTP', '1');
COMMIT;

INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (200, 19, 5, 100, 0, 'complete reconciliation messages', NULL, NULL, 'NS in urn:swift:xs:NotificationMessage', 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (205, 19, 5, 600, 0, 'move CoreBlk', 'MT==CoreBlkLrgRmtCdtTrf', NULL, NULL, 'MoveTo(BOACHInQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (206, 20, 5, 100, 0, 'move reactivated returns', NULL, NULL, 'REQUESTOR==BORTNACHOut', 'MoveTo(RTNACHOutQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (207, 20, 5, 200, 0, 'hold message in queue', NULL, NULL, NULL, 'ChangeHoldStatus(true)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (208, 20, 5, 300, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(SwiftToACH.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (209, 19, 5, 550, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(ACHToSwift.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (212, 22, 5, 200, 0, 'move CoreBlk', NULL, NULL, NULL, 'MoveTo(ACHOutQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (215, 24, 5, 200, 0, 'move CoreBlk return', NULL, NULL, NULL, 'MoveTo(RTNACHOutQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (216, 25, 5, 100, 0, 'hold message in queue', NULL, NULL, NULL, 'ChangeHoldStatus(true)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (217, 25, 5, 200, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(SwiftToACH.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (210, 21, 5, 100, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(SwiftToDBBO.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (211, 22, 5, 100, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(DBBOToSwift.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (249, 103, 99, 100, 0, 'complete msg', NULL, NULL, NULL, 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (202, 19, 5, 140, 0, 'send negative answer to BO', NULL, 'IsNack()==true', NULL, 'SendReply()');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (203, 19, 5, 150, 0, 'aggregate interface ack', NULL, 'IsReply(urn:swift:xs:CoreBlkLrgRmtCdtTrf)==true', 'FEEDBACKCODE==FTM00', 'Aggregate');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (204, 19, 5, 160, 0, 'complete interm replies', NULL, 'IsReply()==true', NULL, 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (201, 19, 5, 120, 0, 'send positive answer to BO', NULL, 'IsAck()==true', NULL, 'SendReply()');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (213, 23, 5, 100, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(SwiftToDBBO.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (214, 24, 5, 100, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(DBBOToSwift.xslt)');

COMMIT;

--queuesrolemap
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (2652, 39, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (10, 20, 2, 'RW');

Insert into FINCFG.USERS (USERID, USERNAME, PASSWORD, SKINCOLOR, ISLOCKED, NORETRY, PAYMSETPREF, QSETPREF)
 Values  (52, 'admin', '670657fe99ad06927fbe160317f55d57cf8060a7e2f327b9c2b15859e4bac62135ad0045fd0ab1c4','Blue', 0, 4, 'all', 'all');
COMMIT;


Insert into FINCFG.USERSROLEMAP   (MAPID, USERID, ROLEID) Values  (1, 52, 2);
COMMIT;


INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (15, '4/4/2014 4:48:48 PM', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (16, '4/4/2014 4:49:06 PM', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (17, '4/4/2014 4:49:22 PM', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (18, '4/4/2014 4:49:51 PM', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (19, '4/8/2014 2:31:25 PM', 0, 0, 0, 0, 0, 0, 0, 0);
COMMIT;
