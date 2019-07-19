<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();

String type= request.getParameter("type");

%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h4 class="modal-title">选择用户岗位</h4>
</div>
<div class="modal-body">
	<form id="post_sel-search-form" class="form-inline well well-sm well-cln sel_frm" action="" method="POST">
	<input type="text" class="form-control ipt-mgn" id="post_full_name" name="upost.full_name" value="" placeholder="输入岗位名称">
	<span id="post_reset-condition" title="重置搜索条件" class="glyphicon glyphicon-refresh" style="cursor: pointer;" aria-hidden="true"></span>
	<input type="button" class="btn btn-primary ipt-mgn" onclick="loadSelUsers(1);" value='搜索' />
	</form>
	<div class="row">
		<div class="col-md-3">
			<iframe id="treeIfm" style="border:1px solid #D4D0C8;" name="treeIfm" frameborder="0" height="375px" width="100%" scrolling="auto" src="<%=path %>/common/pages/sel_users_ugtree.jsp"></iframe>
		</div>
		<div class="col-md-9">
			<div id="post_data">请输入搜索条件查询岗位。</div>
		</div>
	</div>
</div>
<div class="modal-footer">
 		<button type="button" class="btn btn-primary" data-dismiss="modal" tabindex="6">关闭</button>
</div>

<script type="text/javascript">
var path = "<%=path %>";
var us_site_id = 0,us_user_group_id = 0;
var flag = true;
$('input, textarea').placeholder();

$(document).ready(function(){
	;//loadSelUsers(1);
});

function loadSelUsers(cp){
	var data = getParameters(cp);
	var sel_url = path + "/upost/searchPostByTree.action?oper=single&r="+Math.random();
	$("#post_data").load(sel_url,data,function(res){
		initB3paginatorForSellugroup();//loadSelUser();setChkSel();layer.close(idx);setPagerShowHide();
	});
}
function setPagerShowHide(){
	if(us_site_id == 1 && !flag){
		$("#pagination_main").hide();
	}else{
		$("#pagination_main").show();
	}
}

$("#post_reset-condition").on('click',function(){
	flag = false;
	us_site_id = 0;
	$("#post_full_name").val("");
	$("#post_data").html("请输入搜索条件查询岗位。");
	getIframe("treeIfm").cancelSelectNote();
});
//获得提交参数
function getParameters(cp){
	var curp = $('#curPageUs').val();
	if(us_site_id == 0 && !flag){us_site_id = 1;}
	var target="O"; var target_id=us_user_group_id;
	if(us_user_group_id ==0 && us_site_id !=0) {target="S"; target_id=us_site_id;}

	if(cp != null && cp != ''){ curp = cp; }
	var data = {
			"upost.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
			"upost.curPage": curp,
			"upost.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
			"upost.totCount": $('#totCount').val() == null ? "0" : $('#totCount').val(),
			"upost.site_id": us_site_id,
			"target": target,
			"target_id": target_id,
			"upost.full_name": $("#post_full_name").val(),
			"upost.is_deleted": "Y"
	};
	return data;
}
//初始化分页
function initB3paginatorForSellugroup(){
	var data = getParameters();
	//基本分页
	b3Paginator('paginationUs', 5, data['upost.curPage'], data['upost.pageSize'], data['upost.totPage'],
		function(event, originalEvent, type, page){
        	var goPage = 1;
        	if(type == "first") goPage = 1;
        	else if(type == "prev") goPage = parseInt(data['upost.curPage']) - 1;
        	else if(type == "next") goPage = parseInt(data['upost.curPage']) + 1;
        	else if(type == "last") goPage = data['upost.totPage'];
        	else if(type == "page") goPage = page;
        	//页面跳转方法自行定义
        	loadSelUsers(goPage);
    	}, function (type, page, current) {
        	return null;
    });
	$(".page-list").b3paginatorext({
    	onPageSizeChange:function(){loadSelUsers(1);},
    	pagesizeinput:"#pageSizeUs",
    	pagesize:data['upost.pageSize'],
    	totcount:data['upost.totCount']});
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