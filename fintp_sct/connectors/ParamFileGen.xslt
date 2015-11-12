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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.02" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsrm="http://schemas.xmlsoap.org/ws/2005/02/rm" xmlns:wsu="http://schemas.xmlsoap.org/ws/2002/07/utility" xmlns:Sw="urn:swift:snl:ns.Sw" xmlns:SwGbl="urn:swift:snl:ns.SwGbl" xmlns:SwInt="urn:swift:snl:ns.SwInt" xmlns:SwSec="urn:swift:snl:ns.SwSec" xmlns="urn:swift:saa:xsd:saa.2.0" xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="p02 p08 wsrm wsu external">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" standalone="yes" omit-xml-declaration="no"/>
	<xsl:strip-space elements="*"/>
	<xsl:param name="XSLTPARAMMSGID"/>
	<xsl:param name="XSLTPARAMFILENAME"/>
	<xsl:param name="XSLTPARAMFILESIZE"/>
	<xsl:param name="XSLTPARAMDATASIGNITURE"/>

	<xsl:template match="/">
		<xsl:variable name="DIRPATH" select="'SEPA/TempPath/SEPAOutgoing/'"/>
		<xsl:variable name="v_CurrentDate">
			<!--xsl:value-of select="substring('20330711123456',3)"/-->
			<xsl:value-of select="substring(external:time('%Y%m%d%H%M%S',14),3)"/>
		</xsl:variable>
		
		<xsl:variable name="MessageType">
		<xsl:text>P008</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="Sender">
			<xsl:value-of select="//*[local-name()='InstgAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC']"/>
		</xsl:variable>
		
		<xsl:variable name="Receiver">
			<xsl:value-of select="//*[local-name()='InstdAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC']"/>
		</xsl:variable>
		
		<xsl:variable name="val">
			<xsl:call-template name="substring-after-last">
				<!--
			SEPAEICF_<Basic Header, block 1, (4, 8)>_YYYYMMDDssssss_60
			
			SPXAROBU2013062600SPXA20.008
			    SEPAEICFP008_FILEP008_YYMMDDssssss_60-->
				<xsl:with-param name="string" select="concat($DIRPATH, 'SEPAEICF', $MessageType,'_', substring($Sender,1,8), '_', $v_CurrentDate,'_60')"/>
				<xsl:with-param name="delimiter" select="'/'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="val1">
			<xsl:choose>
				<xsl:when test=" contains($val,'.par') ">
					<xsl:value-of select="substring-before($val,'.par')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$val"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:element name="DataPDU" namespace="urn:swift:saa:xsd:saa.2.0">
			<xsl:element name="Revision" namespace="urn:swift:saa:xsd:saa.2.0">
				<xsl:text>2.0.3</xsl:text>
			</xsl:element>
			<xsl:element name="Header" namespace="urn:swift:saa:xsd:saa.2.0">
				<xsl:element name="Message" namespace="urn:swift:saa:xsd:saa.2.0">
					<xsl:element name="SenderReference" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:value-of select="//*[local-name()='FileRef']"/>
					</xsl:element>
					<xsl:element name="MessageIdentifier" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:text>pacs.008.001.02</xsl:text>
					</xsl:element>
					<xsl:element name="Format" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:text>File</xsl:text>
					</xsl:element>
					<xsl:element name="Sender" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:element name="DN" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:text>o=</xsl:text>
							<xsl:value-of select="translate($Sender,
                                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') "/>
                  	<xsl:text>,o=swift</xsl:text>
						</xsl:element>
						<xsl:element name="FullName" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:element name="X1" namespace="urn:swift:saa:xsd:saa.2.0">
								<xsl:value-of select="$Sender"/>
								<xsl:text>XXX</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<xsl:element name="Receiver" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:element name="DN" namespace="urn:swift:saa:xsd:saa.2.0">
						  <xsl:if test="$Sender != 'SPXAROBU' ">           
                               <xsl:text>ou=sepa,</xsl:text>
                     </xsl:if>
							<xsl:text>o=</xsl:text>
							<xsl:value-of select="translate($Receiver,
                                 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') "/>
							<xsl:text>,o=swift</xsl:text>
						</xsl:element>
						<xsl:element name="FullName" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:element name="X1" namespace="urn:swift:saa:xsd:saa.2.0">
								<xsl:value-of select="$Receiver"/>
								<xsl:text>XXX</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<xsl:element name="NetworkInfo" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:element name="Priority" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:text>Normal</xsl:text>
						</xsl:element>
						<xsl:element name="IsNotificationRequested" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:text>true</xsl:text>
						</xsl:element>
						<xsl:element name="Service" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:choose>
								<xsl:when test="$Sender = 'SPXAROBU' ">
									<xsl:text>swift.generic.fa!x</xsl:text>
								</xsl:when>
								<xsl:when test="//*[local-name()='TstCode'] = 'T'">
									<xsl:text>swift.generic.fast!p</xsl:text>
								</xsl:when>
								<xsl:when test="//*[local-name()='TstCode'] = 'P'">
									<xsl:text>swift.generic.fast</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:element>
					</xsl:element>
					<xsl:element name="SecurityInfo" namespace="urn:swift:saa:xsd:saa.2.0">
						<xsl:element name="IsSigningRequested" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:text>true</xsl:text>
						</xsl:element>
						<xsl:element name="SWIFTNetSecurityInfo" namespace="urn:swift:saa:xsd:saa.2.0">
							<xsl:element name="IsNRRequested" namespace="urn:swift:saa:xsd:saa.2.0">
								<xsl:text>true</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:element>
					<xsl:element name="FileLogicalName" namespace="urn:swift:saa:xsd:saa.2.0">
						<!-- d:/test/xml/type/file.008.par-->
						<xsl:value-of select="$val1"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:element name="Body" namespace="urn:swift:saa:xsd:saa.2.0">
				<xsl:value-of select="$val1"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="substring-after-last">
		<xsl:param name="string"/>
		<xsl:param name="delimiter"/>
		<xsl:choose>
			<xsl:when test="contains($string, $delimiter)">
				<xsl:call-template name="substring-after-last">
					<xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
