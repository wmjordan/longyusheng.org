<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://www.dreamstudioz.org/xslt/js" exclude-result-prefixes="msxsl js">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="fID"/>
	<xsl:param name="ѡ������"/>
	<xsl:param name="writerXml"/>
	<xsl:param name="writer" select="$writerXml/�������/����[����=$fID]"/>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$fID != '����'">
				<xsl:value-of select="$fID"/>
				<xsl:text>���ǡ���</xsl:text>
				<xsl:value-of select="$ѡ������"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>���˴����뼯������</xsl:text>
				<xsl:value-of select="$ѡ������"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>(������)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:if test="$fID != '����'">
			<xsl:element name="meta">
				<xsl:attribute name="name">description</xsl:attribute>
				<xsl:attribute name="content">��ҳ�����˴���<xsl:value-of select="$fID"/>����ƽ�¼������Ҷ�����Ʒ�����</xsl:attribute>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PageDescriptionMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:if test="$fID != '����'">
					<xsl:value-of select="$fID"/>
					<xsl:text>, ����, ����, </xsl:text>
				</xsl:if>
				<xsl:value-of select="$ѡ������"/>
				<xsl:text>, ������, ������</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">��ǰλ�ã�<xsl:call-template name="ListAncestorsInSiteMap"/></div>
	</xsl:template>
	<xsl:template name="RelatedLinksPart">
		<ul class="NaviPart">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:if test="$fID != '����'">
				<li class="title">�μ�</li>
				<li>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'coll'"/>
								<xsl:with-param name="ref" select="$fID"/>
							</xsl:call-template>
						</xsl:attribute>
						<u><xsl:value-of select="$fID"/></u>
						<xsl:text>�ʼ�</xsl:text>
					</a>
				</li>
				<xsl:apply-templates select="$writer/�������"/>
			</xsl:if>
		</ul>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$fID != '����'">
					<xsl:call-template name="formatName">
						<xsl:with-param name="n" select="$writer/����"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>���˴����뼯��</xsl:otherwise>
			</xsl:choose>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$fID != '����'">
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
			<xsl:for-each select="�������/����">
				<div class="list">
					<span class="listitem" style="width: 90pt;">
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'biblio'"/>
									<xsl:with-param name="ref" select="string(����)"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="formatName">
								<xsl:with-param name="n" select="����"/>
							</xsl:call-template>
						</a>
					</span>
					<span class="listdesc">
						<xsl:if test="����">
							<div class="note">
								<xsl:value-of select="����/@��"/>
								<xsl:text> - </xsl:text>
								<xsl:value-of select="����/@��"/>
							</div>
						</xsl:if>
						<div class="note">
							<xsl:text>��������</xsl:text>
							<xsl:for-each select="����[position() &gt; 1]">
								<xsl:if test="@˵��">
									<xsl:value-of select="concat (@˵��, '��')"/>
								</xsl:if>
								<xsl:value-of select="text()"/>
								<xsl:text>��</xsl:text>
							</xsl:for-each>
						</div>
					</span>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="����">
		<xsl:if test="����">
			<xsl:value-of select="concat (' ����', translate(����/@��, '1234567890', 'һ�����������߰˾š�'), '���䣺', translate(����/@��, '1234567890', 'һ�����������߰˾š�'))"/>
		</xsl:if>
		<xsl:for-each select="����[position() &gt; 1]">
			<div>
				<xsl:if test="@˵��">
					<xsl:value-of select="concat (@˵��, '��')"/>
				</xsl:if>
				<xsl:value-of select="text()"/>
			</div>
		</xsl:for-each>
		<xsl:if test="˵��">
			<div class="HeadNote">
				<xsl:apply-templates select="˵��/����"/>
			</div>
		</xsl:if>
		<xsl:if test="����">
			<a name="zhuanji"><br/></a>
			<h2>�������ǡ�</h2>
			<xsl:apply-templates select="����/����"/>
		</xsl:if>
		<xsl:if test="����">
			<a name="jiping"><br/></a>
			<h2>����������</h2>
			<xsl:for-each select="����">
				<xsl:if test="position() != 1">
					<hr />
				</xsl:if>
				<xsl:apply-templates select="."/>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="��ע">
			<div class="FootNote">
				<div class="ItemTitle">��ע��</div>
				<xsl:apply-templates select="��ע"/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="˵��|��ע">
		<xsl:apply-templates select="����|�о���|����|����|�����"/>
	</xsl:template>

	<xsl:template match="���ø�ע">
		<xsl:variable name="num">
			<xsl:number count="���ø�ע" level="any" from="����" format="1" />
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
					<xsl:value-of select="concat('�鿴��', ., '���ĸ�ע����ҳ��')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('�鿴��ҳ��ע ', $num)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates />
		<sup>
			<a href="#fn{$id}" name="qfn{$id}" class="Ref" title="{$title}">[<xsl:value-of select="$num"/>]</a>
		</sup>
	</xsl:template>
	<xsl:template match="��ע/����[@id]">
		<p>
			<sup>
				<a name="fn{@id}" href="#qfn{@id}" class="Ref" title="���ظ�ע��Ӧ��λ��">[<xsl:value-of select="count(preceding-sibling::����[@id])+1"/>]</a>
			</sup>
			<xsl:variable name="text">
				<xsl:value-of select="ancestor::����[1]//���ø�ע[@id=current()/@id or position() = current()/@id]"/>
			</xsl:variable>
			<xsl:if test="string-length($text) != 0"><xsl:value-of select="$text"/>��</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="����">
		<p>
			<xsl:if test="not(@����='false')">
				<xsl:text>����</xsl:text>
			</xsl:if>
			<xsl:apply-templates select="text()|*"/>
		</p>
	</xsl:template>
	<xsl:template match="����">
		<p>
			<div>
				<xsl:apply-templates select="����|����"/>
			</div>
			<div align="right">��<xsl:value-of select="����"/>��</div>
		</p>
	</xsl:template>
	<xsl:template match="����">
		<div><u><xsl:value-of select="text()"/></u>��</div>
	</xsl:template>
</xsl:stylesheet>