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



INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (17, 'SEPA Payments', 'n/a', 1);

INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (6, 101, 0);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (3, 101, 1);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (1, 101, 2);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (2, 101, 3);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (7, 101, 4);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (8, 101, 6);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (9, 101, 7);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (10, 104, 12);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (11, 104, 13);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (12, 104, 14);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (13, 102, 2);
INSERT INTO fincfg.qtypeactionmaps (mapid, qtypeid, qactionid) VALUES (14, 102, 3);
COMMIT;


INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('SEPAIn', 11, 3, 0, 0, '1/17/2014 3:22:01 PM', '', ' ', 1, 0, '', '52cd58c0-6b4f5f79-ad020001', 1, '', '', '', '');
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('BOSEPAOut', 12, 3, 0, 50, '1/17/2014 3:22:02 PM', '', ' ', 1, 1, '', '52d3b7e9-3b255f79-34460001', 1, 'CTDupOutQueue', 'getHash.SepaOut.xslt', '', '');
COMMIT;


INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (7, 'CTInQueue', 0, NULL, 101, 0, 'Intermediary queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (11, 'BOSEPAInQueue', 0, 12, 101, 0, 'Intermediary queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (10, 'SEPAInQueue', 0, NULL, 101, 0, 'SEPA incomings entry queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (9, 'BOSEPAOutQueue', 0, NULL, 101, 0, 'SEPA outgoings entry queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (5, 'CTOutQueue', 0, 11, 101, 0, 'Credit Transfer authorization queue', 50, NULL);
INSERT INTO fincfg.queues (guid, name, holdstatus, connector, typeid, batchno, description, priority, autobatchtime) VALUES (14, 'CTDupOutQueue', 0, NULL, 102, 0, 'Credit Transfer duplicates queue', 50, NULL);
COMMIT;


INSERT INTO fincfg.qmoveprivmaps (mapid, sourcequeueid, destqueueid) VALUES (1, 5, 103);
INSERT INTO fincfg.qmoveprivmaps (mapid, sourcequeueid, destqueueid) VALUES (2, 5, 13);
INSERT INTO fincfg.qmoveprivmaps (mapid, sourcequeueid, destqueueid) VALUES (3, 14, 5);
INSERT INTO fincfg.qmoveprivmaps (mapid, sourcequeueid, destqueueid) VALUES (4, 14, 103);
COMMIT;


INSERT INTO fincfg.routingschemas (name, description, active, guid, startlimit, stoplimit, sessioncode, isvisible) VALUES ('SEPA', 'SEPA routing schema', 1, 3, 1, 2, 'SEPA', '0');
COMMIT;


INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (175, 5, 3, 100, 0, 'hold message in queue', NULL, NULL, NULL, 'ChangeHoldStatus(true)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (180, 10, 3, 300, 0, 'move CT', 'MT==FIToFICstmrCdtTrf', NULL, NULL, 'MoveTo(CTInQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (171, 10, 3, 205, 0, 'complete NACKs', NULL, 'isNack()==true', NULL, 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (170, 10, 3, 250, 0, 'complete all ACKs', NULL, 'isReply()==true', NULL, 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (169, 10, 3, 50, 0, 'complete', NULL, 'isReply()==false', 'NS==urn:swift:saa:xsd:saa.2.0', 'Complete');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (178, 10, 3, 100, 0, 'transform', NULL, NULL, NULL, 'Aggregate');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (187, 11, 3, 100, 0, 'transform to backoffice', NULL, NULL, NULL, 'TransformMessage(SepaToFIN.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (177, 9, 3, 300, 0, 'move CT to specific queue', 'MT==FIToFICstmrCdtTrf', NULL, NULL, 'MoveTo(CTOutQueue)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (174, 9, 3, 200, 0, 'transform', NULL, NULL, NULL, 'TransformMessage(FINToSepa.xslt)');
INSERT INTO fincfg.routingrules (guid, queueid, schemaguid, "sequence", ruletype, description, msgcond, funccond, metacond, "action") VALUES (182, 7, 3, 200, 0, 'move to BOSEPAInQueue', NULL, NULL, NULL, 'MoveTo(BOSEPAInQueue)');
COMMIT;



INSERT INTO fincfg.usersecurity (pwddays, pwdlength, pwdno, retryno, pwdlower, pwdupper, passno) VALUES (900, 0, 0, 9, 0, 0, 0);
COMMIT;


INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (6, 5, 17, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (8, 14, 17, 'RW');
COMMIT;
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (100, 5, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (101, 14, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (103, 7, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (106, 11, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (107, 10, 2, 'RW');
INSERT INTO fincfg.queuesrolemap (mapid, queueid, roleid, actiontype) VALUES (108, 9, 2, 'RW');
COMMIT;


INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (11, '1/27/2014 2:03:16 PM', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (12, '1/27/2014 2:03:22 PM', 0, 0, 0, 0, 0, 0, 0, 0);
COMMIT;
