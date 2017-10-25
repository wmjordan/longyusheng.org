<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="context">
	<xsl:import href="common.xsl" />

<!-- 生成 CHM 项目的目录文件 hhc -->
	<xsl:output method="html" encoding="gb2312" indent="yes"/>

	<xsl:variable name="numXml" select="context:GetCachedDocument ('xsl/ChineseNum.xml')/中文数字"/>

<xsl:template name="档案">
	<xsl:param name="资料档案ID"/>
	<xsl:variable name="档案" select="/索引/档案[@id=$资料档案ID]"/>
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name" value="{$档案/@名称}"/>
			<param name="ImageNumber" value="1"/>
			<param name="Local" value="{$档案/@路径}"/>
		</object>
		<ul>
			<xsl:apply-templates select="$档案/文章"/>
		</ul>
	</li>
</xsl:template>

<xsl:template match="文章">
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name">
				<xsl:attribute name="value">
					<xsl:value-of select="标题"/>
					<xsl:if test="string-length (@作者) and @作者 != '龙榆生'">
						<xsl:text>...</xsl:text>
						<xsl:value-of select="@作者"/>
					</xsl:if>
				</xsl:attribute>
			</param>
			<param name="Local" value="{@路径}"/>
		</object>
		<xsl:if test="文章">
			<ul>
				<xsl:apply-templates select="文章"/>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

<!-- 生成 CHM 项目的目录文件 hhc -->
	<xsl:template match="/">
		<html>
			<head>
			<meta name="generator" content="Microsoft Html Help Workshop 4.1"/>
			<xsl:comment> Sitemap 1.0 </xsl:comment>
			</head>
			<body>
				<object type="text/site properties">
					<param name="Window Styles" value="0x800627"/>
					<param name="ImageType" value="Folder"/>
				</object>
				<ul>
					<xsl:call-template name="siteMapNode">
						<xsl:with-param name="text" select="'龙榆生先生词学著作选'"/>
						<xsl:with-param name="ref" select="'root'"/>
					</xsl:call-template>
					<li>
						<xsl:call-template name="siteMapNodeObject">
							<xsl:with-param name="text" select="'唐宋名家词选'"/>
							<xsl:with-param name="ref" select="'tangsongci-index'"/>
							<xsl:with-param name="icon" select="'1'"/>
						</xsl:call-template>
						<ul>
							<xsl:apply-templates select="/索引/档案[@id='tangsongci']/文章[not(contains(@路径, 'index.html'))]"/>
							<xsl:call-template name="ci">
								<xsl:with-param name="选集名称" select="'唐宋名家词选'"/>
								<xsl:with-param name="siteMapId" select="'tangsongci-index1'"/>
							</xsl:call-template>
							<xsl:call-template name="siteMapNode">
								<xsl:with-param name="text" select="'词作收录数一览'"/>
								<xsl:with-param name="ref" select="'tangsongci-index3'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
							<xsl:call-template name="zhuanji">
								<xsl:with-param name="选集名称" select="'唐宋名家词选'"/>
								<xsl:with-param name="siteMapId" select="'tangsongci-biblio'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
						</ul>
					</li>
					<li>
						<xsl:call-template name="siteMapNodeObject">
							<xsl:with-param name="text" select="'近三百年名家词选'"/>
							<xsl:with-param name="ref" select="'jindaici-index'"/>
							<xsl:with-param name="icon" select="'1'"/>
						</xsl:call-template>
						<ul>
							<xsl:apply-templates select="/索引/档案[@id='jindaici']/文章[not(contains(@路径, 'index.html'))]"/>
							<xsl:call-template name="ci">
								<xsl:with-param name="选集名称" select="'近三百年名家词选'"/>
								<xsl:with-param name="siteMapId" select="'jindaici-index1'"/>
							</xsl:call-template>
							<xsl:call-template name="siteMapNode">
								<xsl:with-param name="text" select="'词作收录数一览'"/>
								<xsl:with-param name="ref" select="'jindaici-index3'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
							<xsl:call-template name="zhuanji">
								<xsl:with-param name="选集名称" select="'近三百年名家词选'"/>
								<xsl:with-param name="siteMapId" select="'jindaici-biblio'"/>
							</xsl:call-template>
						</ul>
					</li>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'zhongguoyunwenshi'"/>
					</xsl:call-template>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'cixueshijiang'"/>
					</xsl:call-template>
					<xsl:call-template name="format"/>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'lunwen'"/>
					</xsl:call-template>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'xintigequ'"/>
					</xsl:call-template>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'zawen'"/>
					</xsl:call-template>
					<xsl:call-template name="档案">
						<xsl:with-param name="资料档案ID" select="'jinian'"/>
					</xsl:call-template>
					<xsl:apply-templates select="/索引/档案[@id='about']/文章[@id='gy-shiyongshuoming']"/>
					<xsl:apply-templates select="/索引/档案[@id='about']/文章[@id='gy-zhizuozhe']"/>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="龙榆生先生纪念网站（在线）"/>
							<param name="URL" value="http://longyusheng.org"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="龙榆生先生纪念网站微博（在线）"/>
							<param name="URL" value="http://weibo.com/lys1902"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="龙榆生先生纪念网站开放源代码项目（在线）"/>
							<param name="URL" value="http://git.oschina.net/longyusheng/longyusheng"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
				</ul>
			</body>
		</html>
	</xsl:template>

<xsl:template name="ci">
	<xsl:param name="选集名称"/>
	<xsl:param name="siteMapId"/>
	<li>
		<xsl:call-template name="siteMapNodeObject">
			<xsl:with-param name="text" select="'目录'"/>
			<xsl:with-param name="ref" select="$siteMapId"/>
			<xsl:with-param name="icon" select="'1'"/>
		</xsl:call-template>
		<ul>
			<xsl:variable name="索引" select="/索引/词人[@名称=$选集名称]"/>
			<xsl:variable name="选集" select="/索引/词作[@名称=$选集名称]"/>
			<xsl:for-each select="$索引/作家">
				<xsl:variable name="词作" select="$选集/词[@作家=current()/姓名]"/>
				<li>
					<xsl:text> </xsl:text>
					<object type="text/sitemap">
						<param name="Name">
							<xsl:attribute name="value">
								<xsl:call-template name="formatName">
									<xsl:with-param name="n" select="姓名"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:value-of select="$numXml/数字[count($词作/node())]/@小写"/>
								<xsl:text>首</xsl:text>
							</xsl:attribute>
						</param>
						<param name="Local" value="{@词集路径}"/>
						<param name="ImageNumber" value="1"/>
					</object>
					<ul>
					<xsl:if test="$索引/作家[姓名 = current()/姓名 and @简传='1']">
						<li>
							<xsl:text> </xsl:text>
							<object type="text/sitemap">
								<param name="Name">
									<xsl:attribute name="value">
										<xsl:call-template name="formatName">
											<xsl:with-param name="n" select="姓名"/>
										</xsl:call-template>
										<xsl:text>　传记</xsl:text>
									</xsl:attribute>
								</param>
								<param name="Local" value="{@传记路径}"/>
							</object>
						</li>
					</xsl:if>
					<xsl:for-each select="$选集/词[@作家=current()/姓名]">
						<li>
							<xsl:text> </xsl:text>
							<object type="text/sitemap">
								<param name="Name">
									<xsl:attribute name="value">
										<xsl:value-of select="concat(@词牌, ' (', translate(内容[1]/@text, '&#xA;&#xD;', ''), ')')"/>
										<xsl:choose>
											<xsl:when test="count(内容) != 1">
												<xsl:value-of select="concat(' 等',$numXml/数字[count(current()/内容)]/@小写, '首')"/>
											</xsl:when>
										</xsl:choose>
									</xsl:attribute>
								</param>
								<param name="Local" value="{@路径}"/>
								<param name="ImageNumber" value="17"/>
							</object>
						</li>
					</xsl:for-each>
					</ul>
				</li>
			</xsl:for-each>
		</ul>
	</li>
</xsl:template>

<xsl:template name="zhuanji">
	<xsl:param name="选集名称"/>
	<xsl:param name="siteMapId"/>
	<xsl:call-template name="siteMapNode">
		<xsl:with-param name="text" select="'词人传记、集评一览'"/>
		<xsl:with-param name="ref" select="$siteMapId"/>
		<xsl:with-param name="icon" select="35"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="format">
	<li>
		<xsl:call-template name="siteMapNodeObject">
			<xsl:with-param name="text" select="'唐宋词格律'"/>
			<xsl:with-param name="ref" select="'cipai-index'"/>
			<xsl:with-param name="icon" select="'1'"/>
		</xsl:call-template>
		<ul>
			<xsl:apply-templates select="/索引/档案[@id='cipai']/文章[not(contains(@路径, 'index.html'))]"/>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'原书目录'"/>
				<xsl:with-param name="ref" select="'gl-mulu'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'词牌读音排序目录'"/>
				<xsl:with-param name="ref" select="'gl-pinyin'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'词牌字数排序目录'"/>
				<xsl:with-param name="ref" select="'gl-zishu'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="列出词牌">
				<xsl:with-param name="类别">平韵格</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="列出词牌">
				<xsl:with-param name="类别">仄韵格</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="列出词牌">
				<xsl:with-param name="类别">平仄韵转换格</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="列出词牌">
				<xsl:with-param name="类别">平仄韵通叶格</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="列出词牌">
				<xsl:with-param name="类别">平仄韵错叶格</xsl:with-param>
			</xsl:call-template>
		</ul>
	</li>
</xsl:template>

<xsl:template name="列出词牌">
	<xsl:param name="类别"/>
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name" value="{$类别}"/>
			<param name="ImageNumber" value="1"/>
		</object>
		<ul>
		<xsl:for-each select="/索引/格律/词牌[类别=$类别]">
			<li>
				<xsl:text> </xsl:text>
				<object type="text/sitemap">
					<param name="Name">
						<xsl:attribute name="value">
							<xsl:for-each select="名称">
								<xsl:if test="position() != 1">
									<xsl:text>、</xsl:text>
								</xsl:if>
								<xsl:value-of select="@名称"/>
							</xsl:for-each>
						</xsl:attribute>
					</param>
					<param name="Local" value="{@路径}"/>
				</object>
			</li>
		</xsl:for-each>
		</ul>
	</li>
</xsl:template>

<xsl:template name="siteMapNode">
	<xsl:param name="text"/>
	<xsl:param name="ref"/>
	<xsl:param name="icon"/>
	<li>
		<xsl:call-template name="siteMapNodeObject">
			<xsl:with-param name="text" select="$text"/>
			<xsl:with-param name="ref" select="$ref"/>
			<xsl:with-param name="icon" select="$icon"/>
		</xsl:call-template>
	</li>
</xsl:template>

<xsl:template name="siteMapNodeObject">
	<xsl:param name="text"/>
	<xsl:param name="ref"/>
	<xsl:param name="icon"/>
	<xsl:text> </xsl:text>
	<object type="text/sitemap">
		<param name="Name" value="{$text}"/>
		<param name="Local">
			<xsl:attribute name="value">
				<xsl:call-template name="mappath">
					<xsl:with-param name="type">site</xsl:with-param>
					<xsl:with-param name="ref" select="$ref"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:if test="$icon">
				<param name="ImageNumber" value="{$icon}"/>
			</xsl:if>
		</param>
	</object>
</xsl:template>
</xsl:stylesheet>