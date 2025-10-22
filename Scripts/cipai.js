function showExample () {
	var e = $(this).parents("div.ci").find("blockquote div.ceHolder"); // 放置示例的div集合
	var s = $(this).children("option:selected");
	$(this).nextAll("a[id^='cenext']").get(0).style.visibility = (s.next().length > 0 ? "visible" : "hidden");
	$(this).nextAll("a[id^='ceprev']").get(0).style.visibility = (s.prev().length > 0 ? "visible" : "hidden");
	if (s.length == 0) {
		$(this).parents("div.ci").find("div.ciExample").hide();
		return ;
	}
	if ($(this).get(0).options.length == 1) {
		$(this).nextAll(":not([id^='note'])").remove();
	}
	var ex = ces[s.get(0).value];
	if (ex == null) {
		for (var i=0; i<e.length; i++) {
			e.eq(i).text (e.eq(i).text().replace(/[^，。]/g, "□"));
		}
		return ;
	}
	$(this).nextAll("span[id^='note']").text(ex.n);
	var junk = $("#cejunk").html (ex.t);
	junk.find("span[class='note']").remove();
	junk.find("span[class='ze'], span[class='ping']").after("★");
	junk.find("span[class='shiyun']").after("☆");
	var ceLink = $(this).parents("div.ci").find("div.ciExample a[id^='celink']");
	ceLink.get(0).href = ex.h;
	ceLink.text(s.text().replace(/[0-9]+:/g, ""));
	var ext = $("#cejunk").text().replace(/[“”]/g,"").replace (/★(.)/g, "$1★");
	var extp = ext.split(/[★☆]/g);
	var ei;
	var pi = 0;
	for (var i=0; i<e.length; i++) {
		var ei = e.eq(i);
		ei.text (extp.slice(pi,(pi+=ei.attr("pattern").split(/\|/g).length)).join(""));
	}
	return false;
}

function initExample (index, n){
	var junk = $("#cejunk").html (n.t);
	junk.find("span[class='note']").remove();
	junk.find("span[class='ze'], span[class='ping']").after("★");
	junk.find("span[class='shiyun']").after("☆");
	junk.find("br").after("%☆");
	var ss = junk.text().replace(/[“”]/g,"").split(/★[，、。：；！？]|☆/g);
	var s = new Array();
	var si;
	for (var i=0; i<ss.length; i++) {
		si = ss[i];
		if (si.length == 0)
			continue;
		else if (si == "%") {
			s.push("%");
			continue;
		}
		s.push (si.replace(/（[^）]+）|[《》“”，、。：；！？]/g,"").length.toString());
	}
	n.p = s.join("|");
};

function changeExample () {
	var list = $(this).parent().find("select")[0];
	list.selectedIndex += (this.id.indexOf("ceprev")!=-1 ? -1 : 1);
	$(list).trigger("change");
}

function initCipai (n) {
	var lines = $(this).children();
	var s = new Array();
	for (var i=0; i<lines.length; i++) {
		var l = lines[i];
		if (l.tagName == "BR")
			s.push("%");
		else {
			var ss = $(l).text().replace(/[〖〗『』]/g,"").split(/（韵）[，。]/g);
			var p = new Array();
			var pl;
			for (var j=0; j<ss.length; j++) {
				if (ss[j].length == 0)
					continue;
				pl = ss[j].replace(/[^中平仄去入]/g,"").length;
				p.push(pl);
				s.push(pl);
			}
			//$(l).after("<div class='ceHolder' pattern='$' title='$'></div>".replace(/\$/g,p.join("|")));
			$(l).after("<div class='ceHolder' pattern='$'></div>".replace(/\$/g,p.join("|")));
		}
	}
	$(this).before("<div class='ciExample'>例词：<select id='q$'></select><br />　　　<a id='ceprev$' class='button' href='javascript:void(0);'>上一首例词</a><a id='cenext$' class='button' href='javascript:void(0);'>下一首例词</a><br /><span id='note$'></span>　</div>".replace(/\$/g,n));
	$(this).after("<div class='ciExample'>当前例词：<a id='celink$'></a><a href=\"#cp$\" class='button'>返回词牌开头</a></div>".replace(/\$/g,n));
	var p = s.join("|");
	// $(this).get(0).title = p;
	var exId = $(this).parent().attr("example"); // 特定例词
	var c = 0;
	if (ces) {
		var qn = $("#q"+n);
		var j=0;
		for (var i in ces) {
			var ce = ces[i];
			if (p == ce.p && !ce.y) {
				var fs = ce.t.split(/[，、。：；！？]/g)[0].replace(/<[^>]+>/g,"");
				if (exId == null /* 没有指定例词 */ || exId.indexOf(fs) != -1 /* 例词首句在指定例词之内 */) {
					qn.append("<option value='".concat(i,"'>",++j, ":", ce.w,"《",ce.c, "（",fs,"）》","</option>"));
					ce.y = true;
				}
			}
		}
		qn.bind ("change", showExample);
		qn.trigger("change");
		$("#ceprev"+n).bind("click",changeExample);
		$("#cenext"+n).bind("click",changeExample);
	}
};

$(function  () {
	if (typeof(ces) != "undefined") {
		$.each(ces, initExample);
		$("div.ci[example] > blockquote").each(initCipai);
		$("div.ci:not([example]) > blockquote").each(initCipai);
		var y = false;
		for (var i in ces) {
			var ce = ces[i];
			if (!ce.y) {
				var ci = document.createElement("div");
				ci.appendChild (document.createElement("blockquote"));
				ci.className = "ci";
				if (!y) {
					$("#ceExtra").before("<div class=\"ItemTitle\">【其它例词】</div>");
				}
				//$("#ceExtra").append("<div class=\"ItemTitle\">".concat(ce.w,"：《<a href=\"",ce.h,"\">",ce.c,"</a>》",ce.n,"</div>",ce.p)).append(ci);
				$("#ceExtra").append("<div class=\"ItemTitle\">".concat(ce.w,"：《<a href=\"",ce.h,"\">",ce.c,"</a>》",ce.n,"</div>")).append(ci);
				$(ci.firstChild).append(ces[i].t);
				ci = null;
				y = true;
			}
		}
		$("#ceExtra").after('<fieldset><legend>格律说明</legend><div>词牌格律与例词交错排列。格律使用宋体字排印，例词使用楷体字排印。词牌符号含义如下：</div><ul><li>平：填平声字；仄：填仄声字（上、去或入声）；中：可平可仄。</li><li>逗号“，”和句号“。”：表示句；顿号“、”：表示逗。</li><li>粗体字：表示<span class="ping">平声</span>或<span class="ze">仄声</span>韵脚字，或<span class="zeng">可押可不押</span>的韵脚。另，平仄转换、平仄错叶格以不同颜色区分韵部。</li><li><span class="lingge">下划线</span>：领格字。</li><li>『』：例作对偶；〖〗：例作叠韵。</li></ul></fieldset>');
	}
});

