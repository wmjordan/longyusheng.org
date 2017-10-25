<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://www.dreamstudioz.org/xslt/js" exclude-result-prefixes="msxsl js">
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="html"/>
	<xsl:param name="keyword"/>
	<xsl:variable name="note" select="$ciNotesXml/���ϵ���/����/ע��[�ʻ� = $keyword]"/>

	<xsl:template name="PageTitle">
		<xsl:text>�ʻ㣺</xsl:text>
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
			<xsl:value-of select="$note/�ʻ�[1]"/>
			<xsl:for-each select="$note/�ʻ�[position() &gt; 1]">
				<xsl:text>��</xsl:text>
				<xsl:value-of select="text()"/>
			</xsl:for-each>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<xsl:apply-templates select="$note"/>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart">
			<xsl:text>��ǰλ�ã�</xsl:text>
			<xsl:call-template name="ListAncestorsInSiteMap"/>
			<xsl:text>ע��</xsl:text>
			<xsl:text>��</xsl:text>
			<xsl:call-template name="ListWords"/>
		</div>
	</xsl:template>

	<xsl:template match="ע��">
		<hr/>
		<div class="Page" style="padding-bottom: 50pt;"><xsl:apply-templates select="ע��"/></div>
	</xsl:template>

	<xsl:template match="�ʻ�">
		<div><xsl:value-of select="text()"/></div>
	</xsl:template>

	<xsl:template match="ע��">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template match="����">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template match="����">
		<div><xsl:apply-templates /></div>
	</xsl:template>

	<xsl:template name="ListWords">
		<xsl:for-each select="$note/�ʻ�">
			<xsl:if test="position () != 1">
				<xsl:text>��</xsl:text>
			</xsl:if>
			<xsl:value-of select="text()"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="copyrightText"/>

</xsl:stylesheet>

