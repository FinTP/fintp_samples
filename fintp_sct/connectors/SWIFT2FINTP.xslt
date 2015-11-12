<?xml version="1.0" encoding="UTF-8"?>
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
<?xmlspysamplexml C:\TEMP\tempSinkb64cOutput.xml?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
	
	<xsl:template match="/">
		<qPCMessageSchema>
			<Message>
				<xsl:attribute name="ID">
					<xsl:value-of select="$XSLTPARAMGUID"/>
				</xsl:attribute>
				<Payload>
					<xsl:if test="root">
						<xsl:apply-templates select="node()"/>
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
					<!--xsl:value-of select="'SEPAIn'"/-->
					<xsl:value-of select="$XSLTPARAMRESPONDER"/>
				</ResponderService>
				<RequestType>
					<xsl:value-of select="$XSLTPARAMREQUEST"/>
				</RequestType> 
				<Feedback>
					<xsl:value-of select="$XSLTPARAMFEEDBACK"/>
				</Feedback> 
			</Message>
		</qPCMessageSchema>
	</xsl:template>
	
	<xsl:template match="root">
			<Original>
			<xsl:value-of select="Transformed/Encoded_Transformed"/>
		</Original>
		<Transformed>		
			<xsl:value-of select="Transformed/Encoded_Transformed"/>
		</Transformed>		
		
		<!--xsl:copy-of select="Original"/>	
		<xsl:copy-of select="Transformed"/-->		
	</xsl:template>
	
</xsl:stylesheet>
