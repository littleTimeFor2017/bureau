<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String lg_sid=request.getParameter("site_id");
String path = request.getContextPath();
if(lg_sid==null) lg_sid="-1";
%>

<form id="addForm" method="post" class="form-horizontal" action="">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 class="modal-title">选择课程分类</h4>
	</div>
	<div class="modal-body">
		<div class="well well-sm table-responsive">
			<ul id="course_category_Tree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">	
  		<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
		<button type="button" class="btn btn-primary" onclick="returnCatgoryVal();return false;" name="addBtn" id="addBtn" >确定</button>
	</div>
</form>
<script type="text/javascript" src="<%=path%>/admin/course/category/categoryTreeforPick.js?version=x"></script>
<script type="text/javascript">
var path = '<%=path%>';
var lca_sid=<%=lg_sid%>;

var cc_conainter_id="course_category_Tree";
	$(document).ready(function(){
		var ztreeOpts = {
				"container":cc_conainter_id,
				"disableParamKey":"level",
				"disableParamValue":"0",
				"lca_sid":lca_sid,
				"check":{"enable":true,"chkStyle":"radio"}
			};
		renderCategoryTree(ztreeOpts);
	});
	//回传选择的课程分类id和名称
	function returnCatgoryVal(){
		var treeObj = $.fn.zTree.getZTreeObj(cc_conainter_id);
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length<1){
			layer.msg('请选择一个分类再点击确定',{icon:2})
			return false;
		}
		var id=nodes[0].id;
		var name=nodes[0].name;
		setCategoryVal(id,name);
	}
</script>