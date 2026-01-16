<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:string="http://longyusheng.org/xslt/extensions/string" exclude-result-prefixes="msxsl string">
	<xsl:import href="common.xsl"/>
	<xsl:import href="pageframe.xsl"/>
	<xsl:param name="html"/>
	<xsl:param name="fID"/>
	<xsl:param name="sort"/>
	<xsl:param name="ciFormatsXml"/>
	<xsl:param name="ciXml"/>

	<xsl:template name="PageTitle">
		<xsl:value-of select="/名家词选/标题"/>
		<xsl:text>(龙榆生)</xsl:text>
	</xsl:template>

	<xsl:template name="PageKeywordsMetaTag">
		<meta name="keywords" content="{名家词选/标题}, 龙榆生" />
	</xsl:template>

	<xsl:template name="NavigationPart">
		<div class="NaviPart Breadcrumb">当前位置：<xsl:call-template name="ListAncestorsInSiteMap"/></div>
		<ul class="NaviPart"><xsl:call-template name="ListSiblingsInSiteMap"/></ul>
	</xsl:template>

	<xsl:template name="TitlePart">
		<h1 class="PageTitle">
			<xsl:choose>
				<xsl:when test="$sort='minguo'">
					<xsl:text>初版目次</xsl:text>
				</xsl:when>
				<xsl:when test="$sort='jianguo'">
					<xsl:text>修订版目次</xsl:text>
				</xsl:when>
				<xsl:when test="$sort='edits'">
					<xsl:text>收词一览</xsl:text>
				</xsl:when>
				<xsl:otherwise>目录</xsl:otherwise>
			</xsl:choose>
		</h1>
	</xsl:template>

	<xsl:template name="BodyPart">
		<div class="Page" style="text-justify: auto;">
			<xsl:apply-templates select="/名家词选"/>
		</div>
	</xsl:template>
	<xsl:template match="名家词选">
		<xsl:choose>
			<xsl:when test="$sort = 'edits'">
				<xsl:call-template name="edits"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="id">ciList</xsl:attribute>
				<xsl:call-template name="contents"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="edits">
		<xsl:variable name="data">
			<xsl:for-each select="名家词[选本 != '']">
				<xsl:element name="writer">
					<xsl:attribute name="name"><xsl:value-of select="作家"/></xsl:attribute>
					<xsl:attribute name="add">
						<xsl:choose>
							<xsl:when test="@edit = '增'">
								<xsl:value-of select="count(词/正文[not(@edit)])"/>
							</xsl:when>
							<xsl:when test="not(@edit)">
								<xsl:value-of select="count(词/正文[@edit = '增'])"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="del">
						<xsl:choose>
							<xsl:when test="@edit = '删'">
								<xsl:value-of select="count(词/正文[not(@edit)])"/>
							</xsl:when>
							<xsl:when test="not(@edit)">
								<xsl:value-of select="count(词/正文[@edit = '删'])"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="share">
						<xsl:choose>
							<xsl:when test="not(@edit)">
								<xsl:value-of select="count(词/正文[not(@edit)])"/>
							</xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</xsl:element>
			</xsl:for-each>
			<writer name="李重元" add="0" del="1" share="0"/>
		</xsl:variable>
		<xsl:variable name="writers" select="msxsl:node-set($data)/writer"/>
		<table class="Data">
			<colgroup>
				<col class="head"/>
				<col class="sum"/>
				<col/>
				<col/>
				<col/>
				<col class="sum"/>
				<col class="sum"/>
			</colgroup>
			<thead>
				<tr>
					<th>作者</th>
					<th>初版</th>
					<th>删弃</th>
					<th>同收</th>
					<th>增收</th>
					<th>修订版</th>
					<th>小计</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="$writers">
					<xsl:variable name="writer" select="@name"/>
					<tr>
						<td>
							<a>
								<xsl:attribute name="href">
									<xsl:call-template name="mappath">
										<xsl:with-param name="type">coll</xsl:with-param>
										<xsl:with-param name="ref" select="$writer"/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="formatName">
									<xsl:with-param name="n" select="$writer"/>
								</xsl:call-template>
							</a>
							<xsl:choose>
								<xsl:when test="$writer = '冯延己' or $writer = '欧阳修'">
									<sup><a href="#fn1" name="qfn1" class="Ref">[1]</a></sup>
								</xsl:when>
								<xsl:when test="$writer = '范仲淹' or $writer = '李重元'">
									<sup><a href="#fn2" name="qfn2" class="Ref">[2]</a></sup>
								</xsl:when>
							</xsl:choose>
						</td>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@del+@share"/>
						</xsl:call-template>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@del"/>
						</xsl:call-template>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@share"/>
						</xsl:call-template>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@add"/>
						</xsl:call-template>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@add+@share"/>
						</xsl:call-template>
						<xsl:call-template name="num">
							<xsl:with-param name="value" select="@add+@del+@share"/>
						</xsl:call-template>
					</tr>
				</xsl:for-each>
			</tbody>
			<tfoot>
				<tr>
					<td>合计</td>
					<td class="num"><xsl:value-of select="sum($writers/@del)+sum($writers/@share)"/></td>
					<td class="num"><xsl:value-of select="sum($writers/@del)"/></td>
					<td class="num"><xsl:value-of select="sum($writers/@share)"/></td>
					<td class="num"><xsl:value-of select="sum($writers/@add)"/></td>
					<td class="num"><xsl:value-of select="sum($writers/@add)+sum($writers/@share)"/></td>
					<td class="num"><xsl:value-of select="sum($writers/@add)+sum($writers/@del)+sum($writers/@share)"/></td>
				</tr>
			</tfoot>
		</table>
		<div class="Appendix">
			<div class="edit">注</div>
			<div class="AppendixContent"><sup><a name="fn1" href="#qfn1" class="Ref">[1]</a></sup>初版三首《蝶恋花》（《鹊踏枝》）入欧阳修作，修订版入冯延己作，故初版欧阳修收 9 首，冯延己收 12 首。</div>
			<div class="AppendixContent"><sup><a name="fn2" href="#qfn2" class="Ref">[2]</a></sup>初版范仲淹词收 4 首，其中《忆王孙·秋思》一首实李重元《忆王孙·秋词》。</div>
		</div>
	</xsl:template>
	<xsl:template name="num">
		<xsl:param name="value"/>
		<td class="num">
			<xsl:choose>
				<xsl:when test="$value != '0'">
					<xsl:value-of select="$value"/>
				</xsl:when>
			</xsl:choose>
		</td>
	</xsl:template>
	<xsl:template name="contents">
		<xsl:variable name="writers">
			<xsl:choose>
				<xsl:when test="$sort = 'count'">
					<xsl:for-each select="名家词[选本 != '']/作家">
						<xsl:sort select="count(../词/正文)" data-type="number" order="descending" />
						<xsl:element name="作家">
							<xsl:attribute name="count"><xsl:value-of select="count(../词/正文)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$sort = 'minguo'">
					<xsl:variable name="list" select="string:SplitToDocument(string:Replace('温庭筠|皇甫松|韦庄|薛昭蕴|牛峤|毛文锡|牛希济|欧阳炯|顾夐|孙光宪|鹿虔扆|李珣|李煜|冯延己|张泌|潘阆|晏殊|范仲淹|张先|欧阳修|柳永|苏轼|晏几道|秦观|晁补之|贺铸|周邦彦|李清照|张元干|叶梦得|张孝祥|辛弃疾|陆游|姜夔|史达祖|刘克庄|吴文英|刘辰翁|王沂孙|张炎|周密|元好问','|','&#x0D;&#x0A;'))"/>
					<xsl:variable name="current" select="current()"/>
					<xsl:for-each select="$list/root/line">
						<xsl:variable name="writer" select="$current/名家词[选本 != ''][not(@edit) or @edit='删'][作家/text()=current()]"/>
						<xsl:element name="作家">
							<xsl:attribute name="count"><xsl:value-of select="count($writer/词/正文[not(@edit) or @edit='删'])"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$sort = 'jianguo'">
					<xsl:for-each select="名家词[选本 != ''][not(@edit) or @edit='增']/作家">
						<xsl:element name="作家">
							<xsl:attribute name="count"><xsl:value-of select="count(../词/正文[not(@edit) or @edit='增'])"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="$sort != ''">
					<xsl:for-each select="名家词[选本 != '']/作家">
						<xsl:sort select="text()" data-type="text" order="ascending" />
						<xsl:element name="作家">
							<xsl:attribute name="count"><xsl:value-of select="count(../词/正文)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="名家词[选本 != '']/作家">
						<xsl:element name="作家">
							<xsl:attribute name="count"><xsl:value-of select="count(../词/正文)"/></xsl:attribute>
							<xsl:value-of select="current()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="msxsl:node-set($writers)/作家">
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
					<span class="note">　<xsl:value-of select="@count"/>首</span>
				</xsl:if>
			</span>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="copyrightText">
		<div>
			<xsl:choose>
				<xsl:when test="/名家词选/标题 = '近三百年名家词选'">《近三百年名家词选》：<u>上海古籍出版社</u>一九五六年版。</xsl:when>
				<xsl:when test="/名家词选/标题 = '唐宋名家词选'">《唐宋名家词选》：<u>开明书店</u>一九三八年版，<u>上海古籍出版社</u>一九八零年版。</xsl:when>
			</xsl:choose>
		</div>
	</xsl:template>
</xsl:stylesheet>
