<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl js">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl" />
	<!-- Parameters -->
	<xsl:param name="词牌"/>
	<xsl:param name="sort"/>
	<xsl:param name="ciXml"/>
	<!-- End of Parameters -->

	<xsl:param name="ciPai" select="$词牌"/>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$ciPai">
				<xsl:value-of select="concat ('词牌《', $ciPai/名称[1], '》——唐宋词格律(龙榆生)')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>唐宋词格律(龙榆生)</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:if test="$ciPai">
					<xsl:for-each select="$ciPai/名称">
						<xsl:if test="position() &gt; 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:value-of select="current()"/>
					</xsl:for-each>
					<xsl:text>, 词牌, 格律, </xsl:text>
				</xsl:if>
				<xsl:text>唐宋词格律, 龙榆生, 电子书</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="PageDescriptionMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">description</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:choose>
					<xsl:when test="$ciPai">
						<xsl:value-of select="$ciPai/名称"/>
						<xsl:text>词牌格律</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>《唐宋词格律》是龙榆生先生编选的词牌格律选本，附有示例词作若干，是研究词学、填词方法的优秀著作。</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">当前位置：<xsl:call-template name="ListAncestorsInSiteMap"/></div>
	</xsl:template>
	<xsl:template name="RelatedLinksPart">
		<xsl:variable name="ref">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:call-template name="RelativeArticles"/>
			<xsl:if test="$ciPai">
				<xsl:apply-templates select="$ciPai/相关链接"/>
			</xsl:if>
		</xsl:variable>
		<xsl:if test="msxsl:node-set($ref)/*">
			<ul class="NaviPart">
				<xsl:copy-of select="$ref" />
			</ul>
		</xsl:if>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$ciPai"><xsl:apply-templates select="$ciPai/名称[1]"/></xsl:when>
				<xsl:otherwise>唐宋词格律</xsl:otherwise>
			</xsl:choose>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$ciPai">
					<xsl:apply-templates select="$ciPai"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="唐宋词格律"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<script src="../cipai.js" type="text/javascript" defer="defer"/>
	</xsl:template>

	<xsl:template match="唐宋词格律">
		<xsl:choose>
			<xsl:when test="$sort = '字数'">
				<h2>小令</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/索引/格律/词牌/格律[@字数 &lt; 59]">
						<xsl:sort select="@字数" data-type="number" order="ascending" />
						<xsl:call-template name="字数词牌"/>
					</xsl:for-each>
				</div>
				<h2>中调</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/索引/格律/词牌/格律[@字数 &gt; 59 and @字数 &lt; 91]">
						<xsl:sort select="@字数" data-type="number" order="ascending" />
						<xsl:call-template name="字数词牌"/>
					</xsl:for-each>
				</div>
				<h2>长调</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/索引/格律/词牌/格律[@字数 &gt; 90]">
						<xsl:sort select="@字数" data-type="number" order="ascending" />
						<xsl:call-template name="字数词牌"/>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:when test="$sort = '拼音'">
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="类别/词牌/名称">
						<xsl:sort select="." data-type="text" order="ascending" />
						<span class="item">
							<a>
								<xsl:attribute name="href">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'format'"/>
										<xsl:with-param name="ref" select="."/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:value-of select="."/>
							</a>
							<span class="note">
								<xsl:text>(</xsl:text>
								<xsl:if test="not (@变体) and ../名称[1] != .">
									<xsl:text>即《</xsl:text>
									<xsl:value-of select="../名称"/>
									<xsl:text>》；</xsl:text>
								</xsl:if>
								<xsl:value-of select="../../名称"/>
								<xsl:if test="../正文/格律/@类别">
									<xsl:for-each select="../正文/格律[not(preceding-sibling::格律/@类别 = ./@类别)]/@类别">
										<xsl:text>、</xsl:text>
										<xsl:value-of select="."/>
									</xsl:for-each>
								</xsl:if>
								<xsl:text>)</xsl:text>
							</span>
						</span>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="类别">
					<h2><xsl:value-of select="名称"/></h2>
					<div style="margin-left: 20pt;" class="doublelist">
						<xsl:for-each select="词牌">
							<span class="item">
								<a>
									<xsl:attribute name="href">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'format'"/>
											<xsl:with-param name="ref" select="名称[1]"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="名称[1]"/>
								</a>
								<xsl:if test="count (名称) != 1">
									<span class="note">
										<xsl:text>(</xsl:text>
										<xsl:for-each select="名称[position() &gt; 1]">
											<xsl:if test="position() != 1">
												<xsl:text>、</xsl:text>
											</xsl:if>
											<xsl:value-of select="."/>
										</xsl:for-each>
										<xsl:text>)</xsl:text>
									</span>
								</xsl:if>
							</span>
						</xsl:for-each>
					</div>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="字数词牌">
		<span class="item">
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'format'"/>
						<xsl:with-param name="ref" select="../名称[1]/@名称"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:value-of select="../名称[1]/@名称"/>
			</a>
			<span class="note">
				<xsl:text> </xsl:text>
				<xsl:value-of select="@字数"/>
				<xsl:text>字；</xsl:text>
				<xsl:if test="@说明 != '定格' or count(../格律) != 1">
					<xsl:value-of select="@说明"/>
					<xsl:text>；</xsl:text>
				</xsl:if>
				<xsl:value-of select="@类别"/>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="词牌">
		<div>
			<div class="ItemTitle">
				<xsl:text>【</xsl:text>
					<xsl:for-each select="名称">
						<xsl:if test="position() &gt; 1">
							<xsl:text>、</xsl:text>
						</xsl:if>
						<xsl:value-of select="current()"/>
					</xsl:for-each>
				<xsl:text>】 </xsl:text>
			</div>
			<br />
			<xsl:for-each select="说明">
				<div class="cipaiDesc">
					<xsl:apply-templates select="段落"/>
				</div>
			</xsl:for-each>
			<br class="empty"/>
			<xsl:apply-templates select="正文"/>
			<xsl:call-template name="formatExample"/>
			<div id="ceExtra"/>
			<div style="display: none;" id="cejunk"/>
			<div class="SiblingLinks">
				<xsl:if test="preceding-sibling::词牌">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'上一词牌'"/>
						<xsl:with-param name="text" select="preceding-sibling::*[1]/名称"/>
						<xsl:with-param name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'format'"/>
								<xsl:with-param name="ref" select="preceding-sibling::*[1]/名称"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="following-sibling::词牌">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorNext"/>
						<xsl:with-param name="class" select="'Next'"/>
						<xsl:with-param name="label" select="'下一词牌'"/>
						<xsl:with-param name="text" select="following-sibling::*[1]/名称"/>
						<xsl:with-param name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'format'"/>
								<xsl:with-param name="ref" select="following-sibling::*[1]/名称"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="正文">
		<xsl:apply-templates select="格律|附注"/>
	</xsl:template>

	<xsl:template name="formatExample">
		<xsl:variable name="doc" select="msxsl:node-set($ciXml)/名家词选/名家词"/>
		<xsl:variable name="name" select="名称"/>
		<xsl:if test="$doc/词[词牌=$name or 词牌/@别名=$name]">
			<!-- <ul class="jd_menu" id="formatExample">
				<li class="title"><div>【例词】</div>
					<ul>
						<xsl:apply-templates select="$doc/词[词牌=current()/../名称/text()]/正文"/>
					</ul>
				</li>
			</ul> -->
			<script type="text/javascript">
				<xsl:text>var ces = {</xsl:text>
				<xsl:for-each select="$doc/词[词牌=$name or 词牌/@别名=$name]/正文">
					<xsl:variable name="extraExample" select="following-sibling::别作版本[preceding-sibling::正文[1] = current()][1][contains(@refBy,'格律')]"/>
					<xsl:if test="position() != 1">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<xsl:text>'ce</xsl:text>
					<xsl:value-of select="position()"/>
					<xsl:text>': { t: '</xsl:text>
					<xsl:choose>
						<xsl:when test="$extraExample">
							<xsl:value-of select="js:formatCiString(string($extraExample/段落))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="js:formatCiString(string(段落))"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>',w: '</xsl:text>
					<xsl:value-of select="../../作家"/>
					<xsl:text>',c: '</xsl:text>
					<xsl:value-of select="../词牌"/>
					<xsl:text>',n: '</xsl:text>
					<xsl:value-of select="substring-after(../附录[contains(出处, '格律')]/段落, '例词：')"/>
					<xsl:text>',h: '</xsl:text>
					<xsl:choose>
						<xsl:when test="@id!=''">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'ci'"/>
								<xsl:with-param name="ref" select="@id"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="../../作家"/>
								<xsl:with-param name="val" select="1+count(parent::*/preceding-sibling::词)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>'}</xsl:text>
				</xsl:for-each>
				<xsl:text>};</xsl:text>
			</script>
		</xsl:if>
	</xsl:template>

	<xsl:template match="格律">
		<a name="cp{count(../preceding-sibling::正文)}"></a>
		<div class="ItemTitle">【<xsl:value-of select="@说明"/>】</div>
		<div class="ci">
			<xsl:if test="@例词">
				<xsl:attribute name="example"><xsl:value-of select="@例词"/></xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="js:formatCiPai(string(current()))"/>
		</div>
		<br />
	</xsl:template>
	<xsl:template match="格律/text()">
		<xsl:copy-of select="js:formatCiPai(string(current()))" />
	</xsl:template>

	<xsl:template match="附注">
		<div class="Appendix">
			<xsl:text>【注】</xsl:text>
			<xsl:apply-templates />
		</div>
		<br />
	</xsl:template>
	<xsl:template match="附注/text()">
		<xsl:value-of select="translate(., '－│＋！％＊','平仄中仄')"/>
	</xsl:template>
	<xsl:template match="词/正文">
		<li id="ce{position()}" class="ceItem">
			<a>
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="@id!=''">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'ci'"/>
								<xsl:with-param name="ref" select="@id"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="../../作家"/>
								<xsl:with-param name="val" select="1+count(parent::*/preceding-sibling::词)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="../词牌"/>
			</a>
			<xsl:choose>
				<xsl:when test="contains(段落, '＾') and not(contains(段落, '－'))"> (仄韵)</xsl:when>
				<xsl:when test="not(contains(段落, '＾')) and contains(段落, '－')"> (平韵)</xsl:when>
				<xsl:otherwise> (平仄韵)</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="formatName">
				<xsl:with-param name="n" select="../../作家"/>
			</xsl:call-template>
		</li>
	</xsl:template>

	<xsl:template match="段落">
		<p><xsl:apply-imports/></p>
	</xsl:template>

<xsl:template name="RelativeArticles">
	<xsl:if test="$ciPai">
		<xsl:call-template name="ListReferenceArticles">
			<xsl:with-param name="articles" select="$indexXml/索引/格律/词牌[名称/@名称 = $ciPai/名称]/档案"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="copyrightText">
	<div>《唐宋词格律》：<u>上海古籍出版社</u>一九七八年版。</div>
</xsl:template>
</xsl:stylesheet>
