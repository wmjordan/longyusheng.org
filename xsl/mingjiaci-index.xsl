<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="html"/>
	<xsl:param name="fID"/>
	<xsl:param name="sort"/>
	<xsl:param name="ciFormatsXml"/>
	<xsl:param name="ciXml"/>

	<xsl:template name="PageTitle">
		<xsl:value-of select="/���Ҵ�ѡ/����"/>
		<xsl:text>(������)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<meta name="keywords" content="{���Ҵ�ѡ/����}, ������" />
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart">��ǰλ�ã�<xsl:call-template name="ListAncestorsInSiteMap"/></div>
		<ul class="NaviPart"><xsl:call-template name="ListSiblingsInSiteMap"/></ul>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">Ŀ¼</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page" id="ciList" style="text-justify: auto;">
			<xsl:apply-templates select="/���Ҵ�ѡ"/>
		</div>
	</xsl:template>
	<xsl:template match="���Ҵ�ѡ">
		<xsl:variable name="writers">
			<xsl:choose>
				<xsl:when test="$sort = 'count'">
					<xsl:for-each select="���Ҵ�[ѡ�� != '']/����">
						<xsl:sort select="count(../��/����)" data-type="number" order="descending" />
						<xsl:element name="����">
							<xsl:attribute name="count"><xsl:value-of select="count(../��/����)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$sort != ''">
					<xsl:for-each select="���Ҵ�[ѡ�� != '']/����">
						<xsl:sort select="text()" data-type="text" order="ascending" />
						<xsl:element name="����">
							<xsl:attribute name="count"><xsl:value-of select="count(../��/����)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="���Ҵ�[ѡ�� != '']/����">
						<xsl:element name="����">
							<xsl:attribute name="count"><xsl:value-of select="count(../��/����)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="msxsl:node-set($writers)/����">
			<span class="listitem">
				<a>
					<xsl:attribute name="href">
						<xsl:call-template name="mappath">
							<xsl:with-param name="type">
								<xsl:choose>
									<xsl:when test="$sort = 'writerbiob'">biblio</xsl:when>
									<xsl:otherwise>coll</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="ref" select="text()"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="formatName">
						<xsl:with-param name="n" select="text()"/>
					</xsl:call-template>
				</a>
				<xsl:if test="@count">
					<span class="note">��<xsl:value-of select="@count"/>��</span>
				</xsl:if>
			</span>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="copyrightText">
		<div>
			<xsl:choose>
				<xsl:when test="/���Ҵ�ѡ/���� = '�����������Ҵ�ѡ'">�������������Ҵ�ѡ����<u>�Ϻ��ż�������</u>һ��������档</xsl:when>
				<xsl:when test="/���Ҵ�ѡ/���� = '�������Ҵ�ѡ'">���������Ҵ�ѡ����<u>�Ϻ��ż�������</u>һ�Ű�����档</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>
</xsl:stylesheet>

