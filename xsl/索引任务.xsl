<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:context="AppFramework.Xml.XsltExtensions.InternalContextUtility" xmlns:dic="http://longyusheng.org/xslt/extensions/stringdictionary" xmlns:string="http://longyusheng.org/xslt/extensions/string" exclude-result-prefixes="context dic string">
	<xsl:import href="common.xsl" />
	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:param name="indexXml" select="context:ClearDocumentCache ()"/>
	<xsl:param name="ciNotesXml" select="context:GetCachedDocument ('注释.xml')"/>
	<xsl:param name="网站地图" select="context:GetCachedDocument ('SiteMap.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="唐宋词格律" select="context:GetCachedDocument ('唐宋词格律.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="唐宋名家词选" select="context:GetCachedDocument ('唐宋名家词选.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="唐宋词家" select="context:GetCachedDocument ('唐宋词家.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="近三百年名家词选" select="context:GetCachedDocument ('近三百年名家词选.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="近三百年词家" select="context:GetCachedDocument ('近三百年词家.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="中国韵文史" select="context:GetCachedDocument ('中国韵文史.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="词学十讲" select="context:GetCachedDocument ('词学十讲.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="词学论文" select="context:GetCachedDocument ('词学论文.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="纪念专辑" select="context:GetCachedDocument ('纪念专辑.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="新体歌曲" select="context:GetCachedDocument ('新体歌曲.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="封面" select="context:GetCachedDocument ('封面.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="其他" select="context:GetCachedDocument ('其他.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="相关人物" select="context:GetCachedDocument ('人物介绍.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>
	<xsl:param name="说明" select="context:GetCachedDocument ('说明.xml', '/', 'AppFramework.Utilities.XsltExecutor.XmlnsFilteredReader')"/>

	<xsl:variable name="词学著作" select="$词学十讲|$中国韵文史"/>

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
		<索引 date="{concat($year,'年',$month,'月',$date,'日')}">
			<xsl:call-template name="词人">
				<xsl:with-param name="名称" select="'唐宋名家词选'"/>
				<xsl:with-param name="词选" select="$唐宋名家词选"/>
				<xsl:with-param name="词家介绍" select="$唐宋词家"/>
			</xsl:call-template>
			<xsl:call-template name="词人">
				<xsl:with-param name="名称" select="'近三百年名家词选'"/>
				<xsl:with-param name="词选" select="$近三百年名家词选"/>
				<xsl:with-param name="词家介绍" select="$近三百年词家"/>
			</xsl:call-template>
			<xsl:call-template name="人物介绍">
				<xsl:with-param name="名称" select="'人物介绍'"/>
				<xsl:with-param name="人物介绍" select="$相关人物"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$中国韵文史"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$词学十讲"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$纪念专辑"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$词学论文"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$新体歌曲"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$说明"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$封面"/>
			</xsl:call-template>
			<xsl:call-template name="文章">
				<xsl:with-param name="文件" select="$其他"/>
			</xsl:call-template>
			<xsl:call-template name="特选词作">
				<xsl:with-param name="名称" select="'唐宋名家词选'"/>
				<xsl:with-param name="词选" select="$唐宋名家词选"/>
			</xsl:call-template>
			<xsl:call-template name="特选词作">
				<xsl:with-param name="名称" select="'近三百年名家词选'"/>
				<xsl:with-param name="词选" select="$近三百年名家词选"/>
			</xsl:call-template>
			<xsl:call-template name="词作">
				<xsl:with-param name="名称" select="'唐宋名家词选'"/>
				<xsl:with-param name="词选" select="$唐宋名家词选"/>
			</xsl:call-template>
			<xsl:call-template name="词作">
				<xsl:with-param name="名称" select="'近三百年名家词选'"/>
				<xsl:with-param name="词选" select="$近三百年名家词选"/>
			</xsl:call-template>
			<xsl:call-template name="格律"/>
			<xsl:call-template name="siteMap"/>
			<xsl:call-template name="词汇"/>
		</索引>
	</xsl:template>

	<xsl:template name="词人">
		<xsl:param name="名称"/>
		<xsl:param name="词选"/>
		<xsl:param name="词家介绍"/>

		<词人 名称="{$名称}">
			<xsl:for-each select="$词选/名家词选/名家词">
				<作家 id="{@id}">
					<xsl:variable name="介绍" select="$词家介绍/人物介绍/作家[姓名 = current()/作家]"/>
					<xsl:attribute name="词集路径">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="@id"/>
						<xsl:text>/index.html</xsl:text>
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$介绍">
							<xsl:attribute name="传记路径">
								<xsl:text>ciren/</xsl:text>
								<xsl:value-of select="@id"/>
								<xsl:text>.html</xsl:text>
							</xsl:attribute>
							<xsl:if test="$介绍/介绍">
								<xsl:attribute name="简传">1</xsl:attribute>
							</xsl:if>
							<xsl:if test="$介绍/集评">
								<xsl:attribute name="集评">1</xsl:attribute>
							</xsl:if>
							<xsl:for-each select="$介绍/姓名">
								<xsl:element name="姓名">
									<xsl:value-of select="."/>
								</xsl:element>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="姓名">
								<xsl:value-of select="作家"/>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</作家>
			</xsl:for-each>
		</词人>
		
	</xsl:template>

	<xsl:template name="人物介绍">
		<xsl:param name="名称"/>
		<xsl:param name="人物介绍"/>

		<词人 名称="{$名称}">
			<xsl:for-each select="$人物介绍/人物介绍/作家">
				<作家 id="{@id}">
					<xsl:attribute name="传记路径">
						<xsl:text>xiangguanrenwu/</xsl:text>
						<xsl:value-of select="@id"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="简传">1</xsl:attribute>
					<xsl:for-each select="姓名">
						<xsl:element name="姓名">
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
				</作家>
			</xsl:for-each>
		</词人>
		
	</xsl:template>

	<xsl:template name="特选词作">
		<xsl:param name="名称"/>
		<xsl:param name="词选"/>
		<特选词作 名称="{$名称}">
			<xsl:for-each select="$词选/名家词选/名家词/词/*[self::正文 or self::别作版本][@id]">
				<词>
				<xsl:variable name="position1">
					<xsl:number count="词" from="名家词"/>
				</xsl:variable>
				<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
					<xsl:attribute name="词牌"><xsl:value-of select="../词牌"/></xsl:attribute>
					<xsl:attribute name="作家"><xsl:value-of select="../../作家"/></xsl:attribute>
					<xsl:attribute name="首行内容">
						<xsl:call-template name="提取段落首句">
							<xsl:with-param name="段落" select="段落"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="路径">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="../../@id"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$position1"/>
						<xsl:text>.html</xsl:text>
						<xsl:if test="../正文[2] and ../正文[1][@id != current()/@id]">
							<xsl:text>#</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:if>
					</xsl:attribute>
					<xsl:call-template name="获取词作相关文章">
						<xsl:with-param name="档案" select="$词学著作"/>
					</xsl:call-template>
				</词>
			</xsl:for-each>
		</特选词作>
	</xsl:template>

	<xsl:template name="获取词作相关文章">
		<xsl:param name="档案"/>
		<xsl:variable name="当前词作ID" select="@id"/>
		<xsl:for-each select="$档案/文档集/资料档案">
			<xsl:variable name="相关文章" select=".//档案文章[正文/*[not(self::档案文章)]/descendant::链接[@xhref= concat ('$', $当前词作ID)]]"/>
			<xsl:if test="$相关文章">
				<档案 id="{@archiveID}">
					<xsl:variable name="资料档案ID" select="@archiveID"/>
					<xsl:copy-of select="标题" />
					<xsl:for-each select="$相关文章">
						<文章>
							<xsl:attribute name="id">
								<xsl:call-template name="文章ID">
									<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
									<xsl:with-param name="档案文章ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="作者列表"/>
							<xsl:attribute name="路径">
								<xsl:call-template name="文章路径">
									<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
									<xsl:with-param name="档案文章ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:copy-of select="标题" />
						</文章>
					</xsl:for-each>
				</档案>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="词作">
		<xsl:param name="名称"/>
		<xsl:param name="词选"/>
		<词作 名称="{$名称}">
			<xsl:for-each select="$词选/名家词选/名家词/词">
				<词>
					<xsl:variable name="position1">
						<xsl:number count="词" from="名家词"/>
					</xsl:variable>
					<xsl:attribute name="词牌"><xsl:value-of select="词牌"/></xsl:attribute>
					<xsl:attribute name="作家"><xsl:value-of select="../作家"/></xsl:attribute>
					<xsl:attribute name="路径">
						<xsl:text>ci/</xsl:text>
						<xsl:value-of select="../@id"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$position1"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<xsl:for-each select="正文">
						<内容>
							<xsl:attribute name="text">
								<xsl:call-template name="提取段落首句">
									<xsl:with-param name="段落" select="段落"/>
								</xsl:call-template>
							</xsl:attribute>
						</内容>
					</xsl:for-each>
				</词>
			</xsl:for-each>
		</词作>
	</xsl:template>

	<xsl:template name="文章">
		<xsl:param name="名称"/>
		<xsl:param name="文件"/>
		<xsl:for-each select="$文件/文档集/资料档案">
			<xsl:variable name="资料档案ID" select="@archiveID"/>
			<档案 名称="{标题}" id="{$资料档案ID}">
				<xsl:if test="not (@noIndex = 'true')">
					<xsl:attribute name="路径"><xsl:value-of select="$资料档案ID"/>/index.html</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="档案文章">
					<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
				</xsl:apply-templates>
			</档案>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="档案文章">
		<xsl:param name="资料档案ID" select="ancestor::资料档案/@archiveID"/>
		<文章>
			<xsl:attribute name="id">
				<xsl:call-template name="文章ID">
					<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
					<xsl:with-param name="档案文章ID" select="@fileID"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="作者列表"/>
			<xsl:attribute name="路径">
				<xsl:call-template name="文章路径">
					<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
					<xsl:with-param name="档案文章ID" select="@fileID"/>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:copy-of select="标题" />
			<xsl:copy-of select="正文/段落/关键字" />
			<xsl:apply-templates select="正文/档案文章">
				<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
			</xsl:apply-templates>
		</文章>
	</xsl:template>

	<xsl:template name="作者列表">
		<xsl:attribute name="作者">
			<xsl:for-each select="作者|self::node()[not(作者)]/ancestor::资料档案/作者">
				<xsl:if test="position () != 1">
					<xsl:text>、</xsl:text>
				</xsl:if>
				<xsl:call-template name="formatName">
					<xsl:with-param name="n" select="."/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:attribute>
	</xsl:template>

	<xsl:template name="文章路径">
		<xsl:param name="资料档案ID"/>
		<xsl:param name="档案文章ID"/>
		<xsl:value-of select="$资料档案ID"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$档案文章ID"/>
		<xsl:text>.html</xsl:text>
	</xsl:template>

	<xsl:template name="文章ID">
		<xsl:param name="资料档案ID"/>
		<xsl:param name="档案文章ID"/>
		<xsl:choose>
			<xsl:when test="$档案文章ID = 'index'">
				<xsl:value-of select="$资料档案ID"/>
				<xsl:text>-</xsl:text>
				<xsl:value-of select="$档案文章ID"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$档案文章ID"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="格律">
		<格律>
			<xsl:for-each select="$唐宋词格律/唐宋词格律/类别/词牌">
				<词牌>
					<xsl:attribute name="路径">
						<xsl:text>cipai/cipai</xsl:text>
						<xsl:value-of select="position()"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<类别><xsl:value-of select="../名称"/></类别>
					<xsl:for-each select="正文/格律[@类别]">
						<类别><xsl:value-of select="@类别"/></类别>
					</xsl:for-each>
					<xsl:for-each select="正文/格律[@说明 != '注']">
						<格律 说明="{@说明}" 字数="{string-length(translate(., '&#x0D;&#x0A;，。＊％＃（）、ˇ｛｝［］ ', ''))}">
							<xsl:attribute name="类别">
								<xsl:choose>
									<xsl:when test="@类别">
										<xsl:value-of select="@类别"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="../../../名称"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
						</格律>
					</xsl:for-each>
					<xsl:for-each select="名称">
						<xsl:copy>
							<xsl:attribute name="名称"><xsl:value-of select="text()"/></xsl:attribute>
							<!-- <xsl:call-template name="格律例词">
								<xsl:with-param name="词选" select="$唐宋名家词选"/>
							</xsl:call-template>
							<xsl:call-template name="格律例词">
								<xsl:with-param name="词选" select="$近三百年名家词选"/>
							</xsl:call-template> -->
						</xsl:copy>
					</xsl:for-each>
					<xsl:call-template name="获取格律相关文章">
						<xsl:with-param name="档案" select="$词学著作"/>
					</xsl:call-template>
				</词牌>
			</xsl:for-each>
		</格律>
	</xsl:template>

	<xsl:template name="获取格律相关文章">
		<xsl:param name="档案"/>
		<xsl:variable name="当前词牌名称" select="名称"/>
		<xsl:for-each select="$档案/文档集/资料档案">
			<xsl:variable name="相关文章" select=".//档案文章[正文/*[not(self::档案文章)]/descendant::链接[(@xhref='?fmt=' and text() = $当前词牌名称) or (@xhref = concat ('?fmt=', $当前词牌名称))]]"/>
			<xsl:if test="$相关文章">
				<档案 id="{@archiveID}">
					<xsl:variable name="资料档案ID" select="@archiveID"/>
					<xsl:copy-of select="标题" />
					<xsl:for-each select="$相关文章">
						<文章>
							<xsl:attribute name="id">
								<xsl:call-template name="文章ID">
									<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
									<xsl:with-param name="档案文章ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="作者列表"/>
							<xsl:attribute name="路径">
								<xsl:call-template name="文章路径">
									<xsl:with-param name="资料档案ID" select="$资料档案ID"/>
									<xsl:with-param name="档案文章ID" select="@fileID"/>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:copy-of select="标题" />
						</文章>
					</xsl:for-each>
				</档案>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- <xsl:template name="格律例词">
		<xsl:param name="词选"/>
		<xsl:for-each select="$词选/名家词选/名家词/词[词牌=current()]/正文">
			<例词 作者="{../../作家}">
				<xsl:call-template name="提取段落首句">
					<xsl:with-param name="段落" select="段落"/>
				</xsl:call-template>
			</例词>
		</xsl:for-each>
	</xsl:template> -->

	<xsl:template name="提取段落首句">
		<xsl:param name="段落"/>
		<xsl:variable name="预处理文字" select="translate (substring ($段落, 1, 48), '，！？ －＾【】&#xD;&#xA;', '。。。。。')"/>
		<xsl:value-of select="substring-before ($预处理文字, '。')"/>
	</xsl:template>

	<xsl:template name="siteMap">
		<siteMaps>
			<xsl:for-each select="$网站地图//siteMap">
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

	<xsl:template name="词汇">
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$唐宋名家词选"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$唐宋词格律"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$唐宋词家"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$近三百年名家词选"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$近三百年词家"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$中国韵文史"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$词学十讲"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$词学论文"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$纪念专辑"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$封面"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$相关人物"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$说明"/>
		</xsl:call-template>
		<xsl:call-template name="添加注释关键字">
			<xsl:with-param name="doc" select="$ciNotesXml"/>
		</xsl:call-template>
		<xsl:for-each select="$ciNotesXml/资料档案/索引/注释[注解/概述]">
			<xsl:variable name="dummy" select="dic:Update (词汇, '')"/>
		</xsl:for-each>
		<注释>
			<xsl:for-each select="dic:Dump()/root/item">
				<xsl:sort select="@key" data-type="text" order="ascending" />
				<xsl:variable name="note" select="$ciNotesXml/资料档案/索引[注释/词汇 = current()/@key]"/>
				<词汇 name="{@key}" 路径="note\{$note/@ID}\{string:UnicodeEncode(@key)}.html"/>
			</xsl:for-each>
		</注释>
	</xsl:template>

	<xsl:template name="添加注释关键字">
		<xsl:param name="doc"/>
		<xsl:for-each select="$doc//链接[@xhref='?' or starts-with(@xhref, '?note=')]">
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
