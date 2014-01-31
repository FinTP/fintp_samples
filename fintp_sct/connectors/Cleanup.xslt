<?xml version="1.0"?>

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