/**
 * 调用方法：bsAlert(type,msg)
 * 参数：type为 'D' 错误、'S' 成功、'W' 警告，msg为提示信息
 * 
 * */
var alertTm = null;
$().ready(function() {
	//错误提示Alert
	var atDanger = document.createElement("div");
	atDanger.setAttribute("id","alert-danger");
	atDanger.setAttribute("class","alert alert-danger fade in");
	atDanger.setAttribute("role","alert");
	atDanger.innerHTML = '<a class="close" onclick="$(\'#alert-danger\').hide()">×</a><strong>错误！</strong><span id="alert-danger-msg"></span>';
	document.body.appendChild(atDanger);
	//成功提示Alert
	var atSuccess = document.createElement("div");
	atSuccess.setAttribute("id","alert-success");
	atSuccess.setAttribute("class","alert alert-success fade in");
	atSuccess.setAttribute("role","alert");
	atSuccess.innerHTML = '<a class="close" onclick="$(\'#alert-success\').hide()">×</a><strong>成功！</strong><span id="alert-success-msg"></span>';
	document.body.appendChild(atSuccess);
	//警告提示Alert
	var atWarning = document.createElement("div");
	atWarning.setAttribute("id","alert-warning");
	atWarning.setAttribute("class","alert alert-warning fade in");
	atWarning.setAttribute("role","alert");
	atWarning.innerHTML = '<a class="close" onclick="$(\'#alert-warning\').hide()">×</a><strong>警告！</strong><span id="alert-warning-msg"></span>';
	document.body.appendChild(atWarning);
	
	hideAlert();

});
function hideAlert(){
	$("#alert-danger").hide();
	$("#alert-success").hide();
	$("#alert-warning").hide();
}
//提示信息
function bsAlert(type,msg){
	hideAlert();
	if(type == "S"){
		$("#alert-success-msg").html(msg);
		$("#alert-success").show();
		autoClose($("#alert-success"));
	}else if(type =="W"){
		$("#alert-warning-msg").html(msg);
		$("#alert-warning").show();
		autoClose($("#alert-warning"));
	}else if(type == "D"){
		$("#alert-danger-msg").html(msg);
		$("#alert-danger").show();
		autoClose($("#alert-danger"));
	}
}
function autoClose(obj,time){
	if(alertTm){
		window.clearTimeout(alertTm);
	}
	time = time == null || time == "" ? 4000 : time;
	alertTm = window.setTimeout(function () {obj.hide(); }, time); 
}
function formGroupHelpBlock(objId,type){
	 if(type == "error"){
		 $("#"+objId).attr("class","has-error form-group");
	 }else if(type == "success"){
		 $("#"+objId).attr("class","has-success form-group");
	 }
}
function loadErrorMsg(objId,res){
	try{
		var json = eval('(' + res + ')'); 
		if(json.msg != null && json.msg != ""){
			$("#"+objId).html("<div style='margin:0 20px 20px 20px;color:red;'>"+json.msg+"</div>");
		}
	}catch(e){}
}
function loadChkSession(data){
	try{
		var json = eval('(' + data + ')'); 
		if(json.more != null && json.more != "utknull"){
			window.location.reload();
		}
	}catch(e){}
}
$.ajaxSetup({
	complete:function(XMLHttpRequest, status){ 
		var res = XMLHttpRequest.responseText;
		try{
			res = eval('(' + res + ')'); 
			if(res.more !=null && res.more=="utknull"){
				window.location.reload();
			}
		}catch(e){}
	}
}); 