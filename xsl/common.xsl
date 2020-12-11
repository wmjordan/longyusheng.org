<?xml version="1.0" encoding="GB2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:string="http://longyusheng.org/xslt/extensions/string" xmlns:ci="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl context string ci">
	<xsl:param name="indexXml" select="context:GetCachedDocument ('�����ļ�.xml')"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('ע��.xml')"/>
	<xsl:param name="siteMapXml" select="context:GetCachedDocument ('SiteMap.xml')"/>
	<xsl:param name="siteMapId"/>
	<xsl:param name="depth" select="'../'"/>

	<!--# ͨ�ñ��� -->
	<xsl:variable name="SupportCjkExt" select="function-available('ci:encodeCjkExtText')"/>
	<xsl:variable name="AnchorNext" select="'anc_next'"/>
	<xsl:variable name="AnchorPrev" select="'anc_prev'"/>
	<xsl:variable name="Date">
		<xsl:if test="$indexXml">
			<xsl:value-of select="$indexXml/����/@date"/>
		</xsl:if>
	</xsl:variable>

	<xsl:template match="����Ȩ">
		<div><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="����">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="ר��">
		<u><xsl:apply-templates /></u>
	</xsl:template>
	<xsl:template match="����">
		<strong><xsl:apply-templates /></strong>
	</xsl:template>
	<xsl:template match="����">
		<span class="q"><xsl:apply-templates /></span>
	</xsl:template>
	<xsl:template match="����">
		<div class="quot"><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="����[����]">
		<div class="quot"><xsl:apply-templates /></div>
	</xsl:template>
	<xsl:template match="ʡ��">
		<span style="color: #999999" title="�˴���ԭ��ʡ��������">����</span>
	</xsl:template>
	<xsl:template match="����">
		<xsl:if test="@�ַ�|text()">
			<span><xsl:value-of select="@�ַ�|text()"/></span>
		</xsl:if>
		<sup class="reading-note">
			<xsl:choose>
				<xsl:when test="@������">
					<xsl:text>������</xsl:text>
					<span class="reading">
						<xsl:value-of select="@������"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="@����|@����">
						<xsl:if test="position() > 1">
							<xsl:text>��</xsl:text>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="name() = '����'">
								<xsl:text>��</xsl:text>
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
	<xsl:template match="����/text()|�����/text()">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>
	<xsl:template match="����/*|�����/*">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="����">
		<sup><xsl:apply-templates /></sup>
	</xsl:template>
	<xsl:template match="ͼƬ">
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
				<img src="{$depth}{@src}" alt="{text()|˵��}">
					<xsl:if test="@canEnlarge = 'true'">
						<xsl:attribute name="alt">
							<xsl:value-of select="text()"/>
							<xsl:if test="text()">
								<xsl:text>&#xa;</xsl:text>
							</xsl:if>�����ͼƬ�鿴��ͼ��</xsl:attribute>
					</xsl:if>
					<xsl:if test="@width">
						<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="@height">
						<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
					</xsl:if>
				</img>
			</xsl:element>
			<div class="image-desc"><xsl:apply-templates select="˵��" mode="picNote"/></div>
		</div>
	</xsl:template>
	<xsl:template match="��ǩ">
		<a name="{@name}"><xsl:apply-templates /></a>
	</xsl:template>
	<xsl:template match="����/�ؼ���">
		<a name="{@url}"></a>
	</xsl:template>
	<xsl:template match="ͼƬ/˵��" mode="picNote">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="ע��">
		<xsl:for-each select="text()|*">
			<xsl:choose>
				<xsl:when test="self::����">
					<span class="note"><xsl:apply-templates /></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="current()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="����">
		<xsl:choose>
			<xsl:when test="@xhref='#'">
				<a title="�μ� {.} ����">
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
				<a title="�μ� {substring-after(@xhref, '#')} ����">
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
				<a title="�μ� {.} �ʼ�">
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
				<a title="�μ� {substring-after(@xhref, '@')} �ʼ�">
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
				<xsl:variable name="refNode" select="$indexXml/����/��ѡ����/��[@id=substring-after(current()/@xhref, '$')]"/>
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'ci'"/>
							<xsl:with-param name="ref" select="substring-after(@xhref, '$')"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="concat('�μ� ', $refNode/@����, '��', $refNode/@����, '��&#x0D;&#x0A;', $refNode/@��������, '����' )"/></xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:when test="starts-with(@xhref, '?a=')">
				<xsl:variable name="title" select="concat('��', $indexXml/����/����[@id=substring-after(current()/@xhref, '?a=')]/@����, '��')"/>
				<a title="�μ�{$title}">
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
				<xsl:variable name="article" select="$indexXml/����/����//����[@id=substring-after(current()/@xhref, '?f=')]"/>
				<xsl:variable name="title" select="concat('��', $article/ancestor::����[1]/@����, '��', $article/����, '��')"/>
				<a title="�μ�{$title}">
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
						<xsl:variable name="note" select="$ciNotesXml/���ϵ���/����/ע��[�ʻ�=$word]"/>
						<a class="Ref" title="�μ� {$word} ��ע��">
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="$note/../@ID"/>
									<xsl:with-param name="val" select="$note/�ʻ�[1]"/>
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
						<xsl:variable name="note" select="$ciNotesXml/���ϵ���/����/ע��[�ʻ�=current()/text()]"/>
						<a class="Ref" title="�μ� {text()} ��ע��">
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="$note/../@ID"/>
									<xsl:with-param name="val" select="$note/�ʻ�[1]"/>
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
			<xsl:when test="$indexXml/����/����/����/����[@���� = $name]">
				<a title="�μ� {$name} ����">
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
		<!--�г���ص����£���������ĽṹΪ����*[@id][����]/����[@·��][����]��-->
		<xsl:param name="articles"/>
		<xsl:if test="$articles">
			<li class="title">�������</li>
			<xsl:for-each select="$articles">
				<li class="sub">
					<xsl:text>��</xsl:text>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'arc'"/>
								<xsl:with-param name="ref" select="@id"/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:value-of select="����"/>
					</a>
					<xsl:text>��</xsl:text>
				</li>
				<xsl:for-each select="����">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="''"/>
									<xsl:with-param name="ref" select="@·��"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:apply-templates select="����/node()"/>
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
				<xsl:value-of select="concat ($depth, $indexXml/����/����/����[���� = $ref]/@����·��)"/>
			</xsl:when>
			<xsl:when test="$type = 'coll'">
				<xsl:choose>
					<xsl:when test="$val">
						<xsl:value-of select="concat ($depth, $indexXml/����/����/��[@���� = $ref][position() = $val]/@·��)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat ($depth, $indexXml/����/����/����[���� = $ref]/@�ʼ�·��)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$type = 'format'">
				<xsl:value-of select="concat ($depth, $indexXml/����/����/����[����/@���� = $ref]/@·��)"/>
			</xsl:when>
			<xsl:when test="$type = 'note'">
				<xsl:value-of select="concat($depth, $type, '/', $ref, '/', string:UnicodeEncode(string($val)), '.html')"/>
			</xsl:when>
			<xsl:when test="$type = 'ci'">
				<xsl:value-of select="concat ($depth, $indexXml/����/��ѡ����/��[@id=$ref]/@·��)"/>
			</xsl:when>
			<xsl:when test="$type = 'site'">
				<xsl:value-of select="concat ($depth, $indexXml/����/siteMaps/siteMap[@id=$ref]/@url)"/>
			</xsl:when>
			<xsl:when test="$type = 'file'">
				<xsl:value-of select="concat ($depth, $indexXml/����/����//����[@id = $ref]/@·��)"/>
			</xsl:when>
			<xsl:when test="$type = 'arc'">
				<xsl:value-of select="concat ($depth, $indexXml/����/����[@id = $ref]/@·��)"/>
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
				<xsl:value-of select="concat (substring($n, 1, 1), '��', substring ($n, 2))"/>
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
		<xsl:value-of select="translate ($r, '0123456789-', '��һ�����������߰˾�ʮ')"/>
	</xsl:template>

	<!-- # �г���վ�Ĺ����ڵ� -->
	<xsl:template name="ListAncestorsInSiteMap">
		<xsl:param name="id" select="$siteMapId"/>
		<xsl:for-each select="$siteMapXml//siteMap[@id=$id]/ancestor::siteMap[not(@display = 'false')]">
			<xsl:apply-templates select="current()"/>
			<xsl:text>��</xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ListSiblingsInSiteMap">
		<xsl:param name="id" select="$siteMapId"/>
		<xsl:for-each select="$siteMapXml//siteMap[@id=$id]/parent::*/siteMap[@id != $id and not(@display = 'false')]">
			<xsl:if test="position() = 1">
				<li class="title">��������</li>
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
				<xsl:text>��</xsl:text>
			</xsl:if>
			<a id="{$id}" href="{$href}" title="{$label}��{$text}">
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

	<xsl:template match="�������|������">
		<xsl:choose>
			<xsl:when test="���">
				<li class="title"><xsl:apply-templates select="���"/></li>
			</xsl:when>
			<xsl:when test="self::�������">
				<li class="title">�����ҳ��</li>
			</xsl:when>
		</xsl:choose>
		<xsl:for-each select="����">
			<li><xsl:apply-templates select="."/></li>
		</xsl:for-each>
		<xsl:apply-templates select="������"/>
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

	<!-- # ��Ȩ˵�� -->
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
				<u>����ի����</u>
				</a>������������<xsl:value-of select="$Date"/>��<br />����������������վ��<a href="http://longyusheng.org" target="website">longyusheng.org</a>��<a href="http://www.miibeian.gov.cn/" target="_blank">��ICP��15040392��</a>��</div>
	</xsl:template>
	<xsl:template name="copyrightText"/>
</xsl:stylesheet>