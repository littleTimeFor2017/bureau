<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<table class="table tab" id="course-table" style="word-break:break-all;">
   	<thead>
    	<tr>
      		<th width="30px"><input type="checkbox" name="checkbox62" value="" class="checkAll" style="margin-top:4px;"/></th>
      		<th>用户ID</th>
      		<th>姓名</th>
      		<th>部门</th>
			<th>邮箱</th>
			<th>性别</th>
      	<%--	<th>职位</th>
      		<th>职级</th>--%>
    	</tr>
   	</thead>
   	<tbody>
   	<s:iterator value="userList" status="sts" var="u">
   		<tr id="tr_<s:property value="id"/>">
   			<td>
   				<input type="checkbox" id="ck_<s:property value="id"/>" name="check" value="<s:property value="id"/>" class="checkItem" style="margin-top:4px;"/>
   				<input type="hidden" id="name_<s:property value="id"/>" value="<s:property value="full_name"/> / <s:property value="username"/>" />
   				<input type="hidden" id="row_<s:property value="id"/>" value="<s:property value="#sts.index + 1" />"/>
   			</td>
   			<td><s:property value="username" /></td>
   			<td><s:property value="full_name" /></td>
   			<td><div class="hand" onMouseOver="$(this).tooltip('show')" data-toggle="tooltip" data-placement="top" title="<s:property value="site_name" />/<s:property value="full_org_name" />"><s:property value="userGroup.name" /></div></td>
			<td><s:property value="email"/></td>
			<td>
				<s:if test='userAttr.sex == "F"'>女</s:if>
				<s:elseif test='userAttr.sex == "M"'>男</s:elseif>
				<s:else>保密</s:else>
			</td>
   		<%--	<td><s:property value="userAttr.jobcode" /></td>
   			<td><s:property value="userAttr.supv_lvl_id" /></td>--%>
   		</tr>
   	</s:iterator>
   	<s:if test="userList == null || userList.size == 0"><tr><td colspan="6">暂未找到匹配的学员</td></tr> </s:if>
   	</tbody>
</table>
<input type="hidden" name="pageSizeUs" id="pageSizeUs" value="<s:property value="user.pageSize"/>" />
<input type="hidden" name="curPageUs" id="curPageUs" value="<s:property value="user.curPage"/>" />
<input type="hidden" name="totPageUs" id="totPageUs" value="<s:property value="user.totPage"/>" />
<input type="hidden" name="totCount" id="totCount" value="<s:property value="user.totCount"/>" />
<div class="pagination-main" id="pagination_main">
	<ul id="paginationUs" class="pagination"></ul>
	<span class="page-list"></span>
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