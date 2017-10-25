<?xml version='1.0' encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" version="1.0" indent="yes" encoding="gb2312" omit-xml-declaration="yes"/> 

	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<?xml version="1.0" encoding="GB2312"?>]]></xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:element name="唐宋名家词">
			<xsl:for-each select="资料档案/档案文章/正文">
				<xsl:apply-templates select="作家"/>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="作家">
		<xsl:variable name="currentwritor" select="text()"/>
		<xsl:element name="名家词">
			<xsl:element name="作家">
				<xsl:value-of select="text()" />
			</xsl:element>
			<xsl:if test="following-sibling::*[1][name()='段落']">
				<xsl:element name="选本">
					<xsl:value-of select="following-sibling::段落[1]" />
				</xsl:element>
			</xsl:if>
			<xsl:for-each select="following-sibling::词牌[text()!=''][preceding-sibling::作家[1][text()=$currentwritor]]">
				<xsl:element name="词">
					<xsl:variable name="currentci" select="generate-id()"/>
					<xsl:choose>
						<xsl:when test="text()=''"/>
						<xsl:when test="text()!='又'">
							<xsl:element name="词牌">
								<xsl:value-of select="text()" />
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="词牌">
								<xsl:value-of select="preceding-sibling::词牌[text()!='' and text()!='又'][1]" />
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:element name="正文">
						<xsl:element name="段落">
							<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
							<xsl:for-each select="following-sibling::段落[preceding-sibling::作家[1][text()=$currentwritor]][preceding-sibling::词牌[text()!=''][1][generate-id()=$currentci]]">
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