<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();

String type= request.getParameter("type");
String from = request.getParameter("from");
from = from == null ? "" : from;
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
		<div class="col-md-3">
			<iframe id="treeIfm" style="border:1px solid #D4D0C8;" name="treeIfm" frameborder="0" height="375px" width="100%" scrolling="auto" src="<%=path %>/common/pages/sel_users_ugtree.jsp"></iframe>
		</div>
		<div class="col-md-9">
			<div id="users_data">请选择左侧组织机构或输入搜索条件查询用户。</div>
		</div>
	</div>
</div>
<div class="modal-footer">	
	<% if(!from.equals("h5")){ %>
	<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
	<% } %> 	
	<!-- <button type="button" class="btn btn-primary" onclick="returnVal();return false;"  name="addBtn" id="addBtn" >确定</button> -->
</div>
<script type="text/javascript">
var path = "<%=path %>";
var from = "<%=from %>";
var us_site_id = 0,us_user_group_id = 0;
$('input, textarea').placeholder();
function loadSelUsers(cp){
	idx = layer.load(300);
	var data = getParametersforSelUsers(cp);
	var sel_user_url = path + "/user/getUserOfUserGroupToSel.action?r="+Math.random();
	$("#users_data").load(sel_user_url,data,function(res){
		//$('input, textarea').placeholder();
		layer.close(idx);initB3paginatorForSelUsers();
	});
}
//获得提交参数totCountUs
function getParametersforSelUsers(cp){
	var curp = $('#curPageUs').val();
	if(cp != null && cp != ''){ curp = cp; }
	var data = {
			"user.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
			"user.curPage": curp,
			"user.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
			"totCount": $('#totCountUs').val() == null ? "0" : $('#totCountUs').val(),
			"user.site_id": us_site_id,
			"user.user_group_id": us_user_group_id,
			"keyType": $('#keyTypeUs').val(),
			"keyword": $('#keywordUs').val(),
			"user.userAttr.jobcode":$("#keywordUsJob").val(),
			"user.userAttr.supv_lvl_id":$("#keywordUsSupvLvl").val(),
        	"user.is_invalid":'N' /*禁封用户*/
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
    	pagesize:data['user.pageSize'],
		totcount:data['totCount']});
}
function returnUserInfo(id,name){
	if(from == "h5"){
		parent.selUser(id,name);
	}else{
		selUser(id,name);
	}
	
}

function clearnSearch(){
	$('#keywordUs').val("");
	$("#users_data").html("请选择左侧组织机构或输入搜索条件查询用户。");
}
</script>