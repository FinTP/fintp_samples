<?xml version="1.0" encoding="us-ascii"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:smt="urn:xmlns:SWIFTMTs" xmlns:sg="urn:xmlns:SWIFTgenerics">
	<xsl:output method="xml" indent="yes" encoding="us-ascii"/>
	<xsl:strip-space elements="*"/>
	<xsl:param name="XSLTPARAMFEEDBACK"/>
	<xsl:param name="XSLTPARAMREQUESTOR"/>
	<xsl:param name="XSLTPARAMMESSAGEID"/>
	<xsl:param name="XSLTPARAMBATCHID"/>
	<!--
07.04.2014 Mesajul cu msgtype = CoreBlkLrgRmtCdtTrf (ACH) se trimite in BO ca mesaj 103
-->
	<xsl:variable name="VMsgType" select="//sg:ApplicationHeader/@MessageType"/>
	<xsl:variable name="VTipMesaj">
		<xsl:choose>
	   	<xsl:when test="$VMsgType=string('CoreBlkLrgRmtCdtTrf')"> 
					<xsl:value-of select="'103'"/>  
			</xsl:when>
			<xsl:otherwise>
					<xsl:value-of select="//sg:ApplicationHeader/@MessageType"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="VReceiver" select="substring(//sg:ApplicationHeader//@ReceiverLT,1,7)"/>
	<xsl:variable name="VSender" select="//sg:BasicHeader/@SenderLT"/>
	<xsl:variable name="VTag70" select="//smt:MessageText/smt:tag70/@tagValue"/>
	<xsl:variable name="VTag72" select="//smt:MessageText/smt:tag72/@tagValue"/>
	<xsl:variable name="VTag50K" select="//smt:MessageText/smt:tag50K/@tagValue"/>
	<xsl:variable name="VTag57A" select="//smt:MessageText/smt:tag57A/@tagValue"/>
	<xsl:variable name="VTag59" select="//smt:MessageText/smt:tag59/@tagValue"/>
	<xsl:variable name="VDetalii70" select="normalize-space($VTag70)"/>
	<xsl:variable name="VDetalii72" select="normalize-space($VTag72)"/>
	<xsl:variable name="VExplicatii" select="concat($VDetalii70,$VDetalii72)"/>
	<xsl:variable name="VTag119" select="//sg:UserHeader/sg:tag119/@tagValue"/>
	<xsl:variable name="VTag50A" select="//smt:MessageText/smt:tag50A/@tagValue"/>
	<xsl:variable name="VTag58A" select="//smt:MessageText/smt:tag58A/@tagValue"/>
	<xsl:variable name="VTag52A" select="//smt:MessageText/smt:tag52A/@tagValue"/>
	<xsl:variable name="VTag59A" select="//smt:MessageText/smt:tag59A/@tagValue"/>
	<xsl:variable name="VTag50F" select="//smt:MessageText/smt:tag50F/@tagValue"/>
	<xsl:variable name="VTag72FaraEnter" select="	translate( $VTag72 , '&#xA;' , '' ) "/>

	<xsl:variable name="VSeq">
		<xsl:text>`;~</xsl:text>
	</xsl:variable>
	<xsl:variable name="Contains72_Before">
		<xsl:if test="($VTipMesaj='202') and ($VTag119 = 'COV')">
			<xsl:call-template name="TemplateTagIsBefore">
				<xsl:with-param name="VNodeName" select="//smt:MessageText/smt:tag72"/>
				<xsl:with-param name="VTag" select="'72'"/>
				<xsl:with-param name="VFirstTag" select="'59'"/>
				<xsl:with-param name="VSecondTag" select="'59A'"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="VIsReject">
		<xsl:choose>
			<xsl:when test="( contains($VTag72,'/RETN/' ))">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:when test="( contains($VTag72,'/REJT/' ))">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template name="IDMSJ">
		<xsl:element name="IDMSJ">
			<xsl:value-of select="$XSLTPARAMMESSAGEID"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="TIPMESAJ">
		<xsl:element name="TIPMESAJ">
			<xsl:for-each select="smt:MT102E">
				<xsl:text>103</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT103">
				<xsl:text>103</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MTCoreBlkLrgRmtCdtTrf">
				<xsl:text>103</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT104R">
				<xsl:text>104</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT104">
				<xsl:text>104</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT202">
				<xsl:text>202</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT900">
				<xsl:text>900</xsl:text>
			</xsl:for-each>
			<xsl:for-each select="smt:MT910">
				<xsl:text>910</xsl:text>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NRREF">
		<xsl:element name="NRREF">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='104') or ($VTipMesaj='104R') or ($VTipMesaj='202') or ($VTipMesaj='900') or ($VTipMesaj='910')">
					<xsl:value-of select="substring(//smt:MessageText/smt:tag20/@tagValue,1,16)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='102E'">
					<xsl:value-of select="substring(//smt:MessageText/smt:tag21/@tagValue,1,16)"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:value-of select="//smt:MessageText/smt:tag20/@tagValue"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NRDOC">
		<xsl:element name="NRDOC">
			<xsl:if test="($VTipMesaj='103') or ($VTipMesaj='102E') or ( $VTipMesaj='104' )">
				<xsl:variable name="VDupaRFB70">
					<xsl:choose>
						<xsl:when test="$VReceiver='TREZROB'">
							<xsl:value-of select="substring-after($VTag70,'/RFB/')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-after($VTag70,'//RFB/')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="VNrOP70">
					<xsl:choose>
						<xsl:when test="$VReceiver='TREZROB'">
							<xsl:value-of select="substring-before($VDupaRFB70,'/')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-before($VDupaRFB70,'&#xA;')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="VDupaRFB72" select="substring-after($VTag72,'//RFB/')"/>
				<xsl:variable name="VNrOP72" select="substring-before($VDupaRFB72,'&#xA;')"/>
				<xsl:choose>
					<xsl:when test="string-length($VNrOP70)&gt;0">
						<xsl:value-of select="substring($VNrOP70,1,10)"/>
					</xsl:when>
					<xsl:when test="string-length($VDupaRFB70)&gt;0">
						<xsl:value-of select="substring(translate($VDupaRFB70,'&#xA;',''),1,10)"/>
					</xsl:when>
					<xsl:when test="string-length($VNrOP72)&gt;0">
						<xsl:value-of select="substring($VNrOP72,1,10)"/>
					</xsl:when>
					<xsl:when test="string-length($VDupaRFB72)&gt;0">
						<xsl:value-of select="substring(translate($VDupaRFB72,'&#xA;',''),1,10)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="DATADOC">
		<xsl:element name="DATADOC">
			<xsl:if test="($VTipMesaj='103') or ($VTipMesaj='102E') or ( $VTipMesaj='104' )">
				<!-- Mesaj Ack, Nack trimis initial catre Trezorerie -->
				<xsl:if test="$VReceiver='TREZROB'">
					<xsl:variable name="VAfterRFB" select="substring-after($VTag70,'/RFB/')"/>
					<xsl:variable name="VAfterNrDoc" select="substring-after($VAfterRFB,'/')"/>
					<xsl:variable name="VDataDoc" select="normalize-space(substring-before($VAfterNrDoc,'/'))"/>
					<xsl:value-of select="substring($VDataDoc,3,6)"/>
				</xsl:if>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="BICPL">
		<xsl:element name="BICPL">
			<xsl:choose>
				<xsl:when test="$VTipMesaj='104'">
					<xsl:value-of select="substring(//sg:ApplicationHeader//@ReceiverLT,1,9)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring($VSender,1,9)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CODPL">
		<xsl:element name="CODPL">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='102E')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VCod" select="normalize-space(substring-after($VRestLinii45,'&#xA;'))"/>
					<xsl:if test="not($VCod='.')">
						<xsl:value-of select="substring($VCod,1,13)"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VCod" select="normalize-space(substring-after($VRestLinii45,'&#xA;'))"/>
					<xsl:if test="not($VCod='.')">
						<xsl:value-of select="substring($VCod,1,13)"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '54' "/>
						<xsl:with-param name="VTag" select="$VTag50K"/>
					</xsl:call-template>
					<!--<xsl:call-template name="GetLines">
				          <xsl:with-param name="VLinii" select=" '1X' " />
				          <xsl:with-param name="VTag" select="$VTag50F" />
				 	</xsl:call-template>-->
					<xsl:if test="(string-length($VTag50F)&gt;0) and not( substring($VTag50F,1,1) = '/' )">
						<xsl:choose>
							<xsl:when test="substring-after($VTag50F,'&#xA;')">
								<xsl:value-of select="substring(substring-before($VTag50F,'&#xA;'),1,13)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring($VTag50F,1,13)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NUMEPL">
		<xsl:element name="NUMEPL">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='102E')">
					<xsl:variable name="VRestLinii" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VNumePl" select="substring-before($VRestLinii,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="string-length($VNumePl)&gt;0">
							<xsl:value-of select="substring($VNumePl,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104') ">
					<xsl:variable name="VRestLinii" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VNumePl" select="substring-before($VRestLinii,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="string-length($VNumePl)&gt;0">
							<xsl:value-of select="substring($VNumePl,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '20' "/>
						<xsl:with-param name="VTag" select="$VTag50A"/>
					</xsl:call-template>
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '21' "/>
						<xsl:with-param name="VTag" select="$VTag50K"/>
					</xsl:call-template>
					<xsl:call-template name="TemplateTag50F">
						<xsl:with-param name="VText" select=" '1/' "/>
					</xsl:call-template>
				</xsl:when>
				<!-- 50F-->
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="ADRESAPL">
		<xsl:element name="ADRESAPL">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='102E')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VAdresaPl1" select="substring-before($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VAdresaPl2" select="substring-before($VRestLinii45,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="$VAdresaPl1='.'">
							
						</xsl:when>
						<xsl:when test="string-length($VAdresaPl1)&gt;0">
							<xsl:value-of select="substring($VAdresaPl1,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii345,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$VAdresaPl2='.'">
							
						</xsl:when>
						<xsl:when test="string-length($VAdresaPl2)&gt;0">
							<xsl:value-of select="substring($VAdresaPl2,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii45,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VAdresaPl1" select="substring-before($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VAdresaPl2" select="substring-before($VRestLinii45,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="$VAdresaPl1='.'">
							
						</xsl:when>
						<xsl:when test="string-length($VAdresaPl1)&gt;0">
							<xsl:value-of select="substring($VAdresaPl1,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii345,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$VAdresaPl2='.'">
							
						</xsl:when>
						<xsl:when test="string-length($VAdresaPl2)&gt;0">
							<xsl:value-of select="substring($VAdresaPl2,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii45,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:call-template name="GetLines1">
						<xsl:with-param name="VLinii" select=" '3423' "/>
						<xsl:with-param name="VTag" select="$VTag50K"/>
					</xsl:call-template>
					<xsl:if test="(string-length($VTag50F)&gt;0) ">
						<xsl:variable name="VTemp">
							<xsl:call-template name="TemplateTag50F">
								<xsl:with-param name="VText" select=" '2/' "/>
							</xsl:call-template>
							<xsl:call-template name="TemplateTag50F">
								<xsl:with-param name="VText" select=" '3/' "/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="$VTemp"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="IBANPL">
		<xsl:element name="IBANPL">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='102E')">
					<xsl:variable name="VIban" select="substring(substring-before($VTag50K,'&#xA;'),2,24)"/>
					<xsl:choose>
						<xsl:when test="string-length($VIban)&gt;0">
							<xsl:value-of select="$VIban"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VTag50K,1,24)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VIban" select="substring(substring-before($VTag59,'&#xA;'),2,24)"/>
					<xsl:choose>
						<xsl:when test="string-length($VIban)&gt;0">
							<xsl:value-of select="$VIban"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VTag50K,1,24)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
			 	</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="BICBN">
		<xsl:element name="BICBN">
			<xsl:choose>
				<xsl:when test="$VTipMesaj='104'">
					<xsl:value-of select="substring($VSender,1,9)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(//sg:ApplicationHeader//@ReceiverLT,1,9)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CODBN">
		<xsl:element name="CODBN">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ( $VTipMesaj='102E' )">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VCod" select="normalize-space(substring-after($VRestLinii45,'&#xA;'))"/>
					<xsl:if test="not($VCod='.')">
						<xsl:value-of select="substring($VCod,1,13)"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VCod" select="normalize-space(substring-after($VRestLinii45,'&#xA;'))"/>
					<xsl:if test="not($VCod='.')">
						<xsl:value-of select="substring($VCod,1,13)"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '54' "/>
						<xsl:with-param name="VTag" select="$VTag59"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NUMEBN">
		<xsl:element name="NUMEBN">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ( $VTipMesaj='102E' )">
					<xsl:variable name="VRestLinii" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VNumeBn" select="substring-before($VRestLinii,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="string-length($VNumeBn)&gt;0">
							<xsl:value-of select="substring($VNumeBn,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VRestLinii" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VNumeBn" select="substring-before($VRestLinii,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="string-length($VNumeBn)&gt;0">
							<xsl:value-of select="substring($VNumeBn,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '20' "/>
						<xsl:with-param name="VTag" select="$VTag59A"/>
					</xsl:call-template>
					<xsl:call-template name="GetLines">
						<xsl:with-param name="VLinii" select=" '21' "/>
						<xsl:with-param name="VTag" select="$VTag59"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="ADRESABN">
		<xsl:element name="ADRESABN">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ( $VTipMesaj='102E' )">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag59,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VAdresaBn1" select="substring-before($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VAdresaBn2" select="substring-before($VRestLinii45,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="$VAdresaBn1='.'">	
						</xsl:when>
						<xsl:when test="string-length($VAdresaBn1)&gt;0">
							<xsl:value-of select="substring($VAdresaBn1,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii345,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$VAdresaBn2='.'">
						</xsl:when>
						<xsl:when test="string-length($VAdresaBn2)&gt;0">
							<xsl:value-of select="substring($VAdresaBn2,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii45,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VRestLinii2345" select="substring-after($VTag50K,'&#xA;')"/>
					<xsl:variable name="VRestLinii345" select="substring-after($VRestLinii2345,'&#xA;')"/>
					<xsl:variable name="VAdresaBn1" select="substring-before($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VRestLinii45" select="substring-after($VRestLinii345,'&#xA;')"/>
					<xsl:variable name="VAdresaBn2" select="substring-before($VRestLinii45,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="$VAdresaBn1='.'">	
						</xsl:when>
						<xsl:when test="string-length($VAdresaBn1)&gt;0">
							<xsl:value-of select="substring($VAdresaBn1,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii345,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="$VAdresaBn2='.'">
						</xsl:when>
						<xsl:when test="string-length($VAdresaBn2)&gt;0">
							<xsl:value-of select="substring($VAdresaBn2,1,35)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VRestLinii45,1,35)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VTipMesaj='202' and $VTag119='COV'">
					<xsl:call-template name="GetLines1">
						<xsl:with-param name="VLinii" select=" '3423' "/>
						<xsl:with-param name="VTag" select="$VTag59"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="IBANBN">
		<xsl:element name="IBANBN">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ( $VTipMesaj='102E' )">
					<xsl:variable name="VIban" select="substring(substring-before($VTag59,'&#xA;'),2,24)"/>
					<xsl:choose>
						<xsl:when test="string-length($VIban)&gt;0">
							<xsl:value-of select="$VIban"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VTag59,1,24)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104')">
					<xsl:variable name="VIban" select="substring(substring-before($VTag50K,'&#xA;'),2,24)"/>
					<xsl:choose>
						<xsl:when test="string-length($VIban)&gt;0">
							<xsl:value-of select="$VIban"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VTag59,1,24)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="DATAPLATII">
		<xsl:element name="DATAPLATII">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103')or($VTipMesaj='202') or ($VTipMesaj='900') or ($VTipMesaj='910')">
					<xsl:value-of select="substring(//smt:MessageText/smt:tag32A/@tagValue,1,6)"/>
				</xsl:when>
				<xsl:when test="( $VTipMesaj='102E' ) or ($VTipMesaj='104') or ($VTipMesaj='104R')">
					<xsl:variable name="VDataPlatii" select="//smt:MessageText/smt:tag30/@tagValue"/>
					<xsl:choose>
						<xsl:when test="string-length($VDataPlatii)=6">
							<xsl:value-of select="$VDataPlatii"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VDataPlatii,3,6)"/>
						</xsl:otherwise>
					</xsl:choose>
					<!--<xsl:value-of select="substring(//smt:MessageText/smt:tag30/@tagValue,3,6)"/>-->
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NRCRBUG">
		<xsl:element name="NRCRBUG">		
				<xsl:choose>
						<xsl:when test="$VTipMesaj='103'">
							<!-- Mesaj Ack, Nack trimis initial catre Trezorerie -->
							<xsl:if test="$VReceiver='TREZROB'">
								<xsl:variable name="VTag70" select="//smt:MessageText/smt:tag70/@tagValue"/>
								<xsl:variable name="VAfterROC" select="substring-after($VTag70,'/ROC/')"/>
								<xsl:variable name="VNrCrBug1" select="substring-before($VAfterROC,'/RFB/')"/>
								<xsl:variable name="VNrCrBug" select="translate($VNrCrBug1,'&#xA;','')"/>
							
										<xsl:if test="not($VNrCrBug='.')">
											<xsl:value-of select="substring($VNrCrBug,1,23)"/>
										</xsl:if>
								
							</xsl:if>
						</xsl:when>
						<xsl:when test="( $VTipMesaj='102E' ) or ( $VTipMesaj='104' )">
							<!-- Mesaj Ack, Nack trimis initial catre Trezorerie -->
							<xsl:if test="$VReceiver='TREZROB'">
								<xsl:variable name="VTag70" select="//smt:MessageText/smt:tag70/@tagValue"/>
								<xsl:variable name="VAfterROC" select="substring-after($VTag70,'/ROC/')"/>
								<xsl:variable name="VNrCrBug" select="substring-before($VAfterROC,'&#xA;')"/>
								<xsl:choose>
									<xsl:when test="string-length($VNrCrBug)&gt;0">
										<xsl:if test="not($VNrCrBug='.')">
											<xsl:value-of select="substring($VNrCrBug,1,23)"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="(not($VAfterROC='.')) and (string-length($VAfterROC)&gt;0) and (not(contains($VAfterROC,'&#xA;')))">
											<xsl:value-of select="substring($VAfterROC,1,23) "/>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:when>
				</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="SUMATL">
		<xsl:element name="SUMATL">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or (($VTipMesaj='202') and ($VTag119='COV')) ">
					<xsl:variable name="VSumaTl" select="substring(//smt:MessageText/smt:tag33B/@tagValue,4)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaTl"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="SUMANT">
		<xsl:element name="SUMANT">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') ">
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32A/@tagValue,10)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($VTipMesaj='102E') or ( $VTipMesaj='104' ) or ( $VTipMesaj='104R' )">
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32B/@tagValue,4)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202')">
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32A/@tagValue,10)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($VTipMesaj='900')">
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32A/@tagValue,10)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($VTipMesaj='910')">
					<xsl:variable name="VSumaNt" select="substring(//smt:MessageText/smt:tag32A/@tagValue,10)"/>
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaNt"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="TIPCMS">
		<xsl:element name="TIPCMS">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='202') or ( $VTipMesaj='104' )">
					<!-- TODO:De mapat si celelalte variante -->
					<xsl:value-of select="substring(//smt:MessageText/smt:tag71A/@tagValue,1,3)"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='102E')">
					<!-- TODO:De mapat si celelalte variante -->
					<xsl:value-of select="'SHA'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="SUMACM">
		<xsl:element name="SUMACM">
			<!-- TODO:De mapat si celelalte variante -->
			<xsl:if test="$VTipMesaj='103'">
				<xsl:variable name="VSumaF" select="substring(//smt:MessageText/smt:tag71F/@tagValue,4)"/>
				<xsl:variable name="VSumaG" select="substring(//smt:MessageText/smt:tag71G/@tagValue,4)"/>
				<xsl:if test="string-length($VSumaF)&gt;0">
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaF"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="string-length($VSumaG)&gt;0">
					<xsl:call-template name="FORMAT_SUMA">
						<xsl:with-param name="VSuma">
							<xsl:value-of select="$VSumaG"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CODOP">
		<xsl:element name="CODOP">
			<!-- TODO:De mapat si celelalte variante -->
			<xsl:choose>
				<xsl:when test="$VTipMesaj='103'">
					<xsl:value-of select="substring(//smt:MessageText/smt:tag23B/@tagValue,1,16)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='102E'">
					<xsl:value-of select="'CRED'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="TRAN">
		<xsl:element name="TRAN">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='202') or ($VTipMesaj='102E')">
					<xsl:value-of select="substring(//sg:UserHeader/sg:tag108/@tagValue,1,3)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='900'">
					<xsl:value-of select="'000'"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='910'">
					<xsl:value-of select="'000'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="PRB">
		<xsl:element name="PRB">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') or ($VTipMesaj='202') or ($VTipMesaj='102E')">
					<xsl:variable name="VPriBancara" select="//sg:UserHeader/sg:tag113/@tagValue"/>
					<xsl:value-of select="substring($VPriBancara,3,2)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='900'">
					<xsl:value-of select="'00'"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='910'">
					<xsl:value-of select="'00'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NRREFDEST">
		<xsl:element name="NRREFDEST">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='202') or ($VTipMesaj='900') or ($VTipMesaj='910')">
					<xsl:value-of select="//smt:MessageText/smt:tag21/@tagValue"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='103'">
					<xsl:choose>
						<xsl:when test="contains($VTag72, $VSeq) "><!-- e vb de un return de ach-->
							<!--<xsl:value-of select="substring-before( substring-after( substring-after($VTag72, ';' ) , ';' ) , ';' )"/>-->
							<xsl:call-template name="GoToSep">
								<xsl:with-param name="VText" select=" $VTag72FaraEnter "/>
								<xsl:with-param name="VSeq" select=" ';' "/>
								<xsl:with-param name="VNo" select="2"/>
								<xsl:with-param name="VPos" select="1"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="VAfterMREF" select="substring-after($VTag72,'/MREF/')"/>
							<xsl:variable name="VNrRefDest" select="substring-before($VAfterMREF,'&#xA;')"/>
							<xsl:choose>
								<xsl:when test="string-length($VNrRefDest)&gt;0">
									<xsl:value-of select="substring($VNrRefDest,1,16)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring($VAfterMREF,1,16)"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104R')">
					<xsl:variable name="VNrRefDest" select="//sg:UserHeader/sg:tag108/@tagValue"/>
					<xsl:value-of select="substring($VNrRefDest,1,16)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="EXPLICATII">
		<xsl:element name="EXPLICATII">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='102E') or ($VTipMesaj='104') or ($VTipMesaj='104R')">
					<xsl:value-of select="substring($VExplicatii,1,140)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='103'">
					<xsl:choose>
						<xsl:when test="contains($VTag72, $VSeq) "><!-- e vb de un return -->
							<xsl:value-of select="substring(substring-before( $VTag72FaraEnter, $VSeq),1,140)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VExplicatii,1,140)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VTipMesaj='202' and (string-length($VTag119)=0 or $VTag119 != 'COV') ">
					<xsl:value-of select="substring($VDetalii72,1,140)"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
					<xsl:value-of select="substring($VDetalii70,1,140)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='900'">
					<xsl:value-of select="substring($VDetalii72,1,140)"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='910'">
					<xsl:value-of select="substring($VDetalii72,1,140)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NRSCV">
		<xsl:element name="NRSCV">
			<xsl:choose>
				<xsl:when test="$VTipMesaj='102E'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:when test="$VTipMesaj='103'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:when test="$VTipMesaj='202'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:when test="$VTipMesaj='900'">
					<xsl:text>0</xsl:text>
				</xsl:when>
				<xsl:when test="$VTipMesaj='910'">
					<xsl:text>0</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="IDGRP">
		<xsl:element name="IDGRP">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='202') and ($VTag119 = 'COV') ">
					<xsl:value-of select="//smt:MessageText/smt:tag20/@tagValue"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='103') ">
					<xsl:choose>
						<xsl:when test="contains($VTag72, $VSeq) ">
							<!--<xsl:value-of select="substring-before( substring-after( substring-after( substring-after($VTag72, ';') , ';' ) , ';' )"/>	-->
							<xsl:call-template name="GoToSep">
								<xsl:with-param name="VText" select="$VTag72FaraEnter"/>
								<xsl:with-param name="VSeq" select=" ';' "/>
								<xsl:with-param name="VNo" select="3"/>
								<xsl:with-param name="VPos" select="1"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring(normalize-space($XSLTPARAMBATCHID),1,16)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(normalize-space($XSLTPARAMBATCHID),1,16)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="SUMAMSJ">
		<xsl:element name="SUMAMSJ">
			<xsl:if test="($VTipMesaj='102')">
				<xsl:variable name="VSumaMsj" select="substring(//smt:MessageText/smt:tag32A/@tagValue,10)"/>
				<xsl:call-template name="FORMAT_SUMA">
					<xsl:with-param name="VSuma">
						<xsl:value-of select="$VSumaMsj"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="REFUZPL">
		<xsl:element name="REFUZPL">
			<xsl:choose>
				<xsl:when test="$VTipMesaj='103'">
					<xsl:choose>
						<xsl:when test="contains($VTag72,'/REJT/')">
							<xsl:text>J</xsl:text>
						</xsl:when>
						<xsl:when test="contains($VTag72, '/RETN/') or contains($VTag72, $VSeq) ">
							<xsl:text>T</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>N</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104') and (substring($XSLTPARAMFEEDBACK,1,3)='RFD')">
					<xsl:value-of select="'T'"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='102E') or ($VTipMesaj='104') or ($VTipMesaj='202') or ($VTipMesaj='900') or ($VTipMesaj='910')">
					<xsl:text>N</xsl:text>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104R') and ((substring($XSLTPARAMFEEDBACK,1,5)='FTP09') or (substring($XSLTPARAMFEEDBACK,1,3)='FTP08'))">
					<xsl:value-of select="'J'"/>
				</xsl:when>
				<xsl:when test="$VTipMesaj='104R'">
					<xsl:text>T</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CODEROARE">
		<xsl:element name="CODEROARE">
			<!--<xsl:value-of select="substring($XSLTPARAMFEEDBACK,1,5)"/>-->
			<xsl:choose>
				<xsl:when test="//sg:ApplicationHeader/sg:ApplicationHeaderInput">
					<xsl:choose>
						<xsl:when test="substring($XSLTPARAMFEEDBACK,1,3)='RFD'">
							<xsl:value-of select="'FTP00'"/>
						</xsl:when>
						<xsl:when test="string-length($XSLTPARAMFEEDBACK)&gt;0">
							<xsl:value-of select="substring($XSLTPARAMFEEDBACK,1,5)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="' '"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- Pentru mesaj venit de la alti participanti -->
				<xsl:when test="//sg:ApplicationHeader/sg:ApplicationHeaderOutput">
					<xsl:choose>
						<xsl:when test="string-length($XSLTPARAMFEEDBACK)&gt;0">
							<xsl:value-of select="substring($XSLTPARAMFEEDBACK,1,5)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'FTP00'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CODSEP">
		<xsl:element name="CODSEP">
			<xsl:if test="($VTipMesaj='202') or ($VTipMesaj='103') or ($VTipMesaj='104')or ($VTipMesaj='104R') or ($VTipMesaj='900')  or ($VTipMesaj='910') or ($VTipMesaj='102E')">
				<xsl:variable name="VCodSep" select="$XSLTPARAMREQUESTOR"/>
				<xsl:choose>
					<xsl:when test="contains( $VCodSep, 'RTGS')">
						<xsl:value-of select="'R'"/>
					</xsl:when>
					<xsl:when test="contains( $VCodSep, '102')">
						<xsl:value-of select="'R'"/>
					</xsl:when>
					<xsl:when test="($VTipMesaj='202') and ($VTag119='COV') ">
						<xsl:text>R</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'A'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="TAGEROARE">
		<xsl:element name="TAGEROARE">
			<xsl:choose>
				<xsl:when test="($VTipMesaj='103') ">
					<xsl:if test="$VIsReject='Y'">
						<xsl:variable name="VAfterReject" select="substring-after(substring-after($VTag72,'/'),'/')"/>
						<xsl:variable name="VTagERR" select="substring-before($VAfterReject,'&#xA;')"/>
						<xsl:choose>
							<xsl:when test="string-length($VTagERR)&gt;0">
								<xsl:value-of select="substring($VTagERR,1,5)"/>
							</xsl:when>
							<xsl:when test="(string-length($VAfterReject)&gt;0) and (not(contains($VAfterReject,'&#xA;')))">
								<xsl:value-of select="substring($VAfterReject,1,5)"/>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$VTipMesaj='104R'">
					<xsl:value-of select="substring-before($VTag70,'&#xA;')"/>
				</xsl:when>
				<xsl:when test="($VTipMesaj='104') and (substring($XSLTPARAMFEEDBACK,1,3)='RFD')">
					<xsl:value-of select="substring($XSLTPARAMFEEDBACK,4,5)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="DETERR">
		<xsl:element name="DETERR">
			<xsl:if test="$VTipMesaj='104R'">
				<xsl:value-of select="substring-after($VTag70,'&#xA;')"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$VIsReject='Y'">
					<xsl:variable name="VLinia2" select="substring-after($VTag72,'&#xA;/')"/>
					<xsl:variable name="VAfterCodErr" select="substring-after($VLinia2,'/')"/>
					<xsl:variable name="VExpErr" select="substring-before($VAfterCodErr,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="string-length($VExpErr)&gt;0">
							<xsl:value-of select="substring($VExpErr,1,29)"/>
						</xsl:when>
						<xsl:when test="(string-length($VAfterCodErr)&gt;0) and (not(contains($VAfterCodErr,'&#xA;')))">
							<xsl:value-of select="substring($VAfterCodErr,1,29)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template name="ERSWIFT">
		<xsl:element name="ERSWIFT">
			<xsl:if test=" $VTipMesaj='103' ">
				<xsl:choose>
						<xsl:when test="contains($VTag72, $VSeq) ">
							<xsl:choose>
								<xsl:when test="contains( substring-after($VTag72FaraEnter, $VSeq) , ';' )">
									<xsl:value-of select="substring( substring-before( substring-after($VTag72FaraEnter, $VSeq) ,  ';' ) , 1, 4)"/>
								</xsl:when>
								<xsl:otherwise><!-- pe aici n-ar tb sa intre -->
									<xsl:value-of select="substring( substring-after($VTag72FaraEnter, $VSeq) , 1, 4 )"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
								<xsl:if test="$VIsReject='Y'">
									<xsl:variable name="VLinia2" select="substring-after($VTag72,'&#xA;/')"/>
									<xsl:variable name="VCodERR" select="normalize-space(substring-before($VLinia2,'/'))"/>
											<xsl:if test="string-length($VCodERR)&gt;0">
												<xsl:value-of select="substring($VCodERR,1,4)"/>
											</xsl:if>
								</xsl:if>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template name="INDCOV">
		<xsl:element name="INDCOV">
			<xsl:text>D</xsl:text>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CONTBORD">
		<xsl:element name="CONTBORD">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" 'YX' "/>
				<xsl:with-param name="VTag" select="$VTag52A"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="BICBORD">
		<xsl:element name="BICBORD">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" '20' "/>
				<xsl:with-param name="VTag" select="$VTag52A"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CONTORD">
		<xsl:element name="CONTORD">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" 'YX' "/>
				<xsl:with-param name="VTag" select="$VTag50K"/>
			</xsl:call-template>
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" 'YX' "/>
				<xsl:with-param name="VTag" select="$VTag50F"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CONTBBF">
		<xsl:element name="CONTBBF">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" 'YX' "/>
				<xsl:with-param name="VTag" select="$VTag58A"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="BICBBF">
		<xsl:element name="BICBBF">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" '20' "/>
				<xsl:with-param name="VTag" select="$VTag58A"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="CONTBF">
		<xsl:element name="CONTBF">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" 'YX' "/>
				<xsl:with-param name="VTag" select="$VTag59"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="BICCBBF">
		<xsl:element name="BICCBBF">
			<xsl:call-template name="GetLines">
				<xsl:with-param name="VLinii" select=" '20' "/>
				<xsl:with-param name="VTag" select="$VTag57A"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>
	<xsl:template name="DETBANCA">
		<xsl:element name="DETBANCA">
			<xsl:value-of select="$VTag72"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="FORMAT_SUMA">
		<xsl:param name="VSuma"/>
		<xsl:choose>
			<xsl:when test="contains($VSuma, ',')">
				<xsl:variable name="VParteIntreaga" select="substring-before($VSuma,',')"/>
				<xsl:variable name="VParteZecimala" select="substring-after($VSuma,',')"/>
				<xsl:value-of select="$VParteIntreaga"/>
				<xsl:if test="$VParteZecimala">
					<xsl:text>.</xsl:text>
					<xsl:value-of select="$VParteZecimala"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$VSuma"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="GetLines">
		<xsl:param name="VTag"/>
		<xsl:param name="VLinii"/>
		<xsl:variable name="VLinia">
			<xsl:choose>
				<xsl:when test="(string-length($VTag)&gt;0) and ( substring($VTag,1,1) = '/' )">
					<xsl:value-of select="substring($VLinii,1,1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring($VLinii,2,1)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$VLinia != 'X' ">
			<xsl:choose>
				<xsl:when test="$VLinia='0'">
					<xsl:value-of select="$VTag"/>
				</xsl:when>
				<xsl:when test="$VLinia='1'">
					<xsl:choose>
						<xsl:when test="substring-after($VTag,'&#xA;')">
							<xsl:value-of select="substring-before($VTag,'&#xA;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$VTag"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VLinia = 'Y'">
					<xsl:choose>
						<xsl:when test="substring-after($VTag,'&#xA;')">
							<xsl:value-of select="substring(substring-before($VTag,'&#xA;'),2)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VTag,2)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VLinia='2'">
					<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="substring-after($VLinii2345,'&#xA;')">
							<xsl:value-of select="substring-before($VLinii2345,'&#xA;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$VLinii2345"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VLinia='3'">
					<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
					<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="substring-after($VLinii345,'&#xA;')">
							<xsl:value-of select="substring-before($VLinii345,'&#xA;')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$VLinii345"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VLinia='4'">
					<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
					<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
					<xsl:variable name="VLinii45" select="substring-after($VLinii345,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="substring-after($VLinii45,'&#xA;')">
							<xsl:value-of select="substring(substring-before($VLinii45,'&#xA;'),1,13)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VLinii45,1,13)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$VLinia='5'">
					<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
					<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
					<xsl:variable name="VLinii45" select="substring-after($VLinii345,'&#xA;')"/>
					<xsl:variable name="VLinii5" select="substring-after($VLinii45,'&#xA;')"/>
					<xsl:choose>
						<xsl:when test="substring-after($VLinii5,'&#xA;')">
							<xsl:value-of select="substring(substring-before($VLinii5,'&#xA;'),1,13)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($VLinii5,1,13)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetLines1">
		<xsl:param name="VTag"/>
		<xsl:param name="VLinii"/>
		<xsl:variable name="VLinia">
			<xsl:choose>
				<xsl:when test="(string-length($VTag)&gt;0) and ( substring($VTag,1,1) = '/' )">
					<xsl:value-of select="substring($VLinii,1,2)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring($VLinii,3,2)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$VLinia != 'X'">
			<xsl:if test="$VLinia='0'">
				<xsl:value-of select="$VTag"/>
			</xsl:if>
			<xsl:if test="contains($VLinia,'1')">
				<xsl:choose>
					<xsl:when test="substring-after($VTag,'&#xA;')">
						<xsl:value-of select="substring-before($VTag,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VTag"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="contains($VLinia,'Y')">
				<xsl:choose>
					<xsl:when test="substring-after($VTag,'&#xA;')">
						<xsl:value-of select="substring(substring-before($VTag,'&#xA;'),2)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring($VTag,2)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="contains($VLinia,'2')">
				<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
				<xsl:choose>
					<xsl:when test="substring-after($VLinii2345,'&#xA;')">
						<xsl:value-of select="substring-before($VLinii2345,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VLinii2345"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="contains($VLinia,'3')">
				<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
				<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
				<xsl:choose>
					<xsl:when test="substring-after($VLinii345,'&#xA;')">
						<xsl:value-of select="substring-before($VLinii345,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VLinii345"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="contains($VLinia,'4')">
				<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
				<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
				<xsl:variable name="VLinii45" select="substring-after($VLinii345,'&#xA;')"/>
				<xsl:choose>
					<xsl:when test="substring-after($VLinii45,'&#xA;')">
						<xsl:value-of select="substring-before($VLinii45,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VLinii45"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="contains($VLinia,'5')">
				<xsl:variable name="VLinii2345" select="substring-after($VTag,'&#xA;')"/>
				<xsl:variable name="VLinii345" select="substring-after($VLinii2345,'&#xA;')"/>
				<xsl:variable name="VLinii45" select="substring-after($VLinii345,'&#xA;')"/>
				<xsl:variable name="VLinii5" select="substring-after($VLinii45,'&#xA;')"/>
				<xsl:choose>
					<xsl:when test="substring-after($VLinii5,'&#xA;')">
						<xsl:value-of select="substring-before($VLinii5,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VLinii5"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="TemplateTag50F">
		<xsl:param name="VText"/>
		<xsl:variable name="VLiniiAfter" select="substring-after($VTag50F, $VText)"/>
		<xsl:variable name="VLiniiBefore" select="substring-before($VTag50F, $VText)"/>
		<xsl:variable name="VLengthLiniiBefore" select="string-length($VLiniiBefore)"/>
		<xsl:if test="string-length($VLiniiAfter) &gt; 0">
			<xsl:if test=" ($VLengthLiniiBefore = 0 ) or ( substring($VLiniiBefore, $VLengthLiniiBefore, 1) = '&#xA;' ) ">
				<xsl:choose>
					<xsl:when test="substring-after($VLiniiAfter,'&#xA;')">
						<xsl:value-of select="substring-before($VLiniiAfter,'&#xA;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$VLiniiAfter"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="TemplateTagIsBefore">
		<xsl:param name="VNodeName"/>
		<xsl:param name="VTag"/>
		<xsl:param name="VFirstTag"/>
		<xsl:param name="VSecondTag"/>
		<xsl:variable name="getAllSmtTag">
			<xsl:apply-templates select="$VNodeName/following-sibling::*" mode="search"/>
		</xsl:variable>
		<xsl:value-of select="contains($getAllSmtTag,$VFirstTag) or contains($getAllSmtTag,$VSecondTag)"/>
	</xsl:template>
	<xsl:template match="*" mode="search">
		<xsl:value-of select="concat(substring(name(),8),'-')"/>
	</xsl:template>
	<xsl:template name="GoToSep">
		<xsl:param name="VText"/>
		<xsl:param name="VSeq"/>
		<xsl:param name="VNo"/>
		<xsl:param name="VPos"/>
		<xsl:choose>
			<xsl:when test="$VNo &gt;= $VPos">
				<xsl:call-template name="GoToSep">
					<xsl:with-param name="VText" select="substring-after($VText , $VSeq)"/>
					<xsl:with-param name="VSeq" select="$VSeq"/>
					<xsl:with-param name="VNo" select="$VNo"/>
					<xsl:with-param name="VPos" select="$VPos+1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-before($VText , $VSeq)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/">
		<xsl:element name="ROWSET">
			<xsl:element name="ROW">
				<xsl:attribute name="num"><xsl:value-of select="$XSLTPARAMMESSAGEID"/></xsl:attribute>
				<xsl:call-template name="IDMSJ"/>
				<xsl:call-template name="TIPMESAJ"/>
				<xsl:call-template name="NRREF"/>
				<xsl:call-template name="NRDOC"/>
				<xsl:call-template name="DATADOC"/>
				<xsl:call-template name="BICPL"/>
				<xsl:call-template name="IBANPL"/>
				<xsl:call-template name="NUMEPL"/>
				<xsl:call-template name="ADRESAPL"/>
				<xsl:call-template name="CODPL"/>
				<xsl:call-template name="BICBN"/>
				<xsl:call-template name="IBANBN"/>
				<xsl:call-template name="NUMEBN"/>
				<xsl:call-template name="ADRESABN"/>
				<xsl:call-template name="CODBN"/>
				<xsl:call-template name="DATAPLATII"/>
				<xsl:call-template name="NRCRBUG"/>
				<xsl:call-template name="SUMATL"/>
				<xsl:call-template name="SUMANT"/>
				<xsl:call-template name="TIPCMS"/>
				<xsl:call-template name="SUMACM"/>
				<xsl:call-template name="CODOP"/>
				<xsl:call-template name="TRAN"/>
				<xsl:call-template name="PRB"/>
				<xsl:call-template name="NRREFDEST"/>
				<xsl:call-template name="EXPLICATII"/>
				<xsl:call-template name="NRSCV"/>
				<xsl:call-template name="IDGRP"/>
				<xsl:call-template name="SUMAMSJ"/>
				<xsl:call-template name="REFUZPL"/>
				<xsl:call-template name="CODEROARE"/>
				<xsl:call-template name="TAGEROARE"/>
				<xsl:call-template name="ERSWIFT"/>
				<xsl:call-template name="DETERR"/>
				<xsl:call-template name="CODSEP"/>
				<xsl:if test="($VTipMesaj='202') and ($VTag119='COV')">
					<xsl:call-template name="INDCOV"/>
					<xsl:call-template name="CONTBORD"/>
					<xsl:call-template name="BICBORD"/>
					<xsl:call-template name="CONTORD"/>
					<xsl:call-template name="CONTBBF"/>
					<xsl:call-template name="BICBBF"/>
					<xsl:call-template name="CONTBF"/>
					<xsl:call-template name="BICCBBF"/>
					<xsl:if test="string-length($VTag72) and ($Contains72_Before='true')">
						<xsl:call-template name="DETBANCA"/>
					</xsl:if>
				</xsl:if>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
