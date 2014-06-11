<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:cdttrf="urn:swift:xsd:CoreBlkLrgRmtCdtTrf" 
	xmlns:blkrjct="urn:swift:xs:BlkRjct"
	xmlns:blkacc="urn:swift:xs:BlkAcc"
	xmlns:blkrec="urn:swift:xs:ReconciliationMessage"
	xmlns:cbdd="urn:swift:xs:CoreBlkLrgRmtDDbt"
	xmlns:cbddrfl="urn:swift:xs:CoreBlkDDbtRfl"
	xmlns:cbpn="urn:swift:xs:CoreBlkPrmsNt"
	xmlns:cbchq="urn:swift:xs:CoreBlkChq" 
	xmlns:cbbe="urn:swift:xs:CoreBlkBillXch" 
	xmlns:cbchqrfl="urn:swift:xs:CoreBlkChqRfl"
	xmlns:cbbxrfl="urn:swift:xs:CoreBlkBillXchRfl"
	xmlns:cbpnrfl="urn:swift:xs:CoreBlkPrmsNtRfl"
	xmlns:ntf="urn:swift:xs:NotificationMessage"
	xmlns:drr="urn:swift:xs:DRRMessage">
	<xsl:output method="xml" encoding="us-ascii"/>
	

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
						<xsl:apply-templates select="node()" mode="payload"/>					
					</xsl:if>					
				</Payload>
				<Guid>
					<xsl:value-of select="$XSLTPARAMGUID"/>
				</Guid>
				<BatchId>
					<!--<xsl:value-of select="substring($XSLTPARAMBATCHID,1,30)"/>-->
					<xsl:value-of select="$XSLTPARAMBATCHID"/>
				</BatchId>
				<CorrelationId>
					<xsl:value-of select="$XSLTPARAMCORRELID"/>
				</CorrelationId>
				<SessionId>
					<xsl:value-of select="$XSLTPARAMSESSIONID"/>
				</SessionId>
				<RequestorService>
				<!--	<xsl:value-of select="$XSLTPARAMREQUESTOR"/>-->
						<xsl:choose>
								<xsl:when test="/root/cbpn:CoreBlkPrmsNt|/root/cbchq:CoreBlkChq|/root/cbbe:CoreBlkBillXch">
											<xsl:value-of select="'IDIn'"/>
								</xsl:when>	
								<xsl:when test="/root/cbpnrfl:CoreBlkPrmsNtRfl|/root/cbchqrfl:CoreBlkChqRfl|/root/cbbxrfl:CoreBlkBillXchRfl">
											<xsl:value-of select="'RIDIn'"/>
								</xsl:when>
								<xsl:otherwise>
											<xsl:value-of select="$XSLTPARAMREQUESTOR"/>
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
