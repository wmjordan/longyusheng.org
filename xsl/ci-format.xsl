<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl js">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl" />
	<!-- Parameters -->
	<xsl:param name="����"/>
	<xsl:param name="sort"/>
	<xsl:param name="ciXml"/>
	<!-- End of Parameters -->

	<xsl:param name="ciPai" select="$����"/>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$ciPai">
				<xsl:value-of select="concat ('���ơ�', $ciPai/����[1], '���������δʸ���(������)')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>���δʸ���(������)</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:if test="$ciPai">
					<xsl:for-each select="$ciPai/����">
						<xsl:if test="position() &gt; 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:value-of select="current()"/>
					</xsl:for-each>
					<xsl:text>, ����, ����, </xsl:text>
				</xsl:if>
				<xsl:text>���δʸ���, ������, ������</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="PageDescriptionMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">description</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:choose>
					<xsl:when test="$ciPai">
						<xsl:value-of select="$ciPai/����"/>
						<xsl:text>���Ƹ���</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>�����δʸ��ɡ���������������ѡ�Ĵ��Ƹ���ѡ��������ʾ���������ɣ����о���ѧ����ʷ���������������</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">��ǰλ�ã�<xsl:call-template name="ListAncestorsInSiteMap"/></div>
	</xsl:template>
	<xsl:template name="RelatedLinksPart">
		<xsl:variable name="ref">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:call-template name="RelativeArticles"/>
			<xsl:if test="$ciPai">
				<xsl:apply-templates select="$ciPai/�������"/>
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
				<xsl:when test="$ciPai"><xsl:apply-templates select="$ciPai/����[1]"/></xsl:when>
				<xsl:otherwise>���δʸ���</xsl:otherwise>
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
					<xsl:apply-templates select="���δʸ���"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<script src="../cipai.js" type="text/javascript" defer="defer"/>
	</xsl:template>

	<xsl:template match="���δʸ���">
		<xsl:choose>
			<xsl:when test="$sort = '����'">
				<h2>С��</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/����/����/����/����[@���� &lt; 59]">
						<xsl:sort select="@����" data-type="number" order="ascending" />
						<xsl:call-template name="��������"/>
					</xsl:for-each>
				</div>
				<h2>�е�</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/����/����/����/����[@���� &gt; 59 and @���� &lt; 91]">
						<xsl:sort select="@����" data-type="number" order="ascending" />
						<xsl:call-template name="��������"/>
					</xsl:for-each>
				</div>
				<h2>����</h2>
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="$indexXml/����/����/����/����[@���� &gt; 90]">
						<xsl:sort select="@����" data-type="number" order="ascending" />
						<xsl:call-template name="��������"/>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:when test="$sort = 'ƴ��'">
				<div style="margin-left: 20pt;" class="doublelist">
					<xsl:for-each select="���/����/����">
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
								<xsl:if test="not (@����) and ../����[1] != .">
									<xsl:text>����</xsl:text>
									<xsl:value-of select="../����"/>
									<xsl:text>����</xsl:text>
								</xsl:if>
								<xsl:value-of select="../../����"/>
								<xsl:if test="../����/����/@���">
									<xsl:for-each select="../����/����[not(preceding-sibling::����/@��� = ./@���)]/@���">
										<xsl:text>��</xsl:text>
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
				<xsl:for-each select="���">
					<h2><xsl:value-of select="����"/></h2>
					<div style="margin-left: 20pt;" class="doublelist">
						<xsl:for-each select="����">
							<span class="item">
								<a>
									<xsl:attribute name="href">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'format'"/>
											<xsl:with-param name="ref" select="����[1]"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:value-of select="����[1]"/>
								</a>
								<xsl:if test="count (����) != 1">
									<span class="note">
										<xsl:text>(</xsl:text>
										<xsl:for-each select="����[position() &gt; 1]">
											<xsl:if test="position() != 1">
												<xsl:text>��</xsl:text>
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

	<xsl:template name="��������">
		<span class="item">
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'format'"/>
						<xsl:with-param name="ref" select="../����[1]/@����"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:value-of select="../����[1]/@����"/>
			</a>
			<span class="note">
				<xsl:text> </xsl:text>
				<xsl:value-of select="@����"/>
				<xsl:text>�֣�</xsl:text>
				<xsl:if test="@˵�� != '����' or count(../����) != 1">
					<xsl:value-of select="@˵��"/>
					<xsl:text>��</xsl:text>
				</xsl:if>
				<xsl:value-of select="@���"/>
			</span>
		</span>
	</xsl:template>

	<xsl:template match="����">
		<div>
			<div class="ItemTitle">
				<xsl:text>��</xsl:text>
					<xsl:for-each select="����">
						<xsl:if test="position() &gt; 1">
							<xsl:text>��</xsl:text>
						</xsl:if>
						<xsl:value-of select="current()"/>
					</xsl:for-each>
				<xsl:text>�� </xsl:text>
			</div>
			<br />
			<xsl:for-each select="˵��">
				<div class="cipaiDesc">
					<xsl:apply-templates select="����"/>
				</div>
			</xsl:for-each>
			<br class="empty"/>
			<xsl:apply-templates select="����"/>
			<xsl:call-template name="formatExample"/>
			<div id="ceExtra"/>
			<div style="display: none;" id="cejunk"/>
			<div class="SiblingLinks">
				<xsl:if test="preceding-sibling::����">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'��һ����'"/>
						<xsl:with-param name="text" select="preceding-sibling::*[1]/����"/>
						<xsl:with-param name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'format'"/>
								<xsl:with-param name="ref" select="preceding-sibling::*[1]/����"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="following-sibling::����">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorNext"/>
						<xsl:with-param name="class" select="'Next'"/>
						<xsl:with-param name="label" select="'��һ����'"/>
						<xsl:with-param name="text" select="following-sibling::*[1]/����"/>
						<xsl:with-param name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'format'"/>
								<xsl:with-param name="ref" select="following-sibling::*[1]/����"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="����">
		<xsl:apply-templates select="����|��ע"/>
	</xsl:template>

	<xsl:template name="formatExample">
		<xsl:variable name="doc" select="msxsl:node-set($ciXml)/���Ҵ�ѡ/���Ҵ�"/>
		<xsl:if test="$doc/��[����=current()/����]">
			<!-- <ul class="jd_menu" id="formatExample">
				<li class="title"><div>�����ʡ�</div>
					<ul>
						<xsl:apply-templates select="$doc/��[����=current()/../����/text()]/����"/>
					</ul>
				</li>
			</ul> -->
			<script type="text/javascript">
				<xsl:text>var ces = {</xsl:text>
				<xsl:for-each select="$doc/��[����=current()/����/text()]/����">
					<xsl:variable name="extraExample" select="following-sibling::�����汾[preceding-sibling::����[1] = current()][1][contains(@refBy,'����')]"/>
					<xsl:if test="position() != 1">
						<xsl:text>,</xsl:text>
					</xsl:if>
					<xsl:text>'ce</xsl:text>
					<xsl:value-of select="position()"/>
					<xsl:text>': { t: '</xsl:text>
					<xsl:choose>
						<xsl:when test="$extraExample">
							<xsl:value-of select="js:formatCiString(string($extraExample/����))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="js:formatCiString(string(����))"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>',w: '</xsl:text>
					<xsl:value-of select="../../����"/>
					<xsl:text>',c: '</xsl:text>
					<xsl:value-of select="../����"/>
					<xsl:text>',n: '</xsl:text>
					<xsl:value-of select="substring-after(../��¼[contains(����, '����')]/����, '���ʣ�')"/>
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
								<xsl:with-param name="ref" select="../../����"/>
								<xsl:with-param name="val" select="1+count(parent::*/preceding-sibling::��)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>'}</xsl:text>
				</xsl:for-each>
				<xsl:text>};</xsl:text>
			</script>
		</xsl:if>
	</xsl:template>

	<xsl:template match="����">
		<a name="cp{count(../preceding-sibling::����)}"></a>
		<div class="ItemTitle">��<xsl:value-of select="@˵��"/>��</div>
		<div class="ci">
			<xsl:if test="@����">
				<xsl:attribute name="example"><xsl:value-of select="@����"/></xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="js:formatCiPai(string(current()))"/>
		</div>
		<br />
	</xsl:template>
	<xsl:template match="����/text()">
		<xsl:copy-of select="js:formatCiPai(string(current()))" />
	</xsl:template>

	<xsl:template match="��ע">
		<div class="Appendix">
			<xsl:text>��ע��</xsl:text>
			<xsl:apply-templates />
		</div>
		<br />
	</xsl:template>
	<xsl:template match="��ע/text()">
		<xsl:value-of select="translate(., '������������','ƽ������')"/>
	</xsl:template>
	<xsl:template match="��/����">
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
								<xsl:with-param name="ref" select="../../����"/>
								<xsl:with-param name="val" select="1+count(parent::*/preceding-sibling::��)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="../����"/>
			</a>
			<xsl:choose>
				<xsl:when test="contains(����, '��') and not(contains(����, '��'))"> (����)</xsl:when>
				<xsl:when test="not(contains(����, '��')) and contains(����, '��')"> (ƽ��)</xsl:when>
				<xsl:otherwise> (ƽ����)</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="formatName">
				<xsl:with-param name="n" select="../../����"/>
			</xsl:call-template>
		</li>
	</xsl:template>

	<xsl:template match="����">
		<p><xsl:apply-imports/></p>
	</xsl:template>

<xsl:template name="RelativeArticles">
	<xsl:if test="$ciPai">
		<xsl:call-template name="ListReferenceArticles">
			<xsl:with-param name="articles" select="$indexXml/����/����/����[����/@���� = $ciPai/����]/����"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="copyrightText">
	<div>�����δʸ��ɡ���<u>�Ϻ��ż�������</u>һ���߰���档</div>
</xsl:template>
</xsl:stylesheet>
