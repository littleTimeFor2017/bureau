<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.excel.DownloadUtil"
    pageEncoding="UTF-8"%>
<%
String savePath = request.getParameter("savePath");
String fileName = request.getParameter("fileName");

DownloadUtil.downLoadEWP(response, savePath, fileName,"");
out.clear();  
out = pageContext.pushBody();
%>