<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.support.Constants"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title">选择学员</h4>
</div>
<div class="modal-body">
	<jsp:include page="/common/pages/sel_users_search.jsp"></jsp:include>
	<div class="row">
		<div class="col-md-9">
			<div id="users_data"></div>
		</div>
		<div class="col-md-3">
			<div id="sel_user" style="border:1px solid #D4D0C8;height:375px;overflow: auto;padding: 0 0 0 2px;"></div>
		</div>
	</div>
</div>
<div class="modal-footer">	
 	<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
	<button type="button" class="btn btn-primary" onclick="returnVal();return false;" name="addBtn" id="addBtn" >确定</button>
</div>
<script type="text/javascript">
var path = "<%=path %>";
var us_site_id = "<%=Constants.ROOT_SITE_ID %>",us_user_group_id = 0;
function loadSelUsers(cp){
	idx = layer.load(300);
	var data = getParametersforSelUsers(cp);
	var sel_user_url = path + "/user/getAllUsersOfSiteToSel.action?r="+Math.random();
	$("#users_data").load(sel_user_url,data,function(res){
		//$('input, textarea').placeholder();
		loadSelUser();setChkSel();layer.close(idx);initB3paginatorForSelUsers();
	});
}
//获得提交参数
function getParametersforSelUsers(cp){
	var curp = $('#curPageUs').val() == null ? "1" : $('#curPageUs').val();
	if(cp != null && cp != ''){ curp = cp; }
	var data = {
			"user.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
			"user.curPage": curp,
			"user.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
			"user.site_id": us_site_id,
			"user.user_group_id": us_user_group_id,
			"keyType": $('#keyTypeUs').val(),
			"keyword": $('#keywordUs').val()
	};
	return data;
}
//初始化分页
function initB3paginatorForSelUsers(){
	var data = getParametersforSelUsers();
	//基本分页
	b3Paginator('paginationUs', 5, data['user.curPage'], data['user.pageSize'], data['user.totPage'], 
		function(event, originalEvent, type, page){
        	var goPage = 1;
        	if(type == "first") goPage = 1;
        	else if(type == "prev") goPage = parseInt(data['user.curPage']) - 1;
        	else if(type == "next") goPage = parseInt(data['user.curPage']) + 1;
        	else if(type == "last") goPage = data['user.totPage'];
        	else if(type == "page") goPage = page;
        	//页面跳转方法自行定义
        	loadSelUsers(goPage);
    	}, function (type, page, current) {
        	return null;
    });
	$(".page-list").b3paginatorext({
    	onPageSizeChange:function(){loadSelUsers(1);},
    	pagesizeinput:"#pageSizeUs",
    	pagesize:data['user.pageSize']});
}

var umap = new JHashMap();
function loadSelUser(){
	if(umap.size() == 0){
		$("#sel_user").html("没有选择学员");
	}else{
		var keys = umap.keySet();
		var nameStr = "";
		if(keys != null && keys.length > 0){
			for(var i=0;i<keys.length;i++){
				nameStr = nameStr + umap.get(keys[i]) + " <img style='cursor: pointer;' onclick='delSelUser(\""+keys[i]+"\")' src='"+path+"/common/images/delete.gif'/><br/>";
			}
		}
		if(nameStr != null && nameStr != ''){
			$("#sel_user").html(nameStr);
		}else{
			$("#sel_user").html("没有选择学员");
		}
	}
}
function delSelUser(chkey){
	if(umap.get(chkey) != null && umap.get(chkey)!= ""){
		umap.remove(chkey);
		var rowNum = $("#row_"+chkey).val();
		if(rowNum != null && rowNum != ""){
   			if(rowNum%2==0){
				$("#tr_"+chkey).removeClass("XCLTableList_trChecked");
   				$("#tr_"+chkey).addClass("XCLTableList_trEven");
   			}else{
   				$("#tr_"+chkey).removeClass("XCLTableList_trChecked");
   				$("#tr_"+chkey).addClass("XCLTableList_trOdd");
   			}
			$("#ck_"+chkey).attr("checked",false);
		}
		loadSelUser();
	}
}
function setChkSel(){
	if(umap.size() != 0){
		var keys = umap.keySet();
		var rowNum = 0;
		if(keys != null && keys.length > 0){
			for(var i=0;i<keys.length;i++){
				$("#ck_"+keys[i]).attr("checked",true);
				rowNum = $("#row_"+keys[i]).val();
       			if(rowNum%2==0){
       				$("#tr_"+keys[i]).removeClass("XCLTableList_trEven");
       			}else{
       				$("#tr_"+keys[i]).removeClass("XCLTableList_trOdd");
       			}
       			$("#tr_"+keys[i]).addClass("XCLTableList_trChecked");
			}
		}  		
	}
}
function setCheckboxValues(chkName){
    var checkbox = document.getElementsByName(chkName);
    var uname = "";
    var rowNum = 0;
    if(checkbox && checkbox.length > 0){
	    for(var i = 0;i < checkbox.length;i++){
	    	if(checkbox[i].checked && checkbox[i].disabled == false){
	    		if(umap.get(checkbox[i].value) == null || umap.get(checkbox[i].value) == ""){
	    			uname = $("#name_"+checkbox[i].value).val();
	    			umap.put(checkbox[i].value,uname);
	    		}
	       	}else{
	       		if(umap.get(checkbox[i].value) != null && umap.get(checkbox[i].value)!= ""){
	       			umap.remove(checkbox[i].value);
	       			rowNum = $("#row_"+checkbox[i].value).val();
	       			if(rowNum%2==0){
	       				$("#tr_"+checkbox[i].value).removeClass("XCLTableList_trChecked");
	       				$("#tr_"+checkbox[i].value).addClass("XCLTableList_trEven");
	       			}else{
	       				$("#tr_"+checkbox[i].value).removeClass("XCLTableList_trChecked");
	       				$("#tr_"+checkbox[i].value).addClass("XCLTableList_trOdd");
	       			}
	       		}
	       	}
	    }
    } 
    loadSelUser();
}
function returnVal(){
	var uids = umap.keySet();
	if(uids == null || uids.length == 0){
		layer.alert('请选择学员后再点击确定按钮！', 8);
	}else{
		selUsers(uids);
	}
}
loadSelUsers();
$('input, textarea').placeholder();
</script>