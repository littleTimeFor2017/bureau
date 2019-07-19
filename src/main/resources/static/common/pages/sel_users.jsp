<%@ page language="java" import="cn.kindee.common.core.support.UserToken
								,cn.kindee.common.core.utils.ConfigUtil" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String type= request.getParameter("type");
type = type == null ? "" : type;
String from = request.getParameter("from");
from = from == null ? "" : from;
UserToken userToken = ConfigUtil.getUserToken(session);
userToken = userToken == null ? new UserToken() : userToken;
%>
<% if(!from.equals("h5")){ %>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title">选择学员</h4>
</div>
<% }else{  %>
<link href="<%=path%>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
<link href="<%=path%>/common/css/global.css" rel="stylesheet">
<link href="<%=path%>/common/css/public.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path %>/common/zTree3.5/css/custom/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.exedit-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
<script type="text/javascript" src="<%=path %>/ucenter/usergroup/js/usergroup-tree.js"></script><!-- 部门 -->
<script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>

<script type="text/javascript" src="<%=path%>/common/js/placeholder.js"></script>
<script type="text/javascript" src="<%=path%>/common/js/hashmap.js"></script>
<script type="text/javascript" src="<%=path%>/common/js/table_map.js"></script>
<% } %>
<div class="modal-body">
	<jsp:include page="/common/pages/sel_users_search.jsp"></jsp:include>
	<div class="row">
		<% if(!type.equals("SHARE")){ %>
		<div class="col-md-3">
			<iframe id="treeIfm" style="border:1px solid #D4D0C8;" name="treeIfm" frameborder="0" height="375px" width="100%" scrolling="auto" src="<%=path %>/common/pages/sel_users_ugtree.jsp"></iframe>
		</div>
		<% } %>
		<div class="<% if(type.equals("SHARE")){ %>col-md-9<% }else{ %>col-md-7<% } %>">
			<div id="users_data">请选择左侧组织机构或输入搜索条件查询用户。</div>
		</div>
		<div class="<% if(type.equals("SHARE")){ %>col-md-3<% }else{ %>col-md-2<% } %>">
			<div id="sel_user" style="border:1px solid #D4D0C8;height:375px;overflow: auto;padding: 0 0 0 2px;"></div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<% if(!from.equals("h5")){ %>
	<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
	<% } %>
	<button type="button" class="btn btn-primary" onclick="returnVal();return false;"  name="addBtn" id="addBtn" >确定</button>
</div>
<script type="text/javascript">
var path = "<%=path %>";
var from = "<%=from %>";
var type ='<%=type%>';
var us_site_id = 0,us_user_group_id = 0;
var flag = true;
$('input, textarea').placeholder();
var ut_site_id = "<%=userToken.getSite_id() %>";
function loadSelUsers(cp){
	idx = layer.load(300);
	var data = getParametersforSelUsers(cp);
	var sel_user_url = path + "/user/getAllUsersOfUserGroupToSel.action?r="+Math.random();
	$("#users_data").load(sel_user_url,data,function(res){
		//$('input, textarea').placeholder();
		loadSelUser();setChkSel();layer.close(idx);if(type != "SHARE"){initB3paginatorForSelUsers();}setPagerShowHide();
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
//	us_site_id = 0;
	$('#keywordUs').val("");
	$("#keywordEmail").val("");
	$("#keywordUsJob").val("");
	$("#keywordUsSupvLvl").val("");
	$("#users_data").html("请选择左侧组织机构或输入搜索条件查询用户。");
//	getIframe("treeIfm").cancelSelectNote();
}
//获得提交参数
function getParametersforSelUsers(cp){
	var curp = $('#curPageUs').val();
	if(us_site_id == 0 && !flag){us_site_id = 1;}
	if(type == "SHARE"){
		us_site_id = ut_site_id;
	}
	if(cp != null && cp != ''){ curp = cp; }
	var data = {
			"user.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
			"user.curPage": curp,
			"user.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
			"user.totCount": $('#totCount').val() == null ? "0" : $('#totCount').val(),
			"user.site_id": us_site_id,
			"user.user_group_id": us_user_group_id,
			"keyType": $('#keyTypeUs').val(),
			"keyword": $('#keywordUs').val(),
			"user.email":$("#keywordEmail").val(),
			"user.userAttr.jobcode":$("#keywordUsJob").val(),
			"user.userAttr.supv_lvl_id":$("#keywordUsSupvLvl").val(),
			"user.is_invalid":'N', /*禁封用户*/
			"user.from":type
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
	
    //初始化每页显示条数
    $(".page-list").b3paginatorext({
    	onPageSizeChange:function(){loadSelUsers();},
    	pagesizeinput:"#pageSizeUs",
    	pagesize:data['user.pageSize'],
    	totcount:data['user.totCount']});
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
				nameStr = nameStr + "<nobr>" + umap.get(keys[i]) + " <img style='cursor: pointer;' onclick='delSelUser(\""+keys[i]+"\")' src='"+path+"/common/images/delete.gif'/></nobr><br/>";
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
		if(from == "h5"){
			parent.selUsers(uids);
		}else{
			selUsers(uids);
		}
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