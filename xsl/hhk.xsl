<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="msxsl context">
	<xsl:param name="indexXml" select="/"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('注释.xml')"/>
	<xsl:output method="html" encoding="gb18030" indent="yes"/>
<!-- 生成 CHM 项目的索引文件 hhk -->
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
	<xsl:for-each select="/索引/档案[@id != 'help' and @id != '.']">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{@名称}"/>
				<param name="Local" value="{@路径}"/>
			</OBJECT>
		</LI>
		<xsl:for-each select=".//文章/关键字">
			<LI>
				<xsl:text> </xsl:text>
				<OBJECT type="text/sitemap">
					<param name="Name">
						<xsl:attribute name="value"><xsl:value-of select="@说明"/></xsl:attribute>
					</param>
					<param name="Local" value="{../@路径}#{@url}"/>
				</OBJECT>
			</LI>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="ci">
	<xsl:for-each select="$indexXml/索引/词人/作家">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{姓名} "/>
				<xsl:choose>
					<xsl:when test="@词集路径">
						<param name="Local" value="{@词集路径}"/>
					</xsl:when>
					<xsl:otherwise>
						<param name="Local" value="{@传记路径}"/>
					</xsl:otherwise>
				</xsl:choose>
			</OBJECT>
			<xsl:if test="@简传 = '1' or @词集路径">
			<UL>
				<xsl:if test="@词集路径">
					<LI>
						<xsl:text> </xsl:text>
						<OBJECT type="text/sitemap">
							<param name="Name" value="词集"/>
							<param name="Local" value="{@词集路径}"/>
						</OBJECT>
					</LI>
				</xsl:if>
				<xsl:if test="@简传 = '1'">
					<LI>
						<xsl:text> </xsl:text>
						<OBJECT type="text/sitemap">
							<xsl:choose>
								<xsl:when test="@集评 = '1'">
									<param name="Name" value="传记、集评"/>
								</xsl:when>
								<xsl:otherwise>
									<param name="Name" value="传记"/>
								</xsl:otherwise>
							</xsl:choose>
							<param name="Local" value="{@传记路径}"/>
						</OBJECT>
					</LI>
				</xsl:if>
			</UL>
			</xsl:if>
		</LI>
	</xsl:for-each>

	<xsl:for-each select="/索引/词作/词/内容">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{../@词牌} ({translate(@text, '&#xA;&#xD;', '')})...{../@作家}"/>
				<param name="Local" value="{../@路径}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

<xsl:template name="format">
	<xsl:for-each select="/索引/格律/词牌/名称">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="{@名称}  词谱"/>
				<param name="Local" value="{../@路径}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

<xsl:template name="cinote">
	<xsl:for-each select="$indexXml/索引/注释/词汇">
		<LI>
			<xsl:text> </xsl:text>
			<OBJECT type="text/sitemap">
				<param name="Name" value="词汇 {@name}"/>
				<param name="Local" value="{@路径}"/>
			</OBJECT>
		</LI>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>