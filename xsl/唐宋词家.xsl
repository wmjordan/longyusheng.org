<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://www.dreamstudioz.org/xslt/js" exclude-result-prefixes="msxsl js">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="fID"/>
	<xsl:param name="选集名称"/>
	<xsl:param name="writerXml"/>
	<xsl:param name="writer" select="$writerXml/人物介绍/作家[姓名=$fID]"/>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$fID != '词人'">
				<xsl:value-of select="$fID"/>
				<xsl:text>传记——</xsl:text>
				<xsl:value-of select="$选集名称"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>词人传记与集评——</xsl:text>
				<xsl:value-of select="$选集名称"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>(龙榆生)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:if test="$fID != '词人'">
			<xsl:element name="meta">
				<xsl:attribute name="name">description</xsl:attribute>
				<xsl:attribute name="content">本页介绍了词人<xsl:value-of select="$fID"/>的生平事迹及名家对其作品的评语。</xsl:attribute>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PageDescriptionMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:if test="$fID != '词人'">
					<xsl:value-of select="$fID"/>
					<xsl:text>, 传记, 集评, </xsl:text>
				</xsl:if>
				<xsl:value-of select="$选集名称"/>
				<xsl:text>, 龙榆生, 电子书</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">当前位置：<xsl:call-template name="ListAncestorsInSiteMap"/></div>
	</xsl:template>
	<xsl:template name="RelatedLinksPart">
		<ul class="NaviPart">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:if test="$fID != '词人'">
				<li class="title">参见</li>
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="$fID"/>
							</xsl:call-template>
						</xsl:attribute>
						<u><xsl:value-of select="$fID"/></u>
						<xsl:text>词集</xsl:text>
					</a>
				</li>
				<xsl:apply-templates select="$writer/相关链接"/>
			</xsl:if>
		</ul>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$fID != '词人'">
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="$fID"/>
							</xsl:call-template>
						</xsl:attribute>
						<u><xsl:value-of select="$fID"/></u>
					</a>
				</xsl:when>
				<xsl:otherwise>词人传记与集评</xsl:otherwise>
			</xsl:choose>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$fID != '词人'">
					<xsl:apply-templates select="$writer"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="IndexPage"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template name="IndexPage">
		<div id="ciList">
			<xsl:for-each select="人物介绍/作家">
				<div class="list">
					<span class="listitem" style="width: 90pt;">
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'biblio'"/>
									<xsl:with-param name="ref" select="string(姓名)"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="formatName">
								<xsl:with-param name="n" select="姓名"/>
							</xsl:call-template>
						</a>
					</span>
					<span class="listdesc">
						<xsl:if test="生卒">
							<div class="note">
								<xsl:value-of select="生卒/@生"/>
								<xsl:text> - </xsl:text>
								<xsl:value-of select="生卒/@卒"/>
							</div>
						</xsl:if>
						<div class="note">
							<xsl:text>　　　　</xsl:text>
							<xsl:for-each select="姓名[position() &gt; 1]">
								<xsl:if test="@说明">
									<xsl:value-of select="concat (@说明, '：')"/>
								</xsl:if>
								<xsl:value-of select="text()"/>
								<xsl:text>　</xsl:text>
							</xsl:for-each>
						</div>
					</span>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template name="edit">
		<xsl:choose>
			<xsl:when test="@edit = '删'">
				<xsl:text>修订版删</xsl:text>
			</xsl:when>
			<xsl:when test="@edit = '增'">
				<xsl:text>修订版增</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>原版未收</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="作家">
		<xsl:if test="生卒">
			<xsl:value-of select="concat (' 生：', translate(生卒/@生, '1234567890', '一二三四五六七八九○'), '，卒：', translate(生卒/@卒, '1234567890', '一二三四五六七八九○'))"/>
		</xsl:if>
		<xsl:for-each select="姓名[position() &gt; 1]">
			<div>
				<xsl:if test="@说明">
					<xsl:value-of select="concat (@说明, '：')"/>
				</xsl:if>
				<xsl:value-of select="text()"/>
			</div>
		</xsl:for-each>
		<xsl:if test="说明">
			<div class="HeadNote">
				<xsl:apply-templates select="说明/段落"/>
			</div>
		</xsl:if>
		<xsl:if test="介绍">
			<a name="zhuanji"><br/></a>
			<h2>【传　记】</h2>
			<xsl:apply-templates select="介绍/段落|介绍/引文"/>
		</xsl:if>
		<xsl:if test="集评">
			<a name="jiping"><br/></a>
			<h2>【集　评】</h2>
			<xsl:for-each select="集评">
				<xsl:if test="position() != 1">
					<hr />
				</xsl:if>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="附录">
			<h2>【附　录】</h2>
			<xsl:for-each select="附录">
				<xsl:if test="position() != 1">
					<hr />
				</xsl:if>
				<xsl:apply-templates select="标题"/>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="附注">
			<div class="FootNote">
				<div class="ItemTitle">附注：</div>
				<xsl:apply-templates select="附注"/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="说明|附录|附注">
		<xsl:apply-templates select="段落|列举项|代码|引文|代码段"/>
	</xsl:template>

	<xsl:template match="引用附注">
		<xsl:variable name="num">
			<xsl:number count="引用附注" level="any" from="作家" format="1" />
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
				<xsl:value-of select="ancestor::作家[1]//引用附注[@id=current()/@id or position() = current()/@id]"/>
			</xsl:variable>
			<xsl:if test="string-length($text) != 0"><xsl:value-of select="$text"/>：</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="标题">
		<h3>
			<xsl:apply-templates select="text()|*"/>
		</h3>
	</xsl:template>
	<xsl:template match="段落">
		<p>
			<xsl:if test="not(@缩进='false')">
				<xsl:text>　　</xsl:text>
			</xsl:if>
			<xsl:apply-templates select="text()|*"/>
		</p>
	</xsl:template>
	<xsl:template match="集评">
		<p>
			<div>
				<xsl:if test="@edit">
					<span class="note">
						<xsl:text>（</xsl:text>
						<xsl:call-template name="edit"/>
						<xsl:text>）</xsl:text>
					</span>
				</xsl:if>
				<xsl:apply-templates select="人物|段落"/>
			</div>
			<div align="right">【<xsl:value-of select="出处"/>】</div>
		</p>
	</xsl:template>
	<xsl:template match="人物">
		<div><u><xsl:value-of select="text()"/></u>：</div>
	</xsl:template>
</xsl:stylesheet>