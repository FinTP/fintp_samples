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
					<xsl:if test="TableName">
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

				<xsl:variable name="VCanal" select="normalize-space(//CODSEP)" />
				<xsl:variable name="VTipMsj" select="normalize-space(//TIPMESAJ)" />
        		<xsl:variable name="VRefuzPl" select="normalize-space(//REFUZPL)" />
				<RequestorService>
			 		<xsl:choose>
				   	<xsl:when test="($VCanal='A') and ($VTipMsj='103') and ($VRefuzPl != 'N')">
									<xsl:value-of select="'BORTNACHOut'"/>
					  </xsl:when>
					  <xsl:when test="$VCanal='A' and $VTipMsj='103' and ($VRefuzPl='N')">
									<xsl:value-of select="'BOACHOut'"/>
					  </xsl:when>
						<xsl:when test="($VCanal='A') and ($VTipMsj='104') and ($VRefuzPl='N')">
								<xsl:value-of select="'BODDOut'"/>
						</xsl:when>
            			<xsl:when test="($VCanal='A') and ($VTipMsj='104') and ($VRefuzPl != 'N')">
              				<xsl:value-of select="'BODDROut'"/>
            			</xsl:when>
            			<xsl:when test="$VCanal='R' and $VTipMsj='102' ">
							<xsl:value-of select="'BO102Out'"/>
						</xsl:when>
						<xsl:when test="$VCanal='R' and $VTipMsj!='102'">
							<xsl:value-of select="'BOSEPOut'"/><!-- TODO BORTGSOut sau comasat RTGS cu ACH-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'InvestigOut'"/>
						</xsl:otherwise>
					</xsl:choose>
				</RequestorService>

				<ResponderService>
					<xsl:value-of select="$XSLTPARAMRESPONDER"/>
				</ResponderService>
				<RequestType>
					<xsl:value-of select="$XSLTPARAMREQUEST"/>
				</RequestType> 
				<Feedback>
					<xsl:value-of select="$XSLTPARAMFEEDBACK"/>
				</Feedback> 
				<IOIdentifier>
					<xsl:value-of select="'O'"/>
				</IOIdentifier> 				
			</Message>
		</qPCMessageSchema>
	</xsl:template>
	<xsl:template match="TableName">
		<Original>
			<xsl:value-of select="Encoded_TableName"/>
		</Original>
		<Transformed>
			<xsl:value-of select="Encoded_TableName"/>
		</Transformed>
		
	</xsl:template>
</xsl:stylesheet>
