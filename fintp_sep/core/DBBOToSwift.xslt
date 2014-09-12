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

<?xml version="1.0"?>
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output method="xml" indent="yes" encoding="us-ascii" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>


<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>




   
<xsl:template match="/Record">

	<xsl:variable name="VBicBn" select="substring(BICBN,1,7)"/>
	
   
  	<xsl:variable name="TheMsgType" select="TIPMESAJ"/>  
  	<xsl:variable name="TheCodSep" select="CODSEP"/>

	<xsl:variable name="TheMessageType">
	<xsl:choose>
   	<xsl:when test="$TheMsgType=string('103') and $TheCodSep=string('A')"> 
				<xsl:value-of select="'CoreBlkLrgRmtCdtTrf'"/>  
		</xsl:when>
		<xsl:otherwise>
				<xsl:value-of select="TIPMESAJ"/>  
		</xsl:otherwise>
	</xsl:choose>
  	</xsl:variable>
  	
  	
 	
	<xsl:choose>
	
    	<xsl:when test="$TheMessageType=string('103') or $TheMessageType=string('CoreBlkLrgRmtCdtTrf')">
				<xsl:element name="smt:MT{$TheMessageType}"  namespace="urn:xmlns:SWIFTMTs">
			
				<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
				<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
					<xsl:attribute name="BlockIdentifier">
	 					<xsl:value-of select="1"/>
	      			</xsl:attribute>
	      			
	     			<xsl:attribute name="ApplicationIdentifier">
	 					<xsl:text>F</xsl:text>
	      			</xsl:attribute>
	      			
		   			<xsl:attribute name="ServiceIdentifier">
		 					<xsl:text>01</xsl:text>
		      		</xsl:attribute>
	      			
					<xsl:attribute name="SenderLT">
	 					<xsl:value-of select="substring(BICPL,1,8)"/>
	 					<xsl:text>AXXX</xsl:text>
					</xsl:attribute>
	      			
					<xsl:attribute name="SessionNumber">
	 					<xsl:text>0000</xsl:text>
	 					<!--xsl:text>.SN.</xsl:text-->
	      			</xsl:attribute> 
	      			
					<xsl:attribute name="SequenceNumber">
	 					<xsl:text>000000</xsl:text>
	 					<!--xsl:text>..ISN.</xsl:text-->
	      			</xsl:attribute> 
	      		
				</xsl:element> <!--End Basic Header -->
     		
     			<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 		<xsl:attribute name="MessageType">
     		 			<xsl:value-of select="$TheMessageType"/>
     		     </xsl:attribute>
					      	
     		      				   
     		    	<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     						
    					<xsl:attribute name="BlockIdentifier">
     		 				<xsl:value-of select="2"/>
     		      		</xsl:attribute>
     		      				
	     		      	<xsl:attribute name="IOIdentifier">
	     		 				<xsl:text>I</xsl:text>
	     		      	</xsl:attribute>
	     		      				
	     		      	<xsl:attribute name="ReceiverLT">
     		 				<xsl:value-of select="substring(BICBN,1,8)"/>
     		 				<xsl:text>XXXX</xsl:text>
	     		      	</xsl:attribute>
     		      				
	     		      	<xsl:attribute name="MessagePriority">
	     		 			<xsl:text>N</xsl:text>
	     		      	</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:text>ROL</xsl:text>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:text>00</xsl:text>
     						<xsl:value-of select="PRB"/>
     					</xsl:attribute >
     				</xsl:element>

     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="TRAN"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     		
     				<!-- :20:NRREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="NRREF"/>
						</xsl:attribute>
					</xsl:element>
     			
					<!-- :23B:CODOP ( CRED) -->
					
					<xsl:element name="smt:tag23B" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="CODOP"/>
						</xsl:attribute>
					</xsl:element>
     				   				
     				
     				<!-- :32A:DATAPLATII_RON_SUMANT -->
					<xsl:element name="smt:tag32A" namespace="urn:xmlns:SWIFTMTs">
						
						<xsl:attribute name="tagValue">
							
     						<xsl:value-of select="DATAPLATII"/>		
     								
							<xsl:text>RON</xsl:text>
	
							<xsl:variable name="VSuma" select ="SUMANT" />
						
							
							<xsl:choose>
								<xsl:when test="contains($VSuma,'.')">
									<xsl:value-of select="substring-before($VSuma, '.')" />
										<xsl:if test="string-length(substring-before($VSuma, '.'))=0">
											<xsl:text>0</xsl:text>
										</xsl:if>
									<xsl:text>,</xsl:text>
									<xsl:value-of select="substring-after($VSuma, '.')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VSuma" />
									<xsl:text>,</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
						</xsl:attribute>
     							
     				</xsl:element>
     				
     				<!-- 33B :RON<SUMANT> -->
     						
  				    <xsl:element name="smt:tag33B" namespace="urn:xmlns:SWIFTMTs">
						
						<xsl:attribute name="tagValue">
     								
							<xsl:text>RON</xsl:text>
	
							<xsl:variable name="VSuma" select ="SUMANT" />
						
							
							<xsl:choose>
								<xsl:when test="contains($VSuma,'.')">
									<xsl:value-of select="substring-before($VSuma, '.')" />
										<xsl:if test="string-length(substring-before($VSuma, '.'))=0">
											<xsl:text>0</xsl:text>
										</xsl:if>
									<xsl:text>,</xsl:text> 
									<xsl:value-of select="substring-after($VSuma, '.')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VSuma" />
									<xsl:text>,</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
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
							
							<xsl:text>/</xsl:text>
							<!-- Daca IBANPL este NULL se pune . -->						
							<xsl:variable name="VContPl" select="IBANPL" /> 
							<xsl:choose> 
								<xsl:when test="string-length($VContPl)&gt;0">
									<xsl:value-of select="$VContPl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca NUMEPL este NULL se pune . -->
							<xsl:variable name="VNumePl" select="NUMEPL" />  
							<xsl:choose>
								<xsl:when test="string-length($VNumePl)&gt;0">
									<xsl:value-of select="$VNumePl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca ADRESAPL1 este NULL se pune . -->
							<xsl:variable name="VAdresaPl1" select="substring(ADRESAPL,1,35)" /> 
							<xsl:choose>
								<xsl:when test="string-length($VAdresaPl1)&gt;0">
									<xsl:value-of select="$VAdresaPl1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
	
							<xsl:value-of select="$VEnter"/> 
	      				
	      				<!-- Daca ADRESAPL2 este NULL se pune . -->
							<xsl:variable name="VAdresaPl2" select="substring(ADRESAPL,36,35)" />  
							<xsl:choose>
								<xsl:when test="string-length($VAdresaPl2)&gt;0">
									<xsl:value-of select="$VAdresaPl2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
	      		
	      					
	      				<!-- Daca CODPL este NULL se pune . -->
							<xsl:variable name="VCodPl" select="CODPL" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodPl)&gt;0">
									<xsl:value-of select="$VCodPl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						
  						</xsl:attribute>
  					</xsl:element>
     				
     				
  					<!-- :59K:/IBANBN			sau /. (daca e NULL)
  							  	 NUMEBN         			sau .
  							  	 ADRESABN					sau .
  							    ADRESABN (continuare) 	sau .
  							    CODBN						sau .
  								  
  						-->
  					<xsl:element name="smt:tag59" namespace="urn:xmlns:SWIFTMTs">
  						<xsl:attribute name="tagValue">
  							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
     						
     						<xsl:text>/</xsl:text>
  							<!-- Daca IBANBN este NULL se pune . -->
  							<xsl:variable name="VContBn" select="IBANBN" />  
  							<xsl:choose> 
								<xsl:when test="string-length($VContBn)&gt;0">
									<xsl:value-of select="$VContBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
  							<xsl:value-of select="$VEnter"/> 
     								
  							<!-- Daca NUMEBN este NULL se pune . -->
  							<xsl:variable name="VNumeBn" select="NUMEBN" />  
  							<xsl:choose> 
								<xsl:when test="string-length($VNumeBn)&gt;0">
									<xsl:value-of select="$VNumeBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
  							<xsl:value-of select="$VEnter"/> 
     								
  							<!-- Daca ADRESABN1 este NULL se pune . -->
							<xsl:variable name="VAdresaBn1" select="substring(ADRESABN,1,35)" />  
							<xsl:choose> 
								<xsl:when test="string-length($VAdresaBn1)&gt;0">
									<xsl:value-of select="$VAdresaBn1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
	      				
	      				<!-- Daca ADRESABN2 este NULL se pune . -->
							<xsl:variable name="VAdresaBn2" select="substring(ADRESABN,36,35)" />  
							<xsl:choose> 
								<xsl:when test="string-length($VAdresaBn2)&gt;0">
									<xsl:value-of select="$VAdresaBn2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
  		      					      					
  		      			<!-- Daca CODBN este NULL se pune . -->
  							<xsl:variable name="VCodBn" select="CODBN" />  
  							<xsl:choose> 
								<xsl:when test="string-length($VCodBn)&gt;0">
									<xsl:value-of select="$VCodBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
     							
     							
	     				</xsl:attribute>
	     			 </xsl:element>
     				
     				<!-- 
     						
     							Daca BICBN='TREZROB'
     						
     								70:	/ROC/<NRCRBUG>
     										//RFB/<NRDOC>/<DATADOC>/<DATADOC>
     										<EXPLICATII>	
     										<EXPLICATII>	
     										
     							Altfel
     										/ROC/<EXPLICATII>		
     										<EXPLICATII>				    . 
     						    			<EXPLICATII>
     						  				//RFB/<NRDOC>	
     						  
     				-->
     				<xsl:variable name="VExplicatii" select="normalize-space(EXPLICATII)" /> 
     				<xsl:variable name="VNrDoc" select="NRDOC" />		  		  
     				<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
     					<xsl:attribute name="tagValue">
     					
     						<xsl:variable name="VBeneficiar"  select ="substring(BICBN,1,7)" />
     							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
     							
     							<xsl:choose>
     							<!-- Daca e pentru trezorerie -->
     							<xsl:when test=" $VBeneficiar='TREZROB' ">
     							
     								<xsl:text>/ROC/</xsl:text>
     								<xsl:variable name="VCreanta" select="NRCRBUG" /> 	
     								<xsl:choose>
     									<xsl:when test="string-length($VCreanta)&gt;0">
			  								<xsl:value-of select="$VCreanta"/>
			  							</xsl:when> 
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
			  						</xsl:choose>
		  							
		  							<xsl:value-of select="$VEnter"/>
		  							<xsl:text>/RFB/</xsl:text>
		  						 
		  							<xsl:choose>	
		  								<xsl:when test="string-length($VNrDoc)&gt;0">
			  								<xsl:value-of select="$VNrDoc"/>
			  							</xsl:when> 
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
			  						</xsl:choose>
			  						
		  							<xsl:text>/</xsl:text>
		  							
		  						<xsl:variable name="VDataDoc" select="DATADOC" /> 	
		  							<xsl:choose> 
			  							<xsl:when test="string-length($VDataDoc)&gt;0">
			  								<xsl:text>20</xsl:text>
			  								<xsl:value-of select="$VDataDoc"/>
			  							</xsl:when>
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
		  							</xsl:choose>
 							
		  							<xsl:text>/</xsl:text>
		  									  							
		  							<xsl:choose>	 
			  							<xsl:when test="string-length($VDataDoc)&gt;0">
			  								<xsl:text>20</xsl:text>
			  								<xsl:value-of select="$VDataDoc"/>
			  							</xsl:when>
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
		  							</xsl:choose>
		  						 
		  							<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,35)" />   
	     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,36,35)" />
	     		      		
	     		      			<xsl:choose>	
	     		      				<xsl:when test="string-length($VExplicatii)&gt;35">
	     		      					<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VPrimaLinie"/>
		     		      				<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VADouaLinie"/>
		     		      			</xsl:when>
		     		      			<xsl:when test="(string-length($VExplicatii)&lt;36) and (string-length($VExplicatii)&gt;0)">
		     		      				<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VPrimaLinie"/>
		     		      			</xsl:when>
		     		      		</xsl:choose>
		  										
		  						</xsl:when>
		  							
		  						<!-- Daca beneficiarul e banca -->
		  						<xsl:otherwise>	
		  							 
		  						<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,30)" />   
	     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,31,35)" />
	     		      			<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,66,35)" />
	     		      			<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,101,35)" />
	     		      			
	     		      			
	     		      			<xsl:text>/ROC/</xsl:text>	
	     		      			<xsl:choose>
	     		      				
	     		      				<!-- se testeaza daca avem o singura linie de explicatii-->
	     		      					<xsl:when test="string-length($VExplicatii)&lt;31">
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     		      					<xsl:if test="string-length($VPrimaLinie)=0">
		     										<xsl:value-of select="'.'"/>
		     									</xsl:if>
		     									<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:text>//RFB/</xsl:text>
		     						
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  											<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:value-of select="'.'"/> 
	  											</xsl:if>
	     		      					
	     		      					</xsl:when>
	     		      					
	     		      					<!-- se testeaza daca avem doua linii de explicatii-->
	     		      					<xsl:when test="string-length($VExplicatii)&lt;66">
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>	
		     									<xsl:value-of select="$VEnter"/>
												
												<xsl:text>//RFB/</xsl:text>
												
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  												<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:value-of select="'.'"/> 
	  											</xsl:if>
	     		      					
	     		      					<!-- se testeaza daca avem trei linii de explicatii-->
	     		      					</xsl:when>
	     		      					
	     		      					<xsl:when test="string-length($VExplicatii)&lt;101">
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VATreiaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:text>//RFB/</xsl:text>
		     	
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  												<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:text>.</xsl:text> 
	  											</xsl:if>
	     		      					
	     		      					</xsl:when>
	     		      					
	     		      					<!-- varianta default cand avem cel putin patru linii de explicatii-->
	     		      					<xsl:otherwise>
	     		      						
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>				
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VATreiaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:value-of select="$VAPatraLinie"/>
		     		      					
		     										     		      					
	     		      					</xsl:otherwise>
	     		      					
	     		      					
	     		      				</xsl:choose>
		     											
				  				</xsl:otherwise>
				  			</xsl:choose>
     					</xsl:attribute>
     				</xsl:element>
	     				
	     					<!--  :71A:SHA -->
	     				
		     				<xsl:element name="smt:tag71A" namespace="urn:xmlns:SWIFTMTs">
		     					<xsl:attribute name="tagValue">
		     						<xsl:value-of select="TIPCMS"/>
		     					</xsl:attribute>
		     				</xsl:element>
	   					
	   					<!-- :71G: sau :71F: -->
	   					 	<xsl:variable name="VSumaCms" select ="SUMACM" />
							<xsl:variable name="VTipCms" select ="TIPCMS" />
							<!--<xsl:variable name="VSumaCms" select ="SUMACM" />-->
							<xsl:choose>
								<xsl:when test="$VTipCms='OUR'"> 
	  						  		<xsl:element name="smt:tag71G" namespace="urn:xmlns:SWIFTMTs"> 
	
										<xsl:attribute name="tagValue">
										
						     		 		
						     		 		<xsl:text>RON</xsl:text>
						     		 	
						     		 		
						     		 		<xsl:choose>
												<xsl:when test="contains($VSumaCms,'.')">
													<xsl:value-of select="substring-before($VSumaCms, '.')" />
													<xsl:if test="string-length(substring-before($VSumaCms, '.'))=0">
														<xsl:text>0</xsl:text>
													</xsl:if>
													<xsl:text>,</xsl:text>
													<xsl:value-of select="substring-after($VSumaCms, '.')" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VSumaCms" />
													<xsl:text>,</xsl:text> 
												</xsl:otherwise>
											</xsl:choose>
							
										</xsl:attribute>
	     							
	  								</xsl:element>
	  						</xsl:when> 
	  						<xsl:when test="( $VTipCms = 'BEN' ) or ( ( $VTipCms = 'SHA' ) and ( string-length($VSumaCms )&gt;0) and ( not(($VSumaCms = '0')  or ( $VSumaCms = '0.0')   or ($VSumaCms = '0.00' ) ) )  ) "> 
	  						  		<xsl:element name="smt:tag71F" namespace="urn:xmlns:SWIFTMTs"> 
	
										<xsl:attribute name="tagValue">
						     		 	 <xsl:text>RON</xsl:text>
						     		 	
						     		 	 
											<xsl:choose>
												<xsl:when test="contains($VSumaCms,'.')">
													<xsl:value-of select="substring-before($VSumaCms, '.')" />
													<xsl:if test="string-length(substring-before($VSumaCms, '.'))=0">
														<xsl:text>0</xsl:text>
													</xsl:if>
													<xsl:text>,</xsl:text>
													<xsl:value-of select="substring-after($VSumaCms, '.')" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VSumaCms" />
													<xsl:text>,</xsl:text> 
												</xsl:otherwise>
											</xsl:choose>
							
										</xsl:attribute>
	     							
	  								</xsl:element>
	  						</xsl:when>
	  					</xsl:choose> 
	  					
	  					
	  					<!-- :72: -->
	   						
						
						<xsl:variable name="VRefuzPlata" select ="REFUZPL" />
						<xsl:variable name="VBeneficiar"  select ="substring(BICBN,1,7)" />
						<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							
					 <xsl:choose> 
								<!-- Daca e refuz de plata-->
								<xsl:when test="not(contains($VRefuzPlata,'N'))">	
			  					
			  						<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
			  							<xsl:attribute name="tagValue">
			  							
			  								<xsl:variable name="VTagEroare" select="TAGEROARE" /> 
			  								<xsl:variable name="VNrRefDest" select="NRREFDEST" />  
											<xsl:variable name="VEroareSWIFT" select="ERSWIFT" />
			  							  	<xsl:variable name="VDetErr" select="DETERR" />
	     		      					
					  		               <xsl:choose>
                                           <xsl:when test="$VRefuzPlata='T'">
                                               <xsl:text>/RETN/</xsl:text>
                                           </xsl:when>
                                           <xsl:when test="$VRefuzPlata='J'">
                                               <xsl:text>/REJT/</xsl:text>
                                           </xsl:when>
                                       </xsl:choose>
			  								
			  								<xsl:choose>
			  									<xsl:when test="string-length($VTagEroare)&gt;0">
					  							<xsl:value-of select="$VTagEroare"/>
					  							</xsl:when>
					  							<xsl:otherwise>
				  									<xsl:text>.</xsl:text> 
				  								</xsl:otherwise>
			  								</xsl:choose>
			  								
			  								<xsl:value-of select="$VEnter"/>
			  								
			  								<xsl:text>/</xsl:text>
			  								
			  								<xsl:choose>
			  									<xsl:when test="string-length($VEroareSWIFT)&gt;0">
				  									<xsl:value-of select="$VEroareSWIFT"/>
				  								</xsl:when>
					  							<xsl:otherwise>
				  									<xsl:text>.</xsl:text>
				  								</xsl:otherwise>
			  								</xsl:choose>
			  								
			  								<xsl:text>/</xsl:text>
			  								
			  								<xsl:choose>
			  									<xsl:when test="string-length($VDetErr)&gt;0">
					  								<xsl:value-of select="$VDetErr"/>
					  							</xsl:when>
					  							<xsl:otherwise>
				  									<xsl:text>.</xsl:text>
				  								</xsl:otherwise>
			  								</xsl:choose>
			  								
			  								<xsl:value-of select="$VEnter"/>
			  								
			  								<xsl:text>/MREF/</xsl:text>
			  								<xsl:choose>
			  									<xsl:when test="string-length($VNrRefDest)&gt;0">
				  									<xsl:value-of select="$VNrRefDest"/>
				  								</xsl:when>
					  							<xsl:otherwise>
				  									<xsl:text>.</xsl:text> 
				  								</xsl:otherwise>
			  								</xsl:choose>
				  						</xsl:attribute>
	     							</xsl:element>
				  				</xsl:when>
	  						  	 
								<!-- Daca beneficiarul e trezoreria si nu e refuz de plata-->
			  				<xsl:when test="($VBeneficiar='TREZROB') and (string-length($VExplicatii)&gt;71)">	
			  					
			  					<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,71,30)" />
	     		      			<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,101,33)" />
	     		      			<xsl:variable name="VACinceaLinie" select="substring($VExplicatii,134,10)" />
	     		      			
			  						<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
			  											<xsl:attribute name="tagValue">
			  													<xsl:text>/ROC/</xsl:text>
			  													<xsl:value-of select="$VATreiaLinie"/>
			  													
			  													<xsl:if test="string-length($VAPatraLinie)&gt;0">
			  														<xsl:text>&#xA;</xsl:text>
			  														<xsl:text>//</xsl:text>
			  														<xsl:value-of select="$VAPatraLinie"/>
			  													</xsl:if>
			  													
			  													<xsl:if test="string-length($VACinceaLinie)&gt;0">
			  														<xsl:text>&#xA;</xsl:text>
			  														<xsl:text>//</xsl:text>
			  														<xsl:value-of select="$VACinceaLinie"/>
			  													</xsl:if>
			  													
			  											</xsl:attribute>
			  													
			  							</xsl:element>
				  				</xsl:when> 
				  				
				  				<!-- Daca beneficiarul e banca si nu e refuz de plata-->
				  				
			 					<xsl:when test="(not($VBeneficiar='TREZROB')) and(string-length($VExplicatii)&gt;100)">	
			  							<xsl:variable name="VACinceaLinie" select="substring($VExplicatii,136,35)" />
			  							<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
			  											<xsl:attribute name="tagValue">
			  												<xsl:text>/ROC/</xsl:text>
			  												<xsl:value-of select="$VACinceaLinie"/>
			  												<xsl:if test="string-length($VACinceaLinie)=0">
			  														<xsl:text>.</xsl:text>
			  												</xsl:if>
			  												  													
		  													<xsl:text>&#xA;</xsl:text>
		  													<xsl:text>//RFB/</xsl:text>
		     						
				  											<xsl:value-of select="$VNrDoc"/> 	 
	  														<xsl:if test="string-length($VNrDoc)=0">
	  															<xsl:text>.</xsl:text> 
	  														</xsl:if>
			  													
			  									</xsl:attribute>
			  													
			  							</xsl:element>
				  				</xsl:when>
				  				
				  				<!-- Daca e refuz de plata, adica in campul REFUZPL avem T  sau J --> 				
				  				</xsl:choose>
				
	  					
	  					<!-- sfarsit tag 72-->
	  					
	        		</xsl:element>
	     		
	    	</xsl:element>
	    			
	    </xsl:when>
    			
    			
   <!-- Message 202 -->
   <xsl:when test="$TheMessageType=string('202')">
    			
  		<xsl:element name="smt:MT{TIPMESAJ}"  namespace="urn:xmlns:SWIFTMTs">
     				
     		<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
     					
     		<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
     		
     			<xsl:attribute name="BlockIdentifier">
     				<xsl:value-of select="1"/>
     	 		</xsl:attribute>
     	 		
     		   <xsl:attribute name="ApplicationIdentifier">  
     		 		<xsl:text>F</xsl:text>
     		   </xsl:attribute>
     		    
    	      <xsl:attribute name="ServiceIdentifier">
     		 		<xsl:text>01</xsl:text>
     		   </xsl:attribute>
  	      	
  	      	<xsl:attribute name="SenderLT">
  	      		<!-- Doar pentru teste -->
     		 		<!--<xsl:text>RNCBROB0AXXX</xsl:text>-->
     		 		<xsl:value-of select="substring(BICPL,1,8)"/>
  		 				<xsl:text>AXXX</xsl:text>
     		   </xsl:attribute>
     			
     			<xsl:attribute name="SessionNumber">
     				<xsl:variable name="VSessionNumber" select="string('0000')" />   
     		 		<xsl:value-of select="$VSessionNumber"/>
     		   </xsl:attribute> 
     			
     			<xsl:attribute name="SequenceNumber">
     				<xsl:variable name="VSequenceNumber" select="string('.000000')" />  
     		 		<xsl:value-of select="$VSequenceNumber"/>
     		    </xsl:attribute>
     		    
     		</xsl:element> <!--End Basic Header -->
     		
     		<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics"> 
     		
     		 	
				<xsl:attribute name="MessageType">
	 				<xsl:value-of select="TIPMESAJ"/>
	      		</xsl:attribute>
     		   
     		      
     			<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
     			
    				<xsl:attribute name="BlockIdentifier">
     		 			<xsl:value-of select="2"/>
     		    	</xsl:attribute>
     		    	
     		    	<xsl:attribute name="IOIdentifier">
     		 			<xsl:text>I</xsl:text>
     		    	</xsl:attribute>
     		    	
     		    	<xsl:attribute name="ReceiverLT">
  		 				<xsl:value-of select="substring(BICBN,1,8)"/>
  		 				<xsl:text>XXXX</xsl:text>
     		      </xsl:attribute>
     		    	
     		    	
     		    	<xsl:attribute name="MessagePriority">
     		    		<xsl:variable name="VIMessagePriority" select="string('N')" />   
     		 			<xsl:value-of select="$VIMessagePriority"/>
     		    	</xsl:attribute>
     		    	
     		   </xsl:element> <!--End Application Input Header -->
     		      
     		</xsl:element><!--End Application Header -->
     		
     		
     		<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     		
     			<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     							<xsl:attribute name="tagValue">
     								<xsl:text>ROL</xsl:text>
     							</xsl:attribute>
     			</xsl:element>
     						
     			<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="TRAN"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:text>00</xsl:text>
     						<xsl:value-of select="PRB"/>
     					</xsl:attribute >
     				</xsl:element>
     			
     		</xsl:element>	<!--End User Header -->
     		
     		<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     		
     			<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
     				<xsl:attribute name="tagValue">
     					<xsl:value-of select="NRREF"/>
     				</xsl:attribute>
     			</xsl:element>
     				
     			<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
     				<xsl:attribute name="tagValue">
     					<xsl:value-of select="NRREFDEST"/>
     				</xsl:attribute>
     			</xsl:element>
     				
     			<!-- :32A:DATAPLATII_RON_SUMANT -->
				<xsl:element name="smt:tag32A" namespace="urn:xmlns:SWIFTMTs">
					
					<xsl:attribute name="tagValue">
						
  						<xsl:value-of select="DATAPLATII"/>		
  								
						<xsl:text>RON</xsl:text>

						<xsl:variable name="VSuma" select ="SUMANT" />
						<xsl:choose>
							<xsl:when test="contains($VSuma,'.')">
								<xsl:value-of select="substring-before($VSuma, '.')" />
								<xsl:if test="string-length(substring-before($VSuma, '.'))=0">
									<xsl:text>0</xsl:text>
								</xsl:if>
								<xsl:text>,</xsl:text> 
								<xsl:value-of select="substring-after($VSuma, '.')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$VSuma" />
								<xsl:text>,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
						
					</xsl:attribute>
  							
  				</xsl:element>	
     							
     			<xsl:element name="smt:tag58A" namespace="urn:xmlns:SWIFTMTs">
     				<xsl:attribute name="tagValue">
						<xsl:value-of select="substring(BICBN,1,8)"/>
     				</xsl:attribute>
     			</xsl:element>
     			
     			
     			<!--  Testez daca exista tagul 72 -->
     		
     			<xsl:variable name="VEnter"  select ="string('&#xA;')" />
     			
     			<xsl:variable name="VExplicatii" select="normalize-space(EXPLICATII)"/>
		     		
		     			
		     			
		     			<xsl:if test="string-length(normalize-space($VExplicatii))&gt;0">
		     			<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
		     				<xsl:attribute name="tagValue">
		     					<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,30)" />   
			     		      	<xsl:variable name="VADouaLinie" select="substring($VExplicatii,31,33)" /> 
			     		      	<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,64,33)" /> 
			     		      	<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,97,33)" /> 
			     		      	<xsl:variable name="VACinceaLinie" select="substring($VExplicatii,130,33)" /> 
			     		      	
			     		      	
			     		      <xsl:choose>	
			     		      	<xsl:when test="string-length($VExplicatii)&lt;31">
			     						<xsl:text>/BNF/</xsl:text>
			     						<xsl:value-of select="$VPrimaLinie"/>
			     					</xsl:when>	
			     					<xsl:when test="string-length($VExplicatii)&lt;64">
			     						<xsl:text>/BNF/</xsl:text>
			     						<xsl:value-of select="$VPrimaLinie"/>
			     						<xsl:value-of select="$VEnter"/>
			     						<xsl:text>//</xsl:text>
			     						<xsl:value-of select="$VADouaLinie"/>
			     					</xsl:when>
			     					<xsl:when test="string-length($VExplicatii)&lt;97">
			     						<xsl:text>/BNF/</xsl:text>
			     						<xsl:value-of select="$VPrimaLinie"/>
			     						<xsl:value-of select="$VEnter"/>
			     						<xsl:text>//</xsl:text>
			     						<xsl:value-of select="$VADouaLinie"/>
			     						<xsl:value-of select="$VEnter"/>
				     					<xsl:text>//</xsl:text>
				     					<xsl:value-of select="$VATreiaLinie"/>
			     					</xsl:when>
			     					<xsl:when test="string-length($VExplicatii)&lt;130">
				     						<xsl:text>/BNF/</xsl:text>
				     						<xsl:value-of select="$VPrimaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
				     						<xsl:value-of select="$VADouaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
				     						<xsl:value-of select="$VATreiaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
				     						<xsl:value-of select="$VAPatraLinie"/>
				     					</xsl:when>
				     					<xsl:otherwise>
				     						<xsl:text>/BNF/</xsl:text>
				     						<xsl:value-of select="$VPrimaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
				     						<xsl:value-of select="$VADouaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
				     						<xsl:value-of select="$VATreiaLinie"/>
				     						<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
			     							<xsl:value-of select="$VAPatraLinie"/>
			     							<xsl:value-of select="$VEnter"/>
				     						<xsl:text>//</xsl:text>
			     							<xsl:value-of select="$VACinceaLinie"/>
				     					</xsl:otherwise>
								</xsl:choose>
		     				
		     				</xsl:attribute>
		     			</xsl:element>
		     		</xsl:if>
		     						
     		</xsl:element> <!--End MessageText -->
     		
    	</xsl:element>	<!--End MT202 -->
    	</xsl:when>
    	
    	<!-- Message 102 -->
			<xsl:when test="$TheMessageType=string('102')">
            
											<xsl:element name="smt:MT{$TheMessageType}E"  namespace="urn:xmlns:SWIFTMTs">
						
											<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
						
											<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
						
												<xsl:attribute name="BlockIdentifier">
													<xsl:value-of select="1"/>
												</xsl:attribute>
						
												<xsl:attribute name="ApplicationIdentifier">
													<xsl:text>F</xsl:text>
												</xsl:attribute>
						
												<xsl:attribute name="ServiceIdentifier">
													<xsl:text>01</xsl:text>
												</xsl:attribute>
						
												<xsl:attribute name="SenderLT">
													<xsl:value-of select="substring(BICPL,1,8)"/>
	 												<xsl:text>AXXX</xsl:text>		
												</xsl:attribute>
						
												<xsl:attribute name="SessionNumber">
													<xsl:value-of select="'0000'"/>
												</xsl:attribute>
						
												<xsl:attribute name="SequenceNumber">
													<xsl:value-of select="'.000000'"/>
												</xsl:attribute>
						
											</xsl:element>
											<!--End Basic Header -->
						
											<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics">
						
												<xsl:attribute name="MessageType">
													<xsl:value-of select="'102E'"/>
												</xsl:attribute>
						
						
												<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
						
													<xsl:attribute name="BlockIdentifier">
														<xsl:value-of select="2"/>
													</xsl:attribute>
						
													<xsl:attribute name="IOIdentifier">
														<xsl:text>I</xsl:text>
													</xsl:attribute>
						
													<xsl:attribute name="ReceiverLT">
														<xsl:value-of select="substring(BICBN,1,8)"/>
  		 												<xsl:text>XXXX</xsl:text>
													</xsl:attribute>
						
													<xsl:attribute name="MessagePriority">
														<xsl:value-of select="'N'"/>
													</xsl:attribute>
						
												</xsl:element>
												<!--End Application Input Header -->
						
											</xsl:element>
											<!--End Application Header -->
						
											<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
						
												<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
													<xsl:attribute name="tagValue">
														<xsl:text>ROL</xsl:text>
													</xsl:attribute>
												</xsl:element>
						
												<!-- TRAN -->
												<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
													<xsl:attribute name="tagValue">
														<xsl:value-of select="TRAN"/>
													</xsl:attribute>
												</xsl:element>
						
												<!-- PRIORITATE BANCARA -->
												<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
													<xsl:attribute name="tagValue">
														<xsl:text>00</xsl:text>
														<xsl:value-of select="PRB"/>
													</xsl:attribute >
												</xsl:element>
						
											</xsl:element>
											<!--End User Header -->
						
											<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
						
												
												
												<!-- :30:DATAPLATII -->
												<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
													
													<xsl:attribute name="tagValue">
														
							     						<xsl:value-of select="DATAPLATII"/>		
							     																				
													</xsl:attribute>
							     							
							     				</xsl:element>
												
												<!-- :21:<NRREF> -->
												<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
													<xsl:attribute name="tagValue">
														<xsl:value-of select="NRREF"/>
													</xsl:attribute>
												</xsl:element>
						
												<!-- :32B: RON<SEPSUMA>	-->
												<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						
														<xsl:attribute name="tagValue">
																						
															<xsl:text>RON</xsl:text>
							
															<xsl:variable name="VSuma" select="substring(SUMANT,1,15)"/>
															<xsl:choose>
																<xsl:when test="contains($VSuma,'.')">
																	<xsl:value-of select="substring-before($VSuma, '.')" />
																	<xsl:if test="string-length(substring-before($VSuma, '.'))=0">
																		<xsl:text>0</xsl:text>
																	</xsl:if>
																	<xsl:text>,</xsl:text> 
																	<xsl:value-of select="substring-after($VSuma, '.')" />
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$VSuma" />
																	<xsl:text>,</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
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
														
														<xsl:text>/</xsl:text>
														<!-- Daca IBANPL este NULL se pune . -->						
														<xsl:variable name="VContPl" select="IBANPL" /> 
														<xsl:choose> 
															<xsl:when test="string-length($VContPl)&gt;0">
																<xsl:value-of select="$VContPl"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
														<xsl:value-of select="$VEnter"/> 
														
														<!-- Daca NUMEPL este NULL se pune . -->
														<xsl:variable name="VNumePl" select="NUMEPL" />  
														<xsl:choose>
															<xsl:when test="string-length($VNumePl)&gt;0">
																<xsl:value-of select="$VNumePl"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														
														</xsl:choose>
														<xsl:value-of select="$VEnter"/> 
														
														<!-- Daca ADRESAPL1 este NULL se pune . -->
														<xsl:variable name="VAdresaPl1" select="substring(ADRESAPL,1,35)" /> 
														<xsl:choose>
															<xsl:when test="string-length($VAdresaPl1)&gt;0">
																<xsl:value-of select="$VAdresaPl1"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
								
														<xsl:value-of select="$VEnter"/> 
								      				
								      				<!-- Daca ADRESAPL2 este NULL se pune . -->
														<xsl:variable name="VAdresaPl2" select="substring(ADRESAPL,36,35)" />  
														<xsl:choose>
															<xsl:when test="string-length($VAdresaPl2)&gt;0">
																<xsl:value-of select="$VAdresaPl2"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
														
														<xsl:value-of select="$VEnter"/> 
								      		
								      					
								      				<!-- Daca CODPL este NULL se pune . -->
														<xsl:variable name="VCodPl" select="CODPL" />  
														<xsl:choose>
															<xsl:when test="string-length($VCodPl)&gt;0">
																<xsl:value-of select="$VCodPl"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text>
															</xsl:otherwise>
														</xsl:choose>
													
							  						</xsl:attribute>
							  					</xsl:element>
							     				
							     				
							  					<!-- :59K:/IBANBN			sau /. (daca e NULL)
							  							  	 NUMEBN         			sau .
							  							  	 ADRESABN					sau .
							  							    ADRESABN (continuare) 	sau .
							  							    CODBN						sau .
							  								  
							  						-->
							  					<xsl:element name="smt:tag59" namespace="urn:xmlns:SWIFTMTs">
							  						<xsl:attribute name="tagValue">
							  							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							     						
							     						<xsl:text>/</xsl:text>
							  							<!-- Daca IBANBN este NULL se pune . -->
							  							<xsl:variable name="VContBn" select="IBANBN" />  
							  							<xsl:choose> 
															<xsl:when test="string-length($VContBn)&gt;0">
																<xsl:value-of select="$VContBn"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
							  							<xsl:value-of select="$VEnter"/> 
							     								
							  							<!-- Daca NUMEBN este NULL se pune . -->
							  							<xsl:variable name="VNumeBn" select="NUMEBN" />  
							  							<xsl:choose> 
															<xsl:when test="string-length($VNumeBn)&gt;0">
																<xsl:value-of select="$VNumeBn"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
							  							<xsl:value-of select="$VEnter"/> 
							     								
							  							<!-- Daca ADRESABN1 este NULL se pune . -->
														<xsl:variable name="VAdresaBn1" select="substring(ADRESABN,1,35)" />  
														<xsl:choose> 
															<xsl:when test="string-length($VAdresaBn1)&gt;0">
																<xsl:value-of select="$VAdresaBn1"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
														<xsl:value-of select="$VEnter"/> 
								      				
								      				<!-- Daca ADRESABN2 este NULL se pune . -->
														<xsl:variable name="VAdresaBn2" select="substring(ADRESABN,36,35)" />  
														<xsl:choose> 
															<xsl:when test="string-length($VAdresaBn2)&gt;0">
																<xsl:value-of select="$VAdresaBn2"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
														
														<xsl:value-of select="$VEnter"/> 
							  		      					      					
							  		      			<!-- Daca CODBN este NULL se pune . -->
							  							<xsl:variable name="VCodBn" select="CODBN" />  
							  							<xsl:choose> 
															<xsl:when test="string-length($VCodBn)&gt;0">
																<xsl:value-of select="$VCodBn"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:text>.</xsl:text> 
															</xsl:otherwise>
														</xsl:choose>
							     							
							     							
								     				</xsl:attribute>
								     			 </xsl:element>
								     			 
								     			 
															     			 	<!-- 
							     						
							     							Daca BICBN='TREZROB'
							     						
							     								70:	/ROC/<NRCRBUG>
							     										//RFB/<NRDOC>/<DATADOC>/<DATADOC>
							     										<EXPLICATII>	
							     										<EXPLICATII>	
							     										
							     							Altfel
							     										/ROC/<EXPLICATII>		
							     										<EXPLICATII>				    . 
							     						    			<EXPLICATII>
							     						  				//RFB/<NRDOC>	
							     						  
							     				-->
							     				<xsl:variable name="VExplicatii" select="normalize-space(EXPLICATII)" /> 
							     				<xsl:variable name="VNrDoc" select="NRDOC" />		  		  
							     				<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
							     					<xsl:attribute name="tagValue">
							     					
							     						<xsl:variable name="VBeneficiar"  select ="substring(BICBN,1,7)" />
							     							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							     							
							     							<xsl:choose>
							     							<!-- Daca e pentru trezorerie -->
							     							<xsl:when test=" $VBeneficiar='TREZROB' ">
							     							
							     								<xsl:text>/ROC/</xsl:text>
							     								<xsl:variable name="VCreanta" select="NRCRBUG" /> 	
							     								<xsl:choose>
							     									<xsl:when test="string-length($VCreanta)&gt;0">
										  								<xsl:value-of select="$VCreanta"/>
										  							</xsl:when> 
									  								<xsl:otherwise>
									  									<xsl:text>.</xsl:text> 
									  								</xsl:otherwise>
										  						</xsl:choose>
									  							
									  							<xsl:value-of select="$VEnter"/>
									  							
									  							<xsl:text>/RFB/</xsl:text>
									  						 
									  							<xsl:choose>	
									  								<xsl:when test="string-length($VNrDoc)&gt;0">
										  								<xsl:value-of select="$VNrDoc"/>
										  							</xsl:when> 
									  								<xsl:otherwise>
									  									<xsl:text>.</xsl:text> 
									  								</xsl:otherwise>
										  						</xsl:choose>
										  						
									  							<xsl:text>/</xsl:text>
									  							
									  							<xsl:variable name="VDataDoc" select="DATADOC" /> 	
									  							<xsl:choose> 
										  							<xsl:when test="string-length($VDataDoc)&gt;0">
										  								<xsl:text>20</xsl:text>
										  								<xsl:value-of select="$VDataDoc"/>
										  							</xsl:when>
									  								<xsl:otherwise>
									  									<xsl:text>.</xsl:text> 
									  								</xsl:otherwise>
									  							</xsl:choose>
							 							
									  							<xsl:text>/</xsl:text>
									  							
									  							
									  							<xsl:choose>	 
										  							<xsl:when test="string-length($VDataDoc)&gt;0">
										  								<xsl:text>20</xsl:text>
										  								<xsl:value-of select="$VDataDoc"/>
										  							</xsl:when>
									  								<xsl:otherwise>
									  									<xsl:text>.</xsl:text> 
									  								</xsl:otherwise>
									  							</xsl:choose>
										
									  							
									  						
									  						 
									  							<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,35)" />   
								     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,36,35)" />
								     		      		
								     		      			<xsl:choose>	
								     		      				<xsl:when test="string-length($VExplicatii)&gt;35">
								     		      					<xsl:value-of select="$VEnter"/>
									     		      				<xsl:value-of select="$VPrimaLinie"/>
									     		      				<xsl:value-of select="$VEnter"/>
									     		      				<xsl:value-of select="$VADouaLinie"/>
									     		      			</xsl:when>
									     		      			<xsl:when test="(string-length($VExplicatii)&lt;36) and (string-length($VExplicatii)&gt;0)">
									     		      				<xsl:value-of select="$VEnter"/>
									     		      				<xsl:value-of select="$VPrimaLinie"/>
									     		      			</xsl:when>
									     		      		</xsl:choose>
									  										
									  						</xsl:when>
									  							
									  						<!-- Daca beneficiarul e banca -->
									  						<xsl:otherwise>	
									  							
									  						  
									  							<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,30)" />   
								     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,31,35)" />
								     		      			<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,66,35)" />
								     		      			<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,101,35)" />
								     		      			
								     		      			
								     		      			<xsl:text>/ROC/</xsl:text>	
								     		      			<xsl:choose>
								     		      				
								     		      				<!-- se testeaza daca avem o singura linie de explicatii-->
								     		      					<xsl:when test="string-length($VExplicatii)&lt;31">
								     		      						<xsl:value-of select="$VPrimaLinie"/>
									     		      					<xsl:if test="string-length($VPrimaLinie)=0">
									     										<xsl:value-of select="'.'"/>
									     									</xsl:if>
									     									<xsl:value-of select="$VEnter"/>
									     								
									     									<xsl:text>//RFB/</xsl:text>
									     						
											  								<xsl:value-of select="$VNrDoc"/> 	 
								  											<xsl:if test="string-length($VNrDoc)=0">
								  												<xsl:value-of select="'.'"/> 
								  											</xsl:if>
								     		      					
								     		      					</xsl:when>
								     		      					
								     		      					<!-- se testeaza daca avem doua linii de explicatii-->
								     		      					<xsl:when test="string-length($VExplicatii)&lt;66">
								     		      						
								     		      						<xsl:value-of select="$VPrimaLinie"/>
									     									<xsl:value-of select="$VEnter"/>
									     									
									     									<xsl:value-of select="$VADouaLinie"/>	
									     									<xsl:value-of select="$VEnter"/>
																			
																			<xsl:text>//RFB/</xsl:text>
																			
											  								<xsl:value-of select="$VNrDoc"/> 	 
								  												<xsl:if test="string-length($VNrDoc)=0">
								  												<xsl:value-of select="'.'"/> 
								  											</xsl:if>
								     		      					
								     		      					<!-- se testeaza daca avem trei linii de explicatii-->
								     		      					</xsl:when>
								     		      					
								     		      					<xsl:when test="string-length($VExplicatii)&lt;101">
								     		      						
								     		      						<xsl:value-of select="$VPrimaLinie"/>
									     		      					<xsl:value-of select="$VEnter"/>
									     									
									     									<xsl:value-of select="$VADouaLinie"/>
									     		      					<xsl:value-of select="$VEnter"/>
									     									
									     									<xsl:value-of select="$VATreiaLinie"/>
									     		      					<xsl:value-of select="$VEnter"/>
									     								
									     									<xsl:text>//RFB/</xsl:text>
									     	
											  								<xsl:value-of select="$VNrDoc"/> 	 
								  												<xsl:if test="string-length($VNrDoc)=0">
								  												<xsl:text>.</xsl:text> 
								  											</xsl:if>
								     		      					
								     		      					</xsl:when>
								     		      					
								     		      					<!-- varianta default cand avem cel putin patru linii de explicatii-->
								     		      					<xsl:otherwise>
								     		      						
								     		      						
								     		      						<xsl:value-of select="$VPrimaLinie"/>
									     									<xsl:value-of select="$VEnter"/>
									     									
									     									<xsl:value-of select="$VADouaLinie"/>				
									     									<xsl:value-of select="$VEnter"/>
									     									
									     									<xsl:value-of select="$VATreiaLinie"/>
									     									<xsl:value-of select="$VEnter"/>
									     								
									     									<xsl:value-of select="$VAPatraLinie"/>
									     		      					
									     										     		      					
								     		      					</xsl:otherwise>
								     		      					
								     		      					
								     		      				</xsl:choose>
									     											
											  				</xsl:otherwise>
											  			</xsl:choose>
							     					</xsl:attribute>
							     				</xsl:element>
																			
												


											</xsl:element>
											<!--End MessageText -->
																	
										</xsl:element>
									
								
									<!--End MT102E -->
						
			
				</xsl:when>
				
				<xsl:when test="($TheMessageType=string('104')) and (not(contains(REFUZPL,'N')))">
				
				<!-- Direct Debit Refusal 		-->
							<!-- MT104R                     -->
							<xsl:element name="smt:MT104R"  namespace="urn:xmlns:SWIFTMTs">

								<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>

								<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
									<xsl:attribute name="BlockIdentifier">
										<xsl:value-of select="1"/>
									</xsl:attribute>
									<xsl:attribute name="ApplicationIdentifier">
										<xsl:text>F</xsl:text>
									</xsl:attribute>
									<xsl:attribute name="ServiceIdentifier">
										<xsl:text>01</xsl:text>
									</xsl:attribute>
									<xsl:attribute name="SenderLT">
										<!-- Este comentat doar pentru teste pentru a putea ajunge la noi in alliance-->
										<!-- TODO:  BIC TEST CLIENT -->
										<xsl:value-of select="substring(BICPL,1,8)"/>
	 									<xsl:text>AXXX</xsl:text>
									</xsl:attribute>
									<xsl:attribute name="SessionNumber">
										<xsl:text>0000</xsl:text>
									</xsl:attribute>
									<xsl:attribute name="SequenceNumber">
										<xsl:text>000000</xsl:text>
									</xsl:attribute>
								</xsl:element>
								<!--End Basic Header -->

								<xsl:element name="sg:ApplicationHeader" namespace="urn:xmlns:SWIFTgenerics">
									<xsl:attribute name="MessageType">
										<xsl:text>104R</xsl:text>
									</xsl:attribute>
									<xsl:element name="sg:ApplicationHeaderInput" namespace="urn:xmlns:SWIFTgenerics">
										<xsl:attribute name="BlockIdentifier">
											<xsl:value-of select="2"/>
										</xsl:attribute>
										<xsl:attribute name="IOIdentifier">
											<xsl:text>I</xsl:text>
										</xsl:attribute>
										<!-- BICuri pentru teste -->
										<xsl:attribute name="ReceiverLT">
											<xsl:value-of select="substring(BICBN,1,8)"/>
     		 								<xsl:text>XXXX</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="MessagePriority">
											<xsl:text>N</xsl:text>
										</xsl:attribute>
									</xsl:element>
									<!--End Application Input Header -->
								</xsl:element>
								<!--End Application Header -->

								<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
									<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
										<xsl:attribute name="tagValue">
											<xsl:text>ROL</xsl:text>
										</xsl:attribute>
									</xsl:element>
									<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
										<xsl:attribute name="tagValue">
											<xsl:value-of select="NRREFDEST"/>
										</xsl:attribute>
									</xsl:element>
									<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
										<xsl:attribute name="tagValue">
											<xsl:text>00</xsl:text>
     										<xsl:value-of select="PRB"/>
										</xsl:attribute >
									</xsl:element>
								</xsl:element>
								<!--End User Header -->
								<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
									<!-- :20:NRREF -->
									<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:value-of select="NRREF"/>
										</xsl:attribute>
									</xsl:element>
									<!-- :21:NRREFDEST -->
									<xsl:element name="smt:tag21" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:value-of select="IDGRP"/>
										</xsl:attribute>
									</xsl:element>
									
									<!-- :30:DATAPLATII-->
									<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:value-of select="DATAPLATII"/>
										</xsl:attribute>
									</xsl:element>
									
									
									<!-- :32B:RON0-->
									<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:text>RON0</xsl:text>
										</xsl:attribute>
									</xsl:element>
									<!-- :59A:DDIBICBF-->
									<xsl:element name="smt:tag59A" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:value-of select="BICBN"/>
										</xsl:attribute>
									</xsl:element>
									
									<!-- :70:DDIDET1
													DDIDET2
										-->
									<xsl:variable name="VRefuzPlata" select ="REFUZPL" />
									
									
									<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
										<xsl:attribute name="tagValue">
											<xsl:variable name="VDetErr" select="DETERR" />
											<xsl:variable name="VTagEroare" select="TAGEROARE" />
											
											
											<xsl:value-of select="substring($VTagEroare,1,35)"/>
											<xsl:value-of select="'&#xA;'"/>
											<xsl:value-of select="substring($VDetErr,1,35)"/>
											
											
												
												
													
												
											</xsl:attribute>
										</xsl:element>
								

								</xsl:element>
								<!-- End MessageText -->
							</xsl:element> <!-- smt:MT104R -->
							
					</xsl:when>
					
					<!-- MT104 -->
		<xsl:when test="$TheMessageType=string('104')">
    			
			<xsl:element name="smt:MT{TIPMESAJ}"  namespace="urn:xmlns:SWIFTMTs">
			
				<xsl:element name="sg:AckNack" namespace="urn:xmlns:SWIFTgenerics"/>
				
				<xsl:element name="sg:BasicHeader" namespace="urn:xmlns:SWIFTgenerics">
				
					<xsl:attribute name="BlockIdentifier">
	 					<xsl:value-of select="1"/>
	      			</xsl:attribute>
	      			
	     			<xsl:attribute name="ApplicationIdentifier">
	 					<xsl:text>F</xsl:text>
	      			</xsl:attribute>
	      			
		   			<xsl:attribute name="ServiceIdentifier">
		 					<xsl:text>01</xsl:text>
		      		</xsl:attribute>
	      			
					<xsl:attribute name="SenderLT">
						<!-- Este comentat doar pentru teste pentru a putea ajunge la noi in alliance-->
						<!-- TODO:  BIC TEST CLIENT -->
	 					<!--<xsl:text>RNCBROB0AXXX</xsl:text> -->
	 					<xsl:value-of select="substring(BICBN,1,8)"/>
	 					<xsl:text>AXXX</xsl:text>
					</xsl:attribute>
	      			
					<xsl:attribute name="SessionNumber">
	 					<xsl:text>0000</xsl:text>
	      			</xsl:attribute> 
	      			
					<xsl:attribute name="SequenceNumber">
	 					<xsl:text>000000</xsl:text>
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
	     		 				<xsl:text>I</xsl:text>
	     		      	</xsl:attribute>
	     		      				
	     		      	<xsl:attribute name="ReceiverLT">
     		 				<xsl:value-of select="substring(BICPL,1,8)"/>
     		 				<xsl:text>XXXX</xsl:text>
	     		      	</xsl:attribute>
     		      				
	     		      	<xsl:attribute name="MessagePriority">
	     		 			<xsl:text>N</xsl:text>
	     		      	</xsl:attribute>
     		      				
     		      	</xsl:element> <!--End Application Input Header -->
     		      
     			</xsl:element><!--End Application Header -->
     		
     			<xsl:element name="sg:UserHeader" namespace="urn:xmlns:SWIFTgenerics">
     					
     				<xsl:element name="sg:tag103" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:text>ROL</xsl:text>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag108" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:value-of select="TRAN"/>
     					</xsl:attribute>
     				</xsl:element>
     						
     				<xsl:element name="sg:tag113" namespace="urn:xmlns:SWIFTgenerics">
     					<xsl:attribute name="tagValue">
     						<xsl:text>00</xsl:text>
     						<xsl:value-of select="PRB"/>
     					</xsl:attribute >
     				</xsl:element>
     						
     			</xsl:element>	<!--End User Header -->
     		
     			<xsl:element name="smt:MessageText" namespace="urn:xmlns:SWIFTMTs">
     		
     				<!-- :20:NRREF -->
     						
					<xsl:element name="smt:tag20" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="NRREF"/>
						</xsl:attribute>
					</xsl:element>
     		   				   				
     					<!-- :30:DATAPLATII -->
     						
					<xsl:element name="smt:tag30" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:value-of select="DATAPLATII"/>
						</xsl:attribute>
					</xsl:element>
					
     				<!-- :32B:RON_SUMANT -->
					<xsl:element name="smt:tag32B" namespace="urn:xmlns:SWIFTMTs">
						
						<xsl:attribute name="tagValue">			
     								
							<xsl:text>RON</xsl:text>
	
							<xsl:variable name="VSuma" select ="SUMANT" />
							
							<xsl:choose>
								<xsl:when test="contains($VSuma,'.')">
									<xsl:value-of select="substring-before($VSuma, '.')" />
									<xsl:if test="string-length(substring-before($VSuma, '.'))=0">
											<xsl:text>0</xsl:text>
									</xsl:if>
									<xsl:text>,</xsl:text> 
									<xsl:value-of select="substring-after($VSuma, '.')" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$VSuma" />
									<xsl:text>,</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
						</xsl:attribute>
     							
     				</xsl:element>
     				
     				
     				
					<!-- :59:
							    /BANBN			sau /. (daca e NULL)
  							  	 NUMEBN         			sau .
  							  	 ADRESABN					sau .
  							    ADRESABN (continuare) 	sau .
  							    CODBN						sau .
							  
					-->
					<xsl:element name="smt:tag50K" namespace="urn:xmlns:SWIFTMTs">
						<xsl:attribute name="tagValue">
							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
							
							<xsl:text>/</xsl:text>
							<!-- Daca IBANPL este NULL se pune . -->						
							<xsl:variable name="VContBn" select="IBANBN" /> 
							<xsl:choose> 
								<xsl:when test="string-length($VContBn)&gt;0">
									<xsl:value-of select="$VContBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca NUMEPL este NULL se pune . -->
							<xsl:variable name="VNumeBn" select="NUMEBN" />  
							<xsl:choose>
								<xsl:when test="string-length($VNumeBn)&gt;0">
									<xsl:value-of select="$VNumeBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							
							</xsl:choose>
							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca ADRESAPL1 este NULL se pune . -->
							<xsl:variable name="VAdresaBn1" select="substring(ADRESABN,1,35)" /> 
							<xsl:choose>
								<xsl:when test="string-length($VAdresaBn1)&gt;0">
									<xsl:value-of select="$VAdresaBn1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
	
							<xsl:value-of select="$VEnter"/> 
	      				
	      				<!-- Daca ADRESAPL2 este NULL se pune . -->
							<xsl:variable name="VAdresaBn2" select="substring(ADRESABN,36,35)" />  
							<xsl:choose>
								<xsl:when test="string-length($VAdresaBn2)&gt;0">
									<xsl:value-of select="$VAdresaBn2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
	      		
	      					
	      				<!-- Daca CODPL este NULL se pune . -->
							<xsl:variable name="VCodBn" select="CODBN" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodBn)&gt;0">
									<xsl:value-of select="$VCodBn"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						
  						</xsl:attribute>
  					</xsl:element>
     				
     				
  					<!-- :50K:  							    
  							    IBANPL		sau /. (daca e NULL)
							  	 NUMEPL         			sau .
							    ADRESAPL					sau .
							    ADRESAPL (continuare) 	sau .
							    CODPL			      	sau .
  								  
  						-->
  					<xsl:element name="smt:tag59" namespace="urn:xmlns:SWIFTMTs">
  						<xsl:attribute name="tagValue">
  							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
     						
     						<xsl:text>/</xsl:text>
  							<!-- Daca IBANBN este NULL se pune . -->
  							<xsl:variable name="VContPl" select="IBANPL" />  
  							<xsl:choose> 
								<xsl:when test="string-length($VContPl)&gt;0">
									<xsl:value-of select="$VContPl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
  							<xsl:value-of select="$VEnter"/> 
     								
  							<!-- Daca NUMEBN este NULL se pune . -->
  							<xsl:variable name="VNumePl" select="NUMEPL" />  
  							<xsl:choose> 
								<xsl:when test="string-length($VNumePl)&gt;0">
									<xsl:value-of select="$VNumePl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text> 
								</xsl:otherwise>
							</xsl:choose>
  						
  							<xsl:value-of select="$VEnter"/> 
							
							<!-- Daca ADRESAPL1 este NULL se pune . -->
							<xsl:variable name="VAdresaPl1" select="substring(ADRESAPL,1,35)" /> 
							<xsl:choose>
								<xsl:when test="string-length($VAdresaPl1)&gt;0">
									<xsl:value-of select="$VAdresaPl1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
	
							<xsl:value-of select="$VEnter"/> 
	      				
	      				<!-- Daca ADRESAPL2 este NULL se pune . -->
							<xsl:variable name="VAdresaPl2" select="substring(ADRESAPL,36,35)" />  
							<xsl:choose>
								<xsl:when test="string-length($VAdresaPl2)&gt;0">
									<xsl:value-of select="$VAdresaPl2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:value-of select="$VEnter"/> 
	      		
	      					
	      				<!-- Daca CODPL este NULL se pune . -->
							<xsl:variable name="VCodPl" select="CODPL" />  
							<xsl:choose>
								<xsl:when test="string-length($VCodPl)&gt;0">
									<xsl:value-of select="$VCodPl"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>.</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
     						
     							
     							
	     				</xsl:attribute>
	     			 </xsl:element>
     				
     				<!-- 
     						
     							Daca BICBN='TREZROB'
     						
     								70:	/ROC/<NRCRBUG>
     										//RFB/<NRDOC>/<DATADOC>/<DATAPLATII>
     										<EXPLICATII>	
     										<EXPLICATII>	
     										
     							Altfel
     										/ROC/<EXPLICATII>		
     										<EXPLICATII>				    . 
     						    			<EXPLICATII>
     						  				//RFB/<NRDOC>	
     						  
     				-->
     				<xsl:variable name="VExplicatii" select="normalize-space(EXPLICATII)" /> 
     				<xsl:variable name="VNrDoc" select="NRDOC" />		  		  
     				<xsl:element name="smt:tag70" namespace="urn:xmlns:SWIFTMTs">
     					<xsl:attribute name="tagValue">
     					
     						<xsl:variable name="VBeneficiar"  select ="substring(BICPL,1,7)" />
     							<xsl:variable name="VEnter"  select ="string('&#xA;')" />
     							
     							<xsl:choose>
     							<!-- Daca e pentru trezorerie -->
     							<xsl:when test=" $VBeneficiar='TREZROB' ">
     							
     								<xsl:text>/ROC/</xsl:text>
     								<xsl:variable name="VCreanta" select="NRCRBUG" /> 	
     								<xsl:choose>
     									<xsl:when test="string-length($VCreanta)&gt;0">
			  								<xsl:value-of select="$VCreanta"/>
			  							</xsl:when> 
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
			  						</xsl:choose>
		  							
		  							<xsl:value-of select="$VEnter"/>
		  							
		  							<xsl:text>/RFB/</xsl:text>
		  						 
		  							<xsl:choose>	
		  								<xsl:when test="string-length($VNrDoc)&gt;0">
			  								<xsl:value-of select="$VNrDoc"/>
			  							</xsl:when> 
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
			  						</xsl:choose>
			  						
		  							<xsl:text>/</xsl:text>
		  							
		  							<xsl:variable name="VDataDoc" select="DATADOC" /> 	
		  							<xsl:choose> 
			  							<xsl:when test="string-length($VDataDoc)&gt;0">
			  								<xsl:text>20</xsl:text>
			  								<xsl:value-of select="$VDataDoc"/>
			  							</xsl:when>
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
		  							</xsl:choose>
 							
		  							<xsl:text>/</xsl:text>
		  							
		  							<xsl:choose>	 
			  							<xsl:when test="string-length($VDataDoc)&gt;0">
			  								<xsl:text>20</xsl:text>
			  								<xsl:value-of select="$VDataDoc"/>
			  							</xsl:when>
		  								<xsl:otherwise>
		  									<xsl:text>.</xsl:text> 
		  								</xsl:otherwise>
		  							</xsl:choose>					  									  						
		  						 
		  							<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,35)" />   
	     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,36,35)" />
	     		      		
	     		      			<xsl:choose>	
	     		      				<xsl:when test="string-length($VExplicatii)&gt;35">
	     		      					<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VPrimaLinie"/>
		     		      				<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VADouaLinie"/>
		     		      			</xsl:when>
		     		      			<xsl:when test="(string-length($VExplicatii)&lt;36) and (string-length($VExplicatii)&gt;0)">
		     		      				<xsl:value-of select="$VEnter"/>
		     		      				<xsl:value-of select="$VPrimaLinie"/>
		     		      			</xsl:when>
		     		      		</xsl:choose>
		  										
		  						</xsl:when>
		  							
		  						<!-- Daca beneficiarul e banca -->
		  						<xsl:otherwise>	
		  							
		  						  
		  							<xsl:variable name="VPrimaLinie" select="substring($VExplicatii,1,30)" />   
	     		      			<xsl:variable name="VADouaLinie" select="substring($VExplicatii,31,35)" />
	     		      			<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,66,35)" />
	     		      			<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,101,35)" />
	     		      			
	     		      			
	     		      			<xsl:text>/ROC/</xsl:text>	
	     		      			<xsl:choose>
	     		      				
	     		      				<!-- se testeaza daca avem o singura linie de explicatii-->
	     		      					<xsl:when test="string-length($VExplicatii)&lt;31">
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     		      					<xsl:if test="string-length($VPrimaLinie)=0">
		     										<xsl:value-of select="'.'"/>
		     									</xsl:if>
		     									<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:text>//RFB/</xsl:text>
		     						
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  											<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:value-of select="'.'"/> 
	  											</xsl:if>
	     		      					
	     		      					</xsl:when>
	     		      					
	     		      					<!-- se testeaza daca avem doua linii de explicatii-->
	     		      					<xsl:when test="string-length($VExplicatii)&lt;66">
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>	
		     									<xsl:value-of select="$VEnter"/>
												
												<xsl:text>//RFB/</xsl:text>
												
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  												<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:value-of select="'.'"/> 
	  											</xsl:if>
	     		      					
	     		      					<!-- se testeaza daca avem trei linii de explicatii-->
	     		      					</xsl:when>
	     		      					
	     		      					<xsl:when test="string-length($VExplicatii)&lt;101">
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VATreiaLinie"/>
		     		      					<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:text>//RFB/</xsl:text>
		     	
				  								<xsl:value-of select="$VNrDoc"/> 	 
	  												<xsl:if test="string-length($VNrDoc)=0">
	  												<xsl:text>.</xsl:text> 
	  											</xsl:if>
	     		      					
	     		      					</xsl:when>
	     		      					
	     		      					<!-- varianta default cand avem cel putin patru linii de explicatii-->
	     		      					<xsl:otherwise>
	     		      						
	     		      						
	     		      						<xsl:value-of select="$VPrimaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VADouaLinie"/>				
		     									<xsl:value-of select="$VEnter"/>
		     									
		     									<xsl:value-of select="$VATreiaLinie"/>
		     									<xsl:value-of select="$VEnter"/>
		     								
		     									<xsl:value-of select="$VAPatraLinie"/>
		     		      					
		     										     		      					
	     		      					</xsl:otherwise>
	     		      					
	     		      					
	     		      				</xsl:choose>
		     											
				  				</xsl:otherwise>
				  			</xsl:choose>
     					</xsl:attribute>
     				</xsl:element>
	     				
	     					<!--  :71A:SHA -->
	     				
		     				<xsl:element name="smt:tag71A" namespace="urn:xmlns:SWIFTMTs">
		     					<xsl:attribute name="tagValue">
		     						<xsl:value-of select="TIPCMS"/>
		     					</xsl:attribute>
		     				</xsl:element>	   					
	   				  					
	  					<!-- :72: -->
	   				<xsl:variable name="VBeneficiar"  select ="substring(BICPL,1,7)" /> 	 					
						<xsl:choose> 							
	  									
			  				<xsl:when test="($VBeneficiar='TREZROB') and (string-length($VExplicatii)&gt;71)">	
			  					
			  						<xsl:variable name="VATreiaLinie" select="substring($VExplicatii,71,30)" />
	     		      			<xsl:variable name="VAPatraLinie" select="substring($VExplicatii,101,33)" />
	     		      			<xsl:variable name="VACinceaLinie" select="substring($VExplicatii,134,10)" />
	     		      			
			  						<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
			  											<xsl:attribute name="tagValue">
			  													<xsl:text>/ROC/</xsl:text>
			  													<xsl:value-of select="$VATreiaLinie"/>
			  													
			  													<xsl:if test="string-length($VAPatraLinie)&gt;0">
			  														<xsl:text>&#xA;</xsl:text>
			  														<xsl:text>//</xsl:text>
			  														<xsl:value-of select="$VAPatraLinie"/>
			  													</xsl:if>
			  													
			  													<xsl:if test="string-length($VACinceaLinie)&gt;0">
			  														<xsl:text>&#xA;</xsl:text>
			  														<xsl:text>//</xsl:text>
			  														<xsl:value-of select="$VACinceaLinie"/>
			  													</xsl:if>
			  													
			  											</xsl:attribute>
			  													
			  							</xsl:element>
				  				</xsl:when> 
				  				
				  				<!-- Daca beneficiarul e banca si nu e refuz de plata-->
				  				
			 					<xsl:when test="(not($VBeneficiar='TREZROB')) and(string-length($VExplicatii)&gt;100)">	
			  							<xsl:variable name="VACinceaLinie" select="substring($VExplicatii,136,35)" />
			  							<xsl:element name="smt:tag72" namespace="urn:xmlns:SWIFTMTs">
			  											<xsl:attribute name="tagValue">
			  												<xsl:text>/ROC/</xsl:text>
			  												<xsl:value-of select="$VACinceaLinie"/>
			  												<xsl:if test="string-length($VACinceaLinie)=0">
			  														<xsl:text>.</xsl:text>
			  												</xsl:if>
			  												  													
		  													<xsl:text>&#xA;</xsl:text>
		  													<xsl:text>//RFB/</xsl:text>
		     						
				  											<xsl:value-of select="$VNrDoc"/> 	 
	  														<xsl:if test="string-length($VNrDoc)=0">
	  															<xsl:text>.</xsl:text> 
	  														</xsl:if>
			  													
			  									</xsl:attribute>
			  													
			  							</xsl:element>
				  				</xsl:when>
				  				
				  			<!-- Daca e refuz de plata, adica in campul REFUZPL avem T  sau J --> 				
  							</xsl:choose>							  					
	  					
	  					<!-- sfarsit tag 72-->
	  					
	        		</xsl:element>
	     		
	    	</xsl:element>
	    			
	    </xsl:when>
				
    </xsl:choose>

</xsl:template>		
	
</xsl:stylesheet>
