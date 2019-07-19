<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 查询条件 -->
<form id="message-search-form" class="form-inline well well-sm well-cln sel_frm" action="" method="POST">
	<!-- <select id="keyTypeUs" name="keyTypeUs" class="form-control ipt-mgn">
		<option value="">关键词类型</option>
		<option value="username">用户ID</option>
		<option value="full_name">姓名</option>
		<option value="email">邮件地址</option>
	</select> -->
	<input type="text" id="keywordUs" class="form-control ipt-mgn" name="keywordUs" value="" placeholder="用户ID/姓名">
	<!-- <input type="text" id="keywordEmail" class="form-control ipt-mgn" name="keywordEmail" value="" placeholder="邮件地址"> -->
	<!-- <input type="text" id="keywordUsJob" class="form-control ipt-mgn" name="keywordUsJob" value="" placeholder="职位">
	<input type="text" id="keywordUsSupvLvl" class="form-control ipt-mgn" name="keywordUsSupvLvl" value="" placeholder="职级">
	 -->
	<input type="button" class="btn btn-primary ipt-mgn" onclick="loadSelUsers(1);" value='搜索' />
	<a class="btn btn-link" href="javascript:clearnSearch();" >重置搜索条件</a>
</form>