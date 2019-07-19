<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();

String type= request.getParameter("type");

%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title">选择用户群组</h4>
</div>
<div class="modal-body">
	<form id="lug_sel-search-form" class="form-inline well well-sm well-cln sel_frm" action="" method="POST">
	<input type="text" id="lname" class="form-control ipt-mgn" name="lugroup.name" value="" placeholder="用户群组名称">
	<span id="lug_reset-condition" title="重置搜索条件" class="glyphicon glyphicon-refresh" style="cursor: pointer;" aria-hidden="true"></span>
	<input type="button" class="btn btn-primary ipt-mgn" onclick="loadSelUsers(1);" value='搜索' />
		<a target="_blank" href="<%=path %>/ucenter/admin/uindex.jsp?to=addlugroup" class="btn btn-info btn-sm pull-right" style="margin-top:12px;">添加新群组</a>
	</form>
	<div class="row">
		<div class="col-md-3">
			<iframe id="treeIfm" style="border:1px solid #D4D0C8;" name="treeIfm" frameborder="0" height="375px" width="100%" scrolling="auto" src="<%=path %>/common/pages/sel_users_ugtree.jsp"></iframe>
		</div>
		<div class="col-md-7">
			<div id="lug_data">请输入搜索条件查询用户群组。</div>
		</div>
		<div class="col-md-2">
			<div id="sel_user" style="border:1px solid #D4D0C8;height:375px;overflow: auto;padding: 0 0 0 2px;"></div>
		</div>
	</div>
</div>
<div class="modal-footer">
 		<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
	<button type="button" class="btn btn-primary" onclick="returnVal();return false;"  name="addBtn" id="addBtn" >确定</button>
</div>
<script type="text/javascript">
var path = "<%=path %>";
var us_site_id = 0,us_user_group_id = 0;
var flag = true;
$('input, textarea').placeholder();

$(document).ready(function(){	
	$("#lug_reset-condition").on('click',function(){
		$("#lug_sel-search-form").find("input[type='text']").val("");
	});
});	

function loadSelUsers(cp){
	idx = layer.load(300);
	var data = getParameters(cp);
	var sel_lug_url = path + "/lugroup/searchluGroupByTree.action?r="+Math.random();
	$("#lug_data").load(sel_lug_url,data,function(res){
		loadSelUser();setChkSel();layer.close(idx);initB3paginatorForSellugroup();setPagerShowHide();
	});	
}
function setPagerShowHide(){
	if(us_site_id == 1 && !flag){
		$("#pagination_main").hide();
	}else{
		$("#pagination_main").show();
	}
}
function clearnSearch(){
	flag = false;
	us_site_id = 0;
	$('#lugroup.name').val("");
	$("#lug_data").html("请输入搜索条件查询群组。");
	getIframe("treeIfm").cancelSelectNote();
}
//获得提交参数
function getParameters(cp){
	var curp = $('#curPageUs').val();
	if(us_site_id == 0 && !flag){us_site_id = 1;}
	var target="O"; var target_id=us_user_group_id;
	if(us_user_group_id ==0 && us_site_id !=0) {target="S"; target_id=us_site_id;}

	if(cp != null && cp != ''){ curp = cp; }
	
	var data = {
			"lugroup.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
			"lugroup.curPage": curp,
			"lugroup.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
			"lugroup.totCount": $('#totCount').val() == null ? "0" : $('#totCount').val(),					
			"lugroup.site_id": us_site_id,
			"target": target,			
			"target_id": target_id,
			"lugroup.name": $('#lname').val(),
			"lugroup.is_enabled": "Y"			
	};
	return data;
}
//初始化分页
function initB3paginatorForSellugroup(){
	var data = getParameters();
	//基本分页
	b3Paginator('paginationUs', 5, data['lugroup.curPage'], data['lugroup.pageSize'], data['lugroup.totPage'], 
		function(event, originalEvent, type, page){
        	var goPage = 1;
        	if(type == "first") goPage = 1;
        	else if(type == "prev") goPage = parseInt(data['lugroup.curPage']) - 1;
        	else if(type == "next") goPage = parseInt(data['lugroup.curPage']) + 1;
        	else if(type == "last") goPage = data['lugroup.totPage'];
        	else if(type == "page") goPage = page;
        	//页面跳转方法自行定义
        	loadSelUsers(goPage);
    	}, function (type, page, current) {
        	return null;
    });
	$(".page-list").b3paginatorext({
    	onPageSizeChange:function(){loadSelUsers(1);},
    	pagesizeinput:"#pageSizeUs",
    	pagesize:data['lugroup.pageSize'],
    	totcount:data['lugroup.totCount']});
}

var umap = new JHashMap();
function loadSelUser(){
	if(umap.size() == 0){
		$("#sel_user").html("没有选择用户群组");
	}else{
		var keys = umap.keySet();
		var nameStr = "";
		if(keys != null && keys.length > 0){
			for(var i=0;i<keys.length;i++){
				nameStr = nameStr + "<nobr>" + umap.get(keys[i]) + " <img style='cursor: pointer;' onclick='delSelUser(\""+keys[i]+"\")' src='"+path+"/common/images/delete.gif'/></nobr><br/>";
			}
		}
		if(nameStr != null && nameStr != ''){
			$("#sel_user").html(nameStr);
		}else{
			$("#sel_user").html("没有选择用户群组");
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
var type ='<%=type%>';
function returnVal(){	 
	var uids = umap.keySet();
	if(uids == null || uids.length == 0){
		layer.alert('请选择用户群组后再点击确定按钮！', 8);
	}else{
		if(type=='KBMS'){
			uids=$(uids).map(function (index,ele) {
				return  {"id":ele,"name":umap.get(ele),"type":"U"};
			});
		}
		if(type=='UCENTER'){
			uids=$(uids).map(function (index,ele) {
				return  {"id":ele,"name":umap.get(ele)};
			});
		}
		
		selLogical(uids);
		 
	}
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
</script>