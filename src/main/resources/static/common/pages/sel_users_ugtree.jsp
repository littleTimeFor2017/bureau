<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=path %>/common/zTree3.5/css/custom/zTreeStyle.css" type="text/css">
<link href="<%=path %>/common/css/global.css" rel="stylesheet">
<link href="<%=path %>/common/css/public.css" rel="stylesheet">
<script src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/jquery/jquery.browser.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.exedit-3.5.min.js"></script>
<title></title>
</head>
<body style="background-color: #F5F5F5;">
<ul id="userGroupTree" class="ztree"></ul>
<script type="text/javascript">
var path = "<%=path %>";
var zTree;
var setting = {
	async: {  
        enable: true,  
        autoParam: ["id=treeNode.id","type=treeNode.type"],
        dataType: "json"
    },
	view: {
		dblClickExpand: false,
		showLine: true,
		showIcon: true,
		selectedMulti: false,
		expandSpeed:""
	},
	data: {
		simpleData: {
			enable:true,
			idKey: "id",
			pIdKey: "parentId",
			rootPId: "0"
		}
	},
	callback: {
		onClick: zTreeOnClick
	}
};
function initGroupTree(){
	dataParam = {"treetype":"PICKUSER"};	
	setting.async.url = path + "/usergroup/ajaxAsyncSubNodes.action";
	var treeObj = $("#userGroupTree");
	$.ajax({
		type:"POST",
		async:true,
		dataType:"json", 
		data:dataParam,
		url: path + "/usergroup/initSiteUserGroupTree.action",
		//beforeSend:user_loading("treeDemo"),
		success:function(data){
			var zNodes = data.obj;
			treeObj =  $.fn.zTree.init(treeObj, setting, zNodes);
			//选中根节点
			var zTree = $.fn.zTree.getZTreeObj("userGroupTree");
			var rootNode = zTree.getNodeByParam("level", 0);
			zTree.selectNode(rootNode);
			zTree.expandNode(rootNode, true); //自动展开
			
		//	if(parent.flag){
				if(rootNode.type == "S"){
					parent.us_site_id = rootNode.id;
					parent.us_user_group_id = 0;
				}else{
					parent.us_site_id = rootNode.site_id;
					parent.us_user_group_id = rootNode.id;
				}
		//	}
		}
	});
}
function cancelSelectNote(){
	var zTree = $.fn.zTree.getZTreeObj("userGroupTree");
	zTree.cancelSelectedNode();
}
function zTreeOnClick(event, treeId, treeNode){
	parent.flag = true;
	if(treeNode.type == "S"){
		parent.us_site_id = treeNode.id;
		parent.us_user_group_id = 0;
	}else if(treeNode.type == "O"){
		parent.us_site_id = treeNode.site_id;
		parent.us_user_group_id = treeNode.id;
	}
	parent.loadSelUsers(1);
}
initGroupTree();
</script>
</body>
</html>