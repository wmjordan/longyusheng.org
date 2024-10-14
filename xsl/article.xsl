<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:f="http://longyusheng.org/xslt/extensions/ciFormat" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" exclude-result-prefixes="msxsl context f">

	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl" />

	<xsl:param name="file"/>
	<xsl:param name="archive" select="$file/ancestor::���ϵ���[1]"/>

	<xsl:param name="�������Ҵ�ѡ" select="context:GetCachedDocument ('�������Ҵ�ѡ.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�����������Ҵ�ѡ" select="context:GetCachedDocument ('�����������Ҵ�ѡ.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="���δʸ���" select="context:GetCachedDocument ('���δʸ���.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>

	<xsl:variable name="����">
		<xsl:choose>
			<xsl:when test="$file/����">
				<xsl:call-template name="ListWriters">
					<xsl:with-param name="article" select="$file"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ListWriters">
					<xsl:with-param name="article" select="$archive"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$archive/@archiveID = '.'">
				<xsl:text>����������������վ</xsl:text>
			</xsl:when>
			<xsl:when test="$file">
				<xsl:if test="$file">
					<xsl:value-of select="$file/����"/>
				</xsl:if>
				<xsl:if test="$file/���� or $archive/����">
					<xsl:value-of select="concat('(', $����, ')')"/>
				</xsl:if>
				<xsl:if test="$file/���� != $archive/����">
					<xsl:text>����</xsl:text>
					<xsl:value-of select="$archive/����"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$archive/����"/>
				<xsl:if test="$archive/����">
					<xsl:value-of select="concat('(', $����, ')')"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<xsl:if test="not ($archive/@archiveID = '.')">
			<xsl:call-template name="ArticleNavigationPart"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<meta name="keywords">
			<xsl:attribute name="content">
				<xsl:for-each select="$file/ancestor-or-self::��������[1]//�ؼ���|$archive/�ؼ���">
					<xsl:value-of select="."/>
					<xsl:text>, </xsl:text>
				</xsl:for-each>
				<xsl:value-of select="$archive/����"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<xsl:template name="TitlePart">
		<xsl:if test="not ($file/@fileID = 'cover')">
			<div class="PrintContent"><xsl:value-of select="$archive/����"/></div>
			<h1 class="PageTitle">
				<xsl:choose>
					<xsl:when test="$file"><xsl:apply-templates select="$file/����"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$archive/����"/></xsl:otherwise>
				</xsl:choose>
			</h1>
			<xsl:copy-of select="$����"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page">
			<xsl:choose>
				<xsl:when test="$file">
					<xsl:apply-templates select="$file" mode="default"/>
					<xsl:if test="not ($archive/@archiveID = '.')">
						<xsl:call-template name="LinkNextArticle">
							<xsl:with-param name="article" select="$file"/>
						</xsl:call-template>
						<xsl:call-template name="LinkPreviousArticle">
							<xsl:with-param name="article" select="$file"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="$archive"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template name="ListWriters">
		<xsl:param name="article"/>
		<div class="writer">
			<xsl:for-each select="$article/����">
				<xsl:if test="position() != 1">
					<xsl:text>��</xsl:text>
				</xsl:if>
				<u><xsl:value-of select="."/></u>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template name="PageDescriptionMetaTag">
		<meta name="description" content="{$archive/����}" />
	</xsl:template>

	<xsl:template match="���ϵ���">
		<div style="padding-left: 15pt;">
			<xsl:if test="����">
				<div><xsl:apply-templates select="����"/></div>
			</xsl:if>
			<xsl:for-each select="��������">
				<div>
					<a>
						<xsl:attribute name="href">
							<xsl:call-template name="mappath">
								<xsl:with-param name="type" select="'file'"/>
								<xsl:with-param name="ref" select="@fileID"/>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:apply-templates select="����"/>
					</a>
					<xsl:if test="����">
						<xsl:text>��</xsl:text>
						<xsl:for-each select="����">
							<xsl:if test="position() != 1">
								<xsl:text>��</xsl:text>
							</xsl:if>
							<u><xsl:value-of select="."/></u>
						</xsl:for-each>
						<xsl:text>��</xsl:text>
					</xsl:if>
					<xsl:apply-templates select="����/��������"/>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="��������/����">
		<xsl:apply-templates select="������|����|С����|�о���|����|����|��������|�����"/>
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
				<xsl:value-of select="ancestor::��������[1]/����//���ø�ע[@id=current()/@id or position() = current()/@id]"/>
			</xsl:variable>
			<xsl:if test="string-length($text) != 0"><xsl:value-of select="$text"/>��</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="����/��������">
		<div style="padding-left: 15pt;">
			<xsl:number level="single" count="��������" format="һ��"/>
			<a>
				<xsl:attribute name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'file'"/>
						<xsl:with-param name="ref" select="@fileID"/>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:apply-templates select="����"/>
			</a>
		</div>
	</xsl:template>

	<xsl:template match="ע��">
		<span class="note"><xsl:apply-templates /></span>
	</xsl:template>

	<xsl:template match="��������" mode="default">
		<xsl:variable name="˵��" select="ancestor-or-self::*[self::��������|self::���ϵ���]/˵��"/>
		<xsl:variable name="��ע" select="ancestor-or-self::*[self::��������|self::���ϵ���]/��ע"/>
		<xsl:if test="$˵��">
			<div class="HeadNote"><xsl:apply-templates select="$˵��"/></div>
		</xsl:if>
		<xsl:apply-templates select="����"/>
		<xsl:if test="$��ע">
			<div class="FootNote">
				<div class="ItemTitle">��ע��</div>
				<xsl:apply-templates select="$��ע"/>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="������">
		<h2><a name="st{count(preceding-sibling::������)}"/><xsl:apply-templates /></h2>
	</xsl:template>

	<xsl:template match="С����">
		<h3><xsl:apply-templates /></h3>
	</xsl:template>

	<xsl:template match="����">
		<p>
			<xsl:if test="not (@����) or (@���� != 'false')">
				<xsl:text>����</xsl:text>
			</xsl:if>
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="����[name(child::*[1])='����']">
		<blockquote class="quot">
			<xsl:for-each select="����">
				<div class="body">
					<xsl:copy-of select="f:formatCi(string(current()))"/>
				</div>
			</xsl:for-each>
			<br />
		</blockquote>
		<xsl:if test="����[text()|*]">
			<div align="right"><xsl:apply-templates select="(����/text())|(����/*)"/></div>
		</xsl:if>
	</xsl:template>
	<xsl:template match="����[child::*[1][self::����]]">
		<xsl:if test="����[text()|*]">
			<div align="right"><xsl:apply-templates select="(����/text())|(����/*)"/></div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="����[@xhref and not(����)]">
		<blockquote class="quot">
			<xsl:variable name="ciID" select="substring-after(current()/@xhref, '$')"/>
			<xsl:choose>
				<xsl:when test="$indexXml/����/��ѡ����[@����='�������Ҵ�ѡ']/��[@id=$ciID]">
					<xsl:copy-of select="f:formatCi(string($�������Ҵ�ѡ/���Ҵ�ѡ/���Ҵ�/��/*[self::���� or self::�����汾][@id=$ciID]/����))"/>
				</xsl:when>
				<xsl:when test="$indexXml/����/��ѡ����[@����='�����������Ҵ�ѡ']/��[@id=$ciID]">
					<xsl:copy-of select="f:formatCi(string($�����������Ҵ�ѡ/���Ҵ�ѡ/���Ҵ�/��/����[@id=$ciID]/����))"/>
				</xsl:when>
			</xsl:choose>
		</blockquote>
	</xsl:template>

	<xsl:template match="�о���">
		<xsl:choose>
			<xsl:when test="contains ('1IiAa', @��ʽ)">
				<ol class="MF_enum1" type="{@��ʽ}">
					<xsl:for-each select="��Ŀ|�о���">
						<xsl:choose>
							<xsl:when test="name()='��Ŀ'">
								<li class="MF_enum1">
									<xsl:apply-templates />
								</li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</ol>
			</xsl:when>
			<xsl:when test="contains ('square disc circle', @��ʽ)">
				<ul class="MF_enum1" type="{@��ʽ}">
					<xsl:for-each select="��Ŀ|�о���">
						<xsl:choose>
							<xsl:when test="name()='��Ŀ'">
								<li class="MF_enum1">
									<xsl:apply-templates />
								</li>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</ul>
			</xsl:when>
			<xsl:when test="@��ʽ='һ��'">
				<div class="MF_enum0">
					<xsl:for-each select="��Ŀ|�о���">
						<xsl:choose>
							<xsl:when test="name()='��Ŀ'">
								<div class="MF_enum0">
									<xsl:number count="��Ŀ" level="single" format="һ��"/>
									<xsl:apply-templates />
								</div>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="MF_enum0">
					<xsl:for-each select="��Ŀ|�о���">
						<xsl:choose>
							<xsl:when test="name()='��Ŀ'">
								<div class="MF_enum0">
									<xsl:value-of select="@��ʽ"/>
									<xsl:apply-templates />
								</div>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ArticleNavigationPart">
		<div class="NaviPart">
			<xsl:text>��ǰλ�ã�</xsl:text>
			<xsl:choose>
				<xsl:when test="$file/@siteMapID">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$file/@siteMapID"/>
					</xsl:call-template>
					<xsl:value-of select="$file/����"/>
				</xsl:when>
				<xsl:when test="$file/ancestor::���ϵ���[@archiveID]">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$file/ancestor::���ϵ���/@archiveID"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="not($file)">
					<xsl:call-template name="ListAncestorsInSiteMap">
						<xsl:with-param name="id" select="$archive/@archiveID"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ListAncestorsInSiteMap"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="NavigationPartExtraAncestors"/>
		</div>
	</xsl:template>

	<xsl:template name="RelatedLinksPart">
		<xsl:if test="not ($archive/@archiveID = '.')">
			<xsl:variable name="ref">
				<xsl:if test="$file/����/������ and not($file[@subTitleNavigation = 'false'])">
					<xsl:call-template name="ListSubTitleNavigation"/>
				</xsl:if>
				<xsl:apply-templates select="$file/�������"/>
				<xsl:choose>
					<xsl:when test="$file/@siteMapID">
						<xsl:call-template name="ListSiblingsInSiteMap">
							<xsl:with-param name="id" select="$file/@siteMapID"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$file/ancestor::���ϵ���[@archiveID]">
						<xsl:call-template name="ListSiblingsInSiteMap">
							<xsl:with-param name="id" select="$file/ancestor::���ϵ���/@archiveID"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ListSiblingsInSiteMap"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="NavigationPartExtraSiblings"/>
			</xsl:variable>
			<xsl:if test="msxsl:node-set($ref)/*">
				<ul class="NaviPart">
					<xsl:copy-of select="$ref" />
				</ul>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="NavigationPartExtraAncestors">
		<xsl:for-each select="$file/ancestor::��������">
			<xsl:call-template name="siteMapNodeLink">
				<xsl:with-param name="href">
					<xsl:call-template name="mappath">
						<xsl:with-param name="type" select="'file'"/>
						<xsl:with-param name="ref" select="@fileID"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="text" select="����"/>
				<xsl:with-param name="separator" select="'��'"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="NavigationPartExtraSiblings">
		<xsl:if test="$file">
			<xsl:variable name="refs" select="$file/����/*[not(self::��������)]/descendant-or-self::*[starts-with(@xhref, '$')]"/>
			<xsl:if test="$refs">
				<ul class="jd_menu">
					<li class="title">
						<div>��ش���</div>
						<ul>
						<xsl:for-each select="$refs">
							<xsl:variable name="xhref" select="@xhref"/>
							<xsl:variable name="pos" select="position()"/>
							<xsl:if test="not ($refs[position() &lt; $pos][@xhref = $xhref])">
								<xsl:variable name="refNode" select="$indexXml/����/��ѡ����/��[@id=substring-after(current()/@xhref, '$')]"/>
								<li>
									<a>
										<xsl:attribute name="href">
											<xsl:call-template name="mappath">
												<xsl:with-param name="type" select="'ci'"/>
												<xsl:with-param name="ref" select="substring-after(@xhref, '$')"/>
											</xsl:call-template>
										</xsl:attribute>
										<u><xsl:value-of select="$refNode/@����"/></u>
										<xsl:text>��</xsl:text>
										<xsl:value-of select="$refNode/@����"/>
										<xsl:text>����</xsl:text>
										<xsl:value-of select="$refNode/@��������"/>
										<xsl:text>��</xsl:text>
									</a>
								</li>
							</xsl:if>
						</xsl:for-each>
						</ul>
					</li>
				</ul>
			</xsl:if>
		</xsl:if>
	</xsl:template>

<xsl:template name="LinkNextArticle">
	<xsl:param name="article" select="current()"/>
	<xsl:variable name="nextSibling" select="$article/following::��������[1]"/>
	<xsl:variable name="firstDecendant" select="$article//��������[1]"/>
	<xsl:choose>
		<xsl:when test="$firstDecendant">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$firstDecendant"/>
				<xsl:with-param name="id" select="'anc_next'"/>
				<xsl:with-param name="label" select="'��һƪ��'"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$nextSibling">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$nextSibling"/>
				<xsl:with-param name="id" select="'anc_next'"/>
				<xsl:with-param name="label" select="'��һƪ��'"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="LinkPreviousArticle">
	<xsl:param name="article" select="current()"/>
	<xsl:variable name="previousSibling" select="$article/preceding-sibling::��������[1]"/>
	<xsl:variable name="firstAncestor" select="$article/ancestor::��������[1]"/>
	<xsl:choose>
		<xsl:when test="$previousSibling">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$previousSibling"/>
				<xsl:with-param name="id" select="'anc_prev'"/>
				<xsl:with-param name="label" select="'��һƪ��'"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$firstAncestor">
			<xsl:call-template name="LinkToArticle">
				<xsl:with-param name="article" select="$firstAncestor"/>
				<xsl:with-param name="id" select="'anc_prev'"/>
				<xsl:with-param name="label" select="'��һƪ��'"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="LinkToArticle">
	<xsl:param name="article"/>
	<xsl:param name="label"/>
	<xsl:param name="id"/>
	<div class="NaviPart">
		<xsl:value-of select="$label"/>
		<a>
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:attribute name="href">
				<xsl:call-template name="mappath">
					<xsl:with-param name="type" select="'file'"/>
					<xsl:with-param name="ref">
						<xsl:choose>
							<xsl:when test="$article/@fileID != 'index'">
								<xsl:value-of select="$article/@fileID"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$article/../@archiveID"/>
								<xsl:text>-index</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:apply-templates select="$article/����"/>
		</a>
	</div>
</xsl:template>

	<xsl:template name="ListSubTitleNavigation">
		<li class="title">��ҳ����</li>
		<xsl:for-each select="$file/����/������">
			<li>
				<a href="#st{position()-1}"><xsl:value-of select="."/></a>
			</li>
		</xsl:for-each>
	</xsl:template>

<xsl:template name="copyrightText">
		<xsl:choose>
			<xsl:when test="$archive/@archiveID = '.'"/>
			<xsl:when test="$file">
				<xsl:apply-templates select="$file/ancestor::���ϵ���/����Ȩ"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="$archive/����Ȩ"/>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

</xsl:stylesheet>