<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="context">
	<xsl:import href="common.xsl" />

<!-- ���� CHM ��Ŀ��Ŀ¼�ļ� hhc -->
	<xsl:output method="html" encoding="gb2312" indent="yes"/>

	<xsl:variable name="numXml" select="context:GetCachedDocument ('xsl/ChineseNum.xml')/��������"/>

<xsl:template name="����">
	<xsl:param name="���ϵ���ID"/>
	<xsl:variable name="����" select="/����/����[@id=$���ϵ���ID]"/>
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name" value="{$����/@����}"/>
			<param name="ImageNumber" value="1"/>
			<param name="Local" value="{$����/@·��}"/>
		</object>
		<ul>
			<xsl:apply-templates select="$����/����"/>
		</ul>
	</li>
</xsl:template>

<xsl:template match="����">
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name">
				<xsl:attribute name="value">
					<xsl:value-of select="����"/>
					<xsl:if test="string-length (@����) and @���� != '������'">
						<xsl:text>...</xsl:text>
						<xsl:value-of select="@����"/>
					</xsl:if>
				</xsl:attribute>
			</param>
			<param name="Local" value="{@·��}"/>
		</object>
		<xsl:if test="����">
			<ul>
				<xsl:apply-templates select="����"/>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

<!-- ���� CHM ��Ŀ��Ŀ¼�ļ� hhc -->
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
						<xsl:with-param name="text" select="'������������ѧ����ѡ'"/>
						<xsl:with-param name="ref" select="'root'"/>
					</xsl:call-template>
					<li>
						<xsl:call-template name="siteMapNodeObject">
							<xsl:with-param name="text" select="'�������Ҵ�ѡ'"/>
							<xsl:with-param name="ref" select="'tangsongci-index'"/>
							<xsl:with-param name="icon" select="'1'"/>
						</xsl:call-template>
						<ul>
							<xsl:apply-templates select="/����/����[@id='tangsongci']/����[not(contains(@·��, 'index.html'))]"/>
							<xsl:call-template name="ci">
								<xsl:with-param name="ѡ������" select="'�������Ҵ�ѡ'"/>
								<xsl:with-param name="siteMapId" select="'tangsongci-index1'"/>
							</xsl:call-template>
							<xsl:call-template name="siteMapNode">
								<xsl:with-param name="text" select="'������¼��һ��'"/>
								<xsl:with-param name="ref" select="'tangsongci-index3'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
							<xsl:call-template name="zhuanji">
								<xsl:with-param name="ѡ������" select="'�������Ҵ�ѡ'"/>
								<xsl:with-param name="siteMapId" select="'tangsongci-biblio'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
						</ul>
					</li>
					<li>
						<xsl:call-template name="siteMapNodeObject">
							<xsl:with-param name="text" select="'�����������Ҵ�ѡ'"/>
							<xsl:with-param name="ref" select="'jindaici-index'"/>
							<xsl:with-param name="icon" select="'1'"/>
						</xsl:call-template>
						<ul>
							<xsl:apply-templates select="/����/����[@id='jindaici']/����[not(contains(@·��, 'index.html'))]"/>
							<xsl:call-template name="ci">
								<xsl:with-param name="ѡ������" select="'�����������Ҵ�ѡ'"/>
								<xsl:with-param name="siteMapId" select="'jindaici-index1'"/>
							</xsl:call-template>
							<xsl:call-template name="siteMapNode">
								<xsl:with-param name="text" select="'������¼��һ��'"/>
								<xsl:with-param name="ref" select="'jindaici-index3'"/>
								<xsl:with-param name="icon" select="35"/>
							</xsl:call-template>
							<xsl:call-template name="zhuanji">
								<xsl:with-param name="ѡ������" select="'�����������Ҵ�ѡ'"/>
								<xsl:with-param name="siteMapId" select="'jindaici-biblio'"/>
							</xsl:call-template>
						</ul>
					</li>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'zhongguoyunwenshi'"/>
					</xsl:call-template>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'cixueshijiang'"/>
					</xsl:call-template>
					<xsl:call-template name="format"/>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'lunwen'"/>
					</xsl:call-template>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'xintigequ'"/>
					</xsl:call-template>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'zawen'"/>
					</xsl:call-template>
					<xsl:call-template name="����">
						<xsl:with-param name="���ϵ���ID" select="'jinian'"/>
					</xsl:call-template>
					<xsl:apply-templates select="/����/����[@id='about']/����[@id='gy-shiyongshuoming']"/>
					<xsl:apply-templates select="/����/����[@id='about']/����[@id='gy-zhizuozhe']"/>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="����������������վ�����ߣ�"/>
							<param name="URL" value="http://longyusheng.org"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="����������������վ΢�������ߣ�"/>
							<param name="URL" value="http://weibo.com/lys1902"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
					<li>
						<xsl:text> </xsl:text>
						<object type="text/sitemap">
							<param name="Name" value="����������������վ����Դ������Ŀ�����ߣ�"/>
							<param name="URL" value="http://git.oschina.net/longyusheng/longyusheng"/>
							<param name="ImageNumber" value="15"/>
						</object>
					</li>
				</ul>
			</body>
		</html>
	</xsl:template>

<xsl:template name="ci">
	<xsl:param name="ѡ������"/>
	<xsl:param name="siteMapId"/>
	<li>
		<xsl:call-template name="siteMapNodeObject">
			<xsl:with-param name="text" select="'Ŀ¼'"/>
			<xsl:with-param name="ref" select="$siteMapId"/>
			<xsl:with-param name="icon" select="'1'"/>
		</xsl:call-template>
		<ul>
			<xsl:variable name="����" select="/����/����[@����=$ѡ������]"/>
			<xsl:variable name="ѡ��" select="/����/����[@����=$ѡ������]"/>
			<xsl:for-each select="$����/����">
				<xsl:variable name="����" select="$ѡ��/��[@����=current()/����]"/>
				<li>
					<xsl:text> </xsl:text>
					<object type="text/sitemap">
						<param name="Name">
							<xsl:attribute name="value">
								<xsl:call-template name="formatName">
									<xsl:with-param name="n" select="����"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:value-of select="$numXml/����[count($����/node())]/@Сд"/>
								<xsl:text>��</xsl:text>
							</xsl:attribute>
						</param>
						<param name="Local" value="{@�ʼ�·��}"/>
						<param name="ImageNumber" value="1"/>
					</object>
					<ul>
					<xsl:if test="$����/����[���� = current()/���� and @��='1']">
						<li>
							<xsl:text> </xsl:text>
							<object type="text/sitemap">
								<param name="Name">
									<xsl:attribute name="value">
										<xsl:call-template name="formatName">
											<xsl:with-param name="n" select="����"/>
										</xsl:call-template>
										<xsl:text>������</xsl:text>
									</xsl:attribute>
								</param>
								<param name="Local" value="{@����·��}"/>
							</object>
						</li>
					</xsl:if>
					<xsl:for-each select="$ѡ��/��[@����=current()/����]">
						<li>
							<xsl:text> </xsl:text>
							<object type="text/sitemap">
								<param name="Name">
									<xsl:attribute name="value">
										<xsl:value-of select="concat(@����, ' (', translate(����[1]/@text, '&#xA;&#xD;', ''), ')')"/>
										<xsl:choose>
											<xsl:when test="count(����) != 1">
												<xsl:value-of select="concat(' ��',$numXml/����[count(current()/����)]/@Сд, '��')"/>
											</xsl:when>
										</xsl:choose>
									</xsl:attribute>
								</param>
								<param name="Local" value="{@·��}"/>
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
	<xsl:param name="ѡ������"/>
	<xsl:param name="siteMapId"/>
	<xsl:call-template name="siteMapNode">
		<xsl:with-param name="text" select="'���˴��ǡ�����һ��'"/>
		<xsl:with-param name="ref" select="$siteMapId"/>
		<xsl:with-param name="icon" select="35"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="format">
	<li>
		<xsl:call-template name="siteMapNodeObject">
			<xsl:with-param name="text" select="'���δʸ���'"/>
			<xsl:with-param name="ref" select="'cipai-index'"/>
			<xsl:with-param name="icon" select="'1'"/>
		</xsl:call-template>
		<ul>
			<xsl:apply-templates select="/����/����[@id='cipai']/����[not(contains(@·��, 'index.html'))]"/>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'ԭ��Ŀ¼'"/>
				<xsl:with-param name="ref" select="'gl-mulu'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'���ƶ�������Ŀ¼'"/>
				<xsl:with-param name="ref" select="'gl-pinyin'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="siteMapNode">
				<xsl:with-param name="text" select="'������������Ŀ¼'"/>
				<xsl:with-param name="ref" select="'gl-zishu'"/>
				<xsl:with-param name="icon" select="35"/>
			</xsl:call-template>
			<xsl:call-template name="�г�����">
				<xsl:with-param name="���">ƽ�ϸ�</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="�г�����">
				<xsl:with-param name="���">���ϸ�</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="�г�����">
				<xsl:with-param name="���">ƽ����ת����</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="�г�����">
				<xsl:with-param name="���">ƽ����ͨҶ��</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="�г�����">
				<xsl:with-param name="���">ƽ���ϴ�Ҷ��</xsl:with-param>
			</xsl:call-template>
		</ul>
	</li>
</xsl:template>

<xsl:template name="�г�����">
	<xsl:param name="���"/>
	<li>
		<xsl:text> </xsl:text>
		<object type="text/sitemap">
			<param name="Name" value="{$���}"/>
			<param name="ImageNumber" value="1"/>
		</object>
		<ul>
		<xsl:for-each select="/����/����/����[���=$���]">
			<li>
				<xsl:text> </xsl:text>
				<object type="text/sitemap">
					<param name="Name">
						<xsl:attribute name="value">
							<xsl:for-each select="����">
								<xsl:if test="position() != 1">
									<xsl:text>��</xsl:text>
								</xsl:if>
								<xsl:value-of select="@����"/>
							</xsl:for-each>
						</xsl:attribute>
					</param>
					<param name="Local" value="{@·��}"/>
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