<?xml version='1.0' encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" version="1.0" indent="yes" encoding="gb2312" omit-xml-declaration="yes"/> 

	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<?xml version="1.0" encoding="GB2312"?>]]></xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:element name="�������Ҵ�">
			<xsl:for-each select="���ϵ���/��������/����">
				<xsl:apply-templates select="����"/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="����">
		<xsl:variable name="currentwritor" select="text()"/>
		<xsl:element name="���Ҵ�">
			<xsl:element name="����">
				<xsl:value-of select="text()" />
			</xsl:element>
			<xsl:if test="following-sibling::*[1][name()='����']">
				<xsl:element name="ѡ��">
					<xsl:value-of select="following-sibling::����[1]" />
				</xsl:element>
			</xsl:if>
			<xsl:for-each select="following-sibling::����[text()!=''][preceding-sibling::����[1][text()=$currentwritor]]">
				<xsl:element name="��">
					<xsl:variable name="currentci" select="generate-id()"/>
					<xsl:choose>
						<xsl:when test="text()=''"/>
						<xsl:when test="text()!='��'">
							<xsl:element name="����">
								<xsl:value-of select="text()" />
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="����">
								<xsl:value-of select="preceding-sibling::����[text()!='' and text()!='��'][1]" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:element name="����">
						<xsl:element name="����">
							<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
							<xsl:for-each select="following-sibling::����[preceding-sibling::����[1][text()=$currentwritor]][preceding-sibling::����[text()!=''][1][generate-id()=$currentci]]">
								<xsl:value-of select="text()" />
								<xsl:text>&#13;&#10;</xsl:text>
							</xsl:for-each>
							<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
							<xsl:text>&#13;&#10;</xsl:text>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>