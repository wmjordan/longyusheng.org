jQuery.myPage = {
	/*float*/ zoom: 1,
	zoomIn : function  () {
		$.myPage.zoom += 0.1;
		document.body.style.zoom = $.myPage.zoom;
	},
	zoomOut : function () {
		if ($.myPage.zoom > 0.5) {
			$.myPage.zoom -= 0.1;
			document.body.style.zoom = $.myPage.zoom;
		}
	},
	nextPage: function () {
		if ($("#anc_next").get(0)) {
			window.location.href = $("#anc_next").get(0).href;
		}
	},
	prevPage: function () {
		if ($("#anc_prev").get(0)) {
			window.location.href = $("#anc_prev").get(0).href;
		}
	}
};

$(function () {
	if (window.location.href.indexOf ("cover.html") == -1) {
		$("#PageInnerFrame").prepend('<div class="jd_bar" id="MainMenu"><ul class="jd_menu"><li><span>导览目录</span><ul><li><a href="~/index.html">首页</a></li><li><a href="~/jinian/index.html">纪念专辑</a></li><li>唐宋名家词选　　　→<ul><li><b><a href="~/tangsongci/index.html">唐宋名家词选</a></b></li><li><hr></li><li><a href="~/tangsongci/mulu.html">原书目录</a></li><li><a href="~/tangsongci/pinyin.html">词人姓氏读音排序目录</a></li><li><a href="~/tangsongci/tongji.html">词作数目排序目录</a></li><li><hr></li><li><a href="~/tangsongci/ciren.html">词人传记与集评</a></li></ul></li><li>近三百年名家词选　→<ul><li><b><a href="~/jindaici/index.html">近三百年名家词选</a></b></li><li><hr></li><li><a href="~/jindaici/mulu.html">原书目录</a></li><li><a href="~/jindaici/pinyin.html">词人姓氏读音排序目录</a></li><li><a href="~/jindaici/tongji.html">词作数目排序目录</a></li><li><hr></li><li><a href="~/jindaici/ciren.html">词人传记与集评</a></li></ul></li><li><a href="~/cixueshijiang/index.html">词学十讲</a></li><li><a href="~/zhongguoyunwenshi/index.html">中国韵文史</a></li><li>唐宋词格律　　　　→<ul><li><b><a href="~/cipai/index.html">唐宋词格律</a></b></li><li><hr></li><li><a href="~/cipai/mulu.html">韵脚分类目录</a></li><li><a href="~/cipai/pinyin.html">词牌名称排序目录</a></li><li><a href="~/cipai/zishu.html">词牌字数排序目录</a></li></ul></li><li><hr></li><li><a href="~/about/gy-xiazai.html">下载电子书</a></li></ul></li><li><span>使用说明</span><ul><li><a href="~/about/gy-shiyongshuoming.html">使用说明</a></li><li><a href="~/about/shuoming-tili.html">电子版体例说明</a></li><li><a href="~/about/shuoming-biaozhi.html">格律标识说明</a></li><li><a href="~/about/shuoming-dianzishu.html">电子书使用方法</a></li><li><a href="~/about/shuoming-ziti.html">汉字字体</a></li><li><a href="~/about/shuoming-jianpan.html" title="使用键盘阅读电子书的方法">键盘导航快捷键</a></li></ul></li><li><span>辅助功能</span><ul style="width: 200px"><li><a href="javascript:window.print();">打印本页 (Ctrl+P)</a></li><li><a href="javascript:$.myPage.zoomIn();">放大页面字体 (键盘+)</a></li><li><a href="javascript:$.myPage.zoomOut();">缩小页面字体 (键盘-)</a></li><li id="rel"><a href="javascript:$.myPage.nextPage();">下一篇 (键盘右箭头→)</a></li><li id="rev"><a href="javascript:$.myPage.prevPage();">上一篇 (键盘左箭头←)</a></li><li id="ftSearchLink"><a href="~/help/search.html">全文检索</a></li></ul></li><li><span>网上内容</span><ul style="width: 200px"><li><div><img src="~/images/qrcode.png" alt="公众号二维码"/></div><div>龙榆生词学公众号</div></li><li><a href="https://gitee.com/wmjordan/longyusheng" target="_blank">网站开放源代码项目</a></li></ul></li></ul></div>'.replace (/~\//g, depth));
		if (window.location.href.indexOf ("://longyusheng.org/") == -1) {
			$("#ftSearchLink").remove();
		}
        if (!$.support.boxModel) {
            $("#MainMenu").css("position", "absolute");
        }
		if ($("#anc_next").get(0)) {
			$("#rel").get(0).title = "转到 " + $("#anc_next").text();
		}
		else {
			$("#rel").remove();
		}
		if ($("#anc_prev").get(0)) {
			$("#rev").get(0).title = "转到 " + $("#anc_prev").text();
		}
		else {
			$("#rev").remove();
		}
		//$("#fbLink").get(0).href += "?from=" + window.location.href.replace (/http:\/\/longyusheng\.org\//gi, '');
		$('ul.jd_menu').jdMenu();
	}
	$(document).bind('keydown', {combi:'+',disableInInput:true}, $.myPage.zoomIn);
	$(document).bind('keydown', {combi:'-',disableInInput:true}, $.myPage.zoomOut);
	$(document).bind('keydown', {combi:'equal',disableInInput:true}, $.myPage.zoomIn);
	$(document).bind('keydown', {combi:'minus',disableInInput:true}, $.myPage.zoomOut);
	$(document).bind('keydown', {combi:'right',disableInInput:true}, $.myPage.nextPage);
	$(document).bind('keydown', {combi:'2',disableInInput:true}, $.myPage.nextPage);
	$(document).bind('keydown', {combi:'left',disableInInput:true}, $.myPage.prevPage);
	$(document).bind('keydown', {combi:'1',disableInInput:true}, $.myPage.prevPage);
	$(".cr:first").prepend($('<div><img src="~/images/qrcode-2.png" id="qrcode" style="max-width:100%" alt="龙榆生词学公众号" /></div>'.replace(/~\//g, depth))[0]);
}
);

