<?xml version="1.0" encoding="ascii"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 	xmlns:external="http://extensions.bisnet.ro" 	exclude-result-prefixes="external">
	<xsl:output method="text" version="1.0" encoding="us-ascii"/>
	<xsl:strip-space elements="*"/>
	<xsl:variable name="VHash" select="concat(
	    /Record/TIPMESAJ  ,
	    /Record/NRDOC  ,
	    /Record/IBANPL   ,
	    /Record/BICBN   ,
	    /Record/IBANBN  ,
	    /Record/NRCRBUG   ,
	    /Record/SUMATL   ,
	    /Record/SUMANT   ,
	    /Record/TRAN   ,
	    /Record/PRB
)"/>

	<xsl:template match="/">
					<xsl:value-of select="external:hash($VHash)"/>
	</xsl:template>
	
</xsl:stylesheet>
