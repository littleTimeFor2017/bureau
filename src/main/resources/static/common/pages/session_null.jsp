<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.json.Json,cn.kindee.common.core.json.JsonUtils"
    pageEncoding="UTF-8"%>
<%
Json json = new Json();
json.setSuccess(false);
json.setMsg("会话超时!");
json.setMore("utknull");
out.print(JsonUtils.toJsonString(json));
%>