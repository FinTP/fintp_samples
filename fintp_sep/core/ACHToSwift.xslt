<?xml version="1.0"?>
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:cdttrf="urn:swift:xsd:CoreBlkLrgRmtCdtTrf" 
	xmlns:cbdd="urn:swift:xs:CoreBlkLrgRmtDDbt"  
	xmlns:cbddrfl="urn:swift:xs:CoreBlkDDbtRfl">
<xsl:output method="xml" encoding="us-ascii" omit-xml-declaration="yes" />

<!-- 25.01.2006 Modificat pentru mesaje MT104

-->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="cdttrf:CoreBlkLrgRmtCdtTrf" >
				<xsl:apply-templates/> 
		</xsl:when>
		<xsl:when test="cbdd:CoreBlkLrgRmtDDbtTrf" >
				<!--<xsl:call-template name="MT104E"/>-->
				<xsl:apply-templates/>
		</xsl:when>
		<xsl:when test="cbddrfl:CoreBlkDDbtRfl" >				
				<xsl:apply-templates/>
		</xsl:when>
	</xsl:choose>
</xsl:template>
   
<xsl:template match="cdttrf:CoreBlkLrgRmtCdtTrf">

<!-- Se va primi un xml de forma : <CoreBlk...CdtTrf><GrpHdr> ...</GrpHdr><CdtTrf> .... </CdtTrf><CoreBlk...CdtTrf> -->
  
    <xsl:element name="smt:MTCoreBlkLrgRmtCdtTrf"  namespace="urn:xmlns:SWIFTMTs">
			
		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
			<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
				<xsl:attribute name="BlockIdentifier">
	 				<xsl:value-of select="1"/>
	      		</xsl:attribute>
	      			
	     		<xsl:attribute name="ApplicationIdentifier">
	 				<xsl:value-of select="'F'"/>
	      		</xsl:attribute>
	      			
	   			<xsl:attribute name="ServiceIdentifier">
	 				<xsl:value-of select="'01'"/>
	      		</xsl:attribute>
	      			
				<xsl:attribute name="SenderLT" >
					<xsl:value-of select="cdttrf:CdtTrf/cdttrf:FrstAgt/cdttrf:BIC" />
	      		</xsl:attribute>
	      			
					<xsl:attribute name="SessionNumber">
	 					<xsl:value-of select="'.SN.'"/>
	      		</xsl:attribute> 
	      			
					<xsl:attribute name="SequenceNumber">
	 					<xsl:value-of select="'.ISN.'"/>
	      		</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="'CoreBlkLrgRmtCdtTrf'"/>
     		      	</xsl:attribute>				
     		      	
     		    
     		    	<xsl:element name="sg:ApplicationHeaderOutput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
     		      		</xsl:attribute>
     		      				
     		      		<xsl:attribute name="IOIdentifier">
     		 				<xsl:value-of select="'O'"/>
     		      		</xsl:attribute>
		      
     		      		<xsl:attribute name="ReceiverLT">
     		      			<xsl:value-of select="cdttrf:CdtTrf/cdttrf:FnlAgt/cdttrf:BIC" />
						</xsl:attribute>
     		      				
     		      		<xsl:attribute name="MessagePriority">
     		 				<xsl:value-of select="'N'"/>
     		      		</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="cdttrf:CdtTrf/cdttrf:PmtInstr/cdttrf:PmtTx/cdttrf:InstdAmt/@Ccy"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:variable name="VCreDt" select="cdttrf:SessionTime"/>
     						<xsl:variable name="VAfterCreDtT" select="translate($VCreDt, '&#xA;' , ' ' )"/>
     						<xsl:choose>
     							<xsl:when test="string-length($VCreDt)&gt;0">
		     						<xsl:choose>
		     							<xsl:when test="($VAfterCreDtT)&lt;11">
		     								<xsl:value-of select="1"/>
		     							</xsl:when>
		     							<xsl:when test="($VAfterCreDtT)&lt;14">
		     								<xsl:value-of select="2"/>
		     							</xsl:when>
		     							<xsl:otherwise>
		     								<xsl:value-of select="3"/>
		     							</xsl:otherwise>
		     						</xsl:choose>
		     					</xsl:when>
		     					<xsl:otherwise>
		     						<xsl:value-of select="''"/>
		     					</xsl:otherwise>
		     				</xsl:choose>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<!-- Prioritatea bancara -->
     						<xsl:value-of select="''"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     		
     				<!-- :20:SEPREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cdttrf:CdtTrf/cdttrf:PmtInstr/cdttrf:InstrRef"/>
						</xsl:attribute>
					</xsl:element>
     			
					<!-- :23B:CRED -->
					
					<xsl:element name="smt:tag23B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="'CRED'"/>
						</xsl:attribute>
					</xsl:element>
     				
					<!-- :32A:DATAPLATII_RON_SUMA -->
					<xsl:element name="smt:tag32A" namespace="urn:xmlns:SWIFTMTs">
						
						<xsl:attribute name="tagValue">
							<!-- Format data: YYYY-MM-DD -->
							
						  	<xsl:variable name="VValueDate" select="cdttrf:GrpHdr/cdttrf:IntrBkValDt/text()"/>					  	
						  	<!-- daca data platii nu e la nivelul headerului -->
						  	<xsl:choose>
						  		<xsl:when test="$VValueDate">
						  			<xsl:call-template name="FORMAT_DATE">
		      							<xsl:with-param name="VDate">
		      								<xsl:value-of select="$VValueDate"/>
		      							</xsl:with-param>
		      					</xsl:call-template> 
						  		</xsl:when>
						  	
						  	<!-- daca data platii e la nivelul headerului -->
							  	<xsl:otherwise>
							  		<xsl:variable name="VInstrValueDate" select="cdttrf:CdtTrf/cdttrf:PmtInstr/cdttrf:SttlmInstr/cdttrf:IntrBkValDt/text()"/>
							  		<xsl:call-template name="FORMAT_DATE">
		      							<xsl:with-param name="VDate">
		      								<xsl:value-of select="$VInstrValueDate"/>
		      							</xsl:with-param>
		      						</xsl:call-template> 
							  	</xsl:otherwise>
						  </xsl:choose>
								
							<xsl:value-of select="'RON'"/>
							
							<xsl:call-template name="FORMAT_AMOUNT">
	      						<xsl:with-param name="VSuma">
	      							<xsl:value-of select="cdttrf:CdtTrf/cdttrf:PmtInstr/cdttrf:SttlmInstr/cdttrf:IntrBkSttlmAmt"/>
	      						</xsl:with-param>
	      					</xsl:call-template> 
							
								
							
						</xsl:attribute>
     							
     				</xsl:element>
     				
					<!-- :50K:/IBANPL		sau /. (daca e NULL)
							  	 NUMEPL         			sau .
							    ADRESAPL					sau .
							    ADRESAPL (continuare) 	sau .
							    CODPL			      	sau .
							  
					-->
					<xsl:element name="smt:tag50K" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							<!-- Daca IBANPL este NULL se pune . -->
							<xsl:value-of select="'/'"/>
							<xsl:variable name="VContPl" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:DbtrAcct/cdttrf:Id/cdttrf:IBAN" />  
							<xsl:choose>
								<xsl:when test="string-length($VContPl)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VContPl"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca NUMEPL este NULL se pune . -->
							<!--<xsl:variable name="VNumePl" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:Nm" />  -->
							<xsl:variable name="VNumePl">
								<xsl:variable name="VPL1" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:Nm"/>
								<xsl:variable name="VPL2" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:Nm"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VPL1 )&gt;0">
										<xsl:value-of select="$VPL1"/>
									</xsl:when>
									<xsl:when test="string-length($VPL2)&gt;0">
										<xsl:value-of select="$VPL2"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable> 
							<xsl:choose>
								<xsl:when test="string-length($VNumePl)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VNumePl"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca ADRESAPL1 este NULL se pune . -->
							<!--<xsl:variable name="VAdresa1" select="substring(normalize-space(cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd),1,35)" />  -->
							<xsl:variable name="VAdresa1">
								<xsl:variable name="VAdr11" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
								<xsl:variable name="VAdr12" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr11 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr11, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr12)&gt;0">
										<xsl:value-of select="substring(translate($VAdr12, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VAdresa1)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa1"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/>
							
							<!-- Daca ADRESAPL2 este NULL se pune . -->
							<!--<xsl:variable name="VAdresa2" select="substring(normalize-space(cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd),36,35)" />-->
							<xsl:variable name="VAdresa2">
								<xsl:variable name="VAdr21" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
								<xsl:variable name="VAdr22" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr21 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr21, '&#xA;' , ' ' ),36,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr22)&gt;0">
										<xsl:value-of select="substring(translate($VAdr22, '&#xA;' , ' ' ),36,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VAdresa2)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa2"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/>
	      				
	      					
	      				<!-- Daca CODPL este NULL se pune . -->
							<xsl:variable name="VCodPl" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Dbtr/cdttrf:NFI/cdttrf:IdAndNmAdr/cdttrf:Id/cdttrf:ROURC" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodPl)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VCodPl"/>
								</xsl:otherwise>
							</xsl:choose>
						
  						</xsl:attribute>
  					</xsl:element>
     				
     				
  			
  					<xsl:element name="smt:tagQ52A" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cdttrf:CdtTrf/cdttrf:FrstAgt/cdttrf:BIC" />
						</xsl:attribute>
						<xsl:attribute name="visibility">
								<xsl:text>false</xsl:text>
						</xsl:attribute>
  					</xsl:element>
  					
  					<xsl:element name="smt:tagQ58A" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cdttrf:CdtTrf/cdttrf:FnlAgt/cdttrf:BIC" />
						</xsl:attribute>
						<xsl:attribute name="visibility">
							<xsl:text>false</xsl:text>
						</xsl:attribute>
  					</xsl:element>
  				
  					<!-- :59K:/IBANBN					sau /. (daca e NULL)
  							  NUMEBN         			sau .
  							  ADRESABN					sau .
  							  ADRESABN (continuare) 	sau .
  							  CODBN						sau .
  								  
  						-->
  					<xsl:element name="smt:tag59" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							<!-- Daca IBANBN este NULL se pune . -->
							<xsl:value-of select="'/'"/>
							<xsl:variable name="VContBn" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:CdtrAcct/cdttrf:Id/cdttrf:IBAN" />  
							<xsl:choose>
								<xsl:when test="string-length($VContBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VContBn"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca NUMEBN este NULL se pune . -->
							<!--<xsl:variable name="VNumeBn" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:Nm" />  -->
							<xsl:variable name="VNumeBn">
								<xsl:variable name="VNB1" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:Nm"/>
								<xsl:variable name="VNB2" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:Nm"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VNB1 )&gt;0">
										<xsl:value-of select="$VNB1"/>
									</xsl:when>
									<xsl:when test="string-length($VNB2)&gt;0">
										<xsl:value-of select="$VNB2"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VNumeBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VNumeBn"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca ADRESABN1 este NULL se pune . -->
							<!--<xsl:variable name="VAdresa1" select="substring(normalize-space(cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd),1,35)" />  -->
							<xsl:variable name="VAdresa1">
								<xsl:variable name="VAdr11" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
								<xsl:variable name="VAdr12" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr11 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr11, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr12)&gt;0">
										<xsl:value-of select="substring(translate($VAdr12, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VAdresa1)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa1"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/>
							
							<!-- Daca ADRESABN2 este NULL se pune . -->
							<!--<xsl:variable name="VAdresa2" select="substring(normalize-space(cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd),36,35)" />  -->
							<xsl:variable name="VAdresa2">
								<xsl:variable name="VAdr21" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/*/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
								<xsl:variable name="VAdr22" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/cdttrf:NmAndAdr/cdttrf:LngPstlAdrChc/cdttrf:Ustrd"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr21 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr21, '&#xA;' , ' ' ),36,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr22)&gt;0">
										<xsl:value-of select="substring(translate($VAdr22, '&#xA;' , ' ' ),36,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VAdresa2)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa2"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/>
	      				
	      					
	      				<!-- Daca CODBN este NULL se pune . -->
	      			
							<xsl:variable name="VCodBn" select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:Cdtr/cdttrf:NFI/cdttrf:IdAndNmAdr/cdttrf:Id/cdttrf:ROURC" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VCodBn"/>
								</xsl:otherwise>
							</xsl:choose>
						
  						</xsl:attribute>
  					</xsl:element>
     				
     		
     				<xsl:variable name="VExplicatii"  select ="substring(cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:RmtInf/cdttrf:Ustrd,1,140)" /><!-- Ustrd contine maxim 4 linii de cate 35 -->
  					<xsl:variable name="VIsReject" select ="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:RmtInf/cdttrf:Ustrd" />     				
     				<xsl:variable name="VSeq">
							<xsl:text>`;~</xsl:text>
					</xsl:variable>
					  					
     				 <xsl:if test="string-length($VExplicatii)&gt;0 and not (contains($VIsReject, $VSeq))">	<!-- daca contine secventa, at nu pun nimic in 70, merge tot in 72-->
     				 	  
	     				  <xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
			     					<xsl:attribute name="tagValue">
											<xsl:value-of select="$VExplicatii"/>
									</xsl:attribute>
	     					</xsl:element>
     				</xsl:if>
     					<!--  :71A:SHA -->
     				
	     				<xsl:element name="smt:tag71A" namespace="urn:xmlns:SWIFTMTs">
	     					<xsl:attribute name="tagValue">
	     						<xsl:value-of select="cdttrf:CdtTrf/cdttrf:PmtTx/cdttrf:ChrgBr"/>
	     					</xsl:attribute>
	     				</xsl:element>
	     				
	     				<!-- :72:-->
	     				<xsl:variable name="VTag72">
	     					<xsl:choose>
		     					<xsl:when test="contains($VIsReject, $VSeq)">
			     						<xsl:value-of select="$VIsReject"/>
		     					</xsl:when>
		     					<xsl:when test="contains($VIsReject,'/RETN/')">
			     						<xsl:value-of select="'/RETN/'"/>
			     						<xsl:value-of select="substring(substring-after($VIsReject,'/RETN/'),1,140)"/>
		     					</xsl:when>
		     					<xsl:when test="contains($VIsReject,'/REJT/')">
			     						<xsl:value-of select="'/REJT/'"/>
			     						<xsl:value-of select="substring(substring-after($VIsReject,'/REJT/'),1,140)"/>
		     					</xsl:when>
							</xsl:choose>
	     				</xsl:variable> 
     				 <xsl:if test="string-length($VTag72)&gt;0">	
     				 	  
	     				<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
	     					<xsl:attribute name="tagValue">
	
									<xsl:value-of select="$VTag72"/>
								
							</xsl:attribute>
	     					</xsl:element>
     					</xsl:if>
   
        		</xsl:element>
     		
    	</xsl:element>
    			

 </xsl:template>   			
    			

 
 <xsl:template match="cbdd:CoreBlkLrgRmtDDbtTrf">

    <xsl:element name="smt:MT104"  namespace="urn:xmlns:SWIFTMTs">
			
		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
			<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
				<xsl:attribute name="BlockIdentifier">
	 				<xsl:value-of select="1"/>
      		</xsl:attribute>
	      			
	     		<xsl:attribute name="ApplicationIdentifier">
	 				<xsl:value-of select="'F'"/>
      		</xsl:attribute>
	      			
   			<xsl:attribute name="ServiceIdentifier">
	 				<xsl:value-of select="'01'"/>
      		</xsl:attribute>
	      			
				<xsl:attribute name="SenderLT" >
					<xsl:value-of select="cbdd:DDbt/cbdd:FrstAgt/cbdd:BIC/text()" />
      		</xsl:attribute>
	      			
				<xsl:attribute name="SessionNumber">
	 					<xsl:value-of select="'.SN.'"/>
      		</xsl:attribute> 
	      			
				<xsl:attribute name="SequenceNumber">
	 					<xsl:value-of select="'.ISN.'"/>
      		</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="'104'"/>
  		      	</xsl:attribute>				
     		      	
     		    
     		    	<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
  		      		</xsl:attribute>
     		      				
  		      		<xsl:attribute name="IOIdentifier">
     		 				<xsl:value-of select="'O'"/>
  		      		</xsl:attribute>
		      
  		      		<xsl:attribute name="ReceiverLT">
     		      			<xsl:value-of select="cbdd:DDbt/cbdd:FnlAgt/cbdd:BIC/text()" />
						</xsl:attribute>
     		      				
  		      		<xsl:attribute name="MessagePriority">
     		 				<xsl:value-of select="'N'"/>
  		      		</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="cbdd:DDbt/cbdd:PmtInstr/cbdd:PmtTx/cbdd:InstdAmt/@Ccy"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="''"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<!-- Prioritatea bancara -->
     						<xsl:value-of select="''"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     			
     				
     		
     				<!-- :20:DDIREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbdd:DDbt/cbdd:PmtInstr/cbdd:InstrRef"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :21:DDIREF104 -->
     						
					<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbdd:GrpHdr/cbdd:GrpId"/>
						</xsl:attribute>
					</xsl:element>
     			
     				<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								<xsl:variable name="VValueDate" select="cbdd:GrpHdr/cbdd:IntrBkValDt/text()"/>					  	
						  	<!-- daca data platii nu e la nivelul headerului -->
						  	
						  	<!--	  	
						  	<xsl:call-template name="FORMAT_DATE">
	      						<xsl:with-param name="VDate">
	      							<xsl:value-of select="$VValueDate"/>
	      						</xsl:with-param>
	      					</xsl:call-template> 
	      				-->
	      				<xsl:choose>
	      					<xsl:when test="$VValueDate">
			      				<xsl:value-of select="substring($VValueDate,1,4)"/>
									<xsl:value-of select="substring($VValueDate,6,2)"/>
									<xsl:value-of select="substring($VValueDate,9,2)"/>	      						
	      					</xsl:when>
	      					<xsl:otherwise>
	      						<xsl:variable name="VInstrValueDate" select="cbdd:DDbt/cbdd:PmtInstr/cbdd:SttlmInstr/cbdd:IntrBkValDt/text()"/>
		      						<xsl:value-of select="substring($VInstrValueDate,1,4)"/>
										<xsl:value-of select="substring($VInstrValueDate,6,2)"/>
										<xsl:value-of select="substring($VInstrValueDate,9,2)"/>
	      					</xsl:otherwise>
	      				</xsl:choose>
	      				

						</xsl:attribute>
					</xsl:element>
					
					<!-- :32B:RON<SUMA> -->
					<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								
							<xsl:value-of select="'RON'"/>
							
							<xsl:call-template name="FORMAT_AMOUNT">
	      						<xsl:with-param name="VSuma">
	      							<xsl:value-of select="cbdd:DDbt/cbdd:PmtInstr/cbdd:SttlmInstr/cbdd:IntrBkSttlmAmt"/>
	      						</xsl:with-param>
	      				</xsl:call-template> 
	      				
						</xsl:attribute>
					</xsl:element>
     				
					<!-- :50K:/DDIIBANBF		sau /. (daca e NULL)
							  	 DDINUMBF         			sau .
							    DDIADRBF1					sau .
							    DDIADRBF2 (continuare) 	sau .
							    DDICODFBF			      	sau .
							  
					-->
					<xsl:element name="smt:tag50K" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							<!-- Daca DDIIBANBF este NULL se pune . -->
							<xsl:value-of select="'/'"/>
							<xsl:variable name="VContBn" select="cbdd:DDbt/cbdd:PmtTx/cbdd:CdtrAcct/cbdd:Id/cbdd:IBAN" />  
							<xsl:choose>
								<xsl:when test="string-length($VContBn)=0">
										<xsl:value-of select="'.'"/> 
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VContBn"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca DDINUMBF este NULL se pune . -->
							<!--<xsl:variable name="VNumeBn" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:Nm" /> -->
							<xsl:variable name="VNumeBn">
								<xsl:variable name="VNB1" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:Nm"/>
								<xsl:variable name="VNB2" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:Nm"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VNB1 )&gt;0">
										<xsl:value-of select="$VNB1"/>
									</xsl:when>
									<xsl:when test="string-length($VNB2)&gt;0">
										<xsl:value-of select="$VNB2"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable> 
							<xsl:choose>
								<xsl:when test="string-length($VNumeBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VNumeBn"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca DDIADRBF1 este NULL se pune . -->
							<!--<xsl:variable name="VAdresa1" select = "normalize-space(substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,1,35))" />  -->
							<xsl:variable name="VAdresa1">
								<xsl:variable name="VAdr11" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,1,35)"/>
								<xsl:variable name="VAdr12" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,1,35)"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr11 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr11, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr12)&gt;0">
										<xsl:value-of select="substring(translate($VAdr12, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="string-length($VAdresa1)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa1"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/>
							
							<!-- Daca DDIADRBF2 este NULL se pune . -->
						<!--	<xsl:variable name="VAdresa2" select="normalize-space(substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,36,35))" /> -->
							<xsl:variable name="VAdresa2">
								<xsl:variable name="VAdr21" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,36,35)"/>
								<xsl:variable name="VAdr22" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,36,35)"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr21 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr21, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr22)&gt;0">
										<xsl:value-of select="substring(translate($VAdr22, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable> 
							<xsl:choose>
								<xsl:when test="string-length($VAdresa2)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa2"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/>
	      					
	      				<!-- Daca DDICODFBF este NULL se pune . -->
							<xsl:variable name="VCodBn" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Cdtr/cbdd:NFI/cbdd:IdAndNmAdr/cbdd:Id/cbdd:ROURC" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VCodBn"/>
								</xsl:otherwise>
							</xsl:choose>
						
  						</xsl:attribute>
  					</xsl:element>
     				
     				
  					<!-- :59K:/DDIIBANPL					sau /. (daca e NULL)
  							  DDINUMPL         			sau .
  							  DDIADRPL1					sau .
  							  DDIADRPL2 (continuare) 	sau .
  							  
  								  
  						-->
  					<xsl:element name="smt:tag59" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							<!-- Daca DDIIBANPL este NULL se pune . -->
							<xsl:value-of select="'/'"/>
							<xsl:variable name="VContPl" select="cbdd:DDbt/cbdd:PmtTx/cbdd:DbtrAcct/cbdd:Id/cbdd:IBAN" />  
							<xsl:choose>
								<xsl:when test="string-length($VContPl)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VContPl"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca DDINUMPL este NULL se pune . -->
							<xsl:variable name="VNumePl">
								<xsl:variable name="VNP1" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:Nm"/>
								<xsl:variable name="VNP2" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:Nm"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VNP1 )&gt;0">
										<xsl:value-of select="$VNP1"/>
									</xsl:when>
									<xsl:when test="string-length($VNP2)&gt;0">
										<xsl:value-of select="$VNP2"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable> 
							<xsl:choose>
								<xsl:when test="string-length($VNumePl)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VNumePl"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca DDIADRPL1 este NULL se pune . -->
							<xsl:variable name="VAdresa1">
								<xsl:variable name="VAdr11" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,1,35)"/>
								<xsl:variable name="VAdr12" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,1,35)"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr11 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr11, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr12)&gt;0">
										<xsl:value-of select="substring(translate($VAdr12, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable> 
							<xsl:choose>
								<xsl:when test="string-length(VAdresa1)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa1"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/>
							
							<!-- Daca DDIADRPL2 este NULL se pune . -->
							<xsl:variable name="VAdresa2">
								<xsl:variable name="VAdr21" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/*/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,36,35)"/>
								<xsl:variable name="VAdr22" select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/cbdd:NmAndAdr/cbdd:LngPstlAdrChc/cbdd:Ustrd,36,35)"/>
							
								<xsl:choose>
									<xsl:when test="string-length($VAdr21 )&gt;0">
										<xsl:value-of select="substring(translate($VAdr21, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
									<xsl:when test="string-length($VAdr22)&gt;0">
										<xsl:value-of select="substring(translate($VAdr22, '&#xA;' , ' ' ),1,35)"/>
									</xsl:when>
								</xsl:choose>
							</xsl:variable>   
							<xsl:choose>
								<xsl:when test="string-length(VAdresa2)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VAdresa2"/>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/>
	      			
	      					
	      				<!-- Daca CODBN este NULL se pune . -->
	      			
							<xsl:variable name="VCodBn" select="cbdd:DDbt/cbdd:PmtTx/cbdd:Dbtr/cbdd:NFI/cbdd:IdAndNmAdr/cbdd:Id/cbdd:ROURC" />  
							<xsl:choose>
								<xsl:when test="string-length(VCodBn)=0">
									<xsl:value-of select="'.'"/> 
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VCodBn"/>
								</xsl:otherwise>
							</xsl:choose>
					
  						</xsl:attribute>
  					</xsl:element>
     				
     		
     				<!--  :70: -->  		  
     				<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
     					<xsl:attribute name="tagValue">
     					
     						<xsl:variable name="VExplicatii"  select ="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:RmtInf/cbdd:Ustrd,1,140)" />
	
							<xsl:value-of select="$VExplicatii"/>
     								
     						</xsl:attribute>
     					</xsl:element> 
     				
     					<!--  :71A:SHA -->
     				
	     				<xsl:element name="smt:tag71A" namespace="urn:xmlns:SWIFTMTs">
	     					<xsl:attribute name="tagValue">
	     						<xsl:value-of select="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:ChrgBr,1,3)"/>
	     					</xsl:attribute>
	     				</xsl:element>
	     				
	     				<!--  :72: --> 
	     				<xsl:if test="string-length(cbdd:DDbt/cbdd:PmtTx/cbdd:RmtInf/cbdd:Ustrd)&gt;141">
		     				<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
	     						<xsl:attribute name="tagValue">
	     					
	     						<xsl:variable name="VExplicatii"  select ="substring(cbdd:DDbt/cbdd:PmtTx/cbdd:RmtInf/cbdd:Ustrd,141,210)" />
		
								<xsl:value-of select="$VExplicatii"/>
	     								
	     						</xsl:attribute>
	     					</xsl:element> 
   					</xsl:if>
        		</xsl:element>
     		
    	</xsl:element>
    			

 </xsl:template>   			
 
 
 <xsl:template match="cbdd:CoreBlkLrgRmtDDbtHdr">

    <xsl:element name="smt:MT104"  namespace="urn:xmlns:SWIFTMTs">
			
		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
			<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
				<xsl:attribute name="BlockIdentifier">
	 				<xsl:value-of select="1"/>
      		</xsl:attribute>
	      			
	     		<xsl:attribute name="ApplicationIdentifier">
	 				<xsl:value-of select="'F'"/>
      		</xsl:attribute>
	      			
   			<xsl:attribute name="ServiceIdentifier">
	 				<xsl:value-of select="'01'"/>
      		</xsl:attribute>
	      			
				<xsl:attribute name="SenderLT" >
					<xsl:value-of select="cbdd:DDbt/cbdd:FrstAgt/cbdd:BIC" />
      		</xsl:attribute>
	      			
				<xsl:attribute name="SessionNumber">
	 					<xsl:value-of select="'.SN.'"/>
      		</xsl:attribute> 
	      			
				<xsl:attribute name="SequenceNumber">
	 					<xsl:value-of select="'.ISN.'"/>
      		</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="'104'"/>
  		      	</xsl:attribute>				
     		      	   		    
     		    	<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
  		      		</xsl:attribute>
     		      				
  		      		<xsl:attribute name="IOIdentifier">
     		 				<xsl:value-of select="'O'"/>
  		      		</xsl:attribute>
		      
  		      		<xsl:attribute name="ReceiverLT">
     		      			<xsl:value-of select="cbdd:DDbt/cbdd:FnlAgt/cbdd:BIC/text()" />
						</xsl:attribute>
     		      				
  		      		<xsl:attribute name="MessagePriority">
     		 				<xsl:value-of select="'N'"/>
  		      		</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="cbdd:DDbt/cbdd:PmtInstr/cbdd:PmtTx/cbdd:InstdAmt/@Ccy"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="''"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<!-- Prioritatea bancara -->
     						<xsl:value-of select="''"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     		
     				<!-- :20:SEPREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbdd:GrpHdr/cbdd:GrpId"/>
						</xsl:attribute>
					</xsl:element>
					
					<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbdd:GrpHdr/cbdd:IndvItmTtlNb"/>
						</xsl:attribute>
					</xsl:element>
     			
     				<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								<xsl:variable name="VValueDate" select="cbdd:GrpHdr/cbdd:IntrBkValDt/text()"/>					  	
						  	<!-- daca data platii nu e la nivelul headerului -->
						  	<!--	  	
						  	<xsl:call-template name="FORMAT_DATE">
	      						<xsl:with-param name="VDate">
	      							<xsl:value-of select="$VValueDate"/>
	      						</xsl:with-param>
	      					</xsl:call-template> 
	      				-->
	      				<xsl:value-of select="substring($VValueDate,1,4)"/>
							<xsl:value-of select="substring($VValueDate,6,2)"/>
							<xsl:value-of select="substring($VValueDate,9,2)"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :32B:RON<SUMA> -->
					<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
	
							<xsl:value-of select="'RON'"/>
							
							<xsl:call-template name="FORMAT_AMOUNT">
	      						<xsl:with-param name="VSuma">
	      							<xsl:value-of select="cbdd:GrpHdr/cbdd:TtlSttlmAmt"/>
	      						</xsl:with-param>
	      				</xsl:call-template> 
	      				
						</xsl:attribute>
					</xsl:element>
     				
					
        		</xsl:element>
     		
    	</xsl:element>
    			

 </xsl:template> 
 
 <xsl:template match="cbddrfl:CoreBlkDDbtRfl">

    <xsl:element name="smt:MT104R"  namespace="urn:xmlns:SWIFTMTs">
			
		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
			<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
				<xsl:attribute name="BlockIdentifier">
	 				<xsl:value-of select="1"/>
      		</xsl:attribute>
	      			
	     		<xsl:attribute name="ApplicationIdentifier">
	 				<xsl:value-of select="'F'"/>
      		</xsl:attribute>
	      			
   			<xsl:attribute name="ServiceIdentifier">
	 				<xsl:value-of select="'01'"/>
      		</xsl:attribute>
	      			
				<xsl:attribute name="SenderLT" >
					<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:RefIssr/text()" />
      		</xsl:attribute>
	      			
				<xsl:attribute name="SessionNumber">
	 					<xsl:value-of select="'.SN.'"/>
      		</xsl:attribute> 
	      			
				<xsl:attribute name="SequenceNumber">
	 					<xsl:value-of select="'.ISN.'"/>
      		</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="'104R'"/>
  		      	</xsl:attribute>				
     		      	
     		    
     		    	<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
  		      		</xsl:attribute>
     		      				
  		      		<xsl:attribute name="IOIdentifier">
     		 				<xsl:value-of select="'O'"/>
  		      		</xsl:attribute>
		      
  		      		<xsl:attribute name="ReceiverLT">
     		      			<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:DDReceiver/text()" />
						</xsl:attribute>
     		      				
  		      		<xsl:attribute name="MessagePriority">
     		 				<xsl:value-of select="'N'"/>
  		      		</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="''"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="cbddrfl:BlkDDRefHdlg/cbddrfl:IteRef"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<!-- Prioritatea bancara -->
     						<xsl:value-of select="''"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     			
     				
     		
     				<!-- :20:DDIREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbddrfl:BlkDDRefHdlg/cbddrfl:IteRef"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :21:DDIREF104 -->
     						
					<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:Ref"/>
						</xsl:attribute>
					</xsl:element>
					
					<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								<xsl:variable name="VValueDate" select="cbddrfl:GrpHdr/cbddrfl:CreDt/text()"/>					  	
						  	
	      				<xsl:value-of select="substring($VValueDate,3,2)"/>
							<xsl:value-of select="substring($VValueDate,6,2)"/>
							<xsl:value-of select="substring($VValueDate,9,2)"/>
						</xsl:attribute>
					</xsl:element>
     			
     				
					<!-- :32B:RON<SUMA> -->
					<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								
							<xsl:value-of select="'RON0'"/>
							
							
	      				
						</xsl:attribute>
					</xsl:element>
     				
     				   				
     		
     				<!-- :70: DDIDET1
							     DDIDET2  -->	
							     
					
					<xsl:variable name="VDet1" select="substring(cbddrfl:BlkDDRefHdlg/cbddrfl:ErrCd,1,35)"/>
					<xsl:variable name="VDet2" select="substring(cbddrfl:BlkDDRefHdlg/cbddrfl:Desc,1,35)"/>	 
					<xsl:if test="(string-length($VDet1)&gt;0) or (string-length($VDet2)&gt;0)"> 
	     				<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
	     					<xsl:attribute name="tagValue">
	     					
								<xsl:choose>
									<xsl:when test="string-length($VDet1)&gt;0">
										<xsl:value-of select="$VDet1"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								
							
									<xsl:if test="string-length($VDet2)&gt;0">
										<xsl:value-of select="'&#xA;'"/>
										<xsl:value-of select="$VDet2"/>
									</xsl:if>
									
	     								
	     						</xsl:attribute>
	     					</xsl:element> 
     					</xsl:if>
     					
        		</xsl:element>
     		
    	</xsl:element>
    			

 </xsl:template>


<xsl:template match="cbddrfl:CoreBlkDDbtRflHdr">

    <xsl:element name="smt:MT104R"  namespace="urn:xmlns:SWIFTMTs">
			
		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
			<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
				<xsl:attribute name="BlockIdentifier">
	 				<xsl:value-of select="1"/>
      		</xsl:attribute>
	      			
	     		<xsl:attribute name="ApplicationIdentifier">
	 				<xsl:value-of select="'F'"/>
      		</xsl:attribute>
	      			
   			<xsl:attribute name="ServiceIdentifier">
	 				<xsl:value-of select="'01'"/>
      		</xsl:attribute>
	      			
				<xsl:attribute name="SenderLT" >
					<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:RefIssr/text()" />
      		</xsl:attribute>
	      			
				<xsl:attribute name="SessionNumber">
	 					<xsl:value-of select="'.SN.'"/>
      		</xsl:attribute> 
	      			
				<xsl:attribute name="SequenceNumber">
	 					<xsl:value-of select="'.ISN.'"/>
      		</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="'104R'"/>
  		      	</xsl:attribute>				
     		      	
     		    
     		    	<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
  		      		</xsl:attribute>
     		      				
  		      		<xsl:attribute name="IOIdentifier">
     		 				<xsl:value-of select="'O'"/>
  		      		</xsl:attribute>
		      
  		      		<xsl:attribute name="ReceiverLT">
     		      			<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:DDReceiver/text()" />
						</xsl:attribute>
     		      				
  		      		<xsl:attribute name="MessagePriority">
     		 				<xsl:value-of select="'N'"/>
  		      		</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="''"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="''"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<!-- Prioritatea bancara -->
     						<xsl:value-of select="''"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     			
     				
     		
     				<!-- :20:DDIREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbddrfl:AddtlRefs/cbddrfl:Ref"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :21:DDIBATCH -->
     						
					<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="cbddrfl:GrpHdr/cbddrfl:IndvItmTtlNb"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :23E:RTND , nu exista in mesaj dar punem noi numarul de mesaje din 104 -->
					<xsl:element name="smt:tag23E" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:text>RTND</xsl:text>
						</xsl:attribute>
					</xsl:element>
									
									
     			
     				<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								<xsl:variable name="VValueDate" select="cbddrfl:GrpHdr/cbddrfl:CreDt/text()"/>					  	
						  	<!-- daca data platii nu e la nivelul headerului -->
						  	
						  	<!--	  	
						  	<xsl:call-template name="FORMAT_DATE">
	      						<xsl:with-param name="VDate">
	      							<xsl:value-of select="$VValueDate"/>
	      						</xsl:with-param>
	      					</xsl:call-template> 
	      				-->
	      				<xsl:value-of select="substring($VValueDate,1,4)"/>
							<xsl:value-of select="substring($VValueDate,6,2)"/>
							<xsl:value-of select="substring($VValueDate,9,2)"/>
						</xsl:attribute>
					</xsl:element>
					
					<!-- :32B:RON<SUMA> -->
					<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
								
							<xsl:value-of select="'RON0'"/>
							
							
	      				
						</xsl:attribute>
					</xsl:element>
     				
				
     					
        		</xsl:element>
     		
    	</xsl:element>
    			

 </xsl:template>
<xsl:template name="FORMAT_DATE">
	<xsl:param name="VDate"/>
	<!-- De la format YYYY-MM-DD la format YYMMDD-->
		<xsl:value-of select="substring($VDate,3,2)"/>
		<xsl:value-of select="substring($VDate,6,2)"/>
		<xsl:value-of select="substring($VDate,9,2)"/>
</xsl:template>


<xsl:template name="FORMAT_AMOUNT">
	<xsl:param name="VSuma"/>
	<!-- De la format numeric cu .  la format cu ,-->
		<xsl:if test="contains($VSuma,'.')">
			<xsl:value-of select="substring-before($VSuma, '.')" />
			<xsl:value-of select="','"/> 
			<xsl:value-of select="substring-after($VSuma, '.')" />
		</xsl:if>
		<xsl:if test="not(contains($VSuma,'.'))">
			<xsl:value-of select="$VSuma" />
			<xsl:value-of select="','"/> 
		</xsl:if>
</xsl:template>


</xsl:stylesheet>