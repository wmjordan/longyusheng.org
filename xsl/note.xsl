<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://www.dreamstudioz.org/xslt/js" exclude-result-prefixes="msxsl js">
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="html"/>
	<xsl:param name="keyword"/>
	<xsl:variable name="note" select="$ciNotesXml/资料档案/索引/注释[词汇 = $keyword]"/>

	<xsl:template name="PageTitle">
		<xsl:text>词汇：</xsl:text>
		<xsl:call-template name="ListWords"/>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:call-template name="ListWords"/>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">
			<xsl:value-of select="$note/词汇[1]"/>
			<xsl:for-each select="$note/词汇[position() &gt; 1]">
				<xsl:text>、</xsl:text>
				<xsl:value-of select="text()"/>
			</xsl:for-each>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<xsl:apply-templates select="$note"/>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart">
			<xsl:text>当前位置：</xsl:text>
			<xsl:call-template name="ListAncestorsInSiteMap"/>
			<xsl:text>注释</xsl:text>
			<xsl:text>／</xsl:text>
			<xsl:call-template name="ListWords"/>
		</div>
	</xsl:template>

	<xsl:template match="注释">
		<hr/>
		<div class="Page" style="padding-bottom: 50pt;"><xsl:apply-templates select="注解"/></div>
	</xsl:template>

	<xsl:template match="词汇">
		<div><xsl:value-of select="text()"/></div>
	</xsl:template>

	<xsl:template match="注解">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template match="概述">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template match="段落">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template name="ListWords">
		<xsl:for-each select="$note/词汇">
			<xsl:if test="position () != 1">
				<xsl:text>、</xsl:text>
			</xsl:if>
			<xsl:value-of select="text()"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="copyrightText"/>

</xsl:stylesheet>

