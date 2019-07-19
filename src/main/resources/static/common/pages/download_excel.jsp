<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.excel.DownloadUtil"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
String savePath = request.getParameter("savePath");
String fileName = request.getParameter("fileName");
savePath= URLDecoder.decode(savePath,"UTF-8");

DownloadUtil.downLoadEWP(response, savePath, fileName + ".xlsx","xls");
out.clear();  
out = pageContext.pushBody();
%>