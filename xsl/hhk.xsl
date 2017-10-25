<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="msxsl context">
	<xsl:param name="indexXml" select="/"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('ע��.xml')"/>
	<xsl:output method="html" encoding="gb18030" indent="yes"/>
<!-- ���� CHM ��Ŀ�������ļ� hhk -->
	<xsl:template match="/">
		<HTML>
			<HEAD>
			<meta name="GENERATOR" content="Microsoft HTML Help Workshop 4.1"/>
			<xsl:comment> Sitemap 1.0 </xsl:comment>
			</HEAD>
			<BODY>
				<UL>
					<xsl:call-template name="pages"/>
					<xsl:call-template name="ci"/>
					<xsl:call-template name="format"/>
					<xsl:call-template name="cinote"/>
				</UL>
			</BODY>
		</HTML>
	</xsl:template>

<xsl:template name="pages">
	<xsl:for-each select="/����/����[@id != 'help' and @id != '.']">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{@����}"/>
				<param name="Local" value="{@·��}"/>
			</OBJECT>
		</LI>
		<xsl:for-each select=".//����/�ؼ���">
			<LI>
				<xsl:text> </xsl:text>
				<OBJECT type="text/sitemap">
					<param name="Name">
						<xsl:attribute name="value"><xsl:value-of select="@˵��"/></xsl:attribute>
					</param>
					<param name="Local" value="{../@·��}#{@url}"/>
				</OBJECT>
			</LI>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="ci">
	<xsl:for-each select="$indexXml/����/����/����">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{����} "/>
				<xsl:choose>
					<xsl:when test="@�ʼ�·��">
						<param name="Local" value="{@�ʼ�·��}"/>
					</xsl:when>
					<xsl:otherwise>
						<param name="Local" value="{@����·��}"/>
					</xsl:otherwise>
				</xsl:choose>
			</OBJECT>
			<xsl:if test="@�� = '1' or @�ʼ�·��">
			<UL>
				<xsl:if test="@�ʼ�·��">
					<LI>
						<xsl:text> </xsl:text>
						<OBJECT type="text/sitemap">
							<param name="Name" value="�ʼ�"/>
							<param name="Local" value="{@�ʼ�·��}"/>
						</OBJECT>
					</LI>
				</xsl:if>
				<xsl:if test="@�� = '1'">
					<LI>
						<xsl:text> </xsl:text>
						<OBJECT type="text/sitemap">
							<xsl:choose>
								<xsl:when test="@���� = '1'">
									<param name="Name" value="���ǡ�����"/>
								</xsl:when>
								<xsl:otherwise>
									<param name="Name" value="����"/>
								</xsl:otherwise>
							</xsl:choose>
							<param name="Local" value="{@����·��}"/>
						</OBJECT>
					</LI>
				</xsl:if>
			</UL>
			</xsl:if>
		</LI>
	</xsl:for-each>

	<xsl:for-each select="/����/����/��/����">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{../@����} ({translate(@text, '&#xA;&#xD;', '')})...{../@����}"/>
				<param name="Local" value="{../@·��}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

<xsl:template name="format">
	<xsl:for-each select="/����/����/����/����">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{@����}  ����"/>
				<param name="Local" value="{../@·��}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

<xsl:template name="cinote">
	<xsl:for-each select="$indexXml/����/ע��/�ʻ�">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="�ʻ� {@name}"/>
				<param name="Local" value="{@·��}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>