<?xml version="1.0" encoding="ascii"?>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="external">
	<xsl:output method="text" version="1.0" encoding="us-ascii"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
			<xsl:variable name="TransactionTypeCode" select="substring(//Field4/Field[@name='26T']/@value,1,string-length(//Field4/Field[@name='26T']/@value)-1)"/>
			<xsl:variable name="VMessageType">
				<xsl:if test="$TransactionTypeCode = 'RTN' ">
					<xsl:text>04</xsl:text>
				</xsl:if>
				<xsl:if test="$TransactionTypeCode = 'SCT' ">
					<xsl:text>08</xsl:text>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="V32A" select="substring(//Field4/Field[@name='32A']/@value,1,string-length(//Field4/Field[@name='32A']/@value)-1)"/>
			<xsl:variable name="V33B" select="substring(//Field4/Field[@name='33B']/@value,1,string-length(//Field4/Field[@name='33B']/@value)-1)"/>
			<xsl:variable name="V50K" select="substring(//Field4/Field[@name='50K']/@value,1,string-length(//Field4/Field[@name='50K']/@value)-1)"/>
			<xsl:variable name="V59" select="substring(//Field4/Field[@name='59']/@value,1,string-length(//Field4/Field[@name='59']/@value)-1)"/>
				
			<xsl:variable name="Sender">
					<xsl:value-of select="substring(//Field1/@data, 4, 7)"/>
					<xsl:choose>
						<xsl:when test="substring(//Field1/@data, 4, 7)='ATBANL2' or  substring(//Field1/@data, 4, 7)='atbanl2' ">
							<xsl:text>A</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring(//Field1/@data, 11, 1)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
			<xsl:variable name="Receiver">
					<xsl:value-of select="substring(//Field2/@data, 5, 7)"/>
					<xsl:choose>
						<xsl:when test="substring(//Field2/@data, 5, 7)='DEUTDEF' or substring(//Field2/@data, 5, 7)='deutdef' ">
							<xsl:text>F</xsl:text>
						</xsl:when>
						<xsl:when test="substring(//Field2/@data, 5, 7)='ATBANL2' or  substring(//Field2/@data, 5, 7)='atbanl2' ">
							<xsl:text>A</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring(//Field2/@data, 12, 1)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
			<xsl:variable name="ValueDate" select="substring($V32A, 1, 6)"/>	
			<xsl:variable name="SettlementCurrency" select="substring($V32A,7,3)"/>
			<xsl:variable name="InterbankSettledAmount" select="substring($V32A,10)"/>
			<xsl:variable name="InstructedCurrency" select="substring($V33B, 7, 3)"/>	
			<xsl:variable name="InstructedAmount" select="substring($V33B, 10, 15)"/>	
			<xsl:variable name="OrderingCustomerAccount">
				<xsl:choose>
					<xsl:when test="contains($V50K,'&#xA;')">
						<xsl:value-of select="translate(substring-before($V50K,'&#xA;'),'/','') "/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$V50K"/>
					</xsl:otherwise>
				</xsl:choose>			
			</xsl:variable>	
			<xsl:variable name="OrderingCustomerNameAddress" select="translate( substring-after($V50K,'&#xA;'),   '&#xA;', '' )"/>	
			<xsl:variable name="SendingInstitution" select="substring(//Field4/Field[@name='51A']/@value,1,string-length(//Field4/Field[@name='51A']/@value)-1)"/>	
			<xsl:variable name="OrderingInstitution" select="substring(//Field4/Field[@name='52A']/@value,1,string-length(//Field4/Field[@name='52A']/@value)-1)"/>	
			<xsl:variable name="AccountWithInstitution" select="substring(//Field4/Field[@name='57A']/@value,1,string-length(//Field4/Field[@name='57A']/@value)-1)"/>	
			<xsl:variable name="BeneficiaryCustomerAccount" >
				<xsl:choose>
					<xsl:when test="contains($V59,'&#xA;')">
						<xsl:value-of select="translate(substring-before($V59,'&#xA;' ),'/','')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate($V59,'/','')"/>
					</xsl:otherwise>
				</xsl:choose>			
			</xsl:variable>	
			<xsl:variable name="BeneficiaryCustomerNameAddress" select="translate( substring-after($V59,'&#xA;'),   '&#xA;', '' )"/>	
			<xsl:variable name="RemittancesInformation" select="substring(//Field4/Field[@name='70']/@value,1,string-length(//Field4/Field[@name='70']/@value)-1)"/>	
			<xsl:variable name="SenderToReceiverInformation" select="substring(//Field4/Field[@name='72']/@value,1,string-length(//Field4/Field[@name='72']/@value)-1)"/>	

		<xsl:if test="$VMessageType='08' ">
			<xsl:variable name="VHash" select="concat(
						$Sender,
						$Receiver,
						$TransactionTypeCode,
						$ValueDate,
						$SettlementCurrency,
						$InterbankSettledAmount,
						$InstructedCurrency,
						$InstructedAmount,
						$OrderingCustomerAccount,
						$OrderingCustomerNameAddress,
						$OrderingInstitution,
						$AccountWithInstitution,
						$BeneficiaryCustomerAccount,
						$BeneficiaryCustomerNameAddress,
						$RemittancesInformation,
						$SenderToReceiverInformation)"/>
			<!--xsl:value-of select="$VHash"/-->
			<xsl:value-of select="external:hash($VHash)"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
