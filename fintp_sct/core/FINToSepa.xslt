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

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:p08="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="external">
	
	<xsl:output method="xml" indent="yes" encoding="us-ascii" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:param name="XSLTPARAMDATE"/>
	
	<xsl:template match="/SWIFTFORMAT">
			<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
			<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
			<xsl:variable name="VSender">
				<xsl:value-of select="substring(//Field1/@data, 4, 8)"/>
			</xsl:variable>
		
			<xsl:variable name="VReceiver">
				<xsl:value-of select="substring(//Field2/@data, 5, 8)"/>
			</xsl:variable>
			
			<xsl:variable name="V20" select="substring(//Field4/Field[@name='20']/@value,1,string-length(//Field4/Field[@name='20']/@value)-1)"/>
			<xsl:variable name="V32A" select="substring(//Field4/Field[@name='32A']/@value,1,string-length(//Field4/Field[@name='32A']/@value)-1)"/>
			<xsl:variable name="V50K" select="substring(//Field4/Field[@name='50K']/@value,1,string-length(//Field4/Field[@name='50K']/@value)-1)"/>
			<xsl:variable name="V52A" select="substring(//Field4/Field[@name='52A']/@value,1,string-length(//Field4/Field[@name='52A']/@value)-1)"/>
			<xsl:variable name="V57A" select="substring(//Field4/Field[@name='57A']/@value,1,string-length(//Field4/Field[@name='57A']/@value)-1)"/>
			<xsl:variable name="V59" select="substring(//Field4/Field[@name='59']/@value,1,string-length(//Field4/Field[@name='59']/@value)-1)"/>
			<xsl:variable name="V70" select="substring(//Field4/Field[@name='70']/@value,1,string-length(//Field4/Field[@name='70']/@value)-1)"/>
			<xsl:variable name="V72" select="substring(//Field4/Field[@name='72']/@value,1,string-length(//Field4/Field[@name='72']/@value)-1)"/>
			
				<xsl:element name="Document" xmlns="urn:iso:std:iso:20022:tech:xsd:pacs.008.001.02">
					<xsl:element name="FIToFICstmrCdtTrf">
						<xsl:element name="GrpHdr">
							<xsl:element name="MsgId">
								<xsl:text>batch01</xsl:text>
							</xsl:element>
							<xsl:element name="CreDtTm">
							</xsl:element>
							<xsl:element name="NbOfTxs">
								<xsl:text>1</xsl:text>
							</xsl:element>
							<xsl:element name="TtlIntrBkSttlmAmt">
								<xsl:attribute name="Ccy"><xsl:value-of select="substring($V32A,7,3)"/></xsl:attribute>
								<xsl:value-of select="'0'"/>
							</xsl:element>
							<xsl:element name="IntrBkSttlmDt">
								<xsl:variable name="IntrDate" select="substring($V32A, 1, 6)"/>
								<xsl:text>20</xsl:text>
								<xsl:value-of select="substring($IntrDate, 1, 2)"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="substring($IntrDate, 3, 2)"/>
								<xsl:text>-</xsl:text>
								<xsl:value-of select="substring($IntrDate, 5, 2)"/>
							</xsl:element>
							<xsl:element name="SttlmInf">
								<xsl:element name="SttlmMtd">
									<xsl:text>CLRG</xsl:text>
								</xsl:element>
								<xsl:element name="ClrSys">
									<xsl:element name="Prtry">
										<xsl:text>XXX</xsl:text>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="InstgAgt">
								<xsl:element name="FinInstnId">
									<xsl:element name="BIC">
										<xsl:value-of select="$VSender"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="InstdAgt">
								<xsl:element name="FinInstnId">
									<xsl:element name="BIC">
										<xsl:value-of select="$VReceiver"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						<xsl:element name="CdtTrfTxInf">
							<xsl:element name="PmtId">
								<xsl:if test="string-length($V20) &gt; 0">
									<xsl:element name="InstrId">
										<xsl:value-of select="$V20"/>
									</xsl:element>
								</xsl:if>
								<xsl:element name="EndToEndId">
								   <xsl:variable name="endToEnd">
										<xsl:choose>
											<xsl:when test="starts-with($V72, '/ROC/')">
												<xsl:call-template name="GetValue">
												         <xsl:with-param name="VExp" select="'/ROC/'" />
												          <xsl:with-param name="VTag" select="$V72" />
													</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="'NOTPROVIDED'"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
										<xsl:value-of select="substring($endToEnd,1,35)"/>
								</xsl:element>
								<xsl:element name="TxId">
									<xsl:value-of select="$V20"/>
								</xsl:element>
							</xsl:element>
							<xsl:element name="PmtTpInf">
								<xsl:element name="SvcLvl">
									<xsl:element name="Cd">
										<xsl:value-of select="'SEPA'"/>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="IntrBkSttlmAmt">
								<xsl:attribute name="Ccy"><xsl:value-of select="substring($V32A, 7, 3)"/></xsl:attribute>
								<xsl:call-template name="FORMAT_SUMA">
									<xsl:with-param name="VSum" select="substring($V32A, 10, 15)"/>
								</xsl:call-template>
							</xsl:element>
							<xsl:element name="ChrgBr">
								<xsl:text>SLEV</xsl:text>
							</xsl:element>
							<xsl:element name="Dbtr">
								<xsl:if test="string-length($V50K) &gt; 0">
									<xsl:element name="Nm">
											 <xsl:call-template name="GetLine">
											          <xsl:with-param name="VLine" select="2" />
											          <xsl:with-param name="VTag" select="$V50K" />
												</xsl:call-template>
												 <xsl:call-template name="GetLine">
											          <xsl:with-param name="VLine" select="3" />
											          <xsl:with-param name="VTag" select="$V50K" />
												</xsl:call-template>
									</xsl:element>
								</xsl:if>
							</xsl:element>
							<xsl:element name="DbtrAcct">
								<xsl:element name="Id">
									<xsl:element name="IBAN">
										<xsl:choose>
											<xsl:when test="contains($V50K,'&#10;')">
												<xsl:value-of select="translate(substring-before($V50K,'&#10;'),'/','') "/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$V50K"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="DbtrAgt">
								<xsl:element name="FinInstnId">
									<xsl:element name="BIC">
										<xsl:choose>
											<xsl:when test="string-length($V52A) &gt; 0">
												<xsl:value-of select="substring($V52A,1,8)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VSender"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="CdtrAgt">
								<xsl:element name="FinInstnId">
									<xsl:element name="BIC">
										<xsl:if test="string-length($V57A) &gt; 0">
												<xsl:value-of select="substring($V57A,1,8)"/>
											</xsl:if>
									</xsl:element>
								</xsl:element>
							</xsl:element>
							<xsl:element name="Cdtr">
								<xsl:element name="Nm">
										<xsl:call-template name="GetLine">
									          <xsl:with-param name="VLine" select="2" />
									          <xsl:with-param name="VTag" select="$V59" />
										</xsl:call-template>
										 <xsl:call-template name="GetLine">
									          <xsl:with-param name="VLine" select="3" />
									          <xsl:with-param name="VTag" select="$V59" />
										</xsl:call-template>
								</xsl:element>
							</xsl:element>
							<xsl:element name="CdtrAcct">
								<xsl:element name="Id">
									<xsl:element name="IBAN">
										<xsl:choose>
											<xsl:when test="contains($V59,'&#10;')">
												<xsl:value-of select="translate(substring-before($V59,'&#10;' ),'/','')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="translate($V59,'/','')"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
								</xsl:element>
							</xsl:element>
						
							<xsl:variable name="ContainsRFB">
								 <xsl:call-template name="Contains">
					 		   	 	 <xsl:with-param name="VTag" select="$V72"/>	 
							          <xsl:with-param name="VExp" select="'/RFB/'" />
							          <xsl:with-param name="VNo" select="1" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:variable name="ContainsISR">
								 <xsl:call-template name="Contains">
					 		   	 	 <xsl:with-param name="VTag" select="$V72"/>	 
							          <xsl:with-param name="VExp" select="'/ISR/'" />
							          <xsl:with-param name="VNo" select="1" />
								</xsl:call-template>
							</xsl:variable>
						
							<xsl:if test="$ContainsRFB !='7' or $ContainsISR !='7' or string-length($V70) &gt; 0">
								<xsl:element name="RmtInf">
									<xsl:if test="string-length($V70) &gt; 0">
										<xsl:element name="Ustrd">
											<xsl:value-of select="translate($V70,'&#10;','')"/>
										</xsl:element>
									</xsl:if>
									<xsl:if test="$ContainsRFB !='7' or $ContainsISR !='7'">
										<xsl:element name="Strd">
											<xsl:element name="CdtrRefInf">
												<xsl:element name="Tp">
													<xsl:element name="CdOrPrtry">
														<xsl:element name="Cd">
																<xsl:text>SCOR</xsl:text>
														</xsl:element>
													</xsl:element>
													<xsl:if test="$ContainsISR !='7'">
														<xsl:element name="Issr">
																 <xsl:variable name="issr">
																	   <xsl:call-template name="GetValue">
																	         <xsl:with-param name="VExp" select="'/ISR/'" />
																	         <xsl:with-param name="VTag" select="$V72" />
																		</xsl:call-template>
																</xsl:variable>
																<xsl:value-of select="substring($issr,1,35)"/>
														</xsl:element>
													</xsl:if>
												</xsl:element>
												<xsl:if test="$ContainsRFB !='7'">
													<xsl:element name="Ref">
																	<xsl:variable name="ref">
																		<xsl:call-template name="GetValue">
																	         <xsl:with-param name="VExp" select="'/RFB/'" />
																	         <xsl:with-param name="VTag" select="$V72" />
																		</xsl:call-template>
																	</xsl:variable>
																<xsl:value-of select="substring($ref,1,35)"/>
													</xsl:element>
												</xsl:if>
											</xsl:element>
										</xsl:element>
									</xsl:if>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:element>
				</xsl:element>
	</xsl:template>

	
	<xsl:template name="FORMAT_SUMA">
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
	
	<xsl:template name="PostalAddress">
		<xsl:param name="Address"/>
		<xsl:param name="Namespace"/>
		
		<xsl:element name="PstlAdr" namespace="{$Namespace}">
			<xsl:if test="string-length($Address ) &gt; 0">
				<xsl:element name="AdrLine" namespace="{$Namespace}">
					<xsl:value-of select="substring($Address,1,70)"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="string-length($Address ) &gt; 70">
				<xsl:element name="AdrLine" namespace="{$Namespace}">
					<xsl:value-of select="substring($Address,70)"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="*" mode="copy_all_elem">
		<xsl:element name="{name()}">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="copy_all_elem"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="Contains">
			<xsl:param name="VTag"/>	   
		   <xsl:param name="VExp"/>	
		   <xsl:param name="VNo"/>	   
		   <xsl:variable name="temp">
				   <xsl:call-template name="GetLine">
				          <xsl:with-param name="VLine" select="$VNo" />
				          <xsl:with-param name="VTag" select="$VTag" />
					</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
					<xsl:when test="starts-with($temp,$VExp) or ($VNo='7') ">
						<xsl:value-of select="$VNo"/>
					</xsl:when>
					<xsl:otherwise>
						  <xsl:call-template name="Contains">
		 		   	 	 	<xsl:with-param name="VTag" select="$VTag"/>	 
					          <xsl:with-param name="VExp" select="$VExp" />
					          <xsl:with-param name="VNo" select="$VNo+1" />
						</xsl:call-template>
					</xsl:otherwise>
			</xsl:choose>	
	</xsl:template>	
	
	<xsl:template name="GetLine">
			   <xsl:param name="VLine"/>	   
		  		<xsl:param name="VTag"/>	   
		         <xsl:choose>
			       		<xsl:when test="$VLine='0'">
					 				<xsl:value-of select="$VTag"/>
							</xsl:when>
					 		<xsl:when test="$VLine='1'">
							 		  <xsl:choose>
											<xsl:when test="substring-after($VTag,'&#10;')">
												<xsl:value-of select="substring-before($VTag,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VTag"/>
											</xsl:otherwise>
										</xsl:choose>
							</xsl:when>
							<xsl:when test="$VLine = 'Y'">
							 		  <xsl:choose>
											<xsl:when test="substring-after($VTag,'&#10;')">
												<xsl:value-of select="substring(substring-before($VTag,'&#10;'),2)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="substring($VTag,2)"/>
											</xsl:otherwise>
										</xsl:choose>
							</xsl:when>
					 		<xsl:when test="$VLine='2'">
					 				  <xsl:variable name="VLines2345" select="substring-after($VTag,'&#10;')"/>
								 		<xsl:choose>
											<xsl:when test="substring-after($VLines2345,'&#10;')">
												<xsl:value-of select="substring-before($VLines2345,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VLines2345"/>
											</xsl:otherwise>
										</xsl:choose>
					 		</xsl:when>
					 		<xsl:when test="$VLine='3'">
					 			 <xsl:variable name="VLines2345" select="substring-after($VTag,'&#10;')"/>
								 <xsl:variable name="VLines345" select="substring-after($VLines2345,'&#10;')"/>
								 <xsl:choose>
											<xsl:when test="substring-after($VLines345,'&#10;')">
												<xsl:value-of select="substring-before($VLines345,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VLines345"/>
											</xsl:otherwise>
										</xsl:choose>
					 		</xsl:when>
					 		<xsl:when test="$VLine='4'">
					 		 	<xsl:variable name="VLines2345" select="substring-after($VTag,'&#10;')"/>
								 <xsl:variable name="VLines345" select="substring-after($VLines2345,'&#10;')"/>
								 <xsl:variable name="VLines45" select="substring-after($VLines345,'&#10;')"/>
							 	 <xsl:choose>
											<xsl:when test="substring-after($VLines45,'&#10;')">
												<xsl:value-of select="substring-before($VLines45,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VLines45"/>
											</xsl:otherwise>
									</xsl:choose>
					 		</xsl:when>
					 		<xsl:when test="$VLine='5'">
					 			<xsl:variable name="VLines2345" select="substring-after($VTag,'&#10;')"/>
								 <xsl:variable name="VLines345" select="substring-after($VLines2345,'&#10;')"/>
								 <xsl:variable name="VLines45" select="substring-after($VLines345,'&#10;')"/>
							 	 <xsl:variable name="VLines5"   select="substring-after($VLines45,'&#10;')"/>
							    <xsl:choose>
											<xsl:when test="substring-after($VLines5,'&#10;')">
												<xsl:value-of select="substring-before($VLines5,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VLines5"/>
											</xsl:otherwise>
									</xsl:choose>
					 		</xsl:when>
					 		<xsl:when test="$VLine='6'">
					 			<xsl:variable name="VLines23456" select="substring-after($VTag,'&#10;')"/>
								 <xsl:variable name="VLines3456" select="substring-after($VLines23456,'&#10;')"/>
								 <xsl:variable name="VLines456" select="substring-after($VLines3456,'&#10;')"/>
							 	 <xsl:variable name="VLines56"   select="substring-after($VLines456,'&#10;')"/>
							    <xsl:variable name="VLines6"   select="substring-after($VLines56,'&#10;')"/>
							    <xsl:choose>
											<xsl:when test="substring-after($VLines6,'&#10;')">
												<xsl:value-of select="substring-before($VLines6,'&#10;')"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VLines6"/>
											</xsl:otherwise>
									</xsl:choose>
					 		</xsl:when>
			 		</xsl:choose>
		</xsl:template>
		
		<xsl:template name="GetValue">
				  	<xsl:param name="VExp"/>	   
				  	<xsl:param name="VTag"/>	   
					<xsl:variable name="temp">				
				 		   <xsl:call-template name="Contains">
				 		   	 	 <xsl:with-param name="VTag" select="$VTag"/>	 
						          <xsl:with-param name="VExp" select="$VExp" />
						          <xsl:with-param name="VNo" select="1" />
							</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="temp1">		
						<xsl:call-template name="GetLine">
					          <xsl:with-param name="VLine" select="$temp" />
					          <xsl:with-param name="VTag" select="$VTag" />
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="temp2">		
						<xsl:call-template name="GetLine">
					          <xsl:with-param name="VLine" select="$temp+1" />
					          <xsl:with-param name="VTag" select="$VTag" />
						</xsl:call-template>
					</xsl:variable>
					
					<xsl:value-of select="substring-after($temp1,$VExp)"/>
					<xsl:if test="starts-with($temp2, '//')">
						  <xsl:value-of select="substring-after($temp2,'//')"/>
					</xsl:if>
		</xsl:template>
</xsl:stylesheet>
