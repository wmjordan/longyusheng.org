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
		$("#PageInnerFrame").prepend('<div class="jd_bar" id="MainMenu"><ul class="jd_menu"><li><span>����Ŀ¼</span><ul><li><a href="~/index.html">��ҳ</a></li><li><a href="~/jinian/index.html">����ר��</a></li><li>�������Ҵ�ѡ��������<ul><li><b><a href="~/tangsongci/index.html">�������Ҵ�ѡ</a></b></li><li><hr></li><li><a href="~/tangsongci/mulu.html">ԭ��Ŀ¼</a></li><li><a href="~/tangsongci/pinyin.html">�������϶�������Ŀ¼</a></li><li><a href="~/tangsongci/tongji.html">������Ŀ����Ŀ¼</a></li><li><hr></li><li><a href="~/tangsongci/ciren.html">���˴����뼯��</a></li></ul></li><li>�����������Ҵ�ѡ����<ul><li><b><a href="~/jindaici/index.html">�����������Ҵ�ѡ</a></b></li><li><hr></li><li><a href="~/jindaici/mulu.html">ԭ��Ŀ¼</a></li><li><a href="~/jindaici/pinyin.html">�������϶�������Ŀ¼</a></li><li><a href="~/jindaici/tongji.html">������Ŀ����Ŀ¼</a></li><li><hr></li><li><a href="~/jindaici/ciren.html">���˴����뼯��</a></li></ul></li><li><a href="~/cixueshijiang/index.html">��ѧʮ��</a></li><li><a href="~/zhongguoyunwenshi/index.html">�й�����ʷ</a></li><li>���δʸ��ɡ���������<ul><li><b><a href="~/cipai/index.html">���δʸ���</a></b></li><li><hr></li><li><a href="~/cipai/mulu.html">�Ͻŷ���Ŀ¼</a></li><li><a href="~/cipai/pinyin.html">������������Ŀ¼</a></li><li><a href="~/cipai/zishu.html">������������Ŀ¼</a></li></ul></li><li><hr></li><li><a href="~/about/gy-xiazai.html">���ص�����</a></li></ul></li><li><span>ʹ��˵��</span><ul><li><a href="~/about/gy-shiyongshuoming.html">ʹ��˵��</a></li><li><a href="~/about/shuoming-tili.html">���Ӱ�����˵��</a></li><li><a href="~/about/shuoming-biaozhi.html">���ɱ�ʶ˵��</a></li><li><a href="~/about/shuoming-dianzishu.html">������ʹ�÷���</a></li><li><a href="~/about/shuoming-ziti.html">��������</a></li><li><a href="~/about/shuoming-jianpan.html" title="ʹ�ü����Ķ�������ķ���">���̵�����ݼ�</a></li></ul></li><li><span>��������</span><ul style="width: 200px"><li><a href="javascript:window.print();">��ӡ��ҳ (Ctrl+P)</a></li><li><a href="javascript:$.myPage.zoomIn();">�Ŵ�ҳ������ (����+)</a></li><li><a href="javascript:$.myPage.zoomOut();">��Сҳ������ (����-)</a></li><li id="rel"><a href="javascript:$.myPage.nextPage();">��һƪ (�����Ҽ�ͷ��)</a></li><li id="rev"><a href="javascript:$.myPage.prevPage();">��һƪ (�������ͷ��)</a></li><li id="ftSearchLink"><a href="~/help/search.html">ȫ�ļ���</a></li></ul></li><li><span>��������</span><ul style="width: 200px"><li><div><img src="~/images/qrcode.png" alt="���ںŶ�ά��"/></div><div>��������ѧ���ں�</div></li><li><a href="https://gitee.com/wmjordan/longyusheng" target="_blank">��վ����Դ������Ŀ</a></li></ul></li></ul></div>'.replace (/~\//g, depth));
		if (window.location.href.indexOf ("://longyusheng.org/") == -1) {
			$("#ftSearchLink").remove();
		}
        if (!$.support.boxModel) {
            $("#MainMenu").css("position", "absolute");
        }
		if ($("#anc_next").get(0)) {
			$("#rel").get(0).title = "ת�� " + $("#anc_next").text();
		}
		else {
			$("#rel").remove();
		}
		if ($("#anc_prev").get(0)) {
			$("#rev").get(0).title = "ת�� " + $("#anc_prev").text();
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
	$(".cr:first").prepend($('<div><img src="~/images/qrcode-2.png" id="qrcode" style="max-width:100%" alt="��������ѧ���ں�" /></div>'.replace(/~\//g, depth))[0]);
}
);

