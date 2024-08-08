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
		$("#PageInnerFrame").prepend($menu$.replace (/~\//g, depth));
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

