<?xml version="1.0" encoding="GB2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:string="http://longyusheng.org/xslt/extensions/string" xmlns:ci="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl context string ci">
	<xsl:param name="indexXml" select="context:GetCachedDocument ('索引文件.xml')"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('注释.xml')"/>
	<xsl:param name="siteMapXml" select="context:GetCachedDocument ('SiteMap.xml')"/>
	<xsl:param name="siteMapId"/>
	<xsl:param name="depth" select="'../'"/>

	<!--# 通用变量 -->
	<xsl:variable name="SupportCjkExt" select="function-available('ci:encodeCjkExtText')"/>
	<xsl:variable name="AnchorNext" select="'anc_next'"/>
	<xsl:variable name="AnchorPrev" select="'anc_prev'"/>
	<xsl:variable name="Date">
		<xsl:if test="$indexXml">
			<xsl:value-of select="$indexXml/索引/@date"/>
		</xsl:if>
	</xsl:variable>

	<xsl:template match="著作权">
		<div><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="段落">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="专名">
		<u><xsl:apply-templates /></u>
	</xsl:template>
	<xsl:template match="着重">
		<strong><xsl:apply-templates /></strong>
	</xsl:template>
	<xsl:template match="引用">
		<span class="q"><xsl:apply-templates /></span>
	</xsl:template>
	<xsl:template match="引文">
		<div class="quot"><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="引文[段落]">
		<div class="quot"><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="省略">
		<span style="color: #999999" title="此处较原书省略若干字">……</span>
	</xsl:template>
	<xsl:template match="读音">
		<xsl:if test="@字符|text()">
			<span><xsl:value-of select="@字符|text()"/></span>
		</xsl:if>
		<sup class="reading-note">
			<xsl:choose>
				<xsl:when test="@国粤音">
					<xsl:text>国粤音</xsl:text>
					<span class="reading">
						<xsl:value-of select="@国粤音"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="@国音|@粤音">
						<xsl:if test="position() > 1">
							<xsl:text>，</xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="name() = '国音'">
								<xsl:text>音</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="name()"/>
							</xsl:otherwise>
						</xsl:choose>
						<span class="reading">
							<xsl:value-of select="."/>
						</span>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</sup>
	</xsl:template>
	<xsl:template match="代码/text()|代码段/text()">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>
	<xsl:template match="代码/*|代码段/*">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="出处">
		<sup><xsl:apply-templates /></sup>
	</xsl:template>
	<xsl:template match="图片">
		<div>
			<xsl:choose>
				<xsl:when test="@class">
					<xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">image</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="style">
				<xsl:choose>
					<xsl:when test="@placement = 'center'">
						<xsl:text>text-align: center;</xsl:text>
					</xsl:when>
					<xsl:when test="@placement = 'left'">
						<xsl:text>float: left;</xsl:text>
					</xsl:when>
					<xsl:when test="@placement = 'right'">
						<xsl:text>float: right;</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:attribute>
			<xsl:variable name="elementName">
				<xsl:choose>
					<xsl:when test="@canEnlarge = 'true' or @href">
						<xsl:text>a</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>span</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:element name="{$elementName}">
				<xsl:choose>
					<xsl:when test="@canEnlarge = 'true'">
						<xsl:attribute name="href"><xsl:value-of select="$depth"/><xsl:value-of select="@src"/></xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
					</xsl:when>
					<xsl:when test="@href">
						<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<img src="{$depth}{@src}" alt="{text()|说明}">
					<xsl:if test="@canEnlarge = 'true'">
						<xsl:attribute name="alt">
							<xsl:value-of select="text()"/>
							<xsl:if test="text()">
								<xsl:text>&#xa;</xsl:text>
							</xsl:if>（点击图片查看大图）</xsl:attribute>
					</xsl:if>
					<xsl:if test="@width">
						<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="@height">
						<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
					</xsl:if>
				</img>
			</xsl:element>
			<div class="image-desc"><xsl:apply-templates select="说明" mode="picNote"/></div>
		</div>
	</xsl:template>
	<xsl:template match="书签">
		<a name="{@name}"><xsl:apply-templates /></a>
	</xsl:template>
	<xsl:template match="段落/关键字">
		<a name="{@url}"></a>
	</xsl:template>
	<xsl:template match="图片/说明" mode="picNote">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="注释">
		<xsl:for-each select="text()|*">
			<xsl:choose>
				<xsl:when test="self::段落">
					<span class="note"><xsl:apply-templates /></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="current()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="链接">
		<xsl:choose>
			<xsl:when test="@xhref='#'">
				<a title="参见 {.} 传记">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'biblio'"/>
							<xsl:with-param name="ref" select="."/>
						</xsl:call-template>
					</xsl:attribute>
					<u>
						<xsl:apply-templates/>
					</u>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '#')">
				<a title="参见 {substring-after(@xhref, '#')} 传记">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'biblio'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '#')"/>
						</xsl:call-template>
					</xsl:attribute>
					<u>
						<xsl:apply-templates/>
					</u>
				</a>
			</xsl:when>
			<xsl:when test="@xhref='@'">
				<a title="参见 {.} 词集">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'coll'"/>
							<xsl:with-param name="ref" select="."/>
						</xsl:call-template>
					</xsl:attribute>
					<u>
						<xsl:apply-templates/>
					</u>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '@')">
				<a title="参见 {substring-after(@xhref, '@')} 词集">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'coll'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '@')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '$')">
				<xsl:variable name="refNode" select="$indexXml/索引/特选词作/词[@id=substring-after(current()/@xhref, '$')]"/>
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'ci'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '$')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="concat('参见 ', $refNode/@作家, '〖', $refNode/@词牌, '〗&#x0D;&#x0A;', $refNode/@首行内容, '……' )"/></xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?a=')">
				<xsl:variable name="title" select="concat('《', $indexXml/索引/档案[@id=substring-after(current()/@xhref, '?a=')]/@名称, '》')"/>
				<a title="参见{$title}">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'arc'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '?a=')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="node()">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$title"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?f=')">
				<xsl:variable name="article" select="$indexXml/索引/档案//文章[@id=substring-after(current()/@xhref, '?f=')]"/>
				<xsl:variable name="title" select="concat('《', $article/ancestor::档案[1]/@名称, '·', $article/标题, '》')"/>
				<a title="参见{$title}">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'file'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '?f=')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="node()">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$title"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</xsl:when>
			<xsl:when test="@xhref='?fmt='">
				<xsl:call-template name="CreateLinkToFormat">
					<xsl:with-param name="name" select="current ()"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?fmt=')">
				<xsl:call-template name="CreateLinkToFormat">
					<xsl:with-param name="name" select="substring-after(@xhref, '?fmt=')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?s=')">
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'site'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '?s=')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?note=')">
				<xsl:choose>
					<xsl:when test="$ciNotesXml">
						<xsl:variable name="word" select="substring-after(@xhref, '?note=')"/>
						<xsl:variable name="note" select="$ciNotesXml/资料档案/索引/注释[词汇=$word]"/>
						<a class="Ref" title="参见 {$word} 的注释">
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="$note/../@ID"/>
									<xsl:with-param name="val" select="$note/词汇[1]"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<i style="err"><xsl:apply-templates /></i>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@xhref = '?'">
				<xsl:choose>
					<xsl:when test="$ciNotesXml">
						<xsl:variable name="note" select="$ciNotesXml/资料档案/索引/注释[词汇=current()/text()]"/>
						<a class="Ref" title="参见 {text()} 的注释">
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="$note/../@ID"/>
									<xsl:with-param name="val" select="$note/词汇[1]"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<i style="err"><xsl:apply-templates /></i>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<a href="{@xhref}">
					<xsl:if test="contains (@xhref, '://')">
						<xsl:attribute name="target">_blank</xsl:attribute>
						<xsl:attribute name="class">ExLink</xsl:attribute>
					</xsl:if>
					<xsl:if test="@xtitle">
						<xsl:attribute name="title"><xsl:value-of select="@xtitle"/></xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="CreateLinkToFormat">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$indexXml/索引/格律/词牌/名称[@名称 = $name]">
				<a title="参见 {$name} 词牌">
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'format'"/>
							<xsl:with-param name="ref" select="$name"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:value-of select="current()"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'format'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '?fmt=')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:apply-templates />
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ListReferenceArticles">
		<!--列出相关的文章，传入参数的结构为：“*[@id][标题]/文章[@路径][标题]”-->
		<xsl:param name="articles"/>
		<xsl:if test="$articles">
			<li class="title">相关文章</li>
			<xsl:for-each select="$articles">
				<li class="sub">
					<xsl:text>《</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'arc'"/>
								<xsl:with-param name="ref" select="@id"/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="标题"/>
					</a>
					<xsl:text>》</xsl:text>
				</li>
				<xsl:for-each select="文章">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="''"/>
									<xsl:with-param name="ref" select="@路径"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:apply-templates select="标题/node()"/>
						</a>
					</li>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template name="mappath">
		<xsl:param name="type"/>
		<xsl:param name="ref"/>
		<xsl:param name="val"/>
		<xsl:choose>
			<xsl:when test="$type = ''">
				<xsl:value-of select="concat ($depth, $ref)"/>
			</xsl:when>
			<xsl:when test="$type = 'biblio'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/词人/作家[姓名 = $ref]/@传记路径)"/>
			</xsl:when>
			<xsl:when test="$type = 'coll'">
				<xsl:choose>
					<xsl:when test="$val">
						<xsl:value-of select="concat ($depth, $indexXml/索引/词作/词[@作家 = $ref][position() = $val]/@路径)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat ($depth, $indexXml/索引/词人/作家[姓名 = $ref]/@词集路径)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$type = 'format'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/格律/词牌[名称/@名称 = $ref]/@路径)"/>
			</xsl:when>
			<xsl:when test="$type = 'note'">
				<xsl:value-of select="concat($depth, $type, '/', $ref, '/', string:UnicodeEncode(string($val)), '.html')"/>
			</xsl:when>
			<xsl:when test="$type = 'ci'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/特选词作/词[@id=$ref]/@路径)"/>
			</xsl:when>
			<xsl:when test="$type = 'site'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/siteMaps/siteMap[@id=$ref]/@url)"/>
			</xsl:when>
			<xsl:when test="$type = 'file'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/档案//文章[@id = $ref]/@路径)"/>
			</xsl:when>
			<xsl:when test="$type = 'arc'">
				<xsl:value-of select="concat ($depth, $indexXml/索引/档案[@id = $ref]/@路径)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Unknown link type: <xsl:value-of select="$type"/>.</xsl:message>
				<!-- <xsl:value-of select="concat($type, $ref, '.html')"/> -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="formatName">
		<xsl:param name="n"/>
		<xsl:choose>
			<xsl:when test="string-length($n) = 2">
				<xsl:value-of select="concat (substring($n, 1, 1), '　', substring ($n, 2))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$n"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="chNumber">
		<xsl:param name="n"/>
		<xsl:variable name="s" select="substring($n, 1, 1)"/>
		<xsl:variable name="s2" select="substring($n, 2)"/>
		<xsl:variable name="r">
			<xsl:choose>
				<xsl:when test="string-length($n) != 2">
					<xsl:value-of select="$n"/>
				</xsl:when>
				<xsl:when test="$n = '10'">
					<xsl:text>-</xsl:text>
				</xsl:when>
				<xsl:when test="$s = '0'">
					<xsl:value-of select="$s2"/>
				</xsl:when>
				<xsl:when test="$s = '1'">
					<xsl:text>-</xsl:text>
					<xsl:value-of select="$s2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$s"/>
					<xsl:text>-</xsl:text>
					<xsl:if test="$s2 != '0'">
						<xsl:value-of select="$s2"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="translate ($r, '0123456789-', '零一二三四五六七八九十')"/>
	</xsl:template>

	<!-- # 列出网站的关联节点 -->
	<xsl:template name="ListAncestorsInSiteMap">
		<xsl:param name="id" select="$siteMapId"/>
		<xsl:for-each select="$siteMapXml//siteMap[@id=$id]/ancestor::siteMap[not(@display = 'false')]">
			<xsl:apply-templates select="current()"/>
			<xsl:text>／</xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ListSiblingsInSiteMap">
		<xsl:param name="id" select="$siteMapId"/>
		<xsl:for-each select="$siteMapXml//siteMap[@id=$id]/parent::*/siteMap[@id != $id and not(@display = 'false')]">
			<xsl:if test="position() = 1">
				<li class="title">相邻内容</li>
			</xsl:if>
			<xsl:apply-templates select=".">
				<xsl:with-param name="element" select="'li'"/>
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="siteMap">
		<xsl:param name="element" select="'span'"/>
		<xsl:call-template name="siteMapNodeLink">
			<xsl:with-param name="href">
				<xsl:call-template name="mappath">
					<xsl:with-param name="type" select="'site'"/>
					<xsl:with-param name="ref" select="@id"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="text" select="@name"/>
			<xsl:with-param name="element" select="$element"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="siteMapNodeLink">
		<xsl:param name="href"/>
		<xsl:param name="text"/>
		<xsl:param name="separator"/>
		<xsl:param name="element" select="'span'"/>
		<xsl:element name="{$element}">
			<xsl:attribute name="class">SiteMapNode</xsl:attribute>
			<a href="{$href}"><xsl:value-of select="$text"/></a>
		</xsl:element>
		<xsl:value-of select="$separator"/>
	</xsl:template>

	<xsl:template name="CreateAdjacentLink">
		<xsl:param name="id"/>
		<xsl:param name="class"/>
		<xsl:param name="href"/>
		<xsl:param name="label"/>
		<xsl:param name="text"/>
		<span class="{$class}">
			<xsl:value-of select="$label"/>
			<xsl:if test="$label">
				<xsl:text>：</xsl:text>
			</xsl:if>
			<a id="{$id}" href="{$href}" title="{$label}：{$text}">
				<xsl:choose>
					<xsl:when test="$id = $AnchorNext">
						<xsl:attribute name="rel">Next</xsl:attribute>
					</xsl:when>
					<xsl:when test="$id = $AnchorPrev">
						<xsl:attribute name="rev">Prev</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="$text"/>
			</a>
		</span>
	</xsl:template>

	<xsl:template match="相关链接|链接组">
		<xsl:choose>
			<xsl:when test="类别">
				<li class="title"><xsl:apply-templates select="类别"/></li>
			</xsl:when>
			<xsl:when test="self::相关链接">
				<li class="title">相关网页：</li>
			</xsl:when>
		</xsl:choose>
		<xsl:for-each select="链接">
			<li><xsl:apply-templates select="."/></li>
		</xsl:for-each>
		<xsl:apply-templates select="链接组"/>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:choose>
			<xsl:when test="$SupportCjkExt and ci:hasCjkExtText(.)">
				<xsl:value-of select="ci:encodeCjkExtText(.)" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- # 版权说明 -->
	<xsl:template name="copyright">
		<div class="cr">
			<xsl:call-template name="copyrightText"/>
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'file'"/>
						<xsl:with-param name="ref" select="'gy-zhizuozhe'"/>
					</xsl:call-template>
				</xsl:attribute>
				<u>听琴斋主人</u>
				</a>制作（更新于<xsl:value-of select="$Date"/>）<br />龙榆生先生纪念网站：<a href="http://longyusheng.org" target="website">longyusheng.org</a>（<a href="http://www.miibeian.gov.cn/" target="_blank">粤ICP备15040392号</a>）</div>
	</xsl:template>
	<xsl:template name="copyrightText"/>
</xsl:stylesheet>