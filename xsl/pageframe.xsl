<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:import href="common.xsl"/>
	<xsl:param name="html"/>
	<xsl:param name="depth" select="'../'"/>
	<xsl:param name="PageTitle" select="''"/>
	<xsl:param name="UseTransitionEffect" select="'1'"/>
	<!-- <xsl:param name="GlobalTitle" select="'——龙榆生先生纪念网站'"/> -->
	<xsl:param name="GlobalTitle"/>
	<xsl:output method="html" indent="no" doctype-public="-//W3C//DTD HTML 4.0 Transitional//EN" encoding="gbk" />

	<!--# 页面主框架 -->
	<xsl:template match="/">
	<html>
		<head>
			<title><xsl:call-template name="PageTitle"/>
				<xsl:if test="$html != '1'">
					<xsl:value-of select="$GlobalTitle"/>
				</xsl:if>
			</title>
			<xsl:call-template name="PageTransitionMetaTag"/>
			<xsl:call-template name="PageKeywordsMetaTag"/>
			<xsl:call-template name="PageDescriptionMetaTag"/>
			<meta name="author" content="龙榆生, 左伟明" />
			<meta name="copyright" content="左伟明 (longyusheng.org), {$Date}" />
			<link href="{$depth}style.css" rel="stylesheet" type="text/css"/>
			<script language="javascript" type="text/javascript">
				<xsl:text>var depth = "</xsl:text>
				<xsl:value-of select="$depth"/>
				<xsl:text>";</xsl:text>
			</script>
			<script src="{$depth}site.js" language="javascript" type="text/javascript" defer="defer"/>
			<xsl:call-template name="PageHeadExtraItems"/>
		</head>

		<body>
			<div id="PageOuterFrame">
				<div id="PageInnerFrame">
					<xsl:call-template name="PageMainTemplate"/>
					<xsl:call-template name="copyright"/>
				</div>
			</div>
		</body>
	</html>
	</xsl:template>
	<!-- 页面主框架结束 -->

	<xsl:template name="PageTransitionMetaTag">
		<xsl:if test="$UseTransitionEffect = '1'">
			<meta http-equiv="Page-Enter" content="RevealTrans(Duration=0.5,Transition=7)"/>
		</xsl:if>
	</xsl:template>

	<!--# 用于重写的模板 -->
	<xsl:template name="PageMainTemplate">
		<xsl:call-template name="NavigationPart"/>
		<xsl:call-template name="TitlePart"/>
		<xsl:call-template name="RelatedLinksPart"/>
		<xsl:call-template name="BodyPart"/>
	</xsl:template>
	<xsl:template name="PageKeywordsMetaTag"/>
	<xsl:template name="PageDescriptionMetaTag"/>
	<xsl:template name="PageHeadExtraItems"/>
	<xsl:template name="NavigationPart"/>
	<xsl:template name="TitlePart"/>
	<xsl:template name="RelatedLinksPart"/>
	<xsl:template name="BodyPart"/>
	<!-- 用于重写的模板结束 -->
</xsl:stylesheet>

