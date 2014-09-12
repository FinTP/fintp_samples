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
	xmlns:drr="urn:swift:xs:DRRMessage"
	xmlns:drrNo="urn:swift:xs:DRRNoMessage"
	xmlns:external="http://extensions.bisnet.ro" exclude-result-prefixes="external">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="no"/>
	
	<xsl:param name="XSLTPARAMPOSITION"/>
  <!--xsl:variable name="XSLTPARAMPOSITION" select="'5'"/-->
			
	<xsl:template match="cdttrf:CoreBlkLrgRmtCdtTrf">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root"   xmlns:cdttrf="urn:swift:xsd:CoreBlkLrgRmtCdtTrf">	
				<xsl:element name="cdttrf:CoreBlkLrgRmtCdtTrf" xmlns:cdttrf="urn:swift:xsd:CoreBlkLrgRmtCdtTrf">
					<xsl:copy-of select="cdttrf:GrpHdr" />
					<xsl:element name="cdttrf:SessionTime">
							<xsl:value-of select="external:time( '%H', 2 )"/>
					</xsl:element>					
					<xsl:copy-of select="cdttrf:CdtTrf[ position()=$XSLTPARAMPOSITION ]"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cdttrf:GrpHdr/cdttrf:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="count( cdttrf:CdtTrf )"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="cbdd:CoreBlkLrgRmtDDbtTrf">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbdd:GrpHdr/cbdd:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbdd:DDbt ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
			<xsl:element name="root"   xmlns:cbdd="urn:swift:xs:CoreBlkLrgRmtDDbt">	
				<xsl:element name ="cbdd:CoreBlkLrgRmtDDbtTrf" xmlns:cbdd="urn:swift:xs:CoreBlkLrgRmtDDbt">
					<xsl:copy-of select="cbdd:GrpHdr" />
					<xsl:element name="cdttrf:SessionTime">
							<xsl:value-of select="external:time( '%H', 2 )"/>
					</xsl:element>
					<xsl:copy-of select="cbdd:DDbt[ position() =  $XSLTPARAMPOSITION  ]"/>
				</xsl:element>
			</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="cbddrfl:CoreBlkDDbtRfl">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbddrfl:GrpHdr/cbddrfl:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="'1'"/>
				</xsl:attribute>
			</Batch>
		</xsl:when>				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
			<xsl:element name="root"   xmlns:cbddrfl="urn:swift:xs:CoreBlkDDbtRfl">	
					<xsl:element name="cbddrfl:CoreBlkDDbtRfl" xmlns:cbddrfl="urn:swift:xs:CoreBlkDDbtRfl"> 
						<xsl:copy-of select="node()" />
					</xsl:element>
			</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
		<xsl:template match="cbpn:CoreBlkPrmsNt">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbpn:GrpHdr/cbpn:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbpn:PrmsNt ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
			<xsl:element name="root"  xmlns:cbpn="urn:swift:xs:CoreBlkPrmsNt">				
					<xsl:element name ="cbpn:CoreBlkPrmsNt" xmlns:cbpn="urn:swift:xs:CoreBlkPrmsNt">
						<xsl:copy-of select="cbpn:GrpHdr" />
						<xsl:element name="cbpn:SessionTime">
								<xsl:value-of select="external:time( '%H', 2 )"/>
						</xsl:element>
						<xsl:element name="cbpn:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
						</xsl:element>
						<xsl:copy-of select="cbpn:PrmsNt[ position() =  $XSLTPARAMPOSITION  ]"/>
					</xsl:element>
			</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
		<xsl:template match="cbchq:CoreBlkChq">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbchq:GrpHdr/cbchq:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbchq:Chq ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
			<xsl:element name="root"  xmlns:cbchq="urn:swift:xs:CoreBlkChq">		
				<xsl:element name ="cbchq:CoreBlkChq" xmlns:cbchq="urn:swift:xs:CoreBlkChq" >
					<xsl:copy-of select="cbchq:GrpHdr" />
					<xsl:element name="cbchq:SessionTime">
							<xsl:value-of select="external:time( '%H', 2 )"/>
					</xsl:element>
					<xsl:element name="cbchq:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
					</xsl:element>
					<xsl:copy-of select="cbchq:Chq[ position() =  $XSLTPARAMPOSITION  ]"/>
				</xsl:element>
			</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
   <xsl:template match="cbbe:CoreBlkBillXch">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbbe:GrpHdr/cbbe:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbbe:BillXch ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
				<xsl:element name="root"  xmlns:cbbe="urn:swift:xs:CoreBlkBillXch">		
					<xsl:element name ="cbbe:CoreBlkBillXch" xmlns:cbbe="urn:swift:xs:CoreBlkBillXch" >
						<xsl:copy-of select="cbbe:GrpHdr" />
						<xsl:element name="cbbe:SessionTime">
								<xsl:value-of select="external:time( '%H', 2 )"/>
						</xsl:element>
						<xsl:element name="cbbe:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
						</xsl:element>
						<xsl:copy-of select="cbbe:BillXch[ position() =  $XSLTPARAMPOSITION  ]"/>
					</xsl:element>
				</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="cbchqrfl:CoreBlkChqRfl">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbchqrfl:GrpHdr/cbchqrfl:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbchqrfl:BlkChqRefHdlg ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
				<xsl:element name="root"  xmlns:cbchqrfl="urn:swift:xs:CoreBlkChqRfl">		
					<xsl:element name ="cbchqrfl:CoreBlkChqRfl" xmlns:cbchqrfl="urn:swift:xs:CoreBlkChqRfl">
						<xsl:copy-of select="cbchqrfl:GrpHdr" />
						<xsl:copy-of select="cbchqrfl:AddtlRefs" />
						<xsl:element name="cbchqrfl:SessionTime">
								<xsl:value-of select="external:time( '%H', 2 )"/>
						</xsl:element>
						<xsl:element name="cbchqrfl:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
						</xsl:element>
						<xsl:copy-of select="cbchqrfl:BlkChqRefHdlg[ position() =  $XSLTPARAMPOSITION  ]"/>
					</xsl:element>
				</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="cbpnrfl:CoreBlkPrmsNtRfl">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbpnrfl:GrpHdr/cbpnrfl:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbpnrfl:BlkPrmsNtRefHdlg ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
				<xsl:element name="root"  xmlns:cbpnrfl="urn:swift:xs:CoreBlkPrmsNtRfl">		
					<xsl:element name ="cbpnrfl:CoreBlkPrmsNtRfl" xmlns:cbpnrfl="urn:swift:xs:CoreBlkPrmsNtRfl">
						<xsl:copy-of select="cbpnrfl:GrpHdr" />
						<xsl:copy-of select="cbpnrfl:AddtlRefs" />
						<xsl:element name="cbpnrfl:SessionTime">
								<xsl:value-of select="external:time( '%H', 2 )"/>
						</xsl:element>
						<xsl:element name="cbpnrfl:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
						</xsl:element>
						<xsl:copy-of select="cbpnrfl:BlkPrmsNtRefHdlg[ position() =  $XSLTPARAMPOSITION  ]"/>
					</xsl:element>
				</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="cbbxrfl:CoreBlkBillXchRfl">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbbxrfl:GrpHdr/cbbxrfl:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select=" count( cbbxrfl:BlkBillXchRefHdlg ) "/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
				
		<xsl:when test="not($XSLTPARAMPOSITION='0')">
				<xsl:element name="root"  xmlns:cbbxrfl="urn:swift:xs:CoreBlkBillXchRfl">		
					<xsl:element name ="cbbxrfl:CoreBlkBillXchRfl" xmlns:cbbxrfl="urn:swift:xs:CoreBlkBillXchRfl">
						<xsl:copy-of select="cbbxrfl:GrpHdr" />
						<xsl:copy-of select="cbbxrfl:AddtlRefs" />
						<xsl:element name="cbbxrfl:SessionTime">
								<xsl:value-of select="external:time( '%H', 2 )"/>
						</xsl:element>
						<xsl:element name="cbbxrfl:BatchRcvDate">
								<xsl:value-of select="external:time('%y%m%d',6)"/>
						</xsl:element>
						<xsl:copy-of select="cbbxrfl:BlkBillXchRefHdlg[ position() =  $XSLTPARAMPOSITION  ]"/>
					</xsl:element>
				</xsl:element>
		</xsl:when>
		
		</xsl:choose>
	</xsl:template>
	
	<!-- Transmite n+1 bucati, n-mesaje + 1 corespunzator headerului 
	<xsl:template match="cbdd:CoreBlkLrgRmtDDbtTrf">
		<xsl:choose>
		<xsl:when test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="cbdd:GrpHdr/cbdd:GrpId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="number( count( cbdd:DDbt ) ) + 1"/>
				</xsl:attribute>
			</Batch>
		</xsl:when>
		
		<xsl:when test="$XSLTPARAMPOSITION='1'">
			<xsl:element name ="cbdd:CoreBlkLrgRmtDDbtHdr" >
				<xsl:copy-of select="cbdd:GrpHdr" />
				<xsl:copy-of select="cbdd:DDbt[ position() = $XSLTPARAMPOSITION ]"/>
			</xsl:element>		
		</xsl:when>		
				
		<xsl:otherwise>
			<xsl:element name ="cbdd:CoreBlkLrgRmtDDbtTrf" xmlns:cbdd="urn:swift:xs:CoreBlkLrgRmtDDbt">
				<xsl:copy-of select="cbdd:GrpHdr" />
				<xsl:copy-of select="cbdd:DDbt[ position() = ( $XSLTPARAMPOSITION -1 ) ]"/>
			</xsl:element>
		</xsl:otherwise>
		
		</xsl:choose>
	</xsl:template>
    -->
    
	<xsl:template match="blkrjct:BlkRjct">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root"  xmlns:blkrjct="urn:swift:xs:BlkRjct">		
				<xsl:element name="blkrjct:BlkRjct" xmlns:blkrjct="urn:swift:xs:BlkRjct"> 
					<xsl:apply-templates select="node()" mode="copy_all_elem"/>
				</xsl:element> 
			</xsl:element> 
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="substring(blkrjct:GrpHdr/blkrjct:GrpId,1,32)"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="'1'"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="blkacc:BlkAcc">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root"  xmlns:blkacc="urn:swift:xs:BlkAcc">
				<xsl:element name="blkacc:BlkAcc" xmlns:blkacc="urn:swift:xs:BlkAcc"> 
					<xsl:copy-of select="node()" />
				</xsl:element> 				
		</xsl:element> 
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="substring(blkacc:GrpHdr/blkacc:GrpId,1,32)"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="'1'"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="blkrec:ReconciliationMessage">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root"   xmlns:ntf="urn:swift:xs:NotificationMessage">
					<xsl:element name ="blkrec:ReconciliationMessage" xmlns:blkrec="urn:swift:xs:ReconciliationMessage">
						<xsl:attribute name="indexMin">
							<xsl:value-of select="(number($XSLTPARAMPOSITION)-1)*100"/>
						</xsl:attribute>
						<xsl:attribute name="indexMax">
							<xsl:value-of select="(number($XSLTPARAMPOSITION))*100"/>
						</xsl:attribute>
						<xsl:attribute name="bic">
							<xsl:text>TRFDSENT</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="accountId">
							<xsl:text>SEPSENT</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="pageNo">
							<xsl:value-of select="$XSLTPARAMPOSITION"/>
						</xsl:attribute>
						<xsl:copy-of select="blkrec:ReconciliationMessageHeader" />
						<xsl:copy-of select="blkrec:ReconciliationMessagePart[ ceiling( position() div 100 ) = $XSLTPARAMPOSITION ]"/>
					</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="blkrec:ReconciliationMessageHeader/blkrec:MessageId"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
          <xsl:value-of select="ceiling( count( blkrec:ReconciliationMessagePart ) div 100 )"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>	


	<xsl:template match="ntf:NotificationMessage">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:element name="root"   xmlns:ntf="urn:swift:xs:NotificationMessage">
				<xsl:element name="ntf:NotificationMessage" xmlns:ntf="urn:swift:xs:NotificationMessage"> 
					<xsl:copy-of select="node()" />
				</xsl:element> 
			</xsl:element> 
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="substring(ntf:NotificationMessageHeader/ntf:MessageId,1,30)"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="'1'"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="drr:DRRMessage">
		<xsl:if test="not( $XSLTPARAMPOSITION='0' )">
			<xsl:choose>
				<xsl:when test="//drr:DRRMessagePart">
						<xsl:element name="root"   xmlns:drr="urn:swift:xs:DRRMessage">
								<xsl:element name="drr:DRRMessage" xmlns:drr="urn:swift:xs:DRRMessage"> 
									<xsl:element name ="drr:ReceivingDay">
												<xsl:value-of select="drr:DRRMessageHeader/drr:BusinessDay"/>
									</xsl:element>
									<xsl:copy-of select="drr:DRRMessagePart[  position()  = $XSLTPARAMPOSITION ]" />
								</xsl:element> 
						</xsl:element> 
				</xsl:when>
				<xsl:otherwise>
						<xsl:element name="root"   xmlns:drrNo="urn:swift:xs:DRRNoMessage">
								<xsl:element name="drrNo:DRRNoMessage" xmlns:drrNo="urn:swift:xs:DRRNoMessage"> 									
								</xsl:element> 
						</xsl:element> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="$XSLTPARAMPOSITION='0'">
			<Batch>
				<xsl:attribute name="Id">
					<xsl:value-of select="substring(drr:DRRMessageHeader/drr:MessageId,1,30)"/>
				</xsl:attribute>
				<xsl:attribute name="Count">
					<xsl:value-of select="drr:DRRMessageHeader/drr:PartNo"/>
				</xsl:attribute>
			</Batch>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="*" mode="copy_all_elem" >
	<xsl:choose>
		<xsl:when test="name()='IteRef'">
				<xsl:element name="{name()}">
					<xsl:choose>
							<xsl:when test="contains(., '.tiff.p7m')">																
									<xsl:value-of select="substring-before(.,'.tiff.p7m')"/>
							</xsl:when>
							<xsl:otherwise>
									<xsl:value-of select="."/>
							</xsl:otherwise>				
					</xsl:choose>				
				</xsl:element>	    
	    </xsl:when>
	    <xsl:otherwise>
	    		<xsl:element name="{name()}">
		      <xsl:copy-of select="@*"/>
		      <xsl:apply-templates mode="copy_all_elem"/>
		    </xsl:element>
	    </xsl:otherwise>    
   </xsl:choose>
  </xsl:template>


</xsl:stylesheet>
