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

--backoffice schema and user should exist

-- Table: backoffice.sepin

-- DROP TABLE backoffice.sepin;

CREATE TABLE backoffice.sepin
(
  idmsj character varying(12) NOT NULL,
  tipmesaj character varying(3) NOT NULL,
  nrref character varying(16) NOT NULL,
  nrdoc character varying(10),
  datadoc character varying(6),
  bicpl character varying(9),
  codpl character varying(13),
  numepl character varying(35),
  adresapl character varying(70),
  ibanpl character varying(24),
  bicbn character varying(9),
  codbn character varying(13),
  numebn character varying(35),
  adresabn character varying(70),
  ibanbn character varying(24),
  dataplatii character varying(6),
  nrcrbug numeric(23,0),
  sumatl numeric(14,2),
  sumant numeric(14,2),
  tipcms character varying(3),
  sumacm numeric(14,2),
  codop character varying(16),
  tran character varying(3),
  prb character varying(2),
  nrrefdest character varying(16),
  explicatii character varying(140),
  nrscv numeric(5,0),
  idgrp character varying(16),
  sumamsj numeric(14,2),
  refuzpl character varying(1),
  coderoare character varying(5) DEFAULT '0'::character varying,
  codsep character varying(1),
  tageroare character varying(5),
  erswift character varying(4),
  deterr character varying(29),
  indcov character varying(1),
  contbord character varying(34),
  bicbord character varying(11),
  contord character varying(34),
  contbbf character varying(34),
  bicbbf character varying(11),
  contbf character varying(34),
  detbanca character varying(210),
  biccbbf character varying(11),
  numeadcbbf character varying(140),
  bicbint character varying(11),
  contbint character varying(34),
  numeadbint character varying(140)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE backoffice.sepin
  OWNER TO backoffice;



-- Table: backoffice.sepout

-- DROP TABLE backoffice.sepout;

CREATE TABLE backoffice.sepout
(
  idmsj character varying(12) NOT NULL,
  tipmesaj character varying(3) NOT NULL,
  nrref character varying(16) NOT NULL,
  nrdoc character varying(10),
  datadoc character varying(6),
  bicpl character varying(9),
  codpl character varying(13),
  numepl character varying(35),
  adresapl character varying(70),
  ibanpl character varying(24),
  bicbn character varying(9),
  codbn character varying(13),
  numebn character varying(35),
  adresabn character varying(70),
  ibanbn character varying(24),
  dataplatii character varying(6),
  nrcrbug numeric(23,0),
  sumatl numeric(14,2),
  sumant numeric(14,2),
  tipcms character varying(3),
  sumacm numeric(14,2),
  codop character varying(16),
  tran character varying(3),
  prb character varying(2),
  nrrefdest character varying(16),
  explicatii character varying(140),
  nrscv numeric(5,0),
  idgrp character varying(16),
  sumamsj numeric(14,2),
  refuzpl character varying(1),
  coderoare character varying(5),
  codsep character varying(1),
  tageroare character varying(5),
  erswift character varying(4),
  deterr character varying(29),
  indcov character varying(1),
  contbord character varying(34),
  bicbord character varying(11),
  contord character varying(34),
  contbbf character varying(34),
  bicbbf character varying(11),
  contbf character varying(34),
  detbanca character varying(210),
  biccbbf character varying(11),
  numeadcbbf character varying(140),
  bicbint character varying(11),
  contbint character varying(34),
  numeadbint character varying(140)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE backoffice.sepout
  OWNER TO backoffice;

  
  -- Function: backoffice.sepabortmessage(character varying)

-- DROP FUNCTION backoffice.sepabortmessage(character varying);

CREATE FUNCTION backoffice.sepabortmessage(inmsgid character varying)
  RETURNS void AS
$BODY$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         
  Description:     
  Parameters:      inMsgID - fetched message identifier
  Returns:         n/a
  Used:            
***********************************************/

BEGIN

  update backoffice.sepout  set coderoare = '9'  where idmsj = inMsgID;
  
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while aborting message: % ', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION backoffice.sepabortmessage(character varying)
  OWNER TO backoffice;
GRANT EXECUTE ON FUNCTION backoffice.sepabortmessage(character varying) TO backoffice;


-- Function: backoffice.sepcommitmessage(character varying)

-- DROP FUNCTION backoffice.sepcommitmessage(character varying);

CREATE FUNCTION backoffice.sepcommitmessage(inmsgid character varying)
  RETURNS void AS
$BODY$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         
  Description:     
  Parameters:      inMsgID - fetched message identifier
  Returns:         n/a
  Used:            
***********************************************/

BEGIN

  update backoffice.sepout  set coderoare = '2'  where idmsj = inMsgID;
  
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while commiting message: % ', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION backoffice.sepcommitmessage(character varying)
  OWNER TO backoffice;
GRANT EXECUTE ON FUNCTION backoffice.sepcommitmessage(character varying) TO backoffice;

-- Function: backoffice.sepdecomposexmlmessage(character varying, text, character varying, numeric)

-- DROP FUNCTION backoffice.sepdecomposexmlmessage(character varying, text, character varying, numeric);

CREATE FUNCTION backoffice.sepdecomposexmlmessage(IN inxmlnothing character varying, IN inxmlmsg text, IN intablename character varying, IN inxmllength numeric, OUT inreturncode character varying, OUT inreturnmsg character varying)
  RETURNS record AS
$BODY$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         
  Description:     
  Parameters:      inMsgID - fetched message identifier
  Returns:         n/a
  Used:            
***********************************************/

v_XMLData xml;

BEGIN

  select xmlparse(DOCUMENT inxmlMsg) into v_XMLData;

  insert into backoffice.sepin
       ( idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn,
    numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran,
    prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, tageroare, erswift,
    deterr, codsep, indcov, contbord--, bicbord, contord, biccbbf, contbbf, bicbbf, contbf, detbanca,
    --numeadcbbf, bicbint, contbint, numeadbint 
    )
  select (xpath('/ROWSET/ROW/IDMSJ/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/TIPMESAJ/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/NRREF/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/NRDOC/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/DATADOC/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/BICPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/CODPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/NUMEPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/ADRESAPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/IBANPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/BICBN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/CODBN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/NUMEBN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/ADRESABN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/IBANBN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/DATAPLATII/text()', v_XMLData))[1]::varchar,
         ((xpath ('/ROWSET/ROW/NRCRBUG/text()', v_XMLData))[1]::varchar)::numeric,
         ((xpath ('/ROWSET/ROW/SUMATL/text()', v_XMLData))[1]::varchar)::numeric,
         ((xpath ('/ROWSET/ROW/SUMANT/text()', v_XMLData))[1]::varchar)::numeric,
         (xpath ('/ROWSET/ROW/TIPCMS/text()', v_XMLData))[1]::varchar,
         ((xpath ('/ROWSET/ROW/SUMACM/text()', v_XMLData))[1]::varchar)::numeric,
         (xpath ('/ROWSET/ROW/CODOP/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/TRAN/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/PRB/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/NRREFDEST/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/EXPLICATII/text()', v_XMLData))[1]::varchar,
         ((xpath ('/ROWSET/ROW/NRSCV/text()', v_XMLData))[1]::varchar)::numeric,
         (xpath ('/ROWSET/ROW/IDGRP/text()', v_XMLData))[1]::varchar,
         ((xpath ('/ROWSET/ROW/SUMAMSJ/text()', v_XMLData))[1]::varchar)::numeric,
         (xpath ('/ROWSET/ROW/REFUZPL/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/CODEROARE/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/TAGEROARE/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/ERSWIFT/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/DETERR/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/CODSEP/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/INDCOV/text()', v_XMLData))[1]::varchar,
         (xpath ('/ROWSET/ROW/CONTBORD/text()', v_XMLData))[1]::varchar;
                  
      
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while commiting message: % ', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION backoffice.sepdecomposexmlmessage(character varying, text, character varying, numeric)
  OWNER TO backoffice;

  
  -- Function: backoffice.sepgetmessage()

-- DROP FUNCTION backoffice.sepgetmessage();

CREATE FUNCTION backoffice.sepgetmessage(OUT outretcursor refcursor)
  RETURNS refcursor AS
$BODY$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         
  Description:     
  Parameters:      n/a
  Returns:         cursor result set
  Used:            
***********************************************/

v_msgid     backoffice.sepout.idmsj%type;

BEGIN

   update backoffice.sepout set coderoare = '1' where idmsj in 
     (select idmsj from backoffice.sepout where coderoare = '0' limit 1) 
   returning idmsj into v_msgid;

  
   open outretcursor for
   select
	v_msgid rowid,idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn,
	numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran,
	prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, tageroare, erswift,
	deterr, codsep, indcov, contbord, bicbord, contord, biccbbf, contbbf, bicbbf, contbf, detbanca,
	numeadcbbf, bicbint, contbint, numeadbint
   from backoffice.sepout where idmsj = v_msgid;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering message: % ', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION backoffice.sepgetmessage()
  OWNER TO backoffice;
GRANT EXECUTE ON FUNCTION backoffice.sepgetmessage() TO backoffice;


--SAMPLE data

INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057123', '103', '1600000000055882', '838', '140606', 'SPXAROB0X', '7852913', 'JOHN SMITH', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55882, 55882, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057128', '103', '1600000000055887', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55887, 55887, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057121', '103', '1600000000055880', '838', '140606', 'SPXAROB0X', '7852913', 'JOHN DOE', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55800, 55880, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057127', '103', '1600000000055886', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55886, 55886, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057126', '103', '1600000000055885', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55885, 55885, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057125', '103', '1600000000055884', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55884, 55884, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057124', '103', '1600000000055883', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55883, 55883, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO backoffice.sepout (idmsj, tipmesaj, nrref, nrdoc, datadoc, bicpl, codpl, numepl, adresapl, ibanpl, bicbn, codbn, numebn, adresabn, ibanbn, dataplatii, nrcrbug, sumatl, sumant, tipcms, sumacm, codop, tran, prb, nrrefdest, explicatii, nrscv, idgrp, sumamsj, refuzpl, coderoare, codsep, tageroare, erswift, deterr, indcov, contbord, bicbord, contord, contbbf, bicbbf, contbf, detbanca, biccbbf, numeadcbbf, bicbint, contbint, numeadbint) VALUES ('166615057122', '103', '1600000000055881', '838', '140606', 'SPXAROB0X', '7852913', 'SANO VITA SRL', 'BUCHAREST', 'RO09SPXA492222789837', 'BNKAROB0X', '2541130', 'b1', NULL, 'RO69BNKA6712017010101XXX', '140606', NULL, 55881, 55881, 'SHA', NULL, 'CRED', '701', '33', NULL, 'details', 0, '062217S000089773', NULL, 'N', '2', 'A', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

