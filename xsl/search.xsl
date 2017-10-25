<?xml version='1.0' encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" version="1.0">
	<xsl:output method="html" version="1.0" indent="no" media-type="text/html; charset=gb2312"/> 
	<xsl:param name="resNode"/>
	<xsl:param name="mode"/>
	<xsl:template match="/">
		<xsl:apply-templates select="msxsl:node-set($resNode)"/>
	</xsl:template> 

	<xsl:template match="���Ҵ�">
		<p><xsl:value-of select="����"/></p>
	</xsl:template>
	<xsl:template match="��">
		<p><a href="./?wn={../����}&amp;c={@pos}"><xsl:value-of select="../����"/> ֮ <xsl:value-of select="����"/></a></p>
		<blockquote><xsl:value-of select="����"/></blockquote>
	</xsl:template>
	<xsl:template match="��¼">
		<p><a href="./?wn={../../����}&amp;c={../@pos}"><xsl:value-of select="../../����"/> ֮ <xsl:value-of select="../����"/></a></p>
		<xsl:text>��¼</xsl:text>
		<blockquote><xsl:value-of select="text()"/></blockquote>
	</xsl:template>
	
</xsl:stylesheet>