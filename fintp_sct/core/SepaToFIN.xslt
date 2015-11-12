<?xml version="1.0" encoding="us-ascii"?>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:smt="urn:xmlns:SWIFTMTs" xmlns:sg="urn:xmlns:SWIFTgenerics"
 xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02" 
 xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="external">
 
	<xsl:param name="XSLTPARAMFEEDBACK"/>
	<xsl:param name="XSLTPARAMREQUESTOR"/>
	<xsl:param name="XSLTPARAMMESSAGEID"/>
	<xsl:param name="XSLTPARAMBATCHID"/>
	<xsl:output method="text"/>
	<xsl:template match="*">
	
		<xsl:variable name="TstCode">
				<xsl:text>T</xsl:text>
		</xsl:variable>
	
		<xsl:variable name="Enter" select="'&#xD;&#xA;'"/>
		<xsl:variable name="Sequence">
			<xsl:value-of select="external:lookup( 'GetSessionSequenceNo')"/>
			<!--xsl:text>1996-05-22T12:34:56</xsl:text-->
		</xsl:variable>
		<xsl:variable name="Time">
			<xsl:value-of select="external:time('%Y-%m-%dT%H:%M:%S',19)"/>
			<!--xsl:text>1996-05-22T12:34:56</xsl:text-->
		</xsl:variable>
		<xsl:variable name="DateSeq">
			<xsl:value-of select="substring($Time,3,2)"/>
			<xsl:value-of select="substring($Time,6,2)"/>
			<xsl:value-of select="substring($Time,9,2)"/>
		</xsl:variable>
		<xsl:variable name="TimeSeq">
			<xsl:value-of select="substring($Time,12,2)"/>
			<xsl:value-of select="substring($Time,15,2)"/>
		</xsl:variable>
		<xsl:variable name="VSender">
			<xsl:choose>
					<xsl:when test="$TstCode = 'T' ">
							<xsl:value-of select="substring(//*[local-name()='GrpHdr']/*[local-name()='InstgAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC'], 1, 7)"/>
							<xsl:text>0</xsl:text>
					</xsl:when>
					<xsl:otherwise>
							<xsl:value-of select="substring(//*[local-name()='GrpHdr']/*[local-name()='InstgAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC'], 1, 8)"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="VReceiver">
			<xsl:choose>
					<xsl:when test="$TstCode = 'T' ">
								<xsl:value-of select="substring(//*[local-name()='GrpHdr']/*[local-name()='InstdAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC'], 1, 7)"/>
							<xsl:text>0</xsl:text>
					</xsl:when>
					<xsl:otherwise>
								<xsl:value-of select="substring(//*[local-name()='GrpHdr']/*[local-name()='InstdAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC'], 1, 8)"/>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:text>{1:F01</xsl:text>
		<xsl:value-of select="$VReceiver"/>
		<xsl:text>AXXX</xsl:text>
		<xsl:value-of select="$Sequence"/>
		<xsl:text>}{2:O103</xsl:text>
		<xsl:value-of select="$TimeSeq"/>
		<xsl:value-of select="$DateSeq"/>
		<xsl:value-of select="$VSender"/>
		<xsl:text>XXXX</xsl:text>
		<xsl:value-of select="$Sequence"/>
		<xsl:value-of select="$DateSeq"/>
		<xsl:value-of select="$TimeSeq"/>
		<xsl:text>N}{3:{119:REMIT}}</xsl:text>
		<xsl:text>{4:&#xD;&#xA;</xsl:text>
		<xsl:text>:20:</xsl:text>
		<xsl:value-of select="$Sequence"/>
		<xsl:text>&#xD;&#xA;</xsl:text>
		<xsl:text>:23B:</xsl:text>
		<xsl:value-of select=" 'CRED' "/>
		<xsl:text>&#xD;&#xA;</xsl:text>
		
			<xsl:text>:26T:</xsl:text>
				<xsl:value-of select=" 'SCT' "/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>:32A:</xsl:text>
				<xsl:variable name="date">
					<xsl:value-of select="//*[local-name()='GrpHdr']/*[local-name()='IntrBkSttlmDt']"/>
				</xsl:variable>
				<xsl:value-of select="substring($date,3,2)"/>
				<xsl:value-of select="substring($date,6,2)"/>
				<xsl:value-of select="substring($date,9,2)"/>
				<xsl:value-of select="//*[local-name()='CdtTrfTxInf']/*[local-name()='IntrBkSttlmAmt']/@Ccy"/>
				<xsl:call-template name="SUM_FORMAT">
					<xsl:with-param name="VSuma" select="//*[local-name()='CdtTrfTxInf']/*[local-name()='IntrBkSttlmAmt']"/>
				</xsl:call-template>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>:33B:</xsl:text>
				<xsl:value-of select="//*[local-name()='CdtTrfTxInf']/*[local-name()='IntrBkSttlmAmt']/@Ccy"/>
				<xsl:call-template name="SUM_FORMAT">
					<xsl:with-param name="VSuma" select="//*[local-name()='CdtTrfTxInf']/*[local-name()='IntrBkSttlmAmt']"/>
				</xsl:call-template>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:choose>
					<xsl:when test="string-length(//*[local-name()='Dbtr']/*[local-name()='Nm']) &gt; 0">
							<xsl:text>:50K:</xsl:text>
							<xsl:text>/</xsl:text>
							<xsl:value-of select="//*[local-name()='DbtrAcct']/*[local-name()='Id']/*[local-name()='IBAN']"/>
							<xsl:value-of select="$Enter"/>
							<xsl:variable name="val">
								<xsl:value-of select="//*[local-name()='Dbtr']/*[local-name()='Nm']"/>
							</xsl:variable>
							<xsl:variable name="V1Linie" select="normalize-space(substring($val,1,35))"/>
							<xsl:variable name="V2Linie" select="normalize-space(substring($val,36,35))"/>
							<xsl:value-of select="$V1Linie"/>
							<xsl:if test="string-length($V2Linie)&gt;0">
								<xsl:value-of select="'&#xD;&#xA;'"/>
								<xsl:value-of select="$V2Linie"/>
							</xsl:if>
							<xsl:text>&#xD;&#xA;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
							<xsl:if test="string-length(//*[local-name()='Dbtr']/*[local-name()='Id']/*[local-name()='OrgId']/*[local-name()='BICOrBEI']) &gt; 0">
								<xsl:text>:50A:</xsl:text>
								<xsl:value-of select="//*[local-name()='Dbtr']/*[local-name()='Id']/*[local-name()='OrgId']/*[local-name()='BICOrBEI']"/>
								<xsl:text>&#xD;&#xA;</xsl:text>
							</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>:52A:</xsl:text>
				<xsl:value-of select="//*[local-name()='DbtrAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>:57A:</xsl:text>
				<xsl:value-of select="//*[local-name()='CdtrAgt']/*[local-name()='FinInstnId']/*[local-name()='BIC']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:choose>
					<xsl:when test="string-length(//*[local-name()='Cdtr']/*[local-name()='Nm']) &gt; 0">
						<xsl:text>:59:</xsl:text>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="//*[local-name()='CdtrAcct']/*[local-name()='Id']/*[local-name()='IBAN']"/>
						<xsl:value-of select="$Enter"/>
						<xsl:variable name="val1">
							<xsl:value-of select="//*[local-name()='Cdtr']/*[local-name()='Nm']"/>
						</xsl:variable>
						<xsl:variable name="V1Linie2" select="normalize-space(substring($val1,1,35))"/>
						<xsl:variable name="V2Linie2" select="normalize-space(substring($val1,36,35))"/>
						<xsl:value-of select="$V1Linie2"/>
						<xsl:if test="string-length($V2Linie2)&gt;0">
							<xsl:value-of select="'&#xD;&#xA;'"/>
							<xsl:value-of select="$V2Linie2"/>
						</xsl:if>
						<xsl:text>&#xD;&#xA;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>:59A:</xsl:text>
						<xsl:value-of select="//*[local-name()='CdtrAcct']/*[local-name()='Id']/*[local-name()='IBAN']"/>
						<xsl:value-of select="$Enter"/>
						<xsl:value-of select="//*[local-name()='Cdtr']/*[local-name()='Id']/*[local-name()='OrgId']/*[local-name()='BICOrBEI']"/>
						<xsl:text>&#xD;&#xA;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="string-length(//*[local-name()='CdtTrfTxInf']/*[local-name()='RmtInf']/*[local-name()='Ustrd']) &gt; 0">
					<xsl:text>:70:</xsl:text>
					<xsl:variable name="VUstrd" select="//*[local-name()='CdtTrfTxInf']/*[local-name()='RmtInf']/*[local-name()='Ustrd']"/>
					<xsl:variable name="V1LinieUsrtd" select="substring($VUstrd, 1, 35)"/>
					<xsl:variable name="V2LinieUsrtd" select="substring($VUstrd, 36, 35)"/>
					<xsl:variable name="V3LinieUsrtd" select="substring($VUstrd, 71, 35)"/>
					<xsl:variable name="V4LinieUsrtd" select="substring($VUstrd, 106, 35)"/>
					<xsl:value-of select="$V1LinieUsrtd"/>
					<xsl:if test="string-length($V2LinieUsrtd)&gt;0">
						<xsl:value-of select="'&#xD;&#xA;'"/>
						<xsl:value-of select="$V2LinieUsrtd"/>
					</xsl:if>
					<xsl:if test="string-length($V3LinieUsrtd)&gt;0">
						<xsl:value-of select="'&#xD;&#xA;'"/>
						<xsl:value-of select="$V3LinieUsrtd"/>
					</xsl:if>
					<xsl:if test="string-length($V4LinieUsrtd)&gt;0">
						<xsl:value-of select="'&#xD;&#xA;'"/>
						<xsl:value-of select="$V4LinieUsrtd"/>
					</xsl:if>
					<xsl:text>&#xD;&#xA;</xsl:text>
				</xsl:if>

				<xsl:text>:71A:</xsl:text>
				<xsl:value-of select=" 'SHA' "/>
				<xsl:text>&#xD;&#xA;</xsl:text>

				
				<xsl:text>:72:</xsl:text>
				<xsl:choose>
					<xsl:when test="substring($XSLTPARAMFEEDBACK,1,5)='QPI09' or substring($XSLTPARAMFEEDBACK,1,7)='FINTP09' ">
					  <!-- manual reject from FINTP application-->
						<xsl:text>/RJCT/FINTP09</xsl:text>
					</xsl:when>
					<xsl:when test="$XSLTPARAMFEEDBACK='QPI00' or $XSLTPARAMFEEDBACK='FINTP00'">
						<!-- incoming -->
					</xsl:when>
					<xsl:otherwise>
						<!-- 	/RJCT/ error code received-->
						<xsl:text>/RJCT/</xsl:text>
						<xsl:value-of select="substring($XSLTPARAMFEEDBACK,1,5)"/>
						<xsl:value-of select="'&#xD;&#xA;'"/>
						<xsl:text>/GrpId/</xsl:text>
						<xsl:value-of select="//*[local-name()='GrpHdr']/*[local-name()='MsgId']"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>&#xD;&#xA;</xsl:text>

				<xsl:text>:77T:</xsl:text>
				<xsl:text>&lt;TxId&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='TxId']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;DebtorAddress&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='Dbtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][1]"/>
				<xsl:if test="string-length(//*[local-name()='Dbtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][2]) &gt; 0">
					<xsl:text>&#xD;&#xA;</xsl:text>
					<xsl:text>&lt;DebtorAddress&gt;</xsl:text>
					<xsl:value-of select="//*[local-name()='Dbtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][2]"/>
				</xsl:if>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;CreditorAddress&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='Cdtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][1]"/>
				<xsl:if test="string-length(//*[local-name()='Cdtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][2]) &gt; 0">
					<xsl:text>&#xD;&#xA;</xsl:text>
					<xsl:text>&lt;CreditorAddress&gt;</xsl:text>
					<xsl:value-of select="//*[local-name()='Cdtr']/*[local-name()='PstlAdr']/*[local-name()='AdrLine'][2]"/>
				</xsl:if>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;DebtorID&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='Dbtr']/*[local-name()='Id']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;CreditorID&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='Cdtr']/*[local-name()='Id']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;UltimateDebtor&gt;&lt;Nm&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='UltmtDbtr']/*[local-name()='Nm']"/>
				<xsl:text>&lt;Id&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='UltmtDbtr']/*[local-name()='Id']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				
				<xsl:text>&lt;UltimateCreditor&gt;&lt;Nm&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='UltmtCdtr']/*[local-name()='Nm']"/>
				<xsl:text>&lt;Id&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='UltmtCdtr']/*[local-name()='Id']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				
				<xsl:text>&lt;Category&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='CtgyPurp']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;Purpose&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='Purp']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>&lt;RemitInfo&gt;</xsl:text>
				<xsl:value-of select="//*[local-name()='RmtInf']/*[local-name()='Strd']"/>
				<xsl:text>&#xD;&#xA;</xsl:text>
				<xsl:text>-}</xsl:text>
	</xsl:template>


	<xsl:template name="SUM_FORMAT">
		<xsl:param name="VSum"/>
		<xsl:choose>
			<xsl:when test="contains($VSum, '.')">
				<xsl:variable name="VEntireSum" select="substring-before( $VSuma,'.')"/>
				<xsl:variable name="VDecimalSum" select="substring-after( $VSuma,'.')"/>
				<xsl:value-of select="$VEntireSum"/>
				<xsl:if test="string-length( $VDecimalSum )>0 ">
					<xsl:value-of select="','"/>
					<xsl:value-of select="$VDecimalSum"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$VSum"/>
			</xsl:otherwise>	
		</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>
