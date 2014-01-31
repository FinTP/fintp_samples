<?xml version="1.0" encoding="UTF-8"?>
<!--
$HeadURL: https://svn.domain.bisnet.ro/svn/qPI/branches/SEPA/qPaySetup/images/ALL/qPayConnectors/putGroupElement.SEPA.EBA.xslt $
$Revision: 21859 $ 
 $LastChangedDate: 2013-12-12 11:46:10 +0200 (Thu, 12 Dec 2013) $
 $LastChangedBy: costi $
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 

	xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02"
	xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03"
	
	xmlns:S2SCTIcf="urn:S2SCTIcf:xsd:$SCTIcfBlkCredTrf"
>	
	
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>
	
	 <xsl:param name="XSLTPARAMPOSITION"/>
    <!--xsl:variable name="XSLTPARAMPOSITION" select="1"/-->
					
	<xsl:template match="S2SCTIcf:SCTIcfBlkCredTrf">
			<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
										<xsl:element name="S2SCTIcf:FIToFICstmrCdtTrf"  xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02">
											<xsl:apply-templates select="//S2SCTIcf:SCTIcfBlkCredTrf/S2SCTIcf:FIToFICstmrCdtTrf/p08:CdtTrfTxInf[position()=1]" mode="copy_all_elem">
														<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02'"/>
											</xsl:apply-templates>
										</xsl:element>
						</xsl:if>
						<xsl:if test="$XSLTPARAMPOSITION='0'">
							<xsl:copy-of select="//S2SCTIcf:SCTIcfBlkCredTrf"/>		
						</xsl:if>	
	</xsl:template>
	<xsl:template match="*">
			</xsl:template>
		<xsl:template match="*" mode="copy_all_elem" >
	 		<xsl:param name="nms"/>
	 		<xsl:element name="{name()}" namespace="{$nms}">
		        <xsl:copy-of select="@*"/>
		        <xsl:apply-templates mode="copy_all_elem">
		        	<xsl:with-param name="nms" select="$nms"/>
		        	</xsl:apply-templates>
		    </xsl:element>
	 </xsl:template>
</xsl:stylesheet>
