<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.utils.ConfigUtil"
    pageEncoding="UTF-8"%>
<%
String dfSiteName = ConfigUtil.getDefaultSiteName();
%>

<form id="addForm" method="post" class="form-horizontal" action="">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 class="modal-title">选择<%=dfSiteName %></h4>
	</div>
	<div class="modal-body">
		<div class="well well-sm table-responsive">
			<ul id="selSiteTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">	
  		<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
		<button type="button" class="btn btn-primary" onclick="returnVal();return false;" name="addBtn" id="addBtn" >确定</button>
	</div>
</form>
<script type="text/javascript">
	$(document).ready(function(){
		var ztreeOpts = {
			"container":"selSiteTree",
			"disableParamKey":"level",
			"disableParamValue":"0",
			"check":{"enable":true,"chkStyle": "radio"}
		};
		renderSiteTree(ztreeOpts);
	});
	//回传选择的子公司id和名称
	function returnVal(){
		var treeObj = $.fn.zTree.getZTreeObj("selSiteTree");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length<1){
			layer.msg("请先选择一个<%=dfSiteName%>！",{icon:2})
			return false;
		}
		var id=nodes[0].id;
		var name=nodes[0].name;
		setSiteVal(id,name);
	}
</script>