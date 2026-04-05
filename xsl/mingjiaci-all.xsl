<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:string="http://longyusheng.org/xslt/extensions/string" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:js="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl js string context">
	<xsl:output method="html" encoding="gbk"/>
	<!-- Parameters -->
	<xsl:param name="html"/>
	<!-- End of Parameters -->

	<xsl:variable name="p">
		<xsl:text>&#13;&#10;&#13;&#10;</xsl:text>
	</xsl:variable>
	<xsl:variable name="br">
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:variable>
	<xsl:param name="writerXml"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="名家词选/标题"/>
				</title>
				<link href="all.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<xsl:for-each select="名家词选/名家词[not(@edit) or @edit != '补']">
					<xsl:variable name="writer" select="$writerXml/*/作家[姓名[1] = current()/作家]"/>
					<h1>
						<xsl:value-of select="作家[1]"/>
					</h1>
					<p class="source">
						<xsl:value-of select="选本"/>
					</p>
					<div class="bibiography">
						<xsl:text>〔小传〕　</xsl:text>
						<xsl:for-each select="$writer/姓名">
							<xsl:value-of select="@说明"/>
							<u><xsl:value-of select="."/></u>
							<xsl:text>，</xsl:text>
						</xsl:for-each>
						<xsl:apply-templates select="$writer/介绍"/>
					</div>
					<div class="content">
						<xsl:for-each select="词[正文[not(@edit) or @edit != '补']]">
							<xsl:apply-templates select="词牌"/>
							<xsl:for-each select="正文[not(@edit) or @edit != '补']">
								<xsl:variable name="id" select="generate-id(current())"/>
								<xsl:if test="@edit">
									<div class="edit"><xsl:call-template name="edit"/></div>
								</xsl:if>
								<xsl:apply-templates select="preceding-sibling::*[1][self::题记][not(preceding-sibling::*[1][self::词牌])]" mode="title"/>
								<div class="lyric">
									<xsl:copy-of select="js:formatCi(string:Replace(string:Replace(string(段落), $p, '　　'), $br, ''))"/>
								</div>
								<xsl:variable name="comments" select="following-sibling::*[self::附录[not(注释)][not(@edit) or @edit != '补'] or self::校注][generate-id(preceding-sibling::正文[1]) = $id]"/>
								<xsl:if test="$comments">
									<div class="comments">
										<xsl:apply-templates select="$comments"/>
									</div>
								</xsl:if>
							</xsl:for-each>
						</xsl:for-each>
					</div>
					<xsl:if test="$writer/集评">
						<h3><xsl:text>〔集评〕</xsl:text></h3>
						<div class="comments">
							<xsl:for-each select="$writer/集评">
								<div>
									<span class="source">
										<xsl:text>【</xsl:text>
										<xsl:value-of select="出处"/>
										<xsl:value-of select="人物"/>
										<xsl:text>】</xsl:text>
									</span>
									<xsl:apply-templates select="段落"/>
								</div>
							</xsl:for-each>
						</div>
					</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="词牌">
		<xsl:variable name="title" select="following-sibling::*[1][self::题记]"/>
		<h3>
			<xsl:value-of select="text()"/>
			<xsl:if test="@别名">
				<span class="alias">
					<xsl:text>（</xsl:text>
					<xsl:value-of select="@别名"/>
					<xsl:text>）</xsl:text>
				</span>
			</xsl:if>
			<xsl:if test="$title">
				<xsl:text>　</xsl:text>
				<xsl:apply-templates select="$title" mode="subtitle"/>
			</xsl:if>
		</h3>
		<xsl:if test="$title">
			<xsl:apply-templates select="$title/题注"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="题记" mode="subtitle">
		<span class="title">
			<xsl:apply-templates select="text()|*[not(self::题注)]"/>
		</span>
	</xsl:template>
	<xsl:template match="题记" mode="title">
		<p class="title">
			<xsl:apply-templates select="text()|*[not(self::题注)]"/>
		</p>
		<xsl:apply-templates select="题注"/>
	</xsl:template>
	<xsl:template match="题注">
		<p class="sub-title"><xsl:apply-templates /></p>
	</xsl:template>

	<xsl:template match="附录">
		<div>
			<span class="source">
				<xsl:apply-templates select="出处[1]"/>
			</span>
			<span class="edit">
				<xsl:if test="@edit">
					<xsl:text>（</xsl:text>
					<xsl:call-template name="edit"/>
					<xsl:text>）</xsl:text>
				</xsl:if>
			</span>
			<xsl:choose>
				<xsl:when test="count(段落)=1">
					<xsl:apply-templates select="段落"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="段落|出处[position()&gt;1]">
						<xsl:apply-templates select="current()"/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="校注"/>
		</div>
	</xsl:template>
	<xsl:template match="出处">
		<xsl:text>【</xsl:text>
		<xsl:apply-templates select="text()|*"/>
		<xsl:text>】</xsl:text>
	</xsl:template>

	<xsl:template match="附录[注释]"/>
	
	<xsl:template match="校注">
		<div class="edit">
			<div>校注：</div>
			<xsl:for-each select="*">
				<div><xsl:apply-templates select="."/></div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="校注/注释">
		<b>
			<xsl:value-of select="@关键字"/>
		</b>
		<xsl:text>：</xsl:text>
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="专名|链接">
		<u><xsl:apply-templates/></u>
	</xsl:template>
	
	<xsl:template match="异文">
		<b>
			<xsl:value-of select="@文本"/>
		</b>
		<xsl:text>：</xsl:text>
		<xsl:choose>
			<xsl:when test="@类型">
				<xsl:value-of select="@类型"/>
			</xsl:when>
			<xsl:otherwise>别作</xsl:otherwise>
		</xsl:choose>
		<xsl:text>“</xsl:text>
		<xsl:value-of select="@别作"/>
		<xsl:text>”。</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template name="edit">
		<xsl:variable name="edit" select="@edit|../../@edit"/>
		<xsl:choose>
			<xsl:when test="$edit = '删'">
				<xsl:text>修订版删</xsl:text>
			</xsl:when>
			<xsl:when test="$edit = '增'">
				<xsl:text>修订版增</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>原版未收</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
