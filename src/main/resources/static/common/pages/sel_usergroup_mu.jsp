<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%
    String type= request.getParameter("type");
    %>
<form id="addForm" method="post" class="form-horizontal" action="">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 class="modal-title">选择部门</h4>
	</div>
	<div class="modal-body">
		<div class="well well-sm table-responsive">
			<ul id="selUsergroupTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">	
  		<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
		<button type="button" class="btn btn-primary" onclick="getUgroupIds();return false;" name="addBtn" id="addBtn" >确定</button>
	</div>
</form>
<script type="text/javascript">
var type ='<%=type%>';
var umap = new JHashMap();

	$(document).ready(function(){
		var ztreeOpts = {
			"container":"selUsergroupTree",
			"disableParamKey":"type",
			"disableParamValue":"S",
			"check":{"enable":true,"chkStyle":"checkbox","chkboxType": { "Y": "", "N": "ps" }}
		};
		renderUserGroupTree(ztreeOpts);
	});
	function getUgroupIds() {
		var treeObj = $.fn.zTree.getZTreeObj("selUsergroupTree");
		var nodes = treeObj.getCheckedNodes(true);
		var ids = "";
		var names ="";
		if(nodes != null && nodes != ""){
			for(var i=0; i<nodes.length;i++){
				if(ids == ""){
					ids = nodes[i].id;
				}else {
					ids = ids + "," + nodes[i].id;
				}
				umap.put(nodes[i].id,nodes[i].name);
			}
		}else{
			layer.msg('没有选择任何部门！请选择部门后再点击“确定”按钮。',{icon:2})
			return false;
		}
		
		 if(type=='KBMS'){//  文档库目录权限设置
				var ids = umap.keySet();
				ids=$(ids).map(function (index,ele) {
					return  {"id":ele,"name":umap.get(ele),"type":"D"};
				});
				
			} 
		selUgroups(ids);
	}
</script>