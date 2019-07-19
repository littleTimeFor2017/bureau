<%@page import="cn.kindee.common.core.utils.QRCodeUtil"%>
<%@page import="java.io.OutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String content = request.getParameter("content");
response.setHeader("Pragma","No-cache");  
response.setHeader("Cache-Control","no-cache");  
response.setDateHeader("Expires", 0);
OutputStream os;
if(content!=null&&!"".equals(content)){
	os = response.getOutputStream();
	QRCodeUtil.encode(content, os);
	os.flush();
	os.close();
	out.clear(); 
	out = pageContext.pushBody();
}
%>