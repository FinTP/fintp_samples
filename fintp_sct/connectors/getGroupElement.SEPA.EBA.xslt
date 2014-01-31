<?xml version="1.0" encoding="UTF-8"?>
<!--
$HeadURL: https://svn.domain.bisnet.ro/svn/qPI/branches/SEPA/qPaySetup/images/TEST/qPayConnectors/getGroupElement.SEPA.xslt $
$Revision: 16072 $ 
 $LastChangedDate: 2010-06-29 10:44:33 +0300 (Tue, 29 Jun 2010) $
 $LastChangedBy: cristinac $
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:cdttrf="urn:swift:xsd:CoreBlkLrgRmtCdtTrf" 
	
	xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02"
	xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03"
	
	xmlns:S2SCTScf="urn:S2SCTScf:xsd:$SCTScfBlkCredTrf"
		
	xmlns:p02S2="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2"
	xmlns:S2SCTIcf="urn:S2SCTIcf:xsd:$SCTIcfBlkCredTrf"
	xmlns:S2SCTCvf="urn:S2SCTCvf:xsd:$SCTCvfBlkCredTrf" 
	xmlns:saa="urn:swift:saa:xsd:saa.2.0"
	
	
	xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="external">
	
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="no"/>
	<xsl:strip-space elements="*"/>
	
	<xsl:param name="XSLTPARAMPOSITION"/>
   <!--xsl:variable name="XSLTPARAMPOSITION" select="1"/-->
			
			
				
	<xsl:template match="S2SCTScf:SCTScfBlkCredTrf">
			<xsl:choose>
				<xsl:when test="string-length(//S2SCTScf:SCTScfBlkCredTrf/S2SCTScf:FIToFICstmrCdtTrf)&gt;0">
					<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
							<xsl:element name="root">
								<xsl:element name="Document" namespace="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02">
										<xsl:element name="FIToFICstmrCdtTrf" namespace="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02">
											<xsl:apply-templates select="//S2SCTScf:SCTScfBlkCredTrf/S2SCTScf:FIToFICstmrCdtTrf/p08:GrpHdr" mode="copy_all_elem">
													<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02'"/>
											</xsl:apply-templates>
											<xsl:apply-templates select="//S2SCTScf:SCTScfBlkCredTrf/S2SCTScf:FIToFICstmrCdtTrf/p08:CdtTrfTxInf[position()=$XSLTPARAMPOSITION]" mode="copy_all_elem">
														<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02'"/>
											</xsl:apply-templates>
										</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:if>
						<xsl:if test="$XSLTPARAMPOSITION='0'">
							<Batch>
								<xsl:attribute name="Id">
									<xsl:value-of select="//p08:GrpHdr/p08:MsgId"/>
								</xsl:attribute>
								<xsl:attribute name="Count">
									<xsl:value-of select="count(//p08:CdtTrfTxInf )"/>
								</xsl:attribute>
							</Batch>
						</xsl:if>	
				</xsl:when>
					
			</xsl:choose>
	
	</xsl:template>
	
	<xsl:template match="saa:DataPDU">
			<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
				<xsl:element name="root">
						<xsl:copy-of select="//saa:DataPDU" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="$XSLTPARAMPOSITION='0'">
				<Batch>
					<xsl:attribute name="Id">
						<xsl:value-of select="//saa:Header/saa:TransmissionReport/saa:SenderReference"/>
					</xsl:attribute>
					<xsl:attribute name="Count">
						<xsl:value-of select="'1'"/>
					</xsl:attribute>
				</Batch>
			</xsl:if>
	 </xsl:template>
	 
	 <xsl:template match="S2SCTCvf:SCTCvfBlkCredTrf">
		<xsl:variable name = "countMessages" select="count(//p02S2:TxInfAndSts )"/>
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root">
			 	 <xsl:element name="Document" namespace="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2">
						<xsl:element name="FIToFIPmtStsRptS2" namespace="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2">
							  <xsl:choose>	
								     <xsl:when test="$XSLTPARAMPOSITION = 1  and $countMessages = 0 ">
												<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:GrpHdr" mode="copy_all_elem">
													    <xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
											 	   </xsl:apply-templates>
													<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:OrgnlGrpInfAndSts" mode="copy_all_elem">
															<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
											 	   </xsl:apply-templates>
													<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:TxInfAndSts[ position()=$XSLTPARAMPOSITION ]" mode="copy_all_elem">
															<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
											 	   </xsl:apply-templates>
									</xsl:when>
									<xsl:otherwise>
											<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:GrpHdr" mode="copy_all_elem">
											    <xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
									 	   </xsl:apply-templates>
											<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:OrgnlGrpInfAndSts" mode="copy_all_elem">
													<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
									 	   </xsl:apply-templates>
											<xsl:apply-templates select="//S2SCTCvf:SCTCvfBlkCredTrf/S2SCTCvf:FIToFIPmtStsRptS2/p02S2:TxInfAndSts[ position()=$XSLTPARAMPOSITION ]" mode="copy_all_elem">
													<xsl:with-param name="nms" select="'urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03S2'"/>
									 	   </xsl:apply-templates>
									</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
				</xsl:element>
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
				<Batch>
							<xsl:attribute name="Id">
								  <xsl:value-of select="//p02S2:GrpHdr/p02S2:MsgId"/>
							</xsl:attribute>
							<xsl:attribute name="Count">
								 <xsl:choose>
										<xsl:when test="$countMessages = 0">		
												<xsl:text>1</xsl:text>
										</xsl:when>
										<xsl:otherwise>
													<xsl:value-of select="$countMessages"/>
										</xsl:otherwise>
								 </xsl:choose>		
						   </xsl:attribute>
				</Batch>	
			</xsl:if>
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
