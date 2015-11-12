
<?xml version="1.0"?>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02" 
xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.02"
exclude-result-prefixes="p08 p02">

	<xsl:output omit-xml-declaration="no" indent="yes"/>
	
	<xsl:strip-space elements="*"/>

	<xsl:template match="//S2SCTIcf:FIToFICstmrCdtTrf">
		<S2SCTIcf:FIToFICstmrCdtTrf xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</S2SCTIcf:FIToFICstmrCdtTrf>
	</xsl:template>
	
		
	
	<xsl:template match="*" priority="-2">
		<xsl:element name="{name(.)}" namespace="{namespace-uri(.)}">
			<xsl:copy-of select="namespace::*[(name(.)!=&apos;p08&apos;) and name(.)!=&apos;p02&apos;]"/>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="comment()|processing-instruction()|text()">
		<xsl:copy/>
	</xsl:template>
	
</xsl:stylesheet>
