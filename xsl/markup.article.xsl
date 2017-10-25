<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:js="http://www.dreamstudioz.org/xslt/js" xmlns:dsz="urn:dszXML:MarkupTemplate" exclude-result-prefixes="msxsl js dsz" version="1.0">
	<xsl:import href="${markup-path}markup.xsl" />
	<xsl:output method="html" encoding="gb2312" indent="no" media-type="text/html; charset=gb2312"/>
	<xsl:preserve-space elements="CODE TEXTAREA PRE"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="/dszXML/dsz:body/H1">
				<xsl:apply-templates select="/dszXML/dsz:body/H1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="PRE/BR">
		<xsl:text disable-output-escaping="yes">&#13;&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="FIELDSET">
		<xsl:choose>
			<xsl:when test="LEGEND[1]">
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="translate(LEGEND, '&#9;&#10;&#13;&#32;&amp;&lt;&gt;', '')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@elementName">
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="@elementName"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="H1">
						<xsl:apply-templates select="H1"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="*|text()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="LEGEND"/>

	<xsl:template match="TEXTAREA[not(@elementName)]">
		<xsl:value-of select="concat('&lt;![CDATA[', text(), ']]&gt;')" disable-output-escaping="yes"/>
	</xsl:template>

	<xsl:template match="H1">
		<xsl:variable name="id" select="generate-id()"/>
		<xsl:variable name="fileID">
			<xsl:choose>
				<xsl:when test="name(parent::*)='FIELDSET'">
					<xsl:value-of select="../@id"/>
				</xsl:when>
				<xsl:when test="@id">
					<xsl:value-of select="@id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="parent::FIELDSET">
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="$nodeMaps/nodeMap[@src=name(current())]/@dest"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--档案文章-->
				<xsl:call-template name="elementBegin">
					<xsl:with-param name="name" select="'档案文章'"/>
					<xsl:with-param name="attrs">
						<xsl:text> fileID="</xsl:text>
						<xsl:value-of select="$fileID"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>

				<!--标题-->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="$nodeMaps/nodeMap[@src=name(current())]/@dest"/>
				</xsl:call-template>

				<!--作者、来源-->
				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and @elementName and contains(' 作者 来源 ', @elementName)]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>

				<!--正文-->
				<xsl:call-template name="elementBegin">
					<xsl:with-param name="name" select="'正文'"/>
				</xsl:call-template>

				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and not(@elementName and contains(' 作者 来源 备注 ', @elementName))]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>
				
				<!--/正文-->
				<xsl:call-template name="elementEndWithCR">
					<xsl:with-param name="name" select="'正文'"/>
				</xsl:call-template>

				<!--作者、来源-->
				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and @elementName and contains(' 备注 ', @elementName)]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>

				<!--/档案文章-->
				<xsl:call-template name="elementEndWithCR">
					<xsl:with-param name="name" select="'档案文章'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="H1/@id"/>
	<xsl:template match="H1/H2">
		<xsl:call-template name="CreateElement">
			<xsl:with-param name="elementName" select="'副题'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="FONT">
		<xsl:choose>
			<xsl:when test="@color = '#0000ff'"><!-- 蓝色：作家传记连接 -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'链接'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="#</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#000080'"><!-- 深蓝色：作品连接 -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'链接'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="$</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#008080'"><!-- 靛蓝色：文章连接 -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'链接'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="?f=</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#008000'"><!-- 靛蓝色：文章连接 -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'引用附注'"/>
					<xsl:with-param name="attrs">
						<xsl:if test="@title != ''">
							<xsl:text> id="</xsl:text>
							<xsl:value-of select="@title"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#00ff00'"><!-- 浅绿色：词汇注解 -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'链接'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="?note=</xsl:text>
						<xsl:choose>
							<xsl:when test="@title">
								<xsl:value-of select="@title"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="text()|*"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>