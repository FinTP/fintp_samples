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

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  

	xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02"
	xmlns:p02="urn:iso:std:iso:20022:tech:xsd:pacs.002.001.03"
	
	xmlns:saa="urn:swift:saa:xsd:saa.2.0"
	>

	<xsl:output method="xml" encoding="us-ascii"/>
	<xsl:strip-space elements="*"/>

	<xsl:param name="XSLTPARAMGUID"/> 
	<xsl:param name="XSLTPARAMBATCHID"/>
	<xsl:param name="XSLTPARAMCORRELID"/>
	<xsl:param name="XSLTPARAMSESSIONID"/>
	<xsl:param name="XSLTPARAMREQUESTOR"/>
	<xsl:param name="XSLTPARAMRESPONDER"/>
	<xsl:param name="XSLTPARAMREQUEST"/> 
	<xsl:param name="XSLTPARAMFEEDBACK"/> 
	<xsl:variable name="VFEEDBACK" select="substring($XSLTPARAMFEEDBACK,0,string-length($XSLTPARAMFEEDBACK)-2)"/>
	
	<xsl:template match="/">
		<qPCMessageSchema>
			<Message>
				<xsl:attribute name="ID">
					<xsl:value-of select="$XSLTPARAMGUID"/>
				</xsl:attribute>
				<Payload>
					<xsl:if test="root">
						<xsl:apply-templates select="node()" mode="payload"/>					
					</xsl:if>					
				</Payload>
				<Guid>
					<xsl:value-of select="$XSLTPARAMGUID"/>
				</Guid>
				<BatchId>
					<xsl:value-of select="$XSLTPARAMBATCHID"/>
				</BatchId>
				<CorrelationId>
					<xsl:value-of select="$XSLTPARAMCORRELID"/>
				</CorrelationId>
				<SessionId>
					<xsl:value-of select="$XSLTPARAMSESSIONID"/>
				</SessionId>
				<RequestorService>
					<xsl:value-of select="$XSLTPARAMREQUESTOR"/>
				</RequestorService>				
				<ResponderService>
					<xsl:value-of select="$XSLTPARAMRESPONDER"/>
				</ResponderService>
				<RequestType>
					<xsl:value-of select="$XSLTPARAMREQUEST"/>
				</RequestType> 
				<Feedback>
						<xsl:choose>
								<xsl:when test="string-length(//p02:*)!=0 or string-length(//saa:DataPDU)!=0">
										<xsl:value-of select="$XSLTPARAMFEEDBACK"/>
								</xsl:when>
								<xsl:otherwise>
										<xsl:value-of select="concat($VFEEDBACK,'|QPI00')"/>
								</xsl:otherwise>
						</xsl:choose>
				</Feedback> 
			</Message>
		</qPCMessageSchema>
	</xsl:template>
	
	<xsl:template match="root" mode="payload">
		<Original>
			<xsl:value-of select="Encoded_root"/>
		</Original>
		<Transformed>		
			<xsl:value-of select="Encoded_root"/>
		</Transformed>
		
	</xsl:template>
</xsl:stylesheet>
