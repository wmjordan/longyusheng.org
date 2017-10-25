<?xml version='1.0' encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" version="1.0">
	<xsl:output method="html" version="1.0" indent="no" media-type="text/html; charset=gb2312"/> 
	<xsl:param name="resNode"/>
	<xsl:param name="mode"/>
	<xsl:template match="/">
		<xsl:apply-templates select="msxsl:node-set($resNode)"/>
	</xsl:template> 

	<xsl:template match="名家词">
		<p><xsl:value-of select="作家"/></p>
	</xsl:template>
	<xsl:template match="词">
		<p><a href="./?wn={../作家}&amp;c={@pos}"><xsl:value-of select="../作家"/> 之 <xsl:value-of select="词牌"/></a></p>
		<blockquote><xsl:value-of select="正文"/></blockquote>
	</xsl:template>
	<xsl:template match="附录">
		<p><a href="./?wn={../../作家}&amp;c={../@pos}"><xsl:value-of select="../../作家"/> 之 <xsl:value-of select="../词牌"/></a></p>
		<xsl:text>附录</xsl:text>
		<blockquote><xsl:value-of select="text()"/></blockquote>
	</xsl:template>
	
</xsl:stylesheet>