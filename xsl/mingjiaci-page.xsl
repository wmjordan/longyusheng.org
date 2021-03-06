<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:string="http://longyusheng.org/xslt/extensions/string" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:js="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl js string context">
	<xsl:import href="pageframe.xsl"/>
	<!-- Parameters -->
	<xsl:param name="writerName"/>
	<xsl:param name="fID"/>
	<xsl:param name="html"/>
	<!-- End of Parameters -->

	<xsl:variable name="numXml" select="context:GetCachedDocument ('xsl/ChineseNum.xml')/中文数字"/>
	<xsl:variable name="ci" select="名家词选/名家词[作家=$writerName]/词[position()=number($fID)]"/>
	<xsl:variable name="ciList" select="名家词选/名家词[作家=$writerName]"/>
	<xsl:variable name="ciPai">
		<xsl:if test="$ci">
			<xsl:value-of select="$ci/词牌"/>
		</xsl:if>
	</xsl:variable>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$ci">
				<xsl:value-of select="名家词选/名家词/作家[text()=$writerName]"/>
				<xsl:text>《</xsl:text>
				<xsl:value-of select="$ciPai"/>
				<xsl:variable name="题记">
					<xsl:for-each select="$ci/正文[1]/preceding-sibling::题记[1]/node()[self::text()|self::*[name() != '题注']]">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="题记文字" select="string(msxsl:node-set($题记))"/>
				<xsl:if test="$题记文字 != '' and string-length($题记文字) &lt; 11">
					<xsl:text>·</xsl:text>
					<xsl:value-of select="$题记文字"/>
				</xsl:if>
				<xsl:text>》(</xsl:text>
				<xsl:value-of select="js:firstLine(string(名家词选/名家词[作家=$writerName]/词[position()=number($fID)]/正文))"/>
				<xsl:text>)</xsl:text>
				<xsl:if test="count($ci/正文) != 1">
					<xsl:text>等</xsl:text>
					<xsl:value-of select="$numXml/数字[count($ci/正文)]/@大写"/>
					<xsl:text>首</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$ciList">
				<xsl:value-of select="$writerName"/>
				<xsl:text>词选</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text>——</xsl:text>
		<xsl:value-of select="名家词选/标题"/>
		<xsl:text>(龙榆生)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:choose>
					<xsl:when test="$ci">
						<xsl:value-of select="concat (名家词选/名家词/作家[text()=$writerName], ', ', $ciPai)"/>
					</xsl:when>
					<xsl:when test="$ciList">
						<xsl:value-of select="$writerName"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="名家词选/标题"/>
				<xsl:text>, 龙榆生</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart">当前位置：<xsl:call-template name="ListAncestorsInSiteMap"/>
			<xsl:choose>
				<xsl:when test="$ci">
					<xsl:call-template name="siteMapNodeLink">
						<xsl:with-param name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="$writerName"/>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="text" select="$writerName"/>
						<xsl:with-param name="separator" select="'／'"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template name="RelatedLinksPart">
		<xsl:variable name="ref">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:variable name="references">
				<xsl:if test="$writerName and $indexXml/索引/词人/作家[姓名=$writerName and @简传='1']">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'biblio'"/>
									<xsl:with-param name="ref" select="$writerName"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:value-of select="$writerName"/>
							<xsl:text>传记</xsl:text>
							<xsl:if test="$indexXml/索引/词人/作家[姓名=$writerName and @集评='1']">
								<xsl:text>与集评</xsl:text>
							</xsl:if>
						</a>
					</li>
				</xsl:if>
				<xsl:if test="$indexXml/索引/格律/词牌/名称[@名称 = $ciPai]">
					<li>
						<a>
							<xsl:attribute name="href">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'format'"/>
										<xsl:with-param name="ref" select="$ciPai"/>
									</xsl:call-template>
							</xsl:attribute>
							<xsl:value-of select="concat ('词牌：', $ciPai)"/>
						</a>
					</li>
				</xsl:if>
			</xsl:variable>
			<xsl:if test="msxsl:node-set($references)/*">
				<li class="title">相关连接</li>
				<xsl:copy-of select="$references" />
			</xsl:if>
			<xsl:call-template name="RelativeArticles"/>
		</xsl:variable>
		<xsl:if test="msxsl:node-set($ref)/*">
			<ul class="NaviPart">
				<xsl:copy-of select="$ref" />
			</ul>
		</xsl:if>
	</xsl:template>

	<xsl:template name="TitlePart">
		<div class="PrintContent">《<xsl:value-of select="/名家词选/标题"/>》</div>
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$ci">
					<xsl:call-template name="CiPaiLink"/>
					<xsl:if test="count($ci/正文) &gt; 1">
						<span class="title2">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$numXml/数字[count($ci/正文)]/@大写"/>
							<xsl:text>首</xsl:text>
						</span>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$ciList">
					<xsl:call-template name="WriterLink"/>
					<span class="title2">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$numXml/数字[count($ciList/词/正文)]/@大写"/>
						<xsl:text>首</xsl:text>
					</span>
				</xsl:when>
			</xsl:choose>
		</h1>
		<xsl:if test="$ci">
			<div class="PrintContent"><xsl:value-of select="$writerName"/></div>
		</xsl:if>
	</xsl:template>
	<xsl:template name="CiPaiLink">	
		<xsl:choose>
			<xsl:when test="$indexXml/索引/格律/词牌/名称[@名称 = $ciPai]">
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'format'"/>
							<xsl:with-param name="ref" select="$ciPai"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:value-of select="$ciPai"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ciPai"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="WriterLink">
		<xsl:choose>
			<xsl:when test="$indexXml/名家词选/名家词[(作家=$writerName) and (传记='1')]">
				<a>
					<xsl:attribute name="title"><xsl:value-of select="$writerName"/> 传记<xsl:if test="$indexXml/名家词选/名家词[作家=$writerName]/集评[text()='1']">
						<xsl:text>与集评</xsl:text>
					</xsl:if></xsl:attribute>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type" select="'biblio'"/>
							<xsl:with-param name="ref" select="$writerName"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="formatName">
						<xsl:with-param name="n" select="$writerName"/>
					</xsl:call-template>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="formatName">
					<xsl:with-param name="n" select="$writerName"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$ci">
					<xsl:apply-templates select="$ci"/>
				</xsl:when>
				<xsl:when test="$ciList">
					<xsl:apply-templates select="$ciList"/>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="名家词">
		<div><xsl:value-of select="选本"/></div>
		<xsl:if test="说明">
			<div class="HeadNote">
				<xsl:for-each select="说明/段落">
					<p>
						<xsl:text>　　</xsl:text>
						<xsl:apply-templates/>
					</p>
				</xsl:for-each>
			</div>
		</xsl:if>
		<br />
		<div id="ciList">
			<xsl:for-each select="词">
				<xsl:variable name="pos" select="position()"/>
				<xsl:variable name="cnt" select="count(正文)"/>
				<div class="list">
					<span class="listitem">
						<a>
							<xsl:attribute name="href">
								<xsl:choose>
									<xsl:when test="$cnt = 1 and 正文/@id">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'ci'"/>
											<xsl:with-param name="ref" select="正文/@id"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'coll'"/>
											<xsl:with-param name="ref" select="$writerName"/>
											<xsl:with-param name="val" select="$pos"/>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="题记">
								<xsl:attribute name="title">
									<xsl:value-of select="题记"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:if test="position() = 1">
								<xsl:attribute name="id">anc_next</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="词牌"/>
						</a>
					</span>
					<span class="listdesc" style="font-size: 80%;">
						<xsl:for-each select="正文">
							<xsl:if test="preceding-sibling::*[1][self::题记]">
								<div class="tiji"><xsl:apply-templates select="preceding-sibling::*[1][self::题记]" mode="substract"/></div>
							</xsl:if>
							<div>　（<xsl:value-of select="js:firstLine(string(段落))"/>）</div>
						</xsl:for-each>
					</span>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="词">
		<xsl:for-each select="正文">
			<xsl:if test="@id">
				<a name="{@id}"></a>
			</xsl:if>
			<xsl:if test="preceding-sibling::*[1][name()='题记']">
				<xsl:apply-templates select="preceding-sibling::*[1]"/>
			</xsl:if>
			<div class="ci">
				<xsl:apply-templates select="current()"/>
			</div>
			<xsl:if test="following-sibling::*[1][self::附录] or following-sibling::别作版本[last()]/following-sibling::*[1][self::附录]">
				<xsl:variable name="bodyID" select="generate-id()"/>
				<xsl:for-each select="following-sibling::附录[generate-id(preceding-sibling::正文[1])=$bodyID]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="@id and $indexXml/索引/特选词作/词[@id = current()/@id]/档案">
				<div class="Appendix">
					<div>相关文章：</div>
					<xsl:for-each select="$indexXml/索引/特选词作/词[@id = current()/@id]/档案">
						<div class="list">
							<span class="listitem" style="float: left;">
								<xsl:text>《</xsl:text>
								<a>
									<xsl:attribute name="href">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'arc'"/>
											<xsl:with-param name="ref" select="@id"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:apply-templates select="标题"/>
								</a>
								<xsl:text>》：</xsl:text>
							</span>
							<span class="listdesc" style="float: left;">
								<ol id="{../@id}-{@id}">
									<xsl:for-each select="文章">
										<li>
											<xsl:for-each select="ancestor::档案文章[position () != 1]">
												<xsl:text>　　</xsl:text>
											</xsl:for-each>
											<a>
												<xsl:attribute name="href">
													<xsl:call-template name="mappath">
														<xsl:with-param name="type" select="'file'"/>
														<xsl:with-param name="ref" select="@id"/>
													</xsl:call-template>
												</xsl:attribute>
												<xsl:apply-templates select="标题"/>
											</a>
										</li>
									</xsl:for-each>
								</ol>
							</span>
						</div>
					</xsl:for-each>
				</div>
			</xsl:if>
		</xsl:for-each>
		<xsl:variable name="prev_pos" select="count(preceding-sibling::*[name()='词'])"/>
		<div id="ci_nav" class="SiblingLinks">
			<xsl:choose>
				<xsl:when test="$prev_pos &gt; 0">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'上一首'"/>
						<xsl:with-param name="text" select="preceding-sibling::*[1]/词牌"/>
						<xsl:with-param name="href">
							<xsl:choose>
								<xsl:when test="preceding-sibling::*[1][count(正文)=1]/正文[@id!='']">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'ci'"/>
										<xsl:with-param name="ref" select="preceding-sibling::*[1]/正文/@id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'coll'"/>
										<xsl:with-param name="ref" select="../作家"/>
										<xsl:with-param name="val" select="$prev_pos"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="parent::*[self::*[preceding-sibling::*[1][name()='名家词']]]">
					<xsl:variable name="preceding_writer" select="parent::*/preceding-sibling::*[1]"/>
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'上一词人'"/>
						<xsl:with-param name="text" select="$preceding_writer/作家"/>
						<xsl:with-param name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'coll'"/>
									<xsl:with-param name="ref" select="$preceding_writer/作家"/>
								</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="following-sibling::*">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorNext"/>
						<xsl:with-param name="class" select="'Next'"/>
						<xsl:with-param name="label" select="'下一首'"/>
						<xsl:with-param name="text" select="following-sibling::*[1]/词牌"/>
						<xsl:with-param name="href">
							<xsl:choose>
								<xsl:when test="following-sibling::*[1][count(正文)=1]/正文[@id!='']">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'ci'"/>
										<xsl:with-param name="ref" select="following-sibling::*[1]/正文/@id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'coll'"/>
										<xsl:with-param name="ref" select="../作家"/>
										<xsl:with-param name="val" select="$prev_pos + 2"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="parent::*[self::*[following-sibling::*[1][name()='名家词']]]">
					<xsl:variable name="following_writer" select="parent::*/following-sibling::*[1]"/>
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorNext"/>
						<xsl:with-param name="class" select="'Next'"/>
						<xsl:with-param name="label" select="'下一词人'"/>
						<xsl:with-param name="text" select="$following_writer/作家"/>
						<xsl:with-param name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'coll'"/>
									<xsl:with-param name="ref" select="$following_writer/作家"/>
								</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>
	
	<xsl:template match="题记">
		<div class="tiji">
			<xsl:if test="string-length(current()) &lt; 9">
				<xsl:attribute name="align">center</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="string-length(current()) = 2">
					<xsl:value-of select="concat(substring(current(), 1, 1), '　', substring(current(), 2, 1))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="text()|*"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="题记" mode="substract">
		<div><xsl:apply-templates select="text()|*[name() != '题注']"/></div>
	</xsl:template>
	<xsl:template match="题注">
		<p class="tizhu">　　<xsl:apply-templates select="text()|*"/></p>
	</xsl:template>
	
	<xsl:template match="正文">
		<div class="body">
			<xsl:copy-of select="js:formatCi(string(段落))"/>
		</div>
		<hr />
	</xsl:template>
	<xsl:template match="附录">
		<div class="Appendix">
			<xsl:apply-templates select="注释" mode="note"/>
			<xsl:apply-templates select="出处[1]"/>
			<xsl:choose>
				<xsl:when test="count(段落)=1">
					<xsl:apply-templates select="段落"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="段落|出处[position()&gt;1]">
						<div style="margin-left: 15pt;"><xsl:apply-templates select="current()"/></div>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="not(following-sibling::*[1][name()='附录'])">
			<hr/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="出处">
		<xsl:text>【</xsl:text>
		<xsl:apply-templates select="text()|*"/>
		<xsl:text>】</xsl:text>
	</xsl:template>

	<xsl:template match="注释" mode="note">
		<xsl:variable name="node" select="$ciNotesXml/资料档案/索引/注释[词汇=current()/@关键字]"/>
		<div>
			<b><xsl:value-of select="@关键字"/></b>
			<xsl:text>：</xsl:text>
			<xsl:choose>
				<xsl:when test="*|text()">
					<xsl:apply-templates />
				</xsl:when>
				<xsl:when test="$node">
					<xsl:choose>
						<xsl:when test="count($node/注解) &gt; 1">
							<dl class="notelist">
								<xsl:for-each select="$node/注解">
									<dd><xsl:apply-templates select="." mode="note"/></dd>
								</xsl:for-each>
							</dl>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$node/注解" mode="note"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">找不到 <xsl:value-of select="@关键字"/> 的注释。</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="注解" mode="note">
		<xsl:choose>
			<xsl:when test=".//引文">
				<xsl:choose>
					<xsl:when test="概述">
						<xsl:apply-templates select="概述"/>
						<a>
							<xsl:attribute name="title">
								<xsl:text>参见“</xsl:text>
								<xsl:value-of select="current()/../词汇"/>
								<xsl:text>”的详细注解</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="current()/../../@ID"/>
									<xsl:with-param name="val" select="../词汇[1]"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:text>……</xsl:text>
						</a>
					</xsl:when>
					<xsl:otherwise>
					<div class="detailnote">
						<xsl:apply-templates select="current()"/>
					</div>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="current()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="RelativeArticles">
		<xsl:if test="$ci/正文/@id">
			<xsl:call-template name="ListReferenceArticles">
				<xsl:with-param name="articles" select="$indexXml/索引/特选词作/词[@id = $ci/正文/@id]/档案"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="copyrightText">
		<div>
			<xsl:choose>
				<xsl:when test="/名家词选/标题 = '近三百年名家词选'">《近三百年名家词选》：<u>上海古籍出版社</u>一九五六年版、一九七九年新版。</xsl:when>
				<xsl:when test="/名家词选/标题 = '唐宋名家词选'">《唐宋名家词选》：<u>上海古籍出版社</u>一九八零年版。</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

</xsl:stylesheet>

