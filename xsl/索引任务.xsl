<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:dic="http://longyusheng.org/xslt/extensions/stringdictionary" xmlns:string="http://longyusheng.org/xslt/extensions/string" exclude-result-prefixes="context dic string">
	<xsl:import href="common.xsl" />
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:param name="indexXml" select="context:ClearDocumentCache ()"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('ע��.xml')"/>
	<xsl:param name="��վ��ͼ" select="context:GetCachedDocument ('SiteMap.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="���δʸ���" select="context:GetCachedDocument ('���δʸ���.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�������Ҵ�ѡ" select="context:GetCachedDocument ('�������Ҵ�ѡ.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="���δʼ�" select="context:GetCachedDocument ('���δʼ�.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�����������Ҵ�ѡ" select="context:GetCachedDocument ('�����������Ҵ�ѡ.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="��������ʼ�" select="context:GetCachedDocument ('��������ʼ�.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�й�����ʷ" select="context:GetCachedDocument ('�й�����ʷ.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="��ѧʮ��" select="context:GetCachedDocument ('��ѧʮ��.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="��ѧ����" select="context:GetCachedDocument ('��ѧ����.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="����ר��" select="context:GetCachedDocument ('����ר��.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�������" select="context:GetCachedDocument ('�������.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="����" select="context:GetCachedDocument ('����.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="����" select="context:GetCachedDocument ('����.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="�������" select="context:GetCachedDocument ('�������.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="˵��" select="context:GetCachedDocument ('˵��.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>

	<xsl:variable name="��ѧ����" select="$��ѧʮ��|$�й�����ʷ"/>

	<xsl:template match="/">
		<xsl:variable name="year">
			<xsl:call-template name="chNumber">
				<xsl:with-param name="n" select="context:GetNow ('yyyy')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="month">
			<xsl:call-template name="chNumber">
				<xsl:with-param name="n" select="context:GetNow ('MM')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="date">
			<xsl:call-template name="chNumber">
				<xsl:with-param name="n" select="context:GetNow ('dd')"/>
			</xsl:call-template>
		</xsl:variable>
		<���� date="{concat($year,'��',$month,'��',$date,'��')}">
			<xsl:call-template name="����">
				<xsl:with-param name="����" select="'�������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�������Ҵ�ѡ"/>
				<xsl:with-param name="�ʼҽ���" select="$���δʼ�"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="����" select="'�����������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�����������Ҵ�ѡ"/>
				<xsl:with-param name="�ʼҽ���" select="$��������ʼ�"/>
			</xsl:call-template>
			<xsl:call-template name="�������">
				<xsl:with-param name="����" select="'�������'"/>
				<xsl:with-param name="�������" select="$�������"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$�й�����ʷ"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$��ѧʮ��"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$����ר��"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$��ѧ����"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$�������"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$˵��"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$����"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="�ļ�" select="$����"/>
			</xsl:call-template>
			<xsl:call-template name="��ѡ����">
				<xsl:with-param name="����" select="'�������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�������Ҵ�ѡ"/>
			</xsl:call-template>
			<xsl:call-template name="��ѡ����">
				<xsl:with-param name="����" select="'�����������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�����������Ҵ�ѡ"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="����" select="'�������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�������Ҵ�ѡ"/>
			</xsl:call-template>
			<xsl:call-template name="����">
				<xsl:with-param name="����" select="'�����������Ҵ�ѡ'"/>
				<xsl:with-param name="��ѡ" select="$�����������Ҵ�ѡ"/>
			</xsl:call-template>
			<xsl:call-template name="����"/>
			<xsl:call-template name="siteMap"/>
			<xsl:call-template name="�ʻ�"/>
		</����>
	</xsl:template>

	<xsl:template name="����">
		<xsl:param name="����"/>
		<xsl:param name="��ѡ"/>
		<xsl:param name="�ʼҽ���"/>

		<���� ����="{$����}">
			<xsl:for-each select="$��ѡ/���Ҵ�ѡ/���Ҵ�">
				<���� id="{@id}">
					<xsl:variable name="����" select="$�ʼҽ���/�������/����[���� = current()/����]"/>
					<xsl:attribute name="�ʼ�·��">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="@id"/>
						<xsl:text>/index.html</xsl:text>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$����">
							<xsl:attribute name="����·��">
								<xsl:text>ciren/</xsl:text>
								<xsl:value-of select="@id"/>
								<xsl:text>.html</xsl:text>
							</xsl:attribute>
							<xsl:if test="$����/����">
								<xsl:attribute name="��">1</xsl:attribute>
							</xsl:if>
							<xsl:if test="$����/����">
								<xsl:attribute name="����">1</xsl:attribute>
							</xsl:if>
							<xsl:for-each select="$����/����">
								<xsl:element name="����">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="����">
								<xsl:value-of select="����"/>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</����>
			</xsl:for-each>
		</����>
		
	</xsl:template>

	<xsl:template name="�������">
		<xsl:param name="����"/>
		<xsl:param name="�������"/>

		<���� ����="{$����}">
			<xsl:for-each select="$�������/�������/����">
				<���� id="{@id}">
					<xsl:attribute name="����·��">
						<xsl:text>xiangguanrenwu/</xsl:text>
						<xsl:value-of select="@id"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="��">1</xsl:attribute>
					<xsl:for-each select="����">
						<xsl:element name="����">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
				</����>
			</xsl:for-each>
		</����>
		
	</xsl:template>

	<xsl:template name="��ѡ����">
		<xsl:param name="����"/>
		<xsl:param name="��ѡ"/>
		<��ѡ���� ����="{$����}">
			<xsl:for-each select="$��ѡ/���Ҵ�ѡ/���Ҵ�/��/*[self::���� or self::�����汾][@id]">
				<��>
				<xsl:variable name="position1">
					<xsl:number count="��" from="���Ҵ�"/>
				</xsl:variable>
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
					<xsl:attribute name="����"><xsl:value-of select="../����"/></xsl:attribute>
					<xsl:attribute name="����"><xsl:value-of select="../../����"/></xsl:attribute>
					<xsl:attribute name="��������">
						<xsl:call-template name="��ȡ�����׾�">
							<xsl:with-param name="����" select="����"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="·��">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="../../@id"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$position1"/>
						<xsl:text>.html</xsl:text>
						<xsl:if test="../����[2] and ../����[1][@id != current()/@id]">
							<xsl:text>#</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:if>
					</xsl:attribute>
					<xsl:call-template name="��ȡ�����������">
						<xsl:with-param name="����" select="$��ѧ����"/>
					</xsl:call-template>
				</��>
			</xsl:for-each>
		</��ѡ����>
	</xsl:template>

	<xsl:template name="��ȡ�����������">
		<xsl:param name="����"/>
		<xsl:variable name="��ǰ����ID" select="@id"/>
		<xsl:for-each select="$����/�ĵ���/���ϵ���">
			<xsl:variable name="�������" select=".//��������[����/*[not(self::��������)]/descendant::����[@xhref= concat ('$', $��ǰ����ID)]]"/>
			<xsl:if test="$�������">
				<���� id="{@archiveID}">
					<xsl:variable name="���ϵ���ID" select="@archiveID"/>
					<xsl:copy-of select="����" />
					<xsl:for-each select="$�������">
						<����>
							<xsl:attribute name="id">
								<xsl:call-template name="����ID">
									<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
									<xsl:with-param name="��������ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="�����б�"/>
							<xsl:attribute name="·��">
								<xsl:call-template name="����·��">
									<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
									<xsl:with-param name="��������ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:copy-of select="����" />
						</����>
					</xsl:for-each>
				</����>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="����">
		<xsl:param name="����"/>
		<xsl:param name="��ѡ"/>
		<���� ����="{$����}">
			<xsl:for-each select="$��ѡ/���Ҵ�ѡ/���Ҵ�/��">
				<��>
					<xsl:variable name="position1">
						<xsl:number count="��" from="���Ҵ�"/>
					</xsl:variable>
					<xsl:attribute name="����"><xsl:value-of select="����"/></xsl:attribute>
					<xsl:attribute name="����"><xsl:value-of select="../����"/></xsl:attribute>
					<xsl:attribute name="·��">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="../@id"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$position1"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<xsl:for-each select="����">
						<����>
							<xsl:attribute name="text">
								<xsl:call-template name="��ȡ�����׾�">
									<xsl:with-param name="����" select="����"/>
								</xsl:call-template>
							</xsl:attribute>
						</����>
					</xsl:for-each>
				</��>
			</xsl:for-each>
		</����>
	</xsl:template>

	<xsl:template name="����">
		<xsl:param name="����"/>
		<xsl:param name="�ļ�"/>
		<xsl:for-each select="$�ļ�/�ĵ���/���ϵ���">
			<xsl:variable name="���ϵ���ID" select="@archiveID"/>
			<���� ����="{����}" id="{$���ϵ���ID}">
				<xsl:if test="not (@noIndex = 'true')">
					<xsl:attribute name="·��"><xsl:value-of select="$���ϵ���ID"/>/index.html</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="��������">
					<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
				</xsl:apply-templates>
			</����>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="��������">
		<xsl:param name="���ϵ���ID" select="ancestor::���ϵ���/@archiveID"/>
		<����>
			<xsl:attribute name="id">
				<xsl:call-template name="����ID">
					<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
					<xsl:with-param name="��������ID" select="@fileID"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="�����б�"/>
			<xsl:attribute name="·��">
				<xsl:call-template name="����·��">
					<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
					<xsl:with-param name="��������ID" select="@fileID"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:copy-of select="����" />
			<xsl:copy-of select="����/����/�ؼ���" />
			<xsl:apply-templates select="����/��������">
				<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
			</xsl:apply-templates>
		</����>
	</xsl:template>

	<xsl:template name="�����б�">
		<xsl:attribute name="����">
			<xsl:for-each select="����|self::node()[not(����)]/ancestor::���ϵ���/����">
				<xsl:if test="position () != 1">
					<xsl:text>��</xsl:text>
				</xsl:if>
				<xsl:call-template name="formatName">
					<xsl:with-param name="n" select="."/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:attribute>
	</xsl:template>

	<xsl:template name="����·��">
		<xsl:param name="���ϵ���ID"/>
		<xsl:param name="��������ID"/>
		<xsl:value-of select="$���ϵ���ID"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$��������ID"/>
		<xsl:text>.html</xsl:text>
	</xsl:template>

	<xsl:template name="����ID">
		<xsl:param name="���ϵ���ID"/>
		<xsl:param name="��������ID"/>
		<xsl:choose>
			<xsl:when test="$��������ID = 'index'">
				<xsl:value-of select="$���ϵ���ID"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="$��������ID"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$��������ID"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="����">
		<����>
			<xsl:for-each select="$���δʸ���/���δʸ���/���/����">
				<����>
					<xsl:attribute name="·��">
						<xsl:text>cipai/cipai</xsl:text>
						<xsl:value-of select="position()"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<���><xsl:value-of select="../����"/></���>
					<xsl:for-each select="����/����[@���]">
						<���><xsl:value-of select="@���"/></���>
					</xsl:for-each>
					<xsl:for-each select="����/����[@˵�� != 'ע']">
						<���� ˵��="{@˵��}" ����="{string-length(translate(., '&#x0D;&#x0A;�����������������������ۣ� ', ''))}">
							<xsl:attribute name="���">
								<xsl:choose>
									<xsl:when test="@���">
										<xsl:value-of select="@���"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="../../../����"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</����>
					</xsl:for-each>
					<xsl:for-each select="����">
						<xsl:copy>
							<xsl:attribute name="����"><xsl:value-of select="text()"/></xsl:attribute>
							<!-- <xsl:call-template name="��������">
								<xsl:with-param name="��ѡ" select="$�������Ҵ�ѡ"/>
							</xsl:call-template>
							<xsl:call-template name="��������">
								<xsl:with-param name="��ѡ" select="$�����������Ҵ�ѡ"/>
							</xsl:call-template> -->
						</xsl:copy>
					</xsl:for-each>
					<xsl:call-template name="��ȡ�����������">
						<xsl:with-param name="����" select="$��ѧ����"/>
					</xsl:call-template>
				</����>
			</xsl:for-each>
		</����>
	</xsl:template>

	<xsl:template name="��ȡ�����������">
		<xsl:param name="����"/>
		<xsl:variable name="��ǰ��������" select="����"/>
		<xsl:for-each select="$����/�ĵ���/���ϵ���">
			<xsl:variable name="�������" select=".//��������[����/*[not(self::��������)]/descendant::����[(@xhref='?fmt=' and text() = $��ǰ��������) or (@xhref = concat ('?fmt=', $��ǰ��������))]]"/>
			<xsl:if test="$�������">
				<���� id="{@archiveID}">
					<xsl:variable name="���ϵ���ID" select="@archiveID"/>
					<xsl:copy-of select="����" />
					<xsl:for-each select="$�������">
						<����>
							<xsl:attribute name="id">
								<xsl:call-template name="����ID">
									<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
									<xsl:with-param name="��������ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="�����б�"/>
							<xsl:attribute name="·��">
								<xsl:call-template name="����·��">
									<xsl:with-param name="���ϵ���ID" select="$���ϵ���ID"/>
									<xsl:with-param name="��������ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:copy-of select="����" />
						</����>
					</xsl:for-each>
				</����>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- <xsl:template name="��������">
		<xsl:param name="��ѡ"/>
		<xsl:for-each select="$��ѡ/���Ҵ�ѡ/���Ҵ�/��[����=current()]/����">
			<���� ����="{../../����}">
				<xsl:call-template name="��ȡ�����׾�">
					<xsl:with-param name="����" select="����"/>
				</xsl:call-template>
			</����>
		</xsl:for-each>
	</xsl:template> -->

	<xsl:template name="��ȡ�����׾�">
		<xsl:param name="����"/>
		<xsl:variable name="Ԥ��������" select="translate (substring ($����, 1, 48), '������ ���ޡ���&#xD;&#xA;', '����������')"/>
		<xsl:value-of select="substring-before ($Ԥ��������, '��')"/>
	</xsl:template>

	<xsl:template name="siteMap">
		<siteMaps>
			<xsl:for-each select="$��վ��ͼ//siteMap">
				<siteMap id="{@id}" name="{@name}">
					<xsl:attribute name="url">
						<xsl:choose>
							<xsl:when test="@url"><xsl:value-of select="@url"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="parent::siteMap/@url"/></xsl:otherwise>
						</xsl:choose>
						</xsl:attribute>
				</siteMap>
			</xsl:for-each>
		</siteMaps>
	</xsl:template>

	<xsl:template name="�ʻ�">
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$�������Ҵ�ѡ"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$���δʸ���"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$���δʼ�"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$�����������Ҵ�ѡ"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$��������ʼ�"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$�й�����ʷ"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$��ѧʮ��"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$��ѧ����"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$����ר��"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$����"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$�������"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$˵��"/>
		</xsl:call-template>
		<xsl:call-template name="���ע�͹ؼ���">
			<xsl:with-param name="doc" select="$ciNotesXml"/>
		</xsl:call-template>
		<xsl:for-each select="$ciNotesXml/���ϵ���/����/ע��[ע��/����]">
			<xsl:variable name="dummy" select="dic:Update (�ʻ�, '')"/>
		</xsl:for-each>
		<ע��>
			<xsl:for-each select="dic:Dump()/root/item">
				<xsl:sort select="@key" data-type="text" order="ascending" />
				<xsl:variable name="note" select="$ciNotesXml/���ϵ���/����[ע��/�ʻ� = current()/@key]"/>
				<�ʻ� name="{@key}" ·��="note\{$note/@ID}\{string:UnicodeEncode(@key)}.html"/>
			</xsl:for-each>
		</ע��>
	</xsl:template>

	<xsl:template name="���ע�͹ؼ���">
		<xsl:param name="doc"/>
		<xsl:for-each select="$doc//����[@xhref='?' or starts-with(@xhref, '?note=')]">
			<xsl:choose>
				<xsl:when test="@xhref = '?'">
					<xsl:variable name="dummy" select="dic:Update (text(), '')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="dummy" select="dic:Update (substring-after (@xhref, '?note='), '')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
