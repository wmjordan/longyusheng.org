<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:f="http://longyusheng.org/xslt/extensions/ciFormat" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="msxsl context f">

	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl" />

	<xsl:param name="file"/>
	<xsl:param name="archive" select="$file/ancestor::资料档案[1]"/>

	<xsl:param name="唐宋名家词选" select="context:GetCachedDocument ('唐宋名家词选.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="近三百年名家词选" select="context:GetCachedDocument ('近三百年名家词选.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="唐宋词格律" select="context:GetCachedDocument ('唐宋词格律.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>

	<xsl:variable name="作者">
		<xsl:choose>
			<xsl:when test="$file/作者">
				<xsl:call-template name="ListWriters">
					<xsl:with-param name="article" select="$file"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ListWriters">
					<xsl:with-param name="article" select="$archive"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$archive/@archiveID = '.'">
				<xsl:text>龙榆生先生纪念网站</xsl:text>
			</xsl:when>
			<xsl:when test="$file">
				<xsl:if test="$file">
					<xsl:value-of select="$file/标题"/>
				</xsl:if>
				<xsl:if test="$file/作者 or $archive/作者">
					<xsl:value-of select="concat('(', $作者, ')')"/>
				</xsl:if>
				<xsl:if test="$file/标题 != $archive/标题">
					<xsl:text>——</xsl:text>
					<xsl:value-of select="$archive/标题"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$archive/标题"/>
				<xsl:if test="$archive/作者">
					<xsl:value-of select="concat('(', $作者, ')')"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<xsl:if test="not ($archive/@archiveID = '.')">
			<xsl:call-template name="ArticleNavigationPart"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<meta name="keywords">
			<xsl:attribute name="content">
				<xsl:for-each select="$file/ancestor-or-self::档案文章[1]//关键字|$archive/关键字">
					<xsl:value-of select="."/>
					<xsl:text>, </xsl:text>
				</xsl:for-each>
				<xsl:value-of select="$archive/标题"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<xsl:template name="TitlePart">
		<xsl:if test="not ($file/@fileID = 'cover')">
			<div class="PrintContent"><xsl:value-of select="$archive/标题"/></div>
			<h1 class="PageTitle">
				<xsl:choose>
					<xsl:when test="$file"><xsl:apply-templates select="$file/标题"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$archive/标题"/></xsl:otherwise>
				</xsl:choose>
			</h1>
			<xsl:copy-of select="$作者"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$file">
					<xsl:apply-templates select="$file" mode="default"/>
					<xsl:if test="not ($archive/@archiveID = '.')">
						<xsl:call-template name="LinkNextArticle">
							<xsl:with-param name="article" select="$file"/>
						</xsl:call-template>
						<xsl:call-template name="LinkPreviousArticle">
							<xsl:with-param name="article" select="$file"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="$archive"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template name="ListWriters">
		<xsl:param name="article"/>
		<div class="writer">
			<xsl:for-each select="$article/作者">
				<xsl:if test="position() != 1">
					<xsl:text>、</xsl:text>
				</xsl:if>
				<u><xsl:value-of select="."/></u>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template name="PageDescriptionMetaTag">
		<meta name="description" content="{$archive/概述}" />
	</xsl:template>

	<xsl:template match="资料档案">
		<div style="padding-left: 15pt;">
			<xsl:if test="概述">
				<div><xsl:apply-templates select="概述"/></div>
			</xsl:if>
			<xsl:for-each select="档案文章">
				<div>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'file'"/>
								<xsl:with-param name="ref" select="@fileID"/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:apply-templates select="标题"/>
					</a>
					<xsl:if test="作者">
						<xsl:text>（</xsl:text>
						<xsl:for-each select="作者">
							<xsl:if test="position() != 1">
								<xsl:text>、</xsl:text>
							</xsl:if>
							<u><xsl:value-of select="."/></u>
						</xsl:for-each>
						<xsl:text>）</xsl:text>
					</xsl:if>
					<xsl:apply-templates select="正文/档案文章"/>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="档案文章/正文">
		<xsl:apply-templates select="副标题|段落|小标题|列举项|代码|引文|档案文章|代码段"/>
	</xsl:template>

	<xsl:template match="说明|附注">
		<xsl:apply-templates select="段落|列举项|代码|引文|代码段"/>
	</xsl:template>
	<xsl:template match="引用附注">
		<xsl:variable name="num">
			<xsl:number count="引用附注" level="any" from="正文" format="1" />
		</xsl:variable>
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id">
					<xsl:value-of select="@id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$num"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="title">
			<xsl:choose>
				<xsl:when test="string-length(.) != 0">
					<xsl:value-of select="concat('查看“', ., '”的附注（本页）')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('查看本页附注 ', $num)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates />
		<sup>
			<a href="#fn{$id}" name="qfn{$id}" class="Ref" title="{$title}">[<xsl:value-of select="$num"/>]</a>
		</sup>
	</xsl:template>
	<xsl:template match="附注/段落[@id]">
		<p>
			<sup>
				<a name="fn{@id}" href="#qfn{@id}" class="Ref" title="返回附注对应的位置">[<xsl:value-of select="count(preceding-sibling::段落[@id])+1"/>]</a>
			</sup>
			<xsl:variable name="text">
				<xsl:value-of select="ancestor::档案文章[1]/正文//引用附注[@id=current()/@id or position() = current()/@id]"/>
			</xsl:variable>
			<xsl:if test="string-length($text) != 0"><xsl:value-of select="$text"/>：</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="正文/档案文章">
		<div style="padding-left: 15pt;">
			<xsl:number level="single" count="档案文章" format="一、"/>
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'file'"/>
						<xsl:with-param name="ref" select="@fileID"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:apply-templates select="标题"/>
			</a>
		</div>
	</xsl:template>

	<xsl:template match="注释">
		<span class="note"><xsl:apply-templates /></span>
	</xsl:template>

	<xsl:template match="档案文章" mode="default">
		<xsl:variable name="说明" select="ancestor-or-self::*[self::档案文章|self::资料档案]/说明"/>
		<xsl:variable name="附注" select="ancestor-or-self::*[self::档案文章|self::资料档案]/附注"/>
		<xsl:if test="$说明">
			<div class="HeadNote"><xsl:apply-templates select="$说明"/></div>
		</xsl:if>
		<xsl:apply-templates select="正文"/>
		<xsl:if test="$附注">
			<div class="FootNote">
				<div class="ItemTitle">附注：</div>
				<xsl:apply-templates select="$附注"/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="副标题">
		<h2><a name="st{count(preceding-sibling::副标题)}"/><xsl:apply-templates /></h2>
	</xsl:template>

	<xsl:template match="小标题">
		<h3><xsl:apply-templates /></h3>
	</xsl:template>

	<xsl:template match="段落">
		<p>
			<xsl:if test="not (@缩进) or (@缩进 != 'false')">
				<xsl:text>　　</xsl:text>
			</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="引文[name(child::*[1])='引用']">
		<blockquote class="quot">
			<xsl:for-each select="引用">
				<div class="body">
					<xsl:copy-of select="f:formatCi(string(current()))"/>
				</div>
			</xsl:for-each>
			<br />
		</blockquote>
		<xsl:if test="出处[text()|*]">
			<div align="right"><xsl:apply-templates select="(出处/text())|(出处/*)"/></div>
		</xsl:if>
	</xsl:template>
	<xsl:template match="引文[child::*[1][self::出处]]">
		<xsl:if test="出处[text()|*]">
			<div align="right"><xsl:apply-templates select="(出处/text())|(出处/*)"/></div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="引文[@xhref and not(引用)]">
		<blockquote class="quot">
			<xsl:variable name="ciID" select="substring-after(current()/@xhref, '$')"/>
			<xsl:choose>
				<xsl:when test="$indexXml/索引/特选词作[@名称='唐宋名家词选']/词[@id=$ciID]">
					<xsl:copy-of select="f:formatCi(string($唐宋名家词选/名家词选/名家词/词/*[self::正文 or self::别作版本][@id=$ciID]/段落))"/>
				</xsl:when>
				<xsl:when test="$indexXml/索引/特选词作[@名称='近三百年名家词选']/词[@id=$ciID]">
					<xsl:copy-of select="f:formatCi(string($近三百年名家词选/名家词选/名家词/词/正文[@id=$ciID]/段落))"/>
				</xsl:when>
			</xsl:choose>
		</blockquote>
	</xsl:template>

	<xsl:template match="列举项">
		<xsl:choose>
			<xsl:when test="contains ('1IiAa', @形式)">
				<ol class="MF_enum1" type="{@形式}">
					<xsl:for-each select="项目|列举项">
						<xsl:choose>
							<xsl:when test="name()='项目'">
								<li class="MF_enum1">
									<xsl:apply-templates />
								</li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</ol>
			</xsl:when>
			<xsl:when test="contains ('square disc circle', @形式)">
				<ul class="MF_enum1" type="{@形式}">
					<xsl:for-each select="项目|列举项">
						<xsl:choose>
							<xsl:when test="name()='项目'">
								<li class="MF_enum1">
									<xsl:apply-templates />
								</li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</ul>
			</xsl:when>
			<xsl:when test="@形式='一、'">
				<div class="MF_enum0">
					<xsl:for-each select="项目|列举项">
						<xsl:choose>
							<xsl:when test="name()='项目'">
								<div class="MF_enum0">
									<xsl:number count="项目" level="single" format="一、"/>
									<xsl:apply-templates />
								</div>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="MF_enum0">
					<xsl:for-each select="项目|列举项">
						<xsl:choose>
							<xsl:when test="name()='项目'">
								<div class="MF_enum0">
									<xsl:value-of select="@形式"/>
									<xsl:apply-templates />
								</div>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ArticleNavigationPart">
		<div class="NaviPart">
			<xsl:text>当前位置：</xsl:text>
			<xsl:choose>
				<xsl:when test="$file/@siteMapID">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$file/@siteMapID"/>
					</xsl:call-template>
					<xsl:value-of select="$file/标题"/>
				</xsl:when>
				<xsl:when test="$file/ancestor::资料档案[@archiveID]">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$file/ancestor::资料档案/@archiveID"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="not($file)">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$archive/@archiveID"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ListAncestorsInSiteMap"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="NavigationPartExtraAncestors"/>
		</div>
	</xsl:template>

	<xsl:template name="RelatedLinksPart">
		<xsl:if test="not ($archive/@archiveID = '.')">
			<xsl:variable name="ref">
				<xsl:if test="$file/正文/副标题 and not($file[@subTitleNavigation = 'false'])">
					<xsl:call-template name="ListSubTitleNavigation"/>
				</xsl:if>
				<xsl:apply-templates select="$file/相关链接"/>
				<xsl:choose>
					<xsl:when test="$file/@siteMapID">
						<xsl:call-template name="ListSiblingsInSiteMap">
							<xsl:with-param name="id" select="$file/@siteMapID"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$file/ancestor::资料档案[@archiveID]">
						<xsl:call-template name="ListSiblingsInSiteMap">
							<xsl:with-param name="id" select="$file/ancestor::资料档案/@archiveID"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ListSiblingsInSiteMap"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="NavigationPartExtraSiblings"/>
			</xsl:variable>
			<xsl:if test="msxsl:node-set($ref)/*">
				<ul class="NaviPart">
					<xsl:copy-of select="$ref" />
				</ul>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="NavigationPartExtraAncestors">
		<xsl:for-each select="$file/ancestor::档案文章">
			<xsl:call-template name="siteMapNodeLink">
				<xsl:with-param name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'file'"/>
						<xsl:with-param name="ref" select="@fileID"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="text" select="标题"/>
				<xsl:with-param name="separator" select="'／'"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="NavigationPartExtraSiblings">
		<xsl:if test="$file">
			<xsl:variable name="refs" select="$file/正文/*[not(self::档案文章)]/descendant-or-self::*[starts-with(@xhref, '$')]"/>
			<xsl:if test="$refs">
				<ul class="jd_menu">
					<li class="title">
						<div>相关词作</div>
						<ul>
						<xsl:for-each select="$refs">
							<xsl:variable name="xhref" select="@xhref"/>
							<xsl:variable name="pos" select="position()"/>
							<xsl:if test="not ($refs[position() &lt; $pos][@xhref = $xhref])">
								<xsl:variable name="refNode" select="$indexXml/索引/特选词作/词[@id=substring-after(current()/@xhref, '$')]"/>
								<li>
									<a>
										<xsl:attribute name="href">
											<xsl:call-template name="mappath">
												<xsl:with-param name="type" select="'ci'"/>
												<xsl:with-param name="ref" select="substring-after(@xhref, '$')"/>
											</xsl:call-template>
										</xsl:attribute>
										<u><xsl:value-of select="$refNode/@作家"/></u>
										<xsl:text>《</xsl:text>
										<xsl:value-of select="$refNode/@词牌"/>
										<xsl:text>》（</xsl:text>
										<xsl:value-of select="$refNode/@首行内容"/>
										<xsl:text>）</xsl:text>
									</a>
								</li>
							</xsl:if>
						</xsl:for-each>
						</ul>
					</li>
				</ul>
			</xsl:if>
		</xsl:if>
	</xsl:template>

<xsl:template name="LinkNextArticle">
	<xsl:param name="article" select="current()"/>
	<xsl:variable name="nextSibling" select="$article/following::档案文章[1]"/>
	<xsl:variable name="firstDecendant" select="$article//档案文章[1]"/>
	<xsl:choose>
		<xsl:when test="$firstDecendant">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$firstDecendant"/>
				<xsl:with-param name="id" select="'anc_next'"/>
				<xsl:with-param name="label" select="'下一篇：'"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$nextSibling">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$nextSibling"/>
				<xsl:with-param name="id" select="'anc_next'"/>
				<xsl:with-param name="label" select="'下一篇：'"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="LinkPreviousArticle">
	<xsl:param name="article" select="current()"/>
	<xsl:variable name="previousSibling" select="$article/preceding-sibling::档案文章[1]"/>
	<xsl:variable name="firstAncestor" select="$article/ancestor::档案文章[1]"/>
	<xsl:choose>
		<xsl:when test="$previousSibling">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$previousSibling"/>
				<xsl:with-param name="id" select="'anc_prev'"/>
				<xsl:with-param name="label" select="'上一篇：'"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$firstAncestor">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$firstAncestor"/>
				<xsl:with-param name="id" select="'anc_prev'"/>
				<xsl:with-param name="label" select="'上一篇：'"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="LinkToArticle">
	<xsl:param name="article"/>
	<xsl:param name="label"/>
	<xsl:param name="id"/>
	<div class="NaviPart">
		<xsl:value-of select="$label"/>
		<a>
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:attribute name="href">
				<xsl:call-template name="mappath">
					<xsl:with-param name="type" select="'file'"/>
					<xsl:with-param name="ref">
						<xsl:choose>
							<xsl:when test="$article/@fileID != 'index'">
								<xsl:value-of select="$article/@fileID"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$article/../@archiveID"/>
								<xsl:text>-index</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="$article/标题"/>
		</a>
	</div>
</xsl:template>

	<xsl:template name="ListSubTitleNavigation">
		<li class="title">本页内容</li>
		<xsl:for-each select="$file/正文/副标题">
			<li>
				<a href="#st{position()-1}"><xsl:value-of select="."/></a>
			</li>
		</xsl:for-each>
	</xsl:template>

<xsl:template name="copyrightText">
		<xsl:choose>
			<xsl:when test="$archive/@archiveID = '.'"/>
			<xsl:when test="$file">
				<xsl:apply-templates select="$file/ancestor::资料档案/著作权"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="$archive/著作权"/>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

</xsl:stylesheet>