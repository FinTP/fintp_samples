<?xml version="1.0"?>
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:smt="urn:xmlns:SWIFTMTs"
 xmlns:sg="urn:xmlns:SWIFTgenerics"
 xmlns:external="http://extensions.bisnet.ro"
 exclude-result-prefixes="external"
  >
	<xsl:output method="xml" encoding="us-ascii" />
	
	<xsl:param name="XSLTPARAMBATCHID"/>
	<xsl:param name="XSLTPARAMBATCHCOUNT"/>
	<xsl:param name="XSLTPARAMBATCHAMOUNT"/>
	<xsl:param name="XSLTPARAMDATE"/>
  
	<xsl:variable name="VEnter"  select ="string('&#xA;')" />
	
	<!-- 
	07.04.2014 Mesajul cu msgtype = CoreBlkLrgRmtCdtTrf (ACH) se comporta ca vechiul mesaj 103 ACH; 103 a fost inlocuit cu CoreBlkLrgRmtCdtTrf
		-->

	<!-- TESTE >
<xsl:param name="XSLTPARAMBATCHID" select="1"/> 
<xsl:param name="XSLTPARAMBATCHCOUNT" select="2"/> 
<xsl:param name="XSLTPARAMBATCHAMOUNT" select="123456.78"/> 
<xsl:param name="XSLTPARAMDATE" select="051014"/-->

	<xsl:template match="/">
		<xsl:variable name="VIsBatch" select="$XSLTPARAMBATCHCOUNT"/>

		<xsl:choose>

			<!-- no batchid, must be element -->
			<xsl:when test="string-length($VIsBatch)=0">
				<xsl:if test="smt:MTCoreBlkLrgRmtCdtTrf">
					<xsl:apply-templates/>
				</xsl:if>
				<xsl:if test="smt:MT104">
					<xsl:call-template name="MT104"/>
				</xsl:if>
				<xsl:if test="smt:MT104R">
					<xsl:call-template name="MT104R"/>
				</xsl:if>
				<xsl:if test="smt:MTCQ">
						<xsl:call-template name="MTCQ"/>
				</xsl:if>
				<xsl:if test="smt:MTPN">
						<xsl:call-template name="MTPN"/>
				</xsl:if>
				<xsl:if test="smt:MTBE">
						<xsl:call-template name="MTBE"/>
				</xsl:if>
				<xsl:if test="smt:MTRCQ">
						<xsl:call-template name="MTRCQ"/>
				</xsl:if>
				<xsl:if test="smt:MTRPN">
						<xsl:call-template name="MTRPN"/>
				</xsl:if>
				<xsl:if test="smt:MTRBE">
						<xsl:call-template name="MTRBE"/>
				</xsl:if>
				
			</xsl:when>

			<xsl:otherwise>
			
				<xsl:if test="smt:MTCoreBlkLrgRmtCdtTrf" >
					<xsl:element name="CoreBlkLrgRmtCdtTrf" xmlns="urn:swift:xsd:CoreBlkLrgRmtCdtTrf">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="$XSLTPARAMBATCHID"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="TtlSttlmAmt">
								<xsl:attribute name="Ccy">
									<xsl:value-of select=" 'RON' "/>
								</xsl:attribute>
								<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
							</xsl:element>
							<xsl:element name="IntrBkValDt">
								<!-- ISODate: YYYY-MM-DD -->
								<xsl:value-of select="'20'"/>
								<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
								<xsl:value-of select="'-'"/>
								<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
								<xsl:value-of select="'-'"/>
								<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>
							</xsl:element>
							<xsl:element name="CreDt">
								<xsl:value-of select="external:time('%Y-%m-%dT%H:%M:%S',19)"/>
							<!--		<xsl:text>2002-02-06T14:46:52</xsl:text> -->
							</xsl:element>
						</xsl:element>
						<!-- End GrpHdr -->

						<xsl:apply-templates/>

					</xsl:element>
				</xsl:if>
				
				<xsl:if test="smt:MT104R">
					<xsl:element name="CoreBlkDDbtRfl" xmlns="urn:swift:xs:CoreBlkDDbtRfl">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="substring($XSLTPARAMBATCHID,1,16)"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
														
						</xsl:element>
						<xsl:element name="AddtlRefs" xmlns="urn:swift:xs:CoreBlkDDbtRfl">
			
								<xsl:element name="Ref">
									<xsl:value-of select="//smt:MessageText/smt:tag21/@tagValue"/>
								</xsl:element>
								
								<xsl:element name="RefIssr">
									<xsl:value-of select="substring(//sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
								</xsl:element>
								
								<xsl:element name="DDReceiver">
									<xsl:value-of select="substring(//sg:BasicHeader/@SenderLT,1,8)"/>
								</xsl:element>
			
						</xsl:element>
					
						<!-- End GrpHdr -->

            		<!--  ( no header, so get a message from this ) -->
		            <xsl:if test="smt:MT104R">
		              <xsl:call-template name="MT104R"/>
		            </xsl:if>
						
					</xsl:element>
				</xsl:if>

				<!--xsl:if test="smt:MT104E">
					<xsl:element name="CoreBlkLrgRmtDDbtTrf" xmlns="urn:swift:xs:CoreBlkLrgRmtDDbt">
						<xsl:call-template name="MT104"/>
					</xsl:element-->
					<!-- smt:MT104E -->
				<!--/xsl:if-->

				<xsl:if test="smt:MT104">
					<xsl:element name="CoreBlkLrgRmtDDbtTrf" xmlns="urn:swift:xs:CoreBlkLrgRmtDDbt">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="substring($XSLTPARAMBATCHID,1,16)"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="TtlSttlmAmt">
								<xsl:attribute name="Ccy">
									<xsl:value-of select="'RON'"/>
								</xsl:attribute>
								<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
							</xsl:element>
							<xsl:element name="IntrBkValDt">
								<!-- ISODate: YYYY-MM-DD -->
								<!-- se ia data din mesaj -->
								<xsl:variable name="VBatchDate" select="//smt:MessageText/smt:tag30/@tagValue"/>
								<xsl:value-of select="'20'"/>
								<xsl:value-of select="substring($VBatchDate,1,2)"/>
								<xsl:value-of select="'-'"/>
								<xsl:value-of select="substring($VBatchDate,3,2)"/>
								<xsl:value-of select="'-'"/>
								<xsl:value-of select="substring($VBatchDate,5,2)"/>

							</xsl:element>
						</xsl:element>
						<!-- End GrpHdr -->

            <!--  ( no header, so get a message from this ) -->
		            <xsl:if test="smt:MT104">
		              <xsl:call-template name="MT104"/>
		            </xsl:if>

					</xsl:element>
				</xsl:if>
				
					<xsl:if test="smt:MTCQ" >
					<xsl:element name="CoreBlkChq" xmlns="urn:swift:xs:CoreBlkChq">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="$XSLTPARAMBATCHID"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="TtlSttlmAmt">
								<xsl:attribute name="Ccy">
									<xsl:value-of select=" 'RON' "/>
								</xsl:attribute>
								<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
							</xsl:element>
							<xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
							</xsl:element>
						</xsl:element>
						<!-- End GrpHdr -->
						<!-- add CQ element -->
						<xsl:call-template name="MTCQ"/>

					</xsl:element>
				</xsl:if>
				
				<xsl:if test="smt:MTPN" >
					<xsl:element name="CoreBlkPrmsNt" xmlns="urn:swift:xs:CoreBlkPrmsNt">
						<xsl:element name="GrpHdr">
						
								<xsl:element name="GrpId">
									<xsl:value-of select="$XSLTPARAMBATCHID"/>
								</xsl:element>
								<xsl:element name="IndvItmTtlNb">
									<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
								</xsl:element>
								<xsl:element name="TtlSttlmAmt">
									<xsl:attribute name="Ccy">
										<xsl:value-of select=" 'RON' "/>
									</xsl:attribute>
									<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
								</xsl:element>
								<xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
								</xsl:element>
							
						</xsl:element>
						
						<xsl:call-template name="MTPN"/>

					</xsl:element>
				</xsl:if>
				
				<xsl:if test="smt:MTBE" >
					<xsl:element name="CoreBlkBillXch" xmlns="urn:swift:xs:CoreBlkBillXch">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="$XSLTPARAMBATCHID"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="TtlSttlmAmt">
								<xsl:attribute name="Ccy">
									<xsl:value-of select=" 'RON' "/>
								</xsl:attribute>
								<xsl:value-of select="$XSLTPARAMBATCHAMOUNT"/>
							</xsl:element>
						   <xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
								</xsl:element>
						</xsl:element>
						
						<xsl:call-template name="MTBE"/>

					</xsl:element>
				</xsl:if>
				
				<!-- message with batch header -->
			   <xsl:if test="smt:MTRCQ" >
					<xsl:element name="CoreBlkChqRfl" xmlns="urn:swift:xs:CoreBlkChqRfl">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="$XSLTPARAMBATCHID"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
							</xsl:element>
						</xsl:element>
						<xsl:element name="AddtlRefs">
				            <xsl:element name="Ref">
				                <xsl:value-of select="/smt:MTRCQ/smt:MessageText/smt:tag21/@tagValue"/>
				            </xsl:element>
				            <xsl:element name="RefIssr">
				                <xsl:value-of select="substring(/smt:MTRCQ/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
				            </xsl:element>
								<xsl:element name="ChqReceiver">
				                <xsl:value-of select="substring(/smt:MTRCQ/sg:BasicHeader/@SenderLT,1,8)"/>
				            </xsl:element>
	        			</xsl:element>
						
						<xsl:call-template name="MTRCQ"/>

					</xsl:element>
				</xsl:if>
				
			<!-- message with batch header -->
			   <xsl:if test="smt:MTRPN" >
			   	<xsl:element name="CoreBlkPrmsNtRfl" xmlns="urn:swift:xs:CoreBlkPrmsNtRfl">
						<xsl:element name="GrpHdr">
							<xsl:element name="GrpId">
								<xsl:value-of select="$XSLTPARAMBATCHID"/>
							</xsl:element>
							<xsl:element name="IndvItmTtlNb">
								<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
							</xsl:element>
							<xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
							</xsl:element>
						</xsl:element>
						<xsl:element name="AddtlRefs">
				            <xsl:element name="Ref">
				                <xsl:value-of select="/smt:MTRPN/smt:MessageText/smt:tag21/@tagValue"/>
				            </xsl:element>
				            <xsl:element name="RefIssr">
				                <xsl:value-of select="substring(/smt:MTRPN/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
				            </xsl:element>
								<xsl:element name="PrmsNtReceiver">
				                <xsl:value-of select="substring(/smt:MTRPN/sg:BasicHeader/@SenderLT,1,8)"/>
				            </xsl:element>
	        			</xsl:element>
						
						<xsl:call-template name="MTRPN"/>

					</xsl:element>
				</xsl:if>
				
					<!-- message with batch header -->
			   <xsl:if test="smt:MTRBE" >
			   		<xsl:element name="CoreBlkBillXchRfl" xmlns="urn:swift:xs:CoreBlkBillXchRfl">           
							<xsl:element name="GrpHdr">
								<xsl:element name="GrpId">
									<xsl:value-of select="$XSLTPARAMBATCHID"/>
								</xsl:element>
								<xsl:element name="IndvItmTtlNb">
									<xsl:value-of select="$XSLTPARAMBATCHCOUNT"/>
								</xsl:element>
								<xsl:element name="CreDt">
							   	<xsl:value-of select="'20'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,1,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,3,2)"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="substring($XSLTPARAMDATE,5,2)"/>								
								</xsl:element>
							</xsl:element>
							<xsl:element name="AddtlRefs">
					            <xsl:element name="Ref">
					                <xsl:value-of select="/smt:MTRBE/smt:MessageText/smt:tag21/@tagValue"/>
					            </xsl:element>
					            <xsl:element name="RefIssr">
					                <xsl:value-of select="substring(/smt:MTRBE/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
					            </xsl:element>
								 <xsl:element name="BillXchReceiver">
		                			<xsl:value-of select="substring(/smt:MTRBE/sg:BasicHeader/@SenderLT,1,8)"/>
		            		</xsl:element>
		        			</xsl:element>
						
						<xsl:call-template name="MTRBE"/>

					</xsl:element>
				</xsl:if>
				
			</xsl:otherwise>
			

		</xsl:choose>

	</xsl:template>	
	

	<xsl:template name="MTRCQ">
     
	        <xsl:element name="BlkChqRefHdlg" xmlns="urn:swift:xs:CoreBlkChqRfl">
	            <xsl:element name="IteRef">
	                <xsl:value-of select="/smt:MTRCQ/sg:UserHeader/sg:tag108/@tagValue"/>
	            </xsl:element>
	            <xsl:variable name="VSumaRefuz" select="substring(/smt:MTRCQ/smt:MessageText/smt:tag32A/@tagValue,10)"/>
	            <xsl:if test="not( ($VSumaRefuz='0,0')or($VSumaRefuz='0')or($VSumaRefuz='0,00')or($VSumaRefuz='0,') )">
		            <xsl:element name="RfsdAmt">
		            	 <xsl:attribute name="Ccy">
		                		<xsl:value-of select="'RON'"/>
		                </xsl:attribute>
		                <xsl:call-template name="FORMAT_SUMA">
										<xsl:with-param name="VSuma">
												<xsl:value-of select="$VSumaRefuz"/>
										</xsl:with-param>
							 </xsl:call-template>		               
		            </xsl:element>
	            </xsl:if>
	           <xsl:for-each select="/smt:MTRCQ/smt:MessageText/smt:tag70/rfl">
		             <xsl:element name="RflRsn">
						                <xsl:choose>
					                		 <xsl:when test="string-length(d)=0">			            	
									                <xsl:element name="ErrCd">	                    
									                    <xsl:value-of select="c"/>
									                </xsl:element>	  
									          </xsl:when>        
									          <xsl:otherwise>   
									          			<xsl:element name="Desc">	         			                		     
													        		<xsl:value-of select ="normalize-space(d)"/>		
													      </xsl:element>	         
									          		   <xsl:element name="ErrCd">	                    
									                    		<xsl:value-of select="c"/>
									                	</xsl:element>	   							                		 
												 </xsl:otherwise>								
					                </xsl:choose>	        		    
			              	</xsl:element>
	             </xsl:for-each>
	        </xsl:element>
	</xsl:template>	

	<xsl:template name="MTRPN">
		
			<xsl:element name="BlkPrmsNtRefHdlg" xmlns="urn:swift:xs:CoreBlkPrmsNtRfl">
	       		   <xsl:element name="IteRef">
	                			<xsl:value-of select="/smt:MTRPN/sg:UserHeader/sg:tag108/@tagValue"/>
	           		</xsl:element>
		            <xsl:variable name="VSumaRefuz" select="substring(/smt:MTRPN/smt:MessageText/smt:tag32A/@tagValue,10)"/>
	            	<xsl:if test="not( ($VSumaRefuz='0,0')or($VSumaRefuz='0')or($VSumaRefuz='0,00')or($VSumaRefuz='0,'))">
			            <xsl:element name="RfsdAmt">
			                <xsl:attribute name="Ccy">
			                		<xsl:value-of select="'RON'"/>
			                </xsl:attribute>			            
			                <xsl:call-template name="FORMAT_SUMA">
											<xsl:with-param name="VSuma">
													<xsl:value-of select="$VSumaRefuz"/>
											</xsl:with-param>
								 </xsl:call-template>
			            </xsl:element>
		            </xsl:if>
	           		<xsl:for-each select="/smt:MTRPN/smt:MessageText/smt:tag70/rfl">
		             <xsl:element name="RflRsn">
						                <xsl:choose>
					                		 <xsl:when test="string-length(d)=0">			            	
									                <xsl:element name="ErrCd">	                    
									                    <xsl:value-of select="c"/>
									                </xsl:element>	  
									          </xsl:when>        
									          <xsl:otherwise>   
									          			<xsl:element name="Desc">	         			                		     
													        		<xsl:value-of select ="normalize-space(d)"/>		
													      </xsl:element>	         
									          		   <xsl:element name="ErrCd">	                    
									                    		<xsl:value-of select="c"/>
									                	</xsl:element>	   							                		 
												 </xsl:otherwise>								
					                </xsl:choose>	        		    
			              	</xsl:element>
	             </xsl:for-each>
	        		    
	     	</xsl:element>

	</xsl:template>
	
	<!-- (05/02/2008) Mapare refuz cambie -->
	<xsl:template name="MTRBE">
	        <xsl:element name="BlkBillXchRefHdlg" xmlns="urn:swift:xs:CoreBlkBillXchRfl">
	        	   <xsl:element name="IteRef">
	           			<xsl:value-of select="/smt:MTRBE/sg:UserHeader/sg:tag108/@tagValue"/>
	           	</xsl:element>
	          	<xsl:variable name="VSumaRefuz" select="substring(/smt:MTRBE/smt:MessageText/smt:tag32A/@tagValue,10)"/>
	            <xsl:if test="not( ($VSumaRefuz='0,0')or($VSumaRefuz='0')or($VSumaRefuz='0,00')or($VSumaRefuz='0,') )">
		            <xsl:element name="RfsdAmt">
		                <xsl:attribute name="Ccy">
		                		<xsl:value-of select="'RON'"/>
		                </xsl:attribute>		            
		                <xsl:call-template name="FORMAT_SUMA">
										<xsl:with-param name="VSuma">
												<xsl:value-of select="$VSumaRefuz"/>
										</xsl:with-param>
							 </xsl:call-template>
		            </xsl:element>
	            </xsl:if>
	            <xsl:for-each select="/smt:MTRBE/smt:MessageText/smt:tag70/rfl">
		             <xsl:element name="RflRsn">
						                <xsl:choose>
					                		 <xsl:when test="string-length(d)=0">			            	
									                <xsl:element name="ErrCd">	                    
									                    <xsl:value-of select="c"/>
									                </xsl:element>	  
									          </xsl:when>        
									          <xsl:otherwise>   
									          			<xsl:element name="Desc">	         			                		     
													        		<xsl:value-of select ="normalize-space(d)"/>		
													      </xsl:element>	         
									          		   <xsl:element name="ErrCd">	                    
									                    		<xsl:value-of select="c"/>
									                	</xsl:element>	   							                		 
												 </xsl:otherwise>								
					                </xsl:choose>	        		    
			              	</xsl:element>
	             </xsl:for-each>
	        </xsl:element>
	</xsl:template>
	
	<xsl:template match="smt:MTCoreBlkLrgRmtCdtTrf">


		<xsl:element name="CdtTrf" xmlns="urn:swift:xsd:CoreBlkLrgRmtCdtTrf">

			<!-- Payment instruction -->
			<xsl:element name="PmtInstr">
				<xsl:element name="InstrRef">
					<xsl:value-of select="/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag20/@tagValue"/>
				</xsl:element>
				<xsl:element name="SttlmInstr">
					<xsl:element name="IntrBkSttlmAmt">
						<xsl:attribute name="Ccy">
							<xsl:value-of select="'RON'"/>
						</xsl:attribute>
						<!--SUMANT din tag32A -->
						<xsl:variable name="VSumaNt" select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag32A/@tagValue,10)"/>

						<xsl:call-template name="FORMAT_SUMA">
							<xsl:with-param name="VSuma">
								<xsl:value-of select="$VSumaNt"/>
							</xsl:with-param>
						</xsl:call-template>

					</xsl:element>
				</xsl:element>
			</xsl:element>
			<!-- End Payment Instruction -->

			<!-- Platitor -->
			<xsl:element name="FrstAgt">
				<xsl:element name="BIC">
					<xsl:value-of select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/sg:BasicHeader/@SenderLT,1,8)"/>
				</xsl:element>
			</xsl:element>

			<!-- Beneficiar-->
			<xsl:element name="FnlAgt">
				<xsl:element name="BIC">
					<xsl:value-of select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
				</xsl:element>
			</xsl:element>

			<xsl:element name="PmtTx">

				<xsl:element name="InstdAmt">

					<xsl:attribute name="Ccy">
						<xsl:value-of select="'RON'"/>
					</xsl:attribute>

					<!--SUMANT din tag32A -->
					<xsl:variable name="VSumaNt" select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag32A/@tagValue,10)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>

				</xsl:element>

				<!-- TIPCMS -->
				<xsl:element name="ChrgBr">
					<xsl:value-of select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag71A/@tagValue,1)"/>
				</xsl:element>

				<!-- IBANPL -->
				<xsl:element name="DbtrAcct">
					<xsl:element name="Id">
						<xsl:element name="IBAN">
							<xsl:value-of select="substring(substring-before(/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag50K/@tagValue,'&#xA;'),2)"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>

				<!-- IBANBN -->
				<xsl:element name="CdtrAcct">
					<xsl:element name="Id">
						<xsl:element name="IBAN">
							<xsl:value-of select="substring(substring-before(/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag59/@tagValue,'&#xA;'),2)"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>


				<xsl:element name="Dbtr">

					<xsl:element name="NFI">

						<xsl:variable name="VBicBn" select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,7)" />
						<xsl:variable name="VTag50K" select="/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag50K/@tagValue" />
						<xsl:variable name="VLini2345" select="substring-after($VTag50K,'&#xA;')" />
						<xsl:variable name="VNumePl" select="substring-before($VLini2345,'&#xA;')" />
						<xsl:variable name="VLini345" select="substring-after($VLini2345,'&#xA;')" />
						<xsl:variable name="VAdresaPl1" select="substring-before($VLini345,'&#xA;')" />
						<xsl:variable name="VLini45" select="substring-after($VLini345,'&#xA;')" />
						<xsl:variable name="VAdresaPl2" select="substring-before($VLini45,'&#xA;')" />
						<xsl:variable name="VCodPl" select="substring-after($VLini45,'&#xA;')" />

						<xsl:choose>
							<xsl:when test="( string-length( $VCodPl ) = 0 ) or ( $VCodPl ='.' ) ">

								<xsl:element name="NmAndAdr">
									<!-- NUMEPL  linia 2 din tag50K-->
									<xsl:element name="Nm">									   
											<xsl:choose>
												<xsl:when test="contains($VLini2345,'&#xA;')">
													<xsl:value-of select="substring(substring-before($VLini2345,'&#xA;'),1,35)" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="substring($VLini2345,1,35)" />
												</xsl:otherwise>
											</xsl:choose>
									</xsl:element>
									<!-- End  NUMEPL -->

									<!-- ADRESAPL liniile 3 si 4 din tag50K  -->
									
								<xsl:if test="string-length( $VAdresaPl1 ) != 0 or string-length( $VAdresaPl2 ) != 0">									
									<xsl:element name="LngPstlAdrChc">
										<xsl:element name="Ustrd">
										<xsl:choose>
											<xsl:when test="(string-length( $VLini345 ) = 0)">
													<xsl:text>.</xsl:text>
											</xsl:when>
										<xsl:otherwise>											
												
											<xsl:value-of select="$VAdresaPl1"/>
											<xsl:if test="string-length($VAdresaPl2)&gt;0">
												<!--<xsl:value-of select="$VEnter"/> -->
												<xsl:value-of select="$VAdresaPl2"/>
											</xsl:if>
												
										</xsl:otherwise>
										</xsl:choose>
										</xsl:element>
									</xsl:element>
								</xsl:if>
									<!--End ADRESAPL -->

								</xsl:element>
								<!-- End Name and Address -->

							</xsl:when>

							<xsl:otherwise>
								<xsl:element name="IdAndNmAdr">

									<!-- CODPL: linia 5 din tag50 -->
									<xsl:element name="Id">

										<xsl:element name="ROURC">
											<xsl:value-of select="$VCodPl"/>
										</xsl:element>

									</xsl:element>
									<!--End  CODPL -->

									<xsl:element name="NmAndAdr">
										<!-- NUMEPL  linia 2 din tag59-->
										<xsl:element name="Nm">
											<xsl:value-of select="$VNumePl"/>
										</xsl:element>
										<!-- End  NUMEPL -->

										<!-- ADRESAPL liniile 3 si 4 din tag59  -->
										<xsl:if test="string-length( $VAdresaPl1 ) != 0 or string-length( $VAdresaPl2 ) != 0">												
											<xsl:element name="LngPstlAdrChc">
	
												<xsl:element name="Ustrd">
													<xsl:value-of select="$VAdresaPl1"/>
													<xsl:if test="string-length($VAdresaPl2)&gt;0">
														<!--<xsl:value-of select="$VEnter"/> -->
														<xsl:value-of select="$VAdresaPl2"/>
													</xsl:if>
												</xsl:element>
	
											</xsl:element>
										</xsl:if>
										<!--End ADRESAPL -->

									</xsl:element>
									<!-- End Name and Address -->

								</xsl:element>
								<!-- END:  ID and Name Addres -->
							</xsl:otherwise>

						</xsl:choose>
					</xsl:element>
					<!-- End NFI -->
				</xsl:element>
				<!-- End Dbtr -->

				<xsl:element name="Cdtr">

					<xsl:element name="NFI">

						<xsl:variable name="VBicBn" select="substring(/smt:MTCoreBlkLrgRmtCdtTrf/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,7)" />
						<xsl:variable name="VTag59" select="/smt:MTCoreBlkLrgRmtCdtTrf/smt:MessageText/smt:tag59/@tagValue" />
						<xsl:variable name="VLini2345" select="substring-after($VTag59,'&#xA;')" />
						<xsl:variable name="VNumeBn" select="substring-before($VLini2345,'&#xA;')" />
						<xsl:variable name="VLini345" select="substring-after($VLini2345,'&#xA;')" />
						<xsl:variable name="VAdresaBn1" select="substring-before($VLini345,'&#xA;')" />
						<xsl:variable name="VLini45" select="substring-after($VLini345,'&#xA;')" />
						<xsl:variable name="VAdresaBn2" select="substring-before($VLini45,'&#xA;')" />
						<xsl:variable name="VCodBn" select="substring-after($VLini45,'&#xA;')" />

						<xsl:choose>
							<xsl:when test="( string-length( $VCodBn ) = 0 ) or ( $VCodBn ='.' ) ">

								<xsl:element name="NmAndAdr">
									<!-- NUMEBN  linia 2 din tag59-->
									<xsl:element name="Nm">
											<xsl:choose>
												<xsl:when test="contains($VLini2345,'&#xA;')">
													<xsl:value-of select="substring(substring-before($VLini2345,'&#xA;'),1,35)" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="substring($VLini2345,1,35)" />
												</xsl:otherwise>
											</xsl:choose>
									</xsl:element>
									<!-- End  NUMEBN -->

									<!-- ADRESABN liniile 3 si 4 din tag59  -->
									<xsl:if test="string-length( $VAdresaBn1 ) != 0 or string-length( $VAdresaBn2 ) != 0">									
										<xsl:element name="LngPstlAdrChc">
	
											<xsl:element name="Ustrd">
												<xsl:choose>
													<xsl:when test="(string-length( $VLini345 ) = 0)">
														<xsl:text>.</xsl:text>
												</xsl:when>
											<xsl:otherwise>
											
													<xsl:value-of select="$VAdresaBn1"/>
													<xsl:if test="string-length($VAdresaBn2)&gt;0">
													<!--<xsl:value-of select="$VEnter"/> -->
													<xsl:value-of select="$VAdresaBn2"/>
												</xsl:if>
										
											</xsl:otherwise>
											</xsl:choose>
											</xsl:element>
	
										</xsl:element>
									</xsl:if>
									<!--End ADRESABN -->

								</xsl:element>
								<!-- End Name and Address -->

							</xsl:when>

							<xsl:otherwise>
								<xsl:element name="IdAndNmAdr">

									<!-- CODBN: linia 5 din tag59 -->
									<xsl:element name="Id">

										<xsl:element name="ROURC">
											<xsl:value-of select="$VCodBn"/>
										</xsl:element>

									</xsl:element>
									<!--End  CODBN -->

									<xsl:element name="NmAndAdr">
										<!-- NUMEBN  linia 2 din tag59-->
										<xsl:element name="Nm">
											<xsl:value-of select="$VNumeBn"/>
										</xsl:element>
										<!-- End  NUMEBN -->

										<!-- ADRESABN liniile 3 si 4 din tag59  -->
										<xsl:if test="string-length( $VAdresaBn1 ) != 0 or string-length( $VAdresaBn2 ) != 0">										
											<xsl:element name="LngPstlAdrChc">
	
												<xsl:element name="Ustrd">
													<xsl:value-of select="$VAdresaBn1"/>
													<xsl:if test="string-length($VAdresaBn2)&gt;0">
													<!--<xsl:value-of select="$VEnter"/> -->
													<xsl:value-of select="$VAdresaBn2"/>
												</xsl:if>
												</xsl:element>
	
											</xsl:element>
										</xsl:if>
										<!--End ADRESABN -->

									</xsl:element>
									<!-- End Name and Address -->

								</xsl:element>
								<!-- END:  ID and Name Addres -->
							</xsl:otherwise>

						</xsl:choose>

					</xsl:element>
					<!-- End NFI -->

				</xsl:element>
				<!-- End Cdtr -->
				<xsl:element name="RmtInf">
					<xsl:element name="Ustrd">
						<xsl:value-of select="//smt:MessageText/smt:tag70/@tagValue"/>
						<xsl:value-of select="//smt:MessageText/smt:tag72/@tagValue"/>
					</xsl:element>
				</xsl:element>

			</xsl:element>
		</xsl:element>
	</xsl:template>


	<xsl:template name="MT104">


		<xsl:element name="DDbt" xmlns="urn:swift:xs:CoreBlkLrgRmtDDbt">

			<!-- Payment instruction -->
			<xsl:element name="PmtInstr">
				<xsl:element name="InstrRef">
					<xsl:value-of select="//smt:MessageText/smt:tag20/@tagValue"/>
				</xsl:element>
				<xsl:element name="SttlmInstr">
					<xsl:element name="IntrBkSttlmAmt">
						<xsl:attribute name="Ccy">
							<xsl:value-of select="'RON'"/>
						</xsl:attribute>
						<!--SUMANT din tag32A -->
						<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32B/@tagValue, 4)"/>

						<xsl:call-template name="FORMAT_SUMA">
							<xsl:with-param name="VSuma">
								<xsl:value-of select="$VSumaNt"/>
							</xsl:with-param>
						</xsl:call-template>

					</xsl:element>
				</xsl:element>
			</xsl:element>
			<!-- End Payment Instruction -->

			<!-- Platitor -->
		<xsl:element name="FrstAgt">
				<xsl:element name="BIC">
					<xsl:value-of select="substring(//sg:BasicHeader/@SenderLT,1,8)"/>
				</xsl:element>
			</xsl:element>

			<!-- Beneficiar-->
			<xsl:element name="FnlAgt">
				<xsl:element name="BIC">
					<xsl:value-of select="substring(//sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
				</xsl:element>
			</xsl:element>

			<xsl:element name="PmtTx">

				<xsl:element name="InstdAmt">

					<xsl:attribute name="Ccy">
						<xsl:value-of select="'RON'"/>
					</xsl:attribute>

					<!--SUMANT din tag32A -->
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32B/@tagValue,4)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>

				</xsl:element>

				<!-- TIPCMS -->
				<xsl:element name="ChrgBr">
					<xsl:value-of select="substring(//smt:MessageText/smt:tag71A/@tagValue,1)"/>
				</xsl:element>


				<!-- IBANBN -->
				<xsl:element name="CdtrAcct">
					<xsl:element name="Id">
						<xsl:element name="IBAN">
							<xsl:value-of select="substring(substring-before(//smt:MessageText/smt:tag50K/@tagValue,'&#xA;'),2)"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>

				<!-- IBANPL -->
			<xsl:element name="DbtrAcct">
					<xsl:element name="Id">
						<xsl:element name="IBAN">
							<xsl:value-of select="substring(substring-before(//smt:MessageText/smt:tag59/@tagValue,'&#xA;'),2)"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>

				<xsl:element name="Cdtr">

					<xsl:element name="NFI">

						<xsl:variable name="VBicBn" select="substring(//sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,7)" />
						<xsl:variable name="VTag50K" select="//smt:MessageText/smt:tag50K/@tagValue" />
						<xsl:variable name="VLini2345" select="substring-after($VTag50K,'&#xA;')" />
						<xsl:variable name="VNumeBn" select="substring-before($VLini2345,'&#xA;')" />
						<xsl:variable name="VLini345" select="substring-after($VLini2345,'&#xA;')" />
						<xsl:variable name="VAdresaBn1" select="substring-before($VLini345,'&#xA;')" />
						<xsl:variable name="VLini45" select="substring-after($VLini345,'&#xA;')" />
						<xsl:variable name="VAdresaBn2" select="substring-before($VLini45,'&#xA;')" />
						<xsl:variable name="VCodBn" select="substring-after($VLini45,'&#xA;')" />

						<xsl:choose>
							<xsl:when test="( string-length( $VCodBn ) = 0 ) or ( $VCodBn ='.' ) ">

								<xsl:element name="NmAndAdr">
									<!-- NUMEBN  linia 2 din tag59-->
								<xsl:element name="Nm">
										<xsl:choose>
											<xsl:when test="( string-length( $VNumeBn ) = 0 ) and (string-length( $VLini2345 ) = 0)">
													<xsl:text>.</xsl:text>
												</xsl:when>
											<xsl:when test="( string-length( $VNumeBn ) = 0 ) and (string-length( $VLini2345 )&gt;0)">
												<xsl:value-of select="substring($VLini2345,1,35)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="substring($VNumeBn,1,35)"/>
											</xsl:otherwise>
										</xsl:choose>
										
									</xsl:element>
									<!-- End  NUMEBN -->

									<!-- ADRESABN liniile 3 si 4 din tag59  -->
									<xsl:element name="LngPstlAdrChc">

										<xsl:element name="Ustrd">
											<xsl:choose>
												<xsl:when test="( string-length( $VAdresaBn1 ) = 0 ) and (string-length( $VLini345 ) = 0)">
													<xsl:text>.</xsl:text>
												</xsl:when>
												<xsl:when test="( string-length( $VAdresaBn1 ) = 0 ) and (string-length( $VLini345 )&gt;0)">
													<xsl:value-of select="substring($VLini345,1,35)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VAdresaBn1"/>
													<xsl:if test="string-length($VAdresaBn2)&gt;0">
														<xsl:value-of select="$VEnter"/>
														<xsl:value-of select="$VAdresaBn2"/>
													</xsl:if>
												</xsl:otherwise>
											</xsl:choose>
											
										</xsl:element>

									</xsl:element>
									<!--End ADRESABN -->

								</xsl:element>
								<!-- End Name and Address -->

							</xsl:when>

							<xsl:otherwise>
								<xsl:element name="IdAndNmAdr">

									<!-- CODBN: linia 5 din tag59 -->
								<xsl:element name="Id">

										<xsl:element name="ROURC">
											<xsl:value-of select="$VCodBn"/>
										</xsl:element>

									</xsl:element>
									<!--End  CODBN -->

								<xsl:element name="NmAndAdr">
										<!-- NUMEBN  linia 2 din tag59-->
									<xsl:element name="Nm">
											<xsl:choose>
												<xsl:when test="( string-length( $VNumeBn ) = 0 ) and (string-length( $VLini2345 ) = 0)">
														<xsl:text>.</xsl:text>
													</xsl:when>
												<xsl:when test="( string-length( $VNumeBn ) = 0 ) and (string-length( $VLini2345 )&gt;0)">
													<xsl:value-of select="substring($VLini2345,1,35)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VNumeBn"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:element>
										<!-- End  NUMEBN -->

										<!-- ADRESABN liniile 3 si 4 din tag59  -->
										<xsl:element name="LngPstlAdrChc">

											<xsl:element name="Ustrd">
												<xsl:choose>
													<xsl:when test="( string-length( $VAdresaBn1 ) = 0 ) and (string-length( $VLini345 ) = 0)">
														<xsl:text>.</xsl:text>
													</xsl:when>
													<xsl:when test="( string-length( $VAdresaBn1 ) = 0 ) and (string-length( $VLini345 )&gt;0)">
														<xsl:value-of select="substring($VLini345,1,35)"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="$VAdresaBn1"/>
														<xsl:if test="string-length($VAdresaBn2)&gt;0">
															<xsl:value-of select="$VEnter"/>
															<xsl:value-of select="$VAdresaBn2"/>
														</xsl:if>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:element>

										</xsl:element>
										<!--End ADRESABN -->

								</xsl:element>
									<!-- End Name and Address -->

								</xsl:element>
								<!-- END:  ID and Name Addres -->
						</xsl:otherwise>

						</xsl:choose>

				</xsl:element>
					<!-- End NFI -->

				</xsl:element>
				<!-- End Cdtr -->

				<xsl:element name="Dbtr">

					<xsl:element name="NFI">

						<xsl:variable name="VBicBn" select="substring(//sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,7)" />
						<xsl:variable name="VTag59" select="//smt:MessageText/smt:tag59/@tagValue" />
						<xsl:variable name="VLini2345" select="substring-after($VTag59,'&#xA;')" />
						<xsl:variable name="VNumePl">
							<xsl:choose>
								<xsl:when test="contains($VLini2345,'&#xA;')">
									<xsl:value-of select="substring(substring-before($VLini2345,'&#xA;'),1,35)" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring($VLini2345,1,35)" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="VLini345" select="substring-after($VLini2345,'&#xA;')" />
						<xsl:variable name="VAdresaPl1" select="substring-before($VLini345,'&#xA;')" />
						<xsl:variable name="VLini45" select="substring-after($VLini345,'&#xA;')" />
						<xsl:variable name="VAdresaPl2" select="substring-before($VLini45,'&#xA;')" />
						<xsl:variable name="VCodPl" select="substring-after($VLini45,'&#xA;')" />

						<xsl:choose>
							<xsl:when test="( string-length( $VCodPl ) = 0 ) or ( $VCodPl ='.' ) ">

								<xsl:element name="NmAndAdr">
									<!-- NUMEPL  linia 2 din tag59-->
									<xsl:element name="Nm">
										
										<xsl:choose>
											<xsl:when test="( string-length( $VNumePl ) = 0 ) and (string-length( $VLini2345 ) = 0)">
													<xsl:text>.</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VNumePl"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
									<!-- End  NUMEPL -->

									<!-- ADRESAPL liniile 3 si 4 din tag59  -->
									<xsl:element name="LngPstlAdrChc">
				 					
					 				<xsl:element name="Ustrd">
					 						<xsl:choose>
												<xsl:when test="( string-length( $VAdresaPl1 ) = 0 ) and (string-length( $VLini345 ) = 0)">
													<xsl:text>.</xsl:text>
												</xsl:when>
												<xsl:when test="( string-length( $VAdresaPl1 ) = 0 ) and (string-length( $VLini345 )&gt;0)">
													<xsl:value-of select="substring($VLini345,1,35)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VAdresaPl1"/>
													<xsl:choose>
														<xsl:when test="string-length($VAdresaPl2)=0 and (string-length( $VLini45 )&gt;0)">
															<xsl:value-of select="$VEnter"/>
															<xsl:value-of select="substring($VLini45,1,35)"/>
														</xsl:when>
														<xsl:when test="string-length($VAdresaPl2)&gt;0">
															<xsl:value-of select="$VEnter"/>
															<xsl:value-of select="substring($VAdresaPl2,1,35)"/>
														</xsl:when>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
					 				</xsl:element>
						 					
					 			</xsl:element>
									<!--End ADRESAPL -->

								</xsl:element>
								<!-- End Name and Address -->

							</xsl:when>

							<xsl:otherwise>
								<xsl:element name="IdAndNmAdr">

									<!-- CODPL: linia 5 din tag50 -->
								<xsl:element name="Id">

										<xsl:element name="ROURC">
											<xsl:value-of select="$VCodPl"/>
										</xsl:element>

									</xsl:element>
									<!--End  CODPL -->

								<xsl:element name="NmAndAdr">
										<!-- NUMEPL  linia 2 din tag59-->
									<xsl:element name="Nm">
										<xsl:choose>
											<xsl:when test="( string-length( $VNumePl ) = 0 ) and (string-length( $VLini2345 ) = 0)">
													<xsl:text>.</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$VNumePl"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:element>
										<!-- End  NUMEPL -->

										<!-- ADRESAPL liniile 3 si 4 din tag59  -->
									<xsl:element name="LngPstlAdrChc">

											<xsl:element name="Ustrd">
												<xsl:choose>
												<xsl:when test="( string-length( $VAdresaPl1 ) = 0 ) and (string-length( $VLini345 ) = 0)">
													<xsl:text>.</xsl:text>
												</xsl:when>
												<xsl:when test="( string-length( $VAdresaPl1 ) = 0 ) and (string-length( $VLini345 )&gt;0)">
													<xsl:value-of select="substring($VLini345,1,35)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$VAdresaPl1"/>
													<xsl:choose>
														<xsl:when test="string-length($VAdresaPl2)=0 and (string-length( $VLini45 )&gt;0)">
															<xsl:value-of select="$VEnter"/>
															<xsl:value-of select="substring($VLini45,1,35)"/>
														</xsl:when>
														<xsl:when test="string-length($VAdresaPl2)&gt;0">
															<xsl:value-of select="$VEnter"/>
															<xsl:value-of select="substring($VAdresaPl2,1,35)"/>
														</xsl:when>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
											</xsl:element>

										</xsl:element>
										<!--End ADRESAPL -->

								</xsl:element>
									<!-- End Name and Address -->

							</xsl:element>
								<!-- END:  ID and Name Addres -->
						</xsl:otherwise>

						</xsl:choose>
					</xsl:element>
					<!-- End NFI -->
				</xsl:element>
				<!-- End Dbtr -->

			<xsl:element name="RmtInf">
					<xsl:element name="Ustrd">
						<xsl:value-of select="//smt:MessageText/smt:tag70/@tagValue"/>
						<xsl:if test="string-length(//smt:MessageText/smt:tag72/@tagValue)&gt;0">
							<xsl:value-of select="$VEnter"/>
							<xsl:value-of select="//smt:MessageText/smt:tag72/@tagValue"/>
						</xsl:if>
					</xsl:element>
				</xsl:element>

			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="MT104R">
		
		<xsl:element name="BlkDDRefHdlg" xmlns="urn:swift:xs:CoreBlkDDbtRfl">
			
			<xsl:element name="IteRef">
				<xsl:value-of select="//sg:UserHeader/sg:tag108/@tagValue"/>
			</xsl:element>
			
			<xsl:element name="Desc">
				<xsl:variable name="VDet2" >
					<xsl:choose>
						<xsl:when test="contains(//smt:MessageText/smt:tag70/@tagValue,'&#xA;')">
							<xsl:value-of select ="translate(substring-after(//smt:MessageText/smt:tag70/@tagValue,'&#xA;'), '&#xA;' ,' ' )"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
				<xsl:when test="string-length($VDet2)&gt;0">
					<xsl:value-of select="$VDet2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>.</xsl:text>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			
			<xsl:element name="ErrCd">
				<xsl:variable name="VDet1" >
					<xsl:choose>
						<xsl:when test="contains(//smt:MessageText/smt:tag70/@tagValue,'&#xA;')">
							<xsl:value-of select ="substring-before(//smt:MessageText/smt:tag70/@tagValue,'&#xA;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring(//smt:MessageText/smt:tag70/@tagValue,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
				<xsl:when test="string-length($VDet1)&gt;0">
					<xsl:value-of select="$VDet1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>.</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:element>

		</xsl:element>		
	</xsl:template>
	
		<xsl:template name="MTCQ">
	

				<xsl:element name="Chq" xmlns="urn:swift:xs:CoreBlkChq">
						<xsl:element name="PmtInstr">
								<xsl:element name="InstrRef">
										<xsl:value-of select="/smt:MTCQ/smt:MessageText/smt:tag20/@tagValue"/>
								</xsl:element>
								<xsl:element name="SttlmInstr">
										<xsl:element name="IntrBkSttlmAmt">
												<xsl:attribute name="Ccy">
														<xsl:value-of select="substring(/smt:MTCQ/smt:MessageText/smt:tag32A/@tagValue,7,3)"/>
												</xsl:attribute>
												<xsl:variable name="VSumaNt11" select="substring(/smt:MTCQ/smt:MessageText/smt:tag32A/@tagValue,10)"/>
												<xsl:call-template name="FORMAT_SUMA">
														<xsl:with-param name="VSuma">
																<xsl:value-of select="$VSumaNt11"/>
														</xsl:with-param>
												</xsl:call-template>
										</xsl:element>
								</xsl:element>
								<xsl:element name="CreDt">
										<xsl:value-of select="'20'"/>
										<xsl:value-of select="substring(/smt:MTCQ/smt:MessageText/smt:tagM02/@tagValue,1,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTCQ/smt:MessageText/smt:tagM02/@tagValue,3,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTCQ/smt:MessageText/smt:tagM02/@tagValue,5,2)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FrstAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTCQ/sg:BasicHeader/@SenderLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FnlAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTCQ/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="PmtTx">
							<xsl:variable name="VTag50K" select="/smt:MTCQ/smt:MessageText/smt:tag50K/@tagValue" />
							<xsl:variable name="VLine2_tag50K" select="substring-after( $VTag50K,'&#xA;')" />
							<xsl:variable name="VLine1_tag50K" select="substring-after(substring-before($VTag50K,'&#xA;'),'/')" />					
							
							<xsl:variable name="VTag59" select="/smt:MTCQ/smt:MessageText/smt:tag59/@tagValue" />
							<xsl:variable name="VLine23_tag59" select="substring-after($VTag59,'&#xA;')"/>
							<xsl:variable name="VLine2_tag59" select="substring-before($VLine23_tag59,'&#xA;')" />
							<xsl:variable name="VLine1_tag59" select="substring-after(substring-before($VTag59,'&#xA;'),'/')" />
							<xsl:variable name="VLine3_tag59" select="substring-after($VLine23_tag59,'&#xA;')"/>
							
								<xsl:element name="InstdAmt">
										<xsl:attribute name="Ccy">
												<xsl:value-of select="substring(/smt:MTCQ/smt:MessageText/smt:tag33B/@tagValue,1,3)"/>
										</xsl:attribute>
										<xsl:variable name="VSumaNt21" select="substring(/smt:MTCQ/smt:MessageText/smt:tag33B/@tagValue,4)"/>
										<xsl:call-template name="FORMAT_SUMA">
												<xsl:with-param name="VSuma">
														<xsl:value-of select="$VSumaNt21"/>
												</xsl:with-param>
										</xsl:call-template>
								</xsl:element>
								<xsl:element name="CdtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>																
																<xsl:when test="string-length( $VLine2_tag50K ) = 0">
																		<xsl:value-of select="substring-after($VTag50K,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag50K"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="DbtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>
																<xsl:when test="string-length($VLine23_tag59)=0">
																		<xsl:value-of select="substring-after($VTag59,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag59"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Cdtr">
										<xsl:element name="NFI">
												<xsl:element name="NmAndAdr">
														<xsl:element name="Nm">
																<xsl:choose>
																		<xsl:when test="string-length(($VTag50K&gt;0)and($VLine1_tag50K=0))">
																				<xsl:value-of select="substring-after($VTag50K,'&#xA;')"/>
																		</xsl:when>
																		<xsl:when test="string-length( $VLine2_tag50K )&gt;0">
																				<xsl:value-of select="$VLine2_tag50K"/>	
																		</xsl:when>
																</xsl:choose>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Dbtr">
										<xsl:element name="NFI">
												<xsl:element name="IdAndNmAdr">
														<xsl:element name="Id">
																<xsl:element name="ROURC">
																		<xsl:choose>																		
																								<xsl:when test="(string-length($VLine2_tag59)=0)and(string-length($VLine23_tag59)&gt;0)">
																										<xsl:value-of select="substring-after($VLine23_tag59,'&#xA;')"/>
																								</xsl:when>
																								<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																										<xsl:value-of select="$VLine3_tag59"/>																					
																						
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
														<xsl:element name="NmAndAdr">
																<xsl:element name="Nm">
																		<xsl:choose>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine3_tag59)=0)">
																						<xsl:value-of select="substring-after($VTag59,'&#xA;')"/>
																				</xsl:when>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																						<xsl:value-of select="$VLine2_tag59"/>
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:if test="string-length(//smt:tag70/@tagValue)">
									<xsl:element name="RmtInf">
											<xsl:element name="Ustrd">
													<xsl:value-of select="/smt:MTCQ/smt:MessageText/smt:tag70/@tagValue"/>
											</xsl:element>
									</xsl:element>	
								</xsl:if>
						</xsl:element>
				</xsl:element>

	</xsl:template>
	
	<xsl:template name="MTPN">	


				<xsl:element name="PrmsNt" xmlns="urn:swift:xs:CoreBlkPrmsNt">
						<xsl:element name="PmtInstr">
								<xsl:element name="InstrRef">
										<xsl:value-of select="/smt:MTPN/smt:MessageText/smt:tag20/@tagValue"/>
								</xsl:element>
								<xsl:element name="SttlmInstr">
										<xsl:element name="IntrBkSttlmAmt">
												<xsl:attribute name="Ccy">
														<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tag32A/@tagValue,7,3)"/>
												</xsl:attribute>
												<xsl:variable name="VSumaNt11" select="substring(/smt:MTPN/smt:MessageText/smt:tag32A/@tagValue,10)"/>
												<xsl:call-template name="FORMAT_SUMA">
														<xsl:with-param name="VSuma">
																<xsl:value-of select="$VSumaNt11"/>
														</xsl:with-param>
												</xsl:call-template>
												
										</xsl:element>
								</xsl:element>
								<xsl:if test="string-length(//smt:tagM02D/@tagValue)&gt;0">
									<xsl:element name="DueDt">
											<xsl:value-of select="'20'"/>
											<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02D/@tagValue,1,2)"/>
											<xsl:value-of select="'-'"/>
											<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02D/@tagValue,3,2)"/>
											<xsl:value-of select="'-'"/>
											<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02D/@tagValue,5,2)"/>
									</xsl:element>
								</xsl:if>
								<xsl:element name="CreDt">
										<xsl:value-of select="'20'"/>
										<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02/@tagValue,1,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02/@tagValue,3,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tagM02/@tagValue,5,2)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FrstAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTPN/sg:BasicHeader/@SenderLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FnlAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTPN/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="PmtTx">
							<xsl:variable name="VTag50K" select="/smt:MTPN/smt:MessageText/smt:tag50K/@tagValue" />
							<xsl:variable name="VLine2_tag50K" select="substring-after( $VTag50K,'&#xA;')" />
							<xsl:variable name="VLine1_tag50K" select="substring-after(substring-before($VTag50K,'&#xA;'),'/')" />					
							
							<xsl:variable name="VTag59" select="/smt:MTPN/smt:MessageText/smt:tag59/@tagValue" />
							<xsl:variable name="VLine23_tag59" select="substring-after($VTag59,'&#xA;')"/>
							<xsl:variable name="VLine2_tag59" select="substring-before($VLine23_tag59,'&#xA;')" />
							<xsl:variable name="VLine1_tag59" select="substring-after(substring-before($VTag59,'&#xA;'),'/')" />
							<xsl:variable name="VLine3_tag59" select="substring-after($VLine23_tag59,'&#xA;')"/>
							
								<xsl:element name="InstdAmt">
										<xsl:attribute name="Ccy">
												<xsl:value-of select="substring(/smt:MTPN/smt:MessageText/smt:tag33B/@tagValue,1,3)"/>
										</xsl:attribute>
										<xsl:variable name="VSumaNt21" select="substring(/smt:MTPN/smt:MessageText/smt:tag33B/@tagValue,4)"/>
										<xsl:call-template name="FORMAT_SUMA">
												<xsl:with-param name="VSuma">
														<xsl:value-of select="$VSumaNt21"/>
												</xsl:with-param>
										</xsl:call-template>
								</xsl:element>
								<xsl:element name="CdtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>																
																<xsl:when test="string-length( $VLine2_tag50K ) = 0">
																		<xsl:value-of select="substring-after($VTag50K,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag50K"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="DbtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>
																<xsl:when test="string-length($VLine23_tag59)=0">
																		<xsl:value-of select="substring-after($VTag59,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag59"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Cdtr">
										<xsl:element name="NFI">
												<xsl:element name="NmAndAdr">
														<xsl:element name="Nm">
																<xsl:choose>
																			<xsl:when test="string-length(($VTag50K&gt;0)and($VLine1_tag50K=0))">
																				<xsl:value-of select="substring-after($VTag50K,'&#xA;')"/>
																			</xsl:when>
																			<xsl:when test="string-length( $VLine2_tag50K )&gt;0">
																				<xsl:value-of select="$VLine2_tag50K"/>	
																			</xsl:when>
																</xsl:choose>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Dbtr">
										<xsl:element name="NFI">
												<xsl:element name="IdAndNmAdr">
														<xsl:element name="Id">
																<xsl:element name="ROURC">
																		<xsl:choose>
																				<xsl:when test="(string-length($VLine2_tag59)=0)and(string-length($VLine23_tag59)&gt;0)">
																										<xsl:value-of select="substring-after($VLine23_tag59,'&#xA;')"/>
																				</xsl:when>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																										<xsl:value-of select="$VLine3_tag59"/>																				
																						
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
														<xsl:element name="NmAndAdr">
																<xsl:element name="Nm">
																		<xsl:choose>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine3_tag59)=0)">
																						<xsl:value-of select="substring-after($VTag59,'&#xA;')"/>
																				</xsl:when>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																						<xsl:value-of select="$VLine2_tag59"/>
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:if test="string-length(//smt:tag70/@tagValue)">
										<xsl:element name="RmtInf">
												<xsl:element name="Ustrd">
														<xsl:value-of select="/smt:MTPN/smt:MessageText/smt:tag70/@tagValue"/>
												</xsl:element>
										</xsl:element>	
								</xsl:if>
						</xsl:element>
				</xsl:element>
		
	</xsl:template>
	
	<xsl:template name="MTBE">

				<xsl:element name="BillXch" xmlns="urn:swift:xs:CoreBlkBillXch">
						<xsl:element name="PmtInstr">
								<xsl:element name="InstrRef">
										<xsl:value-of select="/smt:MTBE/smt:MessageText/smt:tag20/@tagValue"/>
								</xsl:element>
								<xsl:element name="SttlmInstr">
										<xsl:element name="IntrBkSttlmAmt">
												<xsl:attribute name="Ccy">
														<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tag32A/@tagValue,7,3)"/>
												</xsl:attribute>
												<xsl:variable name="VSumaNt11" select="substring(/smt:MTBE/smt:MessageText/smt:tag32A/@tagValue,10)"/>
												<xsl:call-template name="FORMAT_SUMA">
														<xsl:with-param name="VSuma">
																<xsl:value-of select="$VSumaNt11"/>
														</xsl:with-param>
												</xsl:call-template>
										</xsl:element>
								</xsl:element>
								<xsl:if test="string-length(//smt:tagM02D/@tagValue)&gt;0">
									<xsl:element name="DueDt">
											<xsl:value-of select="'20'"/>
											<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02D/@tagValue,1,2)"/>
											<xsl:value-of select="'-'"/>
											<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02D/@tagValue,3,2)"/>
											<xsl:value-of select="'-'"/>
											<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02D/@tagValue,5,2)"/>
									</xsl:element>
								</xsl:if>
								<xsl:element name="CreDt">
										<xsl:value-of select="'20'"/>
										<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02/@tagValue,1,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02/@tagValue,3,2)"/>
										<xsl:value-of select="'-'"/>
										<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tagM02/@tagValue,5,2)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FrstAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTBE/sg:BasicHeader/@SenderLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="FnlAgt">
								<xsl:element name="BIC">
										<xsl:value-of select="substring(/smt:MTBE/sg:ApplicationHeader/sg:ApplicationHeaderInput/@ReceiverLT,1,8)"/>
								</xsl:element>
						</xsl:element>
						<xsl:element name="PmtTx">
							<xsl:variable name="VTag50K" select="/smt:MTBE/smt:MessageText/smt:tag50K/@tagValue" />
							<xsl:variable name="VLine2_tag50K" select="substring-after( $VTag50K,'&#xA;')" />
							<xsl:variable name="VLine1_tag50K" select="substring-after(substring-before($VTag50K,'&#xA;'),'/')" />					
							
							<xsl:variable name="VTag59" select="/smt:MTBE/smt:MessageText/smt:tag59/@tagValue" />
							<xsl:variable name="VLine23_tag59" select="substring-after($VTag59,'&#xA;')"/>
							<xsl:variable name="VLine2_tag59" select="substring-before($VLine23_tag59,'&#xA;')" />
							<xsl:variable name="VLine1_tag59" select="substring-after(substring-before($VTag59,'&#xA;'),'/')" />
							<xsl:variable name="VLine3_tag59" select="substring-after($VLine23_tag59,'&#xA;')"/>
							
								<xsl:element name="InstdAmt">
										<xsl:attribute name="Ccy">
												<xsl:value-of select="substring(/smt:MTBE/smt:MessageText/smt:tag33B/@tagValue,1,3)"/>
										</xsl:attribute>
										<xsl:variable name="VSumaNt21" select="substring(/smt:MTBE/smt:MessageText/smt:tag33B/@tagValue,4)"/>
										<xsl:call-template name="FORMAT_SUMA">
												<xsl:with-param name="VSuma">
														<xsl:value-of select="$VSumaNt21"/>
												</xsl:with-param>
										</xsl:call-template>
								</xsl:element>
								<xsl:element name="CdtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>																
																<xsl:when test="string-length( $VLine2_tag50K ) = 0">
																		<xsl:value-of select="substring-after($VTag50K,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag50K"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="DbtrAcct">
										<xsl:element name="Id">
												<xsl:element name="IBAN">
														<xsl:choose>
																<xsl:when test="string-length($VLine23_tag59)=0">
																		<xsl:value-of select="substring-after($VTag59,'/')"/>
																</xsl:when>
																<xsl:otherwise>
																		<xsl:value-of select="$VLine1_tag59"/>
																</xsl:otherwise>
														</xsl:choose>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Cdtr">
										<xsl:element name="NFI">
												<xsl:element name="NmAndAdr">
														<xsl:element name="Nm">
																<xsl:choose>
																	<xsl:when test="string-length(($VTag50K&gt;0)and($VLine1_tag50K=0))">
																				<xsl:value-of select="substring-after($VTag50K,'&#xA;')"/>
																			</xsl:when>
																			<xsl:when test="string-length( $VLine2_tag50K )&gt;0">
																				<xsl:value-of select="$VLine2_tag50K"/>	
																			</xsl:when>
																</xsl:choose>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:element name="Dbtr">
										<xsl:element name="NFI">
												<xsl:element name="IdAndNmAdr">
														<xsl:element name="Id">
																<xsl:element name="ROURC">
																		<xsl:choose>
																					<xsl:when test="((string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)=0))">
																										<xsl:value-of select="substring-after($VLine23_tag59,'&#xA;')"/>
																				</xsl:when>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																										<xsl:value-of select="$VLine3_tag59"/>																				
																						
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
														<xsl:element name="NmAndAdr">
																<xsl:element name="Nm">
																		<xsl:choose>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine3_tag59)=0)">
																						<xsl:value-of select="substring-after($VTag59,'&#xA;')"/>
																				</xsl:when>
																				<xsl:when test="(string-length($VLine23_tag59)&gt;0)and(string-length($VLine2_tag59)&gt;0)">
																						<xsl:value-of select="$VLine2_tag59"/>
																				</xsl:when>
																		</xsl:choose>
																</xsl:element>
														</xsl:element>
												</xsl:element>
										</xsl:element>
								</xsl:element>
								<xsl:if test="string-length(//smt:tag70/@tagValue)">
									<xsl:element name="RmtInf">
											<xsl:element name="Ustrd">
													<xsl:value-of select="/smt:MTBE/smt:MessageText/smt:tag70/@tagValue"/>
											</xsl:element>
									</xsl:element>	
								</xsl:if>
						</xsl:element>
				</xsl:element>
		
	</xsl:template>

	<xsl:template name="FORMAT_SUMA">
		<xsl:param name="VSuma"/>

		<xsl:variable name="VSumaIntreaga" select="substring-before( $VSuma,',')" />
		<xsl:variable name="VSumaZecimala" select="substring-after( $VSuma,',')" />
		<xsl:value-of select="$VSumaIntreaga"/>
		<xsl:if test="string-length( $VSumaZecimala )>0 ">
			<xsl:value-of select="'.'"/>
			<xsl:value-of select="$VSumaZecimala"/>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>