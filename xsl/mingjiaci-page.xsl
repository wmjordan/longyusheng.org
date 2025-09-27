<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:string="http://longyusheng.org/xslt/extensions/string" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:js="http://longyusheng.org/xslt/extensions/ciFormat" exclude-result-prefixes="msxsl js string context">
	<xsl:import href="pageframe.xsl"/>
	<!-- Parameters -->
	<xsl:param name="writerName"/>
	<xsl:param name="fID"/>
	<xsl:param name="html"/>
	<!-- End of Parameters -->

	<xsl:variable name="numXml" select="context:GetCachedDocument ('xsl/ChineseNum.xml')/��������"/>
	<xsl:variable name="ci" select="���Ҵ�ѡ/���Ҵ�[����=$writerName]/��[position()=number($fID)]"/>
	<xsl:variable name="ciList" select="���Ҵ�ѡ/���Ҵ�[����=$writerName]"/>
	<xsl:variable name="ciPai">
		<xsl:if test="$ci">
			<xsl:value-of select="$ci/����"/>
		</xsl:if>
	</xsl:variable>

	<xsl:template name="PageTitle">
		<xsl:choose>
			<xsl:when test="$ci">
				<xsl:value-of select="���Ҵ�ѡ/���Ҵ�/����[text()=$writerName]"/>
				<xsl:text>��</xsl:text>
				<xsl:value-of select="$ciPai"/>
				<xsl:variable name="���">
					<xsl:for-each select="$ci/����[1]/preceding-sibling::���[1]/node()[self::text()|self::*[name() != '��ע']]">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="�������" select="string(msxsl:node-set($���))"/>
				<xsl:if test="$������� != '' and string-length($�������) &lt; 11">
					<xsl:text>��</xsl:text>
					<xsl:value-of select="$�������"/>
				</xsl:if>
				<xsl:text>��(</xsl:text>
				<xsl:value-of select="js:firstLine(string(���Ҵ�ѡ/���Ҵ�[����=$writerName]/��[position()=number($fID)]/����))"/>
				<xsl:text>)</xsl:text>
				<xsl:if test="count($ci/����) != 1">
					<xsl:text>��</xsl:text>
					<xsl:value-of select="$numXml/����[count($ci/����)]/@��д"/>
					<xsl:text>��</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$ciList">
				<xsl:value-of select="$writerName"/>
				<xsl:text>��ѡ</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:text>����</xsl:text>
		<xsl:value-of select="���Ҵ�ѡ/����"/>
		<xsl:text>(������)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<xsl:element name="meta">
			<xsl:attribute name="name">keywords</xsl:attribute>
			<xsl:attribute name="content">
				<xsl:choose>
					<xsl:when test="$ci">
						<xsl:value-of select="concat (���Ҵ�ѡ/���Ҵ�/����[text()=$writerName], ', ', $ciPai)"/>
					</xsl:when>
					<xsl:when test="$ciList">
						<xsl:value-of select="$writerName"/>
					</xsl:when>
				</xsl:choose>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="���Ҵ�ѡ/����"/>
				<xsl:text>, ������</xsl:text>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">��ǰλ�ã�<xsl:call-template name="ListAncestorsInSiteMap"/>
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
						<xsl:with-param name="separator" select="'��'"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template name="RelatedLinksPart">
		<xsl:variable name="ref">
			<xsl:call-template name="ListSiblingsInSiteMap"/>
			<xsl:variable name="references">
				<xsl:if test="$writerName and $indexXml/����/����/����[����=$writerName and @��='1']">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'biblio'"/>
									<xsl:with-param name="ref" select="$writerName"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:value-of select="$writerName"/>
							<xsl:text>����</xsl:text>
							<xsl:if test="$indexXml/����/����/����[����=$writerName and @����='1']">
								<xsl:text>�뼯��</xsl:text>
							</xsl:if>
						</a>
					</li>
				</xsl:if>
				<xsl:if test="$indexXml/����/����/����/����[@���� = $ciPai]">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'format'"/>
									<xsl:with-param name="ref" select="$ciPai"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:value-of select="concat ('���ƣ�', $ciPai)"/>
						</a>
					</li>
				</xsl:if>
			</xsl:variable>
			<xsl:if test="msxsl:node-set($references)/*">
				<li class="title">�������</li>
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
		<div class="PrintContent">��<xsl:value-of select="/���Ҵ�ѡ/����"/>��</div>
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$ci">
					<xsl:call-template name="CiPaiLink"/>
					<xsl:if test="count($ci/����) &gt; 1">
						<span class="title2">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$numXml/����[count($ci/����)]/@��д"/>
							<xsl:text>��</xsl:text>
						</span>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$ciList">
					<xsl:call-template name="WriterLink"/>
					<span class="title2">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$numXml/����[count($ciList/��/����)]/@��д"/>
						<xsl:text>��</xsl:text>
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
			<xsl:when test="$indexXml/����/����/����/����[@���� = $ciPai]">
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
			<xsl:when test="$indexXml/���Ҵ�ѡ/���Ҵ�[(����=$writerName) and (����='1')]">
				<a>
					<xsl:attribute name="title"><xsl:value-of select="$writerName"/> ����<xsl:if test="$indexXml/���Ҵ�ѡ/���Ҵ�[����=$writerName]/����[text()='1']">
						<xsl:text>�뼯��</xsl:text>
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

	<xsl:template match="���Ҵ�">
		<div><xsl:apply-templates select="ѡ��"/></div>
		<xsl:if test="˵��|@edit|��/����[@edit]">
			<div class="HeadNote">
				<xsl:for-each select="˵��/����">
					<p>
						<xsl:text>����</xsl:text>
						<xsl:apply-templates/>
					</p>
				</xsl:for-each>
				<xsl:choose>
					<xsl:when test="@edit = '��'">
						<xsl:variable name="add" select="count(��/����[@edit='��'])"/>
						<p>
							<span>����δ�գ��޶�����<xsl:value-of select="count(��/����[not(@edit) or @edit = '��'])"/>�ס�</span>
							<xsl:if test="$add != 0">
								<span>��������������<xsl:value-of select="$add"/>�ס�</span>
							</xsl:if>
						</p>
					</xsl:when>
					<xsl:when test="@edit = 'ɾ'">
						<xsl:variable name="add" select="count(��/����[@edit='��'])"/>
						<p>
							<span>�޶���ɾ��������<xsl:value-of select="count(��/����[not(@edit) or @edit = 'ɾ'])"/>�ס�</span>
							<xsl:if test="$add != 0">
								<span>��������������<xsl:value-of select="$add"/>�ס�</span>
							</xsl:if>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="��/����[@edit]">
							<p>
								<xsl:variable name="plus" select="count(��/����[@edit='��'])"/>
								<xsl:variable name="del" select="count(��/����[@edit='ɾ'])"/>
								<xsl:variable name="add" select="count(��/����[@edit='��'])"/>
								<xsl:if test="$plus != 0 or $del != 0">
									<span>���湲��<xsl:value-of select="count(��/����[not(@edit) or @edit = 'ɾ'])"/>�ס�</span>
									<span>
										<xsl:text>�޶���</xsl:text>
										<xsl:if test="$plus != 0">��<xsl:value-of select="$plus"/>��</xsl:if>
										<xsl:if test="$del != 0">ɾ<xsl:value-of select="$del"/>��</xsl:if>
										<xsl:text>������</xsl:text>
										<xsl:value-of select="count(��/����[not(@edit) or @edit = '��'])"/>
										<xsl:text>�ס�</xsl:text>
									</span>
								</xsl:if>
								<xsl:if test="$add != 0">
									<span>��������������<xsl:value-of select="$add"/>�ס�</span>
								</xsl:if>
							</p>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:if>
		<br />
		<div id="ciList">
			<xsl:for-each select="��">
				<xsl:variable name="pos" select="position()"/>
				<xsl:variable name="cnt" select="count(����)"/>
				<div class="list">
					<span class="listitem">
						<a>
							<xsl:attribute name="href">
								<xsl:choose>
									<xsl:when test="$cnt = 1 and ����/@id">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'ci'"/>
											<xsl:with-param name="ref" select="����/@id"/>
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
							<xsl:if test="���">
								<xsl:attribute name="title">
									<xsl:value-of select="���"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:if test="position() = 1">
								<xsl:attribute name="id">anc_next</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="����"/>
						</a>
					</span>
					<span class="listdesc" style="font-size: 80%;">
						<xsl:for-each select="����">
							<xsl:if test="preceding-sibling::*[1][self::���]">
								<div class="tiji"><xsl:apply-templates select="preceding-sibling::*[1][self::���]" mode="substract"/></div>
							</xsl:if>
							<div>
								<xsl:text>����</xsl:text>
								<xsl:value-of select="js:firstLine(string(����))"/>
								<xsl:text>��</xsl:text>
								<xsl:if test="@edit">
									<span class="edit"><xsl:value-of select="@edit"/></span>
								</xsl:if>
							</div>
						</xsl:for-each>
					</span>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="��">
		<xsl:for-each select="����">
			<xsl:if test="@id">
				<a name="{@id}"></a>
			</xsl:if>
			<xsl:if test="@edit">
				<div class="edit"><xsl:call-template name="edit"/></div>
			</xsl:if>
			<xsl:if test="preceding-sibling::*[1][name()='���']">
				<xsl:apply-templates select="preceding-sibling::*[1]"/>
			</xsl:if>
			<div class="ci">
				<xsl:apply-templates select="current()"/>
			</div>
			<xsl:if test="following-sibling::*[1][self::��¼] or following-sibling::�����汾[last()]/following-sibling::*[1][self::��¼]">
				<xsl:variable name="bodyID" select="generate-id()"/>
				<xsl:for-each select="following-sibling::��¼[generate-id(preceding-sibling::����[1])=$bodyID]">
					<xsl:apply-templates select="current()"/>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="@id and $indexXml/����/��ѡ����/��[@id = current()/@id]/����">
				<div class="Appendix">
					<div>������£�</div>
					<xsl:for-each select="$indexXml/����/��ѡ����/��[@id = current()/@id]/����">
						<div class="list">
							<span class="listitem" style="float: left;">
								<xsl:text>��</xsl:text>
								<a>
									<xsl:attribute name="href">
										<xsl:call-template name="mappath">
											<xsl:with-param name="type" select="'arc'"/>
											<xsl:with-param name="ref" select="@id"/>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:apply-templates select="����"/>
								</a>
								<xsl:text>����</xsl:text>
							</span>
							<span class="listdesc" style="float: left;">
								<ol id="{../@id}-{@id}">
									<xsl:for-each select="����">
										<li>
											<xsl:for-each select="ancestor::��������[position () != 1]">
												<xsl:text>����</xsl:text>
											</xsl:for-each>
											<a>
												<xsl:attribute name="href">
													<xsl:call-template name="mappath">
														<xsl:with-param name="type" select="'file'"/>
														<xsl:with-param name="ref" select="@id"/>
													</xsl:call-template>
												</xsl:attribute>
												<xsl:apply-templates select="����"/>
											</a>
										</li>
									</xsl:for-each>
								</ol>
							</span>
						</div>
					</xsl:for-each>
				</div>
			</xsl:if>
			<xsl:if test="following-sibling::����">
				<hr />
			</xsl:if>
		</xsl:for-each>
		<xsl:variable name="prev_pos" select="count(preceding-sibling::*[name()='��'])"/>
		<div id="ci_nav" class="SiblingLinks">
			<xsl:choose>
				<xsl:when test="$prev_pos &gt; 0">
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'��һ��'"/>
						<xsl:with-param name="text" select="preceding-sibling::*[1]/����"/>
						<xsl:with-param name="href">
							<xsl:choose>
								<xsl:when test="preceding-sibling::*[1][count(����)=1]/����[@id!='']">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'ci'"/>
										<xsl:with-param name="ref" select="preceding-sibling::*[1]/����/@id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'coll'"/>
										<xsl:with-param name="ref" select="../����"/>
										<xsl:with-param name="val" select="$prev_pos"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="parent::*[self::*[preceding-sibling::*[1][name()='���Ҵ�']]]">
					<xsl:variable name="preceding_writer" select="parent::*/preceding-sibling::*[1]"/>
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorPrev"/>
						<xsl:with-param name="class" select="'Prev'"/>
						<xsl:with-param name="label" select="'��һ����'"/>
						<xsl:with-param name="text" select="$preceding_writer/����"/>
						<xsl:with-param name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'coll'"/>
									<xsl:with-param name="ref" select="$preceding_writer/����"/>
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
						<xsl:with-param name="label" select="'��һ��'"/>
						<xsl:with-param name="text" select="following-sibling::*[1]/����"/>
						<xsl:with-param name="href">
							<xsl:choose>
								<xsl:when test="following-sibling::*[1][count(����)=1]/����[@id!='']">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'ci'"/>
										<xsl:with-param name="ref" select="following-sibling::*[1]/����/@id"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="mappath">
										<xsl:with-param name="type" select="'coll'"/>
										<xsl:with-param name="ref" select="../����"/>
										<xsl:with-param name="val" select="$prev_pos + 2"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="parent::*[self::*[following-sibling::*[1][name()='���Ҵ�']]]">
					<xsl:variable name="following_writer" select="parent::*/following-sibling::*[1]"/>
					<xsl:call-template name="CreateAdjacentLink">
						<xsl:with-param name="id" select="$AnchorNext"/>
						<xsl:with-param name="class" select="'Next'"/>
						<xsl:with-param name="label" select="'��һ����'"/>
						<xsl:with-param name="text" select="$following_writer/����"/>
						<xsl:with-param name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'coll'"/>
									<xsl:with-param name="ref" select="$following_writer/����"/>
								</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>
	
	<xsl:template match="���">
		<div class="tiji">
			<xsl:if test="string-length(current()) &lt; 9">
				<xsl:attribute name="align">center</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="string-length(current()) = 2">
					<xsl:value-of select="concat(substring(current(), 1, 1), '��', substring(current(), 2, 1))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="text()|*"/>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="���" mode="substract">
		<div><xsl:apply-templates select="text()|*[name() != '��ע']"/></div>
	</xsl:template>
	<xsl:template match="��ע">
		<p class="tizhu">����<xsl:apply-templates select="text()|*"/></p>
	</xsl:template>
	
	<xsl:template match="����">
		<div class="body">
			<xsl:copy-of select="js:formatCi(string(����))"/>
		</div>
	</xsl:template>
	<xsl:template match="��¼">
		<div class="Appendix">
			<xsl:apply-templates select="ע��" mode="note"/>
			<xsl:apply-templates select="����[1]"/>
			<xsl:choose>
				<xsl:when test="count(����)=1">
					<xsl:apply-templates select="����"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="����|����[position()&gt;1]">
						<div style="margin-left: 15pt;"><xsl:apply-templates select="current()"/></div>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="����">
		<xsl:text>��</xsl:text>
		<xsl:apply-templates select="text()|*"/>
		<xsl:text>��</xsl:text>
	</xsl:template>

	<xsl:template match="ע��" mode="note">
		<xsl:variable name="node" select="$ciNotesXml/���ϵ���/����/ע��[�ʻ�=current()/@�ؼ���]"/>
		<div>
			<b><xsl:value-of select="@�ؼ���"/></b>
			<xsl:text>��</xsl:text>
			<xsl:choose>
				<xsl:when test="*|text()">
					<xsl:apply-templates />
				</xsl:when>
				<xsl:when test="$node">
					<xsl:choose>
						<xsl:when test="count($node/ע��) &gt; 1">
							<dl class="notelist">
								<xsl:for-each select="$node/ע��">
									<dd><xsl:apply-templates select="." mode="note"/></dd>
								</xsl:for-each>
							</dl>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$node/ע��" mode="note"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">�Ҳ��� <xsl:value-of select="@�ؼ���"/> ��ע�͡�</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="ע��" mode="note">
		<xsl:choose>
			<xsl:when test=".//����">
				<xsl:choose>
					<xsl:when test="����">
						<xsl:apply-templates select="����"/>
						<a>
							<xsl:attribute name="title">
								<xsl:text>�μ���</xsl:text>
								<xsl:value-of select="current()/../�ʻ�"/>
								<xsl:text>������ϸע��</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="href">
								<xsl:call-template name="mappath">
									<xsl:with-param name="type" select="'note'"/>
									<xsl:with-param name="ref" select="current()/../../@ID"/>
									<xsl:with-param name="val" select="../�ʻ�[1]"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:text>����</xsl:text>
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

	<xsl:template name="edit">
		<xsl:choose>
			<xsl:when test="@edit = 'ɾ'">
				<xsl:text>�޶���ɾ</xsl:text>
			</xsl:when>
			<xsl:when test="@edit = '��'">
				<xsl:text>�޶�����</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>ԭ��δ�գ���������</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="RelativeArticles">
		<xsl:if test="$ci/����/@id">
			<xsl:call-template name="ListReferenceArticles">
				<xsl:with-param name="articles" select="$indexXml/����/��ѡ����/��[@id = $ci/����/@id]/����"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="copyrightText">
		<div>
			<xsl:choose>
				<xsl:when test="/���Ҵ�ѡ/���� = '�����������Ҵ�ѡ'">�������������Ҵ�ѡ����<u>�Ϻ��ż�������</u>һ��������桢һ���߾����°档</xsl:when>
				<xsl:when test="/���Ҵ�ѡ/���� = '�������Ҵ�ѡ'">���������Ҵ�ѡ����<u>�Ϻ��ż�������</u>һ�Ű�����档</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>

</xsl:stylesheet>
