<?xml version="1.0" encoding="UTF-8"?>
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
