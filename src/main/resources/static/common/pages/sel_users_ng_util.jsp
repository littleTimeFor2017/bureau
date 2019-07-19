<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<table class="table tab" id="course-table" style="word-break:break-all;">
   	<thead>
    	<tr>
      		<th width="50px"><input type="checkbox" name="checkbox62" value="" class="checkAll" style="margin-top:4px;"/></th>
      		<th width="20%">用户ID</th>
      		<th>姓名</th>
      		<th>部门</th>
      		<th>职务</th>
      		<th>职级</th>
    	</tr>
   	</thead>
   	<tbody>
   	<s:iterator value="userList" status="sts">
   		<tr id="tr_<s:property value="id"/>">
   			<td>
   				<input type="checkbox" id="ck_<s:property value="id"/>" name="check" value="<s:property value="id"/>" class="checkItem" style="margin-top:4px;"/>
   				<input type="hidden" id="name_<s:property value="id"/>" value="<s:property value="full_name"/> / <s:property value="username"/>" />
   				<input type="hidden" id="row_<s:property value="id"/>" value="<s:property value="#sts.index + 1" />"/>
   			</td>
   			<td><s:property value="username" /></td>
   			<td><s:property value="full_name" /></td>
   			<td><s:property value="userGroup.name" /></td>
   			<td><s:property value="userAttr.jobcode" /></td>
   			<td><s:property value="userAttr.supv_lvl_id" /></td>
   		</tr>
   	</s:iterator>
   	<s:if test="userList == null || userList.size == 0"><tr><td colspan="4">暂未找到匹配的学员</td></tr> </s:if>
   	</tbody>
</table>
<input type="hidden" name="pageSizeUs" id="pageSizeUs" value="<s:property value="user.pageSize"/>" />
<input type="hidden" name="curPageUs" id="curPageUs" value="<s:property value="user.curPage"/>" />
<input type="hidden" name="totPageUs" id="totPageUs" value="<s:property value="user.totPage"/>" />
<div class="pagination-main">
	<ul id="paginationUs" class="pagination"></ul>
	<%-- <span class="page-list"></span> --%>
</div>
<script type="text/javascript">
us_site_id = "<s:property value="user.site_id"/>";
us_user_group_id = "<s:property value="user.user_group_id"/>";
var funs={  
    Init:function(){  
        $.XCLTableList();  
    }  
};  
$(function(){  
    funs.Init();  
});  
</script>