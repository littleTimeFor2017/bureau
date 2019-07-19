<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<table class="table tab" id="course-table" style="word-break:break-all;">
   	<thead>
    	<tr>
      		<th width="30px"><input type="checkbox" name="checkbox62" value="" class="checkAll" style="margin-top:4px;"/></th>
      		<th>名称</th>
      		<th>类型</th>
      		<th>描述</th>
      		<th>最后更新</th>
      		<th>归属单位</th>
    	</tr>
   	</thead>
   	<tbody>
   	<s:iterator value="lugroupList" status="sts" var="u">
   		<tr id="tr_<s:property value="id"/>">
   			<td>
   				<input type="checkbox" id="ck_<s:property value="id"/>" name="check" value="<s:property value="id"/>" class="checkItem" style="margin-top:4px;"/>
   				<input type="hidden" id="name_<s:property value="id"/>" value="<s:property value="name"/>" />
   				<input type="hidden" id="row_<s:property value="id"/>" value="<s:property value="#sts.index + 1" />"/>
   			</td>
   			<td><s:property value="name" /></td>
			<td><s:if test='mtype=="F"'>固定</s:if><s:if test='mtype=="D"'>动态</s:if></td>			
   			<td><s:property value="description" /></td>
   			<td><s:property value="last_update_user" /><br><s:property value="last_update_date" /></td>   			
   			<td><s:property value="owner_name" /></td>
   		</tr>
   	</s:iterator>
   	<s:if test="lugroupList == null || lugroupList.size == 0"><tr><td colspan="6">暂未找到用户群组.</td></tr> </s:if>
   	</tbody>
</table>
<input type="hidden" name="pageSizeUs" id="pageSizeUs" value="<s:property value="lugroup.pageSize"/>" />
<input type="hidden" name="curPageUs" id="curPageUs" value="<s:property value="lugroup.curPage"/>" />
<input type="hidden" name="totPageUs" id="totPageUs" value="<s:property value="lugroup.totPage"/>" />
<input type="hidden" name="totCount" id="totCount" value="<s:property value="lugroup.totCount"/>" />
<div class="pagination-main" id="pagination_main">
	<ul id="paginationUs" class="pagination"></ul>
	<div style="clear: both;padding-top:5px;"><span class="page-list"></span></div>
</div>
<script type="text/javascript">
us_site_id = "<s:property value="lugroup.site_id"/>";
us_user_group_id = "<s:property value="lugroup.lug_id"/>";
var funs={  
    Init:function(){  
        $.XCLTableList();  
    }  
};  
$(function(){  
    funs.Init();  
});  
</script>