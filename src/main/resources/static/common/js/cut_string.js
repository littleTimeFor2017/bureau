jQuery.fn.limit = function() {
	var self = $("span[limit]");
	self.each(function() {
				var objString = $(this).text();
				var objLength = $(this).text().replace(/[^\x00-\xff]/g, "xx").length;
				var num = $(this).attr("limit");
				if (objLength > num) {
					$(this).attr("title", objString);
					// objString = $(this).text(objString.substring(0,num) +
					// "...");
					objString = $(this).text(
							getInterceptedStr(objString, num) + "...");
				}
			});
};
/*$(function() {
	$(document.body).limit();
})*/
function getInterceptedStr(sSource, iLen) {
	if (sSource.replace(/[^\x00-\xff]/g, "xx").length <= iLen) {
		return sSource;
	}
	var ELIDED = "";

	var str = "";
	var l = 0;
	var schar;
	for (var i = 0; schar = sSource.charAt(i); i++) {
		str += schar;
		l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);
		if (l >= iLen - ELIDED.length) {
			break;
		}
	}
	str += ELIDED;

	return str;
}