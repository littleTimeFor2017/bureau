function closeModal(){
	var mhtml = '<div class="modal-dialog">'+
			 		'<div class="modal-content"></div>'+
				'</div>'; 
	$(".modal-backdrop").remove();
	$("body").removeClass("modal-open");
	$("#dModal").removeAttr("style");
	$("#dModal").modal('hide');
	$("#dModal").html(mhtml);
}
function setModelClass(type){
	if(type == "L"){
		$("#dModal").attr("aria-labelledby","myLargeModalLabel");
		$(".modal-dialog").attr("class","modal-dialog modal-lg");
	}else{
		$("#dModal").attr("aria-labelledby","myModalLabel");
		$(".modal-dialog").attr("class","modal-dialog");
	}
}
function formGroupHelpBlock(objId,type,msg){
	 if(type == "error"){
		 $("#"+objId).attr("class","has-error form-group");
		 if(msg != null && msg != ""){
			 $("#"+objId+"_hb").html(msg);
		 }
	 }else if(type == "success"){
		 $("#"+objId).attr("class","has-success form-group");
		 $("#"+objId+"_hb").html("");
	 }
}
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {  
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {  
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);  
    } else {  
        return this.replace(reallyDo, replaceWith);  
    }  
} 
function comma(num) {
    var source = String(num).split(".");//按小数点分成2部分
        source[0] = source[0].replace(new RegExp('(\\d)(?=(\\d{3})+$)','ig'),"$1,");//只将整数部分进行都好分割
    return source.join(".");//再将小数部分合并进来
}
function getIframeObject(ifr,objId){
	var obj;
	if(navigator.appName == "Netscape") {//firefox等兼容
		obj = document.getElementById(ifr).contentDocument.getElementById(objId);
	}else{//ie兼容
	    obj = document.frames[ifr].document.getElementById(objId);
	}
	return obj;
}
function getIframe(ifr){
	var obj;
	if(navigator.appName == "Netscape") {//firefox等兼容
		obj = document.getElementById(ifr).contentWindow;
	}else{//ie兼容
	    obj = document.frames[ifr];
	}
	return obj;
}

function html2Escape(sHtml)
{
	return sHtml.replace(/[<>&"']/g,function(c){
		return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;','\'':'&apos;'}[c];
		});
}

/**
 * 将秒数换成时分秒格式
 */
function formatSeconds(value) {
	var secondTime = parseInt(value);// 秒
	var minuteTime = 0;// 分
	var hourTime = 0;// 小时
	if(secondTime > 60) {//如果秒数大于60，将秒数转换成整数
		//获取分钟，除以60取整数，得到整数分钟
		minuteTime = parseInt(secondTime / 60);
		//获取秒数，秒数取佘，得到整数秒数
		secondTime = parseInt(secondTime % 60);
		//如果分钟大于60，将分钟转换成小时
		if(minuteTime > 60) {
			//获取小时，获取分钟除以60，得到整数小时
			hourTime = parseInt(minuteTime / 60);
			//获取小时后取佘的分，获取分钟除以60取佘的分
			minuteTime = parseInt(minuteTime % 60);
		}
	}
	var result = "" + parseInt(secondTime) + "秒";

	if(minuteTime > 0) {
		result = "" + parseInt(minuteTime) + "分" + result;
	}
	if(hourTime > 0) {
		result = "" + parseInt(hourTime) + "小时" + result;
	}
	return result;
}
/**
 * 将秒数换成时分秒格式
 */
function formatSecondsMh(value) {
	var secondTime = parseInt(value);// 秒
	var minuteTime = 0;// 分
	var hourTime = 0;// 小时
	if(secondTime > 60) {//如果秒数大于60，将秒数转换成整数
		//获取分钟，除以60取整数，得到整数分钟
		minuteTime = parseInt(secondTime / 60);
		//获取秒数，秒数取佘，得到整数秒数
		secondTime = parseInt(secondTime % 60);
		//如果分钟大于60，将分钟转换成小时
		if(minuteTime > 60) {
			//获取小时，获取分钟除以60，得到整数小时
			hourTime = parseInt(minuteTime / 60);
			//获取小时后取佘的分，获取分钟除以60取佘的分
			minuteTime = parseInt(minuteTime % 60);
		}
	}
	var result = "";
	if(parseInt(secondTime) > 0){
		result = "" + parseInt(secondTime);
	}else{
		result = "0";
	}
	if(minuteTime > 0) {
		result = "" + parseInt(minuteTime) + ":" + result;
	}else{
		result = "0" + ":" + result;
	}
	if(hourTime > 0) {
		result = "" + parseInt(hourTime) + ":" + result;
	}else{
		result = "0" + ":" + result;
	}
	return result;
}