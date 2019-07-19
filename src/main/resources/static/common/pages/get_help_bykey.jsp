<%@page import="cn.kindee.common.core.utils.HelpUtil"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String key = request.getParameter("key");
	String content = HelpUtil.getHelpValue(key);
	if(content!=null&&!"".equals(content)){
		response.sendRedirect(content);
	}
%>