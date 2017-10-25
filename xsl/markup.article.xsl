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
				<!--��������-->
				<xsl:call-template name="elementBegin">
					<xsl:with-param name="name" select="'��������'"/>
					<xsl:with-param name="attrs">
						<xsl:text> fileID="</xsl:text>
						<xsl:value-of select="$fileID"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>

				<!--����-->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="$nodeMaps/nodeMap[@src=name(current())]/@dest"/>
				</xsl:call-template>

				<!--���ߡ���Դ-->
				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and @elementName and contains(' ���� ��Դ ', @elementName)]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>

				<!--����-->
				<xsl:call-template name="elementBegin">
					<xsl:with-param name="name" select="'����'"/>
				</xsl:call-template>

				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and not(@elementName and contains(' ���� ��Դ ��ע ', @elementName))]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>
				
				<!--/����-->
				<xsl:call-template name="elementEndWithCR">
					<xsl:with-param name="name" select="'����'"/>
				</xsl:call-template>

				<!--���ߡ���Դ-->
				<xsl:for-each select="following-sibling::*[name() != 'H1' and generate-id(preceding-sibling::H1[1]) = $id and @elementName and contains(' ��ע ', @elementName)]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>

				<!--/��������-->
				<xsl:call-template name="elementEndWithCR">
					<xsl:with-param name="name" select="'��������'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="H1/@id"/>
	<xsl:template match="H1/H2">
		<xsl:call-template name="CreateElement">
			<xsl:with-param name="elementName" select="'����'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="FONT">
		<xsl:choose>
			<xsl:when test="@color = '#0000ff'"><!-- ��ɫ�����Ҵ������� -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'����'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="#</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#000080'"><!-- ����ɫ����Ʒ���� -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'����'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="$</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#008080'"><!-- ����ɫ���������� -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'����'"/>
					<xsl:with-param name="attrs">
						<xsl:text> xhref="?f=</xsl:text>
						<xsl:value-of select="@title"/>
						<xsl:text>"</xsl:text>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#008000'"><!-- ����ɫ���������� -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'���ø�ע'"/>
					<xsl:with-param name="attrs">
						<xsl:if test="@title != ''">
							<xsl:text> id="</xsl:text>
							<xsl:value-of select="@title"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@color = '#00ff00'"><!-- ǳ��ɫ���ʻ�ע�� -->
				<xsl:call-template name="CreateElement">
					<xsl:with-param name="elementName" select="'����'"/>
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