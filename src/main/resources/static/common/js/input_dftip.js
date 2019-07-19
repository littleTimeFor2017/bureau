/**
 * Input框里的灰色提示，使用前先引入jquery 使用方法:<input type="text" tipMsg="您的用户ID"/>
 * 
 * @return
 */
function inputTipText() {
	$("input[tipMsg]").each(function() {
		if ($(this).val() == "") {
			var oldVal = $(this).attr("tipMsg");
			if ($(this).val() == "") {
				$(this).attr("value", oldVal).css({
					"color" : "#888"
				});
			}
			$(this).css({
				"color" : "#888"
			}) // 灰色
			.focus(function() {
				if ($(this).val() != oldVal) {
					$(this).css({
						"color" : "#000"
					});
				} else {
					$(this).val("").css({
						"color" : "#888"
					});
				}
			}).blur(function() {
				if ($(this).val() == "") {
					$(this).val(oldVal).css({
						"color" : "#888"
					});
				}
			}).keydown(function() {
				$(this).css({
					"color" : "#000"
				});
			});
		}
	});
}
