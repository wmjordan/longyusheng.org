$(function() {
	$('a[href^="#"]').bind('click', function(e) {
		e.preventDefault();
		var targetHash = $(e.target).attr('href');
		var targetEle = $("a[name='"+targetHash.substr(targetHash.indexOf('#') + 1)+"']");
	
		$([
			document.documentElement, document.body
		]).animate({scrollTop: targetEle.offset().top - 50}, 500);
	});
});