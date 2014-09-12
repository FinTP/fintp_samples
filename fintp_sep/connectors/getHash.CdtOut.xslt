<!--
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
-->

<?xml version="1.0" encoding="ascii"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 	xmlns:external="http://extensions.bisnet.ro" 	exclude-result-prefixes="external">
	<xsl:output method="text" version="1.0" encoding="us-ascii"/>
	<xsl:strip-space elements="*"/>
	<xsl:variable name="VHash" select="concat(
	    /Record/TIPMESAJ  ,
	    /Record/NRDOC  ,
	    /Record/IBANPL   ,
	    /Record/BICBN   ,
	    /Record/IBANBN  ,
	    /Record/NRCRBUG   ,
	    /Record/SUMATL   ,
	    /Record/SUMANT   ,
	    /Record/TRAN   ,
	    /Record/PRB
)"/>

	<xsl:template match="/">
					<xsl:value-of select="external:hash($VHash)"/>
	</xsl:template>
	
</xsl:stylesheet>
