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

<?xml version="1.0" encoding="us-ascii"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02" 
xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02"
xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.02">

  <xsl:output method="xml" version="1.0" encoding="us-ascii"/>

  <xsl:param name="XSLTPARAMBATCHID"/>
  <xsl:param name="XSLTPARAMDATE"/>
  <xsl:param name="XSLTPARAMBATCHAMOUNT"/>
  <xsl:param name="XSLTPARAMBATCHCOUNT"/>
  
  <xsl:template match="node()|@*">
   <xsl:copy>
	   <xsl:apply-templates select="@*"/>
	   <xsl:apply-templates/>
   </xsl:copy>
 </xsl:template>
  

  	<xsl:variable name="nms">
 				<xsl:choose>
 						<xsl:when test="string-length(//p08:GrpHdr) &gt; 0">
 								<xsl:text>urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02</xsl:text>
 						</xsl:when>
 						<xsl:when test="string-length(//p02:GrpHdr) &gt; 0">
 								<xsl:text>urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03</xsl:text>
 						</xsl:when>
 				</xsl:choose>
 		</xsl:variable>
  
  		<!--xsl:variable name="VIsBatch" select="$XSLTPARAMBATCHCOUNT"/-->

		<xsl:template match="p08:GrpHdr">
			 <!--xsl:choose>
					 	<xsl:when test="string-length($VIsBatch) != 0"-->
							<xsl:element name="GrpHdr" namespace="{$nms}">
								<xsl:element name="MsgId" namespace="{$nms}">
					  				<xsl:value-of select="$XSLTPARAMBATCHID"/>
					  			</xsl:element>
					  			
					  			<xsl:copy-of select="p08:CreDtTm"/>
					  			
					  			<xsl:element name="NbOfTxs" namespace="{$nms}">
					  				<xsl:choose>
										<xsl:when test="string-length($XSLTPARAMBATCHCOUNT) = 0">
											<xsl:text>1</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
										</xsl:otherwise>
									</xsl:choose>
					  			</xsl:element>
					  			
					  			<xsl:element name="TtlIntrBkSttlmAmt" namespace="{$nms}">
									<xsl:attribute name="Ccy"><xsl:value-of select="p08:TtlIntrBkSttlmAmt/@Ccy"/></xsl:attribute>
									<xsl:choose>
										<xsl:when test="string-length($XSLTPARAMBATCHAMOUNT) = 0">
											<xsl:text>0.00</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="SUM_FORMAT">
												<xsl:with-param name="VSum" select="translate($XSLTPARAMBATCHAMOUNT, '.', ',')"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
					  			</xsl:element>
					  			
					  			<xsl:copy-of select="p08:IntrBkSttlmDt"/>
					  			<xsl:copy-of select="p08:SttlmInf"/>
					  			<xsl:copy-of select="p08:InstgAgt"/>
							</xsl:element>
						<!--/xsl:when>	
						<xsl:otherwise>
								
						</xsl:otherwise> 
				</xsl:choose-->
		  </xsl:template>


		<xsl:template match="p02:GrpHdr">
			 <xsl:choose>
					 	<xsl:when test="string-length($VIsBatch) != 0">
							<xsl:element name="GrpHdr" namespace="{$nms}">
								<xsl:element name="MsgId" namespace="{$nms}">
					  				<xsl:value-of select="$XSLTPARAMBATCHID"/>
					  			</xsl:element>
					  			
					  			<xsl:copy-of select="p02:CreDtTm"/>
					  			
					  			<xsl:element name="NbOfTxs" namespace="{$nms}">
					  				<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
					  			</xsl:element>
					  			
					  			<xsl:element name="TtlIntrBkSttlmAmt" namespace="{$nms}">
									<xsl:attribute name="Ccy"><xsl:value-of select="p08:TtlIntrBkSttlmAmt/@Ccy"/></xsl:attribute>
									<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
					  			</xsl:element>
					  			
					  			<xsl:copy-of select="p02:IntrBkSttlmDt"/>
					  			<xsl:copy-of select="p02:SttlmInf"/>
					  			<xsl:copy-of select="p02:InstgAgt"/>
							</xsl:element>
						</xsl:when>	
						<xsl:otherwise>
								
						</xsl:otherwise> 
				</xsl:choose>
		  </xsl:template>


	<xsl:template name="SUM_FORMAT">
		<xsl:param name="VSum"/>
		<xsl:variable name="VEntireSum">
			<xsl:choose>
				<xsl:when test="contains( $VSum, ',')">
					<xsl:value-of select="substring-before( $VSum,',')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$VSum"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="VDecimalSum">
			<xsl:choose>
				<xsl:when test="contains( $VSum, ',')">
					<xsl:value-of select="substring-after( $VSum,',')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<xsl:value-of select="$VEntireSum"/>
		<xsl:if test="string-length( $VEntireSum )=0">
			<xsl:text>0</xsl:text>
		</xsl:if>
		<xsl:value-of select="'.'"/>
		<xsl:value-of select="$VDecimalSum"/>
		<xsl:choose>
			<xsl:when test="string-length( $VDecimalSum )=1">
				<xsl:text>0</xsl:text>
			</xsl:when>
			<xsl:when test="string-length( $VDecimalSum )=0 ">
				<xsl:text>00</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
